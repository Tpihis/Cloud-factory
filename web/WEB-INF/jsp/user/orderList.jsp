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
                    <input type="text" class="form-control" placeholder="搜索订单...">
                </div>

                <!-- 订单状态筛选 -->
                <div class="filter-group">
                    <div class="sidebar-title">订单状态</div>
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center active">
                            全部订单
                            <span class="badge bg-primary rounded-pill">15</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            待支付
                            <span class="badge bg-secondary rounded-pill">3</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            进行中
                            <span class="badge bg-secondary rounded-pill">8</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            已完成
                            <span class="badge bg-secondary rounded-pill">4</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
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
                <div class="card order-card mb-4">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <div>
                            <span class="fw-bold">订单编号: </span>
                            <span>ORD-20230512-001</span>
                            <span class="ms-3 fw-bold">创建时间: </span>
                            <span>2025-05-12 14:30</span>
                        </div>
                        <span class="order-status status-processing">进行中</span>
                    </div>
                    <div class="card-body">
                        <!-- 订单项目1 -->
                        <div class="order-item d-flex">
                            <div class="flex-shrink-0 me-3">
                                <img src="https://via.placeholder.com/100?text=CNC加工" class="item-img" alt="CNC加工">
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">五轴CNC精密加工服务</h6>
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <small class="text-muted">供应商: 精密机械有限公司</small><br>
                                        <small class="text-muted">数量: 1批次</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold">¥8,500.00</div>
                                        <small class="text-muted">预计完成: 2025-05-20</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 订单项目2 -->
                        <div class="order-item d-flex">
                            <div class="flex-shrink-0 me-3">
                                <img src="https://via.placeholder.com/100?text=3D打印" class="item-img" alt="3D打印">
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">工业级3D打印服务</h6>
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <small class="text-muted">供应商: 创新打印科技</small><br>
                                        <small class="text-muted">数量: 5件</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold">¥3,200.00</div>
                                        <small class="text-muted">预计完成: 2025-05-18</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold me-2">合计: </span>
                                <span class="text-danger fw-bold">¥11,700.00</span>
                            </div>
                            <div>
                                <button class="btn btn-sm btn-outline-primary action-btn me-2">
                                    <i class="bi bi-chat-left-text me-1"></i>联系供应商
                                </button>
                                <button class="btn btn-sm btn-outline-secondary action-btn">
                                    <i class="bi bi-eye me-1"></i>查看详情
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 订单卡片2 -->
                <div class="card order-card mb-4">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <div>
                            <span class="fw-bold">订单编号: </span>
                            <span>ORD-20230505-002</span>
                            <span class="ms-3 fw-bold">创建时间: </span>
                            <span>2025-05-05 09:15</span>
                        </div>
                        <span class="order-status status-completed">已完成</span>
                    </div>
                    <div class="card-body">
                        <!-- 订单项目 -->
                        <div class="order-item d-flex">
                            <div class="flex-shrink-0 me-3">
                                <img src="https://via.placeholder.com/100?text=设计服务" class="item-img" alt="设计服务">
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">机械结构设计服务</h6>
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <small class="text-muted">供应商: 卓越工程设计</small><br>
                                        <small class="text-muted">数量: 1套设计方案</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold">¥6,800.00</div>
                                        <small class="text-success">已完成: 2025-05-10</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold me-2">合计: </span>
                                <span class="text-danger fw-bold">¥6,800.00</span>
                                <span class="ms-3">
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-fill text-warning"></i>
                                </span>
                            </div>
                            <div>
                                <button class="btn btn-sm btn-outline-primary action-btn me-2">
                                    <i class="bi bi-chat-left-text me-1"></i>联系供应商
                                </button>
                                <button class="btn btn-sm btn-outline-secondary action-btn">
                                    <i class="bi bi-eye me-1"></i>查看详情
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 订单卡片3 -->
                <div class="card order-card mb-4">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <div>
                            <span class="fw-bold">订单编号: </span>
                            <span>ORD-20230428-003</span>
                            <span class="ms-3 fw-bold">创建时间: </span>
                            <span>2025-04-28 16:45</span>
                        </div>
                        <span class="order-status status-pending">待支付</span>
                    </div>
                    <div class="card-body">
                        <!-- 订单项目 -->
                        <div class="order-item d-flex">
                            <div class="flex-shrink-0 me-3">
                                <img src="https://via.placeholder.com/100?text=检测服务" class="item-img" alt="检测服务">
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">材料性能检测服务</h6>
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <small class="text-muted">供应商: 材料分析中心</small><br>
                                        <small class="text-muted">数量: 3项检测</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold">¥2,400.00</div>
                                        <small class="text-muted">需在2025-05-01前支付</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold me-2">合计: </span>
                                <span class="text-danger fw-bold">¥2,400.00</span>
                            </div>
                            <div>
                                <button class="btn btn-sm btn-danger action-btn me-2">
                                    <i class="bi bi-credit-card me-1"></i>立即支付
                                </button>
                                <button class="btn btn-sm btn-outline-secondary action-btn me-2">
                                    <i class="bi bi-x-circle me-1"></i>取消订单
                                </button>
                                <button class="btn btn-sm btn-outline-secondary action-btn">
                                    <i class="bi bi-eye me-1"></i>查看详情
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 分页 -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">上一页</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">下一页</a>
                        </li>
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
    // $('.dropdown-menu').on('show.bs.dropdown', function () {
    //     console.log('下拉框已弹出');
    // });
    //
    // $('.dropdown-menu').on('hide.bs.dropdown', function () {
    //     console.log('下拉框已隐藏');
    // });
    // 获取下拉菜单元素
    const dropdownMenu = document.querySelector('.dropdown-menu');

    // 监听下拉菜单的显示事件
    dropdownMenu.addEventListener('show.bs.dropdown', function () {
        console.log('下拉框已弹出');
    });

    // 如果你想同时监听隐藏事件
    dropdownMenu.addEventListener('hide.bs.dropdown', function () {
        console.log('下拉框已隐藏');
    });
</script>