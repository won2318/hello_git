<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
 <%
 String muid ="";
 if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("main.jsp")> -1 ) {
	 muid = "main"; 
	 contact.setValue(request.getRemoteAddr(),"guest", "M");  // 메인 페이지 일경우 접속 카운트
 } else if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0) {
	 muid = request.getParameter("ccode") ;
 }else if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 muid = "B_"+request.getParameter("board_id") ;
 }  else {
	 muid = "etc";
 }
contact.setPage_cnn_cnt("M"); // 페이지 접속 카운트 증가

contactMenu.setValueMenu(request.getRemoteAddr(),"guest", "M", muid);  // 서브페이지 메뉴 카운트
 
LiveManager lMgr = LiveManager.getInstance();
String channel = "";
String stream = "";
String live_title ="";
String live_rcontents ="";
String live_popup = "";
Vector live_v = null;
String live_url = "";
live_v = lMgr.getLive(); 
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
	<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />
	<title>수원iTV</title>
	<link rel="stylesheet" type="text/css" href="../include/css/default.css">
	<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css">
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/jquery.masonry.min.js"></script>
	
	<script type="text/javascript" src="../include/js/script2.js"></script>
<% if (protocal.contains("iPhone")) { %>	
	<script type="text/javascript" src="../include/js/script_ios.js"></script>
<%} else { %>	
	<script type="text/javascript" src="../include/js/script_andr.js"></script>
<%} %>	

<script type="text/javascript">
<!--
 
setTimeout('live_check_timer()',10000);  // 생방송 채크

function live_check_timer(){
	 
	 $.get("live_check_timer.jsp",  function(data) {
			 if (data != "") {
				 $("#live_check_img").html(data); 
			 } 
		 },   "text" ); 
}

function live_log(rcode){
	 
	 $.get("proc_live_log.jsp", { 'rcode': rcode},  function(data) {
			 if (data != "") { 
				// alert(data);
			 } 
		 },   "text" ); 
}

//-->

</script> 
	
</head>


<body>
<div class="u_skip"><a href="#container">본문 바로가기</a></div>
<div class="header">
	<div class="sch_w">
		<h1 class="lg_h"><a href="main.jsp"><img src="../include/images/logo.png" width="104" height="61" alt="수원뉴스 MOBILE SUWON NEWS"/></a></h1>
		<aside>
			<span class="home_icon">
				<a href="main.jsp"><img src="../include/images/icon_home.png" width="47" height="54" alt=""/></a>
			</span>
			<span class="sch_icon">
				<a href="search.jsp"><img src="../include/images/icon_search.png" width="47" height="54"/></a>
			</span>
		</aside>
	</div>


	<div id="nav" class="nav">
	<nav role="navigation">
		<ul class="nav_u">
		<li class="nav_l <%if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && (request.getRequestURI().contains("iTV_board.jsp") ||  request.getRequestURI().contains("iTV_list.jsp") )  ) {out.println("nav_lon");} %> line" data-nCode="iTV"><a href="iTV_list.jsp" class="nav_a"><img src="../include/images/nav_menu1_<%if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && (request.getRequestURI().contains("iTV_board.jsp") ||  request.getRequestURI().contains("iTV_list.jsp") ) ) {out.print("on");}else {out.print("off");} %>.gif" width="159" height="36" alt=""/></a></li>
		<li class="nav_l <%if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().contains("iNews_list.jsp")  ) {out.println("nav_lon");} %>" data-nCode="news"><a href="iNews_list.jsp?menu_id=0101" class="nav_a"><img src="../include/images/nav_menu2_<%if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && !request.getRequestURI().contains("iNews_list.jsp") ) {out.print("off");}else {out.print("on");} %>.gif" width="159" height="36" alt=""/></a></li>
		</ul>
	</nav>
	</div>
	<%  if(live_v != null && live_v.size() > 0) {
		String mobile_stream = String.valueOf(live_v.elementAt(21));
		
		String tmpIP = DirectoryNameManager.SV_LIVE_SERVER_IP ;
		 
		if(protocal.equals("Android")){
			live_url="rtsp://"+tmpIP+ ":1935"+mobile_stream;
		 }else if(protocal.equals("iPhone")){ 
			 live_url="http://"+tmpIP + ":1935/"+mobile_stream +"/playlist.m3u8";
		} 
	%>
		<div class="live_on" id="live_check_img"><a href="<%=live_url%>" onclick="live_log('<%=live_v.elementAt(0)%>');"><img src='../include/images/icon_live.gif' height='24' width='33' alt='LIVE_ON'/> 생방송 시청하기</a></div>
	<%} else { %>
		<%
		 if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("iNews_list.jsp")> -1 ) {
		%>
<%--		<div class="newsHome"><a href="http://news.suwon.go.kr">e-수원뉴스 PC버전</a></div> --%>
		<%
		}else{
		%>
		
		<div class="live_on" id="live_check_img"><a href="LiveSchedule.jsp"><img src='../include/images/icon_live_off.gif' height='24' width='33' alt='LIVE_OFF'/> 생방송 안내</a></div>
		<%
		}
		%>
	<% }%>
	