<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
		<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" style="height: 100%;">

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
<link rel="apple-touch-icon-precomposed"
	href="assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<style>
.white_content {
	display: none;
	position: absolute;
	top: 25%;
	left: 25%;
	width: 50%;
	background-color: white;
	z-index: 10001;
	overflow: auto;
}

.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: #595D60;
	z-index: 10000 !important;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 80);
}

.close {
	float: right;
	clear: both;
	width: 100%;
	text-align: right;
	margin: 0 0 6px 0
}

.close a {
	color: #333;
	text-decoration: none;
	font-size: 14px;
	font-weight: 700
}
</style>

<link rel="stylesheet" href="assets/css/jquery.treeview.css"type="text/css" />
<link rel="stylesheet" href="assets/css/screen.css" type="text/css" />
<link rel="stylesheet" href="dist/amazeui.tree.css" />
<link rel="stylesheet" href="assets/css/amazeui.min.css" />
<link rel="stylesheet" href="dist/amazeui.tree.min.css" />
<link rel="stylesheet" href="assets/css/amazeui.min.css" />
<link rel="stylesheet" href="assets/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="assets/css/app.css">
<script src="assets/js/echarts.min.js"></script>
<script src="assets/js/jquery.min.js"></script>
<script src="dist/amazeui.tree.min.js"></script>
<script src="assets/js/jquery-3.2.1.js"></script>
<script src="assets/js/jquery.cookie.js"></script>
<script src="assets/js/jquery.treeview.js" type="text/javascript"></script>
<script type="text/javascript">
		 $(function() {
			
			 $("#enter_notice").click(function(){
				$("#myFrame").attr("src","loadNotice?type=0&page=1"); 
				read();
				document.getElementById("notice_bell").click();
			});
				
			 
			 
			 $("body").on("click", ".am-tree-icon-folder", function() {
				    if($(this).attr("class")=="am-tree-icon am-tree-icon-folder am-icon-minus-square-o"){
						 $(this).parent().parent().next().addClass("am-hide");
						 
						 $(this).removeClass("am-icon-minus-square-o");
						 $(this).addClass("am-icon-plus-square-o"); 
					}
					else{
											 
						 var parentid= $(this).parent().parent().next().attr("id");
						 $.ajax({
								url:"getDirectory",
								data:{parentid:parentid},
								type:"post",				
								dataType:"json",
								success:function(data){
									console.log(data);
									
									var contents=window.parent.document.getElementById(parentid);
									contents.innerHTML="";
									for(var i=0;i<data.length;i++){
									  var html = '<li class="am-tree-branch" data-template="treebranch" role="treeitem" aria-expanded="true" aria-labelledby="F1-label">'+
														'<div class="am-tree-branch-header">'+
															'<button class="am-tree-branch-name ">';
											 	if(data[i].type=="folders"){
													  html+='<span class="am-tree-icon am-tree-icon-folder am-icon-plus-square-o" ></span>'+
													  		'<i class="am-icon-folder" style="color: #F37B1D;"></i>'+
															'<span class="am-tree-label" >'+data[i].name+'</span>'+
															'<span class="am-tree-label" style="display:none;">'+data[i].srcID+'</span>'+
															'</button>'+
														'</div>'+	
														'<ul class="am-tree-branch-children am-hide" role="group" id="'+data[i].srcID+'"></ul>'	
												  '</li>';	
											 	}
											 	else{
											 		 html+='<i class="am-icon-folder" style="color: #F37B1D;"></i>'+
															'<span class="am-tree-label" >'+data[i].name+'</span>'+
															'<span class="am-tree-label" style="display:none;">'+data[i].srcID+'</span>'+
															'</button>'+
														'</div>'+		
												  '</li>';
											 	}
										contents.innerHTML+=html;
									}
								}
							});
						 
						 $(this).parent().parent().next().removeClass("am-hide");
						$(this).removeClass("am-icon-plus-square-o");
						 $(this).addClass("am-icon-minus-square-o"); 
					}		
				});
			
			 
			 
			 $("body").on("click", "#move_confirm", function() {
					var moved_src= $("#moved_srcID").val();
					var target_folder=$("#target_folder").val();
			
					
					if($("#opration_type").val()=="copy"){
						$.ajax({
							url:"copy",
							data:{target_resource:moved_src,target_folder:target_folder},
							type:"post",				
							dataType:"json",
							success:function(data){
								if(data.result==true){
							         alert("保存成功！");
								   	  $.ajax({
									        type: "get",
									        url: "refreshSpace",
									        data:{}, 
									        dataType:"json",
									        success: function(res){
									        
									        	 $('#space_bar').width((102400-res.space)/1024+"%");
									        	 
									        	 $('#space_value').html(((102400-res.space)/1024).toFixed(2)+"M / 100M");
									        }
									    });	
								}
							}
						});
					}
					else if($("#opration_type").val()=="share_copy"){
						$.ajax({
							url:"share_copy",
							data:{target_resource:moved_src,target_folder:target_folder},
							type:"post",				
							dataType:"json",
							success:function(data){
								if(data.result==true){
							         alert("保存成功！");
								   	  $.ajax({
									        type: "get",
									        url: "refreshSpace",
									        data:{}, 
									        dataType:"json",
									        success: function(res){
									       
									        	 $('#space_bar').width((102400-res.space)/1024+"%");
									        	 
									        	 $('#space_value').html(((102400-res.space)/1024).toFixed(2)+"M / 100M");
									        }
									    });	
								}
							}
						});
					}
					
					else{
					 $.ajax({
							url:"changeFolder",
							data:{moved_src:moved_src,target_folder:target_folder},
							type:"post",				
							dataType:"json",
							success:function(data){
								if(data.result==true){
								
							        alert("移动成功！");
							        location.reload();
								}
								else{
									 alert("不可移动到本文件夹内");
								}
									
							}
						});
					}
					$('.box').hide();
					
			});
			 
			 
			 $("body").on("click", ".am-tree-label", function() {
				 if($(this).parent().parent().parent().is(".am-tree-selected")){
						
						$(this).parent().parent().parent().removeClass("am-tree-selected"); 
					}
					else{
						init();
						$(this).parent().parent().parent().addClass("am-tree-selected");
					
						 $("#target_folder").val($(this).next().html());
					}	
				});
			 $("body").on("click", ".am-icon-folder", function() {
				 if($(this).parent().parent().parent().is(".am-tree-selected")){
						
						$(this).parent().parent().parent().removeClass("am-tree-selected"); 
					}
					else{
						init();
						$(this).parent().parent().parent().addClass("am-tree-selected"); 
						
						 $("#target_folder").val($(this).next().next().html());
					}			  	
			});
			 
			
			 
			 $(".tpl-header-search-btn").click(function(){
				
				var key_word=$(".tpl-header-search-box").val();

				$("#myFrame").attr("src","search?name="+key_word+"&page=1"); 
			});
			
			 
			$('.tpl-header-search-box').bind('keypress', function (event) { 
				if (event.keyCode == "13") { 
					var key_word=$(".tpl-header-search-box").val();
					$("#myFrame").attr("src","search?name="+key_word+"&page=1")
				}
			})
		});
		
		 
		function openTree(){
		
		}
		function init(){
			var list = $(".am-tree-branch");
			for (var i = 0; i < list.length; i++) {
				if (list[i].className=="am-tree-branch am-tree-selected"||list[i].className=="am-tree-branch am-tree-open am-tree-selected") {
					list[i].setAttribute("class","am-tree-branch");
				}
			}
		}
		</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#treeview").treeview({

		});
	});
	
	$(document).on('click', '.candidateCheckbos', function(e) {
		if ($(e.target).is(':checked')) {
			$('#upload').css('display', 'none');
			$('#createFolder').css('display', 'none');
			$('#batchDownload').css('display', 'block');
			$('#batchShare').css('display', 'block');
			$('#batchDelete').css('display', 'block');
		} else {
			var list = $(".candidateCheckbos");
			var Unchecked = 0;
			for (var i = 0; i < list.length; i++) {

				if (list[i].checked == false)
					Unchecked++;

			}
			if (Unchecked == list.length) {
				$('#upload').css('display', 'block');
				$('#createFolder').css('display', 'block');
				$('#batchDownload').css('display', 'none');
				$('#batchShare').css('display', 'none');
				$('#batchDelete').css('display', 'none');
			}

		}
	});
