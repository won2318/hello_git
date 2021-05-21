<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>    
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<jsp:useBean id="contactLog" class="com.vodcaster.sqlbean.WebLogManager" />
 
 <%
 
 String muid ="";
 if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && (request.getRequestURI().indexOf("main.jsp")> -1  || request.getRequestURI().indexOf("main_link.jsp")> -1) ) {
	 muid = "main"; 
	 contact.setValue(request.getRemoteAddr(),"guest", "W");  //  접속 카운트
 } else if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0) {
	 muid = request.getParameter("ccode") ;
 }else if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 muid = "B_"+request.getParameter("board_id") ;
 }  else {
	 muid = "etc";
 }
 
contactLog.setStatVisitInfo(request);  // web_log

contactMenu.setValueMenu(request.getRemoteAddr(),"guest", "W", muid);  // 서브페이지 메뉴 카운트 contact_stat_menu
contact.setPage_cnn_cnt("W"); // 페이지 접속 카운트 증가 page_cnn_cnt
 
%>
<%
LiveManager lMgr = LiveManager.getInstance();
String channel = "";
String stream = "";
String live_title ="";
String live_rcontents ="";
String live_popup = "";
String live_rcode ="";
Vector live_v = null;
try {
 // rcode, rtitle, rcontents, rbcst_time, ralias, 
  // rstart_time, rend_time, rflag, rstatus, rwdate, 
  // rhit, rlevel,rfilename, rid, rimagefile,
  // property_id, openflag,group_id, del_flag, ocode, 
  // otitle, mobile_sream, inoutflag, org_rfilename 
    live_v = lMgr.getLive(); 
//   if(live_v != null && live_v.size() > 0) {
// 		live_popup = "window.open('/2017/info/live_info.jsp','live_comment', 'width=400, height=300, scrollbars=no, toolbars=no');";
// 		live_rcode = String.valueOf(live_v.elementAt(0)); 
// 		live_title = String.valueOf(live_v.elementAt(1)); 
// 		live_rcontents  = String.valueOf(live_v.elementAt(2)); 
// 		String[] data= null;
		 
// 		data=String.valueOf(live_v.elementAt(4)).split("/");

// 		if(data.length > 2){
// 			channel = data[1];
// 			stream = data[2];
// 		} 
//   } 
}catch(Exception e) {}

 
 
String temp_reqURL=request.getRequestURL().toString();
String temp_queryString = request.getQueryString();

if(temp_queryString == null || temp_queryString.equals("") || temp_queryString.equals("null")) temp_queryString = "";
if (temp_reqURL != null && temp_reqURL.length() > 0 && temp_reqURL.contains("tv.suwon.ne.kr")) {
	temp_reqURL = temp_reqURL.replaceAll("tv.suwon.ne.kr","tv.suwon.go.kr");
	if (temp_queryString != null && temp_queryString.length() > 0) {
	
		temp_reqURL = temp_reqURL+"?"+temp_queryString;
	} 
	 
	out.println("<script>location.href = '"+temp_reqURL+"';</script>");
}
 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>수원인터넷방송</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta NAME="title" content="수원 iTv" />
<meta NAME="description" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원" />
<meta NAME="Keywords" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원" />

<link rel="stylesheet" type="text/css" href="../include/css/default.css" />
<link rel="stylesheet" type="text/css" href="../include/css/content.css" />
<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css" />
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.flexslider-min.js"></script> <!-- 상단메뉴 -->
<script type="text/javascript" charset="utf-8" src="../include/js/common.js"></script> <!-- 상단메뉴 -->
<script type="text/javascript" charset="utf-8" src="../include/js/tab.js"></script> <!-- 서브탭버튼 -->
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.leanModal.min.js"></script> <!-- 메인메뉴모달 -->
<!-- <script type="text/javascript" charset="utf-8" src="/2017/include/js/script.js?ver=1"></script> -->
<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
<script type="text/javascript" charset="utf-8" src="../include/js/script.js"></script> <!-- 레이어팝업, 메뉴 상단배치 -->

</head>

 
<script type="text/javascript">
<!--
 
function AddFavorite(obj){
 
  var browser = navigator.userAgent.toLowerCase();
  //Mozilla, FireFox, Netscape
  if(window.sidebar) {
   		window.sidebar.addPanel('http://tv.suwon.go.kr','수원iTV_수원시 인터넷 방송','');
  }else if(window.external){
	    if(browser.indexOf('chrome') == -1){   //IE
	     window.external.AddFavorite('http://tv.suwon.go.kr','수원iTV_수원시 인터넷 방송');
	    }else{
	    alert('ctrl + D 또는 command + D를 눌러 즐겨찾기 추가하세요 ');  //chrome
	    }
   }else if(window.opera && window.print){    //opera
   		return true;
   }else  if(browser.indexOf('konqueror') != -1){  //konqueror
   		 alert('ctrl + B를 눌러 즐겨찾기 추가하세요 ');
   }else  if(browser.indexOf('webkit') != -1){  //safari
      		alert('ctrl + B를 눌러 즐겨찾기 추가하세요 ');
   }else{
    		alert('현재 브라우져 즐겨찾기 지원안됨 ');
   }
} 

