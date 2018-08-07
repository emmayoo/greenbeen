<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
function check(){
	 if($.trim($("#id").val())==""){
		 alert("아이디를 입력하세요!");
		 $("#id").val("").focus();
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
	 if($.trim($("#hmm").val())!="close"){
	 	var data1=$('#f').serialize();
		$.post("pwd_send_mail.env?"+data1,function(data){
		 		if(data.trim()=="yes") {
		 			$("#hmm").val("close");
			 		alert("이메일로 임시비밀번호를 보냈습니다.");
		 		}
		});
	 }
	 if($.trim($("#hmm").val())=="close"){
		 return true;
	}else{
		return false;
 	}
}

function domain_list() {
	var num=f.mail_list.selectedIndex;
	if ( num == -1 ) { 
		return true;
	}
	if(f.mail_list.value=="0"){ 
		 f.join_maildomain.value="";
	 	f.join_maildomain.readOnly=false;
		f.join_maildomain.focus();
	}else {
		f.join_maildomain.value=f.mail_list.options[num].value;
		f.join_maildomain.readOnly=true;
	}
 }
</script>
</head>
<body>
 <div id="pwd_wrap">
  <h2 class="pwd_title">비밀번호 찾기</h2>
  <form method="post" onsubmit="return check()" action="javascript:self.close();" name="f" id="f">  
   <input type=button id="hmm" value="first">
   <table id="pwd_t">
    <tr>
     <th>회원아이디</th>
     <td><input name="join_id" id="id" size="14" class="input_box" /></td>
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
     	</td>
    </tr>
   </table>
   <div id="pwd_menu">
    <input type="submit" value="찾기" class="input_button"/>
    <input type="reset" value="취소" class="input_button" 
    onclick="self.close();"/>
   </div>
  </form>
 </div>
</body>
</html>