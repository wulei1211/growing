<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/4
  Time: 22:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>

    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script src="${path}/js/echars/echars.js"></script>
    <script type='text/javascript' src='${path }/dwr/engine.js'></script>
    <script type='text/javascript' src='${path }/dwr/util.js'></script>
    <script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>

    <title>蔬菜种植环境监测</title>
    <style>
        #loading{
            background-color: #009688;
            height: 100%;
            width: 100%;
            position: fixed;
            z-index: 1;
            margin-top: 0px;
            top: 0px;
        }
        #loading-center{
            width: 100%;
            height: 100%;
            position: relative;
        }
        #loading-center-absolute {
            position: absolute;
            left: 50%;
            top: 50%;
            height: 20px;
            width: 140px;
            margin-top: -10px;
            margin-left: -70px;
            -webkit-animation: loading-center-absolute 1s infinite;
            animation: loading-center-absolute 1s infinite;

        }
        .object{
            width: 20px;
            height: 20px;
            background-color: #FFF;
            float: left;
            -moz-border-radius: 50% 50% 50% 50%;
            -webkit-border-radius: 50% 50% 50% 50%;
            border-radius: 50% 50% 50% 50%;
            margin-right: 20px;
            margin-bottom: 20px;
        }
        .object:last-child {
            margin-right: 0px;

        }
        #object_one{
            -webkit-animation: object_one 1s infinite;
            animation: object_one 1s infinite;
        }
        #object_two{
            -webkit-animation: object_two 1s infinite;
            animation: object_two 1s infinite;
        }
        #object_three{
            -webkit-animation: object_three 1s infinite;
            animation: object_three 1s infinite;
        }
        #object_four{
            -webkit-animation: object_four 1s infinite;
            animation: object_four 1s infinite;
        }

        @-webkit-keyframes loading-center-absolute{
            100% {
                -ms-transform: rotate(360deg);
                -webkit-transform: rotate(360deg);
                transform: rotate(360deg);
            }

        }
        @keyframes loading-center-absolute{
            100% {
                -ms-transform: rotate(360deg);
                -webkit-transform: rotate(360deg);
                transform: rotate(360deg);
            }
        }
        @-webkit-keyframes object_one{
            50% {
                -ms-transform: translate(20px,20px);
                -webkit-transform: translate(20px,20px);
                transform: translate(20px,20px);
            }
        }
        @keyframes object_one{
            50% {
                -ms-transform: translate(20px,20px);
                -webkit-transform: translate(20px,20px);
                transform: translate(20px,20px);
            }
        }
        @-webkit-keyframes object_two{
            50% {
                -ms-transform: translate(-20px,20px);
                -webkit-transform: translate(-20px,20px);
                transform: translate(-20px,20px);
            }
        }
        @keyframes object_two{
            50% {
                -ms-transform: translate(-20px,20px);
                -webkit-transform: translate(-20px,20px);
                transform: translate(-20px,20px);
            }
        }
        @-webkit-keyframes object_three{
            50% {
                -ms-transform: translate(20px,-20px);
                -webkit-transform: translate(20px,-20px);
                transform: translate(20px,-20px);
            }
        }
        @keyframes object_three{
            50% {
                -ms-transform: translate(20px,-20px);
                -webkit-transform: translate(20px,-20px);
                transform: translate(20px,-20px);
            }
        }
        @-webkit-keyframes object_four{
            50% {
                -ms-transform: translate(-20px,-20px);
                -webkit-transform: translate(-20px,-20px);
                transform: translate(-20px,-20px);
            }
        }
        @keyframes object_four{
            50% {
                -ms-transform: translate(-20px,-20px);
                -webkit-transform: translate(-20px,-20px);
                transform: translate(-20px,-20px);
            }
        }
    </style>
