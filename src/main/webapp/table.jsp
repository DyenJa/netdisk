<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script src="assets/js/echarts.min.js"></script>
<link rel="stylesheet" href="assets/css/amazeui.min.css" />
<link rel="stylesheet" href="assets/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="assets/css/app.css">
<link rel="stylesheet" href="assets/css/css_for_table.css">

<style>
.white_content {
	display: none;
	position: absolute;
	top: 25%;
	left: 25%;
	width: 50%;
	padding: 6px 16px;
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



<link rel="stylesheet" href="assets/css/jquery.treeview.css"
	type="text/css" />

<link rel="stylesheet" href="assets/css/screen.css" type="text/css" />


<script src="assets/js/jquery-3.2.1.js"></script>
<script src="assets/js/jquery.cookie.js"></script>
<script src="assets/js/jquery.treeview.js" type="text/javascript"></script>
<script type="text/javascript">
		 $(function() {
			  $('.doc-prompt-toggle').on('click', function(e) {
				  document.getElementById("test_close").click();
				 var srcID= $(this).parents(".resource_list").attr("id")
			
				 $('#srcID', parent.document).val(srcID);
				 $('#my-prompt',window.parent.document).modal({
					  onConfirm: function(e) {
					
			    	  newName=e.data;
			    
			    	  var srcID= $('#srcID', parent.document).val();
			    	
					  $.ajax({
							url:"reName",
							type:"post",
							data:{srcID:srcID,newName:newName},
							dataType:"json",//这个datatype指的是返回的data
							success:function(data){
								if(data.result==true){
								
									if(getUrlParam('type')!=null){
										window.location.href="<%=request.getContextPath()%>/loadByType?type="+getUrlParam("type");
									}	
									else if(getUrlParam('current_position')!=null){
										window.location.href="<%=request.getContextPath()%>/loadSourceList?current_position="+getUrlParam("current_position");
									}
									else{
										window.location.href="<%=request.getContextPath()%>/loadSourceList";	
									}
										
									 $('.am-modal-prompt-input', parent.document).val("");
								}
								else{
									$('.am-modal-prompt-input', parent.document).val("");
								}
							}
						});
			      },
			      onCancel: function(e) {
			    	  $('.am-modal-prompt-input', parent.document).val("");
			      }
			    });
				 
			  });
			  
			  
			  $('.move').on('click', function(e) {
				  $('.box', parent.document).show();
				  document.getElementById("test_close").click();
				 var parentid= getUrlParam("current_position");
				 var srcID=$(this).parents(".resource_list").attr("id");		//移动的资源的ID
				 $('#moved_srcID', parent.document).val(srcID);	
					$.ajax({
						url:"getRootDirectory",
						data:{parentid:"none"},
						type:"post",				
						dataType:"json",
						success:function(data){
							console.log(data);
							
							var contents=window.parent.document.getElementById("myTree");
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
			  });
			  
			  
			  
			  $('.share').on('click', function(e) {
				 var srcID= $(this).parents(".resource_list").attr("id")
			
				 $('#srcID_share', parent.document).val(srcID);
				 $('#my-confirm',window.parent.document).modal({
				  onConfirm: function(e) {
			    	  receiver=e.data;										//拿到了被分享者的ID
			    	  var resources=new Array();
			    	  resources[0]=$('#srcID_share', parent.document).val();	//拿到了被分享的资源srcID
			    	  $.ajax({												//发送Ajax
							url:"batchShare",
							type:"post",
							data:{resources:resources,receiver:receiver},
							traditional:true,
							dataType:"json",//这个datatype指的是返回的data
							success:function(data){
								if(data.result==true){
									alert("分享成功");
									
										
									 $('.am-modal-prompt-input', parent.document).val("");
								}
								else{
									alert("不存在此用户！");
									$('.am-modal-prompt-input', parent.document).val("");
								}
								$('.am-modal-prompt-input', parent.document).val("");
							}
						});	
			    	  
			      },
			      onCancel: function(e) {
			    	  $('.am-modal-prompt-input', parent.document).val("");
			      }
			    });
				 
			  });
			  		  
			  $('#batchShare').on('click', function(e) {
					 $('#my-confirm',window.parent.document).modal({
					  onConfirm: function(e) {
				    	  receiver=e.data;										//拿到了被分享者的ID
				    	  var numtr=$("tbody tr").length;
						  var resources=new Array();
						  var count=0;
						  for(var i=0;i<numtr;i++){
							  if($("tbody tr").eq(i).find(".candidateCheckbos").is(':checked') ){
								  resources[count]=$("tbody tr").eq(i).attr("id");
								  count=count+1;
								  if($("tbody tr").eq(i).children().next().html().indexOf("--")!=-1){
									  alert("文件夹不可分享");
									  return false;
								  }
							
							  }
						  }
					
						  $.ajax({
						        type: "post",
						        url: "batchShare",
						        data:{resources:resources,receiver:receiver}, 
						        dataType:"json",
						        traditional:true,
						        success: function(res){
						        	if(res.result==false)
						        		 alert("不存在此用户！");
						        	else
						        		 alert("成功！");
						            $('.am-modal-prompt-input', parent.document).val("");
						        }
						    });
				    	  
				      },
				      onCancel: function(e) {
				    	  $('.am-modal-prompt-input', parent.document).val("");
				      }
				    });
					 
				  });
			  
			  $('.public_share').on('click', function(e) {
				
				  	var srcID= $(this).parents(".resource_list").attr("id")
					 $('#srcID_public_share', parent.document).val(srcID);
					 $('#my-confirm-share',window.parent.document).modal({
					  onConfirm: function(e) {
						  var srcID=$('#srcID_public_share', parent.document).val();
						  $.ajax({
						        type: "post",
						        url: "public_share",
						        data:{srcID:srcID}, 
						        dataType:"json",
						        traditional:true,
						        success: function(res){
						            alert("感谢您的贡献");
						        }
						    });
				      },
				      onCancel: function(e) { 
				      }
				    }); 
				  });
			 
			  
		});
		 
		 
		
		 $(function() {
			  $('#batchDelete').on('click', function(e) {
				  var numtr=$("tbody tr").length;
				  var resources=new Array();
				  var count=0;
				  for(var i=0;i<numtr;i++){
					  if($("tbody tr").eq(i).find(".candidateCheckbos").is(':checked') ){
						  resources[count]=$("tbody tr").eq(i).attr("id");
						  count=count+1;
					  }
				  }
				  
				  
				  $.ajax({
				        type: "post",
				        url: "batchDelete",
				        data:{resources:resources}, 
				        dataType:"json",
				        traditional:true,
				        success: function(res){
				           
				            var current_position=getUrlParam("current_position");
				            var type=getUrlParam("type");
				            if(type!=null)
				            	window.location.href='<%=request.getContextPath()%>/loadSourceList?type='+type;
				            if(current_position!=null)
				           		window.location.href='<%=request.getContextPath()%>/loadSourceList?current_position='+current_position;
				           	else
				           		window.location.href='<%=request.getContextPath()%>/loadSourceList';
				        }
				    });
			  });
			  
			  $('#batchDownload').on('click', function(e) {
			
				  var numtr=$("tbody tr").length;
				  var resources=new Array();
				  var count=0;
				  for(var i=0;i<numtr;i++){
					  if($("tbody tr").eq(i).find(".candidateCheckbos").is(':checked') ){
						  resources[count]=$("tbody tr").eq(i).attr("id");
						  var url="down?srcID="+$("tbody tr").eq(i).attr("id");
						  $("tbody tr").eq(i).find(".am-icon-download").click();
						  count=count+1;
					  }
				  }
				 
			  });
			
			  
		});
		 
		 
			$(document).ready(function() {
				$("#treeview").treeview({

				});
			});
			
			$(document).on('click', '.candidateCheckbos', function(e) {
				if($(e.target).is(':checked')){
					$('#upload').css('display','none');
					$('#createFolder').css('display','none');
					$('#batchDownload').css('display','block');
					$('#batchShare').css('display','block');
					$('#batchDelete').css('display','block');
				
				}
				else{
					var list=$(".candidateCheckbos");
					var Unchecked=0;
					for(var i=0;i<list.length;i++){
								
						if(list[i].checked==false)
							Unchecked++;
								
					}
					if(Unchecked==list.length){
					
						$('#upload').css('display','block');
						$('#createFolder').css('display','block');
						$('#batchDownload').css('display','none');
						$('#batchShare').css('display','none');
						$('#batchDelete').css('display','none');
						
					}
				}
		  });
		
		</script>
		<script type="text/javascript">
		function getUrlParam(name) {
		    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
		    var r = window.location.search.substr(1).match(reg);  // 匹配目标参数
		    if (r != null) return unescape(r[2]); return null; // 返回参数值
		}
	function UpladFile() {
 		var fileObj = document.getElementById("file").files[0]; // js 获取文件对象
 	
	/* 	alert(document.getElementById("file").files[1].name);
		alert(document.getElementById("file").files[2].name);
		alert(document.getElementById("file").files[3].name);  */
		var current_position=getUrlParam("current_position");
	
		var FileController ;
		if(current_position==null)
			FileController = "upload.do"; // 接收上传文件的后台地址 上传到根目录
		else
			FileController = "upload.do?current_position="+current_position; 	//上传到用户自己创建的文件夹
			// FormData 对象
		var form = new FormData($("#uploadForm")[0]);//创建一个form对象
		// XMLHttpRequest 对象
		var xhr = new XMLHttpRequest();//创建XMLHttpRequest对象
		xhr.open("post", FileController, true);//打开连接，(访问类型，地址，是否异步)
		xhr.onload = function() {//请求完成后执行  里面可用
			if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
				alert(xhr.responseText);//后台返回的数据
			} else {
				if(xhr.responseText.indexOf("space_not_enough")!=-1){
					alert("空间不足！上传任务失败")
				}
				else{
					current_position= current_position==null? "none":current_position;
					window.location.href='<%=request.getContextPath()%>/loadSourceList?current_position='+current_position;
					
						  $.ajax({
						        type: "get",
						        url: "refreshSpace",
						        data:{}, 
						        dataType:"json",
						        success: function(res){
						        
						        	 $('#space_bar', parent.document).width((102400-res.space)/1024+"%");
						        	 
						        	 $('#space_value', parent.document).html(((102400-res.space)/1024).toFixed(2)+"M / 100M");
						        }
						    });		
				//0	UNSENT (未打开),1	OPENED  (未发送),2 HEADERS_RECEIVED (已获取响应头),3	LOADING (正在下载响应体),4	DONE (请求完成)
				}
			}
		};
 
		xhr.upload.addEventListener("progress", progressFunction, false);//添加上传监听器方法
		xhr.send(form);//发送请求
	}
 
	function progressFunction(evt) {
		
		var progressBar =window.parent.document.getElementById("progressactive");//获取进度条对象
		if (evt.lengthComputable) {
			var max = evt.total;//文件总大小
			var loaded = evt.loaded;//已上传文件大小
			console.log(max);
			progressBar.style.width = Math.round(loaded / max * 100) + "%";
		}
	}
</script>
<script>
			
			function checkAll(){
				var list=$(".candidateCheckbos");
				var checked=0;
				for(var i=0;i<list.length;i++){
			
					if(list[i].checked==true)
						checked++;
			
				}
				if(checked!=list.length){
					for(var i=0;i<list.length;i++){
						list[i].checked=true;			
					}
					$('#upload').css('display','none');
					$('#createFolder').css('display','none');
					$('#batchDownload').css('display','block');
					$('#batchShare').css('display','block');
					$('#batchDelete').css('display','block');
				}
				else{
					for(var i=0;i<list.length;i++){
						list[i].checked=false;			
					}
					$('#upload').css('display','block');
					$('#createFolder').css('display','block');
					$('#batchDownload').css('display','none');
					$('#batchShare').css('display','none');
					$('#batchDelete').css('display','none');
					$('checkAll').checked=false;
				}
			}
			
			function batchUpload(){
				var list=$(".candidateCheckbos");
				var checkedlist=new Array();
				var index=0;
				for(var i=0;i<list.length;i++){
					if(list[i].checked==true){
						checkedlist[index]=list[i];
						index++;
						
					}
				}
				//便利上传checkedlist中的每一个文件
			}
			$(function() {
				$('#createFolder').on('click', function() {
							$('#create_time').html(formatTime (new Date()));
				 			$('#new_add_tr').css("display","contents")	;	 
				});
				
				
				$('#create_confirm').on('click', function() {
					 var folder_name=$('#new_name').val();
					 if(getUrlParam("current_position")==null) 
						window.location.href="<%=request.getContextPath()%>/createFolder?name="+folder_name;	
					 else
						window.location.href="<%=request.getContextPath()%>/createFolder?name="+folder_name+"&current_position="+getUrlParam('current_position');
	
					 
				});
				
				$('#create_cancel').on('click', function() {
					$('#new_name').val("新建文件夹");
					$('#new_add_tr').css("display","none")	;
				});
	  
			});
			function formatTime (date) {
	          var year = date.getFullYear()
	          var month = date.getMonth() + 1
	          var day = date.getDate()
	          var hour = date.getHours()
	          var minute = date.getMinutes()
	          var second = date.getSeconds() 
	          return [year, month, day].map(formatNumber).join('-') + ' ' + [hour, minute, second].map(formatNumber).join(':')
			}
			function formatNumber  ( n ) {
				  n = n.toString();
				  return n[1] ? n :  n;
			}
		</script>
<script src="assets/js/myjs.js"></script>
</head>


<body data-type="widgets" style="height: 100%;" >

				
	<script src="assets/js/theme.js"></script>
	<div class="tpl-content-wrapper" id="dynamicDiv"
		style="height: 100%; margin-left: 0;">


		<div class="am-u-sm-12 am-u-md-12 am-u-lg-12"
			style="padding: 0 0 0 1px; height: 100%;">
			<div class="widget am-cf" style="height: 100%; margin-bottom: 0;">
				<div class="am-u-sm-12 am-u-md-6 am-u-lg-6">
					<div class="am-form-group"  style="margin-top: 30px;margin-bottom: 0;">
						<div class="am-btn-toolbar">
						<form id="uploadForm" >
							<div class="am-btn-group am-btn-group-xs">
							
								<button id="upload" type="button" 
									class="am-btn am-btn-default am-btn-primary" 
									style="margin: 0 10px;" >
									<span class="am-icon-upload"></span>上传
									<input type="file" id="file" name="file" style="width:100%;height:100%" class="invisiable_upload" multiple  onchange ="UpladFile()"/> 
								</button>
						
								<button id="createFolder" type="button"
									class="am-btn am-btn-default am-btn-secondary"
									style="margin: 0 10px;">
									<span class="am-icon-plus"></span> 新建
								</button>
							
								<button id="batchDownload" type="button"
									class="am-btn am-btn-default am-btn-primary"
									style="margin: 0 10px; display: none;">
									<span class="am-icon-download"></span> 下载
								</button>
								<button id="batchShare" type="button"
									class="am-btn am-btn-default am-btn-success"
									style="margin: 0 10px; display: none;">
									<span class="am-icon-share"></span> 分享
								</button>
								<button id="batchDelete" type="button"
									class="am-btn am-btn-default am-btn-danger"
									style="margin: 0 10px; display: none;">
									<span class="am-icon-trash-o"></span> 删除
								</button>
								
							</div>
						
						</form>
						</div>
					</div>
					<ol class="am-breadcrumb" style="margin-top: 0;margin-bottom: 0;">
						<li><a href="loadSourceList">首页</a></li>
						<c:forEach items="${requestScope.folder_path}" var="f">
							<li><a href="loadSourceList?current_position=${f.srcID}">${f.name}</a></li>	
						</c:forEach>
						<li class="am-active">${current_name}</li>
					</ol>
				</div>

			

				<div class="am-u-sm-12" style="height: 85%; overflow-y: scroll;">
					<table width="100%"
						class="am-table am-table-compact am-table-striped  "
						id="example-r">
						<thead>
							<tr>
								<th style="width: 40%;">
									<input type="checkbox" style="zoom: 150%; vertical-align: bottom;" onclick="checkAll()" id="checkAll"/> &nbsp; &nbsp; 文件名
								</th>
								<th style="width: 10%;">大小</th>
								<th style="width: 20%;">操作</th>
								<th style="width: 15%;">修改时间</th>
							</tr>
						</thead>

						<tbody id="list">
								<tr style="display:none;" id="new_add_tr">
										<td>
											<label>
												<input  type="checkbox"  style="zoom:150%;vertical-align: middle; padding-bottom: 0px;" />
												&nbsp; &nbsp;
											</label>
											<i class="am-icon-folder sidebar-nav-link-logo" style="vertical-align: middle;color: #FFC028;"></i>
											<font style="vertical-align: middle;cursor: pointer;"><input value="新建文件夹" id="new_name" onfocus="this.select()" onmouseover="this.focus()"/></font>
											<span id="create_confirm"><i class="am-icon-check" style="color: cadetblue;cursor: pointer;"></i></span>
											<span id="create_cancel"><i class="am-icon-times" style="color: cadetblue;cursor: pointer;"></i></span>
										</td>
										<td style="vertical-align: middle;">--</td>
										<td>
											<div class="tpl-table-black-operation">
												<a href="javascript:;">
													<i class="am-icon-download"></i> 下载
												</a>
												<a href="javascript:;">
													<i class="am-icon-share-alt"></i> 分享
												</a>
												<a href="javascript:;" class="tpl-table-black-operation-del">
													<i class="am-icon-trash"></i> 删除
												</a>
											</div>
										</td>
										<td style="vertical-align: middle;" id="create_time"></td>
									</tr>
						
							<c:forEach items="${requestScope.resource_list}" var="r">

								<tr class="resource_list" id="${r.srcID}">
									<td>
										<label> <input class="candidateCheckbos"
											type="checkbox"
											style="zoom: 150%; vertical-align: middle; padding-bottom: 0px;" />
											&nbsp; &nbsp;
										</label> 
										<c:if test="${r.type=='picture'}" >
											<i class="am-icon-file-picture-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #BE2924;"></i>
										</c:if> 
										<c:if test="${r.type=='audio'}" >
											<i class="am-icon-music sidebar-nav-link-logo"
												style="vertical-align: middle; color: #0084C7;"></i>
										</c:if> 
										<c:if test="${r.type=='video'}" >
											<i class="am-icon-video-camera sidebar-nav-link-logo"
												style="vertical-align: middle; color: #0075B0;"></i>
										</c:if> 
										<c:if test="${r.type=='archive'}" >
											<i class="am-icon-file-zip-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #8E44AD;"></i>
										</c:if> 
										<c:if test="${r.type=='folder'}" >
											<i class="am-icon-folder sidebar-nav-link-logo"
												style="vertical-align: middle; color:#FFC028;"></i>
										</c:if> 
										<c:if test="${r.type=='folders'}" >
											<i class="am-icon-folder sidebar-nav-link-logo"
												style="vertical-align: middle; color:#FFC028;"></i>
										</c:if>
										<c:if test="${r.type=='word'}" >
											<i class="am-icon-file-word-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #009CDA;"></i>
										</c:if> 
										<c:if test="${r.type=='excel'}" >
											<i class="am-icon-file-excel-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: darkgreen;"></i>
										</c:if> 
										<c:if test="${r.type=='pdf'}" >
											<i class="am-icon-file-pdf-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #BE2924;"></i>
										</c:if> 
										<c:if test="${r.type=='other'}" >
											<i class="am-icon-question-circle-o sidebar-nav-link-logo" style="vertical-align: middle;"></i>
										</c:if> 
										
										<font style="vertical-align: middle;">
											<c:if test="${r.type=='folder'or r.type=='folders'}" >
												<a href="loadSourceList?current_position=${r.srcID}">${r.name}</a>
											</c:if> 
											
											<c:if test="${r.type!='folder' and r.type!='folders'}" >
												${r.name}
											</c:if> 
										</font>
										
									</td>
									<td style="vertical-align: middle;">
										${r.size}
									</td>
									<td>
										<div class="tpl-table-black-operation">
											<c:if test="${r.type=='folder'or r.type=='folders'}" >
												<a > 
													<i class="am-icon-download">下载</i>
												</a> 
												<a  style="color: #46A546;"> 
													<i class="am-icon-share-alt"></i> 分享
												</a>  
											</c:if> 
											<c:if test="${r.type!='folder' and r.type!='folders'}" >
												<a href="${r.srcurl}" download="${r.name}">
													<i class="am-icon-download">下载</i>
												</a>
												<a href="javascript:;" class="share"  style="color: #46A546;"> 
													<i class="am-icon-share-alt"></i> 分享
												</a>  
											</c:if> 
											
											
										
											<a href="delete?srcID=${r.srcID}" class="tpl-table-black-operation-del">
												<i class="am-icon-trash"></i> 删除
											</a>
											
											<li class="am-dropdown" data-am-dropdown id="test_close">
												<a href="javascript:;" class="am-dropdown-toggle" data-am-dropdown-toggle> 
													<img src="assets/img/more.png" style="width: 1.25rem; height: 1.25rem;">
												</a> 
												<ul class="am-dropdown-content tpl-dropdown-content"
													style="width: auto; min-width: 0;">
													<li class="tpl-dropdown-menu-notifications"
														style="width: 80px;cursor:pointer;"><a class="doc-prompt-toggle" > 重命名 </a></li>
													<li class="tpl-dropdown-menu-notifications"
														style="width: 80px;cursor:pointer;"  ><a class="move">
														 <span> 移动到 </span>
													</a></li>
													
													<c:if test="${r.type=='folder'or r.type=='folders'}" >
														<li class="tpl-dropdown-menu-notifications" style="width: 80px;">
															<a> <span>公开分享</span></a> 
														</li>
													</c:if> 
													<c:if test="${r.type!='folder' and r.type!='folders'}" >
														<li class="tpl-dropdown-menu-notifications" style="width: 80px;cursor:pointer;">
															<a class="public_share"> <span>公开分享</span></a>
														</li>
													</c:if> 
												
												</ul>
											</li>

										</div>
									</td>
									<td style="vertical-align: middle;">
										<fmt:formatDate type="both"  value="${r.edit_time}" /></p>
									</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	
	



	<script src="assets/js/amazeui.min.js"></script>
	<script src="assets/js/amazeui.datatables.min.js"></script>
	<script src="assets/js/dataTables.responsive.min.js"></script>
	<script src="assets/js/app.js"></script>

</body>

</html>
