function master(){
	$("#mastercheck").val("").focus();
	$("#master").removeAttr("style");
	alert("비밀번호를 입력하세요.\n(모르면 연주한테 물어 보기~oracle계정 비번)");
}
function notmaster(){
	$("#master").attr("style","display:none");
}
 function check(e){
	 var rsa = new RSAKey();
	 //rsa.setPublic('${modulus}', '${exponent}');

	 rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
	 if($.trim($("#join_id").val())==""){
		 alert("회원아이디를 입력하세요!");
		 $("#join_id").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_pwd1").val())==""){
		 alert("회원비번을 입력하세요!");
		 $("#join_pwd1").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_pwd2").val())==""){
		 alert("회원비번확인을 입력하세요!");
		 $("#join_pwd2").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_pwd1").val()) != $.trim($("#join_pwd2").val())){
		 //!=같지않다 연산. 비번이 다를 경우
		 alert("비번이 다릅니다!");
		 $("#join_pwd1").val("");
		 $("#join_pwd2").val("");
		 $("#join_pwd1").focus();
		 return false;
	 }
	 if($.trim($("#join_name").val())==""){
		 alert("회원이름을 입력하세요!");
		 $("#join_name").val("").focus();
		 return false;
	 }

	 if($.trim($("#join_phone2").val())==""){
		 alert("휴대전화번호를 입력하세요!");
		 $("#join_phone2").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_phone3").val())==""){
		 alert("휴대전화번호를 입력하세요!");
		 $("#join_phone3").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_mailid").val())==""){
		 alert("메일 아이디를 입력하세요!");
		 $("#join_mailid").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_maildomain").val())==""){
		 alert("메일 주소를 입력하세요!");
		 $("#join_maildomain").val("").focus();
		 return false;
	 }
	 
	 if($.trim($("#mastercheck").val())!="env123"){
		 alert("master 인증 비밀번호를 확인세요!");
		 $("#mastercheck").val("").focus();
		 return false;
		 
	 }else { // 암호화
			// 유저 입력폼 서버 전송 방지
			e.preventDefault();
			// hidden form에 id, pw, email 암호화 후 값 저장
			$("#hdn_id").val($("#join_id").val());
			$("#hdn_pw").val(rsa.encrypt($("#join_pwd1").val()));
			//$("#hdn_pw").val($("#join_pwd1").val());
			$("#hdn_name").val($("#join_name").val());
			$("#hdn_mailid").val($("#join_mailid").val());
			$("#hdn_maildomain").val($("#join_maildomain").val());
			$("#hdn_phone1").val($("#join_phone1").val());
			$("#hdn_phone2").val($("#join_phone2").val());
			$("#hdn_phone3").val($("#join_phone3").val());
			$("#hdn_position").val($("input:radio[name='position']:checked").val());
			// 히든 폼 서버 전송
			$("#hiddenForm").submit();
		}
 }
 
