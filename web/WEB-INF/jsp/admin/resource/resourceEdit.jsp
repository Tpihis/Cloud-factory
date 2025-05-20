<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/5/20
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑资源</title>
   <!--[if lt IE 9]>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/html5.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/respond.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/PIE_IE678.js"></script>
   <![endif]-->
   <link href="${pageContext.request.contextPath}/static/assets/css/bootstrap.min.css" rel="stylesheet" />
   <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
   <link href="${pageContext.request.contextPath}/static/assets/css/codemirror.css" rel="stylesheet">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace.min.css" />
   <link rel="stylesheet" href="${pageContext.request.contextPath}/static/Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/font-awesome.min.css" />
   <!--[if IE 7]>
   <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
   <![endif]-->
   <link href="${pageContext.request.contextPath}/static/Widget/icheck/icheck.css" rel="stylesheet" type="text/css" />
   <link href="${pageContext.request.contextPath}/static/Widget/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="page_right_style">
<%--    <div class="type_title">编辑资源</div>--%>
    <form  class="form form-horizontal" id="form-article-add">
        <div class="clearfix cl">
            <label class="form-label col-2"><span class="c-red">*</span>资源名称：</label>
            <div class="formControls col-10"><input type="text" class="input-text"  name="resourcename"></div>
        </div>
        <div class=" clearfix cl">
            <div class="Add_p_s">
                <label class="form-label col-2">所有人ID：</label>
                <div class="formControls col-2"><input type="number" class="input-text"    name="userid"></div>
            </div>
            <div class="Add_p_s">
                <label class="form-label col-2">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</label>
                <div class="formControls col-2"><input type="number" class="input-text"    name="quantity"></div>
            </div>
            <div class="Add_p_s">
                <label class="form-label col-2">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
                <div class="formControls col-2"><span class="select-box">
				<select class="select" name="categoryid">
					<option>请选择</option>
					<option value="1">设备资源</option>
					<option value="2">工艺知识</option>
					<option value="3">设计模型</option>
					<option value="4">制造服务</option>
				</select>
				</span></div>
            </div>
            <div class="Add_p_s">
                <label class="form-label col-2">价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：</label>
                <div class="formControls col-2"><input type="number" class="input-text"  name="resourceprice" >元</div>
            </div>
            <div class="Add_p_s">
                <%--				resourcestatus--%>
                <label class="form-label col-2">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label>
                <div class="formControls col-2"><span class="select-box">
				<select class="select" name="resourcestatus">
					<option>请选择</option>
					<option value="1">繁忙</option>
					<option value="2">空闲</option>
					<option value="3">损坏</option>
				</select>
				</span></div>
            </div>
<%--         资源审核状态  //审核状态 驳回/通过/待审 --%>
            <div class="Add_p_s">
                <label class="form-label col-2">审核状态：</label>
                <div class="formControls col-2"><span class="select-box">
                    <select class="select" name="auditstatus">
                        <option>请选择</option>
                        <option value="通过">通过</option>
                        <option value="驳回">驳回</option>
                        <option value="待审">待审</option>
                    </select>
                </span></div>
            </div>
            <div class="Add_p_s">
                <label class="form-label col-2">添加时间：</label>
                <div class="formControls col-2"><input type="text" class="inline laydate-icon" id="start" name="resourcedate"></div>
            </div>

        </div>
        <div class="clearfix cl">
            <label class="form-label col-2">资源详情：</label>
            <div class="formControls col-10">
                <textarea type="text" name="resourcedescription" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="备注不能为空！" onKeyUp="textarealength(this,200)"></textarea>
                <p class="textarea-numberbar"><em class="textarea-length">0</em>/200</p>
            </div>
        </div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery-1.9.1.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/js/typeahead-bs2.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/layer/layer.js" type="text/javascript" ></script>
<script src="${pageContext.request.contextPath}/static/assets/laydate/laydate.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/ueditor/1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<script src="${pageContext.request.contextPath}/static/js/lrtk.js" type="text/javascript" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.admin.js"></script>
<script type="text/javascript">
    // 日期选择器初始化
    laydate({
        elem: '#start',
        event: 'focus',
        istime: true,           // 启用时间选择
        format: 'YYYY-MM-DD hh:mm:ss',  // 日期时间格式
    });
</script>
</body>
</html>
