<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/4/28
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
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
        var shouArr = null;
        <%--var dengUser = '${dengUser}';//登录的用户--%>
        <%--var user = '${user}';// 要显示的用户--%>

        $(function(){

            shoucang = shoucang.substring(1,shoucang.length-1);
            shouArr = shoucang.split(",");
            console.log(shouArr)

            //dwr
            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();

            layui.use(['element','layer','flow','form'], function(){
                var element = layui.element;
                layer = layui.layer;
                var form = layui.form;

                jiazai("","","","${user.id}","");



                // 收藏
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

                    var id = $(this).parent("div").find("button").find("div").text()
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"text",
                        data:{"type":type,"articleId":id,"dianType":"2"},
                        url:"${path}/index/changeDianZan.action",
                        success:function(data){
                            if(data == "shou"){
                                layer.msg("已收藏");
                                shouArr.push(id);
                                console.log(shouArr);
                            }
                            if(data == "noshou"){
                                layer.msg("取消收藏");
                                shouArr.splice(shouArr.indexOf(id),1);
                                console.log(shouArr);
                            }

                            $("#demo").text("");
                            if($(".layui-this").find("a").text() == "收藏"){
                                jiazai("","","","","${user.id}");
                            }else{
                                jiazai("","","","${user.id}","");
                            }


                        }

                    });
                });

                //点赞
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

                //首页点击
                $("#index").click(function(){

                    window.location.href = "${path}/index/toIndexPage.action";
                })

                //文章点击
                $("#wenzhang").click(function(){
                    $("#demo").text("");
                    jiazai("","","","${user.id}","");
                })
                // 点击收藏
                $("#shouCang").click(function(){
                    $("#demo").text("");
                    jiazai("","","","","${user.id}");
                    // window.location.reload()
                })

                // 点击标题进入详情
                $(document).on("click",".title",function(){
                    var id = $(this).parent("div").find(".dianzan div").text();
                    window.open(
                        "${path}/artical/articleDetail.action?articleId="+id
                    );
                });




                // var _huifu = null;
                // $(document).on("click",".hui",function(){
                //     _huifu = $(this);
                //
                //     $("#pinglunfa").find("div").text("1");
                //     var name = $(this).parent("span").parent("div").find("span:eq(1)").text();
                //     if(_huifu.hasClass("fu")){
                //         $("#ping").attr({"placeholder":"回复 "+name});
                //     }else{
                //         $("#ping").attr({"placeholder":"回复 "+name.substring(0,name.indexOf("回复")).trim()+"："});
                //     }
                //
                //     $("#ping").css({"height":"4.5rem"});
                //     $("#ping").parent("div").parent("div").parent("div").animate({"height":"4.5rem"},200)
                //     $("#quxiaohuifu").css({"display":"inline"});
                // });



                //进入编辑
                $(document).on("click",".edit",function(){
                    window.open(
                        "${path}/artical/toArticalAdd.action?articleId="+$(this).parent("div").find("button div").text()
                    );
                })

                //进入回复
                $("#myReplay").click(function(){
                    $("#demo").text("");
                    jiazaiPing("2");
                })

                //删除评论回复
                $(document).on("click",".xian_hui_del",function(){
                    var id = $(this).parent("div").prev("div").text();
                    layer.confirm('确认删除此评论?', function(index){
                        //do something
                        $.ajax({
                            type:"POST",
                            async: false,  //默认true,异步
                            dataType:"text",
                            data:{"pId":id},
                            url:"${path}/artical/deletePing.action",
                            success:function(data){
                                $("#demo").text("")
                                jiazaiPing("1")
                            }

                        });
                        layer.close(index);
                    });

                })


                $(document).on("click",".delete",function(){
                    var id = $(this).parent("div").find("button div").text();
                    layer.confirm('确定删除?', function(index){
                        $.ajax({
                            type:"POST",
                            async: false,  //默认true,异步
                            dataType:"text",
                            // contentType: 'application/json; charset=UTF-8',
                            data:{"articleId":id},
                            url:"${path}/artical/deleteArticle.action",
                            success:function(data){
                                window.location.reload();
                                layer.close(index);
                            }

                        });

                    });
                })

                // 评论
                $("#myPingLun").click(function(){
                    $("#demo").text("")
                    jiazaiPing("1")
                });

                //直接回复帖子
                $(document).on("click",".xian_hui_hui",function(){
                    var toPlayer = $(this).parent("div").find("div:eq(0)").text();
                    var pinlunid = $(this).parent("div").find("div:eq(1)").text();
                    var articleId = $(this).parent("div").find("div:eq(2)").text();
                    // alert(toPlayer+","+pinlunid+","+articleId)
                    layer.prompt({                        formType: 2,
                        value: '',
                        title: "回复  "+$(this).parent("div").find("span:eq(1)").text(),
                        area: ['650px', '150px'] //自定义文本域宽高
                    }, function(value, index, elem){
                        var data = {};
                        data.replayContent = value;
                        data.toPlayer = toPlayer;
                        data.pingLunId = pinlunid;
                        data.articleId = articleId;
                        $.ajax({
                            type:"POST",
                            async: false,  //默认true,异步
                            dataType:"text",
                            contentType: 'application/json; charset=UTF-8',
                            data:JSON.stringify(data),
                            url:"${path}/artical/addReplay.action",
                            success:function(data){
                                if(data == "success"){
                                    layer.msg("回复成功！");
                                    $("#myReplay").click();
                                }
                            }
                        });

                        layer.close(index);
                    });
                })


            });

        });

        function jiaXiHuan(shuzi,type){
            var temp = parseInt(shuzi);
            if(type == '1'){
                return temp+1;
            }else{
                return temp-1;
            }
        }

        //加载回复
        function jiazaiPing(type){
            var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
            flow = layui.flow;
            flow.load({
                elem: '#demo' //指定列表容器
                ,done: function(page, next){ //到达临界点（默认滚动触发），触发下一页
                    var lis = [];
                    //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                    $.get('${path}/artical/allArticlePing.action?page='+page+'&userId='+'${user.id}', function(res){
                        //假设你的列表返回在data集合中

                        if(type == "2"){
                            layui.each(res.data, function(index, item){
                                var str = '';
                                $.each(item.repLayList,function(i,val){
                                    str += '<div class = "biao_ping">';
                                    str += '              <div class = "pinglun_tou_ping">';
                                    str += '  <div style = "display:none;">'+val.replayer+'</div>';//恢复给谁
                                    str += '  <div style = "display:none;">'+val.pingLunId+'</div>';//评论id
                                    str += '  <div style = "display:none;">'+val.articleId+'</div>';//文章id
                                    str += '              <span class = ""><img src="'+val.huiTou+'" class = "pinglun_touxiang pinglun_touxiang_plus" />&nbsp;&nbsp;</span>';
                                    str += '         <span style = "font-weight: bold;">'+val.huiName+'：</span><span style="color: #666;">回复了我的评论</span>';
                                    str += '         <span class = "xian_hui xian_hui_hui">回复</span>';
                                    str += '        <div class="pinglun_content" style = "width: 25rem;padding-left: 1.25rem;">';
                                    str += val.replayContent;
                                    str += '      <span class = "pinglun_time">&nbsp;&nbsp;'+val.time+'</span></div>';
                                    str += '      <div style = "width: 4rem;position: absolute;right: 0rem;top: 1.2rem;height: 60%;overflow: hidden;">'+item.pingLunContent+'</div></div> </div>';
                                });
                                lis.push(str);
                            });
                        }else{
                            layui.each(res.data, function(index, item){
                                console.log(item)
                                var str = '';
                                str += '<div class = "biao_ping">';
                                str += '  <div style = "display:none;">'+item.id+'</div>';//评论id
                                str += '              <div class = "pinglun_tou_ping">';
                                str += '              <span class = ""><img src="'+item.headImg+'" class = "pinglun_touxiang pinglun_touxiang_plus" />&nbsp;&nbsp;</span>';
                                str += '         <span style = "font-weight: bold;">'+item.realName+'：</span><span style="color: #666;">评论了文章</span>';
                                str += '         <span class = "xian_hui xian_hui_del">删除评论</span>';
                                str += '        <div class="pinglun_content" style = "width: 25rem;padding-left: 1.25rem;">';
                                str += item.pingLunContent;
                                str += '      <span class = "pinglun_time">&nbsp;&nbsp;'+item.time+'</span></div>';
                                str += '      <div style = "width: 4rem;position: absolute;right: 0rem;top: 1.2rem;height: 60%;overflow: hidden;">'+item.article.articleTitle+'</div></div> </div>';
                                lis.push(str);
                            });
                        }


                        //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                        //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                        next(lis.join(''), page < res.pages);
                    });
                }
            });
        }


        // 加载文章
        function jiazai(titleName,guanzhu,articleType,master,shouCang){
            //流加载显示文章列表
            // var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
            flow = layui.flow;
            flow.load({
                elem: '#demo' //指定列表容器
                ,done: function(page, next){ //到达临界点（默认滚动触发），触发下一页
                    var lis = [];
                    //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                    $.get('${path}/artical/allArticle.action?articleTitle='+titleName+'&page='+page+'&guanzhu='+guanzhu+'&articleType='+articleType+'&master='+master+'&shouCang='+shouCang,
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

                                    var shouIndex = shouArr.indexOf(item.id);
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
                                    //编辑删除
                                    if("${user.id}" == item.master && "${user.id}" == "${dengUser.id}") {
                                        str += '      <span class="pinlun edit">'
                                        str += '     <i class="layui-icon layui-icon-edit" style = "color: #999;"></i>'
                                        str += '     <span class = "pinlun_shuzi" >编辑</span>'
                                        str += '     </span>'
                                        str += '      <span class="pinlun delete">'
                                        str += '     <i class="layui-icon layui-icon-delete" style = "color: #999;"></i>'
                                        str += '     <span class = "pinlun_shuzi" >删除</span>'
                                        str += '     </span>'
                                    }
                                    str += ' </div>'
                                }else{
                                    str += '   <div class="anniu"><button type="button" class="layui-btn layui-btn-primary dianzan" >'
                                    str += '   <div style = "display: none;">'+item.id+'</div>'
                                    str += '      <i class="layui-icon layui-icon-heart"></i>  <span class = "zi"></span> <span class = "xihuan_shuzi">'+item.articleLove+'</span></button>'
                                    str += '   <span class="pinlun"><i class="layui-icon" style = "color: #999;">&#xe611;</i>'
                                    str += '  <span class="pinlun_shuzi">'+item.pingLunCount+'</span>条评论</span>'

                                    var shouIndex = shouArr.indexOf(item.id);
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
                                    if("${user.id}" == item.master && "${user.id}" == "${dengUser.id}"){
                                        str += '      <span class="pinlun edit">'
                                        str += '     <i class="layui-icon layui-icon-edit" style = "color: #999;"></i>'
                                        str += '     <span class = "pinlun_shuzi">编辑</span>'
                                        str += '     </span>'
                                        str += '      <span class="pinlun delete">'
                                        str += '     <i class="layui-icon layui-icon-delete" style = "color: #999;"></i>'
                                        str += '     <span class = "pinlun_shuzi">删除</span>'
                                        str += '     </span>'
                                    }

                                    str +=	'</div>'
                                }
                                str += ' 	</div></div>'
                                lis.push(str);
                            });

                            //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                            //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                            next(lis.join(''), page < res.pages);
                        });
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
        function showMessage(data){addMsg("1"),narn('log',data);}
        function narn (type,data) {naranja()[type]({
            title: '新消息提示',
            text: JSON.parse(data).content,timeout: 'keep',
            buttons: [{
                text: '已读',click: function (e) {
                    naranja().success({title: '通知',text: '通知已读'})
                    addMsg("2");
                    readMsg(JSON.parse(data).id);
                }},
                {text: '取消',click: function (e) {e.closeNotification();}}
            ]})}
        function onPageLoad(){var userId = "";$.ajax({method:"post",url:"/growing/index/gotoIndex.action",async:false,dataType:"text",success:function (data) {userId = data;}});if(userId!=null && userId!=""){var userThisId = userId;MessagePush.onPageLoad(userThisId);}}

        function readMsg(id){
            $.ajax({
                type:"POST",
                async: false,  //默认true,异步
                dataType:"json",
                data:{"msgId":id},
                url:"${path}/artical/readMsg.action",
                success:function(data){

                }
            });
        }
        function addMsg(val){
            var count = $("#msgCot").text();
            if(val == "1"){
                $("#msgCot").text(parseInt(count)+1);
            }else{
                if(count<=0) return ;
                $("#msgCot").text(parseInt(count)-1);
            }
        }
    </script>
