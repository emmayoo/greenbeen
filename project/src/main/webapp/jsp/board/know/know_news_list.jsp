<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>information</title>
</head>
<body>
<input type="hidden" value="${id}" id="hidden" name="id">

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
		오늘의 뉴스
		새 글:${na}	
		<table class="table table-striped">
			<tr>
				<td>번호</td>
				<td>작성자</td>
				<td>제목</td>
				<td>첨부파일</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
			<c:if test="${empty list}">
				<tr>
					<td colspan="5">데이터가 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty list}">
				<c:set var="no1" value="${no }"></c:set>
				<c:forEach var="board" items="${list }">
					<tr>
						<td>${no1}</td>
						<c:if test="${board.del =='y' }">
							<td colspan="4">삭제된 데이터 입니다</td>
						</c:if>
						<c:if test="${board.del !='y' }">
							<td>${board.writer}</td>
							<td><a href="know_news_view.env?id=know_news_list&pageNum=${pageNum}&num=${board.num}"> 
									${board.subject} 
									<c:if test="${board.readcount > 30 }">
										<img src="img/hot.jpg" height="15px">
									</c:if>
									<c:if test="${today == board.reg_date}">
										<img src="img/new.jpg" height="15px">
									</c:if></a></td>
							<td>${board.attach}</td>
							<c:if test="${today == board.reg_date}">
								<td>${board.reg_date2}</td>
							</c:if>
							<c:if test="${today != board.reg_date}">
								<td>${board.reg_date}</td>
							</c:if>
							<td>${board.readcount}</td>
						</c:if>
					</tr>
					<c:set var="no1" value="${no1 - 1}"></c:set>
				</c:forEach>
			</c:if>
		</table>
		<form action="know_news_list.env?pageNum=1">
			<select name="search">
				<option value="subject"
					<c:if test="${search=='subject'}">selected="selected" </c:if>>제목</option>
				<option value="content"
					<c:if test="${search=='content'}">selected="selected" </c:if>>내용</option>
				<option value="writer"
					<c:if test="${search=='writer'}">selected="selected" </c:if>>작성자</option>
				<option value="subcon"
					<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> 
			<input type="text" name="keyword"> 
			<input type="submit" value="확인">
		</form>
		<ul class="pagination">
			<c:if test="${not empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="know_news_list.env?id=question_list&pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}">[이전]</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}"> class="active" </c:if>>
					<a href="know_news_list.env?id=question_list&pageNum=${i}&search=${search}&keyword=${keyword}">[${i}]</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="know_news_list.env?id=question_list&pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}">[다음]</a></li>
				</c:if>
			</c:if>
			<c:if test="${empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="know_news_list.env?id=question_list&pageNum=${pp.startPage - 1}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}">class="active"</c:if>><a
						href="know_news_list.env?id=question_list&pageNum=${i}">${i}이거다</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="know_news_list.env?id=question_list&pageNum=${pp.endPage + 1}">다음</a></li>
				</c:if>
			</c:if>
		</ul>
 		<c:if test="${position=='master'}">
			<div align="center">
				<a class="btn btn-info know_news_new">질문 입력</a>
			</div>
		</c:if>
</div> <!-- container end -->
</div></div>
</div></div>
<div id="footer">
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>             