<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%--    ${pageContext.request.contextPath}--%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="${pageContext.request.contextPath}/static/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>       
        <link href="${pageContext.request.contextPath}/static/assets/css/codemirror.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/font-awesome.min.css" />
		<!--[if IE 7]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace-ie.min.css" />
		<![endif]-->
			<script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>

		<!-- <![endif]-->

		<!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='${pageContext.request.contextPath}/static/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${pageContext.request.contextPath}/static/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${pageContext.request.contextPath}/static/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="${pageContext.request.contextPath}/static/assets/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/static/assets/js/typeahead-bs2.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${pageContext.request.contextPath}/static/assets/js/jquery.dataTables.min.js"></script>
		<script src="${pageContext.request.contextPath}/static/assets/js/jquery.dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.js"></script> 
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.admin.js"></script> 
        <script src="${pageContext.request.contextPath}/static/assets/layer/layer.js" type="text/javascript" ></script>
        <script src="${pageContext.request.contextPath}/static/assets/laydate/laydate.js" type="text/javascript"></script>
<%--        <script src="${pageContext.request.contextPath}/static/assets/laydate/laydate5.3.1.js" type="text/javascript"></script>--%>

<title>任务列表</title>
</head>

<body>
<div class="page-content clearfix">
    <div id="Task_Ratings">
      <div class="d_Confirm_Order_style">
    <div class="search_style">
      <div class="title_names">搜索查询</div>
      <ul class="search_content clearfix">
       <li><label class="l_f">任务名称</label><input name="" type="text"  class="text_add" placeholder="输入任务名称"  style=" width:400px"/></li>
       <li><label class="l_f">添加时间</label><input class="inline laydate-icon" id="start" style=" margin-left:10px;"></li>
       <li style="width:90px;"><button type="button" class="btn_search"><i class="icon-search"></i>查询</button></li>
      </ul>
    </div>
     <!---->
     <div class="border clearfix">
       <span class="l_f">
        <a href="javascript:ovid()" id="task_add" class="btn btn-warning"><i class="icon-plus"></i>添加任务</a>
        <a href="javascript:ovid()" class="btn btn-danger"><i class="icon-trash"></i>批量删除</a>
       </span>
       <span class="r_f">共：<b>2345</b>条</span>
     </div>
     <!---->
     <div class="table_menu_list">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
		<thead>
<%--        taskid;  //任务ID*--%>
<%--        userid;  //用户ID--%>
<%--        taskname;    //任务名称*--%>
<%--        taskdescription;//任务描述*--%>
<%--        taskdate;//任务发布日期*--%>
<%--        completiontime;//完成时间*--%>
<%--        taskstatus;  //任务状态    待完成/已完成/已取消*--%>
<%--        subtasks;    //子任务列表，用逗号分隔--%>
<%--        categoryid; //任务分类ID  1: '设备任务', 2: '工艺任务',3: '设计任务',4: '制造任务'*--%>
<%--        auditstatus; //审核状态    驳回/通过/待审*--%>
<%--        orderids; //订单ID列表，用逗号分隔--%>
		 <tr>
				<th width="25"><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
             <th width="80px">任务id</th><%-- --%>    <%--        taskid;  //任务ID*--%>
             <th width="150px">任务名称</th>            <%--        userid;  //用户ID--%>
             <th width="200px">任务描述</th>            <%--        taskname;    //任务名称*--%>
                                                        <%--        taskdescription;//任务描述*--%>
                                                        <%--        taskdate;//任务发布日期*--%>
             <th width="180px">发布时间</th>            <%--        completiontime;//完成时间*--%>
             <th width="180px">完成时间</th>            <%--        taskstatus;  //任务状态    待完成/已完成/已取消*--%>
             <th width="70px">类别</th>               <%--        subtasks;    //子任务列表，用逗号分隔--%>
             <th width="100px">审核状态</th>            <%--        categoryid; //任务分类ID  1: '设备任务', 2: '工艺任务',3: '设计任务',4: '制造任务'*--%>
             <th width="100px">任务状态</th>            <%--        auditstatus; //审核状态    驳回/通过/待审*--%>
             <th width="200px">操作</th>              <%--        orderids; //订单ID列表，用逗号分隔--%>
			</tr>
		</thead>
	
	</table>
   </div>
  </div>
 </div>
