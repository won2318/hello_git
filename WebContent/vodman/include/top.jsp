<%@ page contentType="text/html; charset=euc-kr"%>
<%
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0101";
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
	<head>
		<title>관리자페이지</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="/vodman/include/js/script.js"></script>
	</head>
<body>
<div id="wrap">
	<div id="top">
		<ul>
		<li><img src="/vodman/include/images/a_top01.gif" alt="관리자페이지"/></li>
		<li><a href="/" target="_blank"><img src="/vodman/include/images/a_top02.gif" alt="home"/></a></li>
		<!--<li><a href="javascript:down_cms();"><img src="/vodman/include/images/a_top03.gif" alt="help"/></a></li>-->
		<li><a href="/vodman/include/logout.jsp"><img src="/vodman/include/images/a_top04.gif" alt="logout"/></a></li>
		</ul>
	</div>	
	<div id="tab_menu">
		<ul class="tab_menu_bg">
<%if(chk_auth(vod_id, vod_level, "s_list")) {%>
		<li class="tab_menu01"><a href="/vodman/site/mng_web_log.jsp?mcode=0116" title="사이트관리" <%if(mcode.substring(0,2).equals("01")) {out.println("class='visible'");}%>>사이트관리</a></li>
<%}%>
<%if(chk_auth(vod_id, vod_level, "be_list")) {%>
		<li class="tab_menu02"><a href="/vodman/best/mng_best_topView.jsp?mcode=0207&flag=A" title="메인화면관리" <%if(mcode.substring(0,2).equals("02")) {out.println("class='visible'");}%>>메인화면관리</a></li>
<%}%>
<%-- <% if(chk_auth(vod_id, vod_level, "menu_list")) {%> --%>
<%-- 		<li class="tab_menu09"><a href="/vodman/menu/mng_menuList.jsp?mcode=0301" title="메뉴관리" <%if(mcode.substring(0,2).equals("03")) {out.println("class='visible'");}%>>메뉴관리</a></li> --%>
<%-- <%} %> --%>
<%if(chk_auth(vod_id, vod_level, "cate_list")) {%>
		<li class="tab_menu03"><a href="/vodman/category/mng_categoryList.jsp?mcode=0401" title="카테고리관리" <%if(mcode.substring(0,2).equals("04")) {out.println("class='visible'");}%>>카테고리관리</a></li>
<%}%>
<%--		<li class="tab_menu11"><a href="/vodman/schedule/frm_schedule.jsp?mcode=0501" title="스케쥴관리" <%if(mcode.substring(0,2).equals("05")) {out.println("class='visible'");}%>>스케쥴관리</a></li>
--%>
<%-- <%if(chk_auth(vod_id, vod_level, "r_list")) {%> --%>
<%-- 		<li class="tab_menu05"><a href="/vodman/live_radio/mng_vodRealList.jsp?mcode=0501" title="보이는 라디오" <%if(mcode.substring(0,2).equals("05")) {out.println("class='visible'");}%>>보이는 라디오</a></li> --%>
<%-- <%}%> --%>
<%if(chk_auth(vod_id, vod_level, "r_list")) {%>
		<li class="tab_menu06"><a href="/vodman/live/mng_vodRealList.jsp?mcode=0601" title="생방송관리" <%if(mcode.substring(0,2).equals("06")) {out.println("class='visible'");}%>>생방송관리</a></li>
<%}%>
<%-- <%if(chk_auth(vod_id, vod_level, "r_list")) {%> --%>
<%-- 		<li class="tab_menu11"><a href="/vodman/schedule/index.jsp?mcode=1101" title="스케줄 관리" <%if(mcode.substring(0,2).equals("11")) {out.println("class='visible'");}%>>스케줄 관리</a></li> --%>
<%-- <%}%> --%>
<%if(chk_auth(vod_id, vod_level, "v_list")) {%>
		<li class="tab_menu04"><a href="/vodman/vod_aod/mng_vodOrderList.jsp?mcode=0701" title="영상관리" <%if(mcode.substring(0,2).equals("07")) {out.println("class='visible'");}%>>영상관리</a></li>
<%}%>
 
<%-- <%if(chk_auth(vod_id, vod_level, "p_list")) {%> --%>
<%-- 		<li class="tab_menu12"><a href="/vodman/event/mng_eventList.jsp?mcode=0801" title="이벤트관리" <%if(mcode.substring(0,2).equals("08")) {out.println("class='visible'");}%>>이벤트관리</a></li> --%>
<%-- <%}%> --%>
 <%if(chk_auth(vod_id, vod_level, "p_list")) {%>
		<li class="tab_menu12"><a href="/vodman/subject/frm_subjectList.jsp?mcode=0801" title="설문관리" <%if(mcode.substring(0,2).equals("08")) {out.println("class='visible'");}%>>이벤트관리</a></li>
<%}%>
<%if(chk_auth(vod_id, vod_level, "b_list")) {%>
		<li class="tab_menu08"><a href="/vodman/board/mng_boardList.jsp?mcode=0901" title="게시판관리" <%if(mcode.substring(0,2).equals("09")) {out.println("class='visible'");}%>>게시판관리</a></li>
<%}%>
<%if(chk_auth(vod_id, vod_level, "m_list")) {%>
		<li class="tab_menu07"><a href="/vodman/member/mng_memberList.jsp?mcode=1001" title="회원관리" <%if(mcode.substring(0,2).equals("10")) {out.println("class='visible'");}%>>회원관리</a></li>
<%}%>
		</ul>
	</div>
	<div id="container">