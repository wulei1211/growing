<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/6
  Time: 14:39
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
    <script type='text/javascript' src='${path }/dwr/engine.js'></script>
    <script type='text/javascript' src='${path }/dwr/util.js'></script>
    <script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>
    <script type="text/javascript">
        $(function () {

            //dwr
            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();
            // showMessage()

            $.ajax({
                type:"POST",
                async: false,  //默认true,异步
                dataType:"text",
                url:"${path}/chuan/getData.action",
                success:function(data){

                }
            });
        })

        function showMessage(data){
            console.log(data)
            var id = data.substring(data.indexOf("ID:")+3,data.indexOf("Temp")).trim();
            if($("chuanMsg").html() == ""){
                $("chuanMsg").append('<button type="button layui-btn-primary" class="layui-btn">'+id+'号传感器</button>');
            }
        }
        function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/growing/index/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}

    </script>
    <title>扫描传感器</title>
</head>
<body>
<div id = "chuanMsg">

</div>
</body>
</html>
