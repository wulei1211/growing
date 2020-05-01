<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%
		String contextPath = request.getContextPath();
		pageContext.setAttribute("path", contextPath);
	%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
<link rel="stylesheet" href="${path}/js/css/index.css">
<script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${path}/js/layui/layui.js"></script>
<script type='text/javascript' src='${path }/dwr/engine.js'></script>
<script type='text/javascript' src='${path }/dwr/util.js'></script>
<script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>
<script type="text/javascript" src="${path }/js/naranja.js"></script>
<link rel="stylesheet" href="${path }/js/css/naranja.min.css">
	<script>
		var layer = null;
        var flow = null;
        var dianzan = '${dianzans}';
        var shoucang = '${shoucangs}';
        $(function(){

            dongHua();

            //dwr
            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();



            layui.use(['element','layer','flow','form'], function(){
                var element = layui.element;
                layer = layui.layer;
                var form = layui.form;

                jiazai("","","");

                $("#sousuo").click(function(){
                    var titleName = $("#shuru").val();
                    $("#demo").html("");
                    jiazai(titleName,"","");
				});

                $("#shuru").focus(function(){
                    $("#tiwen").animate({"opacity":"0"},50)
                    $(this).parent("div").animate({"width":"410px"},500);
                    $(this).next("div").find("i").css({"color":"#0584FB"});
                });

                $("#houTai").click(function(){
                    window.location.href = "${path}/index/toManagerPage.action";
				})

                $("#shuru").blur(function(){
                    $("#tiwen").animate({"opacity":"1"},50);
                    $(this).parent("div").animate({"width":"320px"},500);
                    $(this).next("div").find("i").css({"color":"#999"});
                });

                $("#tiwen").click(function(){
                    window.open("${path}/artical/toArticalAdd.action");
                });


                $(document).on( 'click', '.dianzan', function(){
                    var index = $(this).find("i");
                    var shuzi = $(this).find("span").eq(1);
                    var zi = $(this).find("span").eq(0);
                    var type = 0;
                    var aid = "";
                    if($(this).hasClass("layui-btn-primary")){
                        index.css({"color":"red"});
                        // zi.text("取消");
                        $(this).removeClass("layui-btn-primary");
                        index.removeClass("layui-icon-heart");
                        index.addClass("layui-icon-heart-fill");
                        var xihuan = $(shuzi).text();
                        $(shuzi).text(jiaXiHuan(xihuan,'1'));
                        type = 1;//加一

                    }else{
                        index.css({"color":""});
                        // zi.text("喜欢");
                        $(this).addClass("layui-btn-primary");
                        index.addClass("layui-icon-heart");
                        index.removeClass("layui-icon-heart-fill");
                        var xihuan = $(shuzi).text();
                        $(shuzi).text(jiaXiHuan(xihuan,'2'));
                        type = 2;//减一；

                    }

                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"text",
                        data:{"type":type,"articleId":$(this).find("div").text(),"dianType":"1"},
                        url:"${path}/index/changeDianZan.action",
                        success:function(data){
                            if(data == "dian"){
                                layer.msg("喜欢");
                            }
                            if(data == "qu"){
                                layer.msg("取消喜欢");
                            }
                        }

					});
                })

                $(document).on( 'click', '.shoucang', function(){
                    var type = 0;
                    var index = $(this).find("i");
                    if(index.hasClass("layui-icon-star")){
                        index.removeClass("layui-icon-star");
                        index.addClass("layui-icon-star-fill");
                        index.css({"color":"red"});
                        type = 1;
                    }else{
                        index.addClass("layui-icon-star");
                        index.removeClass("layui-icon-star-fill");
                        index.css({"color":""});
                        type = 2;
                    }

                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"text",
                        data:{"type":type,"articleId":$(this).parent("div").find("button").find("div").text(),"dianType":"2"},
                        url:"${path}/index/changeDianZan.action",
                        success:function(data){
                            if(data == "shou"){
                                layer.msg("已收藏");
                            }
                            if(data == "noshou"){
                                layer.msg("取消收藏");
                            }
                        }

                    });
                });

                $(document).on("click",".title",function(){
                    var id = $(this).parent("div").find(".dianzan div").text();
                    window.open(
                        "${path}/artical/articleDetail.action?articleId="+id
					);
				});
                
                $("#guan").click(function () {
                    $("#demo").text("");
                    jiazai("","${user.id}","");
                });

				$(".type").click(function(){
				    $("#demo").text("");
                    jiazai("","",$(this).parent("dd").attr("ids"));
				});

				$("#xiugai_mi").click(function(){
                    layer.open({
                        type: 1,
                        title: "修改密码",
                        area: ['420px', '300px'], //宽高
                        content: $("#editPassword_dialog")
                    });
                });

				$("#tuichu").click(function(){
                    // session.invalidate()
                    layer.confirm('确定退出吗?', function(index){
                        window.location.href = "${path}/index/clearSession.action";
                    });
				})

				$("#geren").click(function(){
                    window.open(
                        "${path}/artical/toPerson.action?userId="+"${user.id}"
                    );
				});

                form.verify({
                    pass: function(value, item){ //value：表单的值、item：表单的DOM对象
                        var str = "";
                        $.ajax({
                            type:"POST",
                            async: false,  //默认true,异步
                            dataType:"text",
                            data:{"pass":value},
                            url:"${path}/index/checkPass.action",
                            success:function(data){
                                str = data;
                            }
                        });
                        if(str == "no"){

                            return "旧密码不正确";
                        }
                    }
                });

                form.on('submit(go)', function(data){

                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"text",
                        data:{"newPass":$("#newPass").val()},
                        url:"${path}/index/changePassword.action",
                        success:function(data){
                            layer.closeAll();
                            layer.msg("修改成功！");
                        }
                    });

                    // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                    // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                //

                $("#closeBtu").click(function(){
                    layer.closeAll();
                });

            });
        });

        function dongHua(){
            $("#haha").css({"transform":"translateX(0rem)","transition":"all 0.6s"})
            $("#haha").animate({"opacity":"1",},300);
		}

        function dongHua_hui(){
            $("#haha").css({"transform":"translateX(3.25rem)","opacity": "0","overflow-x": "hidden"})
        }

        function jiaXiHuan(shuzi,type){
            var temp = parseInt(shuzi);
            if(type == '1'){
                return temp+1;
            }else{
                return temp-1;
			}
		}


        function jiazai(titleName,guanzhu,articleType){
            //流加载显示文章列表
            // var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
            flow = layui.flow;
            flow.load({
                elem: '#demo' //指定列表容器
                ,done: function(page, next){ //到达临界点（默认滚动触发），触发下一页
                    var lis = [];
                    //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                    $.get('${path}/artical/allArticle.action?articleTitle='+titleName+'&page='+page+'&guanzhu='+guanzhu+'&articleType='+articleType,
						function(res){
                        //假设你的列表返回在data集合中
                        layui.each(res.data, function(index, item){
                            var str = '';
                            str += '<div class = "neirong">'
                            str += '        <div class = "neirong_suo">'
                            str += '       <div class = "title">'+item.articleTitle+'</div>'
                            str += '   <div class = "middle">'+item.articleContent.replace(/<[^<>]+>/g,"")+'</div>'
							var dianIndex = dianzan.indexOf(item.id);
							if(dianIndex != -1){
                                str += '   <div class="anniu"><button type="button" class="layui-btn dianzan" >'
                                str += '   <div style = "display: none;">'+item.id+'</div>'
                                str += '      <i class="layui-icon layui-icon-heart-fill" style = "color: red"></i>  <span class = "zi"></span> <span class = "xihuan_shuzi">'+item.articleLove+'</span></button>'
                                str += '   <span class="pinlun"><i class="layui-icon" style = "color: #999;">&#xe611;</i>'
                                str += '  <span class="pinlun_shuzi">'+item.pingLunCount+'</span>条评论</span>'
                                // str += '      <span class="pinlun">'
                                // str += '     <i class="layui-icon layui-icon-release" style = "color: #999;"></i>'
                                // str += '     <span class = "pinlun_shuzi">转发</span>'
                                // str += '     </span>'


								var shouIndex = shoucang.indexOf(item.id);
                                if(shouIndex != -1){
                                    str += '       <span class="pinlun shoucang">'
                                    str += '          <i class="layui-icon layui-icon-star-fill" style = "color: red;"></i>'
                                    str += '         <span class = "pinlun_shuzi">收藏</span>'
                                    str += '         </span>'
								}else{
                                    str += '       <span class="pinlun shoucang">'
                                    str += '          <i class="layui-icon layui-icon-star"></i>'
                                    str += '         <span class = "pinlun_shuzi">收藏</span>'
                                    str += '         </span>'
								}
                                str += ' </div>'
							}else{
                                str += '   <div class="anniu"><button type="button" class="layui-btn layui-btn-primary dianzan" >'
                                str += '   <div style = "display: none;">'+item.id+'</div>'
                                str += '      <i class="layui-icon layui-icon-heart"></i>  <span class = "zi"></span> <span class = "xihuan_shuzi">'+item.articleLove+'</span></button>'
                                str += '   <span class="pinlun"><i class="layui-icon" style = "color: #999;">&#xe611;</i>'
                                str += '  <span class="pinlun_shuzi">'+item.pingLunCount+'</span>条评论</span>'
                                // str += '      <span class="pinlun">'
                                // str += '     <i class="layui-icon layui-icon-release" style = "color: #999;"></i>'
                                // str += '     <span class = "pinlun_shuzi">转发</span>'
                                // str += '     </span>'
                                var shouIndex = shoucang.indexOf(item.id);
                                if(shouIndex != -1){
                                    str += '       <span class="pinlun shoucang">'
                                    str += '          <i class="layui-icon layui-icon-star-fill" style = "color: red;"></i>'
                                    str += '         <span class = "pinlun_shuzi">收藏</span>'
                                    str += '         </span>'
                                }else{
                                    str += '       <span class="pinlun shoucang">'
                                    str += '          <i class="layui-icon layui-icon-star"></i>'
                                    str += '         <span class = "pinlun_shuzi">收藏</span>'
                                    str += '         </span>'
                                }
								str +=	'</div>'
							}
                            str += ' 	</div></div>'
                            lis.push(str);
                        });

                        //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                        //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                        next(lis.join(''), page < res.pages);
                    },
                    $.ajaxSettings.async = false);
                }
            });
		}

        function showMessage(data){narn('log',data);}
        function narn (type,data) {naranja()[type]({title: '新消息提示',text: data,timeout: 'keep',buttons: [{text: '已读',click: function (e) {naranja().success({title: '通知',text: '通知已读'})}},{text: '取消',click: function (e) {e.closeNotification();}}]})}
        function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/growing/index/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}

        function test(){
                window.location.reload();
            // layer.msg("发布成功！");
		}
	</script>