</head>

<body style="background-color: #F6F6F6;">
<!-- 上面的导航条 -->
<div class="tou">
    <div class="layui-row">
        <div class="layui-container">
            <ul class="layui-nav layui-bg-green" lay-filter="">
                <li class="layui-nav-item"><a href="javascript:;" id = "index">首页</a></li>
                <li class="layui-nav-item layui-this"><a href="javascript:;" id = "wenzhang">文章</a></li>
                <li class="layui-nav-item"><a href="javascript:;" id = "shouCang">收藏</a></li>
                <li class="layui-nav-item"><a href="javascript:;" id = "myPingLun">评论</a></li>
                <li class="layui-nav-item"><a href="javascript:;" id = "myReplay">回复我的</a></li>
                <li class="layui-nav-item"><a href="javascript:;" id="myMsg">我的资料</a></li>
                <!-- <li class="layui-nav-item lvxian">
                    <div class="layui-input-block" style = "width:320px;position: relative;">
                      <input type="text" name="title" placeholder="请输入关键词" class="layui-input" id = "shuru">
                      <div class = "sousuoicon"><i class="layui-icon" style="font-size: 22px; color: #999;">&#xe615;</i></div>
                    </div>
                </li> -->

                <!-- <li class="layui-nav-item ">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="button" class="layui-btn layui-btn-warm" id = "tiwen">发帖</button>
                </li> -->

                <%--<li class="layui-nav-item">--%>
                    <%--<a href="">选项</a>--%>
                    <%--<dl class="layui-nav-child">--%>
                        <%--<dd><a href="javascript:;" id="xiugai_mi">修改密码</a></dd>--%>
                        <%--<dd><a href="javascript:;" >退出系统</a></dd>--%>
                    <%--</dl>--%>
                <%--</li>--%>
            </ul>
        </div>
    </div>
