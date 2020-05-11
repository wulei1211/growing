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
                var chuanId = [];
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
                            chuanId.push(arr[0].id);
                            chuanStr += '<input type="checkbox" name="cids" value = "'+arr[0].id+'" title="'+arr[0].cname+'" checked>';
                        }
                        $("#chuan").html(chuanStr);
                        form.render();
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
                                // chuanId.push(arr[i].id)
                                chuanStr += '<input type="checkbox" name="cids" value = "'+arr[0].id+'" title="'+arr[0].cname+'">';
                            }
                            $("#chuan").html(chuanStr);
                            form.render();
                        }
                    });
                })

                $.ajax({
                    type:"POST",
                    async: false,  //默认true,异步
                    dataType:"json",
                    data:{"gid":beginGrowId,"cids":chuanId.join(";")},
                    url:"${path}/chuan/getGrowsChuanById.action",
                    success:function(data){
                        var data = data.data;
                        for(var i = 0;i<)
                    }
                });


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
                });



            //    温度
            //    温度
            //    温度
            //    温度
            //    温度
            //    温度

                var myChart_wen = echarts.init(document.getElementById('wen'));
                var option_wen = {

                    title: { //图表标题，可以通过show:true/false控制显示与否，subtext:'二级标题',
                        text: '温度曲线图',
                        show:true
                    },
                    backgroundColor: '#FFFFFF',

                        tooltip : {//鼠标浮动时的工具条，显示鼠标所在区域的数据，trigger这个地方每种图有不同的设置
                        trigger: 'axis'
                    },
                    calculable : true,
                    xAxis : [
                        {
                            axisLabel:{
                                rotate: 30,
                                interval:0
                            },
                            axisLine:{
                                lineStyle :{
                                    color: '#CCCCCC'
                                }
                            },
                            type : 'category',
                            boundaryGap : false,//从0刻度开始
                            // data:[]  X轴的定义
                            data : function (){
                                var list = [];
                                for (var i = 10; i <= 18; i++) {
                                    if(i<= 12){
                                        list.push('2016-'+i + '-01');
                                    }else{
                                        list.push('2017-'+(i-12) + '-01');
                                    }
                                }
                                return list;
                            }()
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value',
                            axisLine:{
                                lineStyle :{
                                    color: '#CCCCCC'
                                }
                            }
                        }
                    ],
                    series : [
                        {
                            name:'温度',
                            type:'line',
                            // symbol:'none',//原点
                            smooth: 0.2,//弧度
                            color:['#5FB878'],
                            // data:Y轴数据
                            data:[500,100,200,400,600,150,750,800,400,250,650,350]
                        },
                    ]
                };
                myChart_wen.setOption(option_wen);



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
            </select>
        </div>
    </div>

</div>
<div class="layui-form-item ">
    <div class="layui-inline">
        <label class="layui-form-label">传感器：</label>
        <div class="layui-input-block" id = "chuan">
        </div>
    </div>
    <button type="button" class="layui-btn" id="chakan">查看</button>
</div>
</form>

<div style = "width: 100%;height: 300px; display: flex;justify-content: space-between">
    <%--温度--%>
    <div style = "width: 50%;height: 300px;" id="wen">


    </div>
        <%--湿度--%>
    <div style = "width: 50%;height: 300px;" id = "shi">

    </div>
</div>
<div style = "width: 100%;height: 300px; display: flex;justify-content: space-between">
    <%--光照--%>
    <div style = "width: 50%;height: 300px;" id = "guang">

    </div>
        <%--二氧--%>
    <div style = "width: 50%;height: 300px;" id = "er">

    </div>
</div>



</body>
</html>
