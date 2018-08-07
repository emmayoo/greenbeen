<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
$(function(){
	
	$('#check').click(function(){
		var mychoice = $('[name="choice"]:checked').val();
		if(mychoice== ${board.answer_correct}){
			alert("정답입니다! 씨앗 10개를 획득 하셨습니다. My Page로 가서 확인하세요~")
			
		}else{
			alert("오답입니다. 내일 또 도전해주세요!")
		}
	});
	
	
});

</script>

</head>
<body>

	<input type="hidden" value="${id}" id="hidden">
		
	<jsp:include page="../../top.jsp"></jsp:include>
	
			<div class="tab" role="tabpanel">
         <ul class="nav nav-tabs" role="tablist">
         	<li role="presentation"><a class="dropdown-item"  href="#" id="files_list" aria-controls="home" role="tab" data-toggle="tab">자료실</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="notice_list" aria-controls="profile" role="tab" data-toggle="tab">공지사항</a></li>
          	<li role="presentation"><a class="dropdown-item"href="#" id="ad_com_list" aria-controls="messages" role="tab" data-toggle="tab">홍보플러스</a></li>
         	<li role="presentation" class="active"><a class="dropdown-item" href="#" id="know_news_list" aria-controls="messages" role="tab" data-toggle="tab">지식플러스</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="question_list" aria-controls="messages" role="tab" data-toggle="tab">질문있어요</a></li>
         </ul>
	</div>	

<div class="container"> 
	<form name="frm" action="know_quiz_solve.env" method="post">
		<input type="hidden" name=pageNum value="${pageNum }">
		<input type="hidden" name=num value="${board.num }">
		<h2 class="text-primary">오늘의 퀴즈</h2>
		<table class="table table-bordered">
			<tr>
				<td>날짜</td>
				<td>${board.reg_date}</td>
			</tr>	
			<tr>
				<td>제목</td>
				<td>${board.subject}</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${board.writer}</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${board.readcount}</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td><a href="download.env?fname=${board.attach}">${board.attach}</a></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${board.email}</td>
			</tr>
			<tr>
				<td>문제</td>
				<td><pre>${board.question}</pre></td>
			</tr>
			<tr>
				<td>보기: ${ board.answer_correct }</td>
				<td>
					<label><input type="radio" name=choice  value="${ board.answer1 }"> 1. ${ board.answer1 }</label><br />
					<label><input type="radio" name=choice  value="${ board.answer2 }"> 2. ${ board.answer2 }</label><br />
					<label><input type="radio" name=choice  value="${ board.answer3 }"> 3. ${ board.answer3 }</label><br />
					<label><input type="radio" name=choice  value="${ board.answer4 }"> 4. ${ board.answer4 }</label><br />
					<label><input type="radio" name=choice  value="${ board.answer5 }"> 5. ${ board.answer5 }</label><br />
					<input type="hidden" name=answer_correct value="${board.answer_correct }">
				</td>				
			</tr>
			<tr>
				<td colspan=2>
					<input type="submit" id="check" value="확인"> &nbsp; &nbsp;
					<input type="reset" value="취소" >
				</td>
			</tr>
		</table>

		
		<a href="javascript:history.go(-1)" class="btn btn-info">목록</a> <!-- 뒤로 가면 list가 안나온다....ㅜㅜㅜㅜㅜ view 하나를 다시 파야할듯 -->
		<c:if test="${position=='master'}">		
			<a href="know_quiz_modifyForm.env?id=know_quiz_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">수정</a> 
			<a href="know_quiz_deleteForm.env?id=know_quiz_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">삭제</a>
		</c:if>
		<c:if test="${position=='friend'}">
			<a href="know_quiz_replyForm.env?id=know_quiz_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">신고하기</a>
		</c:if>
		<p>
</div> <!-- container end -->
</div></div>
</div></div>
<div id="footer">
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>