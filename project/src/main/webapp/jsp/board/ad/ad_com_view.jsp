<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="hidden" value="${id}" id="hidden">

	<jsp:include page="../../top.jsp"></jsp:include>
	 <div class="tab" role="tabpanel">
         <ul class="nav nav-tabs" role="tablist">
         	<li role="presentation" ><a class="dropdown-item"  href="#" id="files_list" aria-controls="home" role="tab" data-toggle="tab">자료실</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="notice_list" aria-controls="profile" role="tab" data-toggle="tab">공지사항</a></li>
          	<li role="presentation" class="active"><a class="dropdown-item"href="#" id="ad_com_list" aria-controls="messages" role="tab" data-toggle="tab">홍보플러스</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="know_news_list" aria-controls="messages" role="tab" data-toggle="tab">지식플러스</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="question_list" aria-controls="messages" role="tab" data-toggle="tab">질문있어요</a></li>
         </ul>
	</div>	


<div class="container"> 

<!-- 	<div class="container" align="center"> -->
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
				<td>${board.attach}</td>
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
		<a href="javascript:history.go(-1)" class="btn btn-info">목록</a> <!-- 뒤로 가면 list가 안나온다....ㅜㅜㅜㅜㅜ view 하나를 다시 파야할듯 -->
		<c:if test="${position=='master'}">
			<a href="ad_com_modifyForm.env?id=ad_com_list&pageNum=1&num=${board.num}"
			class="btn btn-info">수정</a>
			<a href="ad_com_deleteForm.env?id=ad_com_list&pageNum=1&num=${board.num}"
			class="btn btn-info">삭제</a> 
		</c:if>
		<c:if test="${position=='friend'}">
			<a href="ad_com_replyForm.env?id=ad_com_list&pageNum=1&num=${board.num}"
			class="btn btn-info">답변</a>
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