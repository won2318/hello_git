<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- ----------------------------------- -->
<!--	// 0. ��ũ ���� ����               -->
<!-- ----------------------------------- -->


<%
    

    if (pageBean.getTotalRecord() > pageBean.getLinePerPage()) {
%>
<script language="JavaScript">
<!--
function goPage(page)
{
	var path_='<%= jspName %>?ccode=<%=ccode%>';
	document.form1._page_.value=page;
	document.form1.action=path_;
	document.form1.submit();
}
// -->
</script>
<noscript>
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 
</noscript>
 
<span class="paginate">

    <%  if (pageBean.getCurrentPage() != 1) { %>
			<a href="javascript:goPage('1');" class="back1" title="ù������"><img src="../include/images/icon_back2.gif" alt="ù������" /></a>
	<% } %>

	<% if (pageBean.getCurrentBlock() != 1) { %>
			<a href="javascript:goPage('<%=((pageBean.getCurrentBlock()-2)*pageBean.getPagePerBlock()+1)%>');" class="back2" title="����������"><img src="../include/images/icon_back1.gif" alt="����������" /></a>

	<%
		} // the end of if statement
	%>


	<%
			for (int b=pageBean.getStartPage(); b<=pageBean.getEndPage(); b++) {
				if (b != pageBean.getCurrentPage()){
	%>
				<a href="javascript:goPage('<%= b %>');"><%=b%></a>
	<%
				}else{
	%>
				<strong><%= b %></strong>
	<%
				} // the end of else statement
			} // the end of for statement
	%>

	<%
			if ( (pageBean.getCurrentBlock()/(pageBean.getPagePerBlock()+0.0)) < (pageBean.getTotalBlock()/(pageBean.getPagePerBlock()+0.0)) ) {
	%>
			<a href="javascript:goPage('<%= pageBean.getCurrentBlock()*pageBean.getPagePerBlock()+ 1%>');"  class="next1" title="����������"><img src="../include/images/icon_next1.gif" alt="����������" /></a>

	<%
			}
	%>

	<%
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) {
	%>
			<a href="javascript:goPage('<%= pageBean.getTotalPage() %>');" class="next2" title="������������"><img src="../include/images/icon_next2.gif" alt="������������" /></a>

	<%
			}
	%>

</span>
<%
	}
%>
<!-- ----------------------------------- -->
<!--	// 0. ��ũ ���� ��                -->
<!-- ----------------------------------- -->

