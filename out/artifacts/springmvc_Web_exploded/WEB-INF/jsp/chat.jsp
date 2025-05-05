<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/4/23
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<style>

    /* 基础页面样式 */
    body {
        margin: 0; /* 去除默认外边距 */
        font-family: "Microsoft YaHei", sans-serif; /* 设置字体为微软雅黑，备用无衬线字体 */
        background: #f2f3f5; /* 设置浅灰色背景 */
    }

    /* 外层包裹容器 */
    .wrapper {
        display: flex; /* 使用弹性布局 */
        justify-content: center; /* 水平居中 */
        margin-top: 100px;
        padding: 30px; /* 内边距30像素 */
    }

    /* 主内容容器 */
    .container {
        display: flex; /* 弹性布局 */
        width: 60%; /* 宽度占父元素60% */
        min-width: 900px; /* 最小宽度900像素 */
        height: 600px; /* 固定高度600像素 */
        background-color: #fff; /* 白色背景 */
        border-radius: 8px; /* 圆角8像素 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 添加轻微阴影效果 */
        overflow: hidden; /* 隐藏溢出内容 */
    }

    /* 左侧边栏样式 */
    .sidebar {
        width: 20%; /* 固定宽度200像素 */
        background-color: #ffffff; /* 白色背景 */
        border-right: 1px solid #ddd; /* 右侧灰色边框 */

        padding: 10px; /* 内边距10像素 */
    }

    /* 搜索框样式 */
    .search-box {
        width: 100%; /* 宽度100%填充父元素 */
        padding: 8px; /* 内边距8像素 */
        border: 1px solid #ccc; /* 浅灰色边框 */
        border-radius: 5px; /* 圆角5像素 */
    }

    /* 联系人列表容器 */
    .contacts {

        list-style: none; /* 去除列表默认样式 */
        padding: 0; /* 去除内边距 */
        margin-top: 15px; /* 上外边距15像素 */
    }

    /* 单个联系人样式 */
    .contact {
        border-radius: 8px; /* 圆角8像素 */
        padding: 10px; /* 内边距10像素 */
        border-bottom: 1px solid #eee; /* 底部浅灰色边框 */
        cursor: pointer; /* 鼠标悬停时显示手型指针 */
    }

    /* 选中状态的联系人样式 */
    .contact.selected {
        background-color: #e6f7ff; /* 浅蓝色背景 */
        font-weight: bold; /* 加粗字体 */
    }

    /* 聊天区域主容器 */
    .chat-area {
        flex: 1; /* 弹性扩展填充剩余空间 */
        display: flex; /* 弹性布局 */
        flex-direction: column; /* 垂直排列子元素 */
        /*padding: 0 10px; /* 左右内边距10像素 */
    }

    /* 聊天头部区域 */
    .chat-header {
        padding: 15px; /* 内边距15像素 */
        border-bottom: 1px solid #ddd; /* 底部灰色边框 */
        background-color: #f9f9f9; /* 浅灰色背景 */
        font-weight: bold; /* 加粗字体 */
    }

    /* 聊天内容区域 */
    .chat-content {
        flex: 1; /* 弹性扩展填充剩余空间 */
        padding: 15px 10px; /* 内边距 */
        overflow-y: auto; /* 垂直方向溢出时显示滚动条 */
        position: relative; /* 相对定位 */
    }

    /* 消息基础样式 */
    .message {
        margin: 10px 10px; /* 上下外边距10像素 */
        padding: 12px; /* 内边距12像素 */
        border-radius: 10px; /* 圆角10像素 */
        max-width: 80%; /* 最大宽度80% */
        position: relative; /* 相对定位 */
    }

    /* 发送方消息样式 */
    .sender {
        background-color: #e6f7ff; /* 浅蓝色背景 */
        align-self: flex-start; /* 靠左对齐 */
        margin-left: 5px; /* 左外边距5像素 */
    }

    /* 接收方消息样式 */
    .receiver {
        background-color: #fffbe6; /* 浅黄色背景 */
        align-self: flex-end; /* 靠右对齐 */
        margin-right: 10px; /* 右外边距5像素 */
        margin-left: auto;
    }

    /* 消息文本样式 */
    .text {
        margin-bottom: 5px; /* 下外边距5像素 */
    }

    /* 消息时间戳样式 */
    .time {
        font-size: 12px; /* 字体大小12像素 */
        color: #888; /* 灰色文字 */
        text-align: right; /* 右对齐 */
    }

    /* 系统消息样式 */
    .system-message {
        background-color: #f0f5ff; /* 淡蓝色背景 */
        color: #1d39c4; /* 深蓝色文字 */
        padding: 8px 12px; /* 内边距 */
        border-left: 4px solid #2f54eb; /* 左侧蓝色边框 */
        margin-bottom: 15px; /* 下外边距15像素 */
        font-size: 14px; /* 字体大小14像素 */
        border-radius: 5px; /* 圆角5像素 */
    }

    /* 聊天输入区域 */
    .chat-input {
        padding: 10px; /* 内边距10像素 */
        display: flex; /* 弹性布局 */
        border-top: 1px solid #ddd; /* 顶部灰色边框 */
        background-color: #f7f7f7; /* 浅灰色背景 */
    }

    /* 输入文本框样式 */
    .chat-input textarea {
        flex: 1; /* 弹性扩展填充剩余空间 */
        padding: 8px; /* 内边距8像素 */
        resize: none; /* 禁止调整大小 */
        border: 1px solid #ccc; /* 浅灰色边框 */
        border-radius: 5px; /* 圆角5像素 */
        height: 40px; /* 高度40像素 */
    }

    /* 发送按钮样式 */
    .send-btn {
        margin-left: 10px; /* 左外边距10像素 */
        padding: 8px 16px; /* 内边距 */
        background-color: #2f54eb; /* 蓝色背景 */
        color: white; /* 白色文字 */
        border: none; /* 无边框 */
        border-radius: 5px; /* 圆角5像素 */
        cursor: pointer; /* 手型指针 */
    }

    /* 右侧信息面板 */
    .info-panel {
        width: 22%; /* 固定宽度220像素 */
        background-color: #ffffff; /* 白色背景 */
        border-left: 1px solid #ddd; /* 左侧灰色边框 */
        padding: 15px; /* 内边距15像素 */
    }

    /* 信息面板头部 */
    .info-header {
        font-weight: bold; /* 加粗字体 */
        margin-bottom: 10px; /* 下外边距10像素 */
    }

    /* 任务信息区域 */
    .task-info p {
        margin: 5px 0; /* 上下外边距5像素 */
    }

    /* 操作按钮区域 */
    .actions {
        margin-top: 20px; /* 上外边距20像素 */
    }

    /* 操作按钮样式 */
    .actions .btn {
        display: block; /* 块级元素 */
        width: 100%; /* 宽度100% */
        padding: 8px; /* 内边距8像素 */
        margin-bottom: 10px; /* 下外边距10像素 */
        background-color: #2f54eb; /* 蓝色背景 */
        color: white; /* 白色文字 */
        border: none; /* 无边框 */
        border-radius: 5px; /* 圆角5像素 */
        cursor: pointer; /* 手型指针 */
    }

    /* 发送方消息气泡效果 */
    .sender::before {
        content: ''; /* 伪元素内容 */
        position: absolute; /* 绝对定位 */
        left: -10px; /* 向左偏移10像素 */
        top: 15px; /* 向下偏移15像素 */
        border-width: 10px 10px 10px 0; /* 边框宽度 */
        border-style: solid; /* 实线边框 */
        border-color: transparent #e6f7ff transparent transparent; /* 透明边框，右侧蓝色 */
    }

    /* 接收方消息气泡效果 */
    .receiver::after {
        content: ''; /* 伪元素内容 */
        position: absolute; /* 绝对定位 */
        right: -10px; /* 向右偏移10像素 */
        top: 15px; /* 向下偏移15像素 */
        border-width: 10px 0 10px 10px; /* 边框宽度 */
        border-style: solid; /* 实线边框 */
        border-color: transparent transparent transparent #fffbe6; /* 透明边框，左侧黄色 */
    }
