<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/1
  Time: 9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <title>蔬菜种植后台管理</title>
    <link type="text/css" rel="stylesheet" href="${path}/js/css/page.css" />
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/ajaxSessionOut.js"></script>

    <!-- layui -->
    <link type="text/css" rel="stylesheet" href="${path}/js/layui/css/modules/layer/default/layer.css"/>
    <script type="text/javascript" src="${path}/js/layui/lay/modules/layer.js" ></script>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>

    <!-- validation -->
    <script type="text/javascript"
            src="${path}/js/jquery-validation/jquery.validate.js"></script>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        body {
            background-color: #EFEFEF;
        }

        .index_top_div {
            width: 100%;
            background-color: #EFEFEF;
            background-image:
                    url('${path}/images/index/titlebg.png');
        }

        .index_top_table {
            width: 100%;
            height: 100%;
            border-collapse: collapse;
        }

        .text_web {
            font-size: 18px;
            color: #FFFFFF;
            letter-spacing: 1px;
            font-weight: bold;
            font-family: Microsoft YaHei;
        }

        .text_0 {
            color: #FFFFFF;
            font-size: 13px;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            margin-right: 5px;
            cursor: pointer;
        }

        .l-link {
            display: block;
            height: 24px;
            line-height: 24px;
            text-decoration: none;
            color: #333;
            padding-left: 16px;
            border: 1px solid white;
            margin: 2px 4px;
            cursor: pointer;
        }

        .l-link:HOVER, .l-link-over {
            background: #FFEEAC;
            border: 1px solid #DB9F00;
        }

        #editPassword_form table td {
            padding: 2px;
        }

        .leftMenu_table {
            width: 200px;
            height: 40px;
            border-collapse: collapse;
            background-color: #D3EFFB;
            cursor: pointer;
            margin-bottom: 2px;
            background-color: #4ABCF0;
        }

        .leftMenu_table .leftMenu_td_0 {
            width: 60px;
        }

        .leftMenu_table .leftMenu_td_1 {
            color: #FFFFFF;
            font-size: 13px;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        .leftMenu_table .leftMenu_td_2 {
            width: 30px;
        }

        .leftMenu_table .leftMenu_td_2 img {
            display: none;
        }

        #leftMenu .index_menu_level_0 {

        }

        .index_menu_level_1 {
            color: #535556;
            font-size: 13px;
            font-weight: bold;
            letter-spacing: 0.5px;
            height: 32px;
            line-height: 32px;
            background-color: #D3EFFB;
            cursor: pointer;
            text-indent: 60px;
            margin: 1px 0px;
        }

        .index_menu_level_ul {
            display: none;
        }

        .index_menu_level_1_hover, .index_menu_level_1_checked {
            background-color: #25AE66;
            color: #FFF;
        }

        <%--
        .index_menu_level_1_checked {
            background-repeat: no-repeat;
            background-position: 175px center;
            background-image:
                url("${path}/images/index/left_menu_arrow.png");
        }
        --%>
    </style>

    <script type="text/javascript">
        var topIframeHeight = 0;
        //调整iframe尺寸
        $(window).resize(function(){
            iframeResize();
        });

        function iframeResize(){
            var hei = $("body").height()-61;
            $("#myIframe").height(hei);
            topIframeHeight = hei-3;
        }

        $(function(){

            iframeResize();

            <%--//导入菜单数据--%>
            <%--var pageList = ${pageList};--%>
            <%--console.log(pageList);--%>
            <%--if(pageList){--%>
            <%--var html="";--%>
            <%--var xxx = 0;--%>
            <%--$.each(pageList, function(index, page){--%>
            <%--if(page.levelType == 0){--%>
            <%--var thisId = page.id;--%>
            <%--if(index==0){--%>
            <%--html+='<li class="layui-nav-item layui-nav-itemed">';--%>
            <%--}else{--%>
            <%--html+='<li class="layui-nav-item">';--%>
            <%--}--%>
            <%--if(page.descr && page.descr!=null && page.descr!=""){--%>
            <%--html+='<a class="" href="javascript:;"><img src="${path}/images/index/'+page.descr+'_02.png"/>&nbsp;&nbsp;'+page.name+'</a>';--%>
            <%--}else{--%>
            <%--html+='<a class="" href="javascript:;"><img src="${path}/images/index/default_02.png"/>&nbsp;&nbsp;'+page.name+'</a>';--%>
            <%--}--%>

            <%--html+='<dl class="layui-nav-child">';--%>
            <%--for(var pp in pageList){--%>
            <%--if(pageList[pp].parentId == thisId){--%>
            <%--if(xxx==0){--%>
            <%--html+='<dd class="layui-this"><a href="${path}/'+pageList[pp].url+'" target="mainIframe" >'+pageList[pp].name+'</a></dd>';--%>
            <%--$("#myIframe").attr("src","${path}/"+pageList[pp].url);--%>
            <%--}else{--%>
            <%--html+='<dd><a href="${path}/'+pageList[pp].url+'" target="mainIframe" >'+pageList[pp].name+'</a></dd>';--%>
            <%--}--%>
            <%--xxx++;--%>
            <%--}--%>
            <%--}--%>
            <%--html+='</dl>';--%>
            <%--html+='</li>';--%>
            <%--}--%>
            <%--});--%>
            <%--$("#menutree").html(html);--%>
            <%--}--%>


            layui.use(['layer','element'],function(){
                var layer = layui.layer;
                var element = layui.element;


            });

            //退出
            $("#loginOut").click(function(){

                layer.confirm('确认退出吗？', {icon: 3, title:'提示'}, function(index){

                    window.location.href = "${path}/index/clearSession.action";
                    layer.close(index);
                });
            });

            //验证新旧密码一样
            $.validator.addMethod(
                "rePassword",
                function (value, element, param){
                    return (value == $("#new_pass").val());
                },
                "与新密码不一样"
            );

            $("#editPassword_form").validate({
                //debug:true,
                /**//* 设置验证规则 */
                rules: {
                    old_pass: {
                        required:true,
                        remote:{
                            url:"${path}/manageUser/checkUserPassword.action",
                            type:"post",
                            dataType:"json",
                            data:{password:function(){
                                    return $.trim($("#old_pass").val());
                                }},
                            dataFilter: function(data, type) {
                                return data;
                            }
                        }
                    },
                    new_pass: {
                        required:true,
                        rangelength:[6, 20]
                    },
                    re_new_pass: {
                        rePassword:true
                    }
                },
                /**//* 设置错误信息 */
                messages: {
                    old_pass: {
                        required:"请输入旧密码",
                        remote:"密码不正确"
                    },
                    new_pass: {
                        required:"新密码不可为空",
                        rangelength:"新密码必须在6-20个字符之间"
                    }
                },
                /**//* 设置验证触发事件 */
                onsubmit:true,
                /**//* 设置错误信息提示DOM */
                errorPlacement: function(error, element) {
                    $(element[0]).parent().next().find("span").text(error.html());
                },
                success:function(error, element){
                    $(element[0]).parent().next().find("span").text("");
                },
                submitHandler: function (){
                    //alert("sunmit");
                    saveNewPass();
                }
            });

            //修改密码
            $("#repassword").click(function(){

                $("#editPassword_dialog input").val("");

                $("#editPassword_dialog span").text("");
                $("#editPassword_dialog input").focus();

                layer.open({
                    type: 1,
                    title: "修改密码",
                    area: ['420px', '200px'], //宽高
                    content: $("#editPassword_dialog")
                });

            });

            //修改密码，保存
            $("#saveBtu").click(function(){
                $("#editPassword_form").submit();
            });

            //修改密码，取消
            $("#closeBtu").click(function(){
                layer.closeAll();
            });

            $("#article").click(function(){
                $("#myIframe").attr("src","${path}/artical/toAllArticleList.action");
            })
            $("#xitong").click(function(){
                $("#myIframe").attr("src","${path}/user/toUserList.action");
            })

            layui.use('element', function(){
                var element = layui.element;

            });

            $(".layui-nav-item layui-nav-itemed");


            $("#pingLun").click(function(){
                $("#myIframe").attr("src","${path}/artical/toAllPingLun.action");
            })
            $("#replay").click(function(){
                $("#myIframe").attr("src","${path}/artical/toAllReplay.action");
            })


        });

        //保存新密码
        function saveNewPass(){

            var pass = $("#editPassword_dialog #new_pass").val();

            $.ajax({
                type:"POST",
                async: false,  //默认true,异步
                dataType:"json",
                data:"password="+pass,
                url:"${path}/manageUser/updatePassword.action",
                success : function(data) {
                    //alert(JSON.stringify(data));
                    if (data == "SUCCESS") {

                        layer.alert('保存成功！', {
                            icon : 1
                        }, function(index) {
                            layer.closeAll();
                        });

                    } else {
                        layer.alert('修改失败！', {
                            icon : 0
                        }, function(index) {
                            layer.close(index);
                        });
                    }
                }
            });
        }
    </script>
