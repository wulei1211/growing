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
    <title>传感器列表</title>
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
        var chuanList = ${chuanList};
        console.log(chuanList)
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
                    ,url: '${path}/chuan/getAllChuan.action' //数据接口
                    ,page: true //开启分页
                    ,limit:10
                    ,limits:[10]
                    ,cols: [[ //表头
                        {type:'numbers',title:'序号',fixed:'left'},
                        {field: 'id', title: '传感器编号',align:"center" }
                        ,{field: 'cname', title: "传感器名称"}
                        ,{field: 'status', title: '是否启用',templet:function (d) {
                            if(d.status == "0"){
                                return '<input type="checkbox" checked="" name="open" id = "'+d.id+'" lay-skin="switch" lay-filter="switchTest" lay-text="ON|OFF">'
                            }else{
                                return '<input type="checkbox" name="close" lay-skin="switch" id = "'+d.id+'"  lay-filter="switchTest" lay-text="ON|OFF">'
                            }
                            }}
                    ]],
                });

                form.on('switch(switchTest)', function (data) {
                    var status = "";
                    console.log(data.elem.checked);
                    if(data.elem.checked){
                        status = "0";
                    }else{
                        status = "1"
                    }
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"text",
                        data:{"id":$(data.elem).attr("id"),"status":status},
                        url:"${path}/chuan/updateChuanStatus.action",
                        success:function(data){

                        }
                    });
                    // layer.open({
                    //     content: '确定'
                    //     ,btn: ['确定', '取消']
                    //     ,yes: function(index, layero){
                    //         data.elem.checked=x;
                    //         form.render();
                    //         layer.close(index);
                    //         //按钮【按钮一】的回调
                    //     }
                    //     ,btn2: function(index, layero){
                    //         //按钮【按钮二】的回调
                    //         data.elem.checked=!x;
                    //         form.render();
                    //         layer.close(index);
                    //         //return false 开启该代码可禁止点击该按钮关闭
                    //     }
                    //     ,cancel: function(){
                    //         //右上角关闭回调
                    //         data.elem.checked=!x;
                    //         form.render();
                    //         //return false 开启该代码可禁止点击该按钮关闭
                    //     }
                    // });
                    return false;
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

                //扫描
                var index = null;
                $("#sao").click(function(){
                    index = layer.open({
                        type: 1,
                        title:"扫描传感器",
                        area: ['300','360px'],
                        content: $("#chuanMsg"),
                        zIndex: layer.zIndex, //重点1
                        success: function(layero){
                            layer.setTop(layero); //重点2
                            $.ajax({
                                type:"POST",
                                async: false,  //默认true,异步
                                dataType:"text",
                                url:"${path}/chuan/getData.action",
                            });
                        },
                        end:function(){
                            $.ajax({
                                type:"POST",
                                async: false,  //默认true,异步
                                dataType:"text",
                                url:"${path}/chuan/closeDate.action",
                            });
                            table.reload("test");
                        }

                    });
                });

                $(document).on("click",".xuan",function(){
                    var val = $(this).text();
                    var id = val.substring(0,val.indexOf("号"))
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"text",
                        url:"${path}/chuan/closeDate.action",
                    });
                    var data = {"id":id,"cname":val};
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        contentType:"application/json",
                        dataType:"json",
                        data:JSON.stringify(data),
                        url:"${path}/chuan/addChuan.action",
                        success:function(data){
                            $("#chuanMsg").html("");
                            layer.close(index)
                            table.reload("test");
                        }
                    });

                })

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

        function showMessage(data){
            // console.log(data)
            // console.log($("#chuanMsg").html());
            var id = data.substring(data.indexOf("ID:")+3,data.indexOf("Temp")).trim();
            if($("#chuanMsg").html().isEmpty() && chuanList.indexOf(id)==-1){
                chuanList.push(id);
                $("#chuanMsg").html('<button type="button" class="layui-btn xuan" id = '+id+'>'+id+'号传感器</button>');
            }
            // element.init();
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
        <legend>传感器管理</legend>
    </fieldset>
    <div class="first_div" style="border-right: none; border-bottom: none; border-left: none;">
        <button type="button" class="layui-btn" id="sao">扫描</button>
        <table id="test" lay-filter="test" ></table>
    </div>
</div>

<div id = "chuanMsg" style = "display: none;padding: 5px 5px 5px 5px">
</div>

<%--<div id="add_iframe" style="display: none; width: 100%; height: 100%;">--%>
<%--<iframe frameborder="0" src=""--%>
<%--style="width: 100%; height: 100%; border: none;"></iframe>--%>
<%--</div>--%>

</body>
</html>
