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
			<h2><img src="/vodman/include/images/a_menu01_title.gif" alt="����Ʈ����"/></h2>
			<ul class="s_menu_bg">
<%-- 			<li ><a href="frm_popList.jsp?mcode=0101" title="�˾�����" <%if(mcode.equals("0101")) {out.println("class='visible'");}%>>�˾�����</a></li> --%>
<%-- 	 
			<li ><a href="mng_authority.jsp?mcode=0102" title="���Ѱ���(����)" <%if(mcode.equals("0102")) {out.println("class='visible'");}%>>���Ѱ���(����)</a></li>
			--%>
 			<li class="menu01_03"><a href="mng_authority_admin.jsp?mcode=0103" title="���Ѱ���(������)" <%if(mcode.equals("0103")) {out.println("class='visible'");}%>>���Ѱ���(������)</a></li> 
			 
			<!-- <li ><a href="mng_poll.jsp?mcode=0104" title="��������" <%if(mcode.equals("0104")) {out.println("class='visible'");}%>>��������</a></li> --> 
			<li ><a href="mng_fuckList.jsp?mcode=0109" title="�弳����" <%if(mcode.equals("0109")) {out.println("class='visible'");}%>>�弳����</a></li>

			<li ><a href="frm_mainLogo.jsp?mcode=0105" title="�ΰ����" <%if(mcode.equals("0105")) {out.println("class='visible'");}%>>�ΰ����</a></li>		
<%-- 			<li ><a href="mng_stat_hit.jsp?mcode=0107" title="��û���(�׷���)" <%if(mcode.equals("0107")) {out.println("class='visible'");}%>>��û���(�׷���)</a></li> --%>
			<li ><a href="mng_stat_count2.jsp?mcode=0107" title="��û���(�׷���)" <%if(mcode.equals("0107")) {out.println("class='visible'");}%>>��û���(�׷���)</a></li>
			<li ><a href="mng_stat_menu_hit_total.jsp?mcode=0113" title="��û���" <%if(mcode.equals("0113")) {out.println("class='visible'");}%>>��û���</a></li>
			<li ><a href="mng_view_stat.jsp?mcode=0108" title="��û�α׺���" <%if(mcode.equals("0108")) {out.println("class='visible'");}%>>��û�α׺���</a></li>
<%--  			<li ><a href="mng_month_log.jsp?mcode=0110" title="���󺰽�û����" <%if(mcode.equals("0110")) {out.println("class='visible'");}%>>���󺰽�û����</a></li> --%>

			<!-- <li ><a href="mng_stat_menu.jsp?mcode=0111" title="�޴�Ŭ�����" <%if(mcode.equals("0111")) {out.println("class='visible'");}%>>�޴�Ŭ�����</a></li> -->
<%-- 			<li ><a href="mng_stat.jsp?mcode=0106" title="������躸��" <%if(mcode.equals("0106")) {out.println("class='visible'");}%>>������躸��</a></li> --%>
			<li ><a href="mng_stat_2.jsp?mcode=0106" title="������躸��" <%if(mcode.equals("0106")) {out.println("class='visible'");}%>>������躸��</a></li>
<%-- 			<li ><a href="mng_stat_menu_total.jsp?mcode=0112" title="�޴�Ŭ���������" <%if(mcode.equals("0112")) {out.println("class='visible'");}%>>�޴�Ŭ�����</a></li>					 --%>
			<li ><a href="mng_cate_stat.jsp?mcode=0115" title="�з��� ���/��û���" <%if(mcode.equals("0115")) {out.println("class='visible'");}%>>�з��� ���/��û���</a></li>
			<li ><a href="mng_web_log.jsp?mcode=0116" title="���α�" <%if(mcode.equals("0116")) {out.println("class='visible'");}%>>���α�</a></li>
			<li ><a href="mng_web_count_stat.jsp?mcode=0117" title="��� ī��Ʈ" <%if(mcode.equals("0117")) {out.println("class='visible'");}%>>��� ī��Ʈ</a></li>
			<li ><a href="proc_backupdb.jsp?mode=doit" title="DB�������">DB�������</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>