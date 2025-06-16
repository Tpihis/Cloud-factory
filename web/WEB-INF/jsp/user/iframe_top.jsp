<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <script src="${pageContext.request.contextPath}/static/Custom/js/toast.js"></script>
    <script src="${pageContext.request.contextPath}/static/Custom/js/modal.js"></script>
    <link href="${pageContext.request.contextPath}/static/Custom/css/toast.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>

    <style>
        iframe {
            border: none;
        }

         :root {
             --primary-color:   #3498db;
             --secondary-color: #2980b9;
             --accent-color: #e74c3c;
             --light-bg: #f8f9fa;
             --dark-bg: #343a40;
             --primary: #1a56db;
         }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            /*-ms-overflow-style: none;*/
            /*scrollbar-width: none;*/
            /*overflow-y: scroll;*/
        }
        /* 添加以下样式 */
        .dropdown:hover .dropdown-menu {
            display: block;
        }
        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color);
        }



        .resource-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
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
        .nav-item .active{
            color: black !important;

            /*加粗*/
            /*font-weight: bold !important;*/
        /*    字体黑体*/
            font-family: "黑体", sans-serif!important;
        }
        header {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .auth-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-outline {
            border: 2px solid var(--primary);
            color: var(--primary);
            background: transparent;
        }

        .btn-outline:hover {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            border: 2px solid var(--primary);
        }

        .btn-primary:hover {
            background-color: #1646b6;
            border-color: #1646b6;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }
        .userImage {
            width: 50px;
            height: 50px;
        }
    </style>

</head>
<body>
<!-- 导航栏 -->
<header>
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
                    <a class="nav-link active" href="#" onclick="loadPage('/home',this)">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link " href="#" onclick="loadPage('/user/resource/display',this)">资源中心</a>
                </li>
                <%--<li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/manufacturing/services',this)">制造服务</a>
                </li>--%>
                <%--<li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/data/analysis',this)">数据分析</a>
                </li>--%>
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/user/requestList',this)">请求列表</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/user/orderList',this)">我的订单</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="loadPage('/user/task/matchResources',this)">分配资源</a>
                </li>
            </ul>


            <div class="d-flex align-items-center">
                <div class="auth-buttons" id="authButtons">
                    <a href="/auth/loginPage" class="btn btn-outline">登录</a>
                    <a href="/auth/loginPage" class="btn btn-primary">免费注册</a>
                </div>
                <div class="dropdown me-3" id="userDropdownContainer">
                    <a href="#" class="d-flex align-items-center
                     text-decoration-none dropdown-toggle" id="userDropdown">
<%--                       data-bs-toggle="dropdown">--%>
                        <img src="/system/userImage" alt="用户头像"  class="userImage rounded-circle me-2">
                        <span id="username"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#" onclick="loadPage('/user/personalCenter',this)">个人中心</a></li>
                        <li><a class="dropdown-item" href="#">我的收藏</a></li>
                        <li><a class="dropdown-item" href="#" onclick="loadPage('/user/chat',this)">消息中心</a></li>
                        <li id="admin"> </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">退出登录</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
</header>
<iframe id="iframe" src="/home" width="100%" height="100%" style="overflow: hidden;scrollbar-width: none;"></iframe>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<script>
    function loadPage(url, activeElement) {
        //如果当前未登录,直接将父页面转向登录页面loginPage
        /*if (document.getElementById('authButtons').style.display === 'block' ) {
                window.location.href = '/auth/loginPage';
        }else{*/
            setActive(activeElement);
            document.getElementById('iframe').src = url;
        /*}*/


    }
    //设置当前活动菜单项
    function setActive(element) {
        // 移除所有导航链接的active类
        document.querySelectorAll('.nav-link,.dropdown-item').forEach(link => {
            link.classList.remove('active');
        });
        // 为当前点击的链接添加active类
        element.classList.add('active');
    }

//  发送请求到后端获取当前用户的角色
    $.ajax({
        url: "${pageContext.request.contextPath}/auth/getCurrentUser",
        type: "GET",
        success: function (response) {
            if (response.code === 0) {
                // 已登录，显示用户下拉菜单
                document.getElementById('authButtons').style.display = 'none';
                document.getElementById('userDropdownContainer').style.display = 'block';
                document.getElementById('username').innerText = response.obj.username;
                // 如果是管理员，添加管理员中心链接
                if (response.obj.role === 1) {
                    document.getElementById('admin').innerHTML = '<a class="dropdown-item" href="/admin/index">管理员中心</a>';
                }
            } else {
                // 未登录，显示登录/注册按钮
                document.getElementById('authButtons').style.display = 'block';
                document.getElementById('userDropdownContainer').style.display = 'none';
            }
        },
        error: function() {
            // 发生错误时默认显示登录/注册按钮
            document.getElementById('authButtons').style.display = 'block';
            document.getElementById('userDropdownContainer').style.display = 'none';
        }
    })
    //浏览器刷新时只刷新子页面,而不刷新父页面
    // 监听浏览器刷新事件
    // window.addEventListener('beforeunload', function (event) {
    //     // 阻止浏览器刷新
    //     event.preventDefault();
    //     // 刷新当前页面
    //     window.location.reload();
    // });
</script>
</html>