//setTimeout('live_check_timer()',10000);  // 생방송 채크 

function live_check_timer(){
	 
	 $.get("/2017/live/live_check_timer.jsp",  function(data) {
			 if (data != "") {
				 $("#live_check_img").html(data); 
			 } 
		 },   "text" ); 
}

function live_open(){
	window.open('/2017/live/live_player_pop.jsp','live_player', 'width=650, height=900, scrollbars=yes, toolbars=no');
	
} 

//-->

</script>   
 

<body>
	<div id="wapper"> 
		<header> 
			<div class="head_inner">
			<div id="accessibility">
				<ul>
				<li><a href="#lnb" accesskey="1">메인메뉴바로가기</a></li>
				<li><a href="#body" accesskey="2">컨텐츠바로가기</a></li>
				</ul>
			</div> <!-- //accessibility::skip -->
			<div class="top-nav"> 
				<h1><a href="/"><img src="../include/images/logo.png" alt="SUWON TV"/></a></h1>
				<div class="gnb_area">
					<ul>
					<li><a href="/">홈</a></li>
					<li><a href="javascript:AddFavorite(this);">즐겨찾기</a></li>
					<li><a href="/2017/info/search.jsp">전체프로그램</a></li>
					<% if (vod_name != null && vod_name.length() > 0) { %><li><a href="/include/logout.jsp">로그아웃</a></li><%} %>
					</ul>
					<div class="gnb_search">
						<form name="head_search" method="post" action="/2017/info/search.jsp">
						<fieldset>
							<legend>검색</legend>
							<span class="gnb_search_in">
								<input type="hidden" name="search_ccode" value="" />
								<input type="hidden" name="searchField" value="title" />
								<input type="text" title="검색어" name="searchString" id="head_searchstring" value="보고싶은 영상이 있다면?" class="input_text" onclick="javascript:document.getElementById('head_searchstring').value=''; "/> 
							</span><input type="image" src="../include/images/icon_search_2.png" alt="검색" class="img"/>
							</fieldset>
						</form>
					</div>
				</div>
