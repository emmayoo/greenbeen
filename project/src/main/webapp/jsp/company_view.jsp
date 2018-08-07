<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>company_view</title>
</head>
<body>
	<div id="top">
		<jsp:include page="top.jsp"/>
	</div>
	<div id="content">
	</div>
	<h2>${com_name}</h2>
	<c:forEach items="${company}" var="co">
	년도: ${co.com_year}<br>
	용수: ${co.com_water}<br>
	</c:forEach>
	</div>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div> 
</body>
</html>