</div>
<!--添加任务图层-->
<div class="add_menber" id="add_menber_style" style="display:none">
    <ul class="page-content">
        <div class="row">
            <li class="col-md-6"><label class="label_name">用户ID：</label><span class="add_name"><input name="userid" type="text" class="text_add"/></span><div class="prompt r_f"></div></li>
            <li class="col-md-6"><label class="label_name">任务名称：</label><span class="add_name"><input name="taskname" type="text" class="text_add"/></span><div class="prompt r_f"></div></li>
        </div>
        <div class="row">
            <li class="col-md-6"><label class="label_name">发布日期：</label><span class="add_name"><input name="taskdate" type="text" class="text_add laydate-icon" id="taskdate"/></span><div class="prompt r_f"></div></li>
            <li class="col-md-6"><label class="label_name">完成时间：</label><span class="add_name"><input name="completiontime" type="text" class="text_add laydate-icon" id="completiontime"/></span><div class="prompt r_f"></div></li>
        </div>
        <div class="row">
            <li class="col-md-6"><label class="label_name">任务状态：</label><span class="add_name">
                <label><input name="taskstatus" type="radio" value="待完成" checked class="ace"><span class="lbl">待完成</span></label>&nbsp;&nbsp;
                <label><input name="taskstatus" type="radio" value="已完成" class="ace"><span class="lbl">已完成</span></label>&nbsp;&nbsp;
                <label><input name="taskstatus" type="radio" value="已取消" class="ace"><span class="lbl">已取消</span></label>
             </span><div class="prompt r_f"></div></li>
            <li class="col-md-6"><label class="label_name">审核状态：</label><span class="add_name">
                <label><input name="auditstatus" type="radio" value="待审" checked class="ace"><span class="lbl">待审</span></label>&nbsp;&nbsp;
                <label><input name="auditstatus" type="radio" value="通过" class="ace"><span class="lbl">通过</span></label>&nbsp;&nbsp;
                <label><input name="auditstatus" type="radio" value="驳回" class="ace"><span class="lbl">驳回</span></label>
            </span><div class="prompt r_f"></div></li>
        </div>
        <div class="row">
            <li class="col-md-6"><label class="label_name">任务分类：</label><span class="add_name">
                <select name="categoryid" class="text_add">
                    <option value="1">设备任务</option>
                    <option value="2">工艺任务</option>
                    <option value="3">设计任务</option>
                    <option value="4">制造任务</option>
                </select>
            </span><div class="prompt r_f"></div></li>
        </div>
        <div class="row">
            <li class="col-md-6"><label class="label_name">子任务：</label><span class="add_name"><input name="subtasks" type="text" class="text_add" placeholder="多个子任务用逗号分隔"/></span><div class="prompt r_f"></div></li>
            <li class="col-md-6"><label class="label_name">订单ID：</label><span class="add_name"><input name="orderids" type="text" class="text_add" placeholder="多个订单ID用逗号分隔"/></span><div class="prompt r_f"></div></li>
        </div>
        <div class="row">
            <li class="col-md-12"><label class="label_name">任务描述：</label><span class="add_name"><textarea name="taskdescription" class="text_add" style="width:630px;height:95px;"></textarea></span><div class="prompt r_f"></div></li>
        </div>
    </ul>
</div>
</body>
</html>
<script>
jQuery(function($) {
				var oTable1 = $('#sample-table').dataTable( {
				"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,8,9]}// 制定列不参与排序
		] } );
				
				
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
						
				});
			
			
				$('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				function tooltip_placement(context, source) {
					var $source = $(source);
					var $parent = $source.closest('table')
					var off1 = $parent.offset();
					var w1 = $parent.width();
			
					var off2 = $source.offset();
					var w2 = $source.width();
			
					if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
					return 'left';
				}
			})

// 页面加载完成后执行的函数
$(function() {
    reloadTaskTable();

    // 查询按钮点击事件
    $('.btn_search').click(function() {
        fetchQueryTaskData();
    });

    // 回车键触发查询
    $('.text_add').keypress(function(e) {
        if(e.which == 13) {
            fetchQueryTaskData();
        }
    });
});
// 重新加载表格的函数（现在只需调用 fetchTaskData）
function reloadTaskTable() {
    fetchAllTaskData(); // 会自动触发渲染
}
// 更新总数显示
function updateTotalCount(count) {
    $('.r_f b').text(count || 0);
}

