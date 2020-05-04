<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/4/24
  Time: 1:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <title>${article.articleTitle}</title>

    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <link rel="stylesheet" href="${path}/js/css/index.css">
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <script type='text/javascript' src='${path }/dwr/engine.js'></script>
    <script type='text/javascript' src='${path }/dwr/util.js'></script>
    <script type="text/javascript" src="${path }/dwr/interface/MessagePush.js"></script>
    <script type="text/javascript" src="${path }/js/naranja.js"></script>
    <link rel="stylesheet" href="${path }/js/css/naranja.min.css">
    <script type="text/javascript">

        var pingList = '${pingList}';
        var reList = '${reList}';

        $(function () {

            //dwr
            dwr.engine.setActiveReverseAjax(true);
            dwr.engine.setNotifyServerOnPageUnload(true);
            onPageLoad();

            if("${user.id}" == "${artUser.id}"){
                $("#anniu_button").css({"display":"none"});
            }


            layui.use(["layer","element","flow"],function(){
                var layer = layui.layer;
                var element = layui.element;

                var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
                var flow = layui.flow;
                flow.load({
                    elem: '#demo' //指定列表容器
                    ,done: function(page, next){ //到达临界点（默认滚动触发），触发下一页
                        var lis = [];
                        //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                        $.get('${path}/artical/getAllPingLunByArticleId.action?page='+page+'&articleId=${articleId}', function(res){
                            //假设你的列表返回在data集合中
                            layui.each(res.data, function(index, item){
                                var str = '';
                                str += '<div class = "pinglun_tou"><div class = "pinlun_hover"><div class = "pinglun_id" style = "display:none">'+item.id+'</div>';
                                str += '       <span class = ""><img src="'+item.headImg+'" class = "pinglun_touxiang" />&nbsp;&nbsp;</span>';
                                str += '   <span style="color: #999;">'+item.realName+'&nbsp;：</span>';
                                str += '      <div class="pinglun_content">';
                                str += item.pingLunContent;
                                str += '  <span class = "pinglun_time">&nbsp;&nbsp;'+item.time+'</span>';
                                str += ' </div>'
                                str += '    <span class="pinglun_xian">';
                                str += '      <span class="huifu hui fu">回复&nbsp;&nbsp;&nbsp;&nbsp;</span><span style = "display:none">'+item.userId+'</span>';
                                if(item.replayCount>0){
                                    str += '  <span class = "chakan">查看回复('+item.replayCount+')</span>&nbsp;&nbsp;&nbsp;&nbsp;';
                                }else{
                                    str += '  <span class = "shouqi"">收起评论</span>&nbsp;&nbsp;&nbsp;&nbsp;';
                                }
                                str += '<div style = "display: none">'+item.id+'</div>'

                                var pingIndex = pingList.indexOf(item.id);
                                if(pingIndex!=-1){
                                    str += '     <i class="layui-icon layui-icon-praise dianzan ping_dian" xuan = "ok" style="margin-top: 0.625rem;color: red">';
                                    str += '    <span style="font-size: 0.7rem;">'+item.pingLunDianCount+'</span></i>';
                                }else{
                                    str += '     <i class="layui-icon layui-icon-praise dianzan ping_dian" style="margin-top: 0.625rem;">';
                                    str += '    <span style="font-size: 0.7rem;">'+item.pingLunDianCount+'</span></i>';
                                }


                                str +=     '</span>';
                                str += '    </div></div>';
                                lis.push(str);
                            });

                            //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                            //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                            next(lis.join(''), page < res.pages);
                        });
                    }
                });

                $(document).on("click",".huifu",function(){
                    $("#ping").focus();
                    $("#ping").attr("placeholder","");
                });

                var temp = "";
                $(document).on("click",".chakan",function(){
                    var _this = $(this);
                    var pId = $(this).parent("span").find("div").text();
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"json",
                        data:{"pId":pId},
                        url:"${path}/artical/getAllReplayOfPingLun.action",
                        success:function(data){
                            var str = '<div class="ping_huifu">';
                            for(var i = 0;i<data.length;i++){
                                str += '     <div class = "pinglun_tou_hui">';
                                str += '      <span class = ""><img src="'+data[i].huiTou+'" class = "pinglun_touxiang" />&nbsp;&nbsp;</span>';
                                str += '   <span style="color: #999;">'+data[i].huiName;
                                str += '      <span style="font-size: 0.5rem;">&nbsp;&nbsp;回复&nbsp;&nbsp;</span>';
                                str += '    <span>'+data[i].beiName+'</span>：';
                                str += '   </span>';
                                str += '  <span class="pinglun_xian_hui">';
                                str += '     <span class="huifu hui">回复&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style = "display:none">'+data[i].replayer+'</span>';

                                var pingIndex = reList.indexOf(data[i].id);
                                if(pingIndex!=-1){
                                    str += ' <i class="layui-icon layui-icon-praise dianzan" xuan_hui = "ok" style="color: red;margin-top: 0.625rem;">';
                                    str += '    <span style="font-size: 0.7rem;">'+data[i].replayDianCount+'</span><div style = "display: none;">'+data[i].id+'</div></i>';
                                }else{
                                    str += ' <i class="layui-icon layui-icon-praise dianzan" style="margin-top: 0.625rem;">';
                                    str += '    <span style="font-size: 0.7rem;">'+data[i].replayDianCount+'</span><div style = "display: none;">'+data[i].id+'</div></i>';
                                }
                                str +=     '</span><div class="pinglun_content_hui">';
                                str += data[i].replayContent;
                                str += '  <span class = "pinglun_time">&nbsp;&nbsp;'+data[i].time+'</span>';
                                str += '  </div></div>';
                            }
                            str += '</div>';
                            _this.parent("span").parent("div").parent("div").append(str);
                        }

                    });
                    temp = _this.text();
                    _this.text("收起评论");
                    _this.removeClass("chakan");
                    _this.addClass("shouqilai");
                });

                $(document).on("click",".dianzan",function(){
                    var pingLunId = "";
                    var dianType = "";
                    var type = "";
                    if($(this).hasClass("ping_dian")){
                        //评论的点赞
                        if(typeof($(this).attr("xuan")) != "undefined"){
                            $(this).css({"color":""})
                            $(this).removeAttr("xuan");
                            var index = jiaXiHuan($(this).find("span").text(),"2");
                            $(this).find("span").text(index);
                            type = "2";//减1
                        }else{
                            $(this).css({"color":"red"})
                            $(this).attr({"xuan":"ok"});
                            var index = jiaXiHuan($(this).find("span").text(),"1");
                            $(this).find("span").text(index);
                            type = "1";//加1
                        }
                        pingLunId = $(this).parent("span").find("div").text();
                        dianType = "1";
                    }else{
                        //回复的点赞
                        if(typeof($(this).attr("xuan_hui")) != "undefined"){
                            $(this).css({"color":""})
                            $(this).removeAttr("xuan_hui");
                            var index = jiaXiHuan($(this).find("span").text(),"2");
                            $(this).find("span").text(index);
                            type = "2";//减1
                        }else{
                            $(this).css({"color":"red"})
                            $(this).attr({"xuan_hui":"ok"});
                            var index = jiaXiHuan($(this).find("span").text(),"1");
                            $(this).find("span").text(index);
                            type = "1";//加1
                        }
                        pingLunId = $(this).find("div").text();
                        dianType = "2";
                    }
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"json",
                        data:{"pingLunId":pingLunId,"dianType":dianType,"type":type},
                        url:"${path}/artical/changePingLunZan.action",
                        success:function(data){

                        }
                    });
                });

                var _huifu = null;
                $(document).on("click",".hui",function(){
                    _huifu = $(this);

                    $("#pinglunfa").find("div").text("1");
                    var name = $(this).parent("span").parent("div").find("span:eq(1)").text();
                    if(_huifu.hasClass("fu")){
                        $("#ping").attr({"placeholder":"回复 "+name});
                    }else{
                        $("#ping").attr({"placeholder":"回复 "+name.substring(0,name.indexOf("回复")).trim()+"："});
                    }

                    $("#ping").css({"height":"4.5rem"});
                    $("#ping").parent("div").parent("div").parent("div").animate({"height":"4.5rem"},200)
                    $("#quxiaohuifu").css({"display":"inline"});
                });

                $("#pinglunfa").click(function(){
                    if($(this).find("div").text() == "1"){
                        var pinlun = $("#ping").val()
                        if(pinlun == ''){
                            layer.msg("请输入回复！");
                            return ;
                        }
                        if(pinlun.length>300) {
                            layer.msg("回复字数不超过300！");
                            return;
                        }
                        // 回复
                        var toUser = _huifu.next().text();
                        var pinlunid = "";
                        if(_huifu.hasClass("fu")){
                            //    对评论的回复
                            pinlunid = _huifu.parent("span").parent("div").find("div:eq(0)").text();
                        }else{
                            pinlunid = _huifu.parent("span").parent("div").parent("div").prev().find("div:eq(0)").text();
                            //对回复的回复
                        }
                        var data = {};
                        data.replayContent = $("#ping").val();
                        data.toPlayer = toUser;
                        data.pingLunId = pinlunid;
                        data.articleId = "${articleId}";
                        $.ajax({
                            type:"POST",
                            async: false,  //默认true,异步
                            dataType:"text",
                            contentType: 'application/json; charset=UTF-8',
                            data:JSON.stringify(data),
                            url:"${path}/artical/addReplay.action",
                            success:function(data){
                                if(data == "success"){
                                    layer.msg("回复成功！",{
                                        time: 500 //2秒关闭（如果不配置，默认是3秒）
                                    },function(){
                                        window.location.reload();
                                    });
                                }
                            }
                        });
                    }else{
                        //评论
                        var pinlun = $("#ping").val()
                        if(pinlun == ''){
                            layer.msg("请输入评论！");
                            return ;
                        }
                        if(pinlun.length>300) {
                            layer.msg("评论字数不超过300！");
                            return;
                        }else{
                            layer.confirm('确定发布评论?', {icon: 3, title:'提示'}, function(index){
                                //do something
                                $.ajax({
                                    type:"POST",
                                    async: false,  //默认true,异步
                                    dataType:"text",
                                    data:{"articleId":"${articleId}","pingLunContent":pinlun,"articleMasterId":"${artUser.id}"},
                                    url:"${path}/artical/addPingLun.action",
                                    success:function(data){
                                        if(data == "success"){

                                            layer.msg("发表成功！",{
                                                time: 500 //2秒关闭（如果不配置，默认是3秒）
                                            },function(){
                                                window.location.reload();
                                            });
                                        }
                                    }
                                });

                            });
                        }
                    }
                })

                $("#quxiaohuifu").click(function(){
                    $("#ping").attr({"placeholder":"想对作者说点什么"});
                    $("#ping").css({"height":""});
                    $("#ping").parent("div").parent("div").parent("div").animate({"height":"1.8rem"},200)
                    $("#quxiaohuifu").css({"display":"none"});
                    $("#pinglunfa").find("div").text("");
                });




                $(document).on("click",".shouqilai",function(){
                    $(this).parent("span").parent("div").next().remove();
                    $(this).removeClass("shouqilai")
                    $(this).addClass("chakan")
                    $(this).text(temp)
                });



                $("#guanzhu").click(function(){
                    var index = 0;
                    var type = "";
                    if($(this).hasClass("layui-btn-primary")){
                        //减1
                        $(this).removeClass("layui-btn-primary");
                        $(this).find("i").addClass("layui-icon-addition");
                        $(this).find("i").removeClass("layui-icon-ok")
                        $(this).find("span:eq(0)").text("关注");
                        $(this).find("span:eq(1)").text("他");
                        index = jiaXiHuan($(".guanzhuzhe").text(),"2");
                        type = 2;
                    }else{
                        //加1
                        $(this).addClass("layui-btn-primary");
                        $(this).find("i").removeClass("layui-icon-addition");
                        $(this).find("i").addClass("layui-icon-ok");
                        $(this).find("span:eq(0)").text("已关注");
                        $(this).find("span:eq(1)").text("");
                        index = jiaXiHuan($(".guanzhuzhe").text(),"1");
                        type = 1;
                    }
                    $(".guanzhuzhe").text(index);
                    $.ajax({
                        type:"POST",
                        async: false,  //默认true,异步
                        dataType:"text",
                        data:{"type":type,"beiGuan":"${artUser.id}"},
                        url:"${path}/artical/changeGuanZhu.action",
                        success:function(data){

                        }
                    })


                });

                $("#jinGeRen").click(function(){
                    window.open(
                        "${path}/artical/toPerson.action?userId="+"${artUser.id}"
                    );
                });


                // $(document).on("focus","#ping",function(){
                //     $(this).css({"box-shadow":"0px 0px 8px #009688"})
                //     $(this).css({"height":"5rem"});
                //     $(this).parent("div").parent("div").parent("div").animate({"height":"5rem"},200)
                // })
                // $(document).on("blur","#ping",function(){
                //     $(this).css({"box-shadow":""})
                //     $(this).css({"height":""});
                //     $(this).parent("div").parent("div").parent("div").animate({"height":"1.8rem"},200)
                //     var tep = $("#ping").attr("placeholder");
                //     if(tep.indexOf("回复")>=0){
                //         return ;
                //     }
                //     $("#ping").attr("placeholder","想对作者说点什么");
                // })

            });

            function jiaXiHuan(shuzi,type){
                var temp = parseInt(shuzi);
                if(type == '1'){
                    return temp+1;
                }else{
                    return temp-1;
                }
            }
        });

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
<body  style="background-color: #F6F6F6;">
<div class="tou">
    <div class="layui-row">
        <div class="layui-container">
            <ul class="layui-nav layui-bg-green" lay-filter="">
                <li class="layui-nav-item layui-this"><a href="">首页</a></li>
                <li class="layui-nav-item"><a href="">关注</a></li>
                <li class="layui-nav-item"><a href="">回答</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">我的</a>
                    <dl class="layui-nav-child"> <!-- 二级菜单 -->
                        <dd><a href="">我的点赞</a></dd>
                        <dd><a href="">我的评论</a></dd>
                        <dd><a href="">我的转发</a></dd>
                    </dl>
                </li>
                <%--<li class="layui-nav-item lvxian">--%>
                    <%--<div class="layui-input-block" style = "width:320px;position: relative;">--%>
                        <%--<input type="text" name="title" placeholder="请输入关键词" class="layui-input" id = "shuru">--%>
                        <%--<div class = "sousuoicon"><i class="layui-icon" style="font-size: 22px; color: #999;">&#xe615;</i></div>--%>
                    <%--</div>--%>
                <%--</li>--%>

                <%--<li class="layui-nav-item ">--%>
                    <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
                    <%--<button type="button" class="layui-btn layui-btn-warm" id = "tiwen">发帖</button>--%>
                <%--</li>--%>
                <div class = "one">
                    <li class="layui-nav-item layui-layout-right">
                        <a href=""><i class="layui-icon" style="font-size: 20px;">&#xe667;</i><span class="layui-badge">9</span></a>
                    </li></div>
                <div class = "two">
                    <li class="layui-nav-item layui-layout-right">
                        <a href="">个人中心</a>
                    </li></div>
                <li class="layui-nav-item layui-layout-right">
                    <a href="">选项</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">修改信息</a></dd>
                        <dd><a href="javascript:;">安全管理</a></dd>
                        <dd><a href="javascript:;">退了</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="layui-container content">
    <div class="layui-row layui-col-space14">
        <div class="layui-col-md9 ">
            <!-- 左边 -->
            <div class="grid-demo grid-demo-bg1 zuo">
                <div class="detail_title">
                    ${article.articleTitle}
                </div>
                <div class = "biao">
                    <div class="detail_time">
                        发布时间：${article.createTime}
                    </div>
                    <div class="detail_biaoji">

                        <i class="layui-icon layui-icon-username detail_biaoji">浏览<span>${article.articleCount}</span></i>
                        <i class="layui-icon layui-icon-star detail_biaoji">收藏<span>${article.shouCangCount}</span></i>
                        <i class="layui-icon layui-icon-heart detail_biaoji">点赞<span>${article.articleLove}</span></i>
                    </div>
                    <div class = "clear"></div>
                </div>

                <div class = "detail_content biao">
                    ${article.articleContent}
                </div>
                <div class = "detail_pinglun">
                    <div class="">
                        <div class = ""><img src="${user.headImg}" class = "pinglun_touxiang" />&nbsp;&nbsp;</div>

                        <div class = "pinglun_fabiao">
                            <input type="text" placeholder="想对作者说点什么" class="layui-input" id = "ping" >
                        </div>
                        <button type="button" class="layui-btn fabiao" id = "pinglunfa">发表<div style = "display: none"></div></button>
                        <button type="button" class="layui-btn layui-btn-warm qquxiao" id = "quxiaohuifu">取消</button>
                    </div>
                </div>
                <div class = "biao" id = "demo">
                    <!-- 评论 -->
                    <%--<div class = "pinglun_tou">--%>
                        <%--<span class = ""><img src="res/343.jpeg" class = "pinglun_touxiang" />&nbsp;&nbsp;</span>--%>
                        <%--<span style="color: #999;">万人敬仰：</span>--%>
                        <%--<span class="pinglun_xian">--%>
									<%--<span class="huifu">回复&nbsp;&nbsp;&nbsp;&nbsp;</span>--%>
									<%--<span class = "shouqi">收起评论</span>&nbsp;&nbsp;&nbsp;&nbsp;--%>
									<%--<i class="layui-icon layui-icon-praise" style="color: #999;margin-top: 0.625rem;">--%>
										<%--<span style="font-size: 0.7rem;">12</span>--%>
									<%--</i>--%>
								<%--</span>--%>
                        <%--<div class="pinglun_content">--%>
                            <%--你好，显示帖子和评论以及恢复内容信息的sql内容怎么写，一个接口实现的--%>
                            <%--容怎么写，一个接口实现的容怎么写，一个接口实现的--%>
                            <%--<span class = "pinglun_time">&nbsp;&nbsp;2020-10-23</span>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<!-- 回复 -->--%>
                    <%--<div class="ping_huifu">--%>
                        <%--<div class = "pinglun_tou_hui">--%>
                            <%--<span class = ""><img src="res/343.jpeg" class = "pinglun_touxiang" />&nbsp;&nbsp;</span>--%>
                            <%--<span style="color: #999;">万人敬仰--%>
										<%--<span style="font-size: 0.5rem;">&nbsp;&nbsp;回复&nbsp;&nbsp;</span>--%>
										<%--<span>万人经验</span>：--%>
									<%--</span>--%>
                            <%--<span class="pinglun_xian_hui">--%>
										<%--<span class="huifu">回复&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>--%>
										<%--<i class="layui-icon layui-icon-praise" style="color: #999;margin-top: 0.625rem;">--%>
											<%--<span style="font-size: 0.7rem;">12</span>--%>
										<%--</i>--%>
									<%--</span>--%>
                            <%--<div class="pinglun_content_hui">--%>
                                <%--你好，显示帖子和评论以及恢复内容信息的sql内容怎么写，一个接口实现的--%>
                                <%--容怎么写，一个接口实现的容怎么写，一个接口实现的容怎么写，一个接口实现的--%>
                                <%--<span class = "pinglun_time">&nbsp;&nbsp;2020-10-23</span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>


                </div>
            </div>
        </div>
        <div class="layui-col-md3 ">
            <!-- 右边 -->
            <div class="grid-demo zuo">


                <div class = "yonghu" style="border: 1px solid white;width: 100%;">
                    <div style = "text-align: center;margin-top: 2.5rem;">
                        <img src="${artUser.headImg}" style = "width: 3.75rem;height: 3.75rem;border: 0.1875rem solid #009688;border-radius: 50%;" />
                    </div>
                    <div style = "margin-top: 1.125rem;font-weight: bold;font-size: 1rem;text-align: center;cursor: pointer">
                        <span id = "jinGeRen">${artUser.realName}</span>
                        <c:if test="${booleanGuan==0}">
                            <span id="anniu_button">
                            &nbsp;&nbsp;
									<button type="button" id= "guanzhu" class="layui-btn layui-btn-sm layui-btn-radius"><i class="layui-icon layui-icon-addition"></i>  <span>关注</span><span>他</span></button>
								</span>
                        </c:if>
                        <c:if test="${booleanGuan>0}">
                            <span id="anniu_button">
                            &nbsp;&nbsp;
									<button type="button" id= "guanzhu" class="layui-btn layui-btn-sm layui-btn-primary layui-btn-radius"><i class="layui-icon layui-icon-ok"></i>  <span>已关注</span><span></span></button>
								</span>
                        </c:if>
                    </div>
                    <div style = " padding-bottom: 1rem;margin-top: 1.125rem;text-align: center;font-size: 0.625rem;color: #999;border-bottom: 1px solid #E0E0E0;margin: 0.9375rem 0.9375rem 0rem 0.9375rem;">
                        ${artUser.memo}</div>
                    <div style = "padding: 1.25rem 3rem 1.25rem 3rem;height: 3.125rem;">
                        <div style = "height: 100%;float: left;color: #999;text-align: center;"><span>文章</span></br></br><span class="shuzi">${artUser.articleCount}</span></div>
                        <div style = "height: 100%;float: right;color: #999;text-align: center;"><span>关注者</span></br></br><span class="shuzi guanzhuzhe">${artUser.guanZhuCount}</span></div>
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
