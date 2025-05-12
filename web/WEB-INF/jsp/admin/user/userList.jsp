<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/4/24
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
    <title>用户列表</title>
</head>

<body>
<div class="page-content clearfix">
    <div id="Member_Ratings">
        <div class="d_Confirm_Order_style">
            <div class="search_style">
                <div class="title_names">搜索查询</div>
                <ul class="search_content clearfix">
                    <li><label class="l_f">会员名称</label><input name="" type="text"  class="text_add" placeholder="输入用户名称、电话、邮箱"  style=" width:400px"/></li>
                    <li><label class="l_f">添加时间</label><input class="inline laydate-icon" id="start" style=" margin-left:10px;"></li>
                    <li style="width:90px;"><button type="button" class="btn_search"><i class="icon-search"></i>查询</button></li>
                </ul>
            </div>
            <!---->
            <div class="border clearfix">
       <span class="l_f">
        <a href="javascript:ovid()" id="member_add" class="btn btn-warning"><i class="icon-plus"></i>添加用户</a>
        <a href="javascript:ovid()" id="member_batch_del" class="btn btn-danger"><i class="icon-trash"></i>批量删除</a>
       </span>
                <span class="r_f">共：<b>2345</b>条</span>
            </div>
            <!---->
            <div class="table_menu_list">
                <table class="table table-striped table-bordered table-hover" id="sample-table">
                    <thead>
                    <tr>
                        <th width="25"><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
                        <th width="80">ID</th>
                        <th width="100">用户名</th>
                        <th width="80">性别</th>
                        <th width="120">手机</th>
                        <th width="150">邮箱</th>
                        <th width="">地址</th>
                        <th width="180">加入时间</th>
                        <th width="100">角色</th>
                        <th width="70">状态</th>
                        <th width="250">操作</th>
                    </tr>
                    </thead>

                </table>
            </div>
        </div>
    </div>
</div>
<!--添加用户图层-->
<div class="add_menber" id="add_menber_style" style="display:none">

    <ul class="page-content">
        <li><label class="label_name">用&nbsp;&nbsp;户 &nbsp;名：</label><span class="add_name">
            <input  name="username" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>

        <li><label class="label_name" name="gender_label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</label><span class="add_name">
     <label><input name="gender" type="radio" value="1" class="ace"><span class="lbl">男</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="gender" type="radio" value="2" class="ace"><span class="lbl">女</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="gender" type="radio" value="3" class="ace"><span class="lbl">保密</span></label>
     </span>
            <div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">移动电话：</label><span class="add_name"><input name="phone" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">电子邮箱：</label><span class="add_name"><input name="email" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label><span class="add_name">
     <label><input name="role" type="radio" value="0" class="ace"><span class="lbl">普通用户</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="role" type="radio" value="1" class="ace"><span class="lbl">管理员</span></label>
     </span><div class="prompt r_f"></div></li>

        <li class="adderss"><label class="label_name">家庭住址：</label><span class="add_name"><input name="address" type="text"  class="text_add" style=" width:350px"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label><span class="add_name">
     <label><input name="status" value="0" type="radio" class="ace"><span class="lbl">正常</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="status" value="1" type="radio" class="ace"><span class="lbl">封禁</span></label>
        </span><div class="prompt r_f"></div></li>
    </ul>
