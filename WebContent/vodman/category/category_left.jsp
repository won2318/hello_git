<%@ page contentType="text/html; charset=euc-kr"%>
<%
	/**
	 * @author 박종성
	 *
	 * @description : 카테고리 등록.
	 * date : 2009-10-19
	 */
%>
		<div id="menu">
			<h2><img src="/vodman/include/images/a_menu03_title.gif" alt="카테고리관리"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/category/mng_categoryList.jsp?mcode=0401&ctype=<%=ctype%>" title="카테고리 목록" <%if(mcode.equals("0401")) {out.println("class='visible'");}%>>카테고리 목록</a></li>
			<li ><a href="/vodman/category/frm_categoryAdd.jsp?mcode=0402&ctype=<%=ctype%>" title="카테고리 등록" <%if(mcode.equals("0402")) {out.println("class='visible'");}%>>카테고리 등록</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>