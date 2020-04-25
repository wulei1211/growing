<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2019/11/10
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>

    <title>Title</title>

    <script type="text/javascript" src="${path }/js/jquery-1.9.1.min.js"></script>
    <script type='text/javascript' src='${path }/dwr/engine.js'></script>
    <script type='text/javascript' src='${path }/dwr/util.js'></script>
    <script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>
    <script type="text/javascript" src="${path }/js/naranja.js"></script>
    <link rel="stylesheet" type="text/css" href="${path }/css/bootstrap-grid.min.css" />
    <link rel="stylesheet" type="text/css" href="${path }/css/demo.css">
    <link rel="stylesheet" href="${path }/css/naranja.min.css">
    <script type = "text/javascript">

        $(function () {

            $("#test").click(function () {
                $.ajax({
                    method:"post",
                    url:'${path}/message/fasong.action',
                    data:{"mess":"消息"},
                    async:false,
                    dataType:'json',
                    success:function (data) {

                    }
                });
            });
            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();
        });
        function showMessage(data){narn('log',data);}
        function narn (type,data) {naranja()[type]({title: '新消息提示',text: data,timeout: 'keep',buttons: [{text: '已读',click: function (e) {naranja().success({title: '通知',text: '通知已读'})}},{text: '取消',click: function (e) {e.closeNotification();}}]})}
        function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/web/message/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}

    </script>
</head>
<body>

<button type="button" id = "test">测试</button>

</body>
</html>
