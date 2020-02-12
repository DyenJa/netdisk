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
		<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
		<meta name="apple-mobile-web-app-title" content="Amaze UI" />
		<script src="assets/js/echarts.min.js"></script>
		<link rel="stylesheet" href="assets/css/amazeui.min.css" />
		<link rel="stylesheet" href="assets/css/amazeui.datatables.min.css" />
		<link rel="stylesheet" href="assets/css/app.css">
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
				filter: alpha(opacity=80);
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



		<link rel="stylesheet" href="assets/css/jquery.treeview.css" type="text/css" />

		<link rel="stylesheet" href="assets/css/screen.css" type="text/css" />


		<script src="assets/js/jquery-3.2.1.js"></script>
		<script src="assets/js/jquery.cookie.js"></script>
		<script src="assets/js/jquery.treeview.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#treeview").treeview({

				});
			});
			function getUrlParam(name) {
			    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
			    var r = window.location.search.substr(1).match(reg);  // 匹配目标参数
			    if (r != null) return unescape(r[2]); return null; // 返回参数值
			}
			$(document).on('click', '.candidateCheckbos', function(e) {
				// 		        var n=$(this).prev().val();
				// 		        var num=parseInt(n)+1;
				// 		        if(num==0){ return;}
				// 		        $(this).prev().val(num);
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

				var ele = document.getElementById("dynamicDiv");
				var height = ele.style.height;
				fullheight = document.body.offsetHeight - document.getElementById("theHead").offsetHeight - 1;

				if (height < fullheight)
					ele.style.height = fullheight + "px";

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

			function batchUpload() {
				var list = $(".candidateCheckbos");
				var checkedlist = new Array();
				var index = 0;
				for (var i = 0; i < list.length; i++) {
					if (list[i].checked == true) {
						checkedlist[index] = list[i];
						index++;

					}
				}
				//便利上传checkedlist中的每一个文件
			}
			  function switchType(sobj) {
					     var docurl =sobj.options[sobj.selectedIndex].value;
					     if (docurl != "") {
							window.location.href="<%=request.getContextPath()%>/loadNotice?type="+docurl+"&page=1";
					}
				}
			
			function save(e){
				 $('.box', parent.document).show();
				 $('#moved_srcID', parent.document).val(e);	
				 $('#opration_type', parent.document).val("copy");	
					$.ajax({
						url:"getRootDirectory",
						data:{},
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
				
			}
			function deleteNotice(e){
				 $.ajax({
						url:"deleteNotice",
						type:"post",
						data:{nid:e},
						dataType:"json",//这个datatype指的是返回的data
						success:function(data){
							if(data.result==true){
							
								window.location.href="<%=request.getContextPath()%>/loadNotice?type="+getUrlParam("type")+"&page="+getUrlParam("page");
							}
							else{
								alert("失败");
						
							}
							
						}
					});
			}
		</script>
		<script src="assets/js/myjs.js"></script>
	</head>

	<body data-type="widgets" >
		<script src="assets/js/theme.js"></script>

		<!-- 头部 -->

		<div class="tpl-content-wrapper" style="height: 100%;margin-left: 0;">
			<div class="row-content am-cf" style="padding: 0;height: 100%;">

				<div class="am-u-sm-12 am-u-md-12 am-u-lg-12" style="padding: 0 0 0 1px; height: 100%;">
					<div class="widget am-cf" style="height: 100%;margin-bottom: 0; ">
						<div class="widget-head am-cf" style="height: 10%;">
							<div class="widget-title  am-cf" style="float: left;">消息列表</div>

							<div class="am-u-sm-12 am-u-md-6 am-u-lg-3" style="float: right;">
								<div class="am-form-group tpl-table-list-select">
									<select data-am-selected="{btnSize: 'sm'}" onchange=switchType(this)>
									<c:if test="${type=='0'}">
										<option selected=true>所有类别</option>
										<option value="1">我分享的</option>
										<option value="2">他人分享</option>
										<option value="3">共享资源</option>
									</c:if>
									<c:if test="${type=='1'}">
										<option value="0">所有类别</option>
										<option   selected=true>我分享的</option>
										<option value="2">他人分享</option>
										<option value="3">共享资源</option>
									</c:if>
									<c:if test="${type=='2'}">
										<option value="0" >所有类别</option>
										<option value="1">我分享的</option>
										<option selected=true>他人分享</option>
										<option value="3">共享资源</option>
									</c:if>
									<c:if test="${type=='3'}">
										<option value="0" >所有类别</option>
										<option value="1">我分享的</option>
										<option value="2">他人分享</option>
										<option selected=true>共享资源</option>
									</c:if>
									</select>
								</div>
							</div>
						</div>
						<div class="widget-body  am-fr" style="padding: 0 0 0 0 !important;position: relative;height: 90%;">
							<div class="am-u-sm-12">
								<ul class="tpl-task-list tpl-task-remind">
								
										<c:forEach items="${requestScope.noticesVo}" var="n">
										<li>
											<div class="cosB" style="width:20%;">
											
												<fmt:formatDate value="${n.time}" pattern='yyyy-MM-dd hh:mm:ss' />
											</div>
												<c:if test="${n.classification=='0'}">
													<div class="cosA">
														<span class="cosIco label-warning" style="background-color: #F37B1D !important;">
															<i class="am-icon-plus"></i>
														</span>
														<span> 你分享了${n.srcName}给${n.communicater}</span>
													</div>
												</c:if>
												<c:if test="${n.classification=='2'}">
													<div class="cosA">
														<span class="cosIco">
															<i class="am-icon-bell-o"></i>
														</span>
														<span> 你分享的${n.srcName}很有用！经验值+1</span>
													</div>
												</c:if>
												<c:if test="${n.classification=='3'}">
													<div class="cosA">
														<span class="cosIco">
															<i class="am-icon-comment"></i>
														</span>
														<span> ${n.srcName} 有新的评论</span>
													</div>
												</c:if>
												<c:if test="${n.classification=='4'}">
													<div class="cosA">
														<span class="cosIco">
															<i class="am-icon-thumbs-up"></i>
														</span>
														<span> 有人给你的${n.srcName}点了赞</span>
													</div>
												</c:if>
												<div class="cosA">
													<c:if test="${n.classification=='1'}">
														
														<span class="cosIco" style="background-color: #00A23F !important;">
															<i class="am-icon-bullhorn"></i>
														</span>
			
														<span> ${n.communicater} 向你分享了【${n.srcName}】，大小：${n.size}。
															<span class="tpl-label-info" onclick="save('${n.srcID}')">
																保存
																<i class="am-icon-share"></i>
															</span>
															&nbsp;&nbsp;
															<span class="tpl-label-info" 
															onclick="deleteNotice('${n.nid}')"
															style="background-color: #EA1328;"  >
																删除
																<i class="am-icon-trash-o"></i>
															</span>
														</span>
													
													</c:if>
												</div>
										</li>							
									</c:forEach>
								</ul>
							</div>
							<div class="am-u-lg-12 am-cf" style="text-align: center;position: absolute;bottom: 0;">

								<div class="am-fr" style="float: left;">
									<ul class="am-pagination tpl-pagination">
									 <c:choose>
								        <c:when test="${count <=10}">
								            <c:set var="begin" value="1"/>
								            <c:set var="end" value="${count}"/>
								        </c:when>
								        <c:otherwise>
								            <c:set var="begin" value="${current_page- 5}"/>
								            <c:set var="end" value="${current_page + 4}"/>
								            <%--如果begin减1后为0,设置起始页为1,最大页为6--%>
								            <c:if test="${begin - 5 <= 0}">
								                <c:set var="begin" value="1"/>
								                <c:set var="end" value="10"/>
								            </c:if>
								            <%--如果end超过最大页,设置起始页=最大页-5--%>
								            <c:if test="${end > count}">
								                <c:set var="begin" value="${count - 9}"/>
								                <c:set var="end" value="${count}"/>
								            </c:if>
								        </c:otherwise>
								    </c:choose>
								    	 <c:choose>
									            <c:when test="${1 == current_page}">
									                <li class="am-disabled"><a href="#">首页</a></li>
													<li class="am-disabled"><a href="#">«上一页</a></li>
									            </c:when>
									            <c:otherwise>
									                <li><a href="<%=request.getContextPath()%>/loadNotice?type=${type}&page=1">首页</a></li>
									                <li><a href="<%=request.getContextPath()%>/loadNotice?type=${type}&page=${current_page-1}">«上一页</a></li>
									            </c:otherwise>
									        </c:choose>
									<c:forEach var="i" begin="${begin}" end="${end}">
									     
									        <c:choose>
									            <c:when test="${i == current_page}">
									                <li class="am-active"><a href="#">${i}</a></li>
									            </c:when>
									            <c:otherwise>
									                <li><a href="<%=request.getContextPath()%>/loadNotice?type=${type}&page=${i}">${i}</a></li>
									            </c:otherwise>
									        </c:choose>
									      
									</c:forEach>
									  <c:choose>
									             <c:when test="${count == current_page}">
									                <li class="am-disabled"><a href="#">下一页»</a></li>
													<li class="am-disabled"><a href="#">尾页</a></li>
									            </c:when>
									            <c:otherwise>
									                <li><a href="<%=request.getContextPath()%>/loadNotice?type=${type}&page=${current_page+1}">下一页»</a></li>
									                <li><a href="<%=request.getContextPath()%>/loadNotice?type=${type}&page=${count}">尾页</a></li>
									            </c:otherwise>
									        </c:choose>
									</ul>
								</div>

							</div>
						</div>
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
