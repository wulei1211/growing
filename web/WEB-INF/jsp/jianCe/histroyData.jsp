<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/10
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <title>历史环境数据</title>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <script src="${path}/js/echars/echars.js"></script>
    <script type="text/javascript">

        var growsList = ${growsList};
        $(function(){
            layui.use(['layer','element','form','laydate'],function() {
                var layer = layui.layer;
                var element = layui.element;
                var form = layui.form;
                var laydate = layui.laydate;


                var growStr = "";
                var beginGrowId = "";
                for(var i = 0;i<growsList.length;i++){
                    beginGrowId = growsList[0].id;
                    growStr += '<option value="'+growsList[i].id+'">'+growsList[i].growName+'</option>'
                }

                $("#grow").html(growStr);

                form.render('select');

                $.ajax({
                    type:"POST",
                    async: false,  //默认true,异步
                    dataType:"json",
                    data:{"gid":beginGrowId},
                    url:"${path}/chuan/getChuanListByGrowId.action",
                    success:function(data){
                        var arr = data.chuanList;
                        var chuanStr = "";
                        for(var i = 0;i<arr.length;i++){
                            chuanStr += '<option value="'+arr[i].id+'">'+arr[i].cname+'</option>';
                        }
                        $("#chuan").html(chuanStr);
                        form.render('select');
                    }
                });

                form.on('select(grow)', function(d){
                    $("#chuan").html("");
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"json",
                        data:{"gid":d.value},
                        url:"${path}/chuan/getChuanListByGrowId.action",
                        success:function(data){
                            console.log(data)
                            var arr = data.chuanList;
                            var chuanStr = "";
                            for(var i = 0;i<arr.length;i++){
                                chuanStr += '<option value="'+arr[i].id+'">'+arr[i].cname+'</option>';
                            }
                            $("#chuan").html(chuanStr);
                            form.render('select');
                        }
                    });
                })


                var nowTime=new Date();
                var startTime=laydate.render({
                    elem:'#startTime',
                    type:'datetime',
                    max:'nowTime',//默认最大值为当前日期
                    done:function(value,date){
                        endTime.config.min={
                            year:date.year,
                            month:date.month-1,//关键
                            date:date.date,
                            hours:date.hours,
                            minutes:date.minutes,
                            seconds:date.seconds
                        };
                    }
                })

                var endTime=laydate.render({
                    elem:'#endTime',
                    type:'datetime',
                    done:function(value,date){
                        startTime.config.max={
                            year:date.year,
                            month:date.month-1,//关键
                            date:date.date,
                            hours:date.hours,
                            minutes:date.minutes,
                            seconds:date.seconds
                        }
                    }
                })

            });
        })
    </script>
</head>
<body style="overflow-x: hidden; background-color: white;margin: 10px;padding: 10px;">
<form class = "layui-form">
<div class="layui-form-item ">
    <div class="layui-inline">
        <label class="layui-form-label">时间范围：</label>
        <div class="layui-input-inline"  style="width: 170px;" >
            <input type="text" name="startTime" id = "startTime" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-mid">-</div>
        <div class="layui-input-inline" style="width: 170px;">
            <input type="text" name="endTime" id = "endTime" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">种植园：</label>
        <div class="layui-input-block">
            <select name="grow" id = "grow" lay-filter="grow" style="width: 170px;" >
                <%--<option value=""></option>--%>
                <%--<option value="0">写作</option>--%>
                <%--<option value="1" selected="">阅读</option>--%>
                <%--<option value="2">游戏</option>--%>
                <%--<option value="3">音乐</option>--%>
                <%--<option value="4">旅行</option>--%>
            </select>
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">传感器：</label>
        <div class="layui-input-block">
            <select name="chuan" id = "chuan" lay-filter="chuan" style="width: 150px;" >
                <%--<option value=""></option>--%>
                <%--<option value="0">写作</option>--%>
                <%--<option value="1" selected="">阅读</option>--%>
                <%--<option value="2">游戏</option>--%>
                <%--<option value="3">音乐</option>--%>
                <%--<option value="4">旅行</option>--%>
            </select>
        </div>
    </div>
    <button type="button" class="layui-btn" id="chakan">查看</button>
</div>
</form>




</body>
</html>
