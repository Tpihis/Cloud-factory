<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/4/8
  Time: 20:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>首页</title>
</head>
<body>
<c:choose>
    <c:when test="${loginUser != null}">
        ${loginUser.username}欢迎进入<br>
        <a href="/user/logout">退出登录</a>
    </c:when>
    <c:otherwise>
        <a href="/user/login">进入登录页面</a>
    </c:otherwise>
</c:choose>
</body>
</html>



