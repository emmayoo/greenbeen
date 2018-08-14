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

		<form action="question_insert.env?id=${id}&num=${board.num}&pageNum=${pageNum}" method="post" name="frm"
			onsubmit="return chk()" enctype="multipart/form-data">
			<input type="hidden" name="num" value="${board.num}"> 
			<input type="hidden" name="preattach" value="${board.attach}"> 
			<input type="hidden" name="id" value="${id}"> 
			<input type="hidden" name="ref" value="${ref}"> 
			<input type="hidden" name="re_step" value="${re_step}"> 
			<input type="hidden" name="re_level" value="${re_level}"> 
			<input type="hidden" name="pageNum" value="${pageNum}">
		<table class="table table-striped" align="center" style="width:75%;">
				<tr><td colspan=2><center class="text-primary">답글</center></td></tr>
				<tr>
					<td style="width:40%; text-align:center">제목</td>
					<td><input type="text" name="subject" required="required"
						value="re:${board.subject}" style="width:100%;"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">작성자</td>
					<td>${jb.join_id}
						<input type="hidden" name="writer" required="required"
						value="${jb.join_id}"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">이메일</td>
					<td><input type="text" name="email" required="required"
						value="${jb.join_email}"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">암호</td>
					<td><input type="password" name="passwd" required="required"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">암호 확인</td>
					<td><input type="password" name="passwd2" required="required"></td>
				</tr>
				<tr>
					<td style="width:20%; text-align:center">내용</td>
					<td><textarea rows="5" cols="100" name="content" required="required">
							</textarea>
						</td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">첨부파일</td>
					<td><input type="file" name="attach1" id="attach1">
					</td>
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