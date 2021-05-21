<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<jsp:useBean id="LiveSqlBean" class="com.hrlee.sqlbean.LiveSqlBean" scope="page"/>
<%@ include file="/include/chkLogin.jsp"%>
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

		
		String apple[] = {"iPhone", "iPop", "iPad"};
		String android = "Android"; 
		for(int i=0; i<apple.length; i++){
			if(StringUtils.indexOf(hValue, apple[i]) > 0){
				protocal = "iPhone";
				break;
			}else if(StringUtils.indexOf(hValue, android) > 0){
				protocal = "Android";
			}else{
				protocal = "web";
				
			}
		}

		if(protocal.equals("web")){
		 		out.println("<script>alert('PC 화면으로 이동합니다.');location.href = '/2017/main/main.jsp';</script>");
		} 
		
%>

<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta NAME="title" content="수원 iTv" />
	<meta NAME="description" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원" />
	<meta NAME="Keywords" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원" />
	
	<title>수원인터넷방송</title>
	
	<link rel="stylesheet" type="text/css" href="../include/css/default.css" />
	<link rel="stylesheet" type="text/css" href="../include/css/main.css" /> <!--메인용-->
	<link rel="stylesheet" type="text/css" href="../include/css/content.css" /> <!--서브용-->
	<script type="text/javascript" src="../include/js/jquery-1.12.0.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.event.drag-1.5.1.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.touchSlider.js"></script>
	<script type="text/javascript" src="../include/js/modernizr.js"></script>
	<script type="text/javascript" src="../include/js/main.js"></script> <!--메뉴, 메인좌우터치-->
	<script type="text/javascript" src="../include/js/masonry.pkgd.min.js"></script>
 
	<script type="text/javascript" src="/include/js/script.js"></script>
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
	<div id="wapper"> 
		<header>
			<h1><a href="/mobile/html/main.jsp"><img src="../include/images/logo_s.png" alt="SUWON TV" class="retina_no"/><img src="../include/images/logo.png" class="retina_yes"/></a></h1>
			<div class="gnb_wrap">
				<a id="cd-menu-trigger" href="#0"><span class="cd-menu-text">Menu</span><span class="cd-menu-icon"></span></a>
				<!--<a href="#"><span class="hide_txt">전체메뉴열기</span></a>-->
			</div>
			<div class="gnb_sch">
				<a href="search.jsp"><span class="hide_txt">검색</span></a>
			</div>
			<!--<div class="sns_link">
				<a href="http://www.youtube.com/user/suwonloves"><img src="../include/images/sns_youtube.png" alt="YOUTUBE"/></a>
				<a href="http://blog.naver.com/suwonitv/"><img src="../include/images/sns_blog.png" alt="Naver Blog"/></a>
				<a href="https://tv.kakao.com/channel/2711566/cliplink/303361751?metaObjectType=Channel"><img src="../include/images/sns_cacaotv.png" alt="CacaoTV"/></a>
				<a href="https://twitter.com/suwonitv"><img src="../include/images/sns_twitter.png" alt="Twitter"/></a>
				<a href="http://tv.naver.com/suwonitv"><img src="../include/images/sns_navertv.png" alt="NaverTV"/></a>
			</div>-->
		</header><!--//상단헤더:header-->
		
		<nav id="cd-lateral-nav">
			<div id="cd-lateral-nav-inner">전체메뉴</div>
			<ul class="cd-navigation">
				<li class="item-has-children">
					<a href="#0">수원은 지금!<%if (contactMenu.menu_content("001000000000") > 0) out.print("<span class='new'>new</span>");%></a>
					<ul class="sub-menu">
						<li><a href="./vod_list.jsp?category=001001000000">수원 iTV 뉴스<%if (contactMenu.menu_content("001001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						<li><a href="./vod_list.jsp?category=001008000000">기획영상<%if (contactMenu.menu_content("001008000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						<li><a href="./vod_list.jsp?category=001009000000">수원시 홍보영상<%if (contactMenu.menu_content("001009000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						<li><a href="./vod_list.jsp?category=001003000000">종영프로그램<%if (contactMenu.menu_content("001003000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
					
					</ul>
				</li> <!-- item-has-children -->

				<li class="item-has-children">
					<a href="#0">방송스크랩<%if (contactMenu.menu_content("002000000000") > 0) out.print("<span class='new'>new</span>");%></a>
					<ul class="sub-menu">
 
						<li><a href="./vod_list.jsp?category=002007000000">방송영상<%if (contactMenu.menu_content("002007000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						<li><a href="./board_list.jsp?board_id=24">방송모음<%if (contactMenu.menu_content_board(24) > 0) out.print("<span class='new '>new</span>");%></a></li>		
					</ul>
				</li> <!-- item-has-children -->

				<li class="item-has-children">
					<a href="#0">교양&#183;정보<%if (contactMenu.menu_content("003000000000") > 0) out.print("<span class='new'>new</span>");%></a>
					<ul class="sub-menu">
						<li><a href="./vod_list.jsp?category=003001000000">라이프<%if (contactMenu.menu_content("003001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						<li><a href="./vod_list.jsp?category=003006000000">홍보영상<%if (contactMenu.menu_content("003006000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						<li><a href="./vod_list.jsp?category=003007000000">타임머신<%if (contactMenu.menu_content("003007000000") > 0) out.print("<span class='new'>new</span>");%></a></li>				
					</ul>
				</li> <!-- item-has-children -->
				
				<li class="item-has-children">
					<a href="#0">참여광장<%if (contactMenu.menu_content("004001000000") > 0 ||contactMenu.menu_content_board2() > 0 ) out.print("<span class='new'>new</span>");%></a>
					<ul class="sub-menu">
						<li><a href="./vod_list.jsp?category=004001000000">나도PD<%if (contactMenu.menu_content("004001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>		
						<li><a href="./board_list.jsp?board_id=10">공지사항<%if (contactMenu.menu_content_board(10) > 0) out.print("<span class='new '>new</span>");%></a></li>			
						<li><a href="./board_list.jsp?board_id=17">휴먼스토리<%if (contactMenu.menu_content_board(17) > 0) out.print("<span class='new '>new</span>");%></a></li>
						<li><a href="./board_list.jsp?board_id=22">시민모니터단<%if (contactMenu.menu_content_board(22) > 0) out.print("<span class='new '>new</span>");%></a></li>
					 
					</ul> 
				</li> <!-- item-has-children -->
				
				<li class="item-has-children">
					<a href="#0">수원시의회<%if (contactMenu.menu_content("005000000000") > 0) out.print("<span class='new'>new</span>");%></a>
					<ul class="sub-menu">

						<li><a href="./vod_list.jsp?category=005002000000">수원시의회<%if (contactMenu.menu_content("005002000000") > 0) out.print("<span class='new'>new</span>");%></a></li>		
						<li><a href="./board_list.jsp?board_id=25">방송모음<%if (contactMenu.menu_content_board(25) > 0) out.print("<span class='new '>new</span>");%></a></li>
					</ul>
				</li> <!-- item-has-children -->
				
				<li class="item-has-children">
					<a href="#0">생방송 다시보기<%if (contactMenu.menu_content("006001000000") > 0) out.print("<span class='new'>new</span>");%></a>
					<ul class="sub-menu">
						 
						<li><a href="./vod_list.jsp?category=006001000000">다시보기<%if (contactMenu.menu_content("006001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
					</ul>
				</li> <!-- item-has-children -->
				<li class="item-has-children">
					<a href="#0">About Suwon<%if (contactMenu.menu_content("009000000000") > 0) out.print("<span class='new'>new</span>");%></a>
					<ul class="sub-menu">
						<li><a href="./vod_list.jsp?category=009002000000">Promotional Video<%if (contactMenu.menu_content("009002000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						<li><a href="./vod_list.jsp?category=009001000000">Global Suwon (End program)<%if (contactMenu.menu_content("009001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
						</ul>
				</li> <!-- item-has-children -->
				
			</ul> <!-- cd-navigation -->
<!-- 			<div class="sns_link"> -->
<!-- 				<a href="http://www.youtube.com/user/suwonloves"><img src="../include/images/sns_youtube.png" alt="YOUTUBE"/></a> -->
<!-- 				<a href="http://blog.naver.com/suwonitv/"><img src="../include/images/sns_blog.png" alt="Naver Blog"/></a> -->
<!-- 				<a href="https://tv.kakao.com/channel/2711566/cliplink/303361751?metaObjectType=Channel"><img src="../include/images/sns_cacaotv.png" alt="CacaoTV"/></a> -->
<!-- 				<a href="https://twitter.com/suwonitv"><img src="../include/images/sns_twitter.png" alt="Twitter"/></a> -->
<!-- 				<a href="http://tv.naver.com/suwonitv"><img src="../include/images/sns_navertv.png" alt="NaverTV"/></a> -->
<!-- 			</div> -->
		</nav><!--//메뉴:nav-->
 
 