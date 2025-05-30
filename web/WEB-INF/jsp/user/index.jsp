<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>普通用户的首页</title>
    <script src="${pageContext.request.contextPath}/static/Custom/js/toast.js"></script>
    <link href="${pageContext.request.contextPath}/static/Custom/css/toast.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

</head>
<body>
<h1>普通用户</h1>
<a href="${pageContext.request.contextPath}/admin/index">进入管理员首页</a>
<br>
<%--<sec:authentication property="principal.username" var="username"/>--%>
<%--<p>用户名: ${username}</p>--%>
<%--<!-- 获取权限列表 -->--%>
<%--<sec:authentication property="principal.authorities" var="authorities"/>--%>
<%--<p>权限列表:</p>--%>
<%--<c:forEach items="${authorities}" var="auth">--%>
<%--    <span class="badge">${auth.authority}</span>--%>
<%--    <br>--%>
<%--</c:forEach>--%>
<a href="${pageContext.request.contextPath}/logout">退出</a>
<a href="${pageContext.request.contextPath}/user/chat">消息</a>
<%--<a href="${pageContext.request.contextPath}/user/index" onclick="requestURL('/user/index')">iframe</a>--%>
<a href="javascript:void(0);" onclick="requestURL('/user/index')">iframe</a>
<%--<a href="${pageContext.request.contextPath}/system/uploadFilePage" onclick="requestURL('/system/uploadFilePage')"> 前往上传页面 </a>--%>
<a href="javascript:void(0);" onclick="requestURL('/system/uploadFilePage')"> 前往上传页面 </a>
<a href="${pageContext.request.contextPath}/auth/loginPage">登录</a>
<%--<div id="toast-container">
    <button >
        <span onclick="LshowToast('操作成功','success')">操作成功</span>
    </button>
    <button >
        <span onclick="LshowToast('操作失败','error')" >操作失败</span>
    </button>
</div>--%>
</body>
<script>
    function LshowToast(message, type = 'success', duration = 1000) {
        showToast(message, type,duration);
    }

    function requestURL(url) {
        window.location.href = url;
    }
</script>
</html>