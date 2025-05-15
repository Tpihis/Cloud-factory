<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERROR!</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/Custom/css/error1.css">
    <link href="https://fonts.googleapis.com/css2?family=Barlow:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Bungee+Spice&family=Exo+2:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Protest+Strike&display=swap" rel="stylesheet">
    <style>
        /* 新增的错误信息面板样式 */
        .error-panel {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 15px;
            max-height: 40vh;
            overflow-y: auto;
            transform: translateY(100%);
            transition: transform 0.3s ease;
            z-index: 1000;
            border-top: 1px solid #444;
        }

        .error-panel.visible {
            transform: translateY(0);
        }

        .error-toggle {
            position: fixed;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            background: #6c5ce7;
            color: white;
            padding: 8px 15px;
            border-radius: 5px 5px 0 0;
            cursor: pointer;
            z-index: 1001;
            font-family: 'Exo 2', sans-serif;
        }

        .error-detail {
            margin-bottom: 10px;
        }

        .stack-trace {
            font-family: monospace;
            font-size: 12px;
            color: #ddd;
            margin-top: 10px;
        }

        pre {
            margin: 0;
            white-space: pre-wrap;
        }
    </style>
</head>

<%--<body>
&lt;%&ndash;显示详细错误信息&ndash;%&gt;
<div class="error-container" style="height: 100%;overflow: scroll">
    <h1 class="error-header">⚠️ <c:out value="${error}"/></h1>

    <div class="error-detail">
        &lt;%&ndash;            <p><strong>状态码:</strong> <c:out value="${status}"/></p>&ndash;%&gt;
        <p><strong>错误类型:</strong> <c:out value="${exception}"/></p>
        <p><strong>错误信息:</strong> <c:out value="${message}"/></p>
        <p><strong>请求URL:</strong> <c:out value="${url}"/></p>
        <p><strong>发生时间:</strong> <c:out value="${timestamp}"/></p>
    </div>

    <!-- 只在开发环境显示堆栈跟踪 -->
    <c:if test="${not empty stackTrace}">
        <div class="stack-trace">
            <h3>堆栈跟踪:</h3>
            <c:forEach items="${stackTrace}" var="trace">
                <c:out value="${trace}"/><br/>
            </c:forEach>
        </div>
    </c:if>
</div>

</body>--%>
<body class="bg-purple">
    <div class="stars">
        <div class="central-body">
          <p onclick="toggleErrorPanel()"><c:out value="${status}"/></p>
            <a href="/" class="btn-go-home">首页</a>
        </div>
        <div class="objects">
            <img class="object_rocket" src="${pageContext.request.contextPath}/static/Custom/img/rocket.svg" width="40px">
            <div class="earth-moon">
                <img class="object_earth" src="${pageContext.request.contextPath}/static/Custom/img/earth.svg" width="100px">
                <img class="object_moon" src="${pageContext.request.contextPath}/static/Custom/img/moon.svg" width="80px">
            </div>
            <div class="box_ren" onclick="toggleErrorPanel()">
                <img class="object_ren" src="${pageContext.request.contextPath}/static/Custom/img/ren.svg" width="140px">
            </div>
        </div>
        <div class="glowing_stars">
            <div class="star"></div>
            <div class="star"></div>
            <div class="star"></div>
            <div class="star"></div>
            <div class="star"></div>
        </div>
    </div>

    <!-- 错误信息切换按钮 -->
<%--    <div class="error-toggle" onclick="toggleErrorPanel()">显示错误详情</div>--%>

    <!-- 错误信息面板 -->
    <div class="error-panel" id="errorPanel">
        <h3>⚠️ <c:out value="${error}"/></h3>

        <div class="error-detail">
            <p><strong>状态码:</strong> <c:out value="${status}"/></p>
            <p><strong>错误类型:</strong> <c:out value="${exception}"/></p>
            <p><strong>错误信息:</strong> <c:out value="${message}"/></p>
            <p><strong>请求URL:</strong> <c:out value="${url}"/></p>
            <p><strong>发生时间:</strong> <c:out value="${timestamp}"/></p>
        </div>

        <!-- 只在开发环境显示堆栈跟踪 -->
        <c:if test="${not empty stackTrace}">
            <div class="stack-trace">
                <h4>堆栈跟踪:</h4>
                <pre><c:forEach items="${stackTrace}" var="trace"><c:out value="${trace}"/>&#13;&#10;</c:forEach></pre>
            </div>
        </c:if>
    </div>

    <script>
        function toggleErrorPanel() {
            const panel = document.getElementById('errorPanel');
            const toggleBtn = document.querySelector('.error-toggle');

            panel.classList.toggle('visible');

            if (panel.classList.contains('visible')) {
                toggleBtn.textContent = '隐藏错误详情';
            } else {
                toggleBtn.textContent = '显示错误详情';
            }
        }

        // 开发环境默认显示错误面板
/*        if (window.location.href.includes('localhost') || window.location.href.includes('127.0.0.1')) {
            document.addEventListener('DOMContentLoaded', function() {
                toggleErrorPanel();
            });
        }*/
    </script>
</body>
</html>
