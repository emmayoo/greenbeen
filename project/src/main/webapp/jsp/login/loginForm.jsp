<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
<script src="<%=request.getContextPath() %>/js/rsa/jsbn.js"></script>
<script src="<%=request.getContextPath() %>/js/rsa/prng4.js"></script>
<script src="<%=request.getContextPath() %>/js/rsa/rng.js"></script>
<script src="<%=request.getContextPath() %>/js/rsa/rsa.js"></script> 
<script>
function login_check(e){
	 var rsa = new RSAKey();
	 rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val()); //rsa 암호화 생성
	
	 if($.trim($("#id").val())==""){
		 alert("로그인 아이디를 입력하세요!");
		 $("#id").val("").focus();
		 return false;
	 }
	 if($.trim($("#pwd").val())==""){
		 alert("비밀번호를 입력하세요!");
		 $("#pwd").val("").focus();
		 return false;
	 }else{
		e.preventDefault(); // 입력폼 미전송
		$("#hdn_id").val($("#id").val()); // 아이디 암호화 후 히든 id에 대입
		$("#hdn_pwd").val(rsa.encrypt($("#pwd").val())); // 비밀번호 암호화 후 히든 pw에 대입
		$("#hdn_autologin").val($("#id_cookie:checked").val());
		$("#hiddenForm").submit();
		
	 }
}

/*아이디찾기 공지창*/
function id_find(){
	 window.open("id_find.env","아이디찾기","width=500,height=500");
	 //자바 스크립트에서 window객체의 open("공지창경로와 파일명","공지창이름","공지창속성")
	 //메서드로 새로운 공지창을 만듬.폭이 400,높이가 400인 새로운 공지창을 만듬.단위는 픽셀
}
/*비번찾기 공지창*/
function pwd_find(){
	 window.open("pwd_find.env","비번찾기","width=500,height=500");
	 //자바 스크립트에서 window객체의 open("공지창경로와 파일명","공지창이름","공지창속성")
	 //메서드로 새로운 공지창을 만듬.폭이 400,높이가 400인 새로운 공지창을 만듬.단위는 픽셀
}

</script>
<style>

body {
	background-color: #bdc3c7
}

h1 {
	color: #2c3e50;
	text-color: #2c3e50;
}

input[type=button], input[type=submit] {
	background-color: #1abc9c;
	border: none;
	color: white;
	padding: 12px 28px;
	font-size: 12px;
}



</style>
</head>
<body>
<input type="hidden" id="RSAModulus" value="${modulus}"/>
<input type="hidden" id="RSAExponent" value="${exponent}"/>   
<jsp:include page="../top.jsp"/>
<div class="container">
<%-- <c:if test="${id!=null && pwd!=null}">
	<form method="post" action="login_ok1.env">
		<input type=button value="${id}" name="id" >
		<input type=button value="1" name="pwd" >
		<input type=submit value="가자" >
		<input type=button value="쿠키삭제" onclick="location.href='logout.env';">
	</form>	
</c:if> --%>
<c:if test="${id==null && pwd==null}">
 	<form method="post" action="login_ok1.env" onsubmit="return login_check(event);">
	<%-- 	<input type=hidden value="${inter}" name="inter" id="inter"> --%>
 		<table align="center" id="login_t">
 		<caption><h1> 로그인</h1></caption>
 		<tr>
 			<td colspan=2>아이디</td>
 		</tr>
 		<tr>
 			<td colspan=2><input type=text name="id" id="id"></td>
 		</tr>
 		<tr>
 			<td colspan=2>비밀번호</td>
 		</tr>
 		<tr>
 			<td colspan=2><input type=text name="pwd" id="pwd"></td>
 		</tr>
 		<tr>
 			<td colspan=2><input type=checkbox name="id_cookie" id="id_cookie">아이디 저장하기</td>
 		</tr>
 		<tr>
 		<td>
 			<input type="submit" value="로그인" class="input_button"/>
 			<input type="button" value="회원가입" class="input_button" onclick="location.href='join.env'"/>
 		</td>
 		</tr>
 		
 		<tr>
 		<td>
 			<input type="button" value="아이디찾기" class="input_button" onclick="id_find()"/>
 			<input type="button" value="비밀번호찾기" class="input_button" onclick="pwd_find()"/>
 		</td>
 		</tr>
 	</table>
 	</form>
 </c:if>
 	<%-- 서버에 실제 전송되는 폼 --%>
	<form id="hiddenForm" action="login_ok.env" method="post">
		<input type="hidden" id="hdn_id" name="id">
		<input type="hidden" id="hdn_pwd" name="pwd">
		<input type="hidden" id="hdn_autologin" name="id_cookie">
		<input type=hidden value="${inter}" name="inter" id="inter">
	</form>
 </div> <!-- container end -->
</div></div>
</div></div>
 <div id="footer">
	<jsp:include page="../footer.jsp"/>
 </div>  
</body>
</html>