// 请求任务数据并自动渲染表格
function fetchAllTaskData() {
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/task/getTaskList",
        type: "POST",
        dataType: "json",
        success: function(data) {
            renderTaskTable(data.obj.list); // 成功获取数据后自动渲染
            updateTotalCount(data.obj.total); // 成功获取数据后自动渲染
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("加载任务数据失败:", textStatus, errorThrown);
            // 可以在这里添加错误提示，比如弹窗或Toast
        }
    });
}
// 请求任务数据并自动渲染表格_模糊查询
function fetchQueryTaskData() {
    const params = {
        searchKey: $('.text_add').val(),
        // startTime: $('#start').val() ? $('#start').val().split('~')[0].trim() : '',
        // endTime: $('#start').val() ? $('#start').val().split('~')[1].trim() : ''
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/task/pageList",
        type: "POST",
        dataType: "json",
        data: params,
        success: function(data) {
            renderTaskTable(data); // 成功获取数据后自动渲染
            // fetchTotalCount();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("加载任务数据失败:", textStatus, errorThrown);
            // 可以在这里添加错误提示，比如弹窗或Toast
        }
    });
}
// 渲染任务表格
function renderTaskTable(data) {
    // 销毁旧表格
    if ($.fn.dataTable.isDataTable('#sample-table')) {
        $('#sample-table').DataTable().destroy();
    }

    // 渲染新表格
    $('#sample-table').DataTable({
        data: data,
        columns: [
            {
                data: null, render: function (e) {
                    return "<label><input type='checkbox' class='ace'><span class='lbl'></span></label>";
                }
            },
            { data: "taskid" },
            { data: "taskname"},
            {data: "taskdescription", render: function(taskdescription) {
                    return taskdescription || "--";
                }
            },
            {data: "taskdate", render: function(taskdate) {
                    return taskdate || "--";
                }
            },
            {data: "completiontime", render: function(completiontime) {
                    return completiontime || "--";
                }
            },
            {data:"categoryid", render: function(categoryid) {
                    switch (categoryid) {
                        case 1: return "设备任务";
                        case 2: return "工艺任务";
                        case 3: return "设计任务";
                        case 4: return "制造任务";
                        default: return categoryid;
                    }
                }
            },
            {data:"auditstatus", render: function(auditstatus) {
                    switch (auditstatus) {
                        case "通过": return "<span class='label label-success radius'>通过</span>";
                        case "驳回": return "<span class='label label-defaunt radius'>驳回</span>";
                        case "待审": return "<span class='label label-warning radius'>待审</span>";
                        default: return auditstatus;
                    }
                }
            },
            {
                data: "taskstatus", render: function(taskstatus) {
                    switch (taskstatus) {
                        case "待完成": return "<span class='label label-defaunt radius'>待完成</span>";
                        case "已完成": return "<span class='label label-success radius'>已完成</span>";
                        case "已取消": return "<span class='label label-warning radius'>已取消</span>";
                        default: return taskstatus;
                    }
                }
            },
            {
                data: null, render: function(data, type, row) {
                    var html = "";
                    html += "<td class='td-manage'>";
                    // 审核状态按钮
                    if (data.auditstatus === "通过") {
                        html += "<a onclick='changeAuditStatus(this, \"" + data.taskid + "\", \"驳回\")' ";
                        html += "class='btn btn-xs btn-danger' title='驳回'>";
                        html += "<i class='icon-remove bigger-120'></i></a> ";
                    } else if (data.auditstatus === "驳回") {
                        html += "<a onclick='changeAuditStatus(this, \"" + data.taskid + "\", \"通过\")' ";
                        html += "class='btn btn-xs btn-success' title='通过'>";
                        html += "<i class='icon-ok bigger-120'></i></a> ";
                    } else {
                        // 待审状态显示两个按钮
                        // 待审状态显示两个按钮（上下排列）
                        html += "<div style='display: inline-block; vertical-align: middle;'>";
                        html += "<div style='margin-bottom: 2px;'>";
                        html += "<a onclick='changeAuditStatus(this, \"" + data.taskid + "\", \"通过\")' ";
                        html += "class='btn btn-xs btn-success smaller-70' title='通过'>";
                        html += "<i class='icon-ok'></i></a>";
                        html += "</div>";
                        html += "<div>";
                        html += "<a onclick='changeAuditStatus(this, \"" + data.taskid + "\", \"驳回\")' ";
                        html += "class='btn btn-xs btn-danger smaller-70' title='驳回'>";
                        html += "<i class='icon-remove'></i></a>";
                        html += "</div>";
                        html += "</div> ";
                    }
                    html += "<a onclick='member_edit(\"" + data.taskid + "\")' ";
                    html += "class='btn btn-xs btn-info' title='编辑'>";
                    html += "<i class='icon-edit bigger-120'></i></a> ";
                    html += "<a onclick='member_del(this, \"" + data.taskid + "\")' ";
                    html += "class='btn btn-xs btn-warning' title='删除'>";
                    html += "<i class='icon-trash bigger-120'></i></a>";
                    html += "</td>";
                    return html;
                }
            }
        ],
        destroy: true
    });
}

