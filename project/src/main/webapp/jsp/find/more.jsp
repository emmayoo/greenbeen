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
	 
	 function addr(name){
		 var a =name.indexOf("<b");
		 var b =name.indexOf(">");
		 var c =name.indexOf("</");
		 var d =name.indexOf("b>")+1;
		 alert("<="+a+"/ >="+b+"<="+c+"/ >="+d)
		 var com_name=name.substring(0,a)+name.substring((b+1),c)+name.substring((d+1));
		 alert(com_name);
		 return com_name;
	 }
	 
	 function com_name(e){
		 var i = e.target.tagName;
		 if(i=='A') var name=e.target.innerHTML;
		 if(i=='B') var name=e.target.parentNode.innerHTML;
		 alert(name);
		 //var a =name.indexOf("<");
		 //var b =name.indexOf(">");
		 //var c =name.indexOf("<",(a+1));
		 //var d =name.indexOf(">",(b+1));
		  var com_name = addr(name);
		  var index = com_name.indexOf("highlight");
		  if(index>=0) com_name = addr(com_name);
		 location.href="company_view.env?com_name="+com_name;
	 }
</script>
<style>
	.highlight {
 		 background-color: yellow;
	}
</style>
<body onload="highlight('${find_val}')">
<div id="top">
	<jsp:include page="../top.jsp"/>
</div>
<div id="content" style="margin-left:30%">

	<b>>>[통합검색]>>회사 검색</b><br>
	<h3 style="color:red">"${find_val}" 검색 결과...</h3>
	<%-- <input type="text" id="find_val" value="${find_val}" >
    <input type="button" id="find" value='찾기' onclick="return find()"> --%>
	<br>
	<div id="content2">
	<table class="table table-striped">
	<tr>
		<td>회사 이름</td>
		<td>주소</td>
	<!--회사검색 -->
	<c:if test="${not empty com_list}" >
		<h4>회사 검색 (총 ${com_cnt}개) </h4>
		<c:forEach var="com" items="${list1}">
			<a onclick="com_name(event)" href="#">${com.com_name}</a><br>
		</c:forEach>
	</c:if>

	
	<!--자료실 -->
	<c:if test="${not empty files_list}" >
		<h4>자료실 (총 ${files_cnt}개)</h4>
		<c:forEach var="files" items="${list2}">
			<a href="files_view.env?id=files_list&num=${files.num}">${files.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--공지사항 -->
	<c:if test="${not empty notice_list}" >
		<h4>공지사항 (총 ${notice_cnt}개)</h4>
		<c:forEach var="notice" items="${list3}" >
			<a href="notice_view.env?id=notice_list&num=${notice.num}">${notice.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--회사 홍보 -->
	<c:if test="${not empty ad_list}">
		<h4>회사홍보 (총 ${ad_cnt}개)</h4>
		<c:forEach var="ad" items="${list4}">
			<a href="ad_com_view.env?id=ad_com_list&num=${ad.num}">${ad.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--오늘의 뉴스 -->
	<c:if test="${not empty news_list}">
		<h4>오늘의 뉴스 (총 ${news_cnt}개)</h4>
		<c:forEach var="news" items="${list5}">
			<a href="know_news_view.env?id=know_news_list&num=${news.num}">${news.subject}</a><br>
		</c:forEach>
	</c:if>
	
		
	<!--질문있어요 -->
	<c:if test="${not empty q_list}">
		<h4>질문 있어요 (총 ${q_cnt}개)</h4>
		<c:forEach var="question" items="${list6}">
			<a href="question_view.env?id=question_list&num=${question.num}">${question.subject}</a><br>
		</c:forEach>
	</c:if>
	</table>
	</div>
</div>		
<div id="footer">
	<jsp:include page="../footer.jsp"/>
 </div>  
</body>
</html>