<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<head>  
  <title>header</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script> 

 
  <!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
  
  <script src="${path}/js/arealist.js"></script>
  <script src="${path}/js/objlist.js"></script>
  <script src="${path}/js/partlist.js"></script>
  <script src="${path}/js/board.js"></script>
  <%-- <script src="<c:url value="/js/board.js" />"></script> --%>
 
 <!--  
 <script src="https://www.gstatic.com/charts/loader.js"></script>
   
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>  

  <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.9/semantic.min.js"></script>
 -->
</head>