</head>
<body>
<div id = "wendu" style = "width: 50%;float: left;height:50%; "></div>
<div id = "shidu" style = "width: 50%;float: right;height:50%; "></div>
<div id = "guang" style = "width: 50%;float: left;height:50%; "></div>
<div id = "eryang" style = "width: 50%;float: right;height:50%; "></div>
<%--<div id = "data"></div>--%>
<script type="text/javascript">


    dwr.engine.setActiveReverseAjax(true);
    dwr.engine.setNotifyServerOnPageUnload(true);
    onPageLoad();
    longPolling();

    var wendu_val = "";
    var dom = document.getElementById("wendu");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    option = {
        tooltip: {
            formatter: '{a} <br/>{b} : {c}%'
        },
        // axisLabel: {
        //     formatter: function(e) {
        //         switch (e + "") {
        //             case "0":
        //                 return "0";
        //             case "10":
        //                 return "0.2";
        //             case "20":
        //                 return "0.4";
        //             case "30":
        //                 return "0.6";
        //             case "40":
        //                 return "0.8";
        //             case "50":
        //                 return "1";
        //             case "60":
        //                 return "0.8";
        //             case "70":
        //                 return "0.6";
        //             case "80":
        //                 return "0.4";
        //             case "90":
        //                 return "0.2";
        //             case "100":
        //                 return "0";
        //             default:
        //                 return "";
        //         }
        //     },
        //     textStyle: {fontSize: 15,}
        // },
        // toolbox: {
        //     feature: {
        //         restore: {},
        //         saveAsImage: {}
        //     }
        // },
        series: [
            {
                name: '业务指标',
                type: 'gauge',
                detail: {formatter: '{value}℃'},
                data: [{value: 50, name: '温度'}]
            }
        ]
    };
    //湿度
    var shi_val = "";
    var dom_shi = document.getElementById("shidu");
    var myChart_shi = echarts.init(dom_shi);
    var app = {};
    option_shi = null;
    option_shi = {
        tooltip: {
            formatter: '{a} <br/>{b} : {c}%'
        },
        // toolbox: {
        //     feature: {
        //         restore: {},
        //         saveAsImage: {}
        //     }
        // },
        series: [
            {
                name: '业务指标',
                type: 'gauge',
                detail: {formatter: '{value}%RH'},
                data: [{value: 50, name: '湿度'}]
            }
        ]
    };
    //光照
    var guang_val = "";
    var dom_guang = document.getElementById("guang");
    var myChart_guang = echarts.init(dom_guang);
    var app = {};
    optio_guang = null;
    option_guang = {
        tooltip: {
            formatter: '{a} <br/>{b} : {c}%'
        },
        // toolbox: {
        //     feature: {
        //         restore: {},
        //         saveAsImage: {}
        //     }
        // },
        series: [
            {
                name: '业务指标',
                type: 'gauge',
                detail: {formatter: '{value}Lux'},
                data: [{value: 50, name: '光照强度'}]
            }
        ]
    };
    // 二氧化碳
    var eryang_val = "";
    var dom_er = document.getElementById("eryang");
    var myChart_er = echarts.init(dom_er);
    var app = {};
    option_er = null;
    option_er = {
        tooltip: {
            formatter: '{a} <br/>{b} : {c}%'
        },
        // toolbox: {
        //     feature: {
        //         restore: {},
        //         saveAsImage: {}
        //     }
        // },
        series: [
            {
                name: '业务指标',
                type: 'gauge',
                detail: {formatter: '{value}ppm'},
                data: [{value: 50, name: '二氧化碳浓度'}]
            }
        ]
    };

    setInterval(function () {
        option.series[0].data[0].value = wendu_val;
        option_shi.series[0].data[0].value = shi_val;
        option_er.series[0].data[0].value = eryang_val;

        option_guang.series[0].data[0].value = guang_val;
        myChart.setOption(option, true);
        myChart_guang.setOption(option_guang, true);
        myChart_er.setOption(option_er, true);
        myChart_shi.setOption(option_shi, true);
    },1000);
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
    if (option_er && typeof option_er === "object") {
        myChart_er.setOption(option_er, true);
    }
    if (option_shi && typeof option_shi === "object") {
        myChart_shi.setOption(option_shi, true);
    }
    if (option_guang && typeof option_guang === "object") {
        myChart_guang.setOption(option_guang, true);
    }



    function showMessage(data){
        wendu_val = data.substring(data.indexOf("Temp:")+5,data.indexOf("Humi:")).trim();
        eryang_val = data.substring(data.indexOf("AD1:")+4,data.indexOf("AD2:")).trim();
        shi_val = data.substring(data.indexOf("Humi:")+5,data.indexOf("AD1:")).trim();
        guang_val = data.substring(data.indexOf("AD2:")+4,data.indexOf("Time:")).trim();
            // ID:1 Temp:22 Humi:46 AD1: 6233 AD2: 5245 Time: 149
        // $("#data").append("<div>"+data+"</div>");
    }
    function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/growing/index/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}

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

    setTimeout(function(){
        $("#loading").fadeOut();
    }, 2500);

</script>
    <div id="loading">
        <div id="loading-center">
            <div id="loading-center-absolute">
                <div class="object" id="object_one"></div>
                <div class="object" id="object_two"></div>
                <div class="object" id="object_three"></div>
                <div class="object" id="object_four"></div>
            </div>
        </div>
    </div>
</body>
</html>
