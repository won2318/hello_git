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
		<h2><img src="/vodman/include/images/a_menu12_title.gif" alt="이벤트관리"/></h2>
		<ul class="s_menu_bg">
		<li ><a href="/vodman/event/mng_eventList.jsp?mcode=0801" title="이벤트 목록" <%if(mcode.equals("0801")) {out.println("class='visible'");}%>>이벤트 목록</a></li>
		<li ><a href="/vodman/event/frm_event_AddSub.jsp?mcode=0802" title="이벤트 생성" <%if(mcode.equals("0802")) {out.println("class='visible'");}%>>이벤트 생성</a></li>
		</ul>
		<p class="menu_bottom"></p>
</div>

