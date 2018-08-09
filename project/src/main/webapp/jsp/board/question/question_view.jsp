<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
<script>
$(function(){
	//question_view (reply)
	$('#slist').load('question_slist.env?num=${board.num}') 
	//$('#list').load('question_list.env?pageNum=${pageNum}');
	
	$('#repInsert').click(function() {
		var id = $('#id').val();
		if (!frm.replytext.value) {
			alert('댓글 입력후에 클릭하시오');
			frm.replytext.focus();
			return false;
		}
		var frmData = $('form').serialize();
		// var frmData = 'replyer='+frm.replyer.value+'&bno='+
		//				  frm.bno.value+'&replytext='+frm.replytext.value;	
		if(id=="n"){
			$('#id').val("n1");
			location.href="logincheck.env";
			//location.href="question_sInsert.env?"+frmData;
			frm.replytext.value ="";
		}else{
			$.post('question_sInsert.env', frmData, function(data) {
				$('#slist').html(data);
				frm.replytext.value ="";
			});			
		} 
	});
});
</script>
</head>
<body>
<c:if test="${sessionScope.id == null}">
	<input type="hidden" value="n" id="id">
</c:if>
<c:if test="${sessionScope.id !=null}">
	<input type="hidden" value="${sessionScope.id}" id="id">
</c:if>

	<jsp:include page="../../top.jsp"></jsp:include>
	
					<div class="tab" role="tabpanel">
         <ul class="nav nav-tabs" role="tablist">
         	<li role="presentation"><a class="dropdown-item"  href="#" id="files_list" aria-controls="home" role="tab" data-toggle="tab">자료실</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="notice_list" aria-controls="profile" role="tab" data-toggle="tab">공지사항</a></li>
          	<li role="presentation"><a class="dropdown-item"href="#" id="ad_com_list" aria-controls="messages" role="tab" data-toggle="tab">홍보플러스</a></li>
         	<li role="presentation" ><a class="dropdown-item" href="#" id="know_news_list" aria-controls="messages" role="tab" data-toggle="tab">지식플러스</a></li>
         	<li role="presentation" class="active"><a class="dropdown-item" href="#" id="question_list" aria-controls="messages" role="tab" data-toggle="tab">질문있어요</a></li>
         </ul>
	</div>	
	

<div class="container"> 

			
	<!-- <div class="container" align="center"> -->
		<h2 class="text-primary">게시글 상세정보</h2>
		<table class="table table-bordered">
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
				<td>내용</td>
				<td><pre>${board.content}</pre></td>
			</tr>
		</table>
		
		<a href="javascript:history.go(-1)" class="btn btn-info">목록</a>
		<c:if test="${board.writer == sessionScope.id ||position == 'master'}">
			<a href="question_modifyForm.env?id=question_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">수정</a> 
			<a href="question_deleteForm.env?id=question_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">삭제</a>
		</c:if> 
			<a href="question_replyForm.env?id=question_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">답변</a>
		<p>
		<div id="slist"></div>
		<form name="frm" id="frm">
			<input type="hidden" name="replyer" value="${board.writer}">
			<input type="hidden" name="bno" value="${board.num}"> 댓글 :
			<textarea rows="3" cols="50" name="replytext"></textarea>
			<input type="button" value="확인" id="repInsert">
		</form>
		<div id="list"></div>
</div> <!-- container end -->
</div></div>
</div></div> 
<div id="footer">
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>