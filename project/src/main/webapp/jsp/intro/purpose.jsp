<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>purpose</title>
</head>
<body>
	<input type="hidden" value="${id}" id="hidden">

		<jsp:include page="../top.jsp"></jsp:include>
		
						<div class="tab" role="tabpanel">
         <ul class="nav nav-tabs" role="tablist">
         	<li role="presentation"><a class="dropdown-item"  href="#" id="summary" aria-controls="home" role="tab" data-toggle="tab">개요</a></li>
         	<li role="presentation"  class="active"><a class="dropdown-item" href="#" id="purpose" aria-controls="profile" role="tab" data-toggle="tab">목적</a></li>
          	<li role="presentation" ><a class="dropdown-item"href="#" id="procedure" aria-controls="messages" role="tab" data-toggle="tab">조사 및 공개절차</a></li>
         	<li role="presentation"><a class="dropdown-item" href="#" id="information" aria-controls="messages" role="tab" data-toggle="tab">공개대상 정보</a></li>
         </ul>
	</div>	

	<div class="container">
목적
</div> <!-- container end -->
</div></div>
</div></div>
	<div id="footer">
		<jsp:include page="../footer.jsp"/>
 	</div> 
</body>
</html>