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
		<h2><img src="/vodman/include/images/a_menu12_title.gif" alt="�̺�Ʈ����"/></h2>
		<ul class="s_menu_bg">
		<li ><a href="/vodman/subject/frm_subjectList.jsp?mcode=0801&sub_flag=S" title="���� ���" <%if(sub_flag.equals("S")) {out.println("class='visible'");}%>>���� ���</a></li>
		<li ><a href="/vodman/subject/frm_subjectList.jsp?mcode=0802&sub_flag=H" title="�ּ��� ����" <%if(sub_flag.equals("H")) {out.println("class='visible'");}%>>�ּ��� ���</a></li>
		<li ><a href="/vodman/subject/frm_subjectList.jsp?mcode=0803&sub_flag=E" title="�̺�Ʈ ���" <%if(sub_flag.equals("E")) {out.println("class='visible'");}%>>�̺�Ʈ ���</a></li>
	
		</ul>
		<p class="menu_bottom"></p>
	</div>
	
	
 