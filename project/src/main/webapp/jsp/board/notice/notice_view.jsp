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
         	<li role="presentation"><a class="dropdown-item"  href="#" id="files_list" aria-controls="home" role="tab" data-toggle="tab">자료실</a></li>
         	<li role="presentation" class="active"><a class="dropdown-item" href="#" id="notice_list" aria-controls="profile" role="tab" data-toggle="tab">공지사항</a></li>
          	<li role="presentation"><a class="dropdown-item"href="#" id="ad_com_list" aria-controls="messages" role="tab" data-toggle="tab">홍보플러스</a></li>
         	<li role="presentation" ><a class="dropdown-item" href="#" id="know_news_list" aria-controls="messages" role="tab" data-toggle="tab">지식플러스</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="question_list" aria-controls="messages" role="tab" data-toggle="tab">질문있어요</a></li>
         </ul>
	</div>	

<div class="container"> 

<!-- 	<div class="container" align="center"> -->
		
		<table class="table table-bordered" style="width:75%;" align=center>
			<tr >
				<td colspan=2 style="text-align:center"><b>${board.subject}</b></td>
			</tr>
			<tr >
				<td colspan=2 >${board.writer} (${board.email})</td>
			</tr>
			<tr>
				<td><span style="color:grey">작성일:</span> ${board.reg_date} &nbsp&nbsp&nbsp
				<span style="color:grey">조회: </span>${board.readcount}</td>
			</tr>
			<c:if test="${board.attach != null}">
			<tr>
				<td colspan=2><a href="download.env?fname=${board.attach}">${board.attach}</a></td>
			</tr>
			</c:if>
			<tr >
				<td colspan=2 ><pre>${board.content}</pre></td>
			</tr>
		</table>
		
		<div align=center>
		
		<a href="javascript:history.go(-1)" class="btn btn-info">목록</a> <!-- 뒤로 가면 list가 안나온다....ㅜㅜㅜㅜㅜ view 하나를 다시 파야할듯 -->
		<c:if test="${position=='master'}">
			<a href="notice_modifyForm.env?id=notice_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">수정</a> 
			<a href="notice_deleteForm.env?id=notice_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">삭제</a> 
		</c:if>
		<c:if test="${position=='friend'}">
			<a href="notice_replyForm.env?id=notice_list&pageNum=${pageNum}&num=${board.num}"
			class="btn btn-info">답변</a>
		</c:if></div>
		<p>
</div> <!-- container end -->
</div></div>
</div></div>
<div id="footer">
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>