</style>

<head>
    <title>云制造资源工厂 - 沟通平台</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
<div class="wrapper">
    <div class="container">
        <!-- 左侧联系人列表 -->
        <div class="sidebar">
            <input type="text" class="search-box" placeholder="搜索联系人"/>
            <ul class="contacts">
                <li class="contact selected">智能制造服务商A</li>
                <li class="contact">设备供应商B</li>
                <li class="contact">调度中心C</li>
            </ul>
        </div>

        <!-- 中间聊天区域 -->
        <div class="chat-area">
            <div class="chat-header">资源协同对话 - 智能制造服务商A</div>
            <div class="chat-content">
                <div class="system-message">【系统通知】任务单 #XZ-20415 已匹配资源，等待确认。</div>

                <div class="message sender">
                    <div class="text">您好，我们需要一套5轴加工中心的资源报价。</div>
                    <div class="time">2025-04-23 10:12</div>
                </div>

                <div class="message receiver">
                    <div class="text">附件为设备报价及交期安排，请查收。</div>
                    <div class="time">2025-04-23 10:15</div>
                </div>
            </div>
            <div class="chat-input">
                <textarea placeholder="请输入内容..."></textarea>
                <button class="send-btn">发送</button>
            </div>
        </div>

        <!-- 右侧任务信息 -->
        <div class="info-panel">
            <div class="info-header">当前任务</div>
            <div class="task-info">
                <p>任务编号：XZ-20415</p>
                <p>状态：待确认</p>
                <p>发布时间：2025-04-22</p>
            </div>
            <div class="actions">
                <button class="btn">进入资源平台</button>
                <button class="btn">返回资源池</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>




