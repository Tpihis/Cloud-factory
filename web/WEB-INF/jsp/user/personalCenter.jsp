<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 个人中心</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/Custom/js/toast.js"></script>
    <link href="${pageContext.request.contextPath}/static/Custom/css/toast.css" rel="stylesheet">



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
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .sidebar-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark-bg);
        }

        .main-content {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #ddd;
            margin-right: 20px;
            overflow: hidden;
            position: relative;
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-edit {
            position: absolute;
            bottom: 0;
            width: 100%;
            background: rgba(0,0,0,0.5);
            color: white;
            text-align: center;
            padding: 5px;
            cursor: pointer;
            display: none;
        }

        .avatar:hover .avatar-edit {
            display: block;
        }

        .user-info h2 {
            margin: 0;
            color: #333;
        }

        .user-info p {
            margin: 5px 0;
            color: #666;
        }

        .tabs {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
        }

        .tab.active {
            border-bottom-color: var(--primary-color);
            color: var(--primary-color);
            font-weight: bold;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-item {
            margin-bottom: 15px;
        }

        .info-label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .info-value {
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 4px;
            border: 1px solid #ddd;
            min-height: 20px;
        }

        .info-input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn-edit {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-save {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-cancel {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        .edit-buttons {
            margin-top: 10px;
            display: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        .table-action-btn {
            padding: 6px 12px;
            margin-right: 5px;
            cursor: pointer;
        }

        .breadcrumb {
            background-color: transparent;
            padding: 0;
            margin-bottom: 20px;
        }

        .status-available {
            color: #28a745;
        }

        .status-busy {
            color: #dc3545;
        }

        .status-maintenance {
            color: #ffc107;
        }

        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
        }

        .btn-edit {
            background-color: #17a2b8;
            color: white;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        .status-select {
            padding: 5px;
            border-radius: 4px;
            border: 1px solid #ced4da;
        }
        .scrollable-container {
            max-height: 500px; /* 设置容器的最大高度，可根据实际需求调整 */
            overflow-y: auto; /* 当内容在垂直方向超出时，显示滚动条 */
            border: 1px solid #ccc; /* 可选，添加边框用于区分容器边界 */
        }
        table {
            width: 100%; /* 让表格宽度撑满容器 */
        }

        /* 订单状态徽章样式 */
        .badge {
            padding: 5px 10px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: normal;
        }

        .bg-warning {
            background-color: #ffc107 !important;
        }

        .bg-primary {
            background-color: #0d6efd !important;
        }

        .bg-secondary {
            background-color: #6c757d !important;
        }

        .bg-success {
            background-color: #198754 !important;
        }

        .bg-info {
            background-color: #0dcaf0 !important;
        }

        .text-dark {
            color: #212529 !important;
        }

        /* 操作按钮样式 */
        .btn-primary {
            background-color: #0d6efd;
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

<!-- 主要内容区 -->
<div class="container py-4">
    <!-- 面包屑导航 -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">首页</a></li>
            <li class="breadcrumb-item active" aria-current="page">个人中心</li>
        </ol>
    </nav>

    <!-- 左侧边栏（宽度调整为3，右侧主内容区调整为9） -->
    <div class="row">
        <div class="col-lg-3 mb-4">
            <!-- 左侧边栏内容保持不变 -->
            <div class="sidebar">
                <!-- 用户信息摘要 -->
                <div class="d-flex align-items-center mb-4">
                    <img src="/images/default-avatar.png" alt="用户头像" class="rounded-circle me-3" style="width: 60px; height: 60px;">
                    <div>
                        <h6 class="mb-0">
                            <c:out value="${user.username}" default="未登录"/>
                        </h6>
                        <small class="text-muted">
                            <c:choose>
                                <c:when test="${user.role == 1}">管理员</c:when>
                                <c:otherwise>普通用户</c:otherwise>
                            </c:choose>
                        </small>
                    </div>
                </div>


                <!-- 个人中心菜单 -->
                <div class="sidebar-title">个人中心</div>
                <div class="list-group">
                    <a href="#basic" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center active" onclick="switchTab('basic')">
                        基本信息
                        <i class="bi bi-person-fill"></i>
                    </a>
                    <a href="#resources" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="switchTab('resources')">
                        我的资源
                        <i class="bi bi-collection-fill"></i>
                    </a>
                    <a href="#orders" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="switchTab('orders')">
                        我的订单
                        <i class="bi bi-receipt"></i>
                    </a>
                    <a href="#messages" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="switchTab('messages')">
                        消息通知
                        <i class="bi bi-bell-fill"></i>
                    </a>
                    <a href="#settings" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="switchTab('settings')">
                        账户设置
                        <i class="bi bi-gear-fill"></i>
                    </a>
                    <c:if test="${user.role == 1}">
                        <a href="#admin" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="switchTab('admin')">
                            管理员面板
                            <i class="bi bi-shield-fill"></i>
                        </a>
                    </c:if>
                </div>

                <!-- 统计信息 -->
                <div class="sidebar-title mt-4">账户统计</div>
                <div class="card mb-2">
                    <div class="card-body py-2">
                        <div class="d-flex justify-content-between align-items-center">
                            <span>资源数量</span>
                            <span class="badge bg-primary rounded-pill">0</span>
                        </div>
                    </div>
                </div>
                <div class="card mb-2">
                    <div class="card-body py-2">
                        <div class="d-flex justify-content-between align-items-center">
                            <span>订单数量</span>
                            <span class="badge bg-success rounded-pill">0</span>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body py-2">
                        <div class="d-flex justify-content-between align-items-center">
                            <span>未读消息</span>
                            <span class="badge bg-danger rounded-pill">0</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 右侧主内容区（个人信息框在此区域内） -->
        <div class="col-lg-9">
            <div class="main-content">
                <!-- 个人信息框调整到右侧主内容区顶部 -->
                <div class="profile-header">
                    <div class="avatar">
                        <img src="/images/default-avatar.png" alt="用户头像" id="avatarImage">
                        <div class="avatar-edit" onclick="openAvatarUpload()">更换头像</div>
                    </div>
                    <div class="user-info">
                        <h2 id="usernameDisplay">
                            用户名：<span id="usernameValue">加载中...</span>
                        </h2>
                        <p>
                            注册时间：<span id="registerTimeValue">加载中...</span>
                        </p>
                        <p>
                            状态：<span id="statusValue">加载中...</span>
                        </p>
                    </div>
                </div>

                <div id="basic" class="tab-content active">
                    <h4 class="section-header">基本信息</h4>
                    <div class="info-grid">
                        <!-- 第一列 -->
                        <div class="info-column">
                            <div class="info-item">
                                <div class="info-label">用户名</div>
                                <div class="info-value" id="usernameField">加载中...</div>
                                <input type="text" class="info-input" id="usernameInput" style="display: none;">
                            </div>
                            <div class="info-item">
                                <div class="info-label">手机号码</div>
                                <div class="info-value" id="phoneField">加载中...</div>
                                <input type="tel" class="info-input" id="phoneInput" style="display: none;">
                            </div>
                            <div class="info-item">
                                <div class="info-label">电子邮箱</div>
                                <div class="info-value" id="emailField">加载中...</div>
                                <input type="email" class="info-input" id="emailInput" style="display: none;">
                            </div>
                        </div>

                        <!-- 第二列 -->
                        <div class="info-column">
                            <div class="info-item">
                                <div class="info-label">性别</div>
                                <div class="info-value" id="genderField">加载中...</div>
                                <select class="info-input" id="genderInput" style="display: none;">
                                    <option value="1">男</option>
                                    <option value="2">女</option>
                                    <option value="3">保密</option>
                                </select>
                            </div>
                            <div class="info-item">
                                <div class="info-label">年龄</div>
                                <div class="info-value" id="ageField">加载中...</div>
                                <input type="number" class="info-input" id="ageInput" style="display: none;">
                            </div>
                            <div class="info-item">
                                <div class="info-label">地址</div>
                                <div class="info-value" id="addressField">加载中...</div>
                                <input type="text" class="info-input" id="addressInput" style="display: none;">
                            </div>
                        </div>
                    </div>

                    <!-- 注册时间和账户类型 -->
                    <div class="info-item">
                        <div class="info-label no_Edit">注册时间</div>
                        <div class="info-value" id="registerTimeField">加载中...</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label no_Edit">账户类型</div>
                        <div class="info-value" id="roleField">加载中...</div>
                    </div>

                    <button class="btn-edit" id="editProfileBtn" onclick="enableEdit()">编辑资料</button>
                    <div class="edit-buttons" id="editButtons">
                        <button class="btn-save" onclick="saveProfile()">保存</button>
                        <button class="btn-cancel" onclick="cancelEdit()">取消</button>
                    </div>
                </div>

                <!-- 我的资源标签页 -->
                <div id="resources" class="tab-content">
                    <h4 class="section-header">我的资源管理</h4>
                    <!-- 新增一个容器div，用于包裹表格，并添加样式类scrollable-container -->
                    <div class="scrollable-container">
                        <!-- 资源状态管理表格 -->
                        <table>
                            <thead>
                            <tr>
                                <th>资源名称</th>
                                <th>资源类型</th>
                                <th>数量</th>
                                <th>价格</th>
                                <th>状态</th>
                                <th>审核状态</th>
                                <th>发布日期</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="resourceTableBody">
                            <c:forEach items="${resources}" var="resource">
                                <tr>
                                    <td>${resource.resourcename}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${resource.categoryid == 1}">设备资源</c:when>
                                            <c:when test="${resource.categoryid == 2}">工艺知识</c:when>
                                            <c:when test="${resource.categoryid == 3}">设计模型</c:when>
                                            <c:when test="${resource.categoryid == 4}">制造服务</c:when>
                                            <c:otherwise>未知类型</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${resource.quantity}</td>
                                    <td>${resource.resourceprice}</td>
                                    <td>
                        <span class="status-${resource.resourcestatus}">
                            <c:choose>
                                <c:when test="${resource.resourcestatus == 1}">繁忙</c:when>
                                <c:when test="${resource.resourcestatus == 2}">空闲</c:when>
                                <c:when test="${resource.resourcestatus == 3}">损坏</c:when>
                                <c:otherwise>未知状态</c:otherwise>
                            </c:choose>
                        </span>
                                    </td>
                                    <td>${resource.auditstatus}</td>
                                    <td>${resource.resourcedate}</td>
                                    <td>
                                        <button class="action-btn btn-view" onclick="viewResource('${resource.resourceid}')">
                                            <i class="bi bi-eye"></i> 详情
                                        </button>
                                        <button class="action-btn btn-delete" onclick="deleteResource('${resource.resourceid}')">
                                            <i class="bi bi-trash"></i> 删除
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- 资源管理功能按钮 -->
                    <div class="mt-4">
                        <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/user/resource/publish'">发布新资源</button>
                    </div>
                </div>

                <div id="orders" class="tab-content">
                    <h4 class="section-header">我的订单</h4>
                    <div class="scrollable-container">
                        <table>
                            <thead>
                            <tr>
                                <th>订单编号</th>
                                <th>任务ID</th>
                                <th>资源ID</th>
                                <th>总价</th>
                                <th>数量</th>
                                <th>状态</th>
                                <th>下单时间</th>
                                <th>完成时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="orderTableBody">
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>${order.orderid}</td>
                                    <td>${order.taskid}</td>
                                    <td>
                                        <c:forEach items="${fn:split(order.resourceids, ',')}" var="resourceId" varStatus="status">
                                            ${resourceId}<c:if test="${not status.last}">, </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${order.totalprice}</td>
                                    <td>${order.quantity}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.orderstatus == '待支付'}">
                                                <span class="badge bg-warning text-dark">${order.orderstatus}</span>
                                            </c:when>
                                            <c:when test="${order.orderstatus == '已支付'}">
                                                <span class="badge bg-primary">${order.orderstatus}</span>
                                            </c:when>
                                            <c:when test="${order.orderstatus == '已取消'}">
                                                <span class="badge bg-secondary">${order.orderstatus}</span>
                                            </c:when>
                                            <c:when test="${order.orderstatus == '已完成'}">
                                                <span class="badge bg-success">${order.orderstatus}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-info">${order.orderstatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${order.ordertime}</td>
                                    <td>${empty order.completiontime ? '未完成' : order.completiontime}</td>
                                    <td>
                                        <button class="action-btn btn-edit" onclick="viewOrderDetails(${order.orderid})">详情</button>
                                        <c:if test="${order.orderstatus == '待支付'}">
                                            <button class="action-btn btn-primary" onclick="payOrder(${order.orderid})">支付</button>
                                            <button class="action-btn btn-danger" onclick="cancelOrder(${order.orderid})">取消</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="9" class="text-center">正在加载订单数据...</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="messages" class="tab-content">
                    <h4 class="section-header">消息通知</h4>
                    <div class="alert alert-info">暂无未读消息</div>
                </div>

                <div id="settings" class="tab-content">
                    <h4 class="section-header">账户安全</h4>
                    <div class="info-item">
                        <div class="info-label">修改密码</div>
                        <input type="password" id="newPassword" placeholder="新密码" class="form-control mb-2">
                        <input type="password" id="confirmPassword" placeholder="确认密码" class="form-control">
                        <button class="btn-save mt-3" onclick="changePassword()">确认修改</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--script里面不可以用el，body里面可以，js里面要用字符串拼接的形式！！！！！！！！！！--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 修改：简化JavaScript逻辑，直接从DOM获取值
    document.addEventListener('DOMContentLoaded', function() {
        // 移除冗余的强制设置逻辑，直接依赖EL表达式渲染
        console.log("页面渲染的用户信息:", {
            username: document.getElementById('usernameValue').textContent,
            email: document.getElementById('emailValue').textContent,
            phone: document.getElementById('phoneValue').textContent
        });
    });

    // 切换标签页
    function switchTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
        });
        document.getElementById(tabId).classList.add('active');

        // 更新侧边栏活动项
        document.querySelectorAll('.list-group-item').forEach(item => {
            item.classList.remove('active');
        });
        document.querySelector('.list-group-item[href="#'+tabId+'"]').classList.add('active');
    }

    // 启用编辑模式
    function enableEdit() {
        // 隐藏所有显示值，显示输入框
        document.querySelectorAll('.info-value').forEach(el => {
            el.style.display = 'none';
        });
        document.querySelectorAll('.no_Edit').forEach(el => {
            el.style.display = 'none';
        });

        document.querySelectorAll('.info-input, select.info-input, textarea.info-input').forEach(el => {
            el.style.display = 'block';
        });

        // 隐藏编辑按钮，显示保存取消按钮
        document.getElementById('editProfileBtn').style.display = 'none';
        document.getElementById('editButtons').style.display = 'block';
    }

    // 取消编辑
    function cancelEdit() {
        // 恢复所有显示值，隐藏输入框
        document.querySelectorAll('.info-value').forEach(el => {
            el.style.display = 'block';
        });
        document.querySelectorAll('.no_Edit').forEach(el => {
            el.style.display = 'block';
        });
        document.querySelectorAll('.info-input, select.info-input, textarea.info-input').forEach(el => {
            el.style.display = 'none';
        });

        // 恢复按钮状态
        document.getElementById('editProfileBtn').style.display = 'inline-block';
        document.getElementById('editButtons').style.display = 'none';
    }

    // 保存资料
    function saveProfile() {
        const profileData = {
            username: document.getElementById('usernameInput').value,
            phone: document.getElementById('phoneInput').value,
            email: document.getElementById('emailInput').value,
            gender: document.getElementById('genderInput').value,
            age: document.getElementById('ageInput').value,
            address: document.getElementById('addressInput').value
        };

        // 简单验证必填字段
        if(!profileData.username || !profileData.phone || !profileData.email) {
            alert('请填写完整必填信息(用户名、手机号、邮箱)');
            return;
        }

        // AJAX请求保存数据
        fetch('${pageContext.request.contextPath}/user/updateProfile', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(profileData)
        })
            .then(response => response.json())
            .then(data => {
                if(data.code === 0) {
                    // 更新显示值
                    document.getElementById('usernameField').textContent = profileData.username;
                    document.getElementById('phoneField').textContent = profileData.phone;
                    document.getElementById('emailField').textContent = profileData.email;
                    document.getElementById('ageField').textContent = profileData.age;
                    document.getElementById('addressField').textContent = profileData.address;

                    // 更新性别显示
                    let genderText = '保密';
                    if(profileData.gender == 1) genderText = '男';
                    else if(profileData.gender == 2) genderText = '女';
                    document.getElementById('genderField').textContent = genderText;

                    // 更新用户名显示
                    document.getElementById('usernameValue').textContent = profileData.username;

                    // 退出编辑模式
                    cancelEdit();

                    showToast(data.msg,'success');
                } else {
                    alert(data.msg);
                }
            });
    }

    // 修改密码
    function changePassword() {
        const currentPassword = document.getElementById('currentPassword').value;
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if(newPassword !== confirmPassword) {
            alert('两次输入的新密码不一致');
            return;
        }

        if(newPassword.length < 6) {
            alert('密码长度不能少于6位');
            return;
        }

        fetch('/user/changePassword', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                currentPassword: currentPassword,
                newPassword: newPassword
            })
        })
            .then(response => response.json())
            .then(data => {
                if(data.code === 0) {
                    alert(data.msg);
                    document.getElementById('currentPassword').value = '';
                    document.getElementById('newPassword').value = '';
                    document.getElementById('confirmPassword').value = '';
                } else {
                    alert(data.msg);
                }
            });
    }

    // 在页面加载完成后获取用户信息
    document.addEventListener('DOMContentLoaded', function() {
        fetch('${pageContext.request.contextPath}/user/profileInfo')  // 后端API接口
            .then(response => response.json())
            .then(data => {
                if(data.code === 0) {

                    const user = data.obj;
                    console.log('获取到的用户信息:', user);
                    // 更新顶部用户信息
                    document.getElementById('usernameValue').textContent = user.username || '无';
                    document.getElementById('registerTimeValue').textContent = user.time || '未记录';

                    // 更新状态显示
                    const statusText = user.status === 0 ? '正常' : '封禁';
                    document.getElementById('statusValue').textContent = statusText;

                    // 更新基本信息区域
                    document.getElementById('usernameField').textContent = user.username || '无';
                    document.getElementById('phoneField').textContent = user.phone || '无';
                    document.getElementById('emailField').textContent = user.email || '无';

                    // 更新性别显示
                    let genderText = '保密';
                    if(user.gender == 1) genderText = '男';
                    else if(user.gender == 2) genderText = '女';
                    document.getElementById('genderField').textContent = genderText;

                    // 更新其他字段
                    document.getElementById('ageField').textContent = user.age || '无';
                    document.getElementById('addressField').textContent = user.address || '无';
                    document.getElementById('registerTimeField').textContent = user.time || '未记录';

                    // 更新账户类型
                    const roleText = user.role == 1 ? '管理员' : '普通用户';
                    document.getElementById('roleField').textContent = roleText;

                    // 更新输入框的值
                    document.getElementById('usernameInput').value = user.username || '';
                    document.getElementById('phoneInput').value = user.phone || '';
                    document.getElementById('emailInput').value = user.email || '';
                    document.getElementById('genderInput').value = user.gender || '3';
                    document.getElementById('ageInput').value = user.age || '';
                    document.getElementById('addressInput').value = user.address || '';

                    // 更新头像（如果有）
                    if(user.avatar) {
                        document.getElementById('avatarImage').src = user.avatar;
                    }
                } else {
                    console.error('获取用户信息失败:', data.message);
                }
            })
            .catch(error => {
                console.error('请求失败:', error);
                // 设置默认错误显示
                document.querySelectorAll('.info-value').forEach(el => {
                    el.textContent = '获取失败';
                });
            });
    });


    document.addEventListener('DOMContentLoaded', function() {
        console.log('页面加载完成，检查元素是否存在...');
        console.log('resourceTableBody:', document.getElementById('resourceTableBody'));
        console.log('testResourceBtn:', document.getElementById('testResourceBtn'));

        loadResources();
        /*document.getElementById('testResourceBtn')?.addEventListener('click', testResourceAPI);*/
    });

    function loadResources() {
        const tbody = document.getElementById('resourceTableBody');
        if (!tbody) {
            console.error('无法找到资源表格容器');
            return;
        }

        showLoading('resourceTableBody', '正在加载资源...');

        fetch('/user/resource/byUser')
            .then(response => {
                console.log('原始响应:', response);
                if (!response.ok) {
                    throw new Error(`HTTP错误! 状态码: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log('解析后的数据:', data);
                if (data.code === 0 || data.code === 200) { // 兼容两种响应码
                    const resources = data.obj || data.data; // 兼容不同字段名
                    if (resources && resources.length > 0) {
                        renderResources(resources);
                        updateResourceStats(resources.length);
                    } else {
                        showError('resourceTableBody', '暂无资源数据');
                    }
                } else {
                    throw new Error(data.msg || '未知错误');
                }
            })
            .catch(error => {
                console.error('资源加载错误详情:', error);
                showError('resourceTableBody', '加载失败: ' + error.message);
            });
    }

    function showLoading(elementId, message) {
        const element = document.getElementById(elementId);
        if(element) {
            element.innerHTML = '<tr><td colspan="8" class="text-center">'+message+'</td></tr>';
        }
    }

    function showError(elementId, message) {
        const element = document.getElementById(elementId);
        if(element) {
            element.innerHTML = '<tr><td colspan="8" class="text-center text-danger">'+message+'</td></tr>';
        }
    }

    function updateResourceStats(count) {
        const badge = document.querySelector('.badge.bg-primary');
        if(badge) {
            badge.textContent = count;
        }
    }

/*    function testResourceAPI() {
        const resultElement = document.getElementById('resourceData');
        resultElement.textContent = '请求中...';

        fetch('/user/resource/byUser')
            .then(response => {
                if(!response.ok) throw new Error('HTTP错误: ' + response.status);
                return response.json();
            })
            .then(data => {
                if(data.code === 0) {
                    resultElement.textContent = JSON.stringify(data.obj, null, 2);
                    alert(`测试成功，获取到${data.obj.length}条资源数据`);
                } else {
                    throw new Error(data.msg || '服务器返回错误');
                }
            })
            .catch(error => {
                resultElement.textContent = '错误: ' + error.message;
                alert('测试失败: ' + error.message);
            });
    }*/
    // 渲染资源表格
    function renderResources(resources) {
        console.log('接收到的资源数据:', resources); // 调试输出

        const tbody = document.getElementById('resourceTableBody');
        if (!tbody) {
            console.error('找不到resourceTableBody元素');
            return;
        }
        tbody.innerHTML = '';

        if (!resources || resources.length === 0) {
            tbody.innerHTML = '<tr><td colspan="8" class="text-center">暂无资源数据</td></tr>';
            return;
        }
        resources.forEach(resource => {
            const row = document.createElement('tr');

            // 资源名称
            const nameCell = document.createElement('td');
            nameCell.textContent = resource.resourcename;
            row.appendChild(nameCell);

            // 资源类型
            const typeCell = document.createElement('td');
            typeCell.textContent = getCategoryName(resource.categoryid);
            row.appendChild(typeCell);

            // 数量
            const quantityCell = document.createElement('td');
            quantityCell.textContent = resource.quantity;
            row.appendChild(quantityCell);

            // 价格
            const priceCell = document.createElement('td');
            priceCell.textContent = resource.resourceprice;
            row.appendChild(priceCell);

            // 状态
            const statusCell = document.createElement('td');
            const statusSpan = document.createElement('span');
            statusSpan.className = 'status-' + resource.resourcestatus;
            statusSpan.textContent = getStatusName(resource.resourcestatus);
            statusCell.appendChild(statusSpan);
            row.appendChild(statusCell);

            // 审核状态
            const auditCell = document.createElement('td');
            auditCell.textContent = resource.auditstatus;
            row.appendChild(auditCell);

            // 发布日期
            const dateCell = document.createElement('td');
            dateCell.textContent = resource.resourcedate;
            row.appendChild(dateCell);

            // 操作
            const actionCell = document.createElement('td');

            // 详情按钮
            const detailBtn = document.createElement('button');
            detailBtn.className = 'action-btn btn-view me-2';
            detailBtn.innerHTML = '<i class="bi bi-eye"></i> 详情';
            detailBtn.onclick = function() { viewResource(resource.resourceid); };
            actionCell.appendChild(detailBtn);

            // 删除按钮
            const deleteBtn = document.createElement('button');
            deleteBtn.className = 'action-btn btn-delete';
            deleteBtn.innerHTML = '<i class="bi bi-trash"></i> 删除';
            deleteBtn.onclick = function() { deleteResource(resource.resourceid); };
            actionCell.appendChild(deleteBtn);

            row.appendChild(actionCell);
            tbody.appendChild(row);
        });
    }

    // 获取资源类型名称
    function getCategoryName(categoryId) {
        const categories = {
            1: '设备资源',
            2: '工艺知识',
            3: '设计模型',
            4: '制造服务'
        };
        return categories[categoryId] || '未知类型';
    }

    // 获取资源状态名称
    function getStatusName(status) {
        const statuses = {
            1: '繁忙',
            2: '空闲',
            3: '损坏'
        };
        return statuses[status] || '未知状态';
    }

    // 删除资源
    function deleteResource(resourceId) {
        if(confirm('确定要删除此资源吗？')) {
            fetch('/user/resource/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    resourceId: resourceId
                })
            })
                .then(response => response.json())
                .then(data => {
                    if(data.code === 0) {
                        loadResources();
                        showToast('删除成功','success');
                    } else {
                        alert('删除失败: ' + data.msg);
                    }
                });
        }
    }

    // 查看资源详情
    function viewResource(resourceId) {
        window.location.href = '/user/resource/details?resourceId=' + resourceId;
    }

    // 加载订单数据 - 修改后
    function loadOrders() {
        const tbody = document.getElementById('orderTableBody');
        if (!tbody) return;

        showLoading('orderTableBody', '正在加载订单...');

        fetch('${pageContext.request.contextPath}/user/order/list', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': '${_csrf.token}'
            }
        })
            .then(response => {
                if (!response.ok) throw new Error(`HTTP错误! 状态码: ${response.status}`);
                return response.json();
            })
            .then(data => {
                if (data.code === 200) {
                    renderOrders(data.obj || []);
                    updateOrderStats((data.obj || []).length);
                } else {
                    throw new Error(data.msg || '获取订单列表失败');
                }
            })
            .catch(error => {
                showError('orderTableBody', '加载失败: ' + error.message);
            });
    }

    // 渲染订单表格
    function renderOrders(orders) {
        const tbody = document.getElementById('orderTableBody');
        tbody.innerHTML = '';

        if (orders.length === 0) {
            tbody.innerHTML = '<tr><td colspan="9" class="text-center">暂无订单数据</td></tr>';
            return;
        }

        orders.forEach(order => {
            const row = document.createElement('tr');

            // 订单编号
            row.appendChild(createTableCell(order.orderid || '无'));

            // 任务ID
            row.appendChild(createTableCell(order.taskid || '无'));

            // 资源ID
            row.appendChild(createTableCell(order.resourceids || '无'));

            // 总价
            row.appendChild(createTableCell(order.totalprice ? '¥' + order.totalprice.toFixed(2) : '无'));

            // 数量
            row.appendChild(createTableCell(order.quantity || '无'));

            // 状态
            const statusCell = document.createElement('td');
            const statusBadge = document.createElement('span');
            statusBadge.className = 'badge ' + getOrderStatusClass(order.orderstatus);
            statusBadge.textContent = order.orderstatus || '无状态';
            statusCell.appendChild(statusBadge);
            row.appendChild(statusCell);

            // 下单时间
            row.appendChild(createTableCell(order.ordertime || '无'));

            // 完成时间
            row.appendChild(createTableCell(order.completiontime || '无'));

            // 操作
            const actionCell = document.createElement('td');
            actionCell.className = 'text-nowrap'; // 防止按钮换行

            // 详情按钮
            const detailBtn = document.createElement('button');
            detailBtn.className = 'btn btn-sm btn-outline-primary me-2';
            detailBtn.innerHTML = '<i class="bi bi-eye"></i> 详情';
            detailBtn.onclick = () => viewOrderDetails(order.orderid);
            actionCell.appendChild(detailBtn);

            // 如果是待支付状态，显示支付和取消按钮
            if (order.orderstatus === '待支付') {
                const payBtn = document.createElement('button');
                payBtn.className = 'btn btn-sm btn-success me-2';
                payBtn.innerHTML = '<i class="bi bi-credit-card"></i> 支付';
                payBtn.onclick = () => payOrder(order.orderid);
                actionCell.appendChild(payBtn);

                const cancelBtn = document.createElement('button');
                cancelBtn.className = 'btn btn-sm btn-danger';
                cancelBtn.innerHTML = '<i class="bi bi-x-circle"></i> 取消';
                cancelBtn.onclick = () => cancelOrder(order.orderid);
                actionCell.appendChild(cancelBtn);
            }

            row.appendChild(actionCell);
            tbody.appendChild(row);
        });
    }

    // 创建表格单元格辅助函数
    function createTableCell(content) {
        const cell = document.createElement('td');
        cell.textContent = content;
        return cell;
    }

    // 获取订单状态对应的CSS类
    function getOrderStatusClass(status) {
        if (!status) return 'bg-secondary';
        switch (status.toLowerCase()) {
            case '待支付': return 'bg-warning text-dark';
            case '已支付': return 'bg-primary';
            case '已取消': return 'bg-secondary';
            case '已完成': return 'bg-success';
            default: return 'bg-info';
        }
    }

    // 查看订单详情
    function viewOrderDetails(orderId) {
        window.location.href = '${pageContext.request.contextPath}/user/order/detail?id=' + orderId;
    }

    // 支付订单函数 - 字符串拼接版
    function payOrder(orderId) {
        if (confirm('确定要支付此订单吗？')) {
            fetch('${pageContext.request.contextPath}/user/order/pay', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': '${_csrf.token}'
                },
                body: '{"orderId":' + orderId + '}'
            })
                .then(function(response) {
                    if (!response.ok) {
                        return response.text().then(function(text) {
                            try {
                                var json = JSON.parse(text);
                                throw new Error(json.msg || 'HTTP错误: ' + response.status);
                            } catch (e) {
                                throw new Error('服务器错误: ' + response.status + ' - 可能未授权或服务器内部错误');
                            }
                        });
                    }
                    return response.json();
                })
                .then(function(data) {
                    if (data.code === 200) {
                        loadOrders();
                        showToast('支付成功','success');
                    } else {
                        throw new Error(data.msg || '支付失败');
                    }
                })
                .catch(function(error) {
                    alert(error.message);
                    console.error('支付错误:', error);
                });
        }
    }

    // 取消订单函数 - 字符串拼接版
    function cancelOrder(orderId) {
        if (confirm('确定要取消此订单吗？')) {
            fetch('${pageContext.request.contextPath}/user/order/cancel', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': '${_csrf.token}'
                },
                body: '{"orderId":' + orderId + '}'
            })
                .then(function(response) {
                    if (!response.ok) {
                        return response.text().then(function(text) {
                            try {
                                var json = JSON.parse(text);
                                throw new Error(json.msg || 'HTTP错误: ' + response.status);
                            } catch (e) {
                                throw new Error('服务器错误: ' + response.status + ' - 可能未授权或服务器内部错误');
                            }
                        });
                    }
                    return response.json();
                })
                .then(function(data) {
                    if (data.code === 200) {
                        // alert(data.msg || '订单已取消');
                        loadOrders();
                        showToast('订单已取消','success');
                    } else {
                        throw new Error(data.msg || '取消失败');
                    }
                })
                .catch(function(error) {
                    alert(error.message);
                    console.error('取消错误:', error);
                });
        }
    }



    // 更新订单统计信息
    function updateOrderStats(count) {
        var badge = document.querySelector('.sidebar .badge.bg-success');
        if (badge) badge.textContent = count;
    }

    // 页面加载完成后初始化
    document.addEventListener('DOMContentLoaded', function() {
        // 如果当前是订单标签页，则加载订单数据
        if (window.location.hash === '#orders') loadOrders();

        // 监听订单标签页点击事件
        document.querySelector('a[href="#orders"]').addEventListener('click', loadOrders);
    });
</script>
</body>
</html>