<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>footer</title>
<script>
	function find(){
		var a = document.getElementById("find_val").value;
	    alert(a);
		if(a==""||a==null){ 
			alert("찾을 값을 입력하세요.");	
			return false;
		}
		location.href="find.env?find_val="+a; //replyBoardcontroller에 있음
	}
</script>
<style>
@font-face{
	font-family:we;
	src:url('a.woff')format('woff');
}
	#footer {
			padding: 10px;
			background-color: #333;
				
			text-align: center;
	}
	#footer_text{
		color: white;
	}	
</style>
</head>
<body>
 	<div id="footer">
    <input type="text" id="find_val" >
    <input type="button" id="find" value='찾기' onclick="return find()" onkeypress="javascript:if(event.keyCode == 13){ return find() }">
	<br>
	<div id="footer_text">
     03367 서울시 은평구 진흥로 215 한국환경산업기술원 친환경경영실<br> 
     TEL 02-2284-1980  FAX 02-2284-1981<br>
	 Copyright ⓒ2018 환경정보공개시스템. All right reserved<br>  
	</div>
	</div> 
</body>
</html>