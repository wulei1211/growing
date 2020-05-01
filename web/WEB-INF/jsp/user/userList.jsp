<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/1
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <title>用户列表</title>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <script type="text/javascript">
        var layer = null;
        var table = null;
        $(function(){

            layui.use(['layer','element','form','table'],function(){
                layer = layui.layer;
                var element = layui.element;
                var form = layui.form;
                table = layui.table;


                table.render({
                    elem: '#test'
                    ,url: '${path}/user/getManageUserByMap.action' //数据接口
                    ,page: true //开启分页
                    ,limit:10
                    ,limits:[10]
                    ,cols: [[ //表头
                        {type:'numbers',title:'序号',fixed:'left'},
                        {field: 'headImg', title: '头像',align:"center",templet:function(d){
                            return '<img src = "'+d.headImg+'" style = "width:28px;height:28px;border-radius: 50%"/>';
                            }}
                        ,{field: 'userName', title: '账号'}
                        ,{field: 'realName', title: '昵称'}
                        ,{field: 'userType', title: '用户等级',templet:function(d){
                                if(d.userType == 2){
                                    return "管理员";
                                }else if(d.userType == 1) {
                                    return "用户";
                                }
                            }}
                        ,{field: 'gender', title: '性别',templet:function(d){
                                if(d.gender == 0){
                                    return "男";
                                }else if(d.gender == 1) {
                                    return "女";
                                }
                            }}
                        ,{field: 'phone', title: '移动电话'}
                        ,{field: 'email', title: '邮箱'}
                        ,{field: 'memo', title: '个性签名'}
                        ,{field: 'id', title: '操作',templet:function (d) {
                                var html = "";
                                html += '<button type="button" class="layui-btn  layui-btn-sm" onclick="editRowOne(\''+d.id+'\')" >修改</button>';
                                html += '<button type="button" class="layui-btn layui-btn-danger layui-btn-sm" onclick="deleteRowOne(\''+d.id+'\')">禁用</button>';
                                return html;
                            }}
                    ]],
                });

                $("#chaxun").click(function () {
                    var realName = $("#realName").val();
                    var userName = $("#userName").val();
                    var userType = $("#userType").val();

                    table.reload('test', {
                        where: { //设定异步数据接口的额外参数，任意设
                            realName: realName
                            ,userName: userName
                            ,userType:userType
                        }
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                    });
                });

                $("#tianjia").click(function(){
                    layer.open({
                        type: 2,
                        title:"添加用户",
                        area: ['500px','660px'],
                        content: '${path}/user/toUserAdd.action',
                        zIndex: layer.zIndex, //重点1
                        success: function(layero){
                            layer.setTop(layero); //重点2
                        },
                        end:function(){
                            table.reload("test");
                        }

                    });
                });

            });
        })

        function editRowOne(val){
            layer.open({
                type: 2,
                title:"编辑用户",
                area: ['500px','660px'],
                content: '${path}/user/toUserEidt.action?userId='+val,
                zIndex: layer.zIndex, //重点1
                success: function(layero){
                    layer.setTop(layero); //重点2
                },
                end:function(){
                    table.reload("test");
                }

            });
        }

        function deleteRowOne(val) {
            layer.confirm('确定禁用?', function(index){
                // console.log(getFormData("#myForm"));
                $.ajax({
                    type:"POST",
                    async: false,  //默认true,异步
                    data:{"id":val},
                    dataType:"text",
                    url:"${path}/user/userDel.action",
                    success:function(data){
                        if(data == "success"){
                            layer.msg("禁用成功！")
                            table.reload("test");
                        }
                    }
                });
            });
        }

    </script>
</head>
<body style="overflow-x: hidden; background-color: white;margin: 10px;padding: 10px;">

<div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>管理员管理</legend>
    </fieldset>
    <div class="first_div"
         style="border-right: none; border-bottom: none; border-left: none;">


        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">昵称：</label>
                <div class="layui-input-inline">
                    <input type="text" id="realName" name="realName" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">账号：</label>
                <div class="layui-input-inline">
                    <input type="text" id="userName" name="userName" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">等级：</label>
                <div class="layui-input-inline">
                    <form class = "layui-form">
                        <select id="userType" name="userType">
                            <option value="">全部</option>
                            <option value="1">用户</option>
                            <option value="2">管理员</option>
                        </select>
                    </form>
                </div>
            </div>

            <div class="layui-inline">
                <button type="button" class="layui-btn  layui-btn-sm  layui-btn-warm" id = "chaxun">查看</button>
                <button type="button" class="layui-btn  layui-btn-sm  layui-btn-warm" id= "tianjia" <%--onclick="addRow()"--%>>增加用户</button>
            </div>

        </div>

        <div style="margin: 3px 10px 10px 10px;"></div>

        <table id="test" lay-filter="test" ></table>
        <div id="paginator11-1" align="right" style="margin-right: 10px;"></div>

    </div>
</div>

<%--<div id="add_iframe" style="display: none; width: 100%; height: 100%;">--%>
    <%--<iframe frameborder="0" src=""--%>
            <%--style="width: 100%; height: 100%; border: none;"></iframe>--%>
<%--</div>--%>

</body>
</html>
