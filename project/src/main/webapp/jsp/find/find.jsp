<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<html>
<meta charset="UTF-8">
<title>연습</title>
<script src="<%=request.getContextPath() %>/js/highlight.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function find2(){
		var a = document.getElementById("find_val").value;
	    alert("a="+a);
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
	 
	 function com_name(e){
		 var i = e.target.tagName;
		 if(i=='A') var name=e.target.innerHTML;
		 if(i=='B') var name=e.target.parentNode.innerHTML;
		 //var a =name.indexOf("<");
		 //var b =name.indexOf(">");
		 //var c =name.indexOf("<",(a+1));
		 //var d =name.indexOf(">",(b+1));
		 var com_name = addr(name);
		 var index = com_name.indexOf("highlight");
		 if(index>=0) com_name = addr(com_name);
	  	 location.href="company_view.env?com_name="+com_name;
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
	 
	 function more(e){
		 var more = e.target.id;
		 var find_val = " "+document.getElementById('find_val').value;
		 alert("find_val1="+find_val);
		 find_val = addr(find_val);
		 var index = find_val.indexOf("highlight");
		 if(index>=0) find_val = addr(find_val);
		 alert("find_val2="+find_val);
		 location.href="find.env?find_val="+find_val+"&more="+more;
	 }
	// function pre(e){e.target.previousElementSibling.click(); }
</script>
<style>
	.highlight {
 		 background-color: yellow;
	}
</style>
<body onload="highlight('${find_val}');">
<div id="top">
	<jsp:include page="../top.jsp"/>
</div>
<div id="content" style="margin-left:30%">

	<b>>>[통합검색]</b><br>
	<h3 style="color:red">"${find_val}" 검색 결과...</h3>
	<input type="text" id="find_val" placeholder="${find_val}" onkeydown="javascript:if(event.keyCode==13){return find2();}">
    <input type="button" id="find" value='찾기' onclick="return find2()">
	<br>
	<div id="content2">
	
	<!--회사검색 -->
	<c:if test="${not empty com_list}" >
		<h4>회사 검색 (총 ${com_cnt}개) <c:if test="${com_cnt>5}"><a onclick="more(event)" id="com">더보기</a></c:if></h4>
		<c:forEach var="com" items="${com_list}" begin='0' end='4'>
		
				<a onclick="com_name(event)" href="#" id="com_view">${com}</a>&nbsp;&nbsp;
				<a href="#" onclick="javascript:event.target.previousElementSibling.click();" id="d">${com_addr.get(com)}</a><br>
		</c:forEach>
	</c:if>
	<!--자료실 -->
	<c:if test="${not empty files_list}" >
		<h4>자료실 (총 ${files_cnt}개) <c:if test="${files_cnt>5}"><a onclick="more(event)" id="files">더보기</a></c:if></h4>
		<c:forEach var="files" items="${files_list}" begin='0' end='4'>
			<a onclick="board_view(event)" target="${files.num}" id="files_view">${files.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--공지사항 -->
	<c:if test="${not empty notice_list}" >
		<h4>공지사항 (총 ${notice_cnt}개) <c:if test="${notice_cnt>5}"><a onclick="more(event)" id="notice">더보기</a></c:if></h4>
		<c:forEach var="notice" items="${notice_list}" begin='0' end='4'>
			<a onclick="board_view(event)" target="${notice.num}" id="notice_view">${notice.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--회사 홍보 -->
	<c:if test="${not empty ad_list}">
		<h4>회사홍보 (총 ${ad_cnt}개) <c:if test="${ad_cnt>5}"><a onclick="more(event)" id="ad">더보기</a></c:if></h4>
		<c:forEach var="ad" items="${ad_list}" begin='0' end='4'>
			<a onclick="board_view(event)" target="${ad.num}" id="ad_com_view">${ad.subject}</a><br>
		</c:forEach>
	</c:if>
	
	<!--오늘의 뉴스 -->
	<c:if test="${not empty news_list}">
		<h4>오늘의 뉴스 (총 ${news_cnt}개) <c:if test="${news_cnt>5}"><a onclick="more(event)" id="news">더보기</a></c:if></h4>
		<c:forEach var="news" items="${news_list}" begin='0' end='4'>
			<a onclick="board_view(event)" target="${news.num}" id="know_news_view">${news.subject}</a><br>
		</c:forEach>
	</c:if>
	
		
	<!--질문있어요 -->
	<c:if test="${not empty q_list}">
		<h4>질문 있어요 (총 ${q_cnt}개) <c:if test="${q_cnt>5}"><a onclick="more(event)" id="question">더보기</a></c:if></h4>
		<c:forEach var="question" items="${q_list}" begin='0' end='4'>
			<a onclick="board_view(event)" target="${question.num}" id="question_view">${question.subject}</a>
			| ${question.writer} | ${question.reg_date} |${question.content2}
			<br>
		</c:forEach>
	</c:if>
	</div><!-- div content2 end -->
	<c:if test="${empty com_list && empty q_list && empty news_list && empty ad_list && empty notice_list && empty files_list}">
		<h2> 검색 결과가 없습니다 </h2> 
	</c:if>
</div>	
<div id="footer">
	<jsp:include page="../footer.jsp"/>
 </div>  
</body>
</html>