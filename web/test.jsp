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
    <script type="text/javascript">
        $(function(){
            $("#ceshi").click(function(){
                alert(11)
                $.ajax({
                    type:"POST",
                    async: false,  //默认true,异步
                    data:{"time":"1"},
                    dataType:"text",
                    url:"${path}/chuan/ceshi.action",
                    success:function(data){
                    }
                });
            })
        })
    </script>
    <title>Title</title>
</head>
<body>
<button id="ceshi"  >测试</button>
</body>
</html>
