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
		 alert("com_name="+com_name);
		 return com_name;
	 }
	 
	 function board_view(e){
		 var i = e.target.tagName;
		 if(i=='A') {var name=e.target.target; var id =e.target.id;}
		 if(i=='B') {var name=e.target.parentNode.target;var id =e.target.parentNode.id;}
		 var num = addr('#'+name); //왜인지 모르겠는데 하나 짤리네..
		 if(id=="files_view")
			 	location.href="files_view.env?id=files_list&num="+num;
		 if(id=="notice_view")
			 	location.href="notice_view.env?id=notice_list&num="+num;
		 if(id=="ad_com_view")
			 	location.href="ad_com_view.env?id=ad_com_list&num="+num;
		 if(id=="know_news_view")
			 	location.href="know_news_view.env?id=know_news_list&num="+num;
		 if(id=="question_view")
			 	location.href="question_view.env?id=question_list&num="+num;
	 }
	 
	 function com_name(e){
		 var i = e.target.tagName;
		 if(i=='A') var name=e.target.innerHTML;
		 if(i=='B') var name=e.target.parentNode.innerHTML;
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
	<c:if test="${not empty list1}">
		<b>>>[통합검색]>>회사 검색</b><br>
	</c:if>
	<c:if test="${not empty list2}">
		<b>>>[통합검색]>>자료실</b><br>
	</c:if>
	<c:if test="${not empty list3}">
		<b>>>[통합검색]>>공지사항</b><br>
	</c:if>
	<c:if test="${not empty list4}">
		<b>>>[통합검색]>>회사홍보</b><br>
	</c:if>
	<c:if test="${not empty list5}">
		<b>>>[통합검색]>>오늘의 뉴스</b><br>
	</c:if>
	<c:if test="${not empty list6}">
		<b>>>[통합검색]>>질문있어요</b><br>
	</c:if>



	<h3 style="color:red">"${find_val}" 검색 결과...</h3>
	<%-- <input type="text" id="find_val" value="${find_val}" >
    <input type="button" id="find" value='찾기' onclick="return find()"> --%>
	<br>
	<div id="content2">
	<table class="table table-striped">
	<!--회사검색 -->
	<c:if test="${not empty list1}" >
		<h4>회사 검색 (총 ${com_cnt}개) </h4>
		<tr>
			<td>회사 이름</td>
		</tr>
		<c:forEach var="com" items="${list1}">
			<tr><td><a onclick="com_name(event)" href="#" id="com">${com.com_name}</a><br></td></tr>
		</c:forEach>
	</c:if>

	
	<!--자료실 -->
	<c:if test="${not empty list2}" >
		<h4>자료실 (총 ${files_cnt}개)</h4>
		<c:forEach var="files" items="${list2}">
			<a onclick="board_view(event)" target="${files.num}" id="files_view">${files.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--공지사항 -->
	<c:if test="${not empty list3}" >
		<h4>공지사항 (총 ${notice_cnt}개)</h4>
		<c:forEach var="notice" items="${list3}" >
			<a onclick="board_view(event)" target="${notice.num}" id="notice_view">${notice.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--회사 홍보 -->
	<c:if test="${not empty list4}">
		<h4>회사홍보 (총 ${ad_cnt}개)</h4>
		<c:forEach var="ad" items="${list4}">
			<a onclick="board_view(event)" target="${ad.num}" id="ad_com_view">${ad.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--오늘의 뉴스 -->
	<c:if test="${not empty list5}">
		<h4>오늘의 뉴스 (총 ${news_cnt}개)</h4>
		<c:forEach var="news" items="${list5}">
			<a onclick="board_view(event)" target="${news.num}" id="know_news_view">${news.subject}</a><br>
		</c:forEach>
	</c:if>
	
		
	<!--질문있어요 -->
	<c:if test="${not empty list6}">
		<h4>질문 있어요 (총 ${q_cnt}개)</h4>
		<c:forEach var="question" items="${list6}">
			<a onclick="board_view(event)" target="${question.num}" id="question_view">${question.subject}</a><br>
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