</div>

<div class="layui-container content">
    <div class="layui-row layui-col-space14">
        <div class="layui-col-md9 ">
            <!-- 左边 -->
            <div class="grid-demo grid-demo-bg1 zuo" id = "demo">

            </div>
        </div>
        <div class="layui-col-md3 ">
            <!-- 右边 -->
            <div class="grid-demo zuo">
                <div class = "yonghu" style="border: 1px solid white;width: 100%;">
                    <div style = "text-align: center;margin-top: 2.5rem;">
                        <img src="${user.headImg}" style = "width: 3.75rem;height: 3.75rem;border: 0.1875rem solid #009688;border-radius: 50%;" />
                    </div>
                    <div style = "margin-top: 1.125rem;font-weight: bold;font-size: 1rem;text-align: center;">${user.realName}</div>
                    <div style = "margin-top: 1.125rem;text-align: center;font-size: 0.625rem;color: #999;">
                        ${user.memo}</div>
                    <div style = "font-size: 0.625rem;color: #999;;height: 3.125rem;border-top: 1px solid #E0E0E0;border-bottom: 1px solid #E0E0E0;margin: 0.9375rem 0.9375rem 0rem 0.9375rem;line-height: 3.125rem;">
                        社交：&nbsp;&nbsp;&nbsp;&nbsp;
                        <i class="layui-icon layui-icon-login-qq tubiao"></i> &nbsp;&nbsp;
                        <i class="layui-icon layui-icon-login-wechat tubiao"></i> &nbsp;&nbsp;
                        <i class="layui-icon layui-icon-login-weibo tubiao"></i>
                    </div>
                    <div style = "padding: 1.25rem 3rem 1.25rem 3rem;height: 3.125rem;">
                        <div style = "height: 100%;float: left;color: #999;text-align: center;">文章</br></br><span class="shuzi">${user.articleCount}</span></div>
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

</body>

</html>
