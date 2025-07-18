<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 我的订单</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
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

        .order-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            background-color: white;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .order-status {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-processing {
            background-color: #cce5ff;
            color: #004085;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .order-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .item-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
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
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
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

        .action-btn {
            padding: 5px 10px;
            font-size: 0.85rem;
            border-radius: 20px;
        }
        /* 分页样式 */
        .pagination .page-item .page-link {
            /*color: #6c757d; !* 默认灰色文字 *!*/
            color: var(--primary-color);
        }

        /* 当前页样式 */
        .pagination .page-item.active .page-link {
            /*color: #000 !important; !* 黑色文字 *!*/
            color: #007bff !important; /* 黑色文字 */
            background-color: #fff !important; /* 白色背景 */
            font-weight: bold;
        }

        /* 当前页底部蓝条 */
        .pagination .page-item.active .page-link::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 70%;
            height: 3px;
            background-color: #007bff; /* 蓝色条 */
            border-radius: 2px;
        }

        /* 悬停效果 */
        .pagination .page-item:not(.active):hover .page-link {
            color: #0056b3;
            background-color: #f8f9fa;
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
            <li class="breadcrumb-item active" aria-current="page">我的订单</li>
        </ol>
    </nav>

    <div class="row">
        <!-- 左侧边栏 -->
        <div class="col-lg-3 mb-4">
            <div class="sidebar">
                <!-- 搜索框 -->
                <div class="search-box mb-4">
                    <i class="bi bi-search"></i>
                    <input type="text"
                           id="orderSearchInput"
                           class="form-control"
                           placeholder="搜索订单..."
                           onkeyup="handleSearch(event)">
                </div>

                <!-- 订单状态筛选 -->
                <div class="filter-group">
                    <div class="sidebar-title">订单状态</div>
                    <div class="list-group" id="orderStatusFilter">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center active"
                           data-status="" onclick="filterByStatus(this, '')">
                            全部订单
                            <span class="badge bg-primary rounded-pill">0</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                           data-status="待支付" onclick="filterByStatus(this, '待支付')">
                            待支付
                            <span class="badge bg-secondary rounded-pill">0</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                           data-status="已支付" onclick="filterByStatus(this, '已支付')">
                            进行中
                            <span class="badge bg-secondary rounded-pill">0</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                           data-status="已完成" onclick="filterByStatus(this, '已完成')">
                            已完成
                            <span class="badge bg-secondary rounded-pill">0</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                           data-status="已取消" onclick="filterByStatus(this, '已取消')">
                            已取消
                            <span class="badge bg-secondary rounded-pill">0</span>
                        </a>
                    </div>
                </div>

                <!-- 筛选条件 -->
                <div class="filter-group">
                    <div class="sidebar-title">筛选条件</div>
                    <div class="mb-3">
                        <div class="filter-title">订单类型</div>
                        <select class="form-select form-select-sm">
                            <option selected>全部类型</option>
                            <option>设备租赁</option>
                            <option>加工服务</option>
                            <option>设计服务</option>
                            <option>技术支持</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <div class="filter-title">时间范围</div>
                        <select class="form-select form-select-sm">
                            <option selected>全部时间</option>
                            <option>最近一周</option>
                            <option>最近一个月</option>
                            <option>最近三个月</option>
                            <option>最近半年</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <div class="filter-title">金额范围</div>
                        <select class="form-select form-select-sm">
                            <option selected>全部金额</option>
                            <option>0-1000元</option>
                            <option>1000-5000元</option>
                            <option>5000-10000元</option>
                            <option>10000元以上</option>
                        </select>
                    </div>
                </div>

                <!-- 统计信息 -->
                <div class="filter-group">
                    <div class="sidebar-title">订单统计</div>
                    <div class="stats-card">
                        <div class="stats-value">15</div>
                        <div class="stats-label">总订单数</div>
                    </div>
                    <div class="stats-card">
                        <div class="stats-value">¥28,650</div>
                        <div class="stats-label">总交易金额</div>
                    </div>
                    <div class="stats-card">
                        <div class="stats-value">4.8</div>
                        <div class="stats-label">平均评分</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 右侧内容区 -->
        <div class="col-lg-9">
            <!-- 订单列表 -->
            <div class="mb-5">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="section-header m-0">我的订单</h4>
                    <div class="d-flex">
                        <select class="form-select form-select-sm me-2" style="width: 120px;">
                            <option selected>最近订单</option>
                            <option>金额从高到低</option>
                            <option>金额从低到高</option>
                            <option>按评分排序</option>
                        </select>
                    </div>
                </div>

                <!-- 订单卡片 -->
                <div class="order-container"></div>

                <!-- 分页 -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center" id="pagination">
                        <!-- 动态生成分页按钮 -->
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<script>
    // 修改document.ready中的代码
    $(document).ready(function () {
        searchOrders();
        fetchAllOrderStatusCounts();
    });

    // 渲染订单卡片
    function renderOrderCards(orders) {
        const container = $('.order-container'); // 假设你的订单卡片容器有这个类名
        if (!container.length) {
            console.error('找不到订单卡片容器');
            return;
        }

        // 清空容器（如果需要）
        container.empty();

        // 遍历每个订单并渲染
        orders.forEach(order => {
            // 首先获取资源详情
            getResourceDetails(order.resourceids, function (resources) {
                const orderCard = createOrderCard(order, resources);
                container.append(orderCard);
            });
        });
    }

    // 获取资源详情
    function getResourceDetails(resourceIds, callback) {
        const ids = resourceIds.split(',').filter(id => id.trim() !== '');
        if (ids.length === 0) {
            callback([]);
            return;
        }

        // 这里假设有一个接口可以批量获取资源信息
        $.ajax({
            url: '/user/resource/batch',
            type: 'POST',
            data: {ids: ids.join(',')},
            dataType: 'json',
            success: function (response) {
                if (response.code === 200) {
                    callback(response.obj || []);
                } else {
                    console.error('获取资源详情失败:', response.message);
                    callback([]);
                }
            },
            error: function (xhr, status, error) {
                console.error('获取资源详情AJAX请求失败:', status, error);
                callback([]);
            }
        });
    }

    // 创建订单卡片HTML
    function createOrderCard(order, resources) {
        // 格式化日期
        const orderTime = formatDate(order.ordertime);
        const completionTime = order.completiontime ? formatDate(order.completiontime) : '未完成';

        // 根据状态设置样式
        let statusClass = '';
        let statusText = '';
        switch (order.orderstatus) {
            case '待支付':
                statusClass = 'status-pending';
                statusText = '待支付';
                break;
            case '已支付':
                statusClass = 'status-processing';
                statusText = '进行中';
                break;
            case '已完成':
                statusClass = 'status-completed';
                statusText = '已完成';
                break;
            case '已取消':
                statusClass = 'status-cancelled';
                statusText = '已取消';
                break;
            default:
                statusClass = 'status-default';
                statusText = order.orderstatus;
        }

        // 创建资源项HTML
        let resourceItemsHtml = '';
        resources.forEach(resource => {
            // 根据categoryid设置不同的占位图
            let placeholderText = '资源';
            switch (resource.categoryid) {
                case 1:
                    placeholderText = '设备资源';
                    break;
                case 2:
                    placeholderText = '工艺知识';
                    break;
                case 3:
                    placeholderText = '设计模型';
                    break;
                case 4:
                    placeholderText = '制造服务';
                    break;
            }

            resourceItemsHtml +=
                '<div class="order-item d-flex">' +
                '<div class="flex-shrink-0 me-3">' +
                '<img src="https://via.placeholder.com/100?text=' + encodeURIComponent(placeholderText) + '" class="item-img" alt="' + resource.resourcename + '">' +
                '</div>' +
                '<div class="flex-grow-1">' +
                '<h6 class="mb-1">' + resource.resourcename + '</h6>' +
                '<div class="d-flex justify-content-between">' +
                '<div>' +
                '<small class="text-muted">供应商ID: ' + resource.userid + '</small><br>' +
                //数量不对应
                '<small class="text-muted">数量: ' + (order.quantity || 1) + '</small>' +
                '</div>' +
                '<div class="text-end">' +
                '<div class="fw-bold">¥' + resource.resourceprice.toFixed(2) + '</div>' +
                '<small class="text-muted">预计完成: ' + completionTime + '</small>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>';
        });

        // 构建完整的订单卡片HTML
        const orderCardHtml =
            '<div class="card order-card mb-4">' +
            '<div class="card-header bg-light d-flex justify-content-between align-items-center">' +
            '<div>' +
            '<span class="fw-bold">订单编号: </span>' +
            '<span>ORD-' + order.orderid.toString().padStart(8, '0') + '</span>' +
            '<span class="ms-3 fw-bold">创建时间: </span>' +
            '<span>' + orderTime + '</span>' +
            '</div>' +
            '<span class="order-status ' + statusClass + '">' + statusText + '</span>' +
            '</div>' +
            '<div class="card-body">' +
            resourceItemsHtml +
            '<hr>' +
            '<div class="d-flex justify-content-between align-items-center">' +
            '<div>' +
            '<span class="fw-bold me-2">合计: </span>' +
            //     order.totalprice === null ? '--' : order.totalprice.toFixed(2)
            '<span class="text-danger fw-bold">¥' + (order.totalprice === null ? '--' : order.totalprice.toFixed(2)) + '</span>' +
            '</div>' +
            '<div>' +
            '<button class="btn btn-sm btn-outline-primary action-btn me-2" onclick="contactSupplier(' + order.orderid + ')">' +
            '<i class="bi bi-chat-left-text me-1"></i>联系供应商' +
            '</button>' +
            '<button class="btn btn-sm btn-outline-secondary action-btn" onclick="viewOrderDetails(' + order.orderid + ')">' +
            '<i class="bi bi-eye me-1"></i>查看详情' +
            '</button>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';

        return orderCardHtml;
    }

    // 辅助函数：格式化日期
    function formatDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toISOString().split('T')[0] + ' ' + date.toTimeString().split(' ')[0].substring(0, 5);
    }

    // 联系供应商函数
    function contactSupplier(orderId) {
        console.log('联系供应商，订单ID:', orderId);
        // 这里可以添加联系供应商的逻辑
        // 例如打开聊天窗口或跳转到聊天页面
    }

    // 查看订单详情函数
    function viewOrderDetails(orderId) {
        console.log('查看订单详情，订单ID:', orderId);
        // 这里可以添加查看订单详情的逻辑
        // 例如跳转到订单详情页面
        window.location.href = `${pageContext.request.contextPath}/user/order/detail?id=` + orderId;
    }

    // 在script标签顶部添加分页参数
    var currentSearchParams = {
        pageNum: 1,
        pageSize: 6,
        searchKey: '',
        orderstatus: ''
    };



    // ajax请求
    function searchOrders() {
        $.ajax({
            url: '/user/order/page_Search',
            type: 'POST',
            dataType: 'json',
            data: currentSearchParams,
            success: function (response) {
                if (response.code === 0) {
                    renderOrderCards(response.obj.list);
                    renderPagination({
                        pageNum: currentSearchParams.pageNum,
                        pageSize: currentSearchParams.pageSize,
                        total: response.obj.total,
                        totalPages: response.obj.totalPages
                    });
                } else {
                    console.error('获取订单数据失败:', response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error('AJAX请求失败:', status, error);
            }
        });
    }

    // 搜索处理函数（支持回车和防抖）
    let searchTimer;
    function handleSearch(event) {
        // 回车键触发搜索
        if (event.key === 'Enter') {
            search();
            return;
        }
        // 输入防抖（300毫秒延迟）
        clearTimeout(searchTimer);
        searchTimer = setTimeout(search, 300);
    }
    // 搜索函数
    function search() {
        // 获取搜索关键字
        const searchKey = document.getElementById('orderSearchInput').value.trim();
        // 获取当前选中的分类ID（新增部分）
        const activeStatusItem = document.querySelector('#orderStatusFilter .list-group-item.active');
        const orderstatus = activeStatusItem ? activeStatusItem.getAttribute('data-status') : '';
        currentSearchParams.searchKey = searchKey;
        currentSearchParams.orderstatus = orderstatus;
        currentSearchParams.pageNum = 1; // 重置到第一页
        searchOrders();
        fetchAllOrderStatusCounts();
    }

    // 状态筛选事件处理
    function filterByStatus(clickedElement, status) {
        // 1. 更新 UI 状态
        const items = document.querySelectorAll('#orderStatusFilter .list-group-item');
        items.forEach(item => {
            item.classList.remove('active');
            item.querySelector('.badge').className = 'badge bg-secondary rounded-pill';
        });

        clickedElement.classList.add('active');
        clickedElement.querySelector('.badge').className = 'badge bg-primary rounded-pill';

        // 2. 更新当前筛选状态
        currentSearchParams.orderstatus = status;
        currentSearchParams.pageNum = 1; // 切换状态时重置页码

        // 3. 执行筛选
        searchOrders();
        fetchAllOrderStatusCounts();
    }

    // 更新所有订单状态的 badge 数字
    function updateAllOrderStatusBadges(counts) {
        const statusCounts = {};
        // 遍历响应数据，将订单状态和对应的数量存入 statusCounts 对象
        counts.forEach(item => {
            const status = item.orderstatus === -1 ? '' : item.orderstatus;
            statusCounts[status] = item.count;
        });

        const statusItems = document.querySelectorAll('#orderStatusFilter .list-group-item');
        statusItems.forEach(item => {
            const status = item.getAttribute('data-status') || '';
            const badge = item.querySelector('.badge');
            if (badge) {
                // 根据订单状态获取对应的数量，如果不存在则默认为 0
                const count = statusCounts[status] || 0;
                badge.textContent = count;
                if (item.classList.contains('active')) {
                    badge.classList.replace('bg-secondary', 'bg-primary');
                } else {
                    badge.classList.replace('bg-primary', 'bg-secondary');
                }
            }
        });
    }
    // 定义获取所有订单状态数量的函数
    function fetchAllOrderStatusCounts() {
        $.ajax({
            url: '/user/order/status_counts',
            type: 'POST',
            dataType: 'json',
            data: {
                searchKey: currentSearchParams.searchKey
            },
            success: function (response) {
                if (response.code === 0) {
                    updateAllOrderStatusBadges(response.obj.data);
                }
            },
            error: function (xhr, status, error) {
                console.error('获取订单状态数量失败:', error);
            }
        });
    }

    // 分页跳转
    function goToPage(pageNum) {
        currentSearchParams.pageNum = pageNum;
        searchOrders();
    }

    function renderPagination(pageData) {
        var pagination = $('#pagination');
        pagination.empty();

        // 上一页按钮
        var prevDisabled = pageData.pageNum === 1 ? 'disabled' : '';
        pagination.append(
            '<li class="page-item ' + prevDisabled + '">' +
            '<a class="page-link" href="#" onclick="goToPage(' + (pageData.pageNum - 1) + ')">上一页</a>' +
            '</li>'
        );

        // 页码按钮
        var startPage = Math.max(1, pageData.pageNum - 2);
        var endPage = Math.min(pageData.totalPages, startPage + 4);

        for (var i = startPage; i <= endPage; i++) {
            var active = i === pageData.pageNum ? 'active' : '';
            pagination.append(
                '<li class="page-item ' + active + '">' +
                '<a class="page-link" href="#" onclick="goToPage(' + i + ')">' + i + '</a>' +
                '</li>'
            );
        }

        // 下一页按钮
        var nextDisabled = pageData.pageNum >= pageData.totalPages ? 'disabled' : '';
        pagination.append(
            '<li class="page-item ' + nextDisabled + '">' +
            '<a class="page-link" href="#" onclick="goToPage(' + (pageData.pageNum + 1) + ')">下一页</a>' +
            '</li>'
        );
    }
</script>