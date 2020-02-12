<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="/css/jquery.dataTables.min.css" type="text/css">
<title>Insert title here</title>
</head>
<body>
    <center>
        <h3> welcome </h3>
        <table id="dataTable" class="dataTable">
		    <thead>
		        <tr>
		            <th>uid</th>
		            <th>uname</th>
		        </tr>
		    </thead>
		</table>
		<br/><br/><br/>
    	uname:<input id="uname" /><button id="bt" type="button">delete</button>
    </center>
</body>


<script type="text/javascript">

$(document).ready(function(){ 
	$.ajax({
		type:'get',
		dataType:'json',
		url:"/user/select",
		success:function(data){
		$('#dataTable').DataTable({
		data: data,
		columns: [
	    	{ data: 'uid' },
	    	{ data: 'uname' }
	 	]});
		}
	});


  $("#bt").click(function(){
	  var url="/user/delete";
	  var uname=$("#uname").val();
	  $.ajax({
		  type : 'post',
		  data:{"uname":uname},
		  url:url,
		  success: function(data){
		        alert(data);
		  },
		  error: function(){
		      alert("fail");
		  }
	  });
  });
});
</script>
</html>