<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/8
  Time: 21:33
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
        var element = null;
        $(function(){
            layui.use(['layer','table','element'],function(){
                layer = layui.layer;
                element = layui.element;
                table = layui.table;

                table.render({
                    elem: '#test'
                    ,url: '${path}/chuan/getErrorList.action' //数据接口
                    ,page: true //开启分页
                    ,limit:10
                    ,limits:[10]
                    ,cols: [[ //表头
                        {type:'numbers',title:'序号',fixed:'left'},
                        {field: 'gid', title: '种植园名称',align:"center" }
                        ,{field: 'cid', title: "传感器名称"}
                        ,{field: 'msg', title: '预警信息' }
                        ,{field: 'time', title: '预警时间' }
                        // ,{field: 'id', title: '操作',templet:function (d) {
                        //         var html = "";
                        //         html += '<button type="button" class="layui-btn  layui-btn-sm" onclick="editRowOne(\''+d.id+'\')" >配置</button>';
                        //         html += '<button type="button" class="layui-btn layui-btn-danger layui-btn-sm" onclick="deleteRowOne(\''+d.id+'\')">删除</button>';
                        //         return html;
                        //     }}
                    ]],
                });


            });
        })

        function editRowOne(val){
            layer.open({
                type: 2,
                title:"配置大棚",
                area: ['460px','560px'],
                content: '${path}/chuan/toPengEidt.action?pId='+val,
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
            layer.confirm('确定删除?', function(index){
                // console.log(getFormData("#myForm"));
                $.ajax({
                    type:"POST",
                    async: false,  //默认true,异步
                    data:{"id":val},
                    dataType:"text",
                    url:"${path}/chuan/growDel.action",
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
    <title>预警信息列表</title>
</head>
<body style="overflow-x: hidden; background-color: white;margin: 10px;padding: 10px;">

<div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>预警信息列表</legend>
    </fieldset>
    <div class="first_div" style="border-right: none; border-bottom: none; border-left: none;">
        <table id="test" lay-filter="test" ></table>
    </div>
</div>

</body>
</html>
