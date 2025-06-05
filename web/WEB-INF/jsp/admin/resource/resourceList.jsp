<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" /> 
        <link href="${pageContext.request.contextPath}/static/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/font-awesome.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
        <link href="${pageContext.request.contextPath}/static/Widget/icheck/icheck.css" rel="stylesheet" type="text/css" />
		<!--[if IE 7]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace-ie.min.css" />
		<![endif]-->
	    <script src="${pageContext.request.contextPath}/static/js/jquery-1.9.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/assets/js/typeahead-bs2.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${pageContext.request.contextPath}/static/assets/js/jquery.dataTables.min.js"></script>
		<script src="${pageContext.request.contextPath}/static/assets/js/jquery.dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.admin.js"></script>
        <script src="${pageContext.request.contextPath}/static/assets/layer/layer.js" type="text/javascript" ></script>
        <script src="${pageContext.request.contextPath}/static/assets/laydate/laydate.js" type="text/javascript"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/js/lrtk.js" type="text/javascript" ></script>
<title>产品列表</title>
<style>
    #products_list .this_table_menu_list{ overflow:auto;}
</style>
</head>
<body>
<div class=" page-content clearfix">
 <div id="products_style">
    <div class="search_style">
      <div class="title_names">搜索查询</div>
      <ul class="search_content clearfix">
       <li><label class="l_f">产品名称</label><input name="" type="text"  class="text_add" placeholder="输入品牌名称"  style=" width:250px"/></li>
       <li><label class="l_f">添加时间</label><input class="inline laydate-icon" id="start" style=" margin-left:10px;"></li>
       <li style="width:90px;"><button type="button" class="btn_search"><i class="icon-search"></i>查询</button></li>
      </ul>
    </div>
     <div class="border clearfix">
       <span class="l_f">
        <a href="${pageContext.request.contextPath}/admin/resource/add" title="添加商品" class="btn btn-warning Order_form"><i class="icon-plus"></i>添加商品</a>
        <a href="javascript:ovid()" class="btn btn-danger"><i class="icon-trash"></i>批量删除</a>
       </span>
       <span class="r_f">共：<b>2334</b>件商品</span>
     </div>

     <!--产品列表展示-->
     <div class="h_products_list clearfix" id="products_list">
      <%-- <div id="scrollsidebar" class="left_Treeview">
        <div class="show_btn" id="rightArrow"><span></span></div>
        <div class="widget-box side_content" >
         <div class="side_title"><a title="隐藏" class="close_btn"><span></span></a></div>
         <div class="side_list"><div class="widget-header header-color-green2"><h4 class="lighter smaller">产品类型列表</h4></div>
         <div class="widget-body">
          <div class="widget-main padding-8"><div id="treeDemo" class="ztree"></div></div>
        </div>
       </div>
      </div>  
     </div>--%>
         <div class="this_table_menu_list" id="testIframe">
       <table class="table table-striped table-bordered table-hover" id="sample-table" width="100%">
		<thead>
		 <tr>
				<th width="25px"><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
				<th width="80px">资源id</th>
				<th width="150px">资源名称</th>
                <th width="200px">资源描述</th>
				<th width="100px">资源数量</th>
				<th width="100px">资源价格</th>
				<th width="180px">发布时间</th>
                <th width="70px">类别</th>
                <th width="100px">审核状态</th>
				<th width="100px">资源状态</th>
				<th width="200px">操作</th>
			</tr>
		</thead>
    </table>
    </div>     
  </div>
 </div>
