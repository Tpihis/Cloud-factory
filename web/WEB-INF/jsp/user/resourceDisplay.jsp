<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 资源中心</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>
<%--    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
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
            -ms-overflow-style: none;
            scrollbar-width: none;
            overflow-y: scroll;
        }

        /* 隐藏滚动条 */
        ::-webkit-scrollbar {
            display: none;
        }

        .resource-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: white;
        }

        .resource-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        img {
            width: 100%;
            height: auto;
        }
        .card-img-top {
            /*min-height: 180px;    !* 设置最小高度 *!*/

            height: 250px;    /* 设置高度 */
            object-fit: contain;  /* 完整显示图片 */
            border-radius: 10px;
            filter: brightness(90%);
            transition: filter 0.3s;
            /*margin: 0 auto;       !* 水平居中 *!*/
        /*    contain–被替换的内容被缩放以保持其纵横比，同时适合元素的内容框。整个对象被制作成填充盒子，同时保持其纵横比，因此如果其纵横比与盒子的纵横比不匹配，则对象将被“信箱”。
cover–替换的内容的大小可以在填充元素的整个内容框时保持其纵横比。如果对象的纵横比与其框的纵横比不匹配，则对象将被剪裁以适应。
fill–替换的内容大小足以填充元素的内容框。整个对象将完全填满该框。如果对象的纵横比与其长方体的纵横比不匹配，则对象将被拉伸以适应。
none–替换的内容不会调整大小。按比例缩小——内容的大小就像没有指定或包含一样，以产生较小的具体对象大小为准。*/

        }

        .resource-card:hover .card-img-top {
            filter: brightness(100%);
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
            z-index: 1;
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
            transition: background-color 0.3s;
        }

        .resource-tag:hover {
            background-color: #d1d8e0;
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark-bg);
        }

        .card-text {
            font-size: 0.9rem;
            color: #6c757d;
            line-height: 1.5;
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


        .pagination .page-link {
            color: var(--primary-color);
        }
        .page-item .page-item .disabled .page-link {
            color: #6c757d;
            pointer-events: none;
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
        /*悬浮按钮发布资源*/
        /* 悬浮按钮样式 */
        .floating-action-btn {
            position: fixed;
            right: 50px;
            bottom: 80px;
            z-index: 1000;
            transition: all 0.3s;
        }

        .floating-action-btn button {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .floating-action-btn:hover {
            transform: scale(1.1);
        }


        /* 移动端适配 */
        @media (max-width: 768px) {
            .floating-action-btn {
                right: 20px;
                bottom: 20px;
            }
        }
        /* 悬浮按钮样式 */

         .fab {
             position: fixed;
             bottom: 30px;
             right: 30px;
             width: 60px;
             height: 60px;
             background-color: #007bff;
             color: white;
             border-radius: 50%;
             text-align: center;
             line-height: 60px;
             font-size: 30px;
             box-shadow: 0 4px 6px rgba(0,0,0,0.1);
             text-decoration: none;
             transition: background-color 0.3s ease;
             z-index: 999;
         }
        .fab:hover {
            background-color: #0056b3;
        }

        .空闲{
            color: #28a745;
        }
        .损坏{

            color: #dc3545;
        }
        .繁忙{
            color: #ffc107;
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
                <li class="breadcrumb-item active" aria-current="page">资源中心</li>
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
                               id="resourceSearchInput"
                               class="form-control"
                               placeholder="搜索资源..."
                               onkeyup="handleSearch(event)">
                    </div>


                    <!-- 资源分类 -->
                    <div class="filter-group">
                        <div class="sidebar-title">资源分类</div>
                        <div class="list-group" id="resourceCategoryFilter">
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center active"
                               data-category="" onclick="filterByCategory(this, '')">
                                全部资源
                                <span class="badge bg-primary rounded-pill">0</span>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                               data-category="1" onclick="filterByCategory(this, '1')">
                                设备资源
                                <span class="badge bg-secondary rounded-pill">0</span>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                               data-category="2" onclick="filterByCategory(this, '2')">
                                工艺知识
                                <span class="badge bg-secondary rounded-pill">0</span>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                               data-category="3" onclick="filterByCategory(this, '3')">
                                设计模型
                                <span class="badge bg-secondary rounded-pill">0</span>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                               data-category="4" onclick="filterByCategory(this, '4')">
                                制造服务
                                <span class="badge bg-secondary rounded-pill">0</span>
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
                            <div class="filter-title">资源状态</div>
                            <select class="form-select form-select-sm" id="resourceStatusSelect" onchange="handleStatusChange(this)">
                                <option value="" selected>全部</option>
                                <option value="1">繁忙</option>
                                <option value="2">空闲</option>
                                <option value="3">损坏</option>
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

            <!-- 右侧资源展示区 -->
            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="section-header m-0">全部资源</h4>
                    <div class="d-flex">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                    onclick="handleSortChange('resourceid')">
                                默认排序 <span id="resourceidSort">▲▽</span>
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                    onclick="handleSortChange('resourceprice')">
                                价格 <span id="resourcepriceSort">△▽</span>
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                    onclick="handleSortChange('resourcedate')">
                                发布时间 <span id="resourcedateSort">△▽</span>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- 资源列表 -->
                <div class="row" id="resources-container">

                </div>

                <!-- 分页 -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center" id="pagination">
                        <!-- 动态生成分页按钮 -->
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <!-- 固定在右下角的发布按钮 -->
    <div class="floating-action-btn">
        <form action="${pageContext.request.contextPath}/user/resource/publish" method="get">
            <button type="submit" class="btn btn-primary rounded-circle">
                <i class="bi bi-plus-lg fs-4"></i>
            </button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<script>
    $(function() {

        // 加载资源数据
        // loadResources();
        searchResources();
        fetchAllResourceCategoryCounts();
    });

    function loadResources() {
        $.ajax({
            url: '${pageContext.request.contextPath}/user/resource/pageSearch',
            type: 'POST',
            dataType: 'json',
            success: function(data) {
                renderResources(data);
            },
            error: function(xhr, status, error) {
                console.error("Error loading resources: ", error);
            }
        });
    }
    // 分页查询
    function searchResources() {
        $.ajax({
            url: '${pageContext.request.contextPath}/user/resource/page_Search',
            type: 'POST',
            // contentType: 'application/json',
            dataType: 'json',
            // data: JSON.stringify(params),
            data: currentSearchParams,
            success: function(response) {
                console.log(response);
                if (response.code === 0) {
                    renderResources(response.obj.list);
                    // renderPagination(response.obj);
                    renderPagination({
                        pageNum: currentSearchParams.pageNum,
                        pageSize: currentSearchParams.pageSize,
                        total: response.obj.total,
                        totalPages: response.obj.totalPages
                    });
                    // 更新当前分类的数字
                    // updateCategoryBadges(response.obj.total);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error loading resources: ", error);
            }
        });
    }
    function renderResources(resources) {
        const container = $('#resources-container'); // 假设有一个容器元素
        container.empty(); // 清空现有内容
        resources.forEach(resource => {
            const resourceCard =
                '<div class="col-md-6">' +
                '<div class="card resource-card" onclick="goToDetail('+ resource.resourceid+ ')">' +
                '<img src="${pageContext.request.contextPath}/system/resourceImage?resourceId='+ resource.resourceid +'" ' +
                'class="card-img-top" alt="'+ resource.resourcename +'" style="object-fit: cover;">' +
                '<div class="card-body">' +
                '<span class="category-badge">' + getCategoryName(resource.categoryid) + '</span>' +
                '<h5 class="card-title">' + resource.resourcename + '</h5>' +
                '<p class="card-text">' + resource.resourcedescription + '</p>' +
                '<span class="resource-tag">价格: ¥' + resource.resourceprice + '</span>' +
                '<span class="resource-tag ' + getResourceStatusName(resource.resourcestatus) + '">' +
                '状态: ' + getResourceStatusName(resource.resourcestatus) + '</span>' +
                '<span class="resource-tag">库存: ' + resource.quantity + '</span>' +
                '</div>' +
                '</div>' +
                '</div>';
            container.append(resourceCard);
        });
    }
    // 分类ID到中文名称的映射
    const categoryMap = {
        1: "设备资源",
        2: "工艺知识",
        3: "设计模型",
        4: "制造服务",
        other: "其他" // 用于处理未知分类ID的情况
    };
    // 分类ID到中文名称的映射
    const resourceStatusMap = {
        1: "繁忙",
        2: "空闲",
        3: "损坏",
        // 4: "制造服务",
        other: "其他" // 用于处理未知分类ID的情况
    };

    // 获取分类名称的函数
    function getCategoryName(categoryId) {
        return categoryMap[categoryId] ;
    }
    // 获取分类名称的函数
    function getResourceStatusName(resourceStatus) {
        return resourceStatusMap[resourceStatus] ;
    }
    function goToDetail(resourceId) {
        // 跳转到详情页，携带resourceId参数
        window.location.href = `details?resourceId=` + resourceId;
    }

    /**
     * 渲染分页导航（字符串拼接版）
     * @param {Object} pageData 分页数据 { pageNum, pageSize, total, totalPages }
     */
    function renderPagination(pageData) {
        var pagination = document.getElementById('pagination');
        pagination.innerHTML = '';

        // 上一页按钮
        var prevDisabled = pageData.pageNum === 1 ? 'disabled' : '';
        pagination.innerHTML +=
            '<li class="page-item ' + prevDisabled + '">' +
            '<a class="page-link" href="#" onclick="goToPage(' + (pageData.pageNum - 1) + ')">上一页' +
            // '<i class="bi bi-chevron-left"></i>' +
            '</a>' +
            '</li>';

        // 页码按钮（最多显示5个页码）
        var startPage = Math.max(1, pageData.pageNum - 2);
        var endPage = Math.min(pageData.totalPages, startPage + 4);

        for (var i = startPage; i <= endPage; i++) {
            var active = i === pageData.pageNum ? 'active' : '';
            pagination.innerHTML +=
                '<li class="page-item ' + active + '">' +
                '<a class="page-link" href="#" onclick="goToPage(' + i + ')">' + i + '</a>' +
                '</li>';
        }

        // 下一页按钮
        var nextDisabled = pageData.pageNum === pageData.totalPages ? 'disabled' : '';
        pagination.innerHTML +=
            '<li class="page-item ' + nextDisabled + '">' +
            '<a class="page-link" href="#" onclick="goToPage(' + (pageData.pageNum + 1) + ')">下一页' +
            // '<i class="bi bi-chevron-right"></i>' +
            '</a>' +
            '</li>';
    }
    // 当前搜索参数（全局变量）
    let currentSearchParams = {
        pageNum: 1,
        pageSize: 6,
        auditstatus: '通过',
        searchKey: '',
        categoryid:'',
        resourcestatus:'',
        orderBy: 'resourceid', // 排序字段
        orderDirect: 'ASC', // 排序类型，'asc'升 或 'desc'降
    };

    // 跳转到指定页
    function goToPage(pageNum) {
        if (pageNum < 1 || pageNum > currentSearchParams.totalPages) return;

        currentSearchParams.pageNum = pageNum;
        searchResources(); // 重新加载数据
    }
    // 搜索处理函数（支持回车和防抖）
    let searchTimer;
    function handleSearch(event) {
        // 回车键触发搜索
        // if (event.which === 13) {
        //     search();
        //     return;
        // }
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
        const searchKey = document.getElementById('resourceSearchInput').value.trim();
        // 获取当前选中的分类ID（新增部分）
        const activeCategoryItem = document.querySelector('#resourceCategoryFilter .list-group-item.active');
        const categoryId = activeCategoryItem ? activeCategoryItem.getAttribute('data-category') : '';
        currentSearchParams.searchKey = searchKey;
        currentSearchParams.categoryid = categoryId;
        currentSearchParams.pageNum = 1; // 重置到第一页
        searchResources();
        fetchAllResourceCategoryCounts();

    }

    // 分类筛选函数
    function filterByCategory(clickedElement, categoryId) {
        // 1. 更新UI状态
        const items = document.querySelectorAll('#resourceCategoryFilter .list-group-item');
        items.forEach(item => {
            item.classList.remove('active');
            item.querySelector('.badge').className = 'badge bg-secondary rounded-pill';
        });

        clickedElement.classList.add('active');
        clickedElement.querySelector('.badge').className = 'badge bg-primary rounded-pill';

        // 2. 更新当前筛选状态
        currentSearchParams.categoryid = categoryId;
        currentSearchParams.pageNum = 1; // 切换分类时重置页码
        // 3. 执行筛选（可以结合之前的搜索功能）
        searchResources();
        // 当点击全部资源时，获取并更新所有状态数量
        fetchAllResourceCategoryCounts();

    }
    // 状态筛选函数
    function handleStatusChange(selectElement) {
        currentSearchParams.resourcestatus = selectElement.value;
        currentSearchParams.pageNum = 1; // 重置到第一页
        searchResources();
        fetchAllResourceCategoryCounts();
    }
    // 排序处理函数
    function handleSortChange(sortField) {

        // 判断是否是相同的排序字段
        if (currentSearchParams.orderBy === sortField) {
            // 相同字段则切换排序方向
            currentSearchParams.orderDirect = currentSearchParams.orderDirect === 'asc' ? 'desc' : 'asc';
        } else {
            // 不同字段则重置为升序
            currentSearchParams.orderBy = sortField;
            currentSearchParams.orderDirect = 'asc';
        }
        // 更新选项文本以反映排序方向
        updateSortButtons();

        currentSearchParams.pageNum = 1; // 重置到第一页
        searchResources();
        fetchAllResourceCategoryCounts();
    }
    // △▽▲▼
    // 更新排序按钮状态
    function updateSortButtons() {
        const fields = ['resourceid', 'resourceprice', 'resourcedate'];
        fields.forEach(field => {
            const span = document.getElementById(field + 'Sort');
            if (field === currentSearchParams.orderBy) {
                span.textContent = currentSearchParams.orderDirect === 'asc' ? '▲▽' : '△▼';
            } else {
                span.textContent = '△▽';
            }
        });
    }
    // 更新分类标签数字的函数
    function updateCategoryBadges(total) {
        // 获取当前激活的分类项
        const activeItem = document.querySelector('#resourceCategoryFilter .list-group-item.active');
        if (!activeItem) return;

        // 获取当前分类ID（全部资源为空字符串）
        const currentCategory = activeItem.getAttribute('data-category') || '';

        // 更新当前激活分类的数字
        const activeBadge = activeItem.querySelector('.badge');
        if (activeBadge) {
            activeBadge.textContent = total;
            activeBadge.classList.replace('bg-secondary', 'bg-primary');
        }
    }
    // 定义获取所有资源状态数量的函数
    function fetchAllResourceCategoryCounts() {
        $.ajax({
            url: '/user/resource/category_counts',
            type: 'POST',
            dataType: 'json',
            data: {
                auditstatus: currentSearchParams.auditstatus,
                searchKey: currentSearchParams.searchKey,
            },
            success: function (response) {
                if (response.code === 0) {
                    updateAllResourceCategoryBadges(response.obj.data);
                }
            },
            error: function (xhr, status, error) {
                console.error('获取资源状态数量失败:', error);
            }
        });
    }
    // 更新所有资源状态的 badge 数字
    function updateAllResourceCategoryBadges(counts) {
        console.log(counts);
        const categoryCounts = {};
        // 遍历响应数据，将资源状态和对应的数量存入 statusCounts 对象
        counts.forEach(item => {
            const category = item.categoryid === -1 ? '' : item.categoryid;
            categoryCounts[category] = item.count;
        });

        const categoryItems = document.querySelectorAll('#resourceCategoryFilter .list-group-item');
        categoryItems.forEach(item => {
            const category = item.getAttribute('data-category') || '';
            const badge = item.querySelector('.badge');
            if (badge) {
                // 根据资源状态获取对应的数量，如果不存在则默认为 0
                const count = categoryCounts[category] || 0;
                badge.textContent = count;
                if (item.classList.contains('active')) {
                    badge.classList.replace('bg-secondary', 'bg-primary');
                } else {
                    badge.classList.replace('bg-primary', 'bg-secondary');
                }
            }
        });
    }


</script>

    