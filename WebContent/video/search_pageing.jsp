<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
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
 
	document.form1._page_.value=page; 
	document.form1.submit();
}
// -->
</script>
<noscript>
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 
</noscript>
 
<div class="paginate">

    <%  if (pageBean.getCurrentPage() != 1) { %>
			<a href="javascript:goPage('1');" class="pre" title="ù������"><img src="../css/icon_left3.gif" alt="ó��" /></a>
			<!--<img src="/2012/include/images/but_ll.gif" alt="ù������" /></a>-->
	<% } %>

	<% if (pageBean.getCurrentBlock() != 1) { %>
			<a href="javascript:goPage('<%=((pageBean.getCurrentBlock()-2)*pageBean.getPagePerBlock()+1)%>');" class="pre" title="����������"><img src="../css/icon_left2.gif" alt="����" /></a>
			<!--<img src="/2012/include/images/but_l.gif" alt="����������" /></a>-->
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
			<a href="javascript:goPage('<%= pageBean.getCurrentBlock()*pageBean.getPagePerBlock()+ 1%>');" class="next" title="����������"><img src="../css/icon_right2.gif" alt="����" /></a>
			<!--<img src="/2012/include/images/but_r.gif" alt="����������" /></a>-->
	<%
			}
	%>

	<%
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) {
	%>
			<a href="javascript:goPage('<%= pageBean.getTotalPage() %>');" class="next" title="������������"><img src="../css/icon_right3.gif" alt="������" /></a>
			<!--<img src="/2012/include/images/but_rr.gif" alt="������������" /></a>-->
	<%
			}
	%>

</div>
<%
	}
%>
<!-- ----------------------------------- -->
<!--	// 0. ��ũ ���� ��                -->
<!-- ----------------------------------- -->

