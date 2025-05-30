<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 资源中心 - 任务发布</title>
    <link href="${pageContext.request.contextPath}/static/Custom/css/toast.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<%--    引入本地jquery，toast.js/css--%>
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/Custom/js/toast.js"></script>

    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-bg: #343a40;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color);
        }

        .resource-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .resource-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .card-img-top {
            height: 160px;
            object-fit: cover;
        }

        .category-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(52, 58, 64, 0.8);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
        }

        .resource-tag {
            display: inline-block;
            background-color: #e9ecef;
            padding: 3px 8px;
            border-radius: 15px;
            font-size: 0.75rem;
            margin-right: 5px;
            margin-bottom: 5px;
            color: #495057;
        }

        .section-header {
            position: relative;
            margin-bottom: 30px;
            padding-bottom: 10px;
        }

        .section-header:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
        }

        .sidebar {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .sidebar-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark-bg);
        }

        .filter-group {
            margin-bottom: 25px;
        }

        .filter-title {
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: #495057;
        }

        .stats-card {
            background-color: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .stats-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .stats-label {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .breadcrumb {
            background-color: transparent;
            padding: 0;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding-left: 40px;
            border-radius: 20px;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 10px;
            color: #6c757d;
        }

        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .pagination .page-link {
            color: var(--primary-color);
        }

        /* 调整右侧卡片样式 */
        .col-lg-9 .card {
            padding: 30px; /* 增加内边距以扩大框的大小 */
        }

        .col-lg-9 .card .mb-3 {
            margin-bottom: 20px; /* 增加输入内容之间的间距 */
        }

        .col-lg-9 .card button[type="submit"] {
            float: right; /* 将发布资源按钮移到右侧 */
        }
        .task-form {
            background-color: white;
            border-radius: 10px;
            padding: 50px; /* 增加表单内边距 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
        }

    </style>
</head>

<body>
    <!-- 主要内容区 -->
    <div class="container py-4">
        <!-- 面包屑导航 -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">首页</a></li>
                <li class="breadcrumb-item"><a href="#">资源中心</a></li>
                <li class="breadcrumb-item active" aria-current="page">任务发布</li>
            </ol>
        </nav>
        <!--
             taskid;  //任务ID
           b userid;  //用户ID
           f taskname;    //任务名称
           f taskdescription;//任务描述
           b taskdate;//任务发布日期
             completiontime;//完成时间
           b taskstatus;  //任务状态    待完成/已完成/已取消
             subtasks;    //子任务列表，用逗号分隔
           f categoryid; //任务分类ID  1: '设备任务', 2: '工艺任务',3: '设计任务',4: '制造任务'
           b auditstatus; //审核状态    驳回/通过/待审
             orderids; //订单ID列表，用逗号分隔
           -->
        <div class="row">
            <!-- 右侧资源与任务发布页面 -->
            <div class="col-lg-9">
                <h4 class="section-header">任务发布</h4>
                <div class="task-form">
                    <div class="card-body">
                        <form id="taskPublishform" enctype="multipart/form-data">
                            <div class="row">
                                <!-- 任务名称 -->
                                <div class="col-md-6 mb-3">
                                    <label for="taskname" class="form-label">任务名称</label>
                                    <input type="text" class="form-control" name="taskname" id="taskname" placeholder="请明确填写任务具体名称">
                                </div>
                                <!-- 任务所属领域 -->
                                <div class="col-md-6 mb-3">
                                    <label for="categoryid" class="form-label">任务类别</label>
                                    <select class="form-select" name="categoryid" id="categoryid">
                                        <option selected value="0">请选择任务类别</option>
                                        <option value="1">设备任务</option>
                                        <option value="2">工艺任务</option>
                                        <option value="3">设计任务</option>
                                        <option value="4">制造任务</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="completiontime" class="form-label">预期完成时间</label>
                                    <input type="date" class="form-control" name="completiontime" id="completiontime">
                                </div>
                            </div>
                            <div class="row">
                                <!-- 任务详细描述 -->
                                <div class="col-md-12 mb-3">
                                    <label for="taskdescription" class="form-label">任务详细说明</label>
                                    <textarea class="form-control" name="taskdescription" id="taskdescription" rows="3" placeholder="请详细描述任务的内容、要求等"></textarea>
                                </div>

                            </div>
                            <!-- 相关资料附件 -->
                            <div class="mb-3">
                                <label for="relatedFiles" class="form-label">相关资料附件</label>
                                <input type="file" class="form-control" name="relatedFiles" id="relatedFiles">
                            </div>
                            <!-- 提交按钮 -->
                            <button type="submit" class="btn btn-primary">发布任务</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
<script>
<%--      <form id="taskPublishform">
            点击提交后，阻止默认事件，收集表单数据，发送ajax请求
            url = "/user/task/addTask"
--%>
        $("#taskPublishform").submit(function (event) {
            event.preventDefault(); // 阻止表单默认提交行为
            // 收集表单数据
            var formData = new FormData(this);

            // 去除资料附件数据
            formData.delete("relatedFiles");

            // 发送ajax请求
            $.ajax({
                url: "${pageContext.request.contextPath}/user/task/addTask",
                type: "POST",
                data: formData,
                processData: false,  // 禁止jQuery处理数据
                contentType: false,  // 让浏览器自动设置Content-Type
                success: function (response) {
                    // 处理成功响应
                    if (response.code === 200) {
                        showToast("发布成功",'success');
                    } else {
                        showToast("发布失败",'error');
                    }
                },
                error: function (xhr, status, error) {
                    // 处理错误响应
                    showToast('请求失败','error');
                }
            });
        });
</script>