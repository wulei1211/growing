<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/3
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>文章列表</title>
    <script type="text/javascript">
        var layer = null;
        var table = null;
        $(function(){
            layui.use(['layer','element','form','table','laydate'],function() {
                layer = layui.layer;
                var element = layui.element;
                var form = layui.form;
                table = layui.table;
                var laydate = layui.laydate;

                table.render({
                    elem: '#test'
                    ,url: '${path}/artical/getAllArticles.action' //数据接口
                    ,page: true //开启分页
                    ,limit:10
                    ,limits:[10]
                    ,toolbar:"#test"
                    ,defaultToolbar: ['exports']
                    ,cols: [[ //表头
                        {type:'numbers',title:'序号',fixed:'left'},
                        {field: 'articleTitle', title: '文章标题',align:"center",templet:function(d){
                            return '<a style = "color:#1E9FFF" target = "_blank" href = "${path}/artical/articleDetail.action?articleId='+d.id+'">'+d.articleTitle+'</a>'
                            }}
                        ,{field: 'typeName', title: '文章类型',align:"center" }
                        ,{field: 'articleCount', title: '浏览次数',align:"center" }
                        ,{field: 'userMsg', title: '作者' ,align:"center" ,templet:function(d){
                                return '<a style = "color:#1E9FFF" target = "_blank" href = "${path}/artical/toPerson.action?userId='+d.userMsg.id+'">'+d.userMsg.realName+'</a>'
                            }}
                        ,{field: 'createTime', title: '发表时间' ,align:"center" }
                        ,{field: 'editTime', title: '最后修改时间',align:"center" }
                        ,{field: 'id', title: '操作',align:"center" ,templet:function (d) {
                                var html = "";
                                html += '<button type="button" class="layui-btn  layui-btn-sm" onclick="editRowOne(\''+d.id+'\')" >修改</button>';
                                html += '<button type="button" class="layui-btn layui-btn-danger layui-btn-sm" onclick="deleteRowOne(\''+d.id+'\')">禁用</button>';
                                return html;
                            }}
                    ]],
                });


                //日期
                var nowTime=new Date();
                var startTime=laydate.render({
                    elem:'#startTime',
                    type:'datetime',
                    max:'nowTime',//默认最大值为当前日期
                    done:function(value,date){
                        endTime.config.min={
                            year:date.year,
                            month:date.month-1,//关键
                            date:date.date,
                            hours:date.hours,
                            minutes:date.minutes,
                            seconds:date.seconds
                        };
                    }
                })

                var endTime=laydate.render({
                    elem:'#endTime',
                    type:'datetime',
                    done:function(value,date){
                        startTime.config.max={
                            year:date.year,
                            month:date.month-1,//关键
                            date:date.date,
                            hours:date.hours,
                            minutes:date.minutes,
                            seconds:date.seconds
                        }
                    }
                })

                $("#chaxun").click(function () {
                    var articleTitle = $("#articleTitle").val();
                    var articleType = $("#articleType").val();
                    var startTime = $("#startTime").val();
                    var endTime = $("#endTime").val();

                    table.reload('test', {
                        where: { //设定异步数据接口的额外参数，任意设
                            articleTitle: articleTitle
                            ,articleType: articleType
                            ,startTime:startTime
                            ,endTime:endTime
                        }
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                    });
                });

                var types = ${artTypeList};
                var str = '<option value = "">全部</option>';
                for(var i = 0;i<types.length;i++){
                    str += '<option value = "'+types[i].id+'">'+types[i].typeName+'</option>';
                }
                $("#articleType").html(str);
                form.render('select');
            });

        })
    </script>
</head>
<body style="overflow-x: hidden; background-color: white;margin: 10px;padding: 10px;">

<div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>文章管理</legend>
    </fieldset>
    <div class="first_div"
         style="border-right: none; border-bottom: none; border-left: none;">


        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">文章标题：</label>
                <div class="layui-input-inline">
                    <input type="text" id="articleTitle" name="articleTitle" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">文章类型：</label>
                <div class="layui-input-inline">
                    <form class = "layui-form">
                        <select id="articleType" name="articleType">
                            <option value = "">全部</option>

                        </select>
                    </form>
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">发表时间：</label>
                <div class="layui-input-inline" style="width: 150px;">
                    <input type="text" name="startTime" id="startTime" placeholder="起始时间" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid">-</div>
                <div class="layui-input-inline" style="width: 150px;">
                    <input type="text" id="endTime" name="endTime" placeholder="结束时间" autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-inline">
                <button type="button" class="layui-btn  layui-btn-sm  layui-btn-warm" id = "chaxun">查看</button>
                <%--<button type="button" class="layui-btn  layui-btn-sm  layui-btn-warm" id= "tianjia" &lt;%&ndash;onclick="addRow()"&ndash;%&gt;>增加用户</button>--%>
            </div>

        </div>

        <table id="test" lay-filter="test" ></table>

    </div>
</div>
</body>
</html>
