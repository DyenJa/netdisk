
$(function(){
	$(".more_png").click(function() {
		// 使用siblings获取被点击元素之外的同级元素，然后使用remove()删除
		alert("OK");
	});
});
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  // 匹配目标参数
    if (r != null) return unescape(r[2]); return null; // 返回参数值
}           
			
/*			
	function show(tag){
	
		var light=window.parent.document.getElementById(tag);
	
		 light.style.display='block';
		document.getElementById("test_close").click();
		 
	}
	
		function hide(tag){
		 var light=document.getElementById(tag);
	
		 light.style.display='none';
		
		}*/