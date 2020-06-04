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

                var wenList = [];
                var xList = [];
                var dataList = [];

                var dataType = [];


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
                            chuanId.push(arr[i].id);
                            chuanStr += '<input type="checkbox" name="cids" value = "'+arr[i].id+'" title="'+arr[i].cname+'" checked>';
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
                            var arr = data.chuanList;
                            var chuanStr = "";
                            for(var i = 0;i<arr.length;i++){
                                // chuanId.push(arr[i].id)
                                chuanStr += '<input type="checkbox" name="cids" value = "'+arr[i].id+'" title="'+arr[i].cname+'" checked>';
                            }
                            $("#chuan").html(chuanStr);
                            form.render();
                        }
                    });
                })

                // chuanId.push("2")
                $.ajax({
                    type:"POST",
                    async: false,  //默认true,异步
                    dataType:"json",
                    data:{"gid":beginGrowId,"cids":chuanId.join(";")},
                    url:"${path}/chuan/getGrowsChuanById.action",
                    success:function(data){
                        dataList = data.data;
                        if(dataList.length>0){
                        var index = dataList[0].cid;
                        for(var i = 0;i<dataList.length;i++){
                            if(dataList[i].cid == index){
                                xList.push(dataList[i].time);
                            }
                            if(dataType.indexOf(dataList[i].cid+"号传感器")>-1){
                                continue;
                            }else{
                                dataType.push(dataList[i].cid+"号传感器")
                            }
                        }}
                        fourEcharts(dataList,dataType,xList)
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



                form.on('submit(*)', function(data){
                    dataType = [];
                    xList = [];
                    // layer.confirm('确定添加?', function(index){
                    //     console.log(getFormData("#myForm"));/
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"json",
                        data:getFormData("#myForm"),
                        url:"${path}/chuan/getGrowsChuanById.action",
                        success:function(data){
                            dataList = data.data;
                            if(dataList.length>0){
                                var temp = dataList[0].cid;
                                for(var i = 0;i<dataList.length;i++){
                                    if(temp == dataList[i].cid){
                                        xList.push(dataList[i].time);
                                    }
                                    if(dataType.indexOf(dataList[i].cid+"号传感器")>-1){
                                        continue;
                                    }else{
                                        dataType.push(dataList[i].cid+"号传感器")
                                    }
                                }
                            }

                            fourEcharts(dataList,dataType,xList)
                        }
                    });
                    // });
                    // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                    // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });



            });
        })

        function fourEcharts(dataList,dataType,xList){
            console.log(dataList)
            console.log(dataType)
            console.log(xList)
            //    温度
            //    温度
            //    温度
            //    温度
            //    温度
            //    温度

            var myChart_wen = echarts.init(document.getElementById('wen'));
            var option_wen = {

                title: {text: '温度曲线图',show:true},
                backgroundColor: '#FFFFFF',tooltip : {/*//鼠标浮动时的工具条，显示鼠标所在区域的数据，trigger这个地方每种图有不同的设置*/trigger: 'axis'},
                legend: {data:dataType},
                calculable : true,
                xAxis : [{axisLabel:{/*// rotate: 40,*/interval:0,textStyle: {fontSize : 7 },formatter:function(value){return value.split(" ").join("\n");}},
                    axisLine:{lineStyle :{color: '#CCCCCC'}},
                    type : 'category',
                    boundaryGap : false,//从0刻度开始
                    data : xList}],
                yAxis : [{type : 'value',min:10,max:50,interval:5,axisLine:{lineStyle :{color: '#CCCCCC'}}}],
                series : []
            };
            myChart_wen.setOption(option_wen);

            //湿度
            var myChart_shi = echarts.init(document.getElementById('shi'));
            var option_shi = {

                title: {text: '湿度曲线图',show:true},
                backgroundColor: '#FFFFFF',tooltip : {/*//鼠标浮动时的工具条，显示鼠标所在区域的数据，trigger这个地方每种图有不同的设置*/trigger: 'axis'},
                legend: {data:dataType},
                calculable : true,
                xAxis : [{axisLabel:{/*// rotate: 40,*/interval:0,textStyle: {fontSize : 7 },formatter:function(value){return value.split(" ").join("\n");}},
                    axisLine:{lineStyle :{color: '#CCCCCC'}},
                    type : 'category',
                    boundaryGap : false,//从0刻度开始
                    data : xList}],
                yAxis : [{type : 'value',min:20,max:100,interval:10,axisLine:{lineStyle :{color: '#CCCCCC'}}}],
                series : []
            };
            myChart_shi.setOption(option_shi);

            // 二氧化碳
            var myChart_er = echarts.init(document.getElementById('er'));
            var option_er = {

                title: {text: '二氧化碳曲线图',show:true},
                backgroundColor: '#FFFFFF',tooltip : {/*//鼠标浮动时的工具条，显示鼠标所在区域的数据，trigger这个地方每种图有不同的设置*/trigger: 'axis'},
                legend: {data:dataType},
                calculable : true,
                xAxis : [{axisLabel:{/*// rotate: 40,*/interval:0,textStyle: {fontSize : 7 },formatter:function(value){return value.split(" ").join("\n");}},
                    axisLine:{lineStyle :{color: '#CCCCCC'}},
                    type : 'category',
                    boundaryGap : false,//从0刻度开始
                    data : xList}],
                yAxis : [{type : 'value',min:0, max:20,interval:4,axisLine:{lineStyle :{color: '#CCCCCC'}}}],
                series : []
            };
            myChart_er.setOption(option_er);

            // 光照
            var myChart_guang = echarts.init(document.getElementById('guang'));
            var option_guang = {

                title: {text: '光照曲线图',show:true},
                backgroundColor: '#FFFFFF',tooltip : {/*//鼠标浮动时的工具条，显示鼠标所在区域的数据，trigger这个地方每种图有不同的设置*/trigger: 'axis'},
                legend: {data:dataType},
                calculable : true,
                xAxis : [{axisLabel:{/*// rotate: 40,*/interval:0,textStyle: {fontSize : 7 },formatter:function(value){return value.split(" ").join("\n");}},
                    axisLine:{lineStyle :{color: '#CCCCCC'}},
                    type : 'category',
                    boundaryGap : false,//从0刻度开始
                    data : xList}],
                yAxis : [{type : 'value',min:0, max:400,interval:50,axisLine:{lineStyle :{color: '#CCCCCC'}}}],
                series : []
            };
            myChart_guang.setOption(option_guang);


            for (var i = 0; i < option_wen.series.length; i++) {
                option_wen.series[i].data = [];
                option_wen.series[i].name = "";
                option_shi.series[i].data = [];
                option_shi.series[i].name = "";
                option_er.series[i].data = [];
                option_er.series[i].name = "";
                option_guang.series[i].data = [];
                option_guang.series[i].name = "";

            }

            myChart_wen.setOption(option_wen,true);
            myChart_shi.setOption(option_shi,true);
            myChart_er.setOption(option_er,true);
            myChart_guang.setOption(option_guang,true);


            var wenDate = [];
            var wenObj = {};
            var shiDate = [];
            var shiObj = {};
            var guangDate = [];
            var guangObj = {};
            var erDate = [];
            var erObj = {};
            for(var i = 0;i<dataType.length;i++){
                var wenList = [];
                var shiList = [];
                var erList = [];
                var guangList = [];
                for(var j = 0;j<dataList.length;j++){
                    if(dataType[i].substring(0,1) == dataList[j].cid){
                        wenList.push(dataList[j].wen);
                        shiList.push(dataList[j].shi);
                        erList.push(dataList[j].er);
                        guangList.push(dataList[j].guang);
                    }
                }
                wenObj = {
                    name:dataType[i],
                    type:'line',
                    // symbol:'none',//原点
                    smooth: 0.2,//弧度
                    data: wenList
                }
                shiObj = {
                    name:dataType[i],
                    type:'line',
                    // symbol:'none',//原点
                    smooth: 0.2,//弧度
                    data: shiList
                }
                erObj = {
                    name:dataType[i],
                    type:'line',
                    // symbol:'none',//原点
                    smooth: 0.2,//弧度
                    data: erList
                }
                guangObj = {
                    name:dataType[i],
                    type:'line',
                    // symbol:'none',//原点
                    smooth: 0.2,//弧度
                    data: guangList
                }
                wenDate.push(wenObj);
                shiDate.push(shiObj);
                erDate.push(erObj);
                guangDate.push(guangObj);
            }
            myChart_wen.setOption({
                series: wenDate
            });
            myChart_shi.setOption({
                series: shiDate
            });
            myChart_er.setOption({
                series: erDate
            });
            myChart_guang.setOption({
                series: guangDate
            });




        }



        function getFormData(formId){
            var data = {};
            var results = $(formId).serializeArray();
            $.each(results,function(index,item){
                //文本表单的值不为空才处理
                if(item.value && $.trim(item.value)!=""){
                    if(!data[item.name]){
                        data[item.name]=item.value;
                    }else{
                        //name属性相同的表单，值以英文,拼接
                        data[item.name]=data[item.name]+';'+item.value;
                    }
                }
            });
            //console.log(data);
            return data;
        }
    </script>
</head>
<body style="overflow-x: hidden; background-color: white;margin: 10px;padding: 10px;">
<form class = "layui-form" id = "myForm">
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
            <select name="gid" id = "grow" lay-filter="grow" style="width: 170px;" >
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
    <button type="button" class="layui-btn" id="chakan" lay-submit lay-filter="*">查看</button>
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
