<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<html>
<meta charset="UTF-8">
<title>연습</title>
<script src="<%=request.getContextPath() %>/js/highlight.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function find(){
		var a = document.getElementById("find_val").value;
	    alert(a);
		if(a==""||a==null){ 
			alert("찾을 값을 입력하세요.");	
			return false;
		}
		location.href="find.env?find_val="+a; //replyBoardcontroller에 있음
	}
	
	 function highlight(text) {
		  var inputText = document.getElementById("content2");
		  var innerHTML = inputText.innerHTML;
		  var index = innerHTML.indexOf(text);
		  while(index>=0){
				  innerHTML = innerHTML.substring(0,index) + "<b class='highlight'>" + innerHTML.substring(index,index+text.length) + "</b>" + innerHTML.substring(index + text.length);
				  index = innerHTML.indexOf(text,(index+25));
				  inputText.innerHTML = innerHTML;
		  }
		} 
</script>
<style>
	.highlight {
 		 background-color: yellow;
	}
</style>
<body onload="highlight('${find_val}')">
<div id="top">
	<jsp:include page="top.jsp"/>
</div>
<div id="content" style="margin-left:30%">

	<b>>>[통합검색]</b><br>
	<h3 style="color:red">"${find_val}" 검색 결과...</h3>
	<input type="text" id="find_val" value="${find_val}" >
    <input type="button" id="find" value='찾기' onclick="return find()">
	<br>
	<div id="content2">
	<!--회사검색 -->
	<c:if test="${not empty com_list}" >
		<h4>회사 검색 (총 ${com_cnt}개) <c:if test="${com_cnt>10}"><input type="button" value="더보기"></c:if></h4>
		<c:forEach var="com" items="${com_list}" begin='0' end='9'>
			${com.com_name}<br>
		</c:forEach>
	</c:if>
	
	<!--자료실 -->
	<c:if test="${not empty files_list}" >
		<h4>자료실 (총 ${files_cnt}개) <c:if test="${files_cnt>10}"><input type="button" value="더보기"></c:if></h4>
		<c:forEach var="files" items="${files_list}" begin='0' end='9'>
			${files.subject}<br>
		</c:forEach>
	</c:if>
	
	<!--공지사항 -->
	<c:if test="${not empty notice_list}" >
		<h4>공지사항 (총 ${notice_cnt}개) <c:if test="${notice_cnt>10}"><input type="button" value="더보기"></c:if></h4>
		<c:forEach var="notice" items="${notice_list}" begin='0' end='9'>
			${notice.subject}<br>
		</c:forEach>
	</c:if>
	
	<!--회사 홍보 -->
	<c:if test="${not empty ad_list}">
		<h4>회사홍보 (총 ${ad_cnt}개) <c:if test="${ad_cnt>10}"><input type="button" value="더보기"></c:if></h4>
		<c:forEach var="ad" items="${ad_list}" begin='0' end='9'>
			${ad.subject}<br>
		</c:forEach>
	</c:if>
	
	<!--오늘의 뉴스 -->
	<c:if test="${not empty news_list}">
		<h4>오늘의 뉴스 (총 ${news_cnt}개) <c:if test="${news_cnt>10}"><input type="button" value="더보기"></c:if></h4>
		<c:forEach var="news" items="${news_list}" begin='0' end='9'>
			${news.subject}<br>
		</c:forEach>
	</c:if>
	
		
	<!--질문있어요 -->
	<c:if test="${not empty q_list}">
		<h4>질문 있어요 (총 ${q_cnt}개) <c:if test="${q_cnt>10}"><input type="button" value="더보기"></c:if></h4>
		<c:forEach var="question" items="${q_list}" begin='0' end='9'>
			${question.subject}<br>
		</c:forEach>
	</c:if>
	</div><!-- div content2 end -->
	<c:if test="${empty com_list && empty q_list && empty news_list && empty ad_list && empty notice_list && empty files_list}">
		<h2> 검색 결과가 없습니다 </h2> 
	</c:if>
</div>	
<div id="footer">
	<jsp:include page="footer.jsp"/>
 </div>  
</body>
</html>