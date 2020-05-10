<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/1
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <title>配置大棚</title>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <script type="text/javascript">
        var grows = ${grows};
        var chuanList = ${chuanList};
        $(function(){

            layui.use(['layer','element','form','upload'],function(){
                var layer = layui.layer;
                var element = layui.element;
                var form = layui.form;
                var upload = layui.upload;


                $("#growName").val(grows.growName);
                $("#memo").val(grows.memo);
                $("#startWen").val(grows.startWen);
                $("#startShi").val(grows.startShi);
                $("#startGuang").val(grows.startGuang);
                $("#startEr").val(grows.startEr);
                $("#endWen").val(grows.endWen);
                $("#endShi").val(grows.endShi);
                $("#endGuang").val(grows.endGuang);
                $("#endEr").val(grows.endEr);


                for(var i = 0;i<grows.chuanGanList.length;i++){
                    $("#chuangan").append('<input type="checkbox" name="chuanId" value = "'+grows.chuanGanList[i].chuan.id+'" lay-skin="primary" checked="" title="'+grows.chuanGanList[i].chuan.cname+'">');
                }
                for(var i = 0;i<chuanList.length;i++){
                    $("#chuangan").append('<input type="checkbox" name="chuanId" value = "'+chuanList[i].id+'" lay-skin="primary" title="'+chuanList[i].cname+'">');
                }

                form.render();

                form.verify({
                    growName: function(value, item){ //value：表单的值、item：表单的DOM对象
                        if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
                            return '用户名不能有特殊字符';
                        }
                        if(/(^\_)|(\__)|(\_+$)/.test(value)){
                            return '用户名首尾不能出现下划线\'_\'';
                        }
                        if(!/^[\S]{0,12}$/.test(value)){
                            return '用户名必须5到12位，且不能出现空格'
                        }

                        var str = "";
                        $.ajax({
                            url:"${path}/chuan/checkGrowName.action",
                            type:"post",
                            dataType:"text",
                            async:false,
                            data:{"growName": $.trim($("#growName").val())},
                            success: function(data) {
                                if(parseInt(data) > 0){
                                    if($.trim($("#growName").val()) == grows.growName){

                                    }else{
                                        str = "名称已存在";
                                    }
                                }
                            }
                        });
                        return str;

                    },
                    touimg: function(value, item){
                        if(value==''){
                            return '请上传头像'
                        }
                    }

                    //我们既支持上述函数式的方式，也支持下述数组的形式
                    //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
                    ,password: [
                        /^[\S]{6,20}$/
                        ,'密码必须6到20位，且不能出现空格'
                    ]
                    ,realName: [
                        /^[\S]{2,20}$/
                        ,'姓名必须2到20位，且不能出现空格'
                    ]
                    ,position: [
                        /^[\S]{0,10}$/
                        ,'姓名必须0到10位，且不能出现空格'
                    ]
                    ,address: [
                        /^[\S]{1,100}$/
                        ,'地址不能超过100位'
                    ]

                });

                form.on('submit(*)', function(data){

                    layer.confirm('确定修改?', function(index){
                        $.ajax({
                            type:"POST",
                            async: false,  //默认true,异步
                            data:getFormData("#myForm"),
                            dataType:"text",
                            url:"${path}/chuan/growUpdate.action?id="+grows.id,
                            success:function(data){
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.layer.close(index); //再执行关闭
                                layer.msg("修改成功！");
                            }
                        });
                    });
                    // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                    // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });

                form.render();

            });


        })

        function getFormData(formId){
            var data = {};
            var results = $(formId).serializeArray();
            $.each(results,function(index,item){
                //文本表单的值不为空才处理
                if(item.value && $.trim(item.value)!=""){
                    if(!data[item.name]){
                        data[item.name]=item.value;
                    }else{
                        //name属性相同的表单，值以英文,拼接
                        data[item.name]=data[item.name]+';'+item.value;
                    }
                }
            });
            //console.log(data);
            return data;
        }
    </script>
</head>
<body style = "padding:20px 30px 0px 0px">

<form class="layui-form" id = "myForm" > <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
    <div class="layui-form-item">
        <label class="layui-form-label">大棚名称：</label>
        <div class="layui-input-block">
            <input type="text" name="growName" id = "growName" placeholder="请输入大棚名称" autocomplete="off" lay-verify="required|growName" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">备注：</label>
        <div class="layui-input-block" >
            <input type="text" name="memo" placeholder="请输入备注" autocomplete="off" class="layui-input" id = "memo">
        </div>
    </div>

    <div class="layui-form-item" pane="">
        <label class="layui-form-label">传感器：</label>
        <div class="layui-input-block" id = "chuangan" style = "height: 50px;">
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">温度范围：</label>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="startWen" id = "startWen" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid">-</div>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="endWen" id = "endWen" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">湿度范围：</label>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="startShi" id = "startShi" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid">-</div>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="endShi" id = "endShi" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">二氧范围：</label>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="startEr" id = "startEr" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid">-</div>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="endEr" id = "endEr" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">照度范围：</label>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="startGuang" id = "startGuang" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid">-</div>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="number" name="endGuang" id = "endGuang" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>



    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="*">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</body>
</html>