/* 아이디 중복 체크*/
function id_check(){
	$("#idcheck").hide();//idcheck span 아이디 영역을 숨긴다.
	var memid=$("#join_id").val();
	//1.입력글자 길이 체크
	if($.trim($("#join_id").val()).length < 4){
		var newtext='<font color="red">아이디는 4자 이상이어야 합니다.</font>';
		$("#idcheck").text('');
		$("#idcheck").show();
		$("#idcheck").append(newtext);//span 아이디 영역에 경고문자 추가
		$("#join_id").val("").focus();
		return false;
	};
	if($.trim($("#join_id").val()).length >12){
		var newtext='<font color="red">아이디는 12자 이하이어야 합니다.</font>';
		$("#idcheck").text('');
		$("#idcheck").show();
		$("#idcheck").append(newtext);//span 아이디 영역에 경고문자 추가
		$("#join_id").val("").focus();
		return false;
	};
	//입력아이디 유효성 검사
	if(!(validate_userid(memid))){
		var newtext='<font color="red">아이디는 영문소문자,숫자,_ 조합만 가능합니다.</font>';
		$("#idcheck").text('');//문자 초기화
		$("#idcheck").show();//span 아이디 영역을 보이게 한다.
		$("#idcheck").append(newtext);
		$("#join_id").val("").focus();
		return false;
	};
	
	
	//아이디 중복확인
    $.ajax({
        type:"POST",
        /*url:"./jsp/member/member_idcheck.jsp",*/
        url:"idcheck.env",
        data: {"memid":memid},       
        success: function (data) { 
        	alert("return success="+data);
      	  if(data==1){//중복 아이디가 있으면
      		var newtext='<font color="red">중복 아이디입니다.</font>';
      			$("#idcheck").text('');
        		$("#idcheck").show();
        		$("#idcheck").append(newtext);
          		$("#join_id").val('').focus();
          		return false;
	     
      	  }else{//중복아이디가 없으면
      		var newtext='<font color="blue">사용가능한 아이디입니다.</font>';
      		$("#idcheck").text('');
      		$("#idcheck").show();
      		$("#idcheck").append(newtext);
      		$("#mem_pwd").focus();
      	  }  	    	  
        }
        ,
    	  error:function(){
    		  alert("data error");
    	  }
      });//$.ajax	
};
/*아이디 중복 체크 끝*/

function validate_userid(memid)
{
  var pattern= new RegExp(/^[a-z0-9_]+$/);
  //영문 소문자,숫자 ,_가능,정규표현식
  return pattern.test(memid);
};
 
function domain_list() {
	 var num=f.mail_list.selectedIndex;
	/*selectedIndex속성은 select객체하위의 속성으로서 해당리스트 목록번호를 반환
	*/
	if ( num == -1 ) {
	//num==-1은 해당 리스트목록이 없다
	return true;
	 }
	 if(f.mail_list.value=="0") // 직접입력
	 {
	/*리스트에서 직접입력을 선택했을때*/
	 f.join_maildomain.value="";
	//@뒤의 도메인입력란을 빈공간시켜라.
	 f.join_maildomain.readOnly=false;
	//@뒤의 도메인입력란을 쓰기 가능
	f.join_maildomain.focus();
	//도메인입력란으로 입력대기상태
	}
	 
	 else {
	//리스트목록을 선택했을때
	 
	f.join_maildomain.value=f.mail_list.options[num].value;
	/*num변수에는 해당리스트 목록번호가 저장되어있다.해당리스트 번호의 option value값이 도메인입력란에 선택된다.options속성은 select객체의 속성으로서 해당리스트번호의 value값을 가져온다
	*/
	f.join_maildomain.readOnly=true;
	 }
 }

 
 /* 회원정보 수정 경고창 */
function edit_check(){
	if($.trim($("#join_pwd1").val())==""){
		 alert("회원비번을 입력하세요!");
		 $("#join_pwd1").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_pwd2").val())==""){
		 alert("회원비번확인을 입력하세요!");
		 $("#join_pwd2").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_pwd1").val()) != $.trim($("#join_pwd2").val())){
		 //!=같지않다 연산. 비번이 다를 경우
		 alert("비번이 다릅니다!");
		 $("#join_pwd1").val("");
		 $("#join_pwd2").val("");
		 $("#join_pwd1").focus();
		 return false;
	 }
	 if($.trim($("#join_name").val())==""){
		 alert("회원이름을 입력하세요!");
		 $("#join_name").val("").focus();
		 return false;
	 }
	 
	 if($.trim($("#join_phone2").val())==""){
		 alert("휴대전화번호를 입력하세요!");
		 $("#join_phone2").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_phone3").val())==""){
		 alert("휴대전화번호를 입력하세요!");
		 $("#join_phone3").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_mailid").val())==""){
		 alert("메일 아이디를 입력하세요!");
		 $("#join_mailid").val("").focus();
		 return false;
	 }
	 if($.trim($("#join_maildomain").val())==""){
		 alert("메일 주소를 입력하세요!");
		 $("#join_maildomain").val("").focus();
		 return false;
	 }	 	 
}
 
 












 
 
 
 