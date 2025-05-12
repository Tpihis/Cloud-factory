<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">  
<head>  
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>云制造资源优化平台 - 个人中心</title>  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">  
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
    </style>  
</head>  
<body>  
<%--    <!-- 导航栏 -->  --%>
<%--    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">  --%>
<%--        <div class="container">  --%>
<%--            <a class="navbar-brand" href="#">  --%>
<%--                <i class="bi bi-cloud-fill me-2"></i>云制造资源优化平台  --%>
<%--            </a>  --%>
<%--            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">  --%>
<%--                <span class="navbar-toggler-icon"></span>  --%>
<%--            </button>  --%>
<%--            <div class="collapse navbar-collapse" id="navbarNav">  --%>
<%--                <ul class="navbar-nav me-auto">  --%>
<%--                    <li class="nav-item">  --%>
<%--                        <a class="nav-link" href="#">首页</a>  --%>
<%--                    </li>  --%>
<%--                    <li class="nav-item">  --%>
<%--                        <a class="nav-link" href="#">资源中心</a>  --%>
<%--                    </li>  --%>
<%--                    <li class="nav-item">  --%>
<%--                        <a class="nav-link" href="#">制造服务</a>  --%>
<%--                    </li>  --%>
<%--                    <li class="nav-item">  --%>
<%--                        <a class="nav-link" href="#">数据分析</a>  --%>
<%--                    </li>  --%>
<%--                    <li class="nav-item">  --%>
<%--                        <a class="nav-link active" href="#">个人中心</a>  --%>
<%--                    </li>  --%>
<%--                </ul>  --%>
<%--                <div class="d-flex align-items-center">  --%>
<%--                    <div class="dropdown me-3">  --%>
<%--                        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown">  --%>
<%--                            <img src="https://via.placeholder.com/40" alt="用户头像" class="rounded-circle me-2">  --%>
<%--                            <span>张三</span>  --%>
<%--                        </a>  --%>
<%--                        <ul class="dropdown-menu dropdown-menu-end">  --%>
<%--                            <li><a class="dropdown-item" href="#">个人中心</a></li>  --%>
<%--                            <li><a class="dropdown-item" href="#">我的收藏</a></li>  --%>
<%--                            <li><a class="dropdown-item" href="#">消息中心</a></li>  --%>
<%--                            <li><hr class="dropdown-divider"></li>  --%>
<%--                            <li><a class="dropdown-item" href="#">退出登录</a></li>  --%>
<%--                        </ul>  --%>
<%--                    </div>  --%>
<%--                </div>  --%>
<%--            </div>  --%>
<%--        </div>  --%>
<%--    </nav>  --%>

    <!-- 主要内容区 -->  
    <div class="container py-4">  
        <!-- 面包屑导航 -->  
        <nav aria-label="breadcrumb">  
            <ol class="breadcrumb">  
                <li class="breadcrumb-item"><a href="#">首页</a></li>  
                <li class="breadcrumb-item active" aria-current="page">个人中心</li>  
            </ol>  
        </nav>  
        
        <div class="row">  
            <!-- 左侧边栏 -->  
            <div class="col-lg-3 mb-4">  
                <div class="sidebar">  
                    <!-- 用户信息摘要 -->  
                    <div class="d-flex align-items-center mb-4">  
                        <img src="${user.avatarUrl}" alt="用户头像" class="rounded-circle me-3" style="width: 60px; height: 60px;">  
                        <div>  
                            <h6 class="mb-0">张三</h6>  
                         
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
                    </div>  
                    
                      <!-- 统计信息 -->  
                    <div class="sidebar-title mt-4">账户统计</div>  
                    <div class="card mb-2">  
                        <div class="card-body py-2">  
                            <div class="d-flex justify-content-between align-items-center">  
                                <span>资源数量</span>  
                                <span class="badge bg-primary rounded-pill">24</span>  
                            </div>  
                        </div>  
                    </div>  
                    <div class="card mb-2">  
                        <div class="card-body py-2">  
                            <div class="d-flex justify-content-between align-items-center">  
                                <span>订单数量</span>  
                                <span class="badge bg-success rounded-pill">15</span>  
                            </div>  
                        </div>  
                    </div>  
                    <div class="card">  
                        <div class="card-body py-2">  
                            <div class="d-flex justify-content-between align-items-center">  
                                <span>未读消息</span>  
                                <span class="badge bg-danger rounded-pill">3</span>  
                            </div>  
                        </div>  
                    </div>  
                </div>  
            </div>
            
            <!-- 右侧主内容区 -->
            <div class="col-lg-9">
                <div class="main-content">
                    <div class="profile-header">
                        <div class="avatar">
                            <img src="${user.avatarUrl}" alt="用户头像" id="avatarImage">
                            <div class="avatar-edit" onclick="openAvatarUpload()">更换头像</div>
                        </div>
                        <div class="user-info">
                            <h2 id="usernameDisplay">张三</h2>
                
                            <p>注册时间:2020年7月1日</p>
                        </div>
                    </div>

                    <div id="basic" class="tab-content active">
                        <h4 class="section-header">基本信息</h4>
                        <div class="info-grid">
                            <!-- 第一列 -->
                            <div class="info-column">
                                <div class="info-item">
                                    <div class="info-label">用户名</div>
                                    <div class="info-value" id="usernameValue">张三</div>
                                    <input type="text" class="info-input" id="usernameInput" value="张三" style="display: none;">
                                </div>
                                <div class="info-item">
                                    <div class="info-label">真实姓名</div>
                                    <div class="info-value" id="realnameValue">张三毛</div>
                                    <input type="text" class="info-input" id="realnameInput" value="张三毛}" style="display: none;">
                                </div>
                                <div class="info-item">
                                    <div class="info-label">电子邮箱</div>
                                    <div class="info-value" id="emailValue">123456@qq.com</div>
                                    <input type="email" class="info-input" id="emailInput" value="123456@qq.com" style="display: none;">
                                </div>
                                <div class="info-item">
                                    <div class="info-label">手机号码</div>
                                    <div class="info-value" id="phoneValue">123456789</div>
                                    <input type="tel" class="info-input" id="phoneInput" value="123456789" style="display: none;">
                                </div>
                                </div>
                            
                            <!-- 第二列 -->
                            <div class="info-column">
                                <div class="info-item">
                                    <div class="info-label">性别</div>
                                    <div class="info-value" id="genderValue">男</div>
                                    <select class="info-input" id="genderInput" style="display: none;">
                                        <option value="男" ${user.gender == '男' ? 'selected' : ''}>男</option>
                                        <option value="女" ${user.gender == '女' ? 'selected' : ''}>女</option>
                                        <option value="其他" ${!user.gender || user.gender == '其他' ? 'selected' : ''}>其他</option>
                                    </select>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">出生日期</div>
                                    <div class="info-value" id="birthdayValue">1998年8月1日</div>
                                    <input type="date" class="info-input" id="birthdayInput" value="1998年8月1日" style="display: none;">
                                </div>
                                <div class="info-item">
                                    <div class="info-label">所在地区</div>
                                    <div class="info-value" id="regionValue">安徽省合肥市巢湖市</div>
                                    <input type="text" class="info-input" id="regionInput" value="安徽省合肥市巢湖市" style="display: none;">
                                </div>
                               </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">个人简介</div>
                            <div class="info-value" id="bioValue" style="min-height: 80px;">技术能力突出</div>
                            <textarea class="info-input" id="bioInput" style="display: none; min-height: 80px;">技术能力突出</textarea>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">注册时间</div>
                            <div class="info-value">2020年7月1日</div>
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
                        
                        <!-- 资源状态管理表格 -->
                        <table>
                            <thead>
                            <tr>
                                <th>资源ID</th>
                                <th>资源名称</th>
                                <th>资源类型</th>
                                <th>规格</th>
                                <th>当前状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${resources}" var="resource">
                                <tr>
                                    <td>123</td>
                                    <td>大型模具设计软件</td>
                                    <td>设计软件</td>
                                    <td>支持复杂模具的三维设计、模具分析与优化功能</td>
                                    <td>
                                        <span class="status-${resource.status}">
                                           可用
                                        </span>
                                    </td>
                                    <td>
                                        <select class="status-select" id="status-${resource.id}">
                                            <option value="available" ${resource.status == 'available' ? 'selected' : ''}>可用</option>
                                            <option value="busy" ${resource.status == 'busy' ? 'selected' : ''}>忙碌</option>
                                            <option value="maintenance" ${resource.status == 'maintenance' ? 'selected' : ''}>维护中</option>
                                        </select>
                                        <button class="action-btn btn-edit" onclick="updateStatus('${resource.id}')">更新</button>
                                        <button class="action-btn btn-delete" onclick="deleteResource('${resource.id}')">删除</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        
                        <!-- 资源管理功能按钮 -->
                        <div class="mt-4">
                            <button class="btn btn-primary" onclick="addResource()">添加新资源</button>
                        </div>
                    </div>

                    <div id="orders" class="tab-content">
                        <!-- 原有内容 -->
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
            document.querySelector(`.list-group-item[href="#${tabId}"]`).classList.add('active');
        }

        // 启用编辑模式
        function enableEdit() {
            // 隐藏所有显示值，显示输入框
            document.querySelectorAll('.info-value').forEach(el => {
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
            document.querySelectorAll('.info-input, select.info-input, textarea.info-input').forEach(el => {
                el.style.display = 'none';
            });
            
            // 恢复按钮状态
            document.getElementById('editProfileBtn').style.display = 'inline-block';
            document.getElementById('editButtons').style.display = 'none';
            
            // 恢复原始值
            document.getElementById('usernameInput').value = document.getElementById('usernameValue').textContent;
            document.getElementById('realnameInput').value = document.getElementById('realnameValue').textContent;
            document.getElementById('emailInput').value = document.getElementById('emailValue').textContent;
            document.getElementById('phoneInput').value = document.getElementById('phoneValue').textContent;
            document.getElementById('titleInput').value = document.getElementById('titleValue').textContent;
            document.getElementById('genderInput').value = document.getElementById('genderValue').textContent;
            document.getElementById('birthdayInput').value = document.getElementById('birthdayValue').textContent;
            document.getElementById('regionInput').value = document.getElementById('regionValue').textContent;
            document.getElementById('companyInput').value = document.getElementById('companyValue').textContent;
            document.getElementById('departmentInput').value = document.getElementById('departmentValue').textContent;
            document.getElementById('bioInput').value = document.getElementById('bioValue').textContent;
        }

        // 保存资料
        function saveProfile() {
            const profileData = {
                username: document.getElementById('usernameInput').value,
                realName: document.getElementById('realnameInput').value,
                email: document.getElementById('emailInput').value,
                phone: document.getElementById('phoneInput').value,
                title: document.getElementById('titleInput').value,
                gender: document.getElementById('genderInput').value,
                birthday: document.getElementById('birthdayInput').value,
                region: document.getElementById('regionInput').value,
                company: document.getElementById('companyInput').value,
                department: document.getElementById('departmentInput').value,
                bio: document.getElementById('bioInput').value
            };
            
            // 简单验证必填字段
            if(!profileData.username || !profileData.email || !profileData.phone) {
                alert('请填写完整必填信息(用户名、邮箱、手机号)');
                return;
            }
            
            // AJAX请求保存数据
            fetch('/user/updateProfile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(profileData)
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    // 更新显示值
                    for(const [key, value] of Object.entries(profileData)) {
                        const valueElement = document.getElementById(`${key}Value`);
                        if(valueElement) {
                            valueElement.textContent = value || '未设置';
                        }
                    }
                    document.getElementById('usernameDisplay').textContent = profileData.username;
                    
                    // 退出编辑模式
                    cancelEdit();
                    alert('资料更新成功');
                } else {
                    alert('更新失败: ' + data.message);
                }
            });
        }

        // 更换头像
        function openAvatarUpload() {
            const input = document.createElement('input');
            input.type = 'file';
            input.accept = 'image/*';
            input.onchange = e => {
                const file = e.target.files[0];
                if(file) {
                    const formData = new FormData();
                    formData.append('avatar', file);
                    
                    fetch('/user/uploadAvatar', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if(data.success) {
                            document.getElementById('avatarImage').src = data.avatarUrl + '?t=' + new Date().getTime();
                            // 更新导航栏和侧边栏头像
                            document.querySelectorAll('.rounded-circle[alt="用户头像"]').forEach(img => {
                                img.src = data.avatarUrl + '?t=' + new Date().getTime();
                            });
                            alert('头像更新成功');
                        } else {
                            alert('头像更新失败: ' + data.message);
                        }
                    });
                }
            };
            input.click();
        }

        // 修改密码
        function changePassword() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if(newPassword !== confirmPassword) {
                alert('两次输入的密码不一致');
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
                    newPassword: newPassword
                })
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('密码修改成功');
                    document.getElementById('newPassword').value = '';
                    document.getElementById('confirmPassword').value = '';
                } else {
                    alert('修改失败: ' + data.message);
                }
            });
        }

        // 更新资源状态
        function updateStatus(resourceId) {
            const status = document.getElementById(`status-${resourceId}`).value;
            // AJAX请求更新状态
            fetch('/resource/updateStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    id: resourceId,
                    status: status
                })
            })
                .then(response => response.json())
                .then(data => {
                    if(data.success) {
                        alert('状态更新成功');
                        location.reload();
                    } else {
                        alert('更新失败: ' + data.message);
                    }
                });
        }

        // 删除资源
        function deleteResource(resourceId) {
            if(confirm('确定要删除此资源吗？')) {
                // AJAX请求删除资源
                fetch('/resource/delete', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        id: resourceId
                    })
                })
                    .then(response => response.json())
                    .then(data => {
                        if(data.success) {
                            alert('删除成功');
                            location.reload();
                        } else {
                            alert('删除失败: ' + data.message);
                        }
                    });
            }
        }

        // 添加新资源
        function addResource() {
            window.location.href = '/resource/add'; // 跳转到添加资源页面
        }

        // 其他功能保持不变
        function viewResource(resourceId) {
            window.location.href = '/resource/detail?id=' + resourceId;
        }
        
        function editResource(resourceId) {
            window.location.href = '/resource/edit?id=' + resourceId;
        }
        
        function viewOrder(orderId) {
            window.location.href = '/order/detail?id=' + orderId;
        }
        
        function payOrder(orderId) {
            window.location.href = '/order/pay?id=' + orderId;
        }
    </script>
</body>
</html>