// 更改审核状态的函数
function changeAuditStatus(obj, taskid, auditstatus) {
    var actionText = auditstatus === "通过" ? "通过" : "驳回";
    layer.confirm('确认要' + actionText + '该任务吗？', {icon: 3, title: '提示'}, function(index) {
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/task/updateTask",
            type: "POST",
            data: {
                taskid: taskid,
                auditstatus: auditstatus
            },
            success: function(response) {
                if (response.code === 0 || response.code === 200) {
                    layer.msg('审核状态已' + actionText, {icon: 6, time: 1000});
                    reloadTaskTable(); // 成功后刷新表格
                } else {
                    layer.msg('操作失败: ' + response.message, {icon: 5, time: 1500});
                }
            },
            error: function() {
                layer.msg('请求失败，请稍后重试！', {icon: 5, time: 1500});
            }
        });
        layer.close(index); // 关闭确认弹窗
    });
}

/* 批量删除任务 - 使用ID选择器 */
$('#member_batch_del').on('click', function() {
    // 获取所有选中的任务ID
    const selectedIds = [];
    $('table input[type="checkbox"]:checked').each(function() {
        const row = $(this).closest('tr');
        const taskid = row.find('td:eq(1)').text().trim();
        if (taskid) {
            selectedIds.push(taskid);
            // console.log("选中的任务ID：" + taskid);
        }
    });

    // 如果没有选中任何任务
    if (selectedIds.length === 0) {
        layer.alert('请至少选择一条记录', {icon: 2});
        return false;
    }

    // 确认对话框
    layer.confirm('确定要删除选中的 ' + selectedIds.length + ' 条记录吗？', {
        title: '批量删除确认',
        btn: ['确定', '取消']
    }, function(index) {
        layer.close(index);

        // 显示加载中
        const loadingIndex = layer.load(2);

        $.ajax({
            url: '${pageContext.request.contextPath}/admin/task/batchDelete',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({taskids: selectedIds}),
            dataType: 'json',
            success: function(response) {
                layer.close(loadingIndex);
                if (response.code === 0) {
                    layer.msg('成功删除 ' + selectedIds.length + ' 条记录', {icon: 1});
                    // 刷新表格
                    reloadTaskTable();
                } else {
                    layer.alert(response.msg || '批量删除失败', {icon: 2});
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                layer.close(loadingIndex);
                const errorResponse = xhr.responseJSON || {};
                const errorMsg = errorResponse.msg || '服务器错误 (' + xhr.status + ')';
                layer.alert('批量删除失败: ' + errorMsg, {icon: 2});
            }
        });
    });
});

/*任务-添加*/
$('#task_add').on('click', function() {
    layer.open({
        type: 1,
        title: '添加任务',
        maxmin: true,
        shadeClose: true,
        area: ['800px', ''],
        content: $('#add_menber_style'),
        btn: ['提交', '取消'],
        success: function(layero, index) { // 弹窗打开后清空表单
            $(".add_menber input[type='text']").val('');
            $(".add_menber input[type='radio']").prop('checked', false);
            // 设置默认值
            $(".add_menber input[name='taskdate']").val(new Date().format("yyyy-MM-dd hh:mm:ss"));
            $(".add_menber input[name='taskstatus'][value='待完成']").prop('checked', true);
            $(".add_menber input[name='auditstatus'][value='待审']").prop('checked', true);
        },
        yes: function(index, layero) {
            // =============== 表单验证 ===============
            let errorMessages = [];
            const formData = {};

            // 验证用户ID
            const userid = $(".add_menber input[name='userid']").val().trim();
            if (!userid) errorMessages.push("用户ID不能为空");
            formData['userid'] = userid;

            // 验证任务名称
            const taskname = $(".add_menber input[name='taskname']").val().trim();
            if (!taskname) errorMessages.push("任务名称不能为空");
            formData['taskname'] = taskname;

            // 收集其他字段
            formData['taskdate'] = $(".add_menber input[name='taskdate']").val().trim();
            formData['completiontime'] = $(".add_menber input[name='completiontime']").val().trim();
            formData['taskstatus'] = $(".add_menber input[name='taskstatus']:checked").val().trim();
            formData['categoryid'] = $(".add_menber select[name='categoryid']").val().trim();
            formData['auditstatus'] = $(".add_menber input[name='auditstatus']:checked").val().trim();
            formData['subtasks'] = $(".add_menber input[name='subtasks']").val().trim();
            formData['orderids'] = $(".add_menber input[name='orderids']").val().trim();
            formData['taskdescription'] = $(".add_menber textarea[name='taskdescription']").val().trim();

            // 显示错误
            if (errorMessages.length > 0) {
                layer.alert(errorMessages.join('<br>'), { title: '表单错误', icon: 2 });
                return false;
            }

            // =============== AJAX 提交 ===============
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/task/addTask',
                type: 'POST',
                // contentType: 'application/json',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    if (response.code === 0 || response.code === 200) {
                        layer.msg('添加成功', { icon: 1 });
                        // $('#sample-table').DataTable().ajax.reload(); // 刷新表格
                        reloadTaskTable(); // 成功后刷新表格
                    } else {
                        layer.alert(response.msg || '添加失败', { icon: 2 });

                    }
                },
                error: function(xhr, textStatus, errorThrown) {
                    // 获取错误信息

                    const errorResponse = xhr.responseJSON || {};
                    const errorMsg = errorResponse.msg || '服务器错误 (' + xhr.status + ')';
                    layer.alert('提交失败: ' + errorMsg, { icon: 2 });
                },
                complete: function() {
                    console.log('请求完成，已关闭加载动画'); // 无论成功失败都关闭加载动画
                }
            });
        }
    });
});