</div>
</body>
</html>
<script>

    // 页面加载完成后执行的函数
    $(function() {
        reloadUserTable();

        // 查询按钮点击事件
        $('.btn_search').click(function() {
            fetchQueryUserData();
        });

        // 回车键触发查询
        $('.text_add').keypress(function(e) {
            if(e.which == 13) {
                fetchQueryUserData();
            }
        });
    });
    // 重新加载表格的函数（现在只需调用 fetchUserData）
    function reloadUserTable() {
        fetchAllUserData(); // 会自动触发渲染
    }
    // 更新总数显示
    function updateTotalCount(count) {
        $('.r_f b').text(count || 0);
    }
    function fetchTotalCount() {
      $.ajax({
          url: "${pageContext.request.contextPath}/admin/user/totalCount",
          type: "POST",
          dataType: "json",
          success: function(data) {
              updateTotalCount(data); // 成功获取数据后自动渲染
              console.log(data);
          },
          error: function(jqXHR, textStatus, errorThrown) {
              console.error("加载用户数据失败:", textStatus, errorThrown);
          }
      })
    }
    // 请求用户数据并自动渲染表格
    function fetchAllUserData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/user/pageSearch",
            type: "POST",
            dataType: "json",
            success: function(data) {
                renderUserTable(data); // 成功获取数据后自动渲染
                fetchTotalCount();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("加载用户数据失败:", textStatus, errorThrown);
                // 可以在这里添加错误提示，比如弹窗或Toast
            }
        });
    }
    // 请求用户数据并自动渲染表格_模糊查询
    function fetchQueryUserData() {
        const params = {
            searchKey: $('.text_add').val(),
            // startTime: $('#start').val() ? $('#start').val().split('~')[0].trim() : '',
            // endTime: $('#start').val() ? $('#start').val().split('~')[1].trim() : ''
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/user/pageList",
            type: "POST",
            dataType: "json",
            data: params,
            success: function(data) {
                renderUserTable(data); // 成功获取数据后自动渲染
                fetchTotalCount();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("加载用户数据失败:", textStatus, errorThrown);
                // 可以在这里添加错误提示，比如弹窗或Toast
            }
        });
    }
    // 渲染用户表格
    function renderUserTable(data) {
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
                { data: "userid" },
                { data: "username"},
                {
                    data: "gender", render: function (gender) {
                        switch (gender) {
                            case 1: return "男";
                            case 2: return "女";
                            case 3: return "保密";
                            default: return gender;
                        }
                    }
                },
                {
                    data: "phone", render: function(phone) {
                        return phone || "--";
                    }
                },
                {
                    data: "email", render: function(email) {
                        return email || "--";
                    }
                },
                {
                    data: "address", render: function(address) {
                        return address || "--";
                    }
                },
                {
                    data: "time", render: function(time) {
                        return time || "--";
                    }
                },
                {
                    data: "role", render: function(role) {
                        switch (role) {
                            case 0: return "用户";
                            case 1: return "管理员";
                            default: return role;
                        }
                    }
                },
                {
                    data: "status", render: function(status) {
                        switch (status) {
                            case 0: return "<span class='label label-success radius'>正常</span>";
                            case 1: return "<span class='label label-defaunt radius'>封禁</span>";
                            default: return status;
                        }
                    }
                },
                {
                    data: null, render: function(data, type, row) {
                        var html = "";
                        html += "<td class='td-manage'>";
                        if (data.status === 0) {
                            // 正常 ➔ 显示停用按钮（红色）
                            html += "<a onclick='changeUserStatus(this, \"" + data.userid + "\", 1)' ";
                            html += "class='btn btn-xs btn-danger' title='停用'>";
                            html += "<i class='icon-remove bigger-120'></i></a> ";
                        } else if (data.status === 1) {
                            // 封禁 ➔ 显示启用按钮（绿色）
                            html += "<a onclick='changeUserStatus(this, \"" + data.userid + "\", 0)' ";
                            html += "class='btn btn-xs btn-success' title='启用'>";
                            html += "<i class='icon-ok bigger-120'></i></a> ";
                        }
                        html += "<a onclick='member_edit(\"" + data.userid + "\")' ";
                        html += "class='btn btn-xs btn-info' title='编辑'>";
                        html += "<i class='icon-edit bigger-120'></i></a> ";
                        html += "<a onclick='member_del(this, \"" + data.userid + "\")' ";
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

    // 更改用户状态的函数
    function changeUserStatus(obj, userid, status) {
        var actionText = (status === 0) ? "启用" : "停用"; // 根据status决定提示内容
        layer.confirm('确认要' + actionText + '该用户吗？', {icon: 3, title: '提示'}, function(index) {
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/user/changeStatus",
                type: "POST",
                data: {
                    userid: userid,
                    status: status
                },
                success: function(response) {
                    if (response.code === 0) {
                        layer.msg(actionText + '成功！', {icon: 6, time: 1000});
                        reloadUserTable(); // 成功后刷新表格
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

    /* 批量删除用户 - 使用ID选择器 */
    $('#member_batch_del').on('click', function() {
        // 获取所有选中的用户ID
        const selectedIds = [];
        $('table input[type="checkbox"]:checked').each(function() {
            const row = $(this).closest('tr');
            const userid = row.find('td:eq(1)').text().trim();
            if (userid) {
                selectedIds.push(userid);
                // console.log("选中的用户ID：" + userid);
            }
        });

        // 如果没有选中任何用户
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
                url: '${pageContext.request.contextPath}/admin/user/batchDelete',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({userids: selectedIds}),
                dataType: 'json',
                success: function(response) {
                    layer.close(loadingIndex);
                    if (response.code === 0) {
                        layer.msg('成功删除 ' + selectedIds.length + ' 条记录', {icon: 1});
                        // 刷新表格
                        reloadUserTable();
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

    /*用户-添加*/
    $('#member_add').on('click', function() {
        layer.open({
            type: 1,
            title: '添加用户',
            maxmin: true,
            shadeClose: true,
            area: ['800px', ''],
            content: $('#add_menber_style'),
            btn: ['提交', '取消'],
            success: function(layero, index) { // 弹窗打开后清空表单
                $(".add_menber input[type='text']").val('');
                $(".add_menber input[type='radio']").prop('checked', false);
                $(".add_menber input[name='address']").val('无');
            },
            yes: function(index, layero) {
                // =============== 表单验证 ===============
                let errorMessages = [];
                const formData = {};

                // 收集文本字段
                $(".add_menber input[type='text']").each(function() {
                    const fieldName = $(this).attr("name");
                    console.log(fieldName);
                    const value = $(this).val().trim();

                    if (!value) {
                        errorMessages.push(fieldName+"不能为空");
                    }
                    formData[fieldName] = value;
                });

                // 收集单选按钮（性别）
                const genderName = $(".add_menber input[name='gender']").attr("name");
                const genderValue = $(".add_menber input[name='gender']:checked").val().trim();
                console.log("genderValue：" + genderValue);
                if (!genderValue) errorMessages.push(genderName+"不能为空");
                formData[genderName] = genderValue;

                // 收集状态
                const stateName = $(".add_menber input[name='status']").attr("name");
                const stateValue = $(".add_menber input[name='status']:checked").val().trim();
                console.log("stateValue：" + stateValue);
                if (!stateValue) errorMessages.push(stateName+"不能为空");
                formData[stateName] = stateValue;

                // 收集状态
                const roleName = $(".add_menber input[name='role']").attr("name");
                const roleValue = $(".add_menber input[name='role']:checked").val().trim();
                if (!roleValue) errorMessages.push(roleName+"不能为空");
                formData[roleName] = roleValue;

                // 显示错误
                if (errorMessages.length > 0) {
                    layer.alert(errorMessages.join('<br>'), { title: '表单错误', icon: 2 });
                    return false;
                }

                // =============== AJAX 提交 ===============
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/user/add',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    dataType: 'json',
                    success: function(response) {
                        if (response.code === 0) {
                            layer.msg('添加成功', { icon: 1 });
                            // $('#sample-table').DataTable().ajax.reload(); // 刷新表格
                            reloadUserTable(); // 成功后刷新表格
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

    /*用户-查看*/
    function member_show(title,url,id,w,h){
        layer_show(title,url+'#?='+id,w,h);
    }

    /*用户-编辑*/
    function member_edit(userid) {
        // console.log("userid:" + userid);
        var editForm = $('#add_menber_style').clone(true, true).removeAttr('style');

        $.ajax({
            url: "${pageContext.request.contextPath}/admin/user/findUserById",
            type: 'GET',
            data: { userid: userid },
            dataType: 'json',
            beforeSend: function() {
                layer.load(1); // loading 动画
            },
            success: function(response) {
                layer.closeAll('loading');
                if (response.code === 0) {
                    var user = response.obj;
                    console.log("user:", user);

                    layer.open({
                        type: 1,
                        title: '修改用户信息',
                        maxmin: true,
                        shadeClose: false,
                        area: ['800px', ''],
                        content: editForm.prop('outerHTML'),
                        btn: ['提交', '取消'],
                        success: function(layero, index) {
                            // 在弹出的layer内部找到表单
                            var form = $(layero).find('#add_menber_style');

                            // 填充表单字段
                            form.find("[name='username']").val(user.username || '');
                            form.find("[name='phone']").val(user.phone || '');
                            form.find("[name='email']").val(user.email || '');
                            form.find("[name='address']").val(user.address || '');

                            // 单选按钮特殊处理
                            // ??只对null和defined进行操作，而不会对0和空字符串进行操作。
                            form.find("[name='gender'][value='" + (user.gender ?? '') + "']").prop('checked', true);
                            form.find("[name='role'][value='" + (user.role ?? '') + "']").prop('checked', true);
                            form.find("[name='status'][value='" + (user.status ?? '') + "']").prop('checked', true);
                        },
                        yes: function(index, layero) {
                            var form = $(layero).find('#add_menber_style');
                            var num = 0;
                            var str = "";

                            form.find("input[type$='text'], select").each(function() {
                                if ($(this).val() == "") {
                                    layer.alert(str += "" + $(this).attr("name") + "不能为空！\r\n", {
                                        title: '提示框',
                                        icon: 0,
                                    });
                                    num++;
                                    return false;
                                }
                            });

                            if (num > 0) {
                                return false;
                            } else {
                                var formData = {};
                                //补个userid，因为表单中没有这个字段
                                formData['userid'] = userid;
                                form.find("input[type$='text'], select, input[type='radio']:checked").each(function() {
                                    formData[$(this).attr("name")] = $(this).val();
                                });

                                $.ajax({
                                    url: "${pageContext.request.contextPath}/admin/user/update",
                                    type: 'POST',
                                    contentType: 'application/json',
                                    data: JSON.stringify(formData),
                                    dataType: 'json',
                                    beforeSend: function() {
                                        layer.load(1); // loading 动画
                                    },
                                    success: function(response) {
                                        layer.closeAll('loading');
                                        if (response.code === 0) {
                                            layer.alert('修改成功！', {
                                                title: '提示框',
                                                icon: 1,
                                            });
                                            layer.close(index);
                                            // 这里可以刷新页面或者表格
                                            reloadUserTable(); // 成功后刷新表格
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
                        }
                    });
                } else {
                    layer.alert('未找到用户信息', {icon: 2});
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                const errorResponse = xhr.responseJSON || {};
                const errorMsg = errorResponse.msg || '服务器错误 (' + xhr.status + ')';
                layer.alert('获取用户信息失败: ' + errorMsg, { icon: 2 });
            }
        });
    }

    /*用户-删除*/
    function member_del(obj, userid) {
        // console.log('Deleting user with ID:', userid); // 添加这一行
        layer.confirm('确认要删除吗？', function(index) {
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/user/delete",
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ userid: userid }),
                // data: { userid: userid },
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

    // 初始化日期选择器
    laydate.render({
        elem: '#start',
        type: 'datetime',
        range: '~',
        format: 'yyyy-MM-dd HH:mm:ss'
    });



</script>