</head>

<body style="background-color: #F6F6F6;">
<!-- 上面的导航条 -->
<div class="tou">
	<div class="layui-row">
		<div class="layui-container">
			<ul class="layui-nav layui-bg-green" lay-filter="">
				<li class="layui-nav-item layui-this"><a href="">首页</a></li>
				<li class="layui-nav-item"><a href="javascript:;" id="guan">关注</a></li>
				<%--<li class="layui-nav-item"><a href="">回答</a></li>--%>
				<li class="layui-nav-item">
					<a href="javascript:;">分类</a>
					<dl class="layui-nav-child"> <!-- 二级菜单 -->

						<c:forEach items="${artTypeList}" var="i">
							<dd ids = "${i.id}"><a href="javascript:;" class = "type">${i.typeName}</a></dd>
						</c:forEach>


					</dl>
				</li>
				<li class="layui-nav-item lvxian">
					<div class="layui-input-block" style = "width:320px;position: relative;">
						<input type="text" name="articleTitle" placeholder="请输入关键词" class="layui-input" id = "shuru">
						<div class = "sousuoicon" id = "sousuo"><i class="layui-icon" style="font-size: 22px; color: #999;">&#xe615;</i></div>
					</div>
				</li>

				<li class="layui-nav-item ">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="layui-btn layui-btn-warm" id = "tiwen">发帖</button>
					<%--<a href="http://www.layui.com" class="layui-btn layui-btn-warm" >发帖</a>--%>
				</li>
				<div class = "one">
					<li class="layui-nav-item layui-layout-right">
						<a href=""><i class="layui-icon" style="font-size: 20px;">&#xe667;</i><span class="layui-badge">9</span></a>
					</li></div>
				<div class = "two">
					<li class="layui-nav-item layui-layout-right">
						<a href="javascript:;" id="geren">个人中心</a>
					</li></div>
				<li class="layui-nav-item layui-layout-right">
					<a href="javascript:;">选项</a>
					<dl class="layui-nav-child">
						<c:if test="${user.userType == '2'}">
							<dd><a href="javascript:;" id = "houTai">后台管理</a></dd>
						</c:if>
						<dd><a href="javascript:;" id="xiugai_mi">修改密码</a></dd>
						<dd><a href="javascript:;" id="tuichu">退出系统</a></dd>
					</dl>
				</li>
			</ul>
		</div>
	</div>
