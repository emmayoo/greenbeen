<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
function send_mail(){
	if($.trim($("#name").val())==""){
		 alert("회원이름을 입력하세요!");
		 $("#name").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_mailid").val())==""){
		 alert("이메일주소를 입력하세요!");
		 $("#join_mailid").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_maildomain").val())==""){
		 alert("이메일을 바르게 입력하세요!");
		 $("#join_maildomain").val("").focus();
		 return false;
	 }
	 var data=$('#f').serialize();
	 $.post("id_send_mail.env?"+data,function(data){
		 var d =data.trim()
		 var a1 =d.split(",");
		 var a2 =a1[1];
		 d=a1[0];
		 $('#text').val(a2);
		 alert(d);
		 if(d.equals('y'))alert("1");
		 if(d.equals("y"))alert("2");
		 if(d=="y")alert("3");
		 if(d=='y')alert("4");
	 });
	//객체 생성부분
	/* var xmlhttp;  
	if (window.XMLHttpRequest) {  
	    xmlhttp = new XMLHttpRequest();
	} 
	else {  
	    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}

	//Ajax구현부분
// 	xmlhttp.onreadystatechange = function() {  
//	    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
//	         //통신 성공시 구현부분
//	         alert("이메일에서 인증번호를 확인하세요.");
//	    }
//	} 
	xmlhttp.open("POST", "send_mail.env?"+data, true);  
	xmlhttp.send(); */


}

function check(){
	 if($.trim($("#name").val())==""){
		 alert("회원이름을 입력하세요!");
		 $("#name").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_mailid").val())==""){
		 alert("이메일주소를 입력하세요!");
		 $("#join_mailid").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_maildomain").val())==""){
		 alert("이메일을 바르게 입력하세요!");
		 $("#join_maildomain").val("").focus();
		 return false;
	 }
	
	 if($.trim($("#mailcheck").val())==""){
		 alert("인증번호를 입력하세요(이메일을 확인하세요)!");
		 $("#mailcheck").val("").focus();
		 return false;
	 }
}
 
function domain_list() {
	var num=f.mail_list.selectedIndex;
	if ( num == -1 ) { //num==-1은 해당 리스트목록이 없다
		return true;
	}
	if(f.mail_list.value=="0"){ // 직접입력
		/*리스트에서 직접입력을 선택했을때*/
		 f.join_maildomain.value="";
		//@뒤의 도메인입력란을 빈공간시켜라.
	 	f.join_maildomain.readOnly=false;
		//@뒤의 도메인입력란을 쓰기 가능
		f.join_maildomain.focus();
		//도메인입력란으로 입력대기상태
	}else {//리스트목록을 선택했을때
		f.join_maildomain.value=f.mail_list.options[num].value;
		/*
		num변수에는 해당리스트 목록번호가 저장되어있다.
		해당리스트 번호의 option value값이 도메인입력란에 선택된다.
		options속성은 select객체의 속성으로서 해당리스트번호의 value값을 가져온다
		*/
		f.join_maildomain.readOnly=true;
	}
 }
</script>

<style>
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
 <div id="id_wrap">
 
 <c:if test="${empty pwdok}"> 
  <form method="post" onsubmit="return check()" action="id_find_ok.env" name="f" id="f">  
   <input type=hidden id="text" name="findid">
   <table id="id_t" border=1>
   <tr><td colspan=2><h2 class="id_title" align="center">아이디찾기</h2></td></tr>
    <tr>
     <th>회원이름</th>
     <td><input name="join_name" id="name" size="14" class="input_box" /></td>
    </tr>
    
    <tr>
     <th>이메일</th>
     	<td>
      		<input name="join_mailid" id="join_mailid" size="10" class="input_box" />
      		@
      		<input name="join_maildomain" 
      			id="join_maildomain" size="20" class="input_box"/>      
      		<select name="mail_list" onchange="domain_list()">
      			<option value="">=이메일선택=</option>
      			<option value="daum.net">daum.net</option>
      			<option value="nate.com">nate.com</option>
      			<option value="naver.com">naver.com</option>
      			<option value="hotmail.com">hotmail.com</option>
      			<option value="gmail.com">gmail.com</option>
      			<option value="0">직접입력</option>
    		 </select> 
    		 <input type="button" value="인증번호 받기" onclick="return send_mail()"/>
     	</td>
    </tr> 
	<tr>
     <th>인증번호</th>
     <td><input name="mailcheck"  id="mailcheck"/></td>
    </tr>
    <%-- <tr>
     <th>휴대폰번호</th>
     <td>
     		<%@ include file="../../jsp/include/phone_number.jsp" %>
     		<select name="join_phone1">
      			<c:forEach var="p" items="${phone}" begin="0" end="5">
      			<option value="${p}">${p}</option>
      			</c:forEach>
     		</select>-<input name="join_phone2" id="join_phone2" size="4" maxlength="4" class="input_box" />
     				 -<input name="join_phone3" id="join_phone3" size="4" maxlength="4" class="input_box" />
     		</td>
    </tr> --%>
    
 <tr><td colspan=2>
 <div id="last">
   <div id="id_menu">
    <input type="submit" value="찾기" class="input_button" />
    <input type="reset" value="취소" class="input_button" 
    onclick="javascript:f.join_name.focus();"/>
   </div>
   <div id="id_close">
    <input type="button" value="닫기" class="input_button"
    onclick="self.close();" />
    <!-- close()메서드로 공지창을 닫는다. self.close()는 자바스크립트이다. -->
   </div>
   </div>
   </td></tr>
   </table>
  </form>
  </c:if>
  
  
  <c:if test="${!empty pwdok}">
    <h2 class="id_title2">아이디찾기 결과</h2>
    <table id="id_t2">
     <tr>
      <th>검색한 아이디:</th>
      <td>${pwdok}</td>
     </tr>
    </table>
    <div id="id_close2">
    <input type="button" value="닫기" class="input_button"
    onclick="self.close();" />
    <!-- close()메서드로 공지창을 닫는다. self.close()는 자바스크립트이다. -->
    </div>
  </c:if> 
  
 </div>
</body>
</html>