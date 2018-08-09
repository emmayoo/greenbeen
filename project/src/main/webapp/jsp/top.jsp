<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>top</title>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
	
<style>

body {
	position: relative;
	overflow-x: hidden;
}

body, html {
	height: 100%;
}

#wrapper.toggled {
	padding-left: 220px;
}

/*열렸을 경우 박스 */
#sidebar-wrapper {
	z-index: 1000;
	left: 200px;
	width: 0;
	height: 100%;
	margin-left: -220px;
	padding-top:0;
	overflow-y: auto;
	overflow-x: hidden;
	background: #E4F7BA;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
	
}

#wrapper.toggled #sidebar-wrapper {
	width: 240px;
}

#page-content-wrapper {
	width: 100%;
	padding-top: 70px;
	background-color: white;
	margin-top:0;
	
}

#wrapper.toggled #page-content-wrapper {
	/* position: absolute; */
	margin-right: -220px;
}

.sidebar-nav  {
	display: block;
	color: #0f4723;
	text-decoration: none;
	position: absolute;
    top: 110px;
}

/* 펼쳤을 경우 나오는 글자 색깔*/
.sidebar-nav li a {
	display: block;
	color: #138200;
	text-decoration: none;
	padding: 8px 40px 8px 50px; 
	margin-top: 0;
}

/* hoover 할때 바뀌는 색깔 */
.sidebar-nav li a:hover, .sidebar-nav li a:active, .sidebar-nav li a:focus,
	.sidebar-nav li.open a:hover, .sidebar-nav li.open a:active,
	.sidebar-nav li.open a:focus {
	color: #138200;
	text-decoration: none;
	background-color: transparent;
}

/*로고 이름*/
 .sidebar-nav>.sidebar-brand {
	/* height: 65px; */
	/* line-height: 44px; */
	margin-bottom:10px;
	margin-top:100px;
} 

#page-content-wrapper {
	transition: margin-left .5s;
	padding: 16px;
	background-color: white;
	height: 170px;
}

.dropdown-container {
	display: none;
	background-color: #CEF279;  
	padding-left: 8px;
}

/*메뉴 각각의 색 설정 */
#summary:hover, #purpose:hover, #procedure:hover, #information:hover { background-color: yellow; }

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">

.dropdown-btn {
	padding: 6px 8px 6px 16px;
	text-decoration: none;
	font-size: 15px;
	color: green;
	display: block;
	border: none;
	background: none; 
	width: 100%;
	text-align: left;
	cursor: pointer;
	outline: none;
	/* background-color:pink; */
}

#logo {
	width: 500px; 
	position: absolute;
	top: 85px; 
	left:50%; 
/* 	position: relative;
	top: 70px;
	left:45%;  */
	transform: translate(-50%, -50%);
	
	
}

#toplogo{
	position:absolute;
	top:30px;
	left:55px;
	bottom:5px;	
}

.topmenu * {
	display: inline;
	text-decoration: none;
}

#menubar {
	display: flex;
	justify-content: center;
	align-center: center;
}

#topnav {
	clear: both;
	width: 100%;
	height: 100%;
}  

ul.topmenu_right li {
	float: right;
	margin-right: 15px;
}

ul.topmenu_left li {
	float:left;
	margin-left: 15px;
}

.container{
	margin-top:50px;
/* //	background-color:red; */
}

#selectmenu {
	margin-bottom: 40px;
	margin-top: 25px;
	width: 100%;
}

.form-control {
	min-height:45px;
}

 a:hover,a:focus{
    outline: none;
    text-decoration: none;
}
.tab .nav-tabs{
	list-style-type:none;
    border-bottom: 5px;
	float:left;
	margin:0;
	position:relative;
	left:44%;
		
	/* //transform: translate(-50%, -50%); */
}
.tab .nav-tabs ul li{
	display:block;
    /* margin-right: 30px;
     */
     float:left;
     margin:0;
     padding:0;
     position:relative;
     right:44%;
}
.tab .nav-tabs li a{
    padding: 20px 15px;
    font-size: 11px;
    font-weight: 600;
    color: #25283d;
    border-radius: 0;
    margin-right: 0;
    border: none;
    position: relative;
    transition: all 0.5s ease 0s;
}
.tab .nav-tabs li a:hover{
    background: #fff;
}
.tab .nav-tabs li a:before{
    content: "";
    width: 100%;
    height: 1px;
    background: rgba(0,0,0, 0.2);
    position: absolute;
    bottom: 5px;
    left: 0;
    transform: scale(0);
    transition: all 700ms ease 0s;
}
.tab .nav-tabs li a:after{
    content: "";
    width: 7px;
    height: 7px;
    border-radius: 50%;
    background: #4cc985;
    margin: 0 auto;
    position: absolute;
    bottom: 2px;
    left: 0;
    right: 0;
    transform: scale(0);
    transition: all 700ms ease 0s;
}
.tab .nav-tabs li.active a,
.tab .nav-tabs li.active a:focus,
.tab .nav-tabs li.active a:hover{
    border: none;
    color: #4cc985;
}
.tab .nav-tabs li a:hover:before,
.tab .nav-tabs li.active a:before,
.tab .nav-tabs li a:hover:after,
.tab .nav-tabs li.active a:after{
    transform: scale(1);
}
.tab .tab-content{
    padding: 20px;
    background: #fff;
    font-size: 14px;
    color: #a09d9d;
    line-height: 26px;
}
.tab .tab-content h3{
    font-size: 24px;
    margin-top: 0;
}
@media only screen and (max-width: 479px){
    .tab .nav-tabs li{ display:none; }
}}

