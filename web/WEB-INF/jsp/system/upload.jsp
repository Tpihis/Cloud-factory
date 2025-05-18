<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/5/17
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/system/uploadFile"
      enctype="multipart/form-data"
      method="post">
  <input type="file" name="fileName">
  <input type="submit" value="提交">
</form>
<h2>同一类别多个文件上传</h2>
<form action="${pageContext.request.contextPath}/system/multiUploadFile" method="post" enctype="multipart/form-data">
  文件：
  <input type="file" name="fileName"><br>
  <input type="file" name="fileName"><br>
  <input type="file" name="fileName"><br>
  <input type="file" name="fileName"><br>
  <input type="submit" value="提交">
</form>
<h2>个人信息上传</h2>
<form name="onfile"  action="${pageContext.request.contextPath}/system/complexUploadFile" method="post" enctype="multipart/form-data">
  姓名：<input type="text" name="name" ><br>
  年龄：<input type="text" name="age"> <br>
  图片：<input type="file" name="img">
  <input type="file" name="img">
  简历：<input type="file" name="resume"><br>
  <input type="submit" value="提交">
</form>
<a href="${pageContext.request.contextPath}/system/files">进入文件列表</a>
</body>
</html>
