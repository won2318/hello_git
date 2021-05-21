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
		<li ><a href="/vodman/subject/frm_subjectList.jsp?mcode=0801&sub_flag=S" title="설문 목록" <%if(sub_flag.equals("S")) {out.println("class='visible'");}%>>설문 목록</a></li>
		<li ><a href="/vodman/subject/frm_subjectList.jsp?mcode=0802&sub_flag=H" title="핫세븐 설문" <%if(sub_flag.equals("H")) {out.println("class='visible'");}%>>핫세븐 목록</a></li>
		<li ><a href="/vodman/subject/frm_subjectList.jsp?mcode=0803&sub_flag=E" title="이벤트 목록" <%if(sub_flag.equals("E")) {out.println("class='visible'");}%>>이벤트 목록</a></li>
	
		</ul>
		<p class="menu_bottom"></p>
	</div>
	
	
 