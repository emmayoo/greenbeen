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
         	<li role="presentation" class="active"><a class="dropdown-item" href="#" id="know_news_list" aria-controls="messages" role="tab" data-toggle="tab">지식플러스</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="question_list" aria-controls="messages" role="tab" data-toggle="tab">질문있어요</a></li>
         </ul>
	</div>	

<div class="container"> 

		<form action="know_quiz_modify.env?id=${id}&num=${board.num}&pageNum=${pageNum}" method="post" name="frm"
			onsubmit="return chk()">
			<input type="hidden" name="preattach" value="${board.attach}"> 
			<input type="hidden" name="num" value="${board.num}"> 
			<input type="hidden" name="passwd" value="${board.passwd}">
			<table class="table table-striped" align="center" style="width:75%;">
				<tr><td colspan=4><center class="text-primary">게시글 글수정</center></td></tr>
				<tr>
					<td style="width:40%; text-align:center">번호</td>
					<td colspan=3>${board.num}</td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">제목</td>
					<td colspan=3><input type="text" name="subject" required="required"
						value="${board.subject}" style="width:100%;"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">작성자</td>
					<td colspan=3><input type="text" name="writer" required="required"
						value="${board.writer}"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">이메일</td>
					<td colspan=3><input type="email" name="email" required="required"
						value="${board.email}"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">암호</td>
					<td colspan=3><input type="password" name="passwd2" required="required"></td>
				</tr>
				<tr>
					<td style="width:20%; text-align:center">문제</td>
					<td colspan=3><textarea rows="5" cols="100" name="question" required="required">${board.question}
						</textarea></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">보기1</td>
					<td>1번 <input type="text" name="answer1" required="required" value="${board.answer1}"></td>
					<td>2번 <input type="text" name="answer2" required="required" value="${board.answer2}"></td>
					<td>3번 <input type="text" name="answer3" required="required" value="${board.answer3}"></td>
				</tr>
				<tr>
					<td style="width:40%; text-align:center">보기2</td>
					<td>4번 <input type="text" name="answer4" required="required" value="${board.answer4}"></td>
					<td>5번 <input type="text" name="answer5" required="required" value="${board.answer5}"></td>			
				</tr>
				<tr>
					<td style="width:40%; text-align:center">정답</td>
					<td colspan=3><input type="text" name="answer_correct" required="required" value="${board.answer_correct}"></td>
				</tr>
				
				<tr>
					<td style="width:40%; text-align:center">첨부파일</td>
					<td colspan=3><input type="button" value="파일찾기" onclick="fake()">
						<input type="text" value="${board.attach }" onclick="fake()" id="attach1_text"readOnly>					
						<input type="file" name="attach1" style="display:none" id="attach1" onchange="ch()">
						<input type="button" value="첨부파일 삭제" onclick="attach1_del()">
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center"><input type="submit" value="확인" class="btn btn-outline-info"></td>
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