<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
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
<script src="assets/js/myjs.js"></script>
<script >
	function switchType(sobj) {
		     var docurl =sobj.options[sobj.selectedIndex].value;
		     if (docurl != "") {
				window.location.href= "<%=request.getContextPath()%>/search?name=" + getUrlParam("name") + "&type=" + docurl + "&page=1";
				
		}
	}
	function getUrlParam(name) {
	    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
	    var r = window.location.search.substr(1).match(reg);  // 匹配目标参数
	    if (r != null) return unescape(r[2]); return null; // 返回参数值
	}
	function publicdownload(e){
		
		 $.ajax({
				url:"download/public",
				type:"post",
				data:{srcID:e},
				dataType:"json",//这个datatype指的是返回的data
				success:function(data){
				/* 	if(data.result==true){
						alert("成功增加积分");
					
					}
					else{
						alert("失败，已经下载过了");
					} */
					
				}
			});
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
		 $.ajax({
				url:"download/public",
				type:"post",
				data:{srcID:e},
				dataType:"json",//这个datatype指的是返回的data
				success:function(data){
				/* 	if(data.result==true){
						alert("成功增加积分"+e);
					
					}
					else{
						alert("失败，已经下载过"+e);
					}
					 */
				}
			});
	}

</script>

</head>



<body data-type="widgets" style="height: 100%;" >
	<script src="assets/js/theme.js"></script>
	<div class="tpl-content-wrapper" style=" margin-left: 0;">
		<div class="row-content am-cf" style="padding: 0; height: 100%;">

			<div class="am-u-sm-12 am-u-md-12 am-u-lg-12"
				style="padding: 0 0 0 1px; height: 100%;">
				<div class="widget am-cf" style="height: 100%; margin-bottom: 0;">
					<div class="widget-head am-cf" style="height: 10%;">
						<div class="widget-title  am-cf" style="float: left;">网络上的资源</div>

						<div class="am-u-sm-12 am-u-md-6 am-u-lg-3" style="float: right;">
							<div class="am-form-group tpl-table-list-select">
						
								<select data-am-selected="{btnSize: 'sm'}" onchange=switchType(this)>
									<c:if test="${type=='all'}">
										<option value="all"  selected=true>所有类别</option>	
										<option value="video">视频</option>
										<option value="audio" >音频</option>
										<option value="file" >文档</option>
										<option value="other" >其他资源</option>
									</c:if>
									<c:if test="${type=='video'}">
										<option value="all">所有类别</option>	
										<option value="video" selected=true>视频</option>
										<option value="audio" >音频</option>
										<option value="file" >文档</option>
										<option value="other" >其他资源</option>
									</c:if>
									<c:if test="${type=='audio'}">
										<option value="all">所有类别</option>	
										<option value="video">视频</option>
										<option value="audio" selected=true>音频</option>
										<option value="file" >文档</option>
										<option value="other" >其他资源</option>
									</c:if>
									<c:if test="${type=='file'}">
										<option value="all">所有类别</option>	
										<option value="video">视频</option>
										<option value="audio">音频</option>
										<option value="file" selected=true>文档</option>
										<option value="other" >其他资源</option>
									</c:if>
									<c:if test="${type=='other'}">
										<option value="all">所有类别</option>	
										<option value="video">视频</option>
										<option value="audio">音频</option>
										<option value="file">文档</option>
										<option value="other" selected=true>其他资源</option>
									</c:if>
									</select>
							</div>
						</div>
					</div>
					<div class="widget-body  am-fr" style="padding: 0 0 0 0 !important; position: relative; height: 90%;">
						<div class="am-u-sm-12" style="height: 92%; display: block; padding-left: 0; padding-right: 0;">
							<c:forEach items="${requestScope.search_result}" var="r">
								<div style="width: 24.5%; height: 25%; text-align: center; padding-top: 5px; display: inline-block;">
									<a href="srcInfo?srcID=${r.srcID}">
										<c:if test="${r.type=='picture'}" >
											<i class="am-icon-file-picture-o am-icon-lg" style=" color:  #0084C7;"></i>
										</c:if> 
										<c:if test="${r.type=='audio'}" >
											<i class="am-icon-music am-icon-lg" style=" color:  #0084C7;"></i>
										</c:if> 
										<c:if test="${r.type=='video'}" >
											<i class="am-icon-video-camera am-icon-lg" style=" color: royalblue;"></i>
										</c:if> 
										<c:if test="${r.type=='archive'}" >
											<i class="am-icon-file-zip-o am-icon-lg" style=" color:darkmagenta;"></i>
										</c:if> 
										<c:if test="${r.type=='word'}" >
											<i class="am-icon-file-word-o am-icon-lg" style=" color:  #009CDA;"></i>
										</c:if> 
										<c:if test="${r.type=='excel'}" >
											<i class="am-icon-file-excel-o am-icon-lg" style=" color: darkgreen;"></i>
										</c:if> 
										<c:if test="${r.type=='pdf'}" >
											<i class="am-icon-file-pdf-o am-icon-lg" style=" color:  #BE2924;"></i>
										</c:if> 
										<c:if test="${r.type=='other'}" >
											<i class="am-icon-question-circle-o  am-icon-lg" style="vertical-align: middle;"></i>
										</c:if> 
									</a>
									<div style="width: 80%; margin: 0 auto;">
										<h5 style="text-align: center; display: block; margin-bottom: 0; color: dimgray;">
											${r.name}
										</h5>
										<div style="width: 100%;">
											<span style="font-size: small; margin-right: 50px;">大小:${r.size}</span>
											<span style="font-size: small;">${r.good}好评</span>
										</div>
										<div style="width: 100%;" >
											<a onclick="save('${r.srcID}')"><i  class="am-icon-save" style="cursor: pointer; color: #0075B0;">保存</i> </a>
											<a onclick="publicdownload('${r.srcID}')" href="down?srcID=${r.srcID}"><i class="am-icon-download" style="cursor: pointer; color: #0075B0; margin-right: 20px; float: right;"></i></a>
											<span style="float: right; font-size: small; margin-right: 10px; font-size: medium;">
												${r.downloads}次下载
											</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="am-u-lg-12 am-cf" style="text-align: center;  bottom: 0; height: 8%;">
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
							                <li><a href="<%=request.getContextPath()%>/search?name=${name}&type=${type}&page=1">首页</a></li>
							                <li><a href="<%=request.getContextPath()%>/search?name=${name}&type=${type}&page=${current_page-1}">«上一页</a></li>
							            </c:otherwise>
							         </c:choose>
									<c:forEach var="i" begin="${begin}" end="${end}">
									     	
									        <c:choose>
									            <c:when test="${i == current_page}">
									                <li class="am-active"><a href="#">${i}</a></li>
									            </c:when>
									            <c:otherwise>
									                <li><a href="<%=request.getContextPath()%>/search?name=${name }&type=${type}&page=${i}">${i}</a></li>
									            </c:otherwise>
									        </c:choose>
									      
									</c:forEach>
									  <c:choose>
							             <c:when test="${count == current_page}">
							                <li class="am-disabled"><a href="#">下一页»</a></li>
											<li class="am-disabled"><a href="#">尾页</a></li>
							            </c:when>
							            <c:otherwise>
							                <li><a href="<%=request.getContextPath()%>/search?name=${name}&type=${type}&page=${current_page+1}">下一页»</a></li>
							                <li><a href="<%=request.getContextPath()%>/search?name=${name}&type=${type}&page=${count}">尾页</a></li>
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