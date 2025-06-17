# app.py
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
    'password': 'root',  # 替换为你的密码
    'database': 'springmvc'     # 替换为你的数据库名
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
            if age > 365:
                res['date_weight'] = 0.2
            else:
                # 使用反比例函数
                k = 0.02
                normalized = 1 - 1 / (1 + k * age)
                res['date_weight'] = 0.2 + 0.8 * normalized
    return resources


def get_fitness(pop, resources):
    fitness = []
    for individual in pop:
        total_score = 0
        for i in range(len(resources)):
            if individual[i] == 1:
                res = resources[i]
                need_count = res.get('required_count', 1)  # 默认需要1个
                has_count = res['quantity']

                if has_count >= need_count:  # 库存足够才计算得分
                    score = (
                        res['quantity'] * 0.6 +
                        (1 / res['resourceprice']) * 0.3 +
                        res['date_weight'] * 0.1
                    )
                    total_score += score
                else:
                    continue  # 不够的话不加分
        fitness.append(total_score)
    return np.array(fitness)


def select(pop, fitness):
    if np.allclose(fitness, fitness[0]):
        idx = np.random.choice(np.arange(len(pop)), size=len(pop), replace=True)
    else:
        probs = (fitness - fitness.min() + 1e-6) / (fitness.sum() - fitness.min() + 1e-6)
        probs /= probs.sum()
        idx = np.random.choice(np.arange(len(pop)), size=len(pop), replace=True, p=probs)
    return pop[idx]


def crossover(parent, population):
    if np.random.rand() < 0.8:
        idx = np.random.randint(0, len(population), size=1)
        cross_point = np.random.randint(1, len(parent) - 1)
        parent[cross_point:] = population[idx, cross_point:]
    return parent


def mutate(individual):
    for i in range(len(individual)):
        if np.random.rand() < 0.01:
            individual[i] = 1 - individual[i]
    return individual


def run_ga(resources):
    DNA_SIZE = len(resources)
    POP_SIZE = 100
    N_GENERATIONS = 50

    if DNA_SIZE == 0:
        return []

    pop = np.random.randint(0, 2, (POP_SIZE, DNA_SIZE))

    for generation in range(N_GENERATIONS):
        fitness = get_fitness(pop, resources)
        best_idx = np.argmax(fitness)
        print(f"Generation {generation} | Best Fitness: {fitness[best_idx]:.4f}")

        pop = select(pop, fitness)
        pop_copy = pop.copy()
        new_pop = []

        for parent in pop:
            child = crossover(parent, pop_copy)
            child = mutate(child)
            new_pop.append(child)

        pop = np.array(new_pop)

    best_individual = pop[np.argmax(get_fitness(pop, resources))]
    result = [resources[i] for i in range(DNA_SIZE) if best_individual[i] == 1]
    return result


@app.route('/recommend_GA', methods=['GET', 'POST'])
def recommend():
    # 如果是 POST 请求，则解析传入的 JSON
    if request.method == 'POST':
        data = request.get_json()
        requested_resources = data.get("resources", {})  # {"轮胎": 2, "车窗": 3}

        resources = fetch_resources()

        # # 过滤出用户请求的资源
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
                    filtered_resources.append(res)

        if not filtered_resources:
            return jsonify({"recommended_resources": []})
    else:
        # 如果是 GET 请求，就返回全部可用资源的推荐
        filtered_resources = fetch_resources()

    # 运行 GA 算法
    recommended = run_ga(filtered_resources)

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
    app.run(debug=True, host='0.0.0.0', port=5001)