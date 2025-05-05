<%--
  Created by IntelliJ IDEA.
  User: gxf
  Date: 2024/10/18
  Time: 上午10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to bottom, #6a9bd1, #f0e5e5);
            background-size: cover;
            font-family: Arial, sans-serif;
            position: relative;
        }
        .container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 400px;
            text-align: left;
        }
        h1 {
            margin-bottom: 30px;
            font-size: 30px;
            color: #333;
            text-align: center;
        }
        .input-group {
            margin-bottom: 25px;
            position: relative;
        }
        .input-group input[type="text"],
        .input-group input[type="password"],
        .input-group input[type="email"],
        .input-group input[type="tel"] {
            width: 100%;
            padding: 12px;
            padding-left: 5px; /* 给图标留出空间 */
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .role-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
        }
        .role-group label {
            display: flex;
            align-items: center;
            font-size: 16px;
            color: #333;
        }
        .role-group input[type="radio"] {
            margin-right: 8px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .footer {
            margin-top: 25px;
            font-size: 16px;
            color: #007bff;
            text-align: center;
        }
        .platform-title {
            position: absolute;
            top: 20px;
            left: 20px;
            font-size: 40px;
            color: #ADD8E6;
        }
    </style>
</head>
<body>
<div class="platform-title">云制造资源管理平台</div>
<div class="container">
    <h1>用户注册</h1>

<%--    <form action="${pageContext.request.contextPath}/auth/register" method="post">--%>
    <form action="${pageContext.request.contextPath}/auth/register" method="post">
        <div class="input-group">
            <input type="text" name="username" placeholder="用户名..." required>
        </div>
        <div class="input-group">
            <input type="password" name="password" placeholder="密码..." required>
        </div>
        <div class="input-group">
            <input type="email" name="email" placeholder="邮箱...">
        </div>
        <div class="input-group">
            <input type="tel" name="phone" placeholder="手机号...">
        </div>
        <!-- 用户角色单选框 -->
<%--        <div class="role-group">--%>
<%--            <label><input type="radio" name="role" value="requester" required> 需求者</label>--%>
<%--            <label><input type="radio" name="role" value="provider" required> 提供者</label>--%>
<%--        </div>--%>
        <button class="btn" type="submit" value="register">注册</button>
    </form>
    <div class="footer">
        <a href="${pageContext.request.contextPath}/auth/loginPage">已有账号？登录</a>
    </div>
</div>
</body>
</html>