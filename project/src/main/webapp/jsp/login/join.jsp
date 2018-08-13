<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 폼</title>
<script src="<%=request.getContextPath()%>/js/login/member.js"></script>
<script src="<%=request.getContextPath()%>/js/rsa/rsa.js"></script> 
<script src="<%=request.getContextPath()%>/js/rsa/jsbn.js"></script>
<script src="<%=request.getContextPath()%>/js/rsa/prng4.js"></script>
<script src="<%=request.getContextPath()%>/js/rsa/rng.js"></script>

<style>
body .container{ 
	/* background-image:url('img/배경.PNG'); */
	background-repeat:no-repeat ;   
	background-size : 100% 100%;  
	background-color: white;
} 

table.type07 {
	width : 70%;
	height : 50%;
	
    border-collapse: collapse;
    text-align: left;

    margin: 20px auto;
    
 
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

.input_button,.input_button1{
  
  width: 30%;
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

#join_menu{
  margin : auto ;
  width: 100%;
  text-align: center;
  
}
</style>


</head>
<body>
<input type="hidden" id="RSAModulus" value="${modulus}"/>
<input type="hidden" id="RSAExponent" value="${exponent}"/>   
	<jsp:include page="../top.jsp"/>

	<div id="join_wrap" class="container">
	<br><br><br> 
	
	<form name="f" method="post" action="join_ok1.env" onsubmit="return check(event);">
		<table id="join_t" class="type07" border=1>
		<thead>
 		<tr>
 			<th colspan=2><h2 class="join_title" align="center">회원가입</h2> </th>
 		</tr>
 		</thead>
 		
 		<tbody>
 		<tr>
     		<th>소속</th>
     		<td>
 				<input type="radio" value="friend" name="position" onclick="notmaster()" selected>일반인용
 				&nbsp;&nbsp;
 				<input type="radio" value="company" name="position" onclick="notmaster()">기업용
 				&nbsp;&nbsp;
 				<input type="radio" value="master" name="position" onclick="master()">관리자용
 				<b id="master" style="display:none">&nbsp;>> master 인증 번호: <input type="text" id="mastercheck" value="env123"></b>
     		</td>
   	 	</tr>
    	<tr>
     		<th>아이디</th>
     		<td><input name="join_id" id="join_id" size="14" class="input_box" />
     			&nbsp;&nbsp;&nbsp;
      			<input type="button" value="아이디 중복체크" class="input_button1" onclick="id_check()" />
      			<div id="idcheck"></div></td>
   	 	</tr>
    	<tr>
     		<th>비밀번호</th>
     		<td><input type="password" name="join_pwd1" id="join_pwd1" size="14" class="input_box" /></td>
    	</tr>
    	<tr>
     		<th>비밀번호 확인</th>
     		<td><input type="password" name="join_pwd2" id="join_pwd2" size="14"class="input_box" /></td>
    	</tr>
    	<tr>
			<th>이름</th>
     		<td><input name="join_name" id="join_name" size="14" class="input_box" /></td>
    	</tr>
  	    <tr>
     		<th>연락처</th>
     		<td>
     		<%@ include file="../../jsp/include/phone_number.jsp" %>
     		<select name="join_phone1" id="join_phone1">
      			<c:forEach var="p" items="${phone}" begin="0" end="5">
      			<option value="${p}">${p}</option>
      			</c:forEach>
     		</select> - <input name="join_phone2" id="join_phone2" size="4" maxlength="4" class="input_box" />
     				  - <input name="join_phone3" id="join_phone3" size="4" maxlength="4" class="input_box" />
     		</td>
    	</tr>
    	<tr>
    		<th>이메일</th>
     		<td>
      		<input name="join_mailid" id="join_mailid" size="10" 
      		class="input_box" /> @ <input name="join_maildomain" 
      		id="join_maildomain" size="20" class="input_box" readonly />
      <!--readonly는 단지 쓰기,수정이 불가능하고 읽기만 가능하다 //-->
      
      		<select name="mail_list" onchange="domain_list()">
      		<option value="">=이메일선택=</option>
      		<option value="daum.net">daum.net</option>
      		<option value="nate.com">nate.com</option>
      		<option value="naver.com">naver.com</option>
      		<option value="hotmail.com">hotmail.com</option>
      		<option value="gmail.com">gmail.com</option>
      		<option value="0">직접입력</option>
    		 </select> 
     		</td>
    	</tr>
    
    <tr>
    <td colspan=2>
    <br><br>
	   <div id="join_menu">
   	   <input type="submit" value="회원가입" class="input_button" />
       <input type="reset" value="가입취소" class="input_button" onclick="$('#join_id').focus();" />
      </div>
    </td>
    </tr>
   
   </tbody>
    </table>
    	
  </form >
  
  <form id="hiddenForm" action="join_ok.env" method="post">
  		<input type="hidden" name="join_id" id="hdn_id">
		<input type="hidden" name="join_pwd1" id="hdn_pw">
		<input type="hidden" name="join_name" id="hdn_name">
		<input type="hidden" name="join_mailid" id="hdn_mailid">
		<input type="hidden" name="join_maildomain" id="hdn_maildomain">
		<input type="hidden" name="join_phone1" id="hdn_phone1">
		<input type="hidden" name="join_phone2" id="hdn_phone2">
		<input type="hidden" name="join_phone3" id="hdn_phone3">
		<input type="hidden" name="position" id="hdn_position">
  </form>
	<br><br><br> 
	
</div> <!-- container end -->
</div></div>
</div></div>
	<div id="footer">
	<jsp:include page="../footer.jsp"/>
 </div>  
</body>

</html>