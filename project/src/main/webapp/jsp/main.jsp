<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<html>
<meta charset="UTF-8">
<title>연습</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
	var i =1;
	var src= document.getElementById('a'+i).src;
 	$("#bestcom").attr("src",src)
	$('#best_list img:not(#a'+i+')').animate({"opacity":"0.2"},100);
 	$('#best_list img').click(function(e){
 		var id  = e.target.id;
 		var num = id.indexOf("a");
 		var n = id.substring(num+1);
 		i=n;
 		if(i==5){i=1;}
		if(i==0){i=4;}
		src= document.getElementById('a'+i).src;
	 	$("#bestcom").attr("src",src)
		$('#best_list #a'+i).animate({"opacity":"1"});
		$('#best_list img:not(#a'+i+')').animate({"opacity":"0.2"},100);
 	});
 	$('#plus').click(function(){
		i++;
		if(i==5){i=1;}
		src= document.getElementById('a'+i).src;
	 	$("#bestcom").attr("src",src);
	 	$('#best_list #a'+i).animate({"opacity":"1"});
		$('#best_list img:not(#a'+i+')').animate({"opacity":"0.2"},100);
	});
	$('#minus').click(function(){
		i--;
		if(i==5){i=1;}
		if(i==0){i=4;}
		src= document.getElementById('a'+i).src;
	 	$("#bestcom").attr("src",src)
		$('#best_list #a'+i).animate({"opacity":"1"});
		$('#best_list img:not(#a'+i+')').animate({"opacity":"0.2"},100);
	});
  	setInterval(function(){
		i++;
		if(i==5){i=1;}
  		src= document.getElementById('a'+i).src;
	 	$("#bestcom").attr("src",src);
	 	$('#best_list #a'+i).animate({"opacity":"1"});
	 	$('#best_list img:not(#a'+i+')').animate({"opacity":"0.2"},1000);

	},2000);  
})

	function popup(){
		window.open("contest.env","공모전","width=700,height=900");
	}
	function scroll(){
		if(document.body.scrollTop>40||document.documentElement.scrollTop>40){
			document.getElementById("totop").style.display="block";
		}else{document.getElementById("totop").style.display="none";}
	}
	function totop(){
		document.body.scrollTop=0;
		document.documentElement.scrollTop=0;
	}

</script>
<style>
	#page-content-wrapper {
	background-color:#B7DDF7;
	}
 	div#second_div {
		height:100%;
		background-color:#FFD9FA;
	}
 	div#carousel {
		height:100%;width:100%;
		background-color:#FAE0D4;
	}
	div#second_div > table{width:100%;}
	
	#carousel{height:800px; width:77%; background-color:skyblue;}
	.slide {
	overflow:hidden;
	transform:translateZ(0);
	transition:transform 1s linear;
	}
	
	#carousel table tr th{margin-left:auto;margin-right:auto}
</style>
<body onload="popup2()" onscroll="scroll()">
<div id="top">
	<jsp:include page="top.jsp"/>
</div>
<div id="content">
	<img src="img/let.gif" width=100% height=85%>
	<div id="second_div">
		<table align=center border=1 >
			<tr height="20%"><th ><h1>환경정보 공개제도</h1></th></tr>
			<tr height="80%"><th>
     		<a href="part.env"><img src="img/제조업.jpg" id="mainbnt"></a>
      		<a href="area.env"><img src="img/지역별.jpg" id="mainbnt"></a>
      		<a href="object.env"><img src="img/object.jpg" id="mainbnt"></a> 	
		</th></tr></table>
	</div>

	<div id="carousel"> 
		<table align=center border=1 height=100%>
			<tr height="10%"><th colspan=3><h1>우수기업</h1></th></tr>
			<tr height="70%"><th><button id="minus"><b><</b></button></th>
				<th id="best"><img id="bestcom" height=80% width=auto></th>
				<th><button id="plus"><b>></b></button></th></tr>
			<th></tr>
			<tr id="best_list" height="20%">
			<th colspan=3>
				<img src="img/best/2013.jpg" id="a1"  class="slide">
				<img src="img/best/2014.jpg" id="a2"  class="slide">
				<img src="img/best/2015.jpg" id="a3"  class="slide">							
				<img src="img/best/2016.jpg" id="a4"  class="slide">							
			</th></tr>
			</table>
	</div>
<button onclick="totop()" id="totop" class="btn-danger" style="display:none;position:fixed;bottom:1;right:1">위로 가기!!</button>
</div>
<div id="footer">
	<jsp:include page="footer.jsp"/>
 </div>  
</body>
</html>