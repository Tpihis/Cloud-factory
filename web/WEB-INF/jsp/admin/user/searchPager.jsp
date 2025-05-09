<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/5/9
  Time: 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>动态sql语句</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/admin/user/pageList" method="post">
    起始页:<input name="pageNum" type="text"/><br>
    页面大小:<input name="pageSize" type="text"/><br>
    排序字段:<input name="orderBy" type="text"/><br>
    排序方向:<input name="orderDirect" type="text"/><br>
    模糊查询:用户名:<input name="name" type="text"/><br>
    精确查询:电话:<input name="phone" type="text"/><br>
    模糊查询:邮箱:<input name="email" type="text"/><br>
    模糊查询:地址:<input name="address" type="text"/><br>
    模糊查询:关键字:<input name="searchKey" type="text"/><br>
    <input name="提交" type="submit" value="查询"/><br>
</form>

<form action="${pageContext.request.contextPath}/admin/user/totalCount" method="post">
    起始页:<input name="pageNum" type="text"/><br>
    页面大小:<input name="pageSize" type="text"/><br>
    排序字段:<input name="orderBy" type="text"/><br>
    排序方向:<input name="orderDirect" type="text"/><br>
    模糊查询:用户名:<input name="name" type="text"/><br>
    精确查询:电话:<input name="phone" type="text"/><br>
    模糊查询:邮箱:<input name="email" type="text"/><br>
    模糊查询:地址:<input name="address" type="text"/><br>
    模糊查询:关键字:<input name="searchKey" type="text"/><br>
    <input name="提交" type="submit" value="查询"/><br>
</form>

</body>
</html>
