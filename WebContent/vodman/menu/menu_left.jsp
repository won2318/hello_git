<%@ page contentType="text/html; charset=euc-kr"%>
		<div id="menu">
			<h2><img src="/vodman/include/images/a_menu09_title.gif" alt="�޴�����"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/menu/mng_menuList.jsp?mcode=0301" title="�޴� ���" <%if(mcode.equals("0301")) {out.println("class='visible'");}%>>�޴� ���</a></li>
			<li ><a href="/vodman/menu/frm_menuAdd.jsp?mcode=0302" title="�޴� ���" <%if(mcode.equals("0302")) {out.println("class='visible'");}%>>�޴� ���</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>