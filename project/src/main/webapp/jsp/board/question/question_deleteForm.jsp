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
         	<li role="presentation"><a class="dropdown-item" href="#" id="notice_list" aria-controls="profile" role="tab" data-toggle="tab">공지사항</a></li>
          	<li role="presentation"><a class="dropdown-item"href="#" id="ad_com_list" aria-controls="messages" role="tab" data-toggle="tab">홍보플러스</a></li>
         	<li role="presentation" ><a class="dropdown-item" href="#" id="know_news_list" aria-controls="messages" role="tab" data-toggle="tab">지식플러스</a></li>
         	<li role="presentation" class="active"><a class="dropdown-item" href="#" id="question_list" aria-controls="messages" role="tab" data-toggle="tab">질문있어요</a></li>
         </ul>
	</div>	

<div class="container"> 

		<form action="question_delete.env?id=${id}&num=${board.num}&pageNum=${pageNum}" name="frm" onsubmit="return chk()" method="post">
			<%-- <input type="hidden" name="pageNum" value="${pageNum}">  이거 있으니까 pageNum이 '1,1'로 나온다--%>
			<input type="hidden" name="passwd" value="${board.passwd}"> 
			<%-- <input type="hidden" name="preattach" value="${board.attach}"> delete가 진찌 delete가 아니라 del='y'로 바꾼거라 안필요할듯--%>
			<input type="hidden" name="num" value="${board.num}">
			<table class="table table-striped" align="center" style="width:75%;">
				<tr><td colspan=2><center class="text-primary">게시글 삭제</center></td></tr>
				<tr>
					<td style="width:15%; text-align:center">암호</td>
					<td><input type="password" name="passwd2" required="required"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="확인" class="btn btn-outline-info"></td>
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