<!-- 				<div class="sns"> -->
<!-- 					<a href="http://www.youtube.com/user/suwonloves" target="_blank" title="새창으로 연결"><img src="../include/images/sns_youtube.png" alt="유투브"/></a> -->
<!-- 					<a href="http://blog.naver.com/suwonitv/" target="_blank" title="새창으로 연결"><img src="../include/images/sns_blog.png" alt="네이버 블로그"/></a> -->
<!-- 					<a href="https://tv.kakao.com/channel/2711566/cliplink/303361751?metaObjectType=Channel" target="_blank" title="새창으로 연결"><img src="../include/images/sns_cacaotv.png" alt="카카오TV"/></a> -->
<!-- 					<a href="https://twitter.com/suwonitv" target="_blank" title="새창으로 연결"><img src="../include/images/sns_twitter.png" alt="트위터"/></a> -->
<!-- 					<a href="http://tv.naver.com/suwonitv" target="_blank" title="새창으로 연결"><img src="../include/images/sns_navertv.png" alt="네이버TV"/></a> -->
<!-- 				</div> -->
			</div>
			</div>
		</header> <!--헤더:header-->               
		<nav id="lnb">     
			<!-- menu::로컬메뉴 -->
			<div class="lnb_wrap">
			<div class="gnb" id="">			
				<ul>
							<li class="s1 ">
							<a href="/2017/video/video_list.jsp?ccode=001000000000" class="<%=ccode != null && ccode.startsWith("001") && !ccode.startsWith("001004")?"visible":""%>">수원은 지금!<%if (contactMenu.menu_content("001000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=001001000000">수원  iTV 뉴스<%if (contactMenu.menu_content("001001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=001008000000">기획영상<%if (contactMenu.menu_content("001008000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=001009000000">수원시 홍보영상<%if (contactMenu.menu_content("001009000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=001003000000">종영프로그램<%if (contactMenu.menu_content("001003000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								
								</ul>
							</li>
							<li class="s2 ">
							<a href="/2017/video/video_list.jsp?ccode=002007000000" class="<%=
							ccode != null && ccode.startsWith("002")  
							|| temp_queryString.indexOf("board_id=24")> -1 
							
							?"visible":""
							%>">방송스크랩<%if (contactMenu.menu_content("002007000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
 								<li><a href="/2017/video/video_list.jsp?ccode=002007000000">방송영상<%if (contactMenu.menu_content("002007000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
							    <li><a href="/2017/board/board_list.jsp?board_id=24">방송모음<%if (contactMenu.menu_content_board(24) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								
								</ul>
							</li>
							<li class="s3 ">
							<a href="/2017/video/video_list.jsp?ccode=003000000000" class="<%=ccode != null && ccode.startsWith("003")?"visible":""%>">교양&#183;정보<%if (contactMenu.menu_content("003000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=003001000000">라이프<%if (contactMenu.menu_content("003001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=003006000000">홍보영상<%if (contactMenu.menu_content("003006000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>					
								<li><a href="/2017/video/video_list.jsp?ccode=003007000000">타임머신<%if (contactMenu.menu_content("003007000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>					
								</ul>
							</li>
							<li class="s4 ">
							<a href="/2017/video/video_list.jsp?ccode=004001000000" class="
							<%=
							ccode != null && ccode.startsWith("004") 
							|| temp_queryString.indexOf("board_id=16")> -1
							|| temp_queryString.indexOf("board_id=12")> -1
							|| temp_queryString.indexOf("board_id=10")> -1
							|| temp_queryString.indexOf("board_id=17")> -1
							|| temp_queryString.indexOf("board_id=18")> -1
							|| temp_queryString.indexOf("board_id=19")> -1 
							|| temp_queryString.indexOf("board_id=11")> -1
							|| temp_queryString.indexOf("board_id=13")> -1 
							|| temp_queryString.indexOf("board_id=21")> -1 
							|| temp_queryString.indexOf("board_id=22")> -1 
							|| temp_queryString.indexOf("board_id=23")> -1 
							
							?"visible":""
							%>">참여광장<%if (contactMenu.menu_content("004001000000") > 0 ||contactMenu.menu_content_board2() > 0 ) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=004001000000">나도PD<%if (contactMenu.menu_content("004001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>				
 								<li><a href="/2017/board/board_list.jsp?board_id=10">공지사항<%if (contactMenu.menu_content_board(10) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/board/board_list.jsp?board_id=17">휴먼스토리<%if (contactMenu.menu_content_board(17) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
<%--  								<li><a href="/2017/board/board_list.jsp?board_id=22">시민모니터단<%if (contactMenu.menu_content_board(22) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li> --%>
								</ul>
							</li>
							<li class="s5 ">
							<a href="/2017/video/video_list.jsp?ccode=005002000000" class="<%=(ccode != null && ccode.startsWith("005")) ?"visible":""%>">수원시의회<%if (contactMenu.menu_content("005002000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
  								<li><a href="/2017/video/video_list.jsp?ccode=005002000000">수원시의회<%if (contactMenu.menu_content("005002000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li> 
								<li><a href="/2017/board/board_list.jsp?board_id=25">방송모음<%if (contactMenu.menu_content_board(25) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>

								</ul>
							</li>
							<li class="s6">
							<a href="/2017/video/video_list.jsp?ccode=006001000000" class="<%=ccode != null && ccode.startsWith("006")
							|| request.getRequestURI().indexOf("live_list.jsp")> -1 
							?"visible":""%>">생방송 다시보기
							<% if(live_v != null && live_v.size() > 0) { %><span class="new onair">ON-AIR</span><%} %>
							<%if (contactMenu.menu_content("006000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
<!-- 								<li><a href="/2017/live/live_list.jsp">생방송 목록</a></li>  -->
								<% if(live_v != null && live_v.size() > 0) { %><li><a href="/2017/live/live_player.jsp?ccode=006001000000">ON-AIR <span class='new bubb1'>N</span></a></li><%} %>
								<li><a href="/2017/video/video_list.jsp?ccode=006001000000">생방송 다시보기<%if (contactMenu.menu_content("006001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
 
								</ul>
							</li>	
							<li class="s7 last">
							<a href="/2017/video/video_list.jsp?ccode=009000000000" class="<%=ccode != null && ccode.startsWith("009")?"visible":""%>">About Suwon<%if (contactMenu.menu_content("009000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=009002000000">Promotional Video<%if (contactMenu.menu_content("009002000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=009001000000">Global Suwon (End program)<%if (contactMenu.menu_content("009001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>


								</ul>
							</li>
										
						</ul>

			</div><!-- //menu::로컬메뉴 -->
			<a href="#menuFull" class="flatbtn" id="modaltrigger"><img src="../include/images/icon_menu_yellow.png" alt="메뉴"/></a>
			 
			</div><!--//lnb_wrap-->
			<div id="snb">
				  <%@ include file = "../include/top_sub_menu.jsp"%> 
			</div>
		</nav> <!--네비게이션:nav-->       
