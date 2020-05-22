<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/8
  Time: 22:20
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
    <script type='text/javascript' src='${path }/dwr/engine.js'></script>
    <script type='text/javascript' src='${path }/dwr/util.js'></script>
    <script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>
    <script type="text/javascript">
        $(function(){
            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();
            longPolling();

            $("#jieshu").click(function(){
                // function closeDate(){
                    $.ajax({
                        type:"POST",
                        async: true,  //默认true,异步
                        dataType:"json",
                        // timeout:20000,
                        url:"${path}/chuan/closeDate.action",
                        success:function(data){
                        }
                    })
                // }
            });
        })
        function showMessage(data){
            $("#ceshi").append(data+"\r\n")
        }
        function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/growing/index/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}

        // ID:2 Temp:29 Humi:56 Light:4 MQ2:5  Time:76
        // ID:1 Temp:30 Humi:95 Light:529 MQ2:7  Time:75

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

    <title>Title</title>
</head>
<body>
<div id = "jieshu">结束</div>
<div id = "ceshi"></div>
</body>
</html>
