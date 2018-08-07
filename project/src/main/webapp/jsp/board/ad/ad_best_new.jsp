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

		<h2 class="text-primary">우수기업</h2>
		<form name="frm" action="ad_best_insert.env" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${id}"> 
			<input type="hidden" name="num" value="${num}"> 
			<input type="hidden" name="pageNum" value="${pageNum}">
			<table class="table table-striped" align="center">
				<tr>
					<td>제목</td>
					<td><input type="text" name="subject" required="required"></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="writer" required="required"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" required="required"></td>
				</tr>
				<tr>
					<td>암호</td>
					<td><input type="password" name="passwd" required="required"></td>
				</tr>
				<tr>
					<td>암호 확인</td>
					<td><input type="password" name="passwd2"  required="required"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="5" cols="30" name="content"	required="required"></textarea></td>
				</tr>
				<tr>
					<td>파일첨부</td>
					<td><input type="file" name="attach1"></td> <!-- multipart로 받을 꺼니까 DTO랑 property명 다르게 하기!!! -->
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="확인"></td>
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