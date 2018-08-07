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
</head>
<body>
<input type="hidden" id="RSAModulus" value="${modulus}"/>
<input type="hidden" id="RSAExponent" value="${exponent}"/>   
	<jsp:include page="../top.jsp"/>

	<div id="join_wrap" class="container">
	<h2 class="join_title">회원가입</h2>
	<form name="f" method="post" action="join_ok1.env" onsubmit="return check(event);">
		<table id="join_t">
 		<tr>
     		<th>소속</th>
     		<td>
 				<input type="radio" value="friend" name="position" onclick="notmaster()" selected>일반인용
 				<input type="radio" value="company" name="position" onclick="notmaster()">기업용
 				<input type="radio" value="master" name="position" onclick="master()">관리자용
 				<b id="master" style="display:none">&nbsp;>> master 인증 번호: <input type="text" id="mastercheck" value="env123"></b>
     		</td>
   	 	</tr>
    	<tr>
     		<th>아이디</th>
     		<td><input name="join_id" id="join_id" size="14" class="input_box" />
      			<input type="button" value="아이디 중복체크" class="input_button" onclick="id_check()" />
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
     		</select>-<input name="join_phone2" id="join_phone2" size="4" maxlength="4" class="input_box" />
     				 -<input name="join_phone3" id="join_phone3" size="4" maxlength="4" class="input_box" />
     		</td>
    	</tr>
    	<tr>
    		<th>이메일</th>
     		<td>
      		<input name="join_mailid" id="join_mailid" size="10" 
      		class="input_box" />@<input name="join_maildomain" 
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
    	</table>
    
   <div id="join_menu">
    <input type="submit" value="회원가입" class="input_button" />
    <input type="reset" value="가입취소" class="input_button" onclick="$('#join_id').focus();" />
   </div>
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

</div> <!-- container end -->
</div></div>
</div></div>
	<div id="footer">
	<jsp:include page="../footer.jsp"/>
 </div>  
</body>

</html>