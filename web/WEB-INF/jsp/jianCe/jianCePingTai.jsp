<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/6
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <link rel="stylesheet" href="${path}/css/index.css">
    <script type="text/javascript" src="${path}/js/jquery-2.2.1.min.js"></script>
    <script src="${path}/js/rem.js"></script>
    <script src="${path}/js/echars/echars.js"></script>
    <script src="${path}/js/guangxi.js"></script>
    <script src="${path}/js/index.js"></script>
    <script type='text/javascript' src='${path }/dwr/engine.js'></script>
    <script type='text/javascript' src='${path }/dwr/util.js'></script>
    <script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>
    <style>
        .color{
            background-color: #32CD32;
        }
        .border{
            border: 5px solid red;
        }
        .bgcolor{
            background-color: red;
        }
    </style>
    <script type="text/javascript">

        var growsList = ${growsList};
        console.log(growsList)
        var growCount = ${growCount};
        var wendu_val = "0";
        var eryang_val = "0";
        var shi_val = "0";
        var guang_val = "0";
        var MyMarhq = null;
        var type = "";
        var gid = "";
        var xuan_grow = null;
        // var timeDing = null;
        $(document).ready(function(){

            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();
            longPolling();


            var zheng = 0;
            var str = "";

            var dataList = null;
            var erList = [];
            var guangList = [];
            var erXList = [];
            var guangXList = [];
            var tableStr = "";
            for(var i = 0;i<growsList.length;i++){
                var chuanGanList = growsList[i].chuanGanList;
                if(chuanGanList.length == 0){
                    continue;
                }else{
                    for(var j = 0;j<chuanGanList.length;j++){
                        if(chuanGanList[j].chuan.status == "0"){
                            zheng ++;
                        }
                    }
                }
            }
            for(var i = 0;i<growsList.length;i++){
                var chuanGanList = growsList[i].chuanGanList;
                if(chuanGanList.length == 0){
                    tableStr += '<div class = "yuan_ge" id = "'+growsList[i].id+'">'+growsList[i].growName+'</div>';
                    continue;
                }else{
                    for(var j = 0;j<chuanGanList.length;j++){
                        if(chuanGanList[j].chuan.status == "0"){
                            if(j==0){
                                tableStr += '<div class = "yuan_ge color border" id = "'+growsList[i].id+'">'+growsList[i].growName+'</div>';
                                $("#xuan_now").text(growsList[i].growName);
                                gid = growsList[i].id;
                                xuan_grow = growsList[i];
                                type = "1";
                            }else{
                                tableStr += '<div class = "yuan_ge color" id = "'+growsList[i].id+'">'+growsList[i].growName+'</div>';
                            }
                            break;
                        }else{
                            tableStr += '<div class = "yuan_ge" id = "'+growsList[i].id+'">'+growsList[i].growName+'</div>';
                        }
                    }
                }
            }

            //点击切换种植园
            $(document).on("click",".yuan_ge ",function(){
                var name = $(this).text();
                $("#xuan_now").text(name);
                if($(this).hasClass("border")){
                    $(this).removeClass("border");
                }else{
                    $(this).addClass("border");
                    $(this).siblings().removeClass("border");
                }
                if($(this).hasClass("color")){
                    gid = $(this).attr("id");
                    for(var i = 0;i<growsList.length;i++){
                        if(growsList[i].id == gid){
                            xuan_grow = growsList[i];
                            break;
                        }
                    }
                }else{
                    gid = "";
                    // clearInterval(timeDing);
                }
                if(gid == ""){

                    erList = [];
                    guangList = [];
                    erXList = [];
                    guangXList = [];
                    wendu_val = "0";
                    eryang_val = "0";
                    shi_val = "0";
                    guang_val = "0";
                    MyMarhq = null;
                    $("#dataTable").html("");
                    type = "";
                    // closeDate();
                }else{
                    type = "1";
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        data:{"gid":gid},
                        dataType:"json",
                        url:"${path}/chuan/findGrowsDataById.action",
                        success:function(data){

                            dataList = data.dataList;
                            for(var i = 0;i<dataList.length;i++){
                                str += '<tr><td>'+dataList[i].time.substring(dataList[i].time.trim().indexOf(" "))+'</td><td>'+dataList[i].wen+'</td><td>'+dataList[i].shi+'</td><td>'+dataList[i].er+'</td><td>'+dataList[i].guang+'</td></tr>';
                                erList.push(dataList[i].er);
                                erXList.push(dataList[i].time.substring(dataList[i].time.trim().indexOf(" ")));
                                guangList.push(dataList[i].guang);
                                guangXList.push(dataList[i].time.substring(dataList[i].time.trim().indexOf(" ")));
                            }
                            $("#dataTable").html(str);

                        }
                    });


                }
            });


            $("#zhengCount").text(zheng);
            $("#yuCount").text("0");
            $("#yuanList").html(tableStr);
            $("#weiShi").text(parseInt(growCount)-zheng);


            // 拿到种植园id，进行数据查询
            $.ajax({
                type:"POST",
                async: false,  //默认true,异步
                data:{"gid":gid},
                dataType:"json",
                url:"${path}/chuan/findGrowsDataById.action",
                success:function(data){
                    dataList = data.dataList;
                }
            });

            window.onbeforeunload = onbeforeunload_handler;
            // window.onunload = onunload_handler;
            function onbeforeunload_handler(){
                var warning="确认退出?";
                closeDate();
                return warning;
            }



            for(var i = 0;i<dataList.length;i++){
                str += '<tr><td>'+dataList[i].time.substring(dataList[i].time.trim().indexOf(" "))+'</td><td>'+dataList[i].wen+'</td><td>'+dataList[i].shi+'</td><td>'+dataList[i].er+'</td><td>'+dataList[i].guang+'</td></tr>';
                erList.push(dataList[i].er);
                erXList.push(dataList[i].time.substring(dataList[i].time.trim().indexOf(" ")));
                guangList.push(dataList[i].guang);
                guangXList.push(dataList[i].time.substring(dataList[i].time.trim().indexOf(" ")));
            }
            $("#dataTable").html(str);

            //温度界面
            var dom_wen = document.getElementById("wendu");
            var myChart = echarts.init(dom_wen);
            var option = null;
            option = {
                tooltip: {
                    formatter: '{a} <br/>{b} : {c}%'
                },
                series: [
                    {
                        name: '业务指标',
                        type: 'gauge',
                        detail: {formatter: '{value}℃'},
                        data: [{value: 50, name: '温度'}]
                    }
                ]
            };


            // 湿度界面
            var dom_shi = document.getElementById("shidu");
            var myChart_shi = echarts.init(dom_shi);
            var option_shi = null;
            option_shi = {
                tooltip: {
                    formatter: '{a} <br/>{b} : {c}%'
                },
                series: [
                    {
                        name: '业务指标',
                        type: 'gauge',
                        detail: {formatter: '{value}%RH'},
                        data: [{value: 50, name: '湿度'}]
                    }
                ]
            };


            // 二氧化碳   11111111111111111111111111111111111111111111
            // 二氧化碳   11111111111111111111111111111111111111111111
            // 二氧化碳   11111111111111111111111111111111111111111111

            var myChart_er = echarts.init(document.getElementById('main'));

            var date = [];


            var option_er = {
                xAxis: {
                    type: 'category',
                    data: erXList,
                    axisLine: {
                        lineStyle: {
                            color: '#ffffff',
                            width: 1, //这里是为了突出显示加上的
                        }
                    }
                },

                yAxis: {
                    type: 'value',
                    min:7500,
                    max:8500,
                    interval:100,
                    axisLine: {
                        lineStyle: {
                            color: '#ffffff',
                            width: 1, //这里是为了突出显示加上的
                        }
                    }
                },
                series: [{
                    data: erList,
                    type: 'line'
                }]
            };

            myChart_er.setOption(option_er);


            // 光照强度 222222222222222222222222222222222222222222
            // 光照强度 222222222222222222222222222222222222222222
            // 光照强度 222222222222222222222222222222222222222222

            var myChart_guang = echarts.init(document.getElementById('guang'));

            var date_guang = [];
            var randomData_guang = [];

            var option_guang = {
                xAxis: {
                    type: 'category',
                    data: guangXList,
                    axisLine: {
                        lineStyle: {
                            color: '#ffffff',
                            width: 1, //这里是为了突出显示加上的
                        }
                    }
                },
                yAxis: {
                    type: 'value',
                    min:5200,
                    max:5600,
                    interval:40,
                    axisLine: {
                        lineStyle: {
                            color: '#ffffff',
                            width: 1, //这里是为了突出显示加上的
                        }
                    }
                },
                series: [{
                    data: guangList,
                    type: 'line'
                }]
            };
            myChart_guang.setOption(option_guang);
            var len = date.length;
            setInterval(function(){
                guangList.push(guang_val);
                guangList.shift();
                guangXList.push(now());
                guangXList.shift();
                myChart_guang.setOption({
                    xAxis: {
                        data: guangXList
                    },
                    series: [{
                        data: guangList
                    }]
                });

                option.series[0].data[0].value = wendu_val;
                option_shi.series[0].data[0].value = shi_val;
                myChart.setOption(option, true);
                myChart_shi.setOption(option_shi, true);
                erList.push(eryang_val);
                erList.shift();
                erXList.push(now());
                erXList.shift();
                myChart_er.setOption({
                    xAxis: {
                        data: erXList
                    },
                    series: [{
                        data: erList
                    }]
                });
            }, 2500)
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
            }
            if (option_shi && typeof option_shi === "object") {
                myChart_shi.setOption(option_shi, true);
            }

        });

        function showMessage(data){
            if(type != ""){
                if(MyMarhq==null){
                    tableScroll('tableId', 0, 30, 8)
                }
                wendu_val = data.substring(data.indexOf("Temp:")+5,data.indexOf("Humi:")).trim();
                eryang_val = data.substring(data.indexOf("AD1:")+4,data.indexOf("AD2:")).trim();
                shi_val = data.substring(data.indexOf("Humi:")+5,data.indexOf("AD1:")).trim();
                guang_val = data.substring(data.indexOf("AD2:")+4,data.indexOf("Time:")).trim();
                $("#dataTable").append('<tr><td>'+now()+'</td><td>'+wendu_val+'</td><td>'+shi_val+'</td><td>'+eryang_val+'</td><td>'+guang_val+'</td></tr>');

                $.each($("#yuanList").find("div"),function(i,val){
                    if($(this).attr("id") == xuan_grow.id){
                        // 温度
                        if(parseInt(wendu_val)<xuan_grow.startWen || parseInt(wendu_val)>xuan_grow.endWen){
                            if($(this).hasClass("wen")){}else{
                                $(this).addClass("bgcolor");
                                $(this).addClass("wen");
                                $("#yuJing").html("<div>"+xuan_grow.growName+"1号传感器异常</div>");
                                addError(xuan_grow.growName,"1号传感器","wen",wendu_val);
                            }
                        }else{
                            if($(this).hasClass("yi")){
                                $(this).removeClass("bgcolor");
                                $(this).removeClass("yi");
                                $("#yuJing").html("");
                            }
                        }
                        // 湿度
                        if(parseInt(shi_val)<xuan_grow.startShi || parseInt(shi_val)>xuan_grow.endShi){
                            if($(this).hasClass("shi")){}else{
                                $(this).addClass("bgcolor");
                                $(this).addClass("shi");
                                $("#yuJing").html("<div>"+xuan_grow.growName+"1号传感器异常</div>");
                                addError(xuan_grow.growName,"1号传感器","shi",shi_val);
                            }
                        }else{
                            if($(this).hasClass("shi")){
                                $(this).removeClass("bgcolor");
                                $(this).removeClass("shi");
                                $("#yuJing").html("");
                            }
                        }
                        // 二氧化碳
                        if(parseInt(eryang_val)<xuan_grow.startEr || parseInt(eryang_val)>xuan_grow.endEr){
                            if($(this).hasClass("er")){}else{
                                $(this).addClass("bgcolor");
                                $(this).addClass("er");
                                $("#yuJing").html("<div>"+xuan_grow.growName+"1号传感器异常</div>");
                                addError(xuan_grow.growName,"1号传感器","er",eryang_val);
                            }
                        }else{
                            if($(this).hasClass("er")){
                                $(this).removeClass("bgcolor");
                                $(this).removeClass("er");
                                $("#yuJing").html("");
                            }
                        }
                        // 光照
                        if(parseInt(guang_val)<xuan_grow.startGuang || parseInt(guang_val)>xuan_grow.endGuang){
                            if($(this).hasClass("guang")){}else{
                                $(this).addClass("bgcolor");
                                $(this).addClass("guang");
                                $("#yuJing").html("<div>"+xuan_grow.growName+"1号传感器异常</div>");
                                addError(xuan_grow.growName,"1号传感器","guang",guang_val);
                            }
                        }else{
                            if($(this).hasClass("guang")){
                                $(this).removeClass("bgcolor");
                                $(this).removeClass("guang");
                                $("#yuJing").html("");
                            }
                        }
                    }
                });

                exchangeYuCount();
            }
        }
        function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/growing/index/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}

        function addError(gid,cid,type,val){
            $.ajax({
                type:"POST",
                async: true,  //默认true,异步
                dataType:"json",
                data:{"gid":gid,"cid":cid,"type":type,"val":val},
                url:"${path}/chuan/addError.action",
                success:function(data){
                }
            })
        }

        function exchangeYuCount(){
            var count = 0;
            $.each($("#yuanList").find("div"),function(i,val){
                if($(this).hasClass("bgcolor")){
                    count++;
                }
            });
            $("#yuCount").text(count);
        }

        function now(){
            var time = new Date();   // 程序计时的月从0开始取值后+1
            var m = time.getMonth() + 1;
            var t =  time.getHours() + ":"+ time.getMinutes() + ":" + time.getSeconds();
            return t;
        }

        function closeDate(){
            $.ajax({
                type:"POST",
                async: true,  //默认true,异步
                dataType:"json",
                // timeout:20000,
                url:"${path}/chuan/closeDate.action",
                success:function(data){
                }
            })
        }

        function tableScroll(tableid, hei, speed, len) {
            clearTimeout(MyMarhq);
            $('#' + tableid).parent().find('.tableid_').remove()
            $('#' + tableid).parent().prepend(
                '<table class="t_table tableid_"><thead>' + $('#' + tableid + ' thead').html() + '</thead></table>'
            ).css({
                'font-size': '0.16rem',
                'color': '#fff',
                'right':'40px',
                'bottom':'-20px',
                'position': 'absolute',
                // 'margin':'0 auto',
                'overflow': 'hidden'
            })


            $(".tableid_").find('th').each(function(i) {
                $(this).css('width', $('#' + tableid).find('th:eq(' + i + ')').width());
            });
            $(".tableid_").css({
                'position': 'absolute',
                'top': '-0.5rem',
                'left': '0.225rem',
                'z-index': 999,
                'background-color':'white'
            })
            $('#' + tableid).css({
                'position': 'absolute',
                'top': '-0.5rem',
                'left': '0.225rem',
                'z-index': 1
            })

            if ($('#' + tableid).find('tbody tr').length > len) {
                $('#' + tableid).find('tbody').html($('#' + tableid).find('tbody').html() + $('#' + tableid).find('tbody').html());
                $(".tableid_").css('top', '-0.7rem');
                $('#' + tableid).css('top', '0rem');
                var tblTop = 0;
                var outerHeight = $('#' + tableid).find('tbody').find("tr").outerHeight();

                function Marqueehq() {
                    if (tblTop <= -outerHeight * $('#' + tableid).find('tbody').find("tr").length) {
                        tblTop = 0;
                    } else {
                        tblTop -= 1;
                    }
                    $('#' + tableid).css('margin-top', tblTop + 'px');
                    clearTimeout(MyMarhq);
                    MyMarhq = setTimeout(function() {
                        Marqueehq()
                    }, speed);
                }

                MyMarhq = setTimeout(Marqueehq, speed);
                $('#' + tableid).find('tbody').hover(function() {
                    clearTimeout(MyMarhq);
                }, function() {
                    clearTimeout(MyMarhq);
                    if ($('#' + tableid).find('tbody tr').length > len) {
                        MyMarhq = setTimeout(Marqueehq, speed);
                    }
                })
            }

        }

        function longPolling(){
            $.ajax({
                type:"POST",
                async: true,  //默认true,异步
                dataType:"json",
                // timeout:20000,
                url:"${path}/chuan/getData.action",
                // error:function(XMLHttpRequest,textStatus,errorThrown){
                //     longPolling();
                // },
                success:function(data){
                    // refresh(data)
                    // $("#data").append(data);
                    // longPolling();
                }
            })
        }
    </script>
    <title>蔬菜种植环境监测平台</title>
