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

        .active-step .timeline-icon {
            background-color: #28a745;
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
        /* 订单状态样式 */
        .status-待支付 {
            color: #ff9800;
            font-weight: bold;
        }
        .status-已支付 {
            color: #4caf50;
            font-weight: bold;
        }
        .status-已取消 {
            color: #f44336;
            font-weight: bold;
        }
        .status-已完成 {
            color: #2196f3;
            font-weight: bold;
        }
    </style>
</head>
<body>
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
    <div class="order-detail-container" id="orderContainer">
<%--        js渲染--%>
    </div>

        <!-- 操作记录部分 -->
<%--        <div class="order-section">
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
        </div>--%>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 返回按钮功能
    document.querySelector('.back-btn').addEventListener('click', function() {
        window.history.back();
    });

    //页面加载完成获取连接中的Id，并发送请求
    document.addEventListener('DOMContentLoaded', function() {
        var orderId = getResourceIdFromUrl();
        //发送请求并渲染数据
        if (orderId) {
            fetchOrderDetail(orderId);
        }
    });

    function getResourceIdFromUrl() {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get('id');
    }
    function fetchOrderDetail(orderId) {
        fetch('/api/order/detail?id=' + orderId)
            .then(response => response.json())
            .then(data => {
                if (data.code === 200) {
                    renderOrderDetail(data.obj);
                } else {
                    document.getElementById('orderContainer').innerHTML =
                        '<div class="alert alert-danger">' + data.msg + '</div>';
                }
            })
            .catch(error => {
                document.getElementById('orderContainer').innerHTML =
                    '<div class="alert alert-danger">请求失败: ' + error.message + '</div>';
            });
    }

    function renderOrderDetail(orderData) {
        const { order, user, resources } = orderData;

        // 分类映射
        const categoryMap = {
            1: "设备资源",
            2: "工艺知识",
            3: "设计模型",
            4: "制造服务"
        };

        // 生成资源表格行
        let resourceRows = '';
        resources.forEach(resource => {
            resourceRows += '<tr>' +
                '<td>' + resource.resourcename + '</td>' +
                '<td>' + resource.resourcedescription + '</td>' +
                '<td>' + order.quantity + '</td>' +
                '<td>' + (categoryMap[resource.categoryid] || '未知类型') + '</td>' +
                '<td>¥' + resource.resourceprice + '</td>' +
                '</tr>';
        });
        // 拼接完整HTML
        const html = '<h2 class="mb-4">订单详情 #' + order.orderid + '</h2>' +
            '<!-- 基本信息部分 -->' +
            '<div class="order-section">' +
            '<h3 class="section-title"><i class="bi bi-info-circle"></i>基本信息</h3>' +
            '<div class="detail-row">' +
            '<div class="detail-label">订单号：</div>' +
            '<div class="detail-value">' + order.orderid + '</div>' +
            '</div>' +
            '<div class="detail-row">' +
            '<div class="detail-label">创建时间：</div>' +
            '<div class="detail-value">' + order.ordertime + '</div>' +
            '</div>' +
            '<div class="detail-row">' +
            '<div class="detail-label">客户名称：</div>' +
            '<div class="detail-value">' + user.username + '</div>' +
            '</div>' +
            '<div class="detail-row">' +
            '<div class="detail-label">联系电话：</div>' +
            '<div class="detail-value">' + user.phone + '</div>' +
            '</div>' +
            '<div class="detail-row">' +
            '<div class="detail-label">订单状态：</div>' +
            '<div class="detail-value status-' + order.orderstatus + '">' + order.orderstatus + '</div>' +
            '</div>' +
            '<div class="detail-row">' +
            '<div class="detail-label">收货地址：</div>' +
            '<div class="detail-value">' + user.address + '</div>' +
            '</div>' +
            '<div class="detail-row">' +
            '<div class="detail-label">邮箱：</div>' +
            '<div class="detail-value">' + user.email + '</div>' +
            '</div>' +
            '</div>' +
            '<!-- 产品和服务详情部分 -->' +
            '<div class="order-section">' +
            '<h3 class="section-title"><i class="bi bi-box-seam"></i>产品和服务详情</h3>' +
            '<table class="product-table">' +
            '<thead>' +
            '<tr>' +
            '<th>资源名称</th>' +
            '<th>规格描述</th>' +
            '<th>数量</th>' +
            '<th>资源类型</th>' +
            '<th>单价</th>' +
            '</tr>' +
            '</thead>' +
            '<tbody>' + resourceRows + '</tbody>' +
            '</table>' +
            '</div>' +
            '<!-- 金额信息部分 -->' +
            '<div class="order-section">' +
            '<h3 class="section-title"><i class="bi bi-cash-stack"></i>金额信息</h3>' +
            '<div class="price-detail">' +
            '<span class="price-label">原价：</span>' +
            '<span class="price-value">¥' + order.totalprice + '</span>' +
            '</div>' +
            '<div class="price-detail">' +
            '<span class="price-label">优惠金额：</span>' +
            '<span class="price-value">-¥0.00</span>' +
            '</div>' +
            '<div class="price-detail total-price">' +
            '<span class="price-label">实际支付金额：</span>' +
            '<span class="price-value">¥' + order.totalprice + '</span>' +
            '</div>' +
            '</div>';

        document.getElementById('orderContainer').innerHTML = html;
    }
</script>
</body>
</html>