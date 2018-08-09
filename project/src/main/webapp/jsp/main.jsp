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
	#content{height:800px; width:77%; margin-left:50%;transform: translate(-50%, 0%); background-color: blue ; }
	ul#second {list-style-type:none;background-image:url("img/back2.jpg");height:95%;width:100%;background-size:contain;background-repeat:no-repeat;}
	#mainbnt{width:250px; height:auto;}
	ul#second li{display:inline;}
	
	#img1 {
		height:95%; width:100%;
	}
	
	#img2 {
		height:95%; width:100%;
	}
</style>
<body>
<div id="top">
	<jsp:include page="top.jsp"/>
</div>
<div id="content">
	이미지 변경할 때 :
	<button id="minus">이전</button>
	<button id="plus">이후</button>
	<form id="a1">
    	<ul id="second">
     		<li><a href="part.env"><img src="img/제조업.jpg" id="mainbnt"></a></li>
      		<li><a href="area.env"><img src="img/지역별.jpg" id="mainbnt"></a></li>
      		<li><a href="object.env"><img src="img/object.jpg" id="mainbnt"></a></li>
     	</ul> 
 	</form>
	<form id="a2"><img src="img/back3.jpg" id="img1"></form>
	<form id="a3"><img src="img/a.jpg" id="img2"></form>
</div>
	
<div id="footer">
	<jsp:include page="footer.jsp"/>
 </div>  
</body>
</html>