</head>
<body style = "overflow: hidden;">
<div class="t_container">
    <header class="t_header">
        <span>蔬菜种植环境监测平台</span>
    </header>
    <main class="t_main">
        <div class="t_left_box">
            <img class="t_l_line" src="${path}/img/left_line.png" alt="">
            <div class="t_mbox t_gbox">
                <!-- <i></i> -->
                <span>设备数</span>
                <h2>${chuanCount}</h2>
            </div>
            <div class="t_mbox t_ybox">
                <!-- <i></i> -->
                <span>种植园数</span>
                <h2>${growCount}</h2>
            </div>
            <div class="t_mbox_yu t_rbox">
                <!-- <i></i> -->
                <span>预警信息</span>
                <h6 id = "yuJing">
                </h6>
            </div>
            <img class="t_r_line" src="${path}/img/right_line.png" alt="">
        </div>
        <div class="t_center_box">
            <div class="t_top_box">
                <img class="t_l_line" src="${path}/img/left_line.png" alt="">
                <ul class="t_nav">
                    <li>
                        <span>正常数</span>
                        <a class = "zheng"></a>
                        <h1 id = "zhengCount"></h1>
                        <i></i>
                    </li>
                    <li>
                        <span>预警数</span>
                        <a class = "yu"></a>
                        <h1 id = "yuCount"></h1>
                        <i></i>
                    </li>
                    <li>
                        <span>未使用数</span>
                        <a class = "wei"></a>
                        <h1 id="weiShi"></h1>
                    </li>
                </ul>
                <img class="t_r_line" src="${path}/img/right_line.png" alt="">
            </div>
            <div class="t_bottom_box">
                <img class="t_l_line" src="${path}/img/left_line.png" alt="">
                <!-- <div id="chart_3" class="echart" style="width: 100%; height: 3.6rem;"></div> -->
                <div>
                    <div class = "yuan_title">
                        大棚分布  <span style = "font-size: 0.18rem;">&nbsp;&nbsp;&nbsp;您当前查看的是：<span  id = "xuan_now"></span></span>
                    </div>
                    <div class = "yuan" id = "yuanList">

                    </div>
                </div>
                <img class="t_r_line" src="${path}/img/right_line.png" alt="">
            </div>
        </div>
        <div class="t_right_box">
            <img class="t_l_line" src="${path}/img/left_line.png" alt="">
            <div style = "position: absolute;color: white;font-size: 0.25rem;top: 50px;left: 90px;">蔬菜园实时温度</div>
            <div style = "position: absolute;color: white;font-size: 0.25rem;top: 50px;left: 400px;">蔬菜园实时湿度</div>

            <div id = "wendu" style = "width: 90%;float: left;height:90%; position: absolute;left: -120px;top: 70px;"></div>
            <div id = "shidu" style = "width: 90%;float: right;height:90%;  position: absolute;right: -120px;top: 70px;"></div>
            <img class="t_r_line" src="${path}/img/right_line.png" alt="">
        </div>
        <div class="b_left_box">
            <img class="t_l_line" src="${path}/img/left_line.png" alt="">
            <%--<div id="chart_2" class="echart" style="width: 100%; height: 3.6rem;"></div>--%>
            <div style = "position: absolute;color: white;font-size: 0.25rem;top: 20px;left: 50px;">蔬菜园实时二氧化碳</div>
            <div id="main" style="height:300px;"></div>
            <img class="t_r_line" src="${path}/img/right_line.png" alt="">
        </div>
        <div class="b_center_box">
            <img class="t_l_line" src="${path}/img/left_line.png" alt="">
            <%--<div id="chart_1" class="echart" style="width: 100%; height: 3.6rem;"></div>--%>
            <div style = "position: absolute;color: white;font-size: 0.25rem;top: 20px;left: 50px;">蔬菜园实时照度</div>
            <div id="guang" style="height:300px;"></div>
            <img class="t_r_line" src="${path}/img/right_line.png" alt="">
        </div>
        <div class="b_right_box">
            <img class="t_l_line" src="${path}/img/left_line.png" alt="">
            <h1 class="t_title">设备参数数据</h1>
            <div style = "width: 5.5rem;height: 3.125rem;margin-top: 12%;margin-left: 0.25rem;">
                <table id = "tableId" class="t_table" >
                    <thead>
                    <tr>
                        <th>时间</th>
                        <th>温度</th>
                        <th>湿度</th>
                        <th>二氧化碳</th>
                        <th>照度</th>
                    </tr>
                    </thead>
                    <tbody id="dataTable">

                    </tbody>
                </table>
            </div>
            <img class="t_r_line" src="${path}/img/right_line.png" alt="">
        </div>
    </main>
</div>
</body>

</html>