</div>
</body>
</html>
<script>
    $(function() {
        reloadResourceTable();
    });


    function reloadResourceTable() {
        if ($.fn.dataTable.isDataTable('#sample-table')) {
            $('#sample-table').DataTable().destroy();
        }

        $('#sample-table').DataTable({
            ajax: {
                url: "${pageContext.request.contextPath}/admin/resource/pageSearch",
                type: "POST",
                dataType: "json",
                dataSrc: "" // 后端返回资源列表数组
            },
            columns: [
                {
                    data: null, render: function () {
                        return "<label><input type='checkbox' class='ace'><span class='lbl'></span></label>";
                    }
                },
                {data: "resourceid"},
                {data: "resourcename"},

                {data: "resourcedescription"},
                {data: "quantity"},
                {data: "resourceprice"},
                {
                    data: "resourcedate", render: function (date) {
                        return date || "--";
                    }
                },
                {data: "categoryid"},

                {
                    data: "auditstatus", render: function (status) {
                        switch (status) {
                            case "通过":
                                return "<span class='label label-success radius'>"+status +"</span>";
                            case "待审":
                                return "<span class='label label-warning radius'>"+status+"</span>";
                            case "驳回":
                                return "<span class='label label-defaunt radius'>"+status+"</span>";
                            default:
                                return status || "--";
                        }
                    }
                },
                {
                    data: "resourcestatus", render: function (status) {
                        return status || "--";
                    }
                },
                {
                    data: null, render: function (data) {
                        var html = "<td class='td-manage'>";
                        html += "<a onclick='resource_edit(\"" + data.resourceid + "\")' ";
                        html += "class='btn btn-xs btn-info' title='编辑'>";
                        html += "<i class='icon-edit bigger-120'></i></a> ";
                        html += "<a onclick='resource_del(this, \"" + data.resourceid + "\")' ";
                        html += "class='btn btn-xs btn-warning' title='删除'>";
                        html += "<i class='icon-trash bigger-120'></i></a> ";
                        html += "<a onclick='resource_detail(\"" + data.resid + "\")' ";
                        html += "class='btn btn-xs btn-success' title='详情'>";
                        html += "<i class='icon-zoom-in bigger-120'></i></a>";
                        html += "</td>";
                        return html;
                    }
                }
            ],
            destroy: true
        });
    }


    laydate({
        elem: '#start',
        event: 'focus'
    });
    $(function () {
        $("#products_style").fix({
            float: 'left',
            //minStatue : true,
            skin: 'green',
            durationTime: false,
            spacingw: 30,//设置隐藏时的距离
            spacingh: 260,//设置显示时间距
        });
    });
</script>
<script type="text/javascript">
    //初始化宽度、高度
 $(".widget-box").height($(window).height()-215); 
$(".table_menu_list").width($(window).width()-260);
 $(".table_menu_list").height($(window).height()-215);
  //当文档窗口发生改变时 触发  
    $(window).resize(function(){
	$(".widget-box").height($(window).height()-215);
	 $(".table_menu_list").width($(window).width()-260);
	  $(".table_menu_list").height($(window).height()-215);
	})
 
/*******树状图*******/
var setting = {
	view: {
		dblClickExpand: false,
		showLine: false,
		selectedMulti: false
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: ""
		}
	},
	callback: {
		beforeClick: function(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("tree");
			if (treeNode.isParent) {
				zTree.expandNode(treeNode);
				return false;
			} else {
				demoIframe.attr("src",treeNode.file + ".html");
				return true;
			}
		}
	}
};

var zNodes =[
	{ id:1, pId:0, name:"商城分类列表", open:true},
	{ id:11, pId:1, name:"蔬菜水果"},
	{ id:111, pId:11, name:"蔬菜"},
	{ id:112, pId:11, name:"苹果"},
	{ id:113, pId:11, name:"大蒜"},
	{ id:114, pId:11, name:"白菜"},
	{ id:115, pId:11, name:"青菜"},
	{ id:12, pId:1, name:"手机数码"},
	{ id:121, pId:12, name:"手机 "},
	{ id:122, pId:12, name:"照相机 "},
	{ id:13, pId:1, name:"电脑配件"},
	{ id:131, pId:13, name:"手机 "},
	{ id:122, pId:13, name:"照相机 "},
	{ id:14, pId:1, name:"服装鞋帽"},
	{ id:141, pId:14, name:"手机 "},
	{ id:142, pId:14, name:"照相机 "},
];
		
var code;
		
function showCode(str) {
	if (!code) code = $("#code");
	code.empty();
	code.append("<li>"+str+"</li>");
}
		
$(document).ready(function(){
	var t = $("#treeDemo");
	t = $.fn.zTree.init(t, setting, zNodes);
	demoIframe = $("#testIframe");
	demoIframe.bind("load", loadReady);
	var zTree = $.fn.zTree.getZTreeObj("tree");
	zTree.selectNode(zTree.getNodeByParam("id",'11'));
});	
/*产品-停用*/
function member_stop(obj,id){
	layer.confirm('确认要停用吗？',function(index){
		$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" class="btn btn-xs " onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="icon-ok bigger-120"></i></a>');
		$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已停用</span>');
		$(obj).remove();
		layer.msg('已停用!',{icon: 5,time:1000});
	});
}

