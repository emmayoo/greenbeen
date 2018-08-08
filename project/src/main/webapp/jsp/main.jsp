<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<html>
<meta charset="UTF-8">
<title>연습</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
	var i =1;
	$('form:not(#a'+i+')').hide();
	$('#plus').click(function(){
		i++;
		$('form').show();
		if(i==4){i=1;}
		$('form:not(#a'+i+')').hide();
	});
	$('#minus').click(function(){
		i--;
		$('form').show();
		if(i==4){i=1;}
		if(i==0){i=3;}
		$('form:not(#a'+i+')').hide();
	});
 	setInterval(function(){
		$('form').show();
		i++;
		if(i==4){i=1;}
		$('form:not(#a'+i+')').hide();

	},2000); 
})
</script>
<style>
	#content{height:700px;margin-left:50%;transform: translate(-50%, 0%);}
	ul#second {list-style-type:none;background-image:url("img/back2.jpg");height:500px;width:1200px;background-size:contain;background-repeat:no-repeat;}
	#mainbnt{width:250px; height:auto;}
	ul#second li{display:inline;}
</style>
<body>
<div id="top">
	<jsp:include page="top.jsp"/>
</div>
<div id="content">
	이미지 변경할 때 :
	<button id="minus">이전</button>
	<button id="plus">이후</button>
	<form id="a1"><img src="img/back.jpg" height=500px></form>
	<form id="a2"><img src="img/back3.jpg" height=500px></form>
	<form id="a3"><img src="img/back3.jpg" height=500px"></form>
</div>
	
<div id="footer">
	<jsp:include page="footer.jsp"/>
 </div>  
</body>
</html>