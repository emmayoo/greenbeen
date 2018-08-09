<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>footer</title>
<script>
	function find(){
		var a = document.getElementById("find_val2").value;
	    alert(a);
		if(a==""||a==null){ 
			alert("검색어를 입력하세요.");	
			return false;
		}
		location.href="find.env?find_val="+a; //replyBoardcontroller에 있음
	}
</script>
<style>
	#footer {
			padding: 10px;
			background-color: white;
			
			color: black;
			text-align: center;
			}
	#footer .p {
			font-size :20px;
			font-weight:20;
	}
	
	hr {
		border: 1;
 	    width: 75%;
 	    border-color : #CACACA;
 	    height: 20px;
	}


</style>
</head>
<body>
 	<div id="footer">
 	<hr>
    <input type="text" id="find_val2" onkeydown="javascript:if(event.keyCode==13){return find();}">
    <input type="button" id="find" value='찾기' onclick="return find();">
	<br><br>
	<p class="p">
     03367 서울시 은평구 진흥로 215 한국환경산업기술원 친환경경영실<br> 
     TEL 02-2284-1980  FAX 02-2284-1981<br>
	 Copyright ⓒ2018 환경정보공개시스템. All right reserved<br>  
	</p>
	</div> 
</body>
</html>