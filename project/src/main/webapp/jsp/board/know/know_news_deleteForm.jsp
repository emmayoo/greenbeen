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

<div class="container"> 

		<h2 class="text-primary">게시글 삭제</h2>
		<form action="know_news_delete.env?id=${id}&num=${board.num}&pageNum=${pageNum}" name="frm" onsubmit="return chk()" method="post">
			<input type="hidden" name="pageNum" value="${pageNum}"> 
			<input type="hidden" name="passwd" value="${board.passwd}"> 
			<input type="hidden" name="num" value="${board.num}">
			<table class="table">
				<tr>
					<td>암호</td>
					<td><input type="password" name="passwd2" required="required"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="확인"></td>
				</tr>
			</table>
		</form>
</div> <!-- container end -->
</div></div>
</div></div>
<div id="footer">
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>	
</body>
</html>