<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>普通用户的首页</title>
    <script src="${pageContext.request.contextPath}/static/Custom/js/toast.js"></script>
    <script src="${pageContext.request.contextPath}/static/Custom/js/modal.js"></script>
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
<div id="toast-container">
    <button >
        <span onclick="LshowToast('操作成功','success')">操作成功</span>
    </button>
    <button >
        <span onclick="LshowToast('操作失败','error')" >操作失败</span>
    </button>
</div>
<br>
<!--简单弹框-->
<button onclick="new Modal({
    title: '系统提示',
    content: '操作成功完成',
    confirmText: '知道了'
})
.show()">简单弹框</button>
<%--带确认取消的弹框--%>
<button onclick="new Modal({
    title: '系统提示',
    content: '操作成功完成',
    confirmText: '知道了',
    cancelText: '取消',
    onConfirm: function () {
        console.log('点击了确认按钮');
    },
    onCancel: function () {
        console.log('点击了取消按钮');
    }
})
.show()">带确认取消的弹框</button>
<%--带自定义按钮的弹框--%>
<button onclick="new Modal({
    title: '选择操作',
    content: '请选择您要执行的操作:',
    buttons: [
        {
            text: '保存草稿',
            className: 'modal-btn-save',
            handler: function() {
                console.log('保存草稿');
            }
        },
        {
            text: '立即发布',
            className: 'modal-btn-confirm',
            handler: function() {
                console.log('立即发布');
            }
        },
        {
            text: '取消',
            className: 'modal-btn-cancel',
            handler: function() {
                console.log('操作取消');
            }
        }
    ]
}).show();">带自定义按钮的弹框</button>
<%--动态更新内容--%>
<button onclick="const myModal = new Modal({
    title: '加载中',
    content: '正在加载数据，请稍候...'
}).show();

// 模拟异步操作后更新内容
setTimeout(() => {
    myModal.updateContent('数据加载完成！');
}, 2000);">动态更新内容</button>
<%--在iframe中，弹框显示不出来，让父窗口弹出弹框--%>
<button onclick="new Modal({
    title: '系统提示',
    content: '操作成功完成',
    confirmText: '知道了'
})
.show()">在iframe中，弹框显示不出来，让父窗口弹出弹框</button>
<%--可获取输入文本的弹框--%>
<button onclick="new Modal({
    title: '输入框',
    input: true,
    inputPlaceholder: '请输入数字',
    confirmText: '确定',
    cancelText: '取消',
    onConfirm: function (inputValue) {
        // 对输入的值进行验证，必须是数字
        if (isNaN(inputValue)) {
            alert('请输入有效的数字');
            return false;
        }

        console.log('输入的姓名:', inputValue);
    }
}).show();">可获取输入文本的弹框</button>

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