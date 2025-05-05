<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 订单详情</title>
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

        .breadcrumb-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .back-btn {
            margin-right: 15px;
            color: var(--primary-color);
            font-size: 1.2rem;
            cursor: pointer;
        }

        .order-detail-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 30px;
        }

        .order-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .order-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .section-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-bg);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .detail-row {
            display: flex;
            margin-bottom: 10px;
        }

        .detail-label {
            width: 150px;
            font-weight: 600;
            color: #666;
        }

        .detail-value {
            flex: 1;
        }

        .status-completed {
            color: #28a745;
            font-weight: 600;
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-table th {
            background-color: #f8f9fa;
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
            color: #495057;
        }

        .product-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }

        .product-table tr:last-child td {
            border-bottom: none;
        }

        .timeline {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-top: 30px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 2px;
            background: #e9ecef;
            z-index: 1;
        }

        .timeline-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .timeline-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .timeline-step {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .timeline-date {
            font-size: 0.85rem;
            color: #6c757d;
        }

        .active-step .timeline-icon {
            background-color: #28a745;
        }

        .active-step::after {
            content: '';
            position: absolute;
            top: 20px;
            left: 50%;
            width: 100%;
            height: 2px;
            background: #28a745;
            z-index: 1;
        }

        .price-detail {
            display: flex;
            justify-content: space-between;
            max-width: 400px;
            margin-bottom: 10px;
        }

        .price-label {
            font-weight: 600;
            color: #495057;
        }

        .price-value {
            font-weight: 600;
        }

        .total-price {
            font-size: 1.2rem;
            color: var(--accent-color);
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
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
                    <a class="nav-link active" href="#">我的订单</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">数据分析</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <div class="dropdown me-3">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown">
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
    <!-- 返回按钮和面包屑导航 -->
    <div class="breadcrumb-container">
        <div class="back-btn" onclick="history.back()">
            <i class="bi bi-arrow-left"></i>
        </div>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="#">首页</a></li>
                <li class="breadcrumb-item"><a href="#">我的订单</a></li>
                <li class="breadcrumb-item active" aria-current="page">订单详情</li>
            </ol>
        </nav>
    </div>

    <!-- 订单详情主容器 -->
    <div class="order-detail-container">
        <h2 class="mb-4">订单详情 #ORD20250423001</h2>

        <!-- 基本信息部分 -->
        <div class="order-section">
            <h3 class="section-title">
                <i class="bi bi-info-circle"></i>基本信息
            </h3>
            <div class="detail-row">
                <div class="detail-label">订单号：</div>
                <div class="detail-value">ORD20250423001</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">创建时间：</div>
                <div class="detail-value">2025-04-23 12:42:00</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">客户名称：</div>
                <div class="detail-value">张三</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">联系电话：</div>
                <div class="detail-value">138-2584-1998</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">订单状态：</div>
                <div class="detail-value status-completed">已完成</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">收货地址：</div>
                <div class="detail-value">北京市海淀区中关村大街1号院</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">邮编：</div>
                <div class="detail-value">100084</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">承运人：</div>
                <div class="detail-value">李四</div>
            </div>
            <div class="detail-row">
                <div class="detail-label">承运人电话：</div>
                <div class="detail-value">138-1234-5678</div>
            </div>
        </div>

        <!-- 产品和服务详情部分 -->
        <div class="order-section">
            <h3 class="section-title">
                <i class="bi bi-box-seam"></i>产品和服务详情
            </h3>
            <table class="product-table">
                <thead>
                    <tr>
                        <th>产品名称</th>
                        <th>规格描述</th>
                        <th>数量</th>
                        <th>周期类型</th>
                        <th>生效时间</th>
                        <th>失效时间</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>云计算资源A</td>
                        <td>CPU: 4核, 内存: 16GB, 存储: 500GB</td>
                        <td>1</td>
                        <td>包月</td>
                        <td>2025-04-23</td>
                        <td>2025-05-23</td>
                    </tr>
                    <tr>
                        <td>数据存储服务B</td>
                        <td>容量: 1TB, 备份: 每日</td>
                        <td>1</td>
                        <td>包年</td>
                        <td>2025-04-23</td>
                        <td>2026-04-23</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 金额信息部分 -->
        <div class="order-section">
            <h3 class="section-title">
                <i class="bi bi-cash-stack"></i>金额信息
            </h3>
            <div class="price-detail">
                <span class="price-label">原价：</span>
                <span class="price-value">¥5000.00</span>
            </div>
            <div class="price-detail">
                <span class="price-label">优惠金额：</span>
                <span class="price-value">-¥500.00</span>
            </div>
            <div class="price-detail total-price">
                <span class="price-label">实际支付金额：</span>
                <span class="price-value">¥4500.00</span>
            </div>
        </div>

        <!-- 操作记录部分 -->
        <div class="order-section">
            <h3 class="section-title">
                <i class="bi bi-clock-history"></i>操作记录
            </h3>
            <div class="timeline">
                <div class="timeline-item active-step">
                    <div class="timeline-icon">
                        <i class="bi bi-cart-check"></i>
                    </div>
                    <div class="timeline-step">提交订单</div>
                    <div class="timeline-date">2025-04-23 12:42:00</div>
                </div>
                <div class="timeline-item active-step">
                    <div class="timeline-icon">
                        <i class="bi bi-credit-card"></i>
                    </div>
                    <div class="timeline-step">付款成功</div>
                    <div class="timeline-date">2025-04-23 12:45:00</div>
                </div>
                <div class="timeline-item active-step">
                    <div class="timeline-icon">
                        <i class="bi bi-gear"></i>
                    </div>
                    <div class="timeline-step">资源分配完成</div>
                    <div class="timeline-date">2025-04-23 12:50:00</div>
                </div>
                <div class="timeline-item active-step">
                    <div class="timeline-icon">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div class="timeline-step">完成</div>
                    <div class="timeline-date">2025-04-23 12:55:00</div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 返回按钮功能
    document.querySelector('.back-btn').addEventListener('click', function() {
        window.history.back();
    });
</script>
</body>
</html>