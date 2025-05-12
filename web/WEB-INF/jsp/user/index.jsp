<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>普通用户的首页</title>
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
<a href="/user/chat">消息</a>
<a href="/user/resource/display">资源展示</a>
<a href="/user/index">iframe</a>
<a href="${pageContext.request.contextPath}/auth/loginPage">登录</a>
</body>
</html>