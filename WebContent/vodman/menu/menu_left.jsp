<%@ page contentType="text/html; charset=euc-kr"%>
		<div id="menu">
			<h2><img src="/vodman/include/images/a_menu09_title.gif" alt="메뉴관리"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/menu/mng_menuList.jsp?mcode=0301" title="메뉴 목록" <%if(mcode.equals("0301")) {out.println("class='visible'");}%>>메뉴 목록</a></li>
			<li ><a href="/vodman/menu/frm_menuAdd.jsp?mcode=0302" title="메뉴 등록" <%if(mcode.equals("0302")) {out.println("class='visible'");}%>>메뉴 등록</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>