/*任务-查看*/
function member_show(title,url,id,w,h){
    layer_show(title,url+'#?='+id,w,h);
}

/*任务-编辑*/
function member_edit(taskid) {
    // console.log("taskid:" + taskid);
    var editForm = $('#add_menber_style').clone(true, true).removeAttr('style');

    $.ajax({
        url: "${pageContext.request.contextPath}/admin/task/findTaskById",
        type: 'POST',
        data: { taskid: taskid },
        dataType: 'json',
        beforeSend: function() {
            layer.load(1); // loading 动画
        },
        success: function(response) {
            layer.closeAll('loading');
            console.log(response.code);
            if (response.code === 0 || response.code === 200) {
                var task = response.obj;
                layer.open({
                    type: 1,
                    title: '修改任务信息',
                    maxmin: true,
                    shadeClose: false,
                    area: ['800px', ''],
                    content: editForm.prop('outerHTML'),
                    btn: ['提交', '取消'],
                    success: function(layero, index) {
                        // 在弹出的layer内部找到表单
                        var form = $(layero).find('#add_menber_style');

                        // 填充表单字段
                        form.find("[name='taskname']").val(task.taskname || '');
                        form.find("[name='userid']").val(task.userid || '');
                        form.find("[name='taskdate']").val(task.taskdate || '');
                        form.find("[name='completiontime']").val(task.completiontime || '');
                        form.find("[name='subtasks']").val(task.subtasks || '');
                        form.find("[name='orderids']").val(task.orderids || '');
                        form.find("[name='taskdescription']").val(task.taskdescription || '');

                        // 选择任务分类
                        form.find("[name='categoryid']").val(task.categoryid || '1');

                        // 单选按钮特殊处理
                        form.find("[name='taskstatus'][value='" + (task.taskstatus ?? '待完成') + "']").prop('checked', true);
                        form.find("[name='auditstatus'][value='" + (task.auditstatus ?? '待审') + "']").prop('checked', true);
                        },
                    yes: function(index, layero) {
                        // =============== 表单验证 ===============
                        let errorMessages = [];
                        const formData = {};
                        var form = $(layero).find('#add_menber_style');

                        // 收集所有字段
                        form.find("input[type$='text'], select, input[type='radio']:checked").each(function() {
                            formData[$(this).attr("name")] = $(this).val();
                        });
                        // 添加 taskid
                        formData['taskid'] = taskid;

                        // 只校验用户ID和任务名称
                        const userid = parseInt(formData['userid']) || 0;
                        const taskname = (formData['taskname'] || '').trim();

                        if (userid <= 0) {
                            errorMessages.push("用户ID必须大于0");
                        }
                        if (!taskname) {
                            errorMessages.push("任务名称不能为空");
                        }

                        // 显示错误
                        if (errorMessages.length > 0) {
                            layer.alert(errorMessages.join('<br>'), { title: '表单错误', icon: 2 });
                            return false;
                        }

                        // =============== AJAX 提交 ===============
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/task/updateTask',
                            type: 'POST',
                            data: formData,
                            dataType: 'json',
                            beforeSend: function() {
                                layer.load(1); // loading 动画
                            },
                            success: function(response) {
                                layer.closeAll('loading');
                                if (response.code === 0 || response.code === 200) {
                                    layer.alert('修改成功！', {
                                        title: '提示框',
                                        icon: 1,
                                    });
                                    layer.close(index);
                                    reloadTaskTable(); // 成功后刷新表格
                                } else {
                                    layer.alert(response.msg || '修改失败', { icon: 2 });
                                }
                            },
                            error: function(xhr, textStatus, errorThrown) {
                                const errorResponse = xhr.responseJSON || {};
                                const errorMsg = errorResponse.msg || '服务器错误 (' + xhr.status + ')';
                                layer.alert('修改失败: ' + errorMsg, { icon: 2 });
                            }
                        });
                    }
                });
            } else {
                layer.alert('未找到任务信息', {icon: 2});
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            const errorResponse = xhr.responseJSON || {};
            const errorMsg = errorResponse.msg || '服务器错误 (' + xhr.status + ')';
            layer.alert('获取任务信息失败: ' + errorMsg, { icon: 2 });
        }
    });
}

