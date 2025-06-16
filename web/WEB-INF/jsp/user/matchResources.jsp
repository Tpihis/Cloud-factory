<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 资源分配</title>
    <script src="${pageContext.request.contextPath}/static/Custom/js/toast.js"></script>
    <script src="${pageContext.request.contextPath}/static/Custom/js/modal.js"></script>
    <link href="${pageContext.request.contextPath}/static/Custom/css/toast.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-bg: #343a40;
            --success-color: #28a745;
            --warning-color: #ffc107;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 25px;
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

        .section-container:hover {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e9ecef;
        }

        .section-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--dark-bg);
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .subtask-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 15px;
        }

        .subtask-card {
            flex: 0 0 calc(50% - 20px);
            background: linear-gradient(to right, #ffffff, #e5f1ff);
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            position: relative;
            border: 1px solid #e0e7ff;
        }

        .subtask-card:hover {
            transform: translateY(-7px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.2);
        }

        .subtask-id {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--primary-color);
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1rem;
        }

        .subtask-name {
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 12px;
            color: var(--dark-bg);
            padding-bottom: 10px;
            border-bottom: 1px dashed #dee2e6;
        }

        .subtask-detail {
            display: flex;
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .detail-label {
            width: 130px;
            font-weight: 600;
            color: #495057;
        }

        .detail-value {
            flex: 1;
            font-weight: 500;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .status-待完成 { background-color: #fff3cd; color: #856404; }
        .status-已完成 { background-color: #d4edda; color: #155724; }
        .status-已取消 { background-color: #f8d7da; color: #721c24; }

        .action-section {
            text-align: center;
            padding: 25px 0;
        }

        .auto-allocate-btn {
            padding: 12px 35px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .auto-allocate-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(52, 152, 219, 0.4);
        }

        .auto-allocate-btn:active {
            transform: translateY(0);
        }

        .auto-allocate-btn:disabled {
            background: #cccccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .no-task-section {
            text-align: center;
            padding: 40px 20px;
        }

        .no-task-icon {
            font-size: 4rem;
            color: #ced4da;
            margin-bottom: 20px;
        }

        .no-task-text {
            font-size: 1.2rem;
            color: #6c757d;
            margin-bottom: 25px;
        }

        .select-task-btn {
            padding: 10px 30px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .select-task-btn:hover {
            background-color: var(--secondary-color);
        }

        .resource-container {
            margin-top: 20px;
        }

        .resource-group.removing {
            opacity: 0;
        }
        .resource-group {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
            border-left: 4px solid var(--success-color);
            transition: all 0.3s ease;
        }

        .resource-group:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transform: translateX(5px);
        }

        .resource-card {
            flex: 0 0 calc(20% - 15px);
            background: #f8f9fa;
            border-radius: 6px;
            padding: 15px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }
        .demand-badge {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: #6a6c64;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }
        .resource-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background-color: var(--primary-color);
        }

        .resource-name {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--dark-bg);
            font-size: 1rem;
        }

        .resource-detail {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 5px;
        }

        .resource-price {
            font-weight: 600;
            color: var(--accent-color);
            font-size: 0.95rem;
            margin-top: 5px;
        }

        .resource-actions {
            flex: 0 0 20%;
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding-left: 15px;
            border-left: 1px solid #eee;
        }

        .action-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .select-btn {
            background-color: var(--primary-color);
            color: white;
        }

        .select-btn:hover {
            background-color: var(--secondary-color);
        }

        .view-btn {
            background-color: #e9ecef;
            color: var(--dark-bg);
        }

        .view-btn:hover {
            background-color: #dee2e6;
        }

        .group-header {
            width: 100%;
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #dee2e6;
        }

        .group-title {
            font-weight: 600;
            color: var(--dark-bg);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .group-cost {
            font-weight: 600;
            color: var(--accent-color);
            font-size: 1.1rem;
        }

        .loading-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .spinner {
            width: 3rem;
            height: 3rem;
            border: 4px solid rgba(0, 0, 0, 0.1);
            border-left-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .result-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .result-info {
            display: flex;
            gap: 15px;
            font-size: 0.95rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 5px;
            background: #f1f8ff;
            padding: 6px 12px;
            border-radius: 20px;
        }

        .info-item i {
            color: var(--primary-color);
        }

        .info-value {
            font-weight: 600;
        }

        @media (max-width: 992px) {
            .subtask-card {
                flex: 0 0 100%;
            }
            
            .resource-card {
                flex: 0 0 calc(33.333% - 15px);
            }
        }

        @media (max-width: 768px) {
            .resource-card {
                flex: 0 0 calc(50% - 15px);
            }
            
            .resource-actions {
                flex: 0 0 100%;
                flex-direction: row;
                padding-left: 0;
                padding-top: 15px;
                border-left: none;
                border-top: 1px solid #eee;
            }
        }

        @media (max-width: 576px) {
            .section-container {
                padding: 15px;
            }
            
            .resource-card {
                flex: 0 0 100%;
            }
            
            .result-info {
                flex-direction: column;
                gap: 8px;
            }
        }
        /* 小眼睛图标样式 */
        .resource-eye {
            margin-left: 8px;
            color: var(--primary-color);
            cursor: pointer;
            font-size: 0.9em;
            transition: all 0.2s ease;
        }

        .resource-eye:hover {
            color: var(--secondary-color);
            transform: scale(1.1);
        }

        /* 工具提示增强（可选） */
        [title] {
            position: relative;
        }

        [title]:hover:after {
            content: attr(title);
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            white-space: nowrap;
            z-index: 10;
        }
        .Allocate-resources {
            flex: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 子任务区域 -->
        <div class="section-container" id="subtasks-section">
            <div class="section-header">
                <h2 class="section-title"><i class="bi bi-list-task"></i>子任务列表</h2>
                <div id="task-info"></div>
            </div>
            
            <div class="subtask-container" id="subtasks-container">
                <!-- 子任务卡片将由JS动态生成 -->
            </div>
            
            <div class="no-task-section" id="no-task-section" style="display: none;">
                <div class="no-task-icon">
                    <i class="bi bi-folder-x"></i>
                </div>
                <p class="no-task-text">未选择任务，请先选择任务进行资源分配</p>
                <button class="select-task-btn" id="select-task-btn">选择任务</button>
            </div>
        </div>
        
        <!-- 操作按钮区域 -->
        <div class="section-container action-section">
            <button class="auto-allocate-btn" id="auto-allocate-btn" disabled>
                <i class="bi bi-cpu"></i>自动分配资源
            </button>
        </div>
        
        <!-- 资源分配结果区域 -->
        <div class="section-container" id="results-section">
            <div class="result-header">
                <h2 class="section-title"><i class="bi bi-boxes"></i>资源分配结果</h2>
                <div class="result-info">
                    <div class="info-item">
                        <i class="bi bi-check-circle"></i>
                        <span>已分配:</span>
                        <span class="info-value" id="allocated-count">0</span>
                    </div>
                    <div class="info-item">
                        <i class="bi bi-clock"></i>
                        <span>预计耗时:</span>
                        <span class="info-value" id="estimated-time">0小时</span>
                    </div>
                    <div class="info-item">
                        <i class="bi bi-currency-exchange"></i>
                        <span>总成本:</span>
                        <span class="info-value" id="total-cost">¥0</span>
                    </div>
                </div>
            </div>
            
            <div id="resource-results">
                <!-- 资源分配结果将由JS动态生成 -->
            </div>
            
            <div class="loading-container" id="loading-section" style="display: none;">
                <div class="spinner"></div>
            </div>
            
            <div class="no-task-section" id="no-results-section" style="display: block;">
                <div class="no-task-icon">
                    <i class="bi bi-database-exclamation"></i>
                </div>
                <p class="no-task-text">暂无分配结果，请点击"自动分配资源"按钮开始分配</p>
            </div>
        </div>
    </div>

    <script>
        // 获取DOM元素
        // 子任务容器
        const subtasksContainer = document.getElementById('subtasks-container');
        // 无任务提示
        const noTaskSection = document.getElementById('no-task-section');
        // 自动分配按钮
        const autoAllocateBtn = document.getElementById('auto-allocate-btn');
        // 资源分配结果容器
        const resourceResults = document.getElementById('resource-results');
        // 加载中容器
        const noResultsSection = document.getElementById('no-results-section');
        // 结果统计信息
        const loadingSection = document.getElementById('loading-section');
        const taskInfo = document.getElementById('task-info');
        const selectTaskBtn = document.getElementById('select-task-btn');

        // 从URL获取任务ID
        function getTaskIdFromUrl() {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get('taskId');
        }

        // 获取任务数据
        function fetchTaskData(taskId) {
            return fetch('/user/task/subtask/getSubtasksByTaskId?taskId='+taskId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('HTTP错误! 状态码: '+response.status);
                    }
                    return response.json();
                })
                .then(result => {
                    if (result.code === 200 && result.obj) {
                        return result.obj;
                    }
                    throw new Error(result.msg || '获取子任务数据失败');
                });
        }

        // 渲染子任务时,保留每个子任务的名称和数量
        let subtasks_name_count = [];
        // flag：是否有已分配资源
        let flag = false;

        // 渲染子任务卡片
        function renderSubtasks(subtasks) {
            subtasksContainer.innerHTML = '';
            subtasks_name_count = []; // 重置数组

            subtasks.forEach(subtask => {
                subtasks_name_count.push({
                    name: subtask.subtaskname,
                    count: Number(subtask.resourcequantities)
                });
                if (subtask.resourceids !== null) {
                    flag = true;
                }

                const card = document.createElement('div');
                card.className = 'subtask-card';
                card.innerHTML = ''+
                    '<div class="subtask-id">'+ subtask.subtaskid + '</div>'+
                    '<div class="subtask-name">'+ subtask.subtaskname + '</div>'+
                    '<div class="subtask-detail">'+
                    '    <div class="detail-label">状态：</div>'+
                    '    <div class="detail-value"><span class="status-badge status-'+ subtask.subtaskstatus + '">'+ subtask.subtaskstatus + '</span></div>'+
                    '</div>'+
                    '<div class="subtask-detail">'+
                    '    <div class="detail-label">资源要求：</div>'+
                    '    <div class="detail-value">'+ subtask.resourcerequirements + '</div>'+
                    '</div>'+
                    '<div class="subtask-detail">'+
                    '    <div class="detail-label">预计时间：</div>'+
                    '    <div class="detail-value">'+ subtask.estimatedtime + '</div>'+
                    '</div>'+
                    // '<div class="subtask-detail">'+
                    // '    <div class="detail-label">分配资源：</div>'+
                    // '    <div class="detail-value" style="flex: none">'+ (subtask.resourceids === null ? '--' : subtask.resourceids) + '</div>'+
                    // '    <i class="bi bi-eye-fill resource-eye" title="数字为资源ID，点击查看详情"></i>' +
                    // '</div>'+
                    '<div class="subtask-detail">'+
                    '    <div class="detail-label">分配资源：</div>'+
                    '    <div class="detail-value" style="flex: none">'+ (subtask.resourceids === null ? '--' : subtask.resourceids +
                        ' <i class="bi bi-eye-fill resource-eye" title="数字为资源ID，点击查看详情" onclick="window.location.href=\'/user/resource/details?resourceId='+subtask.resourceids+'\'"></i>') + '</div>'+
                    '</div>'+
                    '<div class="subtask-detail">'+
                    '    <div class="detail-label">资源数量：</div>'+
                    '    <div class="detail-value">'+ (subtask.resourcequantities === null ? '--' : subtask.resourcequantities) + '</div>'+
                    '</div>'
                ;
                subtasksContainer.appendChild(card);
            });

            // 更新任务信息
            taskInfo.innerHTML =
                '<div class="info-item">'+
                '    <i class="bi bi-list-ol"></i>'+
                '    <span>子任务数:</span>'+
                '    <span class="info-value">'+ subtasks.length + '</span>'+
                '</div>'
            ;
        }

        // 自动分配资源
        function allocateResources() {
            return fetch('/user/task/subtask/autoAllocateResources', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(subtasks_name_count)
            })
                .then(response => response.json())
                .then(result => {
                    if (result.code === 200 && result.obj) {
                        return result.obj;
                    }
                    throw new Error(result.msg || '资源分配失败');
                });
        }

        // 获取资源类型
        function getResourceType(categoryid) {
            switch (categoryid) {
                case 1: return '设备资源';
                case 2: return '工艺知识';
                case 3: return '设计模型';
                case 4: return '制造服务';
                default: return '未知';
            }
        }

        // 获取资源状态
        function getResourceStatus(resourcestatus) {
            switch (resourcestatus) {
                case '1': return '繁忙';
                case '2': return '空闲';
                case '3': return '损坏';
                default: return '未知';
            }
        }

        // 渲染资源分配结果
        function renderResourceAllocations(allocations) {
            resourceResults.innerHTML = '';
            let totalCost = 0;
            let maxCost = 0;
            let minCost = 0;
            let maxTime = 0;

            allocations.forEach(group => {
                totalCost += group.cost;
                const cost = parseFloat(group.cost);
                if (cost > maxCost) maxCost = cost;
                if (minCost === 0) minCost = cost;
                if (cost < minCost) minCost = cost;

                const timeHours = parseFloat(group.time);
                if (timeHours > maxTime) maxTime = timeHours;

                const groupElement = document.createElement('div');
                groupElement.className = 'resource-group';
                groupElement.dataset.groupId = group.combinationId; // 设置data属性

                var groupHTML = '<div class="group-header">';
                groupHTML += '<div class="group-title">';
                groupHTML += '<i class="bi bi-collection"></i>';
                groupHTML += '<span>资源组 G' + group.combinationId + '</span>';
                groupHTML += '</div>';
                groupHTML += '<div class="group-cost">¥' + group.cost.toLocaleString() + '</div>';
                groupHTML += '</div>';
                groupHTML += '<div class="resources-container" style="display: flex; flex-wrap: wrap; gap: 15px; width: 100%;">';

                let resourceids =[];
                for (var i = 0; i < group.resources.length; i++) {
                    var resource = group.resources[i];
                    var demand = group.demands[i] || { count: 1 };
                    resourceids.push(resource.resourceid);
                    groupHTML += '<div class="resource-card">';
                    groupHTML += '<div class="demand-badge">×' + demand.count + '</div>';
                    groupHTML += '<div class="resource-name">' + resource.resourcename + '</div>';
                    groupHTML += '<div class="resource-detail"><span class="detail-label">类型:</span> ' + getResourceType(resource.categoryid) + '</div>';
                    groupHTML += '<div class="resource-detail"><span class="detail-label">状态:</span> ' + getResourceStatus(resource.resourcestatus) + '</div>';
                    groupHTML += '<div class="resource-detail"><span class="detail-label">库存:</span> ' + resource.quantity + '</div>';
                    groupHTML += '<div class="resource-price">' + resource.resourceprice + '</div>';
                    groupHTML += '</div>';
                }
                groupHTML += '</div>';
                groupHTML += '<div class="resource-actions">';
                groupHTML += '<button class="action-btn select-btn" onclick="selectResourceGroup([' + resourceids.join(',') + '],' + group.combinationId + ')">';
                groupHTML += '<i class="bi bi-check-lg"></i>选择';
                groupHTML += '</button>';
                groupHTML += '<button class="action-btn view-btn">';
                groupHTML += '<i class="bi bi-eye"></i>查看详情';
                groupHTML += '</button>';
                groupHTML += '</div>';

                groupElement.innerHTML = groupHTML;
                resourceResults.appendChild(groupElement);
            });

            document.getElementById('allocated-count').textContent = allocations.length;
            document.getElementById('estimated-time').textContent = maxTime + '小时';
            document.getElementById('total-cost').textContent = '¥' + minCost.toLocaleString() + ' - ¥' + maxCost.toLocaleString();
        }

        // 加载任务数据并更新UI
        function loadTaskData() {
            const taskId = getTaskIdFromUrl();

            if (taskId) {
                subtasksContainer.innerHTML = '<div class="loading-container"><div class="spinner"></div></div>';

                fetchTaskData(taskId)
                    .then(subtasks => {
                        if (!subtasks) {
                            subtasksContainer.innerHTML = '<div class="alert alert-warning">未找到任务数据</div>';
                            return;
                        }
                        noTaskSection.style.display = 'none';
                        subtasksContainer.style.display = 'flex';
                        renderSubtasks(subtasks);
                        autoAllocateBtn.disabled = false;
                        // 如果flag为true,则请求已分配的资源数据，并渲染数据
                        if (flag) {
                            fetchResourceAllocations(taskId)
                              .then(allocations => {
                                    autoAllocateBtn.disabled = true;
                                    loadingSection.style.display = 'none';
                                    renderResourceAllocations(allocations);
                                    noResultsSection.style.display = 'none';
                                  //   添加已分配标记
                                  const group = document.querySelector('.resource-group');
                                  const selectBtn = group.querySelector('.select-btn');
                                  if (selectBtn) selectBtn.remove();

                                  const groupHeader = group.querySelector('.group-header');
                                  if (groupHeader) {
                                      const successBadge = document.createElement('div');
                                      successBadge.innerHTML = '<span style="color: green;"><i class="bi bi-check-circle-fill"></i> 已分配</span>';
                                      groupHeader.appendChild(successBadge);
                                  }
                                })
                        } else {
                             // 按需绑定自动分配按钮事件
                             autoAllocateBtn.onclick = function () {
                              resourceResults.innerHTML = '';
                              noResultsSection.style.display = 'none';
                              loadingSection.style.display = 'flex';

                              allocateResources()
                                  .then(allocations => {

                                      renderResourceAllocations(allocations);
                                      noResultsSection.style.display = 'none';
                                  })
                                  .catch(error => {
                                      console.error('资源分配失败:', error);
                                      loadingSection.style.display = 'none';
                                      resourceResults.innerHTML = '<div class="alert alert-danger">资源分配失败: ' + error.message + '</div>';
                                  });
                            };
                        }
                    })
                    .catch(error => {
                        console.error('加载任务数据失败:', error);
                        subtasksContainer.innerHTML = '<div class="alert alert-danger">加载任务数据失败</div>';
                    });
            } else {
                subtasksContainer.style.display = 'none';
                noTaskSection.style.display = 'block';
                autoAllocateBtn.disabled = true;

                // 按需绑定选择任务按钮事件
                selectTaskBtn.onclick = function() {
                    const fakeTaskId = 'T1001';
                    // 点击后弹出弹框，获取输入的id
                    new Modal({
                        title: '选择任务',
                        confirmText: '选择',
                        cancelText: '取消',
                        input:true,
                        inputPlaceholder: '请手动输入任务ID',
                        onConfirm: function(inputValue) {
                            // 判断id是否为空，以及数字
                            if (!inputValue) {
                                showToast('任务ID不能为空','error',1500)
                                return false;
                            }
                            if(isNaN(inputValue)) {
                                    showToast('任务ID必须为数字','error',1500)
                                return false;
                            }
                            // 获得当前用户任务id列表，判断当前id是否为当前登录用户的任务id
                            fetch('/user/task/getTaskIdsByUserId')
                                .then(response => response.json())
                                .then(result => {
                                    if (result.code !== 200) {
                                        throw new Error(result.msg || '获取任务ID失败');
                                    }
                                    const taskIds = result.obj;
                                    if (!taskIds.includes(Number(inputValue))) {
                                        showToast('这不是您的任务ID', 'error', 1500)
                                        return false;
                                    } else {
                                        window.history.pushState({}, '', '?taskId=' + inputValue);
                                        console.log('url已更新为:', window.location.href);
                                        loadTaskData();
                                    }
                                });
                        },
                        onCancel: function() {
                            return;
                        }
                    }).show()
                };
            }
        }

        // 选择资源组的函数
        function selectResourceGroup(resourceids,groupId) {
            new Modal({
                title: '系统提示',
                content: '确定要选择这个资源组吗？选择后将为子任务分配这些资源。',
                confirmText: '确定',
                cancelText: '取消',
                onConfirm: function() {
                    const taskId = new URLSearchParams(window.location.search).get('taskId');
                    if (!taskId) {
                        showToast('未找到任务ID','error')
                        return;
                    }

                    fetch('/user/task/subtask/confirmAllocateResources', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        },
                        body: JSON.stringify({
                            taskId: Number(taskId),
                            resourceIds: resourceids.join(',')  // 转为字符串
                        })
                    })
                        .then(response => response.json())
                        .then(result => {
                            if (result.code !== 200) {
                                throw new Error(result.msg || '资源分配失败');
                            }

                            // 获取所有资源组
                            const allGroups = document.querySelectorAll('.resource-group');

                            allGroups.forEach(group => {
                                // 从组元素中提取group-id（假设你在生成HTML时设置了data-group-id属性）
                                const currentGroupId = group.dataset.groupId;

                                // 保留当前选中的组，移除其他组
                                if (currentGroupId !== String(groupId)) {
                                    group.classList.add('removing');
                                    setTimeout(() => group.remove(), 300);
                                } else {
                                    // 对选中的组添加已分配标记
                                    const selectBtn = group.querySelector('.select-btn');
                                    if (selectBtn) selectBtn.remove();

                                    const groupHeader = group.querySelector('.group-header');
                                    if (groupHeader) {
                                        const successBadge = document.createElement('div');
                                        successBadge.innerHTML = '<span style="color: green;"><i class="bi bi-check-circle-fill"></i> 已分配</span>';
                                        groupHeader.appendChild(successBadge);
                                    }
                                }
                            });

                            document.getElementById('allocated-count').textContent = '1';
                            showToast('资源分配成功！', 'success')
                            loadTaskData();
                        })
                        .catch(error => {
                            console.error('资源分配失败:', error);
                            alert('资源分配失败: ' + error.message);
                        });
                },
                onCancel: function() {
                    return;
                }
            }).show();
        }

        // 请求已分配资源数据，并处理成渲染资源函数所需要的格式
        function fetchResourceAllocations(taskId) {
            return fetch('/user/task/subtask/getResourceAllocationsByTaskId?taskId='+taskId)
                .then(response => response.json())
                .then(result => {
                    if (result.code === 200) {
                        const resources = result.obj.resources;
                        const demands = result.obj.demands;
                        let totalCost = 0;

                        // 计算总成本
                        resources.forEach((resource, index) => {
                            totalCost += resource.resourceprice * (demands[index] || 1);
                        });

                        // 构建返回格式
                        return [{
                            combinationId: 1, // 组合ID
                            cost: totalCost.toFixed(2), // 总价保留两位小数
                            time: (Math.random() * 5 + 5).toFixed(2) + "小时", // 随机时间
                            resources: resources.map((resource, index) => ({
                                resourceid: resource.resourceid,
                                resourcename: resource.resourcename,
                                categoryid: resource.categoryid,
                                resourcestatus: resource.resourcestatus,
                                resourceprice: "¥" + resource.resourceprice,
                                quantity: resource.quantity,
                                specs: resource.resourcedescription || "无规格信息"
                            })),
                            demands: demands.map(count => ({ count }))
                        }];
                    } else {
                        throw new Error(result.msg || "获取资源分配失败");
                    }
                });
        }

        // 页面加载时初始化
        loadTaskData();
    </script>
</body>
</html>