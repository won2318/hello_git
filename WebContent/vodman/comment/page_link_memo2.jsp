<%@ page contentType="text/html; charset=euc-kr"%>
<!-- ----------------------------------- -->
<!--	// 0. ��ũ ���� ����               -->
<!-- ----------------------------------- -->


<%
    String jspNameMemo = "comment.jsp";

//if (mPageBean.getTotalRecord() > mPageBean.getLinePerPage()) 
//{
		String argumentMemo ="&ocode="+paramOcode+"&flag="+flag;
%>

<div class="paginate">

<%
	if (mPageBean.getTotalRecord() > mPageBean.getLinePerPage()) 
	{
%>
 <%		if (mPageBean.getCurrentPage() != 1) { %>					
					<a href="<%= jspNameMemo %>?mpage=1<%= argumentMemo%>" class="pre" title="ù������"><img src="/vodman/include/images/but_rr.gif" alt="ù������" /></a>
<%		 } %>
<%		if (mPageBean.getCurrentBlock() != 1) { %>
					<a href="<%= jspNameMemo %>?mpage=<%=((mPageBean.getCurrentBlock()-2)*mPageBean.getPagePerBlock()+1)%><%=argumentMemo%>" class="pre" title="����������"><img src="/vodman/include/images/but_r.gif" alt="����������" /></a>
<%		} %>
<%	
		for (int b=mPageBean.getStartPage(); b<=mPageBean.getEndPage(); b++) {	
			if (b != mPageBean.getCurrentPage()){	
	  %>
				<a href="<%= jspNameMemo %>?mpage=<%=b%><%=argumentMemo%>" class="first-child"><%=b%></a>
<%
			}
			else{ 
	  %>
				<strong><%=b%></strong>
 <%	
			} // the end of else statement
		} // the end of for statement	
      %>
					
 <%				 
		if ( (mPageBean.getCurrentBlock()/(mPageBean.getPagePerBlock()+0.0)) 
				< (mPageBean.getTotalBlock()/(mPageBean.getPagePerBlock()+0.0)) ) 
		{		
	  %>
				<a href="<%= jspNameMemo %>?mpage=<%= mPageBean.getCurrentBlock()*mPageBean.getPagePerBlock()+ 1%><%=argumentMemo%>" class="next" title="����������"><img src="/vodman/include/images/but_l.gif" alt="����������" /></a>
<%			
		}
	  %>
      <%	
		if (mPageBean.getCurrentPage() < mPageBean.getTotalPage()) {
	  %>
			<a href="<%= jspNameMemo %>?mpage=<%= mPageBean.getTotalPage() %><%=argumentMemo%>" class="next" title="������������"><img src="/vodman/include/images/but_ll.gif" alt="������������" /></a>
 <%				 
		}
	  %>
<%		 
	}
//}
%>
</div>