/*任务-删除*/
function member_del(obj, taskid) {
    layer.confirm('确认要删除吗？', function(index) {
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/task/deleteTask",
            type: 'POST',
            data: { taskid: taskid },
            dataType: 'json',
            success: function(response) {
                if (response.code === 0 || response.code === 200) {
                    $(obj).closest('tr').remove();
                    layer.msg('已删除!', { icon: 1, time: 1000 });
                    // 这里可以刷新页面或者表格
                    reloadTaskTable(); // 成功后刷新表格
                } else {
                    layer.alert(response.msg || '删除失败', { icon: 2 });
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                const errorResponse = xhr.responseJSON || {};
                const errorMsg = errorResponse.msg || '服务器错误 (' + xhr.status + ')';
                // console.error('Error deleting task:', errorMsg);
                layer.alert('删除失败: ' + errorMsg, { icon: 2 });
            },
            complete: function() {
                console.log('请求完成，已关闭加载动画');
            }
        });
    });
}

// 初始化日期选择器（老版本方式）
laydate({
    elem: '#start',       // 绑定元素ID
    format: 'YYYY-MM-DD', // 日期格式
    istime: true,         // 是否开启时间选择
    istoday: true        // 是否显示今天按钮
});
// 初始化日期选择器
laydate({
    elem: '#taskdate',
    format: 'YYYY-MM-DD hh:mm:ss',
    istime: true,
    istoday: true
});

laydate({
    elem: '#completiontime',
    format: 'YYYY-MM-DD hh:mm:ss',
    istime: true,
    istoday: true
});
// 添加日期格式化方法
Date.prototype.format = function(fmt) {
    var o = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S": this.getMilliseconds()
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
};
</script>