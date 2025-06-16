<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- 引入 Font Awesome -->
    <!-- <link rel="stylesheet" href="all.min.css"/> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link href="${pageContext.request.contextPath}/static/Custom/css/signup_in.css" rel="stylesheet">
    <!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
    <title>Document</title>
</head>

<body>
    <div class="container " id="container">
        <div class="form-container sign-up-container">
            <form action="${pageContext.request.contextPath}/auth/register" method="post">
                <h1>创建账户</h1>
                <%--<div class="social-container">
                    <a href="#" class="social"><i class="fa-brands fa-mobile-phone"></i></a>
                    <a href="#" class="social"><i class="fa-brands fa-tiktok"></i></a>
                    <a href="#" class="social"><i class="fa-brands fa-weibo"></i></a>
                </div>
                <span>或使用你的电子邮箱账号注册</span>--%>
                <input type="text" name="username" placeholder="用户名" required/>
                <input type="password" name="password" placeholder="密码" required/>
                <input type="email" name="email" placeholder="电子邮箱地址" />
                <input type="tel" name="phone" placeholder="手机号码" />
                <button>注 册</button>
            </form>
        </div>
        <div class="form-container sign-in-container">
            <form action="${pageContext.request.contextPath}/login" method="post">
                <h1>登 录</h1>
                <!--<div class="social-container">
                    <a href="#" class="social"><i class="fa-brands fa-weixin"></i></a>
                    <a href="#" class="social"><i class="fa-brands fa-tiktok"></i></a>
                    <a href="#" class="social"><i class="fa-brands fa-weibo"></i></a>
                </div>
                <span>或使用您的账户登录</span>-->
                <input type="text" name="username" placeholder="用户名" required/>
                <input type="password" name="password" placeholder="密码" required/>
                <a href="#">忘记密码?</a>
                <button>登 录</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1>欢迎回来！</h1>
                    <p>快来用个人信息登录，保持我们连线~</p>
                    <button class="ghost" id="signIn">去 登 录</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1>您好，朋友！</h1>
                    <p>输入你的个人信息，与我们一起开启新的旅程~</p>
                    <button class="ghost" id="signUp">去 注 册</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const signUpBtn = document.querySelector("#signUp");
        const signInBtn = document.querySelector("#signIn");
        const container = document.querySelector(".container");

        signUpBtn.addEventListener("click", () => {
            console.log("点击了注册按钮");
            container.classList.add("right-panel-active");
        });

        signInBtn.addEventListener("click", () => {
            console.log("点击了登录按钮");
            container.classList.remove("right-panel-active");
        });
    </script>
</body>

</html>