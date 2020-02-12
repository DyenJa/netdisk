<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
			$("#btn_register").click(function(){
				//1.获得整个表单
				var dataForm = new FormData(document.getElementById("registerform"));
			
				var name=dataForm.get("user_name");
				var email=dataForm.get("user_email");
				var password=dataForm.get("user_password");
				var password2=dataForm.get("user_password_again");
				
				if(password!=password2)
					alert("两次密码不一致");
				else if (document.getElementById("remember-me").checked==false)
					alert("用户注册协议未同意，无法注册")
				else{
					//2.发送ajax请求
					$.ajax({
						url:"registerhanle",
						type:"post",
						data:{name:name,password:password,email:email},
					
						dataType:"json",//这个datatype指的是返回的data
						success:function(data){
							if(data.result==true){
								alert("注册成功，请前往邮箱确认！");
								window.location.href='<%=request.getContextPath()%>/UserBoard';
							}
							else{
								alert("注册失败，用户名或邮箱已存在");
							}
						}
					});
					
					
				}
				
			});
		})
		</script>
</head>

<body data-type="login" style="    background-color: cadetblue;">
    <script src="assets/js/theme.js"></script>
    <div class="am-g tpl-g" style="vertical-align: top; ">
        
        <div class="tpl-login" style="vertical-align: top; ">
            <div class="tpl-login-content"  style="background-color:aliceblue">
				
				<div style="vertical-align:middle;text-align:center">
					
						<i class="am-icon-cloud am-icon-lg" style="color: #0075B0; "></i>
						<p style="color: #0075B0; font-weight: bold;  font-style:italic; font-size:200%;">NJU NetDisk</p>
				</div>
              
                <span class="tpl-login-content-info">
					创建一个新的用户
                </span>


                <form class="am-form tpl-form-line-form"   id="registerform">
                    <div class="am-form-group">
                        <input type="text" class="tpl-form-input" name="user_email" placeholder="邮箱">

                    </div>

                    <div class="am-form-group">
                        <input type="text" class="tpl-form-input" name="user_name" placeholder="用户名">
                    </div>

                    <div class="am-form-group">
                        <input type="password" class="tpl-form-input" name="user_password" placeholder="请输入密码">
                    </div>

                    <div class="am-form-group">
                        <input type="password" class="tpl-form-input" name="user_password_again" placeholder="再次输入密码">
                    </div>

                    <div class="am-form-group tpl-login-remember-me">
                        <input id="remember-me" type="checkbox">
                        <label for="remember-me">
       
                        我已阅读并同意 <a href="javascript:;">《用户注册协议》</a> 
                         </label>

                    </div>


                    <div class="am-form-group">

                        <button type="button" id="btn_register" class="am-btn am-btn-primary  am-btn-block tpl-btn-bg-color-success  tpl-login-btn">提交</button>

                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="assets/js/amazeui.min.js"></script>
    <script src="assets/js/app.js"></script>

</body>

</html>