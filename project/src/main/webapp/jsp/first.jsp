<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
#header {	
			text-align: center; 
			height:120px;
			background-color:white;
			padding: 10px;
			overflow: hidden;
		}
		
#logo{ width :399px;
	   height :96px;
	   margin-right : 40px
	   	
}
#article {
			width: 1000px;
			height: auto;
			margin :0px;
			padding: 0px;
			border: 1px dotted #333;
			border-radius: 10px;
			align:center;
		}
nav ul {
	list-style-type:none;
	margin-top:100px;
	margin-bottom:100px;
	float: center;
	}
	
nav ul li {
			display:inline;
			padding:0px;
			margin-left:90px;
		  }
		  
#i1:hover{transform:scale(1.2);}
#i2:hover{transform:scale(1.2);}
#i3:hover{transform:scale(1.2);} 
#footer {
			padding: 10px;
		/* 	background-color: #333; */
			color: 000000;
			text-align: center;
			
		}
</style>

</head>
<body>
<header id=header >
<img src="img/logo.gif" id=logo>
</header>

<div id=alticle>
<form method="post" action="insert.do" >

 <nav>
    <ul>
      <li><a href="part.env"><img src="img/제조업.jpg" width=18% height=30% id=i1></a></li>
      <li><a href="area.env"><img src="img/지역별.jpg" width=18% height=30% id=i2></a></li>
      <li><a href="object.env"><img src="img/object.jpg" width=18% height=30% id=i3></a></li>
      <li><a href="main.env"><img src="img/seoul.jpg" width=18% height=30% id=i4></a></li>
     </ul>
 </nav> 

</form>
</div>


<div id="footer">
	<jsp:include page="footer.jsp"/>
</div>


</body>


</html>