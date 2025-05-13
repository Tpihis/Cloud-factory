<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/5/12
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 资源中心</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>
    <style>
        iframe {
            border: none;
        }

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
            /*-ms-overflow-style: none;*/
            /*scrollbar-width: none;*/
            /*overflow-y: scroll;*/
        }

        /*!* 隐藏滚动条 *!*/
        /*::-webkit-scrollbar {*/
        /*    display: none;*/
        /*}*/

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color);
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
            padding: 30px;
            /* 增加内边距以扩大框的大小 */
        }

        .col-lg-9 .card .mb-3 {
            margin-bottom: 20px;
            /* 增加输入内容之间的间距 */
        }

        .col-lg-9 .task-form button[type="submit"] {
            float: right;
            /* 将发布资源按钮移到右侧 */

        }
    </style>

</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-cloud-fill me-2"></i>云制造资源优化平台
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/home')">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#" onclick="loadPage('/user/resource/display')">资源中心</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/manufacturing/services')">制造服务</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/data/analysis')">数据分析</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/user/orderList')">我的订单</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <div class="dropdown me-3">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown"
                       data-bs-toggle="dropdown">
                        <img src="https://via.placeholder.com/40" alt="用户头像" class="rounded-circle me-2">
                        <span>张工程师</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#" onclick="loadPage('/user/personalCenter')">个人中心</a></li>
                        <li><a class="dropdown-item" href="#">我的收藏</a></li>
                        <li><a class="dropdown-item" href="#" onclick="loadPage('/user/chat')">消息中心</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">退出登录</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
<iframe id="iframe" src="/user/resource/display" width="100%" height="100%" style="overflow: hidden;scrollbar-width: none;"></iframe>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<script>
    function loadPage(url) {
        document.getElementById('iframe').src = url;
    }
</script>
</html>

