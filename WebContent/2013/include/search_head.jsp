<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
 <%
 //request.setCharacterEncoding("euc-kr");
 
 String muid ="";
 if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("main.jsp")> -1 ) {
	 muid = "main"; 
 } else if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0) {
	 muid = request.getParameter("ccode") ;
 }else if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 muid = "B_"+request.getParameter("board_id") ;
 }  else {
	 muid = "etc";
 }

contact.setValue(request.getRemoteAddr(),"guest", "M");  // 메인 페이지 일경우 접속 카운트
contactMenu.setValueMenu(request.getRemoteAddr(),"guest", "M", muid);  // 서브페이지 메뉴 카운트
 
%>
<%

     String hValue = request.getHeader("user-agent");
	String protocal = "http://";
	if(hValue.indexOf("Android") != -1)
		//protocal = "rtsp://";
		protocal = "Android";
	else if(hValue.indexOf("iPhone") != -1)
		//protocal = "http://";
		protocal = "iPhone";

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />
	<title>수원iTV</title>
 
	<link rel="stylesheet" type="text/css" href="../include/css/default.css">
	<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css">
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/jquery.masonry.min.js"></script>
 
	<script type="text/javascript" src="../include/js/script2.js"></script>
 	
	<script type="text/javascript" src="../include/js/script_ios.js"></script>
 
</head>
 <script type="text/javascript">
 

 function search_form(){

   var radioObj = document.all('type'); 
   var isChecked; 
   for(i=0; i<radioObj.length; i++){

    if(radioObj[i].checked){

     isChecked = radioObj[i].value; 
     break;    
    }
 
   }
  
   if (isChecked == 'news') {
	   document.search_form.action="search_news.jsp";
   } else if (isChecked == 'vod') {
	   document.search_form.action = "search_vod.jsp";
 
   } else {
	   document.search_form.action = "search.jsp";
   }
   document.search_form.submit();

 }
 </script>
<body>
<div class="u_skip"><a href="#container">본문 바로가기</a></div>
<div class="header">
	<div class="sch_w">
		<h1 class="lg_h"><a href="main.jsp"><img src="../include/images/logo.gif" width="104" height="61" alt="수원뉴스 MOBILE SUWON NEWS"/></a></h1>
		<aside>
			<span class="home_icon">
				<a href="main.jsp"><img src="../include/images/icon_home.gif" width="47" height="54" alt=""/></a>
			</span>
			<span class="sch_icon">
				<a href="search.jsp"><img src="../include/images/icon_search.gif" width="47" height="54"/></a>
			</span>
		</aside>
	</div>
	
	<div id="searchInfo">
		<form name="search_form" method="post">
 
		<fieldset>
		<legend>기사 검색</legend>
		<p><input type="search" name="searchString" title="검색어입력"  value="<%=searchString%>" class="style"/></p>
		<a href="javascript:search_form();" data-role="button" class="btn3">검색</a>
		</fieldset>	
		<ul class="search"> 
			<li><span>영역</span>
				<input type="radio" id="domain1" name="searchField" value="all" title="전체"  <%if(searchField.equals("all")){%>checked="true"<%}%>/><label for="domain1">전체</label> 
				<input type="radio" id="domain2" name="searchField" value="title" title="제목"  <%if(searchField.equals("title")){%>checked="true"<%}%>/><label for="domain2">제목</label> 
				<input type="radio" id="domain3" name="searchField" value="content" title="내용"  <%if(searchField.equals("content")){%>checked="true"<%}%>/><label for="domain3">내용</label>
			</li>
			<li><span>유형</span>
				<input type="radio" id="type1" name="type" value="all" title="전체" <%if(type.equals("all")){%>checked="true"<%}%>/><label for="type1">전체</label> 
				<input type="radio" id="type2" name="type" value="news" title="뉴스" <%if(type.equals("news")){%>checked="true"<%}%>/><label for="type2">뉴스</label> 
				<input type="radio" id="type3" name="type" value="vod" title="동영상" <%if(type.equals("vod")){%>checked="true"<%}%>/><label for="type3">동영상</label>
			</li>
			<li><span>기간</span>
				<input type="radio" id="date1" name="date" value="all" title="전체" <%if(date.equals("all")){%>checked="true"<%}%> /><label for="date1">전체</label>
				<input type="radio" id="date2" name="date" value="week" title="1주일" <%if(date.equals("week")){%>checked="true"<%}%>/><label for="date2">1주일</label>
				<input type="radio" id="date3" name="date" value="month" title="1개월" <%if(date.equals("month")){%>checked="true"<%}%>/><label for="date3">1개월</label>
				<input type="radio" id="date4" name="date" value="year" title="년" <%if(date.equals("year")){%>checked="true"<%}%>/><label for="date4">1년</label>
			</li>
			 
		</ul>			
		</form>
	</div>	
</div>
 