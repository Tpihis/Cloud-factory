<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理员用户的首页</title>
</head>
<body>
<h1>管理员用户</h1>
<sec:authentication property="principal.username" var="username"/>
<p>用户名: ${username}</p>
<%--<p>用户名: ${loginUser.username}</p>--%>
<sec:authentication property="principal.password" var="password"/>
<p>加密密码: ${password}</p>
<%--<p>加密密码: ${loginUser.password}</p>--%>
<!-- 获取权限列表 -->
<sec:authentication property="principal.authorities" var="authorities"/>
<p>权限列表:</p>
<c:forEach items="${authorities}" var="auth">
    <span class="badge">${auth.authority}</span>
    <br>
</c:forEach>
<br>
<a href="${pageContext.request.contextPath}/logout">退出</a>

</body>
</html>