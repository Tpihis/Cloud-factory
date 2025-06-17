from flask import Flask, request, jsonify
import mysql.connector
import numpy as np
from datetime import datetime

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False  # 关键配置：禁用 ASCII 转义

# 数据库配置，请替换为你自己的数据库信息
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'root',
    'database': 'springmvc'
}

def fetch_resources():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    query = """
    SELECT resourceid, resourcename, quantity, resourceprice, resourcedate 
    FROM resource 
    WHERE auditstatus = 1 AND resourcestatus = 2 AND quantity > 0
    """
    cursor.execute(query)
    resources = cursor.fetchall()

    cursor.close()
    conn.close()

    if not resources:
        return []

    now = datetime.now()
    for res in resources:
        try:
            res_datetime = datetime.strptime(res['resourcedate'], '%Y-%m-%d %H:%M:%S')
        except ValueError:
            res_datetime = now
        delta_days = (now - res_datetime).days
        res['age_days'] = delta_days

    valid_ages = [res['age_days'] for res in resources if res['age_days'] <= 365]
    if valid_ages:
        min_age = min(valid_ages)
        max_age = max(valid_ages)
        for res in resources:
            age = res['age_days']
            if age > 365*2:
                res['date_weight'] = 0.2
            else:
                # 使用反比例函数
                k = 0.02
                normalized = 1 - 1 / (1 + k * age)
                res['date_weight'] = 0.2 + 0.8 * normalized
    return resources

def calculate_fitness(particle, resources):
    total_score = 0
    total_selected = 0
    for i in range(len(resources)):
        if particle[i] == 1:
            res = resources[i]
            need_count = res.get('required_count', 1)  # 默认需要1个
            has_count = res['quantity']

            if has_count >= need_count:
                total_selected += 1
                # score = (
                #     res['quantity'] * 0.6 +
                #     (1 / res['resourceprice']) * 0.3 +
                #     res['date_weight'] * 0.1
                # )
                score = (
                        np.log(res['quantity'] + 1) * 0.1 +  # 对数变换防止大数量主导
                        (1 / np.sqrt(res['resourceprice'])) * 0.7 +  # 平方根缓和价格影响
                        res['age_days'] * 0.2
                )
                total_score += score
            else:
                # 如果库存不足，不加分
                continue
    penalty = total_selected * 0.3  # 可调整系数，例如 0.3
    return total_score-penalty

def run_pso(resources):
    NUM_PARTICLES = 50
    MAX_ITERATIONS = 50
    W = 0.5
    C1 = 1.5
    C2 = 1.5

    DIMENSION = len(resources)
    particles = np.random.randint(2, size=(NUM_PARTICLES, DIMENSION))
    velocities = np.random.uniform(-1, 1, (NUM_PARTICLES, DIMENSION))

    pbest_positions = particles.copy()
    pbest_scores = np.array([float('-inf')] * NUM_PARTICLES)
    gbest_position = np.zeros(DIMENSION)
    gbest_score = float('-inf')

    for iter_num in range(MAX_ITERATIONS):
        for i in range(NUM_PARTICLES):
            current_particle = particles[i]
            fitness = calculate_fitness(current_particle, resources)

            if fitness > pbest_scores[i]:
                pbest_scores[i] = fitness
                pbest_positions[i] = current_particle.copy()

            if fitness > gbest_score:
                gbest_score = fitness
                gbest_position = current_particle.copy()

        for i in range(NUM_PARTICLES):
            r1, r2 = np.random.rand(DIMENSION), np.random.rand(DIMENSION)
            velocities[i] = (
                W * velocities[i] +
                C1 * r1 * (pbest_positions[i] - particles[i]) +
                C2 * r2 * (gbest_position - particles[i])
            )

            probabilities = 1 / (1 + np.exp(-velocities[i]))
            particles[i] = (probabilities > np.random.rand(DIMENSION)).astype(int)

    best_resources = [resources[i] for i in range(DIMENSION) if gbest_position[i] == 1]
    return best_resources


@app.route('/recommend_pso', methods=['POST'])
def recommend_pso():
    # 接收来自Java的请求数据
    data = request.get_json()
    requested_resources = data.get("resources", {})
    # 获取当前所有可用资源
    resources = fetch_resources()
    # # 筛选匹配名称的资源
    # filtered_resources = []
    # for res in resources:
    #     if res['resourcename'] in requested_resources:
    #         res['required_count'] = requested_resources[res['resourcename']]
    #         filtered_resources.append(res)

    # 筛选匹配名称的资源（模糊匹配）
    filtered_resources = []
    for res in resources:
        # 检查是否包含任何请求关键字
        match = any(keyword in res['resourcename']
                    for keyword in requested_resources.keys())

        if match:
            # 获取第一个匹配的关键字
            matched_keyword = next((k for k in requested_resources.keys()
                                    if k in res['resourcename']), None)
            if matched_keyword:
                res['required_count'] = requested_resources[matched_keyword]
                # if res['quantity'] >= res['required_count']:
                filtered_resources.append(res)

    # 如果没有匹配资源，直接返回空
    if not filtered_resources:
        return jsonify({"recommended_resources": []})

    # 运行 PSO 算法
    recommended = run_pso(filtered_resources)

    # 构造分类返回结构
    categorized_result = {}

    # 1. 先按请求的类别初始化空列表
    for category in requested_resources.keys():
        categorized_result[category] = []

    # 2. 将推荐结果按资源名分类
    for r in recommended:
        resourcename = r["resourcename"]
        # 检查资源名是否包含任何请求的关键字
        matched_category = next(
            (category for category in requested_resources.keys()
             if category in resourcename),
            None
        )

        if matched_category:
            categorized_result[matched_category].append({
                "resourceid": r["resourceid"],
                "resourcename": r["resourcename"],
                "quantity": r["quantity"],
                "resourceprice": float(r["resourceprice"]),
                "resourcedate": str(r["resourcedate"]),
                "date_weight": float(r["date_weight"])
            })

    # 3. 确保所有请求的类别都有返回（即使为空列表）
    response = {
        "recommended_resources": categorized_result,
    }

    # 构造响应数据
    clean_recommended = [
        {
            "resourceid": r["resourceid"],
            # 把resourcename转成中文字符,不会输出乱码
            "resourcename": r["resourcename"],
            "quantity": r["quantity"],
            "resourceprice": float(r["resourceprice"]),
            "resourcedate": str(r["resourcedate"]),
            "date_weight": float(r["date_weight"])
        }
        for r in recommended
    ]

    return jsonify(response)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)