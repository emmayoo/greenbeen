<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 페이지</title>
</head>
<body>

		<jsp:include page="../top.jsp"/>

	<div class="container">
	<h2 class="text-primary">내 페이지</h2>
		<table align=center>
		    <tr>
     			<th>*나의 씨앗*</th>
     			<td>${member.point}</td>
   	 		</tr>
			<tr>
     			<th>아이디</th>
     			<td>${member.join_id}</td>
   	 		</tr>
    		<tr>
				<th>이름</th>
     			<td>${member.join_name}</td>
    		</tr>
  	    	<tr>
     			<th>연락처</th>
     			<td>${member.join_phone}</td>
    		</tr>
    		<tr>
    			<th>이메일</th>
     			<td>${member.join_email}</td>
    		</tr>
    		<tr>
     			<th>가입일</th>
     			<td>${member.join_regdate}</td>
   	 		</tr>
   	 		<tr>
     			<th>수정일</th>
     			<td>${member.join_deldate}</td>
   	 		</tr>
   	 		<tr>
     			<th>나는 </th>
     			<td>${member.position}입니다.</td>
   	 		</tr>
   	 		<tr>
   	 			<th colspan=2>
   	 				<a href="Iwrote.env?join_id=${member.join_id}"
					class="btn btn-danger">내가 쓴 글보기</a> 
					<a href="member_edit.env?join_id=${member.join_id}"
					class="btn btn-info">수정</a> 
					<a href="member_del.env?join_id=${member.join_id}"
					class="btn btn-info">삭제</a> 
				</th>
			</tr>
		</table>
</div> <!-- container end -->
</div></div>
</div></div>
	<div id="footer">
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>