/*产品-启用*/
function member_start(obj,id){
	layer.confirm('确认要启用吗？',function(index){
		$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" class="btn btn-xs btn-success" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="icon-ok bigger-120"></i></a>');
		$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
		$(obj).remove();
		layer.msg('已启用!',{icon: 6,time:1000});
	});
}
/*资源-编辑*/
function resource_edit(resourceId){
    let h = 510;
    let w = 800;
    let title = "资源编辑";
    let url = "${pageContext.request.contextPath}/admin/resource/edit";
    // 先获取资源数据
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/resource/" + resourceId,
        type: "GET",
        dataType: "json",
        beforeSend: function() {
            layer.load(1); // 显示加载中
        },
        success: function(response) {
            layer.closeAll('loading');
            if(response.code === 0) {
                // 打开编辑弹窗并填充数据
                layer.open({
                    type: 2,
                    title: title,
                    area: [w+'px', h+'px'],
                    content: url,
                    success: function(layero, index) {
                        var iframe = layero.find('iframe')[0];
                        var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                        // 方法1：直接检查 iframe 是否已加载
                        if (iframeDoc.readyState === 'complete') {
                            // console.log("1");
                            fillForm(iframeDoc, response.obj);
                        }
                        // 方法2：如果未加载，监听 onload 事件
                        else {
                            iframe.onload = function() {
                                // console.log("2");
                                fillForm(iframe.contentDocument, response.obj);
                            };
                        }
                        // 封装填充表单的逻辑
                        function fillForm(doc, data) {
                            var body = $(doc).find('body');

                            body.find("[name='resourcename']").val(data.resourcename);
                            body.find("[name='userid']").val(data.userid);
                            body.find("[name='quantity']").val(data.quantity);
                            body.find("select[name='categoryid']").val(data.categoryid);
                            body.find("input[name='resourceprice']").val(data.resourceprice);
                            body.find("select[name='resourcestatus']").val(data.resourcestatus);
                            body.find("input[name='resourcedate']").val(data.resourcedate);
                            body.find("textarea[name='resourcedescription']").val(data.resourcedescription);
                            body.find("select[name='auditstatus']").val(data.auditstatus);
                        }
                    },
                    btn: ['保存', '取消'],
                    yes: function(index, layero) {
                        // 1. 获取 iframe 的 document 对象
                        var iframe = layero.find('iframe')[0];
                        var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

                        // 2. 从 iframe 内部获取表单数据
                        var formData = {};
                        $(iframeDoc).find('form input, select, textarea').each(function() {
                            var name = $(this).attr('name');
                            var value = $(this).val();
                            if (name) {  // 确保字段有 name 属性
                                formData[name] = value;
                            }
                        });
                        // 3. 添加 resourceId 到提交数据
                        formData.resourceid = resourceId;
                        //打印表单数据
                        // console.log(formData);

                        $.ajax({
                            url: "${pageContext.request.contextPath}/admin/resource/update",
                            type: "POST",
                            contentType: "application/json",
                            data: JSON.stringify(formData),
                            success: function(res) {
                                if(res.code === 0) {
                                    layer.msg('保存成功', {icon: 1});
                                    reloadResourceTable(); // 刷新表格
                                    layer.close(index); // 关闭弹窗
                                } else {
                                    layer.alert(res.msg || '保存失败', {icon: 2});
                                }
                            }
                        });
                    }
                });
            } else {
                layer.msg('获取资源失败: ' + response.msg, {icon: 2});
            }
        },
        error: function() {
            layer.closeAll('loading');
            layer.msg('请求失败', {icon: 2});
        }
    });
}


/*资源-删除*/
function resource_del(obj,resourceid){
        // console.log('Deleting user with ID:', userid); // 添加这一行
        layer.confirm('确认要删除吗？', function(index) {
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/resource/delete",
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ resourceid: resourceid }),
                dataType: 'json',
                success: function(response) {
                    if (response.code === 0) {
                        $(obj).closest('tr').remove();
                        layer.msg('已删除!', { icon: 1, time: 1000 });
                        // 这里可以刷新页面或者表格
                        reloadUserTable(); // 成功后刷新表格
                    } else {
                        layer.alert(response.msg || '删除失败', { icon: 2 });
                    }
                },
                error: function(xhr, textStatus, errorThrown) {
                    const errorResponse = xhr.responseJSON || {};
                    const errorMsg = errorResponse.msg || '服务器错误 (' + xhr.status + ')';
                    // console.error('Error deleting user:', errorMsg);
                    layer.alert('删除失败: ' + errorMsg, { icon: 2 });
                },
                complete: function() {
                    console.log('请求完成，已关闭加载动画');
                }
            });
        });
}
//面包屑返回值
var index = parent.layer.getFrameIndex(window.name);
parent.layer.iframeAuto(index);
$('.Order_form').on('click', function(){
	var cname = $(this).attr("title");
	var chref = $(this).attr("href");
	var cnames = parent.$('.Current_page').html();
	var herf = parent.$("#iframe").attr("src");
    parent.$('#parentIframe').html(cname);
    parent.$('#iframe').attr("src",chref).ready();;
	parent.$('#parentIframe').css("display","inline-block");
	parent.$('.Current_page').attr({"name":herf,"href":"javascript:void(0)"}).css({"color":"#4c8fbd","cursor":"pointer"});
	//parent.$('.Current_page').html("<a href='javascript:void(0)' name="+herf+" class='iframeurl'>" + cnames + "</a>");
    parent.layer.close(index);
	
});
</script>