</head>
<body class="layui-layout-body">


<%--<div class="layui-layout layui-layout-admin">--%>
<%--<div class="layui-header">--%>
<%--<div class="layui-logo" style="width: 400px;">--%>
    <%--<span class="text_web">蔬菜种植系统后台管理</span>--%>
    <%--</div>--%>
<%--<ul class="layui-nav layui-layout-right" lay-filter="">--%>
    <%--<li class="layui-nav-item"><a href="">最新活动</a></li>--%>
    <%--<li class="layui-nav-item layui-this"><a href="">产品</a></li>--%>
    <%--<li class="layui-nav-item"><a href="">大数据</a></li>--%>
    <%--<li class="layui-nav-item">--%>
        <%--<a href="javascript:;">解决方案</a>--%>
        <%--<dl class="layui-nav-child"> <!-- 二级菜单 -->--%>
            <%--<dd><a href="">移动模块</a></dd>--%>
            <%--<dd><a href="">后台模版</a></dd>--%>
            <%--<dd><a href="">电商平台</a></dd>--%>
        <%--</dl>--%>
    <%--</li>--%>
    <%--<li class="layui-nav-item"><a href="">社区</a></li>--%>
<%--</ul>--%>
<%--</div>--%>
<%--</div>--%>

<%--<ul class="layui-nav layui-nav-tree" lay-filter="test">--%>
    <%--<!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->--%>
    <%--<li class="layui-nav-item layui-nav-itemed">--%>
        <%--<a href="javascript:;">默认展开</a>--%>
        <%--<dl class="layui-nav-child">--%>
            <%--<dd><a href="javascript:;">选项1</a></dd>--%>
            <%--<dd><a href="javascript:;">选项2</a></dd>--%>
            <%--<dd><a href="">跳转</a></dd>--%>
        <%--</dl>--%>
    <%--</li>--%>
    <%--<li class="layui-nav-item">--%>
        <%--<a href="javascript:;">解决方案</a>--%>
        <%--<dl class="layui-nav-child">--%>
            <%--<dd><a href="">移动模块</a></dd>--%>
            <%--<dd><a href="">后台模版</a></dd>--%>
            <%--<dd><a href="">电商平台</a></dd>--%>
        <%--</dl>--%>
    <%--</li>--%>
    <%--<li class="layui-nav-item"><a href="">产品</a></li>--%>
    <%--<li class="layui-nav-item"><a href="">大数据</a></li>--%>
