<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- ----------------------------------- -->
<!--	// 0. ��ũ ���� ����               -->
<!-- ----------------------------------- -->
<%
    String jspNameMemo = "comment.jsp";

    if (mPageBean.getTotalRecord() > mPageBean.getLinePerPage()) {
	String argumentMemo ="&ocode="+ocode+"&ccode="+ccode+"&flag="+flag;
%>

<div class="paginate">


    <%  if (mPageBean.getCurrentPage() != 1) { %>
	<!-- 	<a href="javascript:location.href='<%= jspNameMemo %>?mpage=1<%= argumentMemo %>';" class="pre" title="ù������"><img src="/include/images/but_ll.gif" alt="����������" /></a> -->
	<% } %>

	<% if (mPageBean.getCurrentBlock() != 1) { %>
	<a href="javascript:page_go(<%=((mPageBean.getCurrentBlock()-2)*mPageBean.getPagePerBlock()+1)%><%=argumentMemo%>)" class="pre" title="����������"></a>
	<%
		} // the end of if statement
	%>

	<%
			for (int b=mPageBean.getStartPage(); b<=mPageBean.getEndPage(); b++) {
				if (b != mPageBean.getCurrentPage()){
	%>
				<a href="javascript:page_go(<%= b %>);"><%=b%></a>
	<%
				}else{
	%>
				<strong><%=b%></strong>
	<%
				} // the end of else statement
			} // the end of for statement
	%>
	<%
			if ( (mPageBean.getCurrentBlock()/(mPageBean.getPagePerBlock()+0.0)) < (mPageBean.getTotalBlock()/(mPageBean.getPagePerBlock()+0.0)) ) {
	%>
				<a href="javascript:page_go(<%= mPageBean.getCurrentBlock()*mPageBean.getPagePerBlock()+ 1%>)" class="next" title="����������"></a>
	<%
			}
	%>

	<%
			if (mPageBean.getCurrentPage() < mPageBean.getTotalPage()) {
	%>
<!-- 			<a href="<%= jspNameMemo %>?mpage=<%= mPageBean.getTotalPage() %><%=argumentMemo%>" class="next" title="������������"><img src="/include/images/but_rr.gif" alt="������������" /></a> -->
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
