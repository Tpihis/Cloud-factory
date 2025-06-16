<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 任务详情</title>
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

        .task-detail-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 30px;
        }

        .task-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .task-section:last-child {
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

        .subtask-table {
            width: 100%;
            border-collapse: collapse;
        }

        .subtask-table th {
            background-color: #f8f9fa;
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
            color: #495057;
        }

        .subtask-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }

        .subtask-table tr:last-child td {
            border-bottom: none;
        }

        /* 任务状态样式 */
        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        .status-待完成 { background-color: #fff3cd; color: #856404; }
        .status-已完成 { background-color: #d4edda; color: #155724; }
        .status-已取消 { background-color: #f8d7da; color: #721c24; }
        .status-待审 { background-color: #e2e3e5; color: #383d41; }
        .status-通过 { background-color: #d4edda; color: #155724; }
        .status-驳回 { background-color: #f8d7da; color: #721c24; }

        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }

        /* 编辑模式样式 */
        .edit-mode .view-mode {
            display: none !important;
        }

        .edit-mode .edit-field {
            display: block !important;
        }

        .edit-field {
            display: none;
            width: 100%;
        }

        /* 新增样式：禁用编辑的字段 */
        .non-editable-field {
            background-color: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
        }

        .detail-value {
            position: relative;
        }
        .error-message {
            color: red;
            margin-top: 10px;
            display: none;
        }

        .edit-mode .error-message {
            display: block;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <!-- 返回按钮和面包屑导航 -->
    <div class="breadcrumb-container">
        <div class="back-btn" onclick="history.back()">
            <i class="bi bi-arrow-left"></i>
        </div>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="#">首页</a></li>
                <li class="breadcrumb-item"><a href="#">任务中心</a></li>
                <li class="breadcrumb-item active" aria-current="page">任务详情</li>
            </ol>
        </nav>
    </div>

    <!-- 任务详情主容器 -->
    <div class="task-detail-container" id="taskContainer">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold" id="taskTitle">任务 #</h2>
            <span class="status-badge" id="taskStatusBadge">
                <i class="bi bi-hourglass-split"></i>
                <span id="taskStatusText"></span>
            </span>
        </div>

        <!-- 基本信息部分 -->
        <div class="task-section">
            <h3 class="section-title">
                <i class="bi bi-info-circle"></i>基本信息
            </h3>
            <div class="detail-row">
                <div class="detail-label">任务名称：</div>
                <div class="detail-value">
                    <span class="view-mode" id="taskName"></span>
                    <input type="text" class="edit-field form-control" id="editTaskName">
                </div>
            </div>
            <div class="detail-row">
                <div class="detail-label">任务分类：</div>
                <div class="detail-value">
                    <span class="view-mode badge bg-primary" id="taskCategory"></span>
                    <select class="edit-field form-select" id="editCategoryId">
                        <option value="1">设备任务</option>
                        <option value="2">工艺任务</option>
                        <option value="3">设计任务</option>
                        <option value="4">制造任务</option>
                    </select>
                </div>
            </div>
            <div class="detail-row">
                <div class="detail-label">发布日期：</div>
                <div class="detail-value">
                    <span class="view-mode" id="taskDate"></span>
                    <input type="datetime-local" class="edit-field form-control non-editable-field" id="editTaskDate" disabled>
                </div>
            </div>
            <div class="detail-row">
                <div class="detail-label">完成时间：</div>
                <div class="detail-value">
                    <span class="view-mode" id="completionTime"></span>
                    <input type="datetime-local" class="edit-field form-control" id="editCompletionTime">
                </div>
            </div>
            <div class="detail-row">
                <div class="detail-label">审核状态：</div>
                <div class="detail-value">
                    <span class="view-mode status-badge" id="auditStatusBadge"></span>
                    <select class="edit-field form-select non-editable-field" id="editAuditStatus" disabled>
                        <option value="待审">待审</option>
                        <option value="通过">通过</option>
                        <option value="驳回">驳回</option>
                    </select>
                </div>
            </div>
            <div class="detail-row">
                <div class="detail-label">任务描述：</div>
                <div class="detail-value">
                    <span class="view-mode" id="taskDescription"></span>
                    <textarea class="edit-field form-control" id="editTaskDescription" rows="4"></textarea>
                </div>
            </div>
            <div class="error-message" id="errorMessage"></div>
        </div>

        <!-- 子任务部分 -->
        <div class="task-section" id="subtasksSection" style="display: none;">
            <h3 class="section-title">
                <i class="bi bi-list-task"></i>子任务列表
            </h3>
            <div class="table-responsive">
                <table class="subtask-table">
<%--                    Integer subtaskid;  //子任务ID
Integer taskid;     //任务ID
String subtaskname; //子任务名称
String subtaskstatus;   //子任务状态 1: "待完成", 2: "已完成", 3: "已取消"
String resourcerequirements;    //资源要求
String estimatedtime;    //预计完成时间
String resourceids;    //对应资源列表，用逗号分隔
String resourcequantities;  //对应资源数量列表，用逗号分隔,与资源列表顺序一致--%>
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>名称</th>
                        <th>状态</th>
                        <th>资源要求</th>
                        <th>预计完成时间</th>
                        <th>资源列表</th>
                        <th>资源数量</th>
                    </tr>
                    </thead>
                    <tbody id="subtasksList">
                    </tbody>
                </table>
            </div>
        </div>

        <div class="action-buttons" id="actionButtons">
            <!-- 按钮 -->
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

    // 页面加载完成后获取任务数据并渲染
    document.addEventListener('DOMContentLoaded', function() {
        const taskId = getTaskIdFromUrl();
        if (!taskId) {
            showToast('未找到任务ID', 'error',3000);
            return;
        }

        fetchTaskData(taskId).then(function(task) {
            if (task) {
                renderTaskData(task);
            }
        });
    });

    let currentUserId = null;
    // 从URL中获取任务ID
    function getTaskIdFromUrl() {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get('taskId');
    }

    // 获取任务数据
    async function fetchTaskData(taskId) {
        try {
            const response = await fetch('/user/task/detail?taskId=' + taskId);
            if (!response.ok) {
                throw new Error('网络响应不正常');
            }
            const data = await response.json();
            if (data.code === 200) {
                currentUserId = data.obj.currentUserId;
                return data.obj.task;
            } else {
                throw new Error(data.msg || '获取任务数据失败');
            }
        } catch (error) {
            new Modal({
                title: '错误',
                content: '获取任务数据失败:'+ error.message,
                confirmText: '知道了',
                cancelText: '取消',
            }).show();
            return null;
        }
    }

    // 渲染任务数据
    function renderTaskData(task) {
        if (!task) return;

        // 设置任务基本信息
        document.getElementById('taskTitle').textContent = '任务 #' + task.taskid;
        document.getElementById('taskName').textContent = task.taskname;
        document.getElementById('editTaskName').value = task.taskname;

        // 设置任务分类
        const categoryMap = {
            1: '设备任务',
            2: '工艺任务',
            3: '设计任务',
            4: '制造任务'
        };
        document.getElementById('taskCategory').textContent = categoryMap[task.categoryid] || '未知分类';
        document.getElementById('editCategoryId').value = task.categoryid;

        // 设置日期
        document.getElementById('taskDate').textContent = task.taskdate;
        document.getElementById('editTaskDate').value = task.taskdate;

        // 设置完成时间
        const completionTimeText = task.completiontime ? task.completiontime : '未完成';
        document.getElementById('completionTime').textContent = completionTimeText;
        document.getElementById('editCompletionTime').value = task.completiontime || '';

        // 设置审核状态
        document.getElementById('auditStatusBadge').textContent = task.auditstatus;
        document.getElementById('auditStatusBadge').className = 'view-mode status-badge status-' + task.auditstatus;
        document.getElementById('editAuditStatus').value = task.auditstatus;

        // 设置任务描述
        const descriptionText = task.taskdescription ? task.taskdescription : '无描述';
        document.getElementById('taskDescription').textContent = descriptionText;
        document.getElementById('editTaskDescription').value = task.taskdescription || '';

        // 设置任务状态
        document.getElementById('taskStatusText').textContent = task.taskstatus;
        document.getElementById('taskStatusBadge').className = 'status-badge status-' + task.taskstatus;

        // 设置状态图标
        const statusIconMap = {
            '待接受': 'bi-clock',
            '已完成': 'bi-check-circle',
            '已取消': 'bi-x-circle',
            '待完成': 'bi-hourglass-split'
        };
        const statusIcon = document.querySelector('#taskStatusBadge i');
        statusIcon.className = 'bi ' + (statusIconMap[task.taskstatus] || 'bi-hourglass-split');

        // 渲染子任务
        renderSubtasks(task);

        // 渲染操作按钮
        renderActionButtons(task);
    }

    // 渲染操作按钮
    function renderActionButtons(task) {
        const actionButtons = document.getElementById('actionButtons');
        actionButtons.innerHTML = '';

        // 假设我们从某个地方获取当前用户ID

        if (task.userid == currentUserId) {
            if (task.taskstatus === '待完成') {
                // 编辑按钮
                const editBtn = document.createElement('button');
                editBtn.className = 'btn btn-warning';
                editBtn.id = 'editBtn';
                editBtn.innerHTML = '<i class="bi bi-pencil-square me-2"></i>编辑任务';
                editBtn.onclick = function() { toggleEditMode(true); };
                actionButtons.appendChild(editBtn);

                // 保存和取消按钮（仅编辑模式显示）
                const editControls = document.createElement('div');
                editControls.className = 'edit-controls';
                editControls.style.display = 'none';

                const saveBtn = document.createElement('button');
                saveBtn.className = 'btn btn-primary';
                saveBtn.style = "margin-right: 10px";
                saveBtn.innerHTML = '<i class="bi bi-save me-2"></i>保存';
                saveBtn.onclick = saveTask;
                editControls.appendChild(saveBtn);

                const cancelEditBtn = document.createElement('button');
                cancelEditBtn.className = 'btn btn-secondary';
                cancelEditBtn.innerHTML = '<i class="bi bi-x-circle me-2"></i>取消';
                cancelEditBtn.onclick = function() { toggleEditMode(false); };
                editControls.appendChild(cancelEditBtn);

                actionButtons.appendChild(editControls);

                // 取消任务按钮
                const cancelTaskBtn = document.createElement('button');
                cancelTaskBtn.className = 'btn btn-danger';
                cancelTaskBtn.innerHTML = '<i class="bi bi-x-circle me-2"></i>取消任务';
                cancelTaskBtn.onclick = function() { cancelTask(task.taskid); };
                actionButtons.appendChild(cancelTaskBtn);
                //分解任务按钮
                const decomposeTaskBtn = document.createElement('button');
                decomposeTaskBtn.className = 'btn btn-info';
                decomposeTaskBtn.id = 'decomposeTaskBtn';
                decomposeTaskBtn.innerHTML = '<i class="bi bi-arrow-repeat me-2"></i>分解任务';
                decomposeTaskBtn.onclick = function() { decomposeTask(task.taskid); };
                // 在按钮右方放置灰色小感叹号,鼠标悬浮时显示提示信息
                const warningIcon = document.createElement('i');
                warningIcon.className = 'bi bi-exclamation-circle text-muted ms-2';
                warningIcon.style.cursor = 'help';
                warningIcon.title = '任务审核通过后,24h内不进行分解,将视为取消任务!';
                decomposeTaskBtn.appendChild(warningIcon);
                actionButtons.appendChild(decomposeTaskBtn);
                //去分配资源按钮,默认隐藏
                const allocateResourceBtn = document.createElement('button');
                allocateResourceBtn.className = 'btn btn-primary';
                allocateResourceBtn.id = 'allocateResourceBtn';
                allocateResourceBtn.style.display = 'none';
                allocateResourceBtn.innerHTML = '<i class="bi bi-arrow-right me-2"></i>分配资源';
                allocateResourceBtn.onclick = function() { allocateResource(task.taskid); };
                actionButtons.appendChild(allocateResourceBtn);
            } else if (task.taskstatus === '已完成') {
                const completedBtn = document.createElement('button');
                completedBtn.className = 'btn btn-success';
                completedBtn.disabled = true;
                completedBtn.innerHTML = '<i class="bi bi-check-circle me-2"></i>任务已完成';
                actionButtons.appendChild(completedBtn);
            } else if (task.taskstatus === '已取消') {
                const cancelledBtn = document.createElement('button');
                cancelledBtn.className = 'btn btn-secondary';
                cancelledBtn.disabled = true;
                cancelledBtn.innerHTML = '<i class="bi bi-x-circle me-2"></i>任务已取消';
                actionButtons.appendChild(cancelledBtn);
            }
        } else if (task.taskstatus === '待接受') {
            const acceptBtn = document.createElement('button');
            acceptBtn.className = 'btn btn-primary';
            acceptBtn.innerHTML = '<i class="bi bi-check-circle me-2"></i>接受任务';
            acceptBtn.onclick = function() { acceptTask(task.taskid); };
            actionButtons.appendChild(acceptBtn);
        }
    }


    // 编辑模式状态
    let isEditMode = false;

    // 切换编辑模式
    function toggleEditMode(edit) {
        isEditMode = edit;
        const container = document.getElementById('taskContainer');
        const editControls = document.querySelector('.edit-controls');
        const cancelBtn = document.querySelector('.cancel-btn-container');

        if (edit) {
            container.classList.add('edit-mode');
            if (editControls) editControls.style.display = 'flex';
            const editBtn = document.getElementById('editBtn');
            if (editBtn) editBtn.style.display = 'none';
            if (cancelBtn) {
                cancelBtn.style.display = 'none';
            }
        } else {
            container.classList.remove('edit-mode');
            if (editControls) editControls.style.display = 'none';
            const editBtn = document.getElementById('editBtn');
            if (editBtn) editBtn.style.display = 'inline-block';
            if (cancelBtn) {
                cancelBtn.style.display = 'inline-block';
            }
            hideErrorMessage();
        }

        document.querySelectorAll('.view-mode').forEach(function(el) {
            el.style.display = edit ? 'none' : 'inline';
        });
        document.querySelectorAll('.edit-field').forEach(function(el) {
            el.style.display = edit ? 'block' : 'none';
        });
    }

    // 显示错误消息
    function showErrorMessage(message) {
        const errorElement = document.getElementById('errorMessage');
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }

    // 隐藏错误消息
    function hideErrorMessage() {
        const errorElement = document.getElementById('errorMessage');
        errorElement.style.display = 'none';
    }

    // 保存任务
    function saveTask() {
        const taskId = getTaskIdFromUrl();
        const taskName = document.getElementById('editTaskName').value.trim();
        const categoryId = document.getElementById('editCategoryId').value;
        const taskDate = document.getElementById('editTaskDate').value;
        const completionTime = document.getElementById('editCompletionTime').value;
        const auditStatus = document.getElementById('editAuditStatus').value;
        const taskDescription = document.getElementById('editTaskDescription').value.trim();

        if (taskName === '') {
            showErrorMessage('任务名称不能为空');
            return;
        }

        const subtasks = [];
        const subtaskInputs = document.querySelectorAll('#subtasksList input[type="text"]');
        subtaskInputs.forEach(function(input) {
            if (input.value.trim() !== '') {
                subtasks.push(input.value.trim());
            }
        });

        const taskData = {
            taskid: taskId,
            taskname: taskName,
            categoryid: parseInt(categoryId),
            taskdate: taskDate,
            completiontime: completionTime || null,
            auditstatus: auditStatus,
            taskdescription: taskDescription,
            subtasks: subtasks.join(',')
        };

        fetch('/user/task/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(taskData)
        })
            .then(function(response) {
                if (!response.ok) {
                    throw new Error('网络响应不正常');
                }
                return response.json();
            })
            .then(function(data) {
                if (data.code === 200) {
                    window.parent.showToast('任务更新成功',"success");
                    window.location.reload();
                } else {
                    showErrorMessage('更新失败：' + (data.msg || '操作失败，请重试'));
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showErrorMessage('发生错误，请重试: ' + error.message);
            });
    }

    // 接受任务
    async function acceptTask(taskId) {
        if (!confirm('确定要接受这个任务吗？接受后将开始处理')) return;

        try {
            const response = await fetch('/user/task/accept?taskId=' + taskId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'include'
            });

            const contentType = response.headers.get('content-type');
            if (!contentType || !contentType.includes('application/json')) {
                const text = await response.text();
                throw new Error('期望JSON但收到: ' + text.substring(0, 100));
            }

            const result = await response.json();

            if (result.code === 200 || result.success) {
                window.parent.showToast(result.msg || '任务接受成功！',"success");
                window.location.reload();
            } else {
                throw new Error(result.msg || '接受失败');
            }
        } catch (error) {
            alert('接受任务失败: ' + error.message);
        }
    }

    // 取消任务
    async function cancelTask(taskId) {
        if (!confirm('确定要取消此任务吗？此操作不可撤销')) return;

        try {
            const url = new URL('/user/task/cancel', window.location.origin);
            url.searchParams.append('taskId', taskId);

            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                },
                credentials: 'include'
            });

            const responseText = await response.text();

            let result;
            try {
                result = JSON.parse(responseText);
            } catch (e) {
                throw new Error('响应不是有效的JSON: ' + responseText.substring(0, 100));
            }

            if (result.code === 200 || result.success) {
                window.parent.showToast(result.msg || '任务取消成功！',"success");
                window.location.reload();
            } else {
                throw new Error(result.msg || '取消失败');
            }
        } catch (error) {
            console.error('取消任务完整错误:', {
                error: error.message,
                stack: error.stack
            });
            alert('操作失败: ' + error.message);

            if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
                console.error('完整错误详情:', error);
            }
        }
    }

   function decomposeTask(taskid){
       new Modal({
           title: '系统提示',
           content: '确定要分解此任务吗？此操作不可撤销!',
           confirmText: '确定分解',
           cancelText: '取消',
           onCancel: function () {
                return;
           },
           onConfirm: function () {
               fetch('/user/task/decompose?taskid='+taskid)
                   .then(response => response.json())
                   .then(data => {
                       if (data.code === 200) {
                           window.parent.showToast(data.msg || '任务分解成功！',"success");
                           window.location.reload();
                       }
                   })
           }
       }).show();
    }
//     渲染子任务
    function renderSubtasks(task) {
        if (task.subtasks && task.subtasks.trim() !== '') {
            // 发送请求查询子任务详情
            fetch('/user/task/subtask/detail?taskid='+task.taskid)
               .then(response => response.json())
               .then(data => {
                    if (data.code === 200) {
                        renderSubtasksTable(data.obj);
                    }
                })
        }
    }
    // 渲染子任务表格
    function renderSubtasksTable(subtasks) {
        const subtasksList = document.getElementById('subtasksList');
        subtasksList.innerHTML = '';
        if (!subtasks || subtasks.length === 0) {
            subtasksList.innerHTML = '<tr><td colspan="7" class="text-center">暂无子任务数据</td></tr>';
            document.getElementById('subtasksSection').style.display = 'block';
            return;
        }
        subtasks.forEach(function(subtask, index) {
            const row = document.createElement('tr');
            row.innerHTML = '<td>' + subtask.subtaskid + '</td>' +
                '<td>' +
                '<span class="view-mode">' + subtask.subtaskname + '</span>' +
                '<input type="text" class="edit-field form-control" value="' + subtask.subtaskname + '" id="subtask-' + index + '">' +
                '</td>' +
                '<td>' +
                '<span class="view-mode status-badge status-' + subtask.subtaskstatus + '">' + subtask.subtaskstatus + '</span>' +
                '<select class="edit-field form-select" id="subtaskStatus-' + index + '">' +
                '<option value="待完成" ' + (subtask.subtaskstatus === '待完成' ? 'selected' : '') + '>待完成</option>' +
                '<option value="已完成"'+ (subtask.subtaskstatus === '已完成'?'selected' : '') + '>已完成</option>' +
                '<option value="已取消"'+ (subtask.subtaskstatus === '已取消'?'selected' : '') + '>已取消</option>' +
                '</select>' +
                '</td>' +
                '<td>' +
                '<span class="view-mode">' + subtask.resourcerequirements + '</span>' +
                '<input type="text" class="edit-field form-control" value="' + subtask.resourcerequirements + '" id="subtaskResourceRequirements-' + index + '">' +
                '</td>' +
                '<td>' +
                '<span class="view-mode">' + subtask.estimatedtime + '</span>' +
                '<input type="text" class="edit-field form-control" value="' + subtask.estimatedtime + '" id="subtaskEstimatedTime-' + index + '">' +
                '</td>' +
                '<td>' +
                '<span class="view-mode">' + (subtask.resourceids === null ? '--' : subtask.resourceids) + '</span>' +
                '<input type="text" class="edit-field form-control" value="' + subtask.resourceids + '" id="subtaskResourceIds-' + index + '">' +
                '</td>' +
                '<td>' +
                '<span class="view-mode">' + (subtask.resourcequantities === null ? '--' : subtask.resourcequantities ) + '</span>' +
                '<input type="text" class="edit-field form-control" value="' + subtask.resourcequantities + '" id="subtaskResourceQuantities-' + index + '">' +
                '</td>';
            subtasksList.appendChild(row);
        })
        document.getElementById('subtasksSection').style.display = 'block';
        document.getElementById('decomposeTaskBtn').style.display = 'none';
        document.getElementById('allocateResourceBtn').style.display = 'block';
    }

    function allocateResource(taskid){
    //     带着taskid跳转到分配资源页面
        window.location.href = '/user/task/matchResources?taskId='+taskid;
    }
</script>
</body>
</html>