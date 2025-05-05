<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 资源详情</title>
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

       .resource-detail-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

       .resource-detail-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

       .resource-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-bg);
        }

       .category-badge {
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

       .resource-info {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
        }

       .info-label {
            font-weight: 600;
            color: #495057;
            margin-right: 5px;
        }

       .section-header {
            position: relative;
            margin-bottom: 20px;
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
            height: 100%;
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

       .pagination.page-item.active.page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

       .pagination.page-link {
            color: var(--primary-color);
        }

       .right-content {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

       .right-content>.resource-detail-card {
            flex: 0 0 auto;
        }

       .product-img {
            width: 40%;
            height: auto;
            margin-right: 20px;
            object-fit: cover;
            float: left;
        }

       .price {
            color: var(--accent-color);
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

       .evaluation {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }

       .delivery {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }

       .service {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }

       .installment {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }

       .purchase-buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

       .purchase-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin-left: 10px;
            color: white;
            font-weight: 600;
        }

       .add-to-cart {
            background-color: #e74c3c;
        }

       .buy-now {
            background-color: #3498db;
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
                        <a class="nav-link" href="#">首页</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">资源中心</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">制造服务</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">数据分析</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">我的项目</a>
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
                            <li><a class="dropdown-item" href="#">个人中心</a></li>
                            <li><a class="dropdown-item" href="#">我的收藏</a></li>
                            <li><a class="dropdown-item" href="#">消息中心</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">退出登录</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    <!-- 主要内容区 -->
    <div class="container py-4">
        <!-- 面包屑导航 -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">首页</a></li>
                <li class="breadcrumb-item"><a href="#">资源中心</a></li>
                <li class="breadcrumb-item active" aria-current="page">资源详情</li>
            </ol>
        </nav>
        <div class="row">
            <!-- 左侧边栏 -->
            <div class="col-lg-3 mb-4">
                <div class="sidebar">
                    <!-- 搜索框 -->
                    <div class="search-box mb-4">
                        <i class="bi bi-search"></i>
                        <input type="text" class="form-control" placeholder="搜索资源...">
                    </div>
                    <!-- 资源分类 -->
                    <div class="filter-group">
                        <div class="sidebar-title">资源分类</div>
                        <div class="list-group">
                            <a href="#"
                                class="list-group-item list-group-item-action d-flex justify-content-between align-items-center active">
                                全部资源
                                <span class="badge bg-primary rounded-pill">128</span>
                            </a>
                            <a href="#"
                                class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                设备资源
                                <span class="badge bg-secondary rounded-pill">42</span>
                            </a>
                            <a href="#"
                                class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                工艺知识
                                <span class="badge bg-secondary rounded-pill">35</span>
                            </a>
                            <a href="#"
                                class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                设计模型
                                <span class="badge bg-secondary rounded-pill">28</span>
                            </a>
                            <a href="#"
                                class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                制造服务
                                <span class="badge bg-secondary rounded-pill">23</span>
                            </a>
                        </div>
                    </div>
                    <!-- 筛选条件 -->
                    <div class="filter-group">
                        <div class="sidebar-title">筛选条件</div>
                        <div class="mb-3">
                            <div class="filter-title">资源类型</div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="type1" checked>
                                <label class="form-check-label" for="type1">3D模型</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="type2" checked>
                                <label class="form-check-label" for="type2">CAD图纸</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="type3">
                                <label class="form-check-label" for="type3">工艺文档</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="type4">
                                <label class="form-check-label" for="type4">设备参数</label>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="filter-title">行业领域</div>
                            <select class="form-select form-select-sm">
                                <option selected>全部行业</option>
                                <option>汽车制造</option>
                                <option>航空航天</option>
                                <option>电子电器</option>
                                <option>医疗器械</option>
                                <option>机械装备</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <div class="filter-title">上传时间</div>
                            <select class="form-select form-select-sm">
                                <option selected>全部时间</option>
                                <option>最近一周</option>
                                <option>最近一个月</option>
                                <option>最近三个月</option>
                                <option>最近半年</option>
                            </select>
                        </div>
                    </div>
                    <!-- 统计信息 -->
                    <div class="filter-group">
                        <div class="sidebar-title">资源统计</div>
                        <div class="stats-card">
                            <div class="stats-value">128</div>
                            <div class="stats-label">总资源数</div>
                        </div>
                        <div class="stats-card">
                            <div class="stats-value">42</div>
                            <div class="stats-label">设备资源</div>
                        </div>
                        <div class="stats-card">
                            <div class="stats-value">35</div>
                            <div class="stats-label">工艺知识</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 右侧资源详情内容 -->
            <div class="col-lg-9 mb-4 right-content">
                <!-- 资源详情卡片 -->
                <div class="resource-detail-card">
                    <div class="resource-detail-header">
                        <h2 class="resource-name">高精度CNC加工设备</h2>
                        <span class="category-badge">设备资源</span>
                    </div>
                    <div class="resource-tags">
                        <span class="resource-tag">机械加工</span>
                        <span class="resource-tag">高精度</span>
                        <span class="resource-tag">CNC</span>
                    </div>
                    <img src="https://via.placeholder.com/800x400" alt="CNC加工设备" class="product-img">
                    <div class="resource-info">
                        <span class="info-label">价格：</span><span class="price">¥500/小时</span>
                        <span class="info-label">数量：</span><span class="evaluation">3台</span>
                        <span class="info-label">资源类型：</span><span class="delivery">设备</span>
                        <span class="info-label">规格：</span><span class="service">XYZ行程1000*800*500mm</span>
                        <span class="info-label">状态：</span><span class="installment">可用</span>
                        <span class="info-label">好评率：</span><span class="installment">90%</span>
                    </div>
                    <div class="section-header">
                        <h3>资源描述</h3>
                    </div>
                    <p>该高精度CNC加工设备采用先进的控制系统，具备高稳定性和高精度加工能力，适用于多种复杂零部件的加工，可满足汽车制造、航空航天等行业的高精度加工需求。</p>
                    <div class="purchase-buttons">
                        <button class="buy-now">购买资源</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>