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
			<h2><img src="/vodman/include/images/a_menu07_title.gif" alt="������"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/member/mng_memberList.jsp?mcode=1001" title="������ ���" <%if(mcode.equals("1001")) {out.println("class='visible'");}%>>������ ���</a></li>
			<li ><a href="/vodman/member/frm_memberAdd_new.jsp?mcode=1002&level=9" title="������ ���" <%if(mcode.equals("1002")) {out.println("class='visible'");}%>>������ ���</a></li>
			<li ><a href="/vodman/member/mng_memberList.jsp?mcode=1004&slevel=2" title="����͸��� ���" <%if(mcode.equals("1004")) {out.println("class='visible'");}%>>����͸��� ���</a></li>
			<li ><a href="/vodman/member/frm_memberAdd_new.jsp?mcode=1003&level=2" title="����͸��� ���" <%if(mcode.equals("1003")) {out.println("class='visible'");}%>>����͸��� ���</a></li>
			<li ><a href="/vodman/member/mng_member_logList.jsp?mcode=1008" title="������ �α�" <%if(mcode.equals("1008")) {out.println("class='visible'");}%>>������ �α�</a></li>
		   <li ><a href="/vodman/member/mng_admin_logList.jsp?mcode=1007" title="������ ���� ���" <%if(mcode.equals("1007")) {out.println("class='visible'");}%>>������ ���� ���</a></li> 
		     <%--  <li ><a href="/vodman/member/mng_vod_log2_test.jsp?mcode=1009" title="vod_log2_�׽�Ʈ" <%if(mcode.equals("1009")) {out.println("class='visible'");}%>>vod_log2_�׽�Ʈ</a></li> --%>
<!--			<li ><a href="/vodman/member/frm_sendMail.jsp?mcode=1007" title="���Ϻ�����" <%if(mcode.equals("1007")) {out.println("class='visible'");}%>>���Ϻ�����</a></li>
 
			<li><a href="/vodman/me/mng_buseoList.jsp?mcode=1003" title="�μ� ���" <%if(mcode.equals("1003")) {out.println("class='visible'");}%>>�μ� ���</a></li>
			<li ><a href="/vodman/me/frm_buseoAdd.jsp?mcode=1004" title="�μ� ����" <%if(mcode.equals("1004")) {out.println("class='visible'");}%>>�μ� ����</a></li>
			<li><a href="/vodman/me/mng_grayList.jsp?mcode=1005" title="���� ���" <%if(mcode.equals("1005")) {out.println("class='visible'");}%>>���� ���</a></li>
			<li><a href="/vodman/me/frm_grayAdd.jsp?mcode=1006" title="���� ����" <%if(mcode.equals("1006")) {out.println("class='visible'");}%>>���� ����</a></li>
-->
			</ul>
			<p class="menu_bottom"></p>
</div>