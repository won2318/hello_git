<%@ page contentType="text/html; charset=euc-kr"%>
<%
	/**
	 * @author ������
	 *
	 * @description : ī�װ� ���.
	 * date : 2009-10-19
	 */
%>
		<div id="menu">
			<h2><img src="/vodman/include/images/a_menu03_title.gif" alt="ī�װ�����"/></h2>
			<ul class="s_menu_bg">
			<li ><a href="/vodman/category/mng_categoryList.jsp?mcode=0401&ctype=<%=ctype%>" title="ī�װ� ���" <%if(mcode.equals("0401")) {out.println("class='visible'");}%>>ī�װ� ���</a></li>
			<li ><a href="/vodman/category/frm_categoryAdd.jsp?mcode=0402&ctype=<%=ctype%>" title="ī�װ� ���" <%if(mcode.equals("0402")) {out.println("class='visible'");}%>>ī�װ� ���</a></li>
			</ul>
			<p class="menu_bottom"></p>
		</div>