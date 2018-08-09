<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 페이지</title>
</head>
<body>

	<jsp:include page="../top.jsp"/>

	<div class="container">
	<h2 class="text-primary">내가 쓴 글(총 ${cnt})</h2>
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
				<c:set var="no1" value="${no}"></c:set>
				<c:forEach var="board" items="${list}">
					<tr>
						<td>${no1}</td>
						<c:if test="${board.del =='y' }">
							<td colspan="4">삭제된 데이터 입니다</td>
						</c:if>
						<c:if test="${board.del !='y' }">
							<td>${board.writer}</td>
							<td><a href="question_view.env?id=question_list&pageNum=${pageNum}&num=${board.num}"> 
									<c:if test="${board.re_level >0 }">
										Reply:
									</c:if> 
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
					<c:set var="no1" value="${no1 - 1}"/>
				</c:forEach>
				</c:if>
				</table>
				
</div> <!-- container end -->
</div></div>
</div></div>
	<div id="footer">
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>