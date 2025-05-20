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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>
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
           align-items: center;
           gap: 16px;
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



        .purchase-section {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 16px;
            margin-top: 20px;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid #ccc;
            border-radius: 999px;
            overflow: hidden;
            height: 40px;
            background-color: #fff;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
        }

        .qty-btn {
            background-color: #3498db;
            color: white;
            border: none;
            width: 40px;
            height: 100%;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s ease;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .qty-btn:hover {
            background-color: #2980b9;
        }

        #quantity-input {
            width: 50px;
            text-align: center;
            border: none;
            outline: none;
            font-size: 18px;
            font-weight: bold;
            background: transparent;
            color: #333;
        }

        .buy-now {
            padding: 10px 24px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .buy-now:hover {
            background-color: #3498db;
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
                <li class="breadcrumb-item active" aria-current="page">资源详情</li>
            </ol>
        </nav>
        <div class="row">
            <!-- 左侧边栏 -->
            <%--<div class="col-lg-3 mb-4">
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
            </div>--%>
            <!-- 右侧资源详情内容 -->
            <div class="col-lg-9 mb-4 right-content">
                <!-- 资源详情卡片 -->
                <div class="resource-detail-container"></div>
            </div>
        </div>
    </div>
</body>

</html>
<script>

    // 获取URL中的资源ID
    function getResourceIdFromUrl() {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get('resourceId');
    }

    // 加载资源详情
    function loadResourceDetail() {
        const resourceId = getResourceIdFromUrl();
        if (!resourceId) {
            console.error("未获取到资源ID");
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/user/resource/' + resourceId,
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.code === 0) {
                    renderResourceDetail(response.obj); // 渲染数据
                    console.log(response.obj);
                } else {
                    showError(response.msg || "加载失败");
                }
            },
            error: function(xhr) {
                console.error("请求失败:", xhr.status);
                document.querySelector('.resource-detail-card').innerHTML =
                    '<div class="alert alert-danger">加载资源详情失败</div>';
            }
        });
    }

    // 渲染资源详情（纯字符串拼接）
    function renderResourceDetail(resource) {
        var html =
            '<div class="resource-detail-card">' +
            '<div class="resource-detail-header">' +
            '<div class="resource-name" >' + resource.resourceid + '</div>' +
            '<h2 class="resource-name">' + resource.resourcename + '</h2>' +
            '<span class="category-badge">' + getCategoryName(resource.categoryid) + '</span>' +
            '</div>' +
            '<div class="resource-tags">' +
            '<span class="resource-tag">标签</span>' +
            '<span class="resource-tag">标签</span>' +
            '<span class="resource-tag">标签</span>' +
            '</div>' +
            '<img src="' + (resource.imageUrl || 'https://via.placeholder.com/800x400') + '" alt="' + resource.resourcename + '" class="product-img">' +
            '<div class="resource-info">' +
            '<span class="info-label">价格：</span><span class="price">¥' + resource.resourceprice.toFixed(2) + '</span>' +
            '<span class="info-label">数量：</span><span class="evaluation">' + resource.quantity + '台</span>' +
            '<span class="info-label">资源类型：</span><span class="delivery">' + getCategoryName(resource.categoryid) + '</span>' +
            '<span class="info-label">规格：</span><span class="service">' + (resource.specification || '暂无规格') + '</span>' +
            '<span class="info-label">状态：</span><span class="installment">' + getResourceStatus(resource.resourcestatus) + '</span>' +
            '<span class="info-label">好评率：</span><span class="installment">' + (resource.rating || '暂无评分') + '</span>' +
            '</div>' +
            '<div class="section-header">' +
            '<h3>资源描述</h3>' +
            '</div>' +
            '<p>' + (resource.resourcedescription || '暂无描述') + '</p>' +
            '<div class="purchase-section">' +
            '<div class="quantity-control">' +
            '<button class="qty-btn" onclick="decreaseQuantity()">−</button>' +
            '<input type="text" id="quantity-input" value="1"  min="1" max="' + resource.quantity + '" readonly>' +
            '<button class="qty-btn" onclick="increaseQuantity()">＋</button>' +
            '</div>' +
            '<button class="buy-now" onclick="createOrder(' + resource.resourceid + ')">购买资源</button>' +
            '</div>' +
            '</div>';
        //清空数据
        document.querySelector('.resource-detail-container').innerHTML = html;
    }

    function increaseQuantity() {
        var input = document.getElementById('quantity-input');
        var value = parseInt(input.value);
        if (value >= parseInt(input.max)) {
            alert('库存不足');
            return;
        }
        input.value = value + 1;
    }

    function decreaseQuantity() {
        var input = document.getElementById('quantity-input');
        var value = parseInt(input.value);
        if (value > 1) {
            input.value = value - 1;
        }
    }

    // 辅助函数：分类ID转名称
    function getCategoryName(categoryId) {
        let categories = {
            1: '设备资源',
            2: '工艺知识',
            3: '设计模型',
            4: '制造服务'
        };
        return categories[categoryId] || '其他';
    }

    // 辅助函数：分类ID转资源类型
    function getResourceStatus(resourceStatus) {
        let status = {
            1: "繁忙",
            2: "空闲",
            3: "损坏",
        };
        return status[resourceStatus] || '其他';
    }

    // 页面加载时执行
    document.addEventListener('DOMContentLoaded', function() {
        loadResourceDetail();
    });

    function createOrder(resourceId) {
        // 获取购买数量
        const quantity = parseInt(document.getElementById('quantity-input').value);
        //获取总价
        const price = parseFloat(document.querySelector('.price').textContent.replace('¥', ''));
        //获取总价
        const totalPrice = price * quantity;

        // 显示加载状态
        const buyBtn = document.querySelector('.buy-now');
        const originalText = buyBtn.innerHTML;
        buyBtn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> 创建订单中...';
        buyBtn.disabled = true;

        // 发送AJAX请求
        $.ajax({
            url: '${pageContext.request.contextPath}/user/order/create',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                resourceids: resourceId.toString(),
                quantity: quantity,
                totalprice: totalPrice
            }),
            success: function(response) {
                if(response.code === 200) { // 假设200表示成功
                    showToast("购买成功","success")
                    // 跳转到订单详情页面
                    window.location.href = '${pageContext.request.contextPath}/user/order/detail?id=' + response.obj.orderid;
                } else {
                    alert('创建订单失败: ' + response.msg);
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.statusText);
            },
            complete: function() {
                // 无论成功或失败，都恢复按钮状态
                buyBtn.innerHTML = originalText;
                buyBtn.disabled = false;
            }
        });
    }
</script>