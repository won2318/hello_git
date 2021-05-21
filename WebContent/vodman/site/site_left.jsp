<%@ page contentType="text/html; charset=euc-kr"%>
	<script language = "JavaScript">
	<!--
	function M_over(src,cleerOver) {
		if (!src.contains(event.fromElement)) {
			src.style.cursor = 'hand'; src.bgColor = cleerOver;
		}
	}
	
	
	function M_out(src,cleerin) {
		if (!src.contains(event.toElement)) {
			src.style.cursor = 'default'; src.bgColor = cleerin;
		}
	}
	function go_backup() {
		location.href="proc_backupdb.jsp?mode=doit";
	}
	
	
	//-->
	</script>
		<div id="menu">
			<h2><img src="/vodman/include/images/a_menu01_title.gif" alt="사이트관리"/></h2>
			<ul class="s_menu_bg">
<%-- 			<li ><a href="frm_popList.jsp?mcode=0101" title="팝업관리" <%if(mcode.equals("0101")) {out.println("class='visible'");}%>>팝업관리</a></li> --%>
<%-- 	 
			<li ><a href="mng_authority.jsp?mcode=0102" title="권한관리(서비스)" <%if(mcode.equals("0102")) {out.println("class='visible'");}%>>권한관리(서비스)</a></li>
			--%>
 			<li class="menu01_03"><a href="mng_authority_admin.jsp?mcode=0103" title="권한관리(관리자)" <%if(mcode.equals("0103")) {out.println("class='visible'");}%>>권한관리(관리자)</a></li> 
			 
			<!-- <li ><a href="mng_poll.jsp?mcode=0104" title="설문관리" <%if(mcode.equals("0104")) {out.println("class='visible'");}%>>설문관리</a></li> --> 
			<li ><a href="mng_fuckList.jsp?mcode=0109" title="욕설관리" <%if(mcode.equals("0109")) {out.println("class='visible'");}%>>욕설관리</a></li>

			<li ><a href="frm_mainLogo.jsp?mcode=0105" title="로고관리" <%if(mcode.equals("0105")) {out.println("class='visible'");}%>>로고관리</a></li>		
<%-- 			<li ><a href="mng_stat_hit.jsp?mcode=0107" title="시청통계(그래프)" <%if(mcode.equals("0107")) {out.println("class='visible'");}%>>시청통계(그래프)</a></li> --%>
			<li ><a href="mng_stat_count2.jsp?mcode=0107" title="시청통계(그래프)" <%if(mcode.equals("0107")) {out.println("class='visible'");}%>>시청통계(그래프)</a></li>
			<li ><a href="mng_stat_menu_hit_total.jsp?mcode=0113" title="시청통계" <%if(mcode.equals("0113")) {out.println("class='visible'");}%>>시청통계</a></li>
			<li ><a href="mng_view_stat.jsp?mcode=0108" title="시청로그보기" <%if(mcode.equals("0108")) {out.println("class='visible'");}%>>시청로그보기</a></li>
<%--  			<li ><a href="mng_month_log.jsp?mcode=0110" title="영상별시청누계" <%if(mcode.equals("0110")) {out.println("class='visible'");}%>>영상별시청누계</a></li> --%>

			<!-- <li ><a href="mng_stat_menu.jsp?mcode=0111" title="메뉴클릭통계" <%if(mcode.equals("0111")) {out.println("class='visible'");}%>>메뉴클릭통계</a></li> -->
<%-- 			<li ><a href="mng_stat.jsp?mcode=0106" title="접속통계보기" <%if(mcode.equals("0106")) {out.println("class='visible'");}%>>접속통계보기</a></li> --%>
			<li ><a href="mng_stat_2.jsp?mcode=0106" title="접속통계보기" <%if(mcode.equals("0106")) {out.println("class='visible'");}%>>접속통계보기</a></li>
<%-- 			<li ><a href="mng_stat_menu_total.jsp?mcode=0112" title="메뉴클릭통계종합" <%if(mcode.equals("0112")) {out.println("class='visible'");}%>>메뉴클릭통계</a></li>					 --%>
			<li ><a href="mng_cate_stat.jsp?mcode=0115" title="분류별 등록/시청통계" <%if(mcode.equals("0115")) {out.println("class='visible'");}%>>분류별 등록/시청통계</a></li>
			<li ><a href="mng_web_log.jsp?mcode=0116" title="웹로그" <%if(mcode.equals("0116")) {out.println("class='visible'");}%>>웹로그</a></li>
			<li ><a href="mng_web_count_stat.jsp?mcode=0117" title="뷰어 카운트" <%if(mcode.equals("0117")) {out.println("class='visible'");}%>>뷰어 카운트</a></li>
			<li ><a href="proc_backupdb.jsp?mode=doit" title="DB정보백업">DB정보백업</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>