<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
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
<script src="assets/js/echarts.min.js"></script>
<link rel="stylesheet" href="assets/css/amazeui.min.css" />
<link rel="stylesheet" href="assets/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="assets/css/app.css">
<link rel="stylesheet" href="assets/css/app2.css">
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
			$(document).ready(function() {
				$("#treeview").treeview({

				});
			});
			
			
			

			 $(function() {
				  $('.am-btn-danger').on('click', function(e) {
				
					
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
					        url: "batchRealDelete",
					        data:{resources:resources}, 
					        dataType:"json",
					        traditional:true,
					     
					        success: function(res){
					        
					            window.location.href='<%=request.getContextPath()%>/loadTrash';
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
					        }
					    });					  
				  });
				  
				  
				
				  $('.am-btn-success').on('click', function(e) {
						
						
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
						        url: "batchUndo",
						        data:{resources:resources}, 
						        dataType:"json",
						        traditional:true,
						        success: function(res){
						           
						            window.location.href='<%=request.getContextPath()%>/loadTrash';
						        }
						    });					  
					  });
				  
			});
		</script>
<script>
			function setHeight(){
				
				var ele=document.getElementById("dynamicDiv");

				ele.style.height=document.body.offsetHeight-document.getElementById("theHead").offsetHeight-1+"px";
				
			}
		
			
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
				}
				else{
					for(var i=0;i<list.length;i++){
						list[i].checked=false;			
					}
				}
			}

		</script>
<script src="assets/js/myjs.js"></script>
</head>

<body data-type="widgets" style="height: 100%;" onload="setHeight()">
	<script src="assets/js/theme.js"></script>




	<div class="tpl-content-wrapper" id="dynamicDiv"
		style="height: 100%; margin-left: 0;">


		<div class="am-u-sm-12 am-u-md-12 am-u-lg-12"
			style="padding: 0 0 0 1px; height: 100%;">
			<div class="widget am-cf" style="height: 100%; margin-bottom: 0;">
				<div class="am-u-sm-12 am-u-md-6 am-u-lg-6">
					<div class="am-form-group" style="margin-top: 30px;">
						<div class="am-btn-toolbar">
							<div class="am-btn-group am-btn-group-xs">
								<button type="button"
									class="am-btn am-btn-default am-btn-success"
									style="margin: 0 10px;">
									<span class="am-icon-share"></span> 恢复
								</button>
								<button type="button"
									class="am-btn am-btn-default am-btn-danger"
									style="margin: 0 10px;">
									<span class="am-icon-trash-o"></span> 删除
								</button>

							</div>
						</div>
					</div>
				</div>

				

				<div class="am-u-sm-12" style="height: 89%; overflow-y: scroll;">
					<table width="100%"
						class="am-table am-table-compact am-table-striped  "
						id="example-r">
						<thead>
							<tr>

								<th style="width: 40%;"><input type="checkbox"
									style="zoom: 150%; vertical-align: bottom;"
									onclick="checkAll()" /> &nbsp; &nbsp; 文件名</th>
								<th style="width: 10%;">大小</th>
								<th style="width: 20%;">操作</th>
								<th style="width: 15%;">删除时间</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${requestScope.Trash_list}" var="t">

								<tr id="${t.srcID}">
									<td>
										<label> <input class="candidateCheckbos"
												type="checkbox"
												style="zoom: 150%; vertical-align: middle; padding-bottom: 0px;" />
												&nbsp; &nbsp;
										</label> 
										<c:if test="${t.type=='picture'}">
											<i class="am-icon-file-picture-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #BE2924;"></i>
										</c:if> 
										<c:if test="${t.type=='audio'}">
											<i class="am-icon-music sidebar-nav-link-logo"
												style="vertical-align: middle; color: #0084C7;"></i>
										</c:if> 
										<c:if test="${t.type=='video'}">
											<i class="am-icon-video-camera sidebar-nav-link-logo"
												style="vertical-align: middle; color: #0075B0;"></i>
										</c:if> 
										<c:if test="${t.type=='archive'}">
											<i class="am-icon-file-zip-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #8E44AD;"></i>
										</c:if> 
										<c:if test="${t.type=='folder'}">
											<i class="am-icon-folder sidebar-nav-link-logo"
												style="vertical-align: middle; color: #FFC028;"></i>
										</c:if> 
										<c:if test="${t.type=='folders'}">
											<i class="am-icon-folder sidebar-nav-link-logo"
												style="vertical-align: middle; color: #FFC028;"></i>
										</c:if> 
										<c:if test="${t.type=='word'}">
											<i class="am-icon-file-word-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #009CDA;"></i>
										</c:if> 
										<c:if test="${t.type=='excel'}">
											<i class="am-icon-file-excel-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #BE2924;"></i>
										</c:if> 
										<c:if test="${t.type=='pdf'}">
											<i class="am-icon-file-pdf-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #BE2924;"></i>
										</c:if> 
										<c:if test="${t.type=='other'}">
											<i class="am-icon-file-zip-o sidebar-nav-link-logo"
												style="vertical-align: middle; color: #8E44AD;"></i>
										</c:if> 
										<font style="vertical-align: middle;"> 
										
												${t.name}
											
										</font>
									</td>
									<td style="vertical-align: middle;">${t.size}</td>
									<td>
										<div class="tpl-table-black-operation">
											<a href="undo?srcID=${t.srcID}"> <i class="am-icon-repeat">&nbsp;恢复</i>
											</a> <a href="realDelete?srcID=${t.srcID}" class="tpl-table-black-operation-del">
												<i class="am-icon-trash"></i> 彻底删除
											</a>
										</div>
									</td>
									<td style="vertical-align: middle;">
										<fmt:formatDate	type="both" value="${t.edit_time}" />
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