</script>
<script>
	function setHeight() {
		
		var ele3 = document.getElementById("processbar");
		ele3.style.marginTop  = ((document.getElementById("theHead").offsetHeight-10)/2) + "px";
	
	}
	function read(){
		$(".item-feed-badge").html("");
	}
	function checkAll() {

		var list = $(".candidateCheckbos");
		var checked = 0;
		for (var i = 0; i < list.length; i++) {

			if (list[i].checked == true)
				checked++;

		}
		if (checked != list.length) {
			for (var i = 0; i < list.length; i++) {
				list[i].checked = true;
			}
			$('#upload').css('display', 'none');
			$('#createFolder').css('display', 'none');
			$('#batchDownload').css('display', 'block');
			$('#batchShare').css('display', 'block');
			$('#batchDelete').css('display', 'block');
		} else {
			for (var i = 0; i < list.length; i++) {
				list[i].checked = false;
			}
			$('#upload').css('display', 'block');
			$('#createFolder').css('display', 'block');
			$('#batchDownload').css('display', 'none');
			$('#batchShare').css('display', 'none');
			$('#batchDelete').css('display', 'none');
		}
	}

	function UpladFile() {
 		var fileObj = document.getElementById("file").files[0]; // js 获取文件对象	
		var FileController = "uploadhead.do?"; 	//上传到用户自己创建的文件夹
			// FormData 对象
		var form = new FormData($("#uploadForm")[0]);//创建一个form对象
		// XMLHttpRequest 对象
		var xhr = new XMLHttpRequest();//创建XMLHttpRequest对象
		xhr.open("post", FileController, true);//打开连接，(访问类型，地址，是否异步)
		xhr.onload = function() {//请求完成后执行  里面可用
			if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
				alert("success");//后台返回的数据
			} else {
				
			}
			
			$.ajax({
				url:"refreshHead",
				type:"get",
				data:{},
				dataType:"json",//这个datatype指的是返回的data
				success:function(data){
					$("#head").attr("src",data.result);
				
				},
                error: function (e) {
                	alert(e.message);
                }
				
			});
			
		};
		xhr.send(form);//发送请求
	}
	function getUrlParam(name) {
	    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
	    var r = window.location.search.substr(1).match(reg);  // 匹配目标参数
	    if (r != null) return unescape(r[2]); return null; // 返回参数值
	}
