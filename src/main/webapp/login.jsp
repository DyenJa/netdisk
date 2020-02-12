<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%> 

<%@ page contentType="text/html;charset=utf-8"%> 

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Amaze UI Admin index Examples</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="assets/css/amazeui.datatables.min.css" />
    <link rel="stylesheet" href="assets/css/app.css">
    <script src="assets/js/jquery.min.js"></script>
	<script>
		$(function(){
			//注册提交按钮的点击事件
			$("#btn_login").click(function(){
				//1.获得整个表单
				var dataForm = new FormData(document.getElementById("loginform"));
			
				var name=dataForm.get("name");
				var pwd=dataForm.get("pwd");
			
				//2.发送ajax请求
				$.ajax({
					url:"loginhanle",
					type:"post",
					data:{name:name,pwd:pwd},
				
					dataType:"json",//这个datatype指的是返回的data
					
					success:function(data){
						if(data.result==true){
							
							window.location.href='<%=request.getContextPath()%>/UserBoard';
						}
						else{
							alert("登录失败");
						}
					}
				});
			});
		})
		</script>
</head>

<body data-type="login" style="    background-color: cadetblue;">
    <script src="assets/js/theme.js"></script>
    <div class="am-g tpl-g">
     
       
        <div class="tpl-login">
            <div class="tpl-login-content" style="background-color:aliceblue">
				<div align="right" style="margin: 0 0 30px 0;">
					<a href="register">注册</a>
				</div>
                <div style="vertical-align:middle;text-align:center">
					
						<i class="am-icon-cloud am-icon-lg" style="color: #0075B0; "></i>
						<p style="color: #0075B0; font-weight: bold;  font-style:italic; font-size:200%;">NJU NetDisk</p>
                </div>



                <form class="am-form tpl-form-line-form" id="loginform" >
                    <div class="am-form-group">
                        <input type="text" class="tpl-form-input"  name="name"  placeholder="请输入账号">

                    </div>

                    <div class="am-form-group">
                        <input type="password" class="tpl-form-input" name="pwd"   placeholder="请输入密码">

                    </div>
                    <div class="am-form-group tpl-login-remember-me">
                        <input id="remember-me" type="checkbox">
                        <label for="remember-me">
       
                        记住密码
                         </label>

                    </div>

                    <div class="am-form-group">

                        <button type="button" name="log" id="btn_login"  class="am-btn am-btn-primary  am-btn-block tpl-btn-bg-color-success  tpl-login-btn">提交</button>

                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="assets/js/amazeui.min.js"></script>
    <script src="assets/js/app.js"></script>

</body>

</html>