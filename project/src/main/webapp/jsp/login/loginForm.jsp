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

body .container{ 
	/* background-image:url('img/배경.PNG'); */
	background-repeat:no-repeat ;   
	background-size : 100% 100%;  
	background-color: white;
} 

/* 테이블 라인 */
table.type07 {
	width : 50%;
	height : 50%;
	
    border-collapse: collapse;
    text-align: left;

    margin: 20px auto;
 
}


table.type07 thead {

/*     border-right: 1px solid #000000; 
    border-left: 1px solid #000000;  */
/*     background: #FAED7D; */
}

table.type07 thead th {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
  /*    color: black; */ 
}

table.type07 tbody th {
    width: 30%;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    font-size : 18px;
    text-align: center;
    margin: 0 auto;
     
    /*  border-bottom: 1px solid #000000;  */
    /* background: #E4F7BA; */
}

table.type07 td {
    width: 350px;
    padding: 10px;
    vertical-align: top; 
   /*  border-bottom: 1px solid #ccc; */
}

.input_button ,.input_button1 {
  
  width: 22%;
  height: 50%;
  font-family: 'Roboto', sans-serif;
  font-size: 14px; 
  font-weight: bold;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #fff;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  margin: auto;
  
  }

.input_button:hover {
  background-color: #2EE59D;
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  color: black;
  transform: translateY(-7px);
}

.input_button1:hover {
  background-color: #CEFBC9;
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  color: black;
  transform: translateY(-7px);
}

#last{
  margin : 0 auto ;
   width: 100%;
   text-align: center;
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
	<br><br><br> 
	
 	<form method="post" action="login_ok1.env" onsubmit="return login_check(event);" id="form">
	<%-- 	<input type=hidden value="${inter}" name="inter" id="inter"> --%>
 		<table align="center" id="login_t" class="type07" border=1>   
 	  	<thead><tr>
 	  		<th colspan=3><h1 align="center"> 로그인</h1></th></tr>
 	  	</thead>
 	  	
 	  	<tbody>
 		<tr>
 			<th>아이디</th>
 			<td colspan=2><input type=text name="id" id="id">
 			&nbsp;&nbsp;
 			<input type=checkbox name="id_cookie" id="id_cookie">아이디 저장하기
 			</td>
 		</tr>
 		<tr>
 			<th>비밀번호</th>
 			<td colspan=2><input type=text name="pwd" id="pwd"></td>
 		</tr>

 		<tr>
 		<td colspan=3>
 		<br><br>
 		<div id='last'>
 			<input type="submit" value="로그인" class="input_button"/>
 			<input type="button" value="회원가입" class="input_button" onclick="location.href='join.env'"/>
 			<input type="button" value="아이디찾기" class="input_button1" onclick="id_find()"/>
 			<input type="button" value="비밀번호찾기" class="input_button1" onclick="pwd_find()"/>
 		</div>
 		</td>
 		</tr>

 		</tbody>
 	</table>
</fieldset>
 	</form>
 	<br><br><br>
 	
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