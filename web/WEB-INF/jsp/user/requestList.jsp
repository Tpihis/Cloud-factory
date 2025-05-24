<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 资源请求管理</title>
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

        .request-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            background-color: white;
        }

        .request-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .request-status {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background-color: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .status-expired {
            background-color: #e2e3e5;
            color: #383d41;
        }

        .request-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }

        .request-item:last-child {
            border-bottom: none;
        }

        .resource-img {
            width: 80px;
            height: 80px;
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

        .requester-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .time-badge {
            font-size: 0.75rem;
            background-color: #f8f9fa;
            padding: 3px 8px;
            border-radius: 10px;
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
            <li class="breadcrumb-item"><a href="#">资源管理</a></li>
            <li class="breadcrumb-item active" aria-current="page">资源请求</li>
        </ol>
    </nav>

    <div class="row">
        <!-- 左侧边栏 -->
        <div class="col-lg-3 mb-4">
            <div class="sidebar">
                <!-- 搜索框 -->
                <div class="search-box mb-4">
                    <i class="bi bi-search"></i>
                    <input type="text" class="form-control" placeholder="搜索请求...">
                </div>

                <!-- 请求状态筛选 -->
                <div class="filter-group">
                    <div class="sidebar-title">请求状态</div>
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center active">
                            全部请求
                            <span class="badge bg-primary rounded-pill">12</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            待处理
                            <span class="badge bg-secondary rounded-pill">5</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            已同意
                            <span class="badge bg-secondary rounded-pill">4</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            已拒绝
                            <span class="badge bg-secondary rounded-pill">2</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            已过期
                            <span class="badge bg-secondary rounded-pill">1</span>
                        </a>
                    </div>
                </div>

                <!-- 筛选条件 -->
                <div class="filter-group">
                    <div class="sidebar-title">筛选条件</div>
                    <div class="mb-3">
                        <div class="filter-title">资源类型</div>
                        <select class="form-select form-select-sm">
                            <option selected>全部类型</option>
                            <option>CNC加工设备</option>
                            <option>3D打印机</option>
                            <option>检测设备</option>
                            <option>设计服务</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <div class="filter-title">时间范围</div>
                        <select class="form-select form-select-sm">
                            <option selected>全部时间</option>
                            <option>今天</option>
                            <option>最近三天</option>
                            <option>最近一周</option>
                            <option>最近一个月</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <div class="filter-title">紧急程度</div>
                        <select class="form-select form-select-sm">
                            <option selected>全部</option>
                            <option>普通</option>
                            <option>加急</option>
                            <option>特急</option>
                        </select>
                    </div>
                </div>

                <!-- 统计信息 -->
                <div class="filter-group">
                    <div class="sidebar-title">请求统计</div>
                    <div class="stats-card">
                        <div class="stats-value">12</div>
                        <div class="stats-label">总请求数</div>
                    </div>
                    <div class="stats-card">
                        <div class="stats-value">75%</div>
                        <div class="stats-label">平均同意率</div>
                    </div>
                    <div class="stats-card">
                        <div class="stats-value">2.3天</div>
                        <div class="stats-label">平均响应时间</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 右侧内容区 -->
        <div class="col-lg-9">
            <!-- 请求列表 -->
            <div class="mb-5">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="section-header m-0">资源请求管理</h4>
                    <div class="d-flex">
                        <select class="form-select form-select-sm me-2" style="width: 140px;">
                            <option selected>按时间排序</option>
                            <option>按紧急程度排序</option>
                            <option>按资源类型排序</option>
                        </select>
                        <button class="btn btn-sm btn-outline-secondary">
                            <i class="bi bi-download me-1"></i>导出
                        </button>
                    </div>
                </div>

                <!-- 请求卡片1 - 待处理 -->
                <div class="card request-card mb-4 border-start border-4 border-warning">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <div>
                            <span class="fw-bold">请求编号: </span>
                            <span>REQ-20230515-001</span>
                            <span class="ms-3 fw-bold">请求时间: </span>
                            <span>2025-05-15 09:30</span>
                            <span class="ms-3 time-badge">
                                <i class="bi bi-clock me-1"></i>剩余12小时
                            </span>
                        </div>
                        <span class="request-status status-pending">待处理</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- 请求资源信息 -->
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="https://via.placeholder.com/100?text=CNC设备" class="resource-img me-3" alt="CNC设备">
                                    <div>
                                        <h6 class="mb-1">五轴CNC加工中心</h6>
                                        <small class="text-muted">设备编号: CNC-2023-005</small><br>
                                        <small class="text-muted">资源类型: CNC加工设备</small>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-calendar me-2 text-muted"></i>
                                        <span>请求使用时间: 2025-05-20 至 2025-05-25</span>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-tags me-2 text-muted"></i>
                                        <span>预计费用: ¥8,500.00</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-exclamation-triangle me-2 text-muted"></i>
                                        <span class="text-warning">紧急程度: 加急</span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 请求方信息 -->
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="https://via.placeholder.com/60?text=用户" class="requester-avatar me-3" alt="请求方">
                                    <div>
                                        <h6 class="mb-1">李制造有限公司</h6>
                                        <small class="text-muted">联系人: 王工程师</small><br>
                                        <small class="text-muted">信用评级: <i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i></small>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-chat-left-text me-2 text-muted"></i>
                                        <span>请求说明: 需要加工一批精密航空零件，材料为钛合金，工期较紧</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-telephone me-2 text-muted"></i>
                                        <span>联系方式: 138****1234</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <button class="btn btn-sm btn-outline-secondary action-btn me-2">
                                    <i class="bi bi-eye me-1"></i>查看资源详情
                                </button>
                                <button class="btn btn-sm btn-outline-primary action-btn me-2">
                                    <i class="bi bi-chat-left-text me-1"></i>联系请求方
                                </button>
                            </div>
                            <div>
                                <button class="btn btn-sm btn-success action-btn me-2">
                                    <i class="bi bi-check-circle me-1"></i>同意请求
                                </button>
                                <button class="btn btn-sm btn-danger action-btn">
                                    <i class="bi bi-x-circle me-1"></i>拒绝请求
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 请求卡片2 - 已同意 -->
                <div class="card request-card mb-4 border-start border-4 border-success">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <div>
                            <span class="fw-bold">请求编号: </span>
                            <span>REQ-20230510-002</span>
                            <span class="ms-3 fw-bold">请求时间: </span>
                            <span>2025-05-10 14:15</span>
                        </div>
                        <span class="request-status status-approved">已同意</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="https://via.placeholder.com/100?text=3D打印机" class="resource-img me-3" alt="3D打印机">
                                    <div>
                                        <h6 class="mb-1">工业级3D打印机</h6>
                                        <small class="text-muted">设备编号: 3DP-2023-008</small><br>
                                        <small class="text-muted">资源类型: 3D打印设备</small>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-calendar me-2 text-muted"></i>
                                        <span>使用时间: 2025-05-15 至 2025-05-17</span>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-tags me-2 text-muted"></i>
                                        <span>实际费用: ¥3,200.00</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-exclamation-triangle me-2 text-muted"></i>
                                        <span>紧急程度: 普通</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="https://via.placeholder.com/60?text=用户B" class="requester-avatar me-3" alt="请求方">
                                    <div>
                                        <h6 class="mb-1">创新设计工作室</h6>
                                        <small class="text-muted">联系人: 张设计师</small><br>
                                        <small class="text-muted">信用评级: <i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></small>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-chat-left-text me-2 text-muted"></i>
                                        <span>请求说明: 打印一批产品原型，材料为ABS塑料</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-telephone me-2 text-muted"></i>
                                        <span>联系方式: 139****5678</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-success mb-3">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-info-circle-fill me-2"></i>
                                <span>您于 2025-05-11 09:30 同意了此请求，已生成订单 ORD-20230511-003</span>
                            </div>
                        </div>
                        
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <button class="btn btn-sm btn-outline-secondary action-btn me-2">
                                    <i class="bi bi-eye me-1"></i>查看订单详情
                                </button>
                                <button class="btn btn-sm btn-outline-primary action-btn">
                                    <i class="bi bi-chat-left-text me-1"></i>联系请求方
                                </button>
                            </div>
                            <div>
                                <button class="btn btn-sm btn-outline-secondary action-btn">
                                    <i class="bi bi-pencil me-1"></i>修改安排
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 请求卡片3 - 已拒绝 -->
                <div class="card request-card mb-4 border-start border-4 border-danger">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <div>
                            <span class="fw-bold">请求编号: </span>
                            <span>REQ-20230505-003</span>
                            <span class="ms-3 fw-bold">请求时间: </span>
                            <span>2025-05-05 16:40</span>
                        </div>
                        <span class="request-status status-rejected">已拒绝</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="https://via.placeholder.com/100?text=检测设备" class="resource-img me-3" alt="检测设备">
                                    <div>
                                        <h6 class="mb-1">材料性能检测仪</h6>
                                        <small class="text-muted">设备编号: TEST-2023-012</small><br>
                                        <small class="text-muted">资源类型: 检测设备</small>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-calendar me-2 text-muted"></i>
                                        <span>请求使用时间: 2025-05-08 至 2025-05-10</span>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-tags me-2 text-muted"></i>
                                        <span>预计费用: ¥2,800.00</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-exclamation-triangle me-2 text-muted"></i>
                                        <span>紧急程度: 普通</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="https://via.placeholder.com/60?text=用户C" class="requester-avatar me-3" alt="请求方">
                                    <div>
                                        <h6 class="mb-1">材料科技公司</h6>
                                        <small class="text-muted">联系人: 刘研究员</small><br>
                                        <small class="text-muted">信用评级: <i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></small>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-chat-left-text me-2 text-muted"></i>
                                        <span>请求说明: 检测新型复合材料力学性能</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-telephone me-2 text-muted"></i>
                                        <span>联系方式: 137****9012</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-danger mb-3">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-info-circle-fill me-2"></i>
                                <span>您于 2025-05-06 10:15 拒绝了此请求，理由: 设备在该时间段已安排维护</span>
                            </div>
                        </div>
                        
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <button class="btn btn-sm btn-outline-secondary action-btn me-2">
                                    <i class="bi bi-eye me-1"></i>查看详情
                                </button>
                                <button class="btn btn-sm btn-outline-primary action-btn">
                                    <i class="bi bi-chat-left-text me-1"></i>联系请求方
                                </button>
                            </div>
                            <div>
                                <button class="btn btn-sm btn-outline-success action-btn">
                                    <i class="bi bi-arrow-repeat me-1"></i>重新考虑
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
<script>
    // 这里可以添加交互逻辑
    document.addEventListener('DOMContentLoaded', function() {
        // 示例：处理同意/拒绝按钮点击
        document.querySelectorAll('.btn-success, .btn-danger').forEach(btn => {
            btn.addEventListener('click', function() {
                const card = this.closest('.request-card');
                const requestId = card.querySelector('.card-header span:nth-child(2)').textContent;
                const action = this.classList.contains('btn-success') ? '同意' : '拒绝';
                
                if(confirm(`确定要${action}请求 ${requestId} 吗？`)) {
                    // 这里应该发送AJAX请求到服务器
                    console.log(`${action}请求: ${requestId}`);
                    
                    // 模拟响应
                    setTimeout(() => {
                        alert(`已成功${action}请求 ${requestId}`);
                        // 实际应用中应该刷新数据或更新UI
                    }, 500);
                }
            });
        });
    });
</script>
</body>
</html>