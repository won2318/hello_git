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
			<h2><img src="/vodman/include/images/a_menu06_title.gif" alt="����۰���"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/live/mng_vodRealList.jsp?mcode=0601" title="����� ���" <%if(mcode.equals("0601")) {out.println("class='visible'");}%>>����� ���</a></li>
			<li ><a href="/vodman/live/frm_rvodAdd.jsp?mcode=0602" title="����� ���" <%if(mcode.equals("0602")) {out.println("class='visible'");}%>>����� ���</a></li>
			<li ><a href="/vodman/live/mng_boardListComment.jsp?mcode=0603&flag=L" title="����� ���" <%if(mcode.equals("0603")) {out.println("class='visible'");}%>>����� ��۰���</a></li>
			<li ><a href="/vodman/live/frm_connectionCount1.jsp?mcode=0604" title="����� ����͸�" <%if(mcode.equals("0604")) {out.println("class='visible'");}%>>����� ����͸�</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>