</script>
<script src="assets/js/myjs.js"></script>
</head>

<body data-type="widgets" style="height: 100%;" onload="setHeight()">
	
	<div class="box" style="position: fixed;width: 100%;height: 100%;background-color:rgba(0, 0, 0, 0.6);display: none ;Z-index:2000000">
		<div id="light" class="white_content" style="display:block;">	
			<div class="am-panel am-panel-default" style="margin-bottom:0">
			  <div class="am-panel-hd">
			  		<span style="float: left;"></span> 
			  		<a href="javascript:void(0)" onclick="jQuery('.box').hide()"> 关闭</a>
			  </div>
			  <div class="am-panel-bd" style="overflow-y: auto; overflow-x: auto; width: 100%; height: 400px;padding:0">
			   		<div id="main">
						<ul class="am-tree am-tree-folder-select" role="tree" id="myTreeSelectableFolder" >
							<li class="am-tree-branch" data-template="treebranch" role="treeitem" aria-expanded="true" aria-labelledby="F1-label">
								<div class="am-tree-branch-header">
									<button class="am-tree-branch-name ">
										<i class="am-icon-folder" style="color: #F37B1D;"></i>
										<span class="am-tree-label" >根目录</span>
										<span class="am-tree-label" style="display:none;">none</span>
									</button>
								</div>
								<ul class="am-tree-branch-children " role="group" id="myTree"></ul>
							</li>
						</ul>
					</div>
			  </div>

			</div>
			<input type="hidden"  id="target_folder" />
			<input type="hidden"  id="moved_srcID" />
			<input type="hidden"  id="opration_type" />
			<button type="button" id="move_confirm" class="am-btn am-btn-primary" style="width:50%;float:left">确定</button>
			<button type="button" id="move_cancel" class="am-btn am-btn-default" style="width:50%" onclick="jQuery('.box').hide()"> 取消</button>
		</div>
	</div>
	
	
	
	<!-- 主体部分 -->
	<script src="assets/js/theme.js"></script>
	<div class="am-g tpl-g" style="height: 100%;">
		<!-- 头部 -->
		<header id="theHead">
			<!-- logo -->
			<div class="am-fl tpl-header-logo">
				<a href="javascript:;" style="font-style: italic; size: a1;">NJU
					NetDisk</a>
			</div>
			<!-- 右侧内容 -->
			<div class="tpl-header-fluid">
				<!-- 侧边切换 -->

				<!-- 搜索 -->
				<div class="am-fl tpl-header-search">
					<form class="tpl-header-search-form" action="javascript:;">
						<button class="tpl-header-search-btn am-icon-search" ></button>
						<input class="tpl-header-search-box" type="text"
							placeholder="找资源...">
					</form>
				</div>
				<!-- 其它功能-->
				<div class="am-fr tpl-header-navbar" id="headdiv">
					<ul >
						 <li >
							<a style="height: 50%;vertical-align: middle ;"  >
								上传进度：
							</a>						
						</li>
						<li id="processbar">
							<a style="padding:0" >
								<div class="progress" style="width: 100px;height:10px;background-color:#f5f5f5">
									<div id="progressactive"
										class="progress-bar progress-bar-striped active" role="progressbar"
										aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"
										style="width: 0%;height:10px;background-color:#337ab7">
									</div>
								
								</div>
								
							</a>						
						</li>
						<!-- 欢迎语 -->
						
						<li class="am-dropdown" data-am-dropdown id="notice_bell"><a
							href="javascript:;" class="am-dropdown-toggle"
							data-am-dropdown-toggle> <i class="am-icon-bell"></i> 
							
								<c:if test="${unread!=0}" >
									<span class="am-badge am-badge-warning am-round item-feed-badge">${unread}
									</span>	
								</c:if> 
						</a> <!-- 弹出列表 -->
							<ul class="am-dropdown-content tpl-dropdown-content">
								<c:forEach items="${requestScope.three_notice}" var="n">
									<li class="tpl-dropdown-menu-notifications">
										<a href="javascript:;" class="tpl-dropdown-menu-notifications-item am-cf">
											<div class="tpl-dropdown-menu-notifications-title">
												<c:if test="${n.classification==1}" >
													<i class="am-icon-folder-o"></i> 
													<span>${n.giver}给你分享了新的资源</span>
												</c:if> 
												<c:if test="${n.classification==2}" >
													<i class="am-icon-line-chart"></i>
													<span>有人下载了你的资源</span>
												</c:if> 
												<c:if test="${n.classification==3}" >
													<i class="am-icon-star"></i>
													<span>新的评论</span>
												</c:if> 
												<c:if test="${n.classification==4}" >
													<i class="icon iconfont"></i>
													<span>有人给你点了赞</span>
												</c:if> 
												
											</div>
											
										</a>
									</li>
								</c:forEach>
								<li class="tpl-dropdown-menu-notifications" id="enter_notice">
									<a href="loadNotice?type=0&page=1" target="myFrame" class="tpl-dropdown-menu-notifications-item am-cf"> 
										<i class="am-icon-bell"></i> 
										进入消息页面…
									</a>
								</li>
							</ul>
							</li>

						<!-- 新提示 -->


						<!-- 退出 -->
						<li class="am-text-sm" id="testmodal">
							<a href="login.jsp">
							<span class="am-icon-sign-out"></span> 退出当前用户
							</a>
						</li>
					</ul>
				</div>
			</div>

		</header>

		<!-- 侧边导航栏 -->
		<div class="left-sidebar" style="height: 100%;">
			<!-- 用户信息 -->
			<div class="tpl-sidebar-user-panel">
				<div class="tpl-user-panel-slide-toggleable">
					<div>
						<div class="tpl-user-panel-profile-picture am-form-group am-form-file" style="float:left;">
							
								<img id="head" src="<%=request.getAttribute("picture_url") %>" alt="">
								<form id="uploadForm" >
									<input type="file"  id="file" name="file"  class="invisiable_upload"   onchange ="UpladFile()">
								</form>
							
						
						</div>
						<div style="margin-left:102px;height:92px;">
							<h5 style="padding-top:20px;"><%out.println(request.getAttribute("lv")) ;%></h5>
							<a href="changepwdpage">[更换密码]</a>
						</div>
					</div>
					<span class="user-panel-logged-in-text"> <i
						class="am-icon-circle-o am-text-success tpl-user-panel-status-icon"></i>
							<%out.println(request.getAttribute("name")) ;%>
					</span>

				</div>
			</div>

			<!-- 菜单 -->
			<ul class="sidebar-nav">

				<li class="sidebar-nav-link"><a href="loadSourceList"
					target="myFrame"> <i class="am-icon-home sidebar-nav-link-logo"></i>
						全部
				</a></li>
				<li class="sidebar-nav-link"><a href="loadByType?type=file"
					target="myFrame"> <i class="am-icon-file sidebar-nav-link-logo"></i>
						文档
				</a></li>
				<li class="sidebar-nav-link"><a href="loadByType?type=video" target="myFrame"> <i
						class="am-icon-file-video-o sidebar-nav-link-logo"></i> 视频
				</a></li>
				<li class="sidebar-nav-link"><a href="loadByType?type=picture" target="myFrame"> <i
						class="am-icon-file-picture-o sidebar-nav-link-logo"></i> 图片

				</a></li>
				<li class="sidebar-nav-link"><a href="loadByType?type=audio" target="myFrame"> <i
						class="am-icon-music sidebar-nav-link-logo"></i> 音频

				</a></li>
				<li class="sidebar-nav-link"><a href="loadByType?type=other" target="myFrame"> <i
						class="am-icon-file-zip-o sidebar-nav-link-logo"></i> 其他

				</a></li>
				<li class="sidebar-nav-heading"><span
					class="sidebar-nav-heading-info"> </span></li>

				<li class="sidebar-nav-link" onclick="read()"><a href="loadNotice?type=0&page=1"
					target="myFrame"> <i
						class="am-icon-clone sidebar-nav-link-logo"></i> 消息中心
						<!-- 这里可以显示有多少个新的消息 -->
				</a></li>
				<li class="sidebar-nav-link"><a href="loadTrash"
					target="myFrame"> <i
						class="am-icon-trash sidebar-nav-link-logo"></i> 回收站
				</a></li>


				<div style="text-align: center;">
					<div class="am-progress-title" style="text-align: center;" id="space_value">
						<%=(102400-(int)request.getAttribute("space"))/1024%>M / 100M</div>
					<div class="am-progress" style="background-color: #E5E5E5">
						<div class="am-progress-bar" id="space_bar" style="width:<%=(102400-(int)request.getAttribute("space"))/1024%>%"></div>
					</div>
				</div>


			</ul>
		</div>


		<div class="tpl-content-wrapper" id="dynamicDiv" style=" height:91.8%;">
			<iframe id="myFrame" name="myFrame"
				style="width: 100%; height: 100%;" src="loadSourceList"></iframe>
		</div>

		
		<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt" style="background-color: rgba(0, 0, 0, .6);">
				  <div class="am-modal-dialog">
				    <div class="am-modal-hd">重命名</div>
				    <div class="am-modal-bd">
				    
				      <input type="text" class="am-modal-prompt-input">
				      <input type="hidden"  id="srcID" />
				    </div>
				    <div class="am-modal-footer">
				    	<span class="am-modal-btn" data-am-modal-confirm>确认</span>
				      <span class="am-modal-btn" data-am-modal-cancel>取消</span>
				    </div>
				  </div>
		</div>
		
		
		<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm" style="background-color: rgba(0, 0, 0, .6);">
		  <div class="am-modal-dialog">
		    <div class="am-modal-hd">分享给你的好友</div>
		    <div class="am-modal-bd">
		      	<input type="text" class="am-modal-prompt-input" placeholder="对方的用户名">
				<input type="hidden"  id="srcID_share" />
		    </div>
		    <div class="am-modal-footer">
		      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
		      <span class="am-modal-btn" data-am-modal-cancel>取消</span>
		    </div>
		  </div>
		</div>
		
		<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm-share" style="background-color: rgba(0, 0, 0, .6);">
		  <div class="am-modal-dialog">
		    <div class="am-modal-hd">您确定要分享这条资源吗？</div>
		    <div class="am-modal-bd">
		      	您确定要分享这条资源吗？
		      	<input type="hidden"  id="srcID_public_share" />
		    </div>
		    <div class="am-modal-footer">
		   		<span class="am-modal-btn" data-am-modal-confirm>确定</span>
		     	<span class="am-modal-btn" data-am-modal-cancel>取消</span>
		    </div>
		  </div>
		</div>

		<script src="assets/js/amazeui.min.js"></script>
		<script src="assets/js/amazeui.datatables.min.js"></script>
		<script src="assets/js/dataTables.responsive.min.js"></script>
		<script src="assets/js/app.js"></script>
	</div>
	
	
	</body>

</html>
