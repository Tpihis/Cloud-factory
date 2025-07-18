<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云制造资源优化平台 - 资源中心 - 资源发布</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="${pageContext.request.contextPath}/static/Custom/js/toast.js"></script>
    <link href="${pageContext.request.contextPath}/static/Custom/css/toast.css">
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

        .resource-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
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

        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .pagination .page-link {
            color: var(--primary-color);
        }

        /* 调整右侧卡片样式 */
        .col-lg-9 .card {
            padding: 30px;
            /* 增加内边距以扩大框的大小 */
        }

        .col-lg-9 .card .mb-3 {
            margin-bottom: 20px;
            /* 增加输入内容之间的间距 */
        }

        .col-lg-9 .task-form button[type="submit"] {
            float: right;
            /* 将发布资源按钮移到右侧 */
            
        }
        .task-form {
            background-color: white;
            border-radius: 10px;
            padding: 50px; /* 增加表单内边距 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
        }

        /* 按钮加载状态 */
        .spinner-border-sm {
            width: 1rem;
            height: 1rem;
            border-width: 0.2em;
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
                <li class="breadcrumb-item active" aria-current="page">资源发布</li>
            </ol>
        </nav>

        <div class="row">

            <!-- 右侧资源发布页面 -->
            <div class="col-lg-9">
                <h4 class="section-header">资源发布</h4>
                <div class="task-form">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/user/resource/publish" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <!-- 资源名称 -->
                                <div class="col-md-6 mb-3">
                                    <label for="resourceName" class="form-label">*资源名称</label>
                                    <input type="text" class="form-control" id="resourceName"  name="resourcename" placeholder="请输入资源的具体名称" required>
                                </div>
                                <!-- 资源所属类别 -->
                                <div class="col-md-6 mb-3">
                                    <label for="category" class="form-label">资源所属类别</label>
                                    <select class="form-select" id="category" name="categoryid">
                                        <option value="1">设备资源</option>
                                        <option value="2">工艺知识</option>
                                        <option value="3">设计模型</option>
                                        <option value="4">制造服务</option>
                                    </select>
                                </div>
                            </div>
                        <%--<div class="row">
                                <!-- 资源工艺类型 -->
                                <div class="col-md-6 mb-3">
                                    <label for="process" class="form-label">资源涉及工艺</label>
                                    <select class="form-select" id="process">
                                        <option>粉末冶金工艺</option>
                                        <option>精密注塑工艺</option>
                                        <option>激光切割工艺</option>
                                        <option>表面处理工艺</option>
                                    </select>
                                </div>
                                <!-- 资源设备类型 -->
                                <div class="col-md-6 mb-3">
                                    <label for="equipment" class="form-label">资源关联设备</label>
                                    <select class="form-select" id="equipment">
                                        <option>3D打印设备</option>
                                        <option>自动化装配设备</option>
                                        <option>无损检测设备</option>
                                        <option>智能仓储设备</option>
                                    </select>
                                </div>
                            </div>--%>
                            <div class="row">
                               <%-- <!-- 资源详细规格 -->
                                <div class="col-md-6 mb-3">
                                    <label for="specification" class="form-label">资源详细规格</label>
                                    <input type="text" class="form-control" id="specification"
                                        placeholder="请详细描述资源的规格，如精度、功率等">
                                </div>--%>
                                <!-- 资源可用数量 -->
                                <div class="col-md-6 mb-3">
                                    <label for="quantity" class="form-label">*资源可用数量</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" placeholder="请输入资源的可用数量" required>
                                </div>
                            </div>
                            <div class="row">
                                <!-- 资源租赁价格 -->
                                <div class="col-md-6 mb-3">
                                    <label for="price" class="form-label">*资源租赁单价（元/天）</label>
                                    <input type="number" class="form-control" id="price" name="resourceprice" placeholder="请输入资源的租赁单价" required>
                                </div>
                                <!-- 资源当前状态 -->
                                <div class="col-md-6 mb-3">
                                    <label for="status" class="form-label">资源当前状态</label>
                                    <select class="form-select" id="status" name="resourcestatus">
                                        <option value="1">繁忙</option>
                                        <option value="2">空闲</option>
                                        <option value="3">损坏</option>
                                    </select>
                                </div>
                            </div>
                            <!-- 资源详细说明 -->
                            <div class="mb-3">
                                <label for="description" class="form-label">资源详细说明</label>
                                <textarea class="form-control" id="description" name="resourcedescription" rows="3"
                                    placeholder="请详细描述资源的特点、优势等"></textarea>
                            </div>
                            <!-- 图片上传部分 -->
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="resourceImages" class="form-label">资源图片(可多选)</label>
                                    <input type="file" class="form-control" id="resourceImages" name="resourceImages" multiple accept="image/*">
                                    <div class="form-text">可上传多张图片展示资源，支持JPG、PNG格式</div>
                                    <!-- 图片预览区域 -->
                                    <div id="imagePreview" class="d-flex flex-wrap mt-2"></div>
                                </div>
                            </div>
                         <%--   <!-- 上传资源资料 -->
                            <div class="mb-3">
                                <label for="Img" class="form-label">上传资源图片</label>
                                <input class="form-control" type="file" id="Img">
                            </div>--%>
                            <!-- 提交按钮 -->
                            <button type="submit" class="btn btn-primary">发布资源</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
<script>
    // 拦截表单提交并处理
    document.querySelector('form').addEventListener('submit', function(event) {
        event.preventDefault(); // 阻止默认表单提交

        // 收集表单数据
        const formData = new FormData(this);
        const imageFiles = document.getElementById('resourceImages').files;
        const jsonData = {};
        formData.forEach((value, key) => {
            // 转换数字类型字段
            if (['quantity', 'resourceprice', 'categoryid', 'resourcestatus'].includes(key)) {
                jsonData[key] = value ? Number(value) : null;
            } else {
                jsonData[key] = value;
            }
        });

        // 显示加载中状态
        const submitBtn = this.querySelector('button[type="submit"]');
        const originalBtnText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> 提交中...';
        submitBtn.disabled = true;

        // 发送AJAX请求
        fetch('${pageContext.request.contextPath}/user/resource/publish', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(Object.fromEntries(formData)),

        })
            .then(response => response.json())
            .then(data => {
                if (data.code === 0) {
                    // 2. 资源创建成功后再上传图片
                    if (imageFiles.length > 0) {
                        const imageFormData = new FormData();
                        for (let i = 0; i < imageFiles.length; i++) {
                            imageFormData.append('fileName', imageFiles[i]);
                        }

                        return fetch('${pageContext.request.contextPath}/system/multiUploadResourceFile?resourceId='+data.obj, {
                            method: 'POST',
                            body: imageFormData
                        });
                    } else {
                        // showToast('无图片上传','error');
                        return Promise.resolve(
                            new Response(
                                JSON.stringify({code: 0, msg: '无图片上传'}),
                                { status: 200, headers: { 'Content-Type': 'application/json' } }
                            )
                        );
                    }
                } else {
                    throw new Error(data.msg || '资源发布失败');
                }
            })
            .then(response => response.json())
            .then(data => {
                // 恢复按钮状态
                submitBtn.innerHTML = originalBtnText;
                submitBtn.disabled = false;

                if (data.code === 0 || data.code === 200) {
                    showToast('资源发布成功', 'success');
                    setTimeout(() => {
                        if (window.opener) {
                            parent.opener.location.reload();
                            window.close();
                        } else {
                            parent.location.reload();
                        }
                    }, 2000);
                } else {
                    showToast(data.msg || '图片上传失败', 'error');
                }
            })
            .catch(error => {
                submitBtn.innerHTML = originalBtnText;
                submitBtn.disabled = false;
                showToast('请求失败: ' + error.message, 'error');
            });
    });

    // 图片预览功能
    document.getElementById('resourceImages').addEventListener('change', function(e) {
        const previewContainer = document.getElementById('imagePreview');
        previewContainer.innerHTML = ''; // 清空之前的预览

        const files = e.target.files;
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            if (!file.type.match('image.*')) continue;

            const reader = new FileReader();
            reader.onload = function(e) {
                const previewDiv = document.createElement('div');
                previewDiv.className = 'position-relative me-2 mb-2';
                previewDiv.style.width = '100px';

                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'img-thumbnail';
                img.style.maxHeight = '100px';

                previewDiv.appendChild(img);
                previewContainer.appendChild(previewDiv);
            };
            reader.readAsDataURL(file);
        }
    });
</script>