</div>

<div class="layui-container content" id = "haha" >
	<div class="layui-row layui-col-space14">
		<div class="layui-col-md9 ">
			<!-- 左边 -->
			<div class="grid-demo grid-demo-bg1 zuo" id="demo">


			</div>
		</div>
		<div class="layui-col-md3 ">
			<!-- 右边 -->
			<div class="grid-demo zuo">
				<div class = "yonghu" style="border: 1px solid white;width: 100%;">
					<div style = "text-align: center;margin-top: 2.5rem;">
						<c:if test="${!empty touXiang}">
							<img src="${touXiang}" style = "width: 3.75rem;height: 3.75rem;border: 0.1875rem solid #009688;border-radius: 50%;" id = "touXiang" />
						</c:if>
						<c:if test = "${empty touXiang}">
							<img src="${path}/js/images/343.jpeg" style = "width: 3.75rem;height: 3.75rem;border: 0.1875rem solid #009688;border-radius: 50%;" id = "touXiang" />
						</c:if>
					</div>
					<div style = "margin-top: 1.125rem;font-weight: bold;font-size: 1rem;text-align: center;">${realName}</div>
					<div style = "margin-top: 1.125rem;text-align: center;font-size: 0.625rem;color: #999;">
						${memo}</div>
					<div style = "font-size: 0.625rem;color: #999;;height: 3.125rem;border-top: 1px solid #E0E0E0;border-bottom: 1px solid #E0E0E0;margin: 0.9375rem 0.9375rem 0rem 0.9375rem;line-height: 3.125rem;">
						社交：&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="layui-icon layui-icon-login-qq tubiao"></i> &nbsp;&nbsp;
						<i class="layui-icon layui-icon-login-wechat tubiao"></i> &nbsp;&nbsp;
						<i class="layui-icon layui-icon-login-weibo tubiao"></i>
					</div>
					<div style = "padding: 1.25rem 3rem 1.25rem 3rem;height: 3.125rem;">
						<div style = "height: 100%;float: left;color: #999;text-align: center;">文章</br></br><span class="shuzi">${artCount}</span></div>
						<div style = "height: 100%;float: right;color: #999;text-align: center">关注者</br></br><span class="shuzi">${user.guanZhuCount}</span></div>
					</div>
				</div>

				<div>
					<button type="button" class="layui-btn" style = "width: 100%;height: 2.5rem;">蔬菜种植环境</button>
				</div>

			</div>
		</div>
	</div>
</div>

<!-- 修改密码 -->
<div id="editPassword_dialog" style="display:none;margin-top: 20px;">
	<form id="editPassword_form" style="margin:5px;" class = "layui-form" action="${path}/index/changePassword.action" lay-filter="" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">旧密码：</label>
				<div class="layui-input-inline">
					<input type="password" id="old_pass" name="oldPass" lay-verify="pass" autocomplete="off" class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">新密码：</label>
				<div class="layui-input-inline">
					<input type="password" id="newPass" name="newPass" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">确认密码：</label>
				<div class="layui-input-inline">
					<input type="password" id="re_new_pass" name="re_new_pass" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
		</div>
		<div align="center" style="margin:10px 10px 5px 0px;">
			<button type="button" id="saveBtu" class="layui-btn" lay-submit="" lay-filter="go">保存</button>
			<button type="button" id="closeBtu" class="layui-btn layui-btn-warm">取消</button>
		</div>
	</form>
</div>

</body>

</html>