hr {
	border: 1;
     width: 75%;
     border-color : #CACACA;
     height: 20px;
}

.caret {
	background-color:blue;
}

</style>
<script>
	$(document).ready(function() {

		//햄버거 누르면 펼쳐짐

		$('[data-toggle="offcanvas"]').click(function() {
			$('#wrapper').toggleClass('toggled');
		});

		var dropdown = document.getElementsByClassName("dropdown-btn");
		var i;

		for (i = 0; i < dropdown.length; i++) {
			dropdown[i].addEventListener("click", function() {
				this.classList.toggle("active");
				var dropdownContent = this.nextElementSibling;
				if (dropdownContent.style.display === "block") {
					dropdownContent.style.display = "none";
				} else {
					dropdownContent.style.display = "block";
				}
			});
		}
		
		var id = $('#hidden').val();
		var classname = $("."+id).attr("class"); 
		
	 	$("."+id).attr("class",classname+" active"); 
	 	$('.dropdown-item').click(function(e){
			id = $(e.target).attr("id");
			location.href="summary.env?id="+id;
		});	
	 	
	 	$('.intro').click(function(e){
			id = $(e.target).attr("id");
			location.href="summary.env?id="+id;
		});	
		
		$('.board').click(function(e){
			id = $(e.target).attr("id");
			location.href="summary.env?id="+id;
		});
		
		$('.cal').click(function(e){
			id = $(e.target).attr("id");
			location.href="summary.env?id="+id;
		});
		
		//이거 하니까 너무 느려진듯????
		$(".active").filter(".board:eq(1)").css("background","#A4FFFF").css("color","black");

	});
</script>

</head>
<body>

	<div id="wrapper">
		<div class="overlay"></div>

		<!-- Sidebar -->
		<nav class="navbar navbar-inverse navbar-fixed-top"
			id="sidebar-wrapper" role="navigation">
			
		<a id="toplogo" href="main.env">
			<img src="img/logo.gif" width=150px;></a>
		
		<ul class="nav sidebar-nav">
			<li><a class="dropdown-btn">정보공개안내 <span class="caret"></span>
			</a>
				<div class="dropdown-container">
			        <a class="dropdown-item" href="#" id="summary">개요</a>
			        <a class="dropdown-item" href="#" id="purpose">목적</a>
			        <a class="dropdown-item" href="#" id="procedure">조사 및 공개절차</a>
			        <a class="dropdown-item" href="#" id="information">공개대상 정보</a>
				</div></li>

			<li><a class="dropdown-btn">환경정보공개 <span class="caret"></span>
			</a>
				<div class="dropdown-container">
			        <a class="dropdown-item" href="area.env" id="area">지역별</a>
			        <a class="dropdown-item" href="object.env" id="object">물질별</a>
			        <a class="dropdown-item" href="part.env" id="part">업종별</a>
			        <a class="dropdown-item" href="#">내 설정</a>
				</div></li>

			<li><a class="dropdown-btn"> 알림마당 <span class="caret"></span>
			</a>
				<div class="dropdown-container">
			        <a class="dropdown-item" href="#" id="files_list">자료실</a>
			        <a class="dropdown-item" href="#" id="notice_list">공지사항</a>
			        <a class="dropdown-item" href="#" id="ad_com_list">홍보플러스</a>
			 		<a class="dropdown-item" href="#" id="ad_com_list">+회사홍보</a>
			 		<a class="dropdown-item" href="#" id="ad_best_list">+우수기업</a>
					<a class="dropdown-item" href="#" id="know_news_list">지식플러스</a>
			 		<a class="dropdown-item" href="#" id="know_news_list">+오늘의 뉴스</a>
			 		<a class="dropdown-item" href="#" id="know_quiz_list">+오늘의 퀴즈</a>
			        <a class="dropdown-item" href="#" id="question_list">질문있어요</a>
				</div></li>
		</ul>
		</nav>


		<!-- /#sidebar-wrapper -->
		<div id="page-content-wrapper">
	
			<!-- Page Content -->
		
			<div class="topmenu">
				
				<ul class="topmenu_left"><li>
				
					<span style="font-size: 30px; cursor: pointer"
						data-toggle="offcanvas">&#9776;</span></li>
				</ul>
				
			<!-- 	<ul class="topmenu_mid">
					<li> -->
					<div class="topmenu_mid"><img src="img/index용.jpg" id="logo"></div>
					
			<!-- 		</li>
				</ul> -->
				
				<ul class="topmenu_right">
					<li class="topmemu_search">
						<form id="topSearchFrm" action="/search/topSearch.do"
							method="post">
							<input name="schPrdValue" id="topSchPrdValue"
								onkeypress="javascript:if(event.keyCode == 13){ fnTopSearch(); return false;}"
								type="text" placeholder="찾기" style="display: none">
						</form>
						<!-- <button onclick="fnTopSearch();" type="button">Search</button> -->
					</li>
					<c:if test="${sessionScope.id == null}">
						<li><a href="join.env" id="register">회원가입</a></li>
						<li><a href="loginForm.env" id="login">로그인</a></li>
					</c:if>
					<c:if test="${sessionScope.id != null}">
						<li><a href="logout.env" id="login">로그아웃</a></li>
						<li><a href="mypage.env" id="register">내 페이지</a></li>
					</c:if>
				</ul>
				
			</div>
	<hr style="margin-top:150px">

			
<!-- 			<div id="topnav">
					<img src="img/logo.gif" id="logo">
			</div> -->
			
	<!-- 	<div class="container">
							<h1>Fancy Toggle Sidebar Navigation</h1>

				</div>  
			</div>-->
			<!-- /#page-content-wrapper -->

		</div>
</body>
</html>