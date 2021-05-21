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
	
	//-->
	</script>


<div id="menu">
			<h2><img src="/vodman/include/images/a_menu07_title.gif" alt="관리자"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/member/mng_memberList.jsp?mcode=1001" title="관리자 목록" <%if(mcode.equals("1001")) {out.println("class='visible'");}%>>관리자 목록</a></li>
			<li ><a href="/vodman/member/frm_memberAdd_new.jsp?mcode=1002&level=9" title="관리자 등록" <%if(mcode.equals("1002")) {out.println("class='visible'");}%>>관리자 등록</a></li>
			<li ><a href="/vodman/member/mng_memberList.jsp?mcode=1004&slevel=2" title="모니터링단 목록" <%if(mcode.equals("1004")) {out.println("class='visible'");}%>>모니터링단 목록</a></li>
			<li ><a href="/vodman/member/frm_memberAdd_new.jsp?mcode=1003&level=2" title="모니터링단 등록" <%if(mcode.equals("1003")) {out.println("class='visible'");}%>>모니터링단 등록</a></li>
			<li ><a href="/vodman/member/mng_member_logList.jsp?mcode=1008" title="관리자 로그" <%if(mcode.equals("1008")) {out.println("class='visible'");}%>>관리자 로그</a></li>
		   <li ><a href="/vodman/member/mng_admin_logList.jsp?mcode=1007" title="관리자 접속 기록" <%if(mcode.equals("1007")) {out.println("class='visible'");}%>>관리자 접속 기록</a></li> 
		     <%--  <li ><a href="/vodman/member/mng_vod_log2_test.jsp?mcode=1009" title="vod_log2_테스트" <%if(mcode.equals("1009")) {out.println("class='visible'");}%>>vod_log2_테스트</a></li> --%>
<!--			<li ><a href="/vodman/member/frm_sendMail.jsp?mcode=1007" title="메일보내기" <%if(mcode.equals("1007")) {out.println("class='visible'");}%>>메일보내기</a></li>
 
			<li><a href="/vodman/me/mng_buseoList.jsp?mcode=1003" title="부서 목록" <%if(mcode.equals("1003")) {out.println("class='visible'");}%>>부서 목록</a></li>
			<li ><a href="/vodman/me/frm_buseoAdd.jsp?mcode=1004" title="부서 생성" <%if(mcode.equals("1004")) {out.println("class='visible'");}%>>부서 생성</a></li>
			<li><a href="/vodman/me/mng_grayList.jsp?mcode=1005" title="직위 목록" <%if(mcode.equals("1005")) {out.println("class='visible'");}%>>직위 목록</a></li>
			<li><a href="/vodman/me/frm_grayAdd.jsp?mcode=1006" title="직위 생성" <%if(mcode.equals("1006")) {out.println("class='visible'");}%>>직위 생성</a></li>
-->
			</ul>
			<p class="menu_bottom"></p>
</div>