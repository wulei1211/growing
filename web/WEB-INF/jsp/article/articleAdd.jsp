<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/4/21
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <title>写文章</title>
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/wangEditor-3.1.1/release/wangEditor.js" ></script>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <link rel="stylesheet" href="${path}/js/css/index.css">
    <script type="text/javascript">
        var editor;
        $(function(){
            var E = window.wangEditor
            editor = new E('#editor');

            // 自定义菜单配置
            editor.customConfig.menus = [
                // 'head',  // 标题
                'bold' /** 粗体*/, 'fontSize' /** 字号 */, 'fontName' /** 字体 */,'italic' /** 斜体 */,
                //	 		    'underline',  // 下划线
                'strikeThrough',  // 删除线
                'foreColor',  // 文字颜色
                // 'backColor',  // 背景颜色
                'link',  // 插入链接
                // 'list',  // 列表
                'justify',  // 对齐方式
                'quote',  // 引用
                // 'emoticon',  // 表情   打开后支持表情功能
                'image',  // 插入图片
                'table',  // 表格
                // 'video',  // 插入视频
                //	 		    'code',  // 插入代码
                'undo',  // 撤销
                'redo'  // 重复
            ]

            editor.customConfig.uploadImgServer = "${path}/fileUploadAction/upload.action"  // 上传图片到服务器
            // 将图片大小限制为 1M
            editor.customConfig.uploadImgMaxSize = 5 * 1024 * 1024
            editor.customConfig.uploadFileName = 'myFile';
            // editor.customConfig.showLinkImg= false;
            // 限制一次最多上传 1 张图片
            // editor.customConfig.uploadImgMaxLength = 1;

            editor.customConfig.uploadImgHooks = {
                before : function(xhr, editor, files) {

                },
                success : function(xhr, editor, result) {
                    console.log("上传成功");
                },
                fail : function(xhr, editor, result) {
                    console.log("上传失败,原因是"+result);
                },
                error : function(xhr, editor) {
                    console.log("上传出错");
                },
                timeout : function(xhr, editor) {
                    console.log("上传超时");
                }
            }
            editor.create();

            layui.use(['layer'],function(){

                var layer = layui.layer;
                var content = "";
                $("#tiwen").click(function () {
                    var index = $("#title").val().length;
                    if(index<=0 ){
                        layer.msg("请输入标题！");
                        return ;
                    }
                    if(index>50){
                        layer.msg("标题不超过50个字！");
                        return ;
                    }
                    content = editor.txt.html();
                    var realContent = content.replace(/<[^<>]+>/g,"");
                    if(realContent.length<=5){
                        if(realContent.length==0){
                            layer.msg("请输入正文内容！");
                            return ;
                        }else {
                            layer.msg("正文至少5个字！");
                            return ;
                        }
                    }

                    $("#xuanxiang").slideToggle();
                });

                $(".xuan").click(function(){
                    $(this).siblings().removeClass("ok");
                    $(this).removeClass("layui-btn-primary");
                    $(this).siblings().addClass("layui-btn-primary");
                    $(this).addClass("ok");
                })

                $("#fasong").click(function(){
                    if($(this).parent("div").prev().find("button").hasClass("ok")){
                        var data = {};
                        data.master = "${userId}";
                        data.articleContent = content;
                        data.articleTitle = $("#title").val();
                        data.articleType = $("#anniu .ok").attr("arttype");
                        layer.confirm('确认发布？', {icon: 3, title:'提示'}, function(index){
                            $.ajax({
                                type:"POST",
                                async: false,  //默认true,异步
                                dataType:"text",
                                data:data,
                                url:"${path}/artical/articleAdd.action",
                                success:function(data){
                                    if(data == "success"){
                                        window.close();
                                    }
                                }
                            });
                            layer.close(index);
                            <%--window.location.href = "${path}/index/toIndexPage.action";--%>
                        });
                    }else{
                        layer.msg("请选择文章类型！")
                    }
                })

                window.onbeforeunload = function() {
                    //这里刷新方答法有很多，具体要回看你的子窗答口是怎样出来的
                    // window.opener.location.reload();
                    //parent.location.reload();
                    //self.opener.location.reload();
                    // window.opener.location.href=window.opener.location.href;
                    window.opener.test();
                };

            })
        });


    </script>
</head>
<body>
<div class="tou">
    <div class="layui-row">
        <div class="layui-container">
            <ul class="layui-nav layui-bg-green" lay-filter="">
                <li class="layui-nav-item" style = "font-size: 1.25rem;">写文章</li>

                <li class="layui-nav-item  layui-layout-right">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <div style = "position: absolute;top: 0.625rem;right: 5.625rem;">
                        <button type="button" class="layui-btn layui-btn-warm" id = "tiwen">发帖</button>
                    </div>

                    <div id = "xuanxiang" style = "display: none;width: 12.5rem;box-shadow: 0px 0px 8px #999;padding-left: 0.625rem;padding-right: 0.625rem;">
                        <div style = "font-weight: bold;color: #1A1A1A;font-size: 1rem;border-bottom: 0.03125rem solid #efefef;">
                            请选择文章类型
                        </div>
                        <div id = "anniu" style = "text-align: center;border-bottom: 0.03125rem solid #E0E0E0;padding-bottom: 0.625rem;">
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary xuan" arttype = "1">分享交流</button>
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary xuan" arttype = "2">问题反馈</button>
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary xuan" arttype = "3">其他</button>
                        </div>
                        <div style = "text-align: center;padding: 0.625rem 0 0.625rem 0;">
                            <button type="button" class="layui-btn layui-btn-sm" id = "fasong">发送</button>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class = "wenzhang">
    <div class="layui-form-item layui-form-text">
        <div>
            <textarea placeholder="请输入标题(最多50个字)" class="layui-textarea" style="font-weight: bold;font-size: 1.125rem;" id = "title"></textarea>
        </div>
    </div>

    <div id="editor" >
    </div>
</div>
</body>
</html>
