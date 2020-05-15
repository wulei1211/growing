<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/15
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <script type="text/javascript">
        var layer = null;
        var table = null;
        $(function(){
            layui.use(['layer','element','form','table','laydate'],function() {
                layer = layui.layer;
                var element = layui.element;
                var form = layui.form;
                table = layui.table;
                var laydate = layui.laydate;

                table.render({
                    elem: '#test'
                    ,url: '${path}/artical/getAllPingLun.action' //数据接口
                    ,page: true //开启分页
                    ,limit:10
                    ,limits:[10]
                    // ,toolbar:"#test"
                    // ,defaultToolbar: ['exports']
                    ,cols: [[ //表头
                        {type:'numbers',title:'序号',fixed:'left'},
                        {field: 'articleTitle', title: '所属文章',align:"center",templet:function(d){
                            return d.article.articleTitle;
                            } }
                        ,{field: 'typeName', title: '用户',align:"center",templet:function(d){
                                return d.realName;
                            }  }
                        ,{field: 'pingLunContent', title: '评论内容',align:"center" }
                        ,{field: 'time', title: '评论时间' ,align:"center"  }
                        ,{field: 'id', title: '操作',align:"center" ,templet:function (d) {
                            // console.log(d)
                                var html = "";
                                html += '<button type="button" class="layui-btn layui-btn-danger layui-btn-sm" onclick="deleteRowOne(\''+d.id+'\')">删除</button>';
                                return html;
                            }}
                    ]],
                });
            });
        });
        function deleteRowOne(val) {
            layer.confirm('确定删除?', function(index){
                // console.log(getFormData("#myForm"));
                $.ajax({
                    type:"POST",
                    async: false,  //默认true,异步
                    data:{"pId":val},
                    dataType:"text",
                    url:"${path}/artical/deletePing.action",
                    success:function(data){
                        if(data == "success"){
                            layer.msg("删除成功！")
                            table.reload("test");
                        }
                    }
                });
            });
        }

    </script>
    <title>评论列表</title>

</head>
<body style="overflow-x: hidden; background-color: white;margin: 10px;padding: 10px;">
<div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>评论管理</legend>
    </fieldset>
    <div class="first_div"
         style="border-right: none; border-bottom: none; border-left: none;">
        <%--<div class="layui-form-item">--%>
            <%--<div class="layui-inline">--%>
                <%--<label class="layui-form-label">文章标题：</label>--%>
                <%--<div class="layui-input-inline">--%>
                    <%--<input type="text" id="articleTitle" name="articleTitle" autocomplete="off" class="layui-input">--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="layui-inline">--%>
                <%--<label class="layui-form-label">文章类型：</label>--%>
                <%--<div class="layui-input-inline">--%>
                    <%--<form class = "layui-form">--%>
                        <%--<select id="articleType" name="articleType">--%>
                            <%--<option value = "">全部</option>--%>

                        <%--</select>--%>
                    <%--</form>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="layui-inline">--%>
                <%--<label class="layui-form-label">发表时间：</label>--%>
                <%--<div class="layui-input-inline" style="width: 150px;">--%>
                    <%--<input type="text" name="startTime" id="startTime" placeholder="起始时间" autocomplete="off" class="layui-input">--%>
                <%--</div>--%>
                <%--<div class="layui-form-mid">-</div>--%>
                <%--<div class="layui-input-inline" style="width: 150px;">--%>
                    <%--<input type="text" id="endTime" name="endTime" placeholder="结束时间" autocomplete="off" class="layui-input" >--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="layui-inline">--%>
                <%--<button type="button" class="layui-btn  layui-btn-sm  layui-btn-warm" id = "chaxun">查看</button>--%>
                <%--&lt;%&ndash;<button type="button" class="layui-btn  layui-btn-sm  layui-btn-warm" id= "tianjia" &lt;%&ndash;onclick="addRow()"&ndash;%&gt;>增加用户</button>&ndash;%&gt;--%>
            <%--</div>--%>

        <%--</div>--%>

        <table id="test" lay-filter="test" ></table>

    </div>
</div>
</body>
</html>
