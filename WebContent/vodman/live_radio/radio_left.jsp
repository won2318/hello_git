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
			<h2><img src="/vodman/include/images/a_menu05_title.gif" alt="���̴� ����"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/live_radio/mng_vodRealList.jsp?mcode=0501" title="���̴� ���� ���" <%if(mcode.equals("0501")) {out.println("class='visible'");}%>>���̴� ���� ���</a></li>
			<li ><a href="/vodman/live_radio/frm_rvodAdd.jsp?mcode=0502" title="���̴� ���� ���" <%if(mcode.equals("0502")) {out.println("class='visible'");}%>>���̴� ���� ���</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>
