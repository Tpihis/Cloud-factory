<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录界面</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to bottom, #6a9bd1, #f0e5e5);
            font-family: Arial, sans-serif;
            position: relative;
        }
        .container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 60px;
            width: 400px;
            text-align: center;
        }
        h1 {
            margin-bottom: 30px;
            font-size: 30px;
            color: #333;
        }
        .input-group {
            margin-bottom: 25px;
            text-align: left;
            position: relative;
        }
        .input-group input[type="text"],
        .input-group input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            padding-left: 5px;  /* 为了给图标留出空间 */
        }
        .forgot-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 14px;
            color: #007bff;
            cursor: pointer;
            text-decoration: none;
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
        }
        .platform-title {
            position: absolute;
            top: 20px;
            left: 20px;
            font-size: 40px;
            color: #ADD8E6;
        }
        /* 单选框样式 */
        .role-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
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
    </style>
</head>
<body>
<div class="platform-title">云制造资源管理平台</div>
<div class="container">
    <h1>WELCOME</h1>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="input-group">
            <input type="text" id="username" name="username" placeholder="用户名..." required>
        </div>
        <div class="input-group">
            <input type="password" id="password" name="password" placeholder="请输入密码..." required>
<%--            <a href="#" class="forgot-password">忘记密码？</a>--%>
        </div>
<%--        <!-- 关键：添加 CSRF 令牌 -->--%>
<%--        <input type="hidden"--%>
<%--               name="${_csrf.parameterName}"--%>
<%--               value="${_csrf.token}" />--%>
        <button id="login" class="btn" value="Login" >登录</button>
    </form>

    <div class="footer">
<%--        <a href="register">免费注册</a>--%>
        <a href="${pageContext.request.contextPath}/auth/register">免费注册</a>
    </div>
</div>
</body>
</html>
