<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    
<title>登录页面</title>
<script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js" ></script>
<script type="text/javascript" src="${path}/js/ajaxSessionOut.js" ></script>

<!-- layer -->
<%--<link type="text/css" rel="stylesheet" href="${path}/js/layer/skin/layer.css"/>--%>
    <link type="text/css" rel="stylesheet" href="${path}/js/layui/css/modules/layer/default/layer.css"/>
<script type="text/javascript" src="${path}/js/layer/layer.js" ></script>
<script type="text/javascript" src="${path}/js/layui/lay/modules/layer.js" ></script>
<link href="${path}/js/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

if(window != top){
	//session 失效 判断有没父页面，有，改变父页面地址
	top.location.href = location.href; 
}  
	


function login(){
	// 准备参数
	var param = new Object();
	param.userName = $.trim($("#name").val());
	param.password = $.trim($("#password").val());
	
	if(param.userName == ""){

		layer.alert('用户名不可为空', {icon: 0});
		return false;
	}else if(param.password == ""){

		layer.alert('密码不可为空', {icon: 0});
		return false;
	}

	$.ajax({
		type:"POST",
		async:true,  //默认true,异步
		data:param,
		dataType:'text',
		url:"${path}/login/tologin.action",
		success:function(data){
			
			if(data == "PASSWORD_ERROR"){
				layer.alert('密码错误', {icon: 2});
			}else if(data == "NO_EXIST"){
				layer.alert('用户不存在！', {icon: 2});
			}else{
                window.location.href = "${path}/index/toIndexPage.action";
			}
			
	    }
	});
}

function key_down(num){
	if(num == 13) {
		login();
	}
}
</script>
</head>

<body onkeydown="key_down(event.keyCode);" style = "background-color: #393d49;">
	<div class="login_box">
      <div class="login_l_img"><img src="${path}/js/images/login-img.png" /></div>
      <div class="login">
          <div class="login_logo"><a href="#"><img src="${path}/js/images/login_logo.png" /></a></div>
          <div class="login_name">
               <p>蔬菜种植环境感知系统</p>
          </div>
          <form method="post">
              <input id = "name" name="username" type="text"  value="用户名" onfocus="this.value=''" onblur="if(this.value==''){this.value='用户名'}">
              <span id="password_text" onclick="this.style.display='none';document.getElementById('password').style.display='block';document.getElementById('password').focus().select();" >密码</span>
				<input name="password" type="password" id="password" style="display:none;" onblur="if(this.value==''){document.getElementById('password_text').style.display='block';this.style.display='none'};"/>
				              <input value="登录" style="width:100%;" type="button" onclick="login()" style="cursor:pointer;">
				          </form>
				      </div>
				      <div class="copyright">GFNF有限公司 版权所有©2018-2019 技术支持电话：13141514402</div>
	</div>

</body>

</html>