<%--</ul>--%>





<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo" style="width: 400px;">
            <span class="text_web">蔬菜种植系统后台管理</span>
        </div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">你好!&nbsp;&nbsp;</li>
            <li class="layui-nav-item">${USER_NAME_STRING}&nbsp;&nbsp;</li>
            <%--<li class="layui-nav-item"><a id="repassword">[修改密码]</a></li>--%>
            <li class="layui-nav-item"><a id="loginOut">[退出]</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test" id="menutree">
                <!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;"><i class="layui-icon">&#xe770;</i>&nbsp;&nbsp;用户管理</a>
                    <dl class="layui-nav-child">
                        <dd class = "layui-this"><a href="javascript:;" id="xitong">系统用户</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon">&#xe663;</i>&nbsp;&nbsp;文章管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" id = "article">文章列表</a></dd>
                        <dd><a href="javascript:;" id = "pingLun">评论列表</a></dd>
                        <dd><a href="javascript:;" id = "replay">回复列表</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>


    <div class="layui-body" style="height: 100%;">
        <div style="padding: 10px;">
            <iframe id="myIframe" name="mainIframe" frameborder="0"
                    style="width: 100%; min-width: 800px;" src="${path}/user/toUserList.action"></iframe>
        </div>
    </div>
</div>

<div id="otherMenu" style="display: none;">
    <div class="index_menu_level_0">
        <table class="leftMenu_table">
            <tr valign="middle" align="center">
                <td class="leftMenu_td_0"><img class="hover_2" alt=""
                                               src="${path}/images/index/default_02.png" />
                </td>
                <td class="leftMenu_td_1" align="left">网站数据监测</td>
                <td class="leftMenu_td_2"><img alt=""
                                               src="${path}/images/index/left_menu_arrow.png" />
                </td>
            </tr>
        </table>
    </div>
    <ul class="index_menu_level_ul">

    </ul>
</div>

<!-- 修改密码 -->
<div id="editPassword_dialog" style="display: none;">
    <form id="editPassword_form" style="margin: 5px;">
        <table style="">
            <tr valign="middle">
                <td align="right">旧密码：</td>
                <td><input type="password" id="old_pass" name="old_pass"
                           class="input_0" /></td>
                <td align="left" valign="middle"><span style="color: red;"></span>
                </td>
            </tr>
            <tr valign="middle">
                <td align="right">新密码：</td>
                <td><input type="password" id="new_pass" name="new_pass"
                           class="input_0" /></td>
                <td align="left" valign="middle"><span style="color: red;"></span>
                </td>
            </tr>
            <tr valign="middle">
                <td align="right">确认新密码：</td>
                <td><input type="password" id="re_new_pass" name="re_new_pass"
                           class="input_0" /></td>
                <td align="left" valign="middle"><span style="color: red;"></span>
                </td>
            </tr>
        </table>
    </form>
    <div align="center" style="margin: 10px 10px 5px 0px;">
        <button id="saveBtu" class="btu_0">保存</button>
        <button id="closeBtu" class="btu_0">取消</button>
    </div>
</div>

<script type="text/javascript">

</script>
</body>
</html>
