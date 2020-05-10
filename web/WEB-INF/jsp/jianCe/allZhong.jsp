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
    <title>种植大棚列表</title>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <script type='text/javascript' src='${path }/dwr/engine.js'></script>
    <script type='text/javascript' src='${path }/dwr/util.js'></script>
    <script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>
    <script type="text/javascript">
        var layer = null;
        var table = null;
        var element = null;
        $(function(){


            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();





            layui.use(['layer','element','form','table'],function(){
                layer = layui.layer;
                element = layui.element;
                var form = layui.form;
                table = layui.table;


                table.render({
                    elem: '#test'
                    ,url: '${path}/chuan/getAllZhong.action' //数据接口
                    ,page: true //开启分页
                    ,limit:10
                    ,limits:[10]
                    ,cols: [[ //表头
                        {type:'numbers',title:'序号',fixed:'left'},
                        {field: 'growName', title: '种植园名称',align:"center" }
                        ,{field: 'memo', title: "备注"}
                        ,{field: 'chuanGanList', title: '传感器',templet:function (d) {
                            var str = "";
                            var arr = d.chuanGanList;
                            for(var i = 0;i<arr.length;i++){
                                if(i==arr.length-1){
                                    str += arr[i].chuan.cname
                                }else{
                                    str += arr[i].chuan.cname+";"
                                }
                            }
                                return str;
                            }}
                        ,{field: 'memo', title: "温度范围",templet:function (d) {
                            if(d.startWen==""|| d.startWen==null){
                                return "";
                            }else{
                                return d.startWen+"~"+d.endWen;
                            }
                            }}
                        ,{field: 'memo', title: "湿度范围",templet:function (d) {
                                if(d.startShi==""|| d.startShi==null){
                                    return "";
                                }else{

                                    return d.startShi+"~"+d.endShi;
                                }
                            }}
                        ,{field: 'memo', title: "照度范围",templet:function (d) {
                                if(d.startGuang=="" || d.startGuang==null){
                                    return "";
                                }else{
                                    return d.startGuang+"~"+d.endGuang;
                                }
                            }}
                        ,{field: 'memo', title: "二氧化碳范围",templet:function (d) {
                                if(d.startEr==""|| d.startEr==null){
                                    return "";
                                }else{
                                    return d.startEr+"~"+d.endEr;
                                }
                            }}
                        ,{field: 'id', title: '操作',templet:function (d) {
                                var html = "";
                                html += '<button type="button" class="layui-btn  layui-btn-sm" onclick="editRowOne(\''+d.id+'\')" >配置</button>';
                                html += '<button type="button" class="layui-btn layui-btn-danger layui-btn-sm" onclick="deleteRowOne(\''+d.id+'\')">删除</button>';
                                return html;
                            }}
                    ]],
                });


                $("#peiAll").click(function(){
                    layer.open({
                        type: 2,
                        title:"配置参数",
                        area: ['460px','460px'],
                        content: '${path}/chuan/toPeiAll.action',
                        zIndex: layer.zIndex, //重点1
                        success: function(layero){
                            layer.setTop(layero); //重点2
                        },
                        end:function(){
                            table.reload("test");
                        }

                    });
                })

                $("#addPeng").click(function(){
                    layer.open({
                        type: 2,
                        title:"添加大棚",
                        area: ['400px','360px'],
                        content: '${path}/chuan/toAddPeng.action',
                        zIndex: layer.zIndex, //重点1
                        success: function(layero){
                            layer.setTop(layero); //重点2
                        },
                        end:function(){
                            table.reload("test");
                        }

                    });
                    <%--$.ajax({--%>
                        <%--url:"${path}/chuan/checkChuanNoUse.action",--%>
                        <%--type:"post",--%>
                        <%--dataType:"text",--%>
                        <%--async:false,--%>
                        <%--success: function(data) {--%>
                            <%--if(parseInt(data) == "0"){--%>
                                <%--layer.msg("传感器已分配完！");--%>
                                <%--return ;--%>
                            <%--}else{--%>
                                <%--layer.open({--%>
                                    <%--type: 2,--%>
                                    <%--title:"添加大棚",--%>
                                    <%--area: ['400px','360px'],--%>
                                    <%--content: '${path}/chuan/toAddPeng.action',--%>
                                    <%--zIndex: layer.zIndex, //重点1--%>
                                    <%--success: function(layero){--%>
                                        <%--layer.setTop(layero); //重点2--%>
                                    <%--},--%>
                                    <%--end:function(){--%>
                                        <%--table.reload("test");--%>
                                    <%--}--%>

                                <%--});--%>
                            <%--}--%>
                        <%--}--%>
                    <%--});--%>

                });

                // $("#chaxun").click(function () {
                //     var realName = $("#realName").val();
                //     var userName = $("#userName").val();
                //     var userType = $("#userType").val();
                //
                //     table.reload('test', {
                //         where: { //设定异步数据接口的额外参数，任意设
                //             realName: realName
                //             ,userName: userName
                //             ,userType:userType
                //         }
                //         ,page: {
                //             curr: 1 //重新从第 1 页开始
                //         }
                //     });
                // });


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

        function showMessage(data){
            // // console.log(data)
            // // console.log($("#chuanMsg").html());
            // var id = data.substring(data.indexOf("ID:")+3,data.indexOf("Temp")).trim();
            // if($("#chuanMsg").html().isEmpty() && chuanList.indexOf(id)==-1){
            //     chuanList.push(id);
            //     $("#chuanMsg").html('<button type="button" class="layui-btn xuan" id = '+id+'>'+id+'号传感器</button>');
            // }
            // // element.init();
        }
        function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/growing/index/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}


        String.prototype.isEmpty = function () {
            var s1 = this.replace(/[\r\n]/g, '').replace(/[ ]/g, ''),
                s2 = (s1 == '') ? true : false;
            return s2;
        };

    </script>
</head>
<body style="overflow-x: hidden; background-color: white;margin: 10px;padding: 10px;">

<div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>种植大棚管理</legend>
    </fieldset>
    <div class="first_div" style="border-right: none; border-bottom: none; border-left: none;">
        <button type="button" class="layui-btn" id="addPeng">添加大棚</button>
        <button type="button" class="layui-btn" id="peiAll">全部配置</button>
        <table id="test" lay-filter="test" ></table>
    </div>
</div>


<%--<div id="add_iframe" style="display: none; width: 100%; height: 100%;">--%>
<%--<iframe frameborder="0" src=""--%>
<%--style="width: 100%; height: 100%; border: none;"></iframe>--%>
<%--</div>--%>

</body>
</html>
