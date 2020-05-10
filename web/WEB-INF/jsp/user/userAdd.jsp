<%--
  Created by IntelliJ IDEA.
  User: wulei
  Date: 2020/5/1
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("path", contextPath);
    %>
    <title>添加用户</title>
    <link rel="stylesheet" type="text/css" href="${path}/js/layui/css/layui.css"/>
    <script type="text/javascript" src="${path}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layui/layui.js"></script>
    <script type="text/javascript">
        $(function(){
            layui.use(['layer','element','form','upload'],function(){
                var layer = layui.layer;
                var element = layui.element;
                var form = layui.form;
                var upload = layui.upload;


                var uploadInst = upload.render({
                    elem: '#test1' //绑定元素
                    ,url: '${path}/fileUploadAction/uploadLayui.action' //上传接口
                    ,accept:'images'
                    ,size:5000
                    ,field:"userimg"
                    ,done: function(res){
                        $('#touxiang').attr('src', res.data.src);
                        $("#touimg").val(res.data.src);
                        layer.msg(res.msg);
                        //上传完毕回调
                    }
                    ,error: function(){
                        //请求异常回调
                        layer.msg('上传失败');
                    }
                });


                form.verify({
                    userName: function(value, item){ //value：表单的值、item：表单的DOM对象
                        if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
                            return '用户名不能有特殊字符';
                        }
                        if(/(^\_)|(\__)|(\_+$)/.test(value)){
                            return '用户名首尾不能出现下划线\'_\'';
                        }
                        if(!/^[\S]{5,12}$/.test(value)){
                            return '用户名必须5到12位，且不能出现空格'
                        }

                        var str = "";
                        $.ajax({
                            url:"${path}/user/checkUserName.action",
                            type:"post",
                            dataType:"text",
                            async:false,
                            data:{userName: $.trim($("#userName").val())},
                            success: function(data) {
                                if(parseInt(data) > 0){
                                    str = "用户名已存在";
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

                $("#moren").click(function(){
                    $("#password").val("123456");
                })

                form.on('submit(*)', function(data){

                    layer.confirm('确定添加?', function(index){
                        // console.log(getFormData("#myForm"));
                        $.ajax({
                            type:"POST",
                            async: false,  //默认true,异步
                            data:getFormData("#myForm"),
                            dataType:"text",
                            url:"${path}/user/userAdd.action",
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
                        data[item.name]=data[item.name]+','+item.value;
                    }
                }
            });
            //console.log(data);
            return data;
        }
    </script>
</head>
<body style = "padding:20px 30px 0px 0px">

<form class="layui-form" id = "myForm" enctype="multipart/form-data"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
    <div class="layui-form-item">
        <label class="layui-form-label">用户名：</label>
        <div class="layui-input-block">
            <input type="text" name="userName" id = "userName" placeholder="请输入用户名" autocomplete="off" lay-verify="required|userName" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码：</label>
        <div class="layui-input-block" style = "width: 280px;">
            <input type="password" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input" id = "password">
            <button type="button" class="layui-btn" style = "position: absolute;top:0px;right:-80px;" id="moren">默认</button>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">昵称：</label>
        <div class="layui-input-block">
            <input type="text" name="realName" placeholder="请输入昵称" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户等级：</label>
        <div class="layui-input-block">
            <select name="userType" lay-filter="dengji">
                <option value="1">用户</option>
                <option value="2">管理员</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别：</label>
        <div class="layui-input-block">
            <input type="radio" name="gender" value="0" title="男"checked>
            <input type="radio" name="gender" value="1" title="女" >
        </div>
    </div>
    <div class="layui-form-item ">
        <label class="layui-form-label">手机号码：</label>
        <div class="layui-input-block">
            <input type="text" name="phone" placeholder="请输入手机号码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item ">
        <label class="layui-form-label">邮箱：</label>
        <div class="layui-input-block">
            <input type="text" name="email" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item ">
        <label class="layui-form-label">个性签名：</label>
        <div class="layui-input-block">
            <input type="text" name="memo" placeholder="请输入签名" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item ">
        <label class="layui-form-label">头像：</label>
        <div class="layui-input-block">
            <img src="${path}/js/images/login_logo.png" id = "touxiang" width = "100px" height="100px" />
            <input type="hidden" value = "" id = "touimg" name = "headImg" <%--lay-verify = "touimg"--%> />
            <button style = "position: absolute;top: 0px;right:170px;" type="button" class="layui-btn  layui-btn-sm layui-btn-warm" id="test1">
                <i class="layui-icon">&#xe67c;</i>上传头像
            </button>
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
