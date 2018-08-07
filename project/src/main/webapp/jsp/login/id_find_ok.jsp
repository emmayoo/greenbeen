<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function(){
		var i = $('#text').val();
		$('#close1').click(function(){ 
			opener.$('#id').val("").focus();
			window.close(); //열려 있는 창 닫기
		});
		
		$('#close2').click(function(){
			opener.$('#id').val(i).focus();
			window.close();
		});
	});
</script>
<body>
		<input type="hidden" value="${result}" id="text">
		아이디는 ${result}입니다.
		<br>
		<input type=button value="닫기" id="close1">
		<input type=button value="사용하기" id="close2">
</body>
