<%@ page contentType="text/html; charset=euc-kr"%>
<!-- ----------------------------------- -->
<!--	// 0. 링크 연결 시작               -->
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
					<a href="<%= jspNameMemo %>?mpage=1<%= argumentMemo%>" class="pre" title="첫페이지"><img src="/vodman/include/images/but_rr.gif" alt="첫페이지" /></a>
<%		 } %>
<%		if (mPageBean.getCurrentBlock() != 1) { %>
					<a href="<%= jspNameMemo %>?mpage=<%=((mPageBean.getCurrentBlock()-2)*mPageBean.getPagePerBlock()+1)%><%=argumentMemo%>" class="pre" title="이전페이지"><img src="/vodman/include/images/but_r.gif" alt="이전페이지" /></a>
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
				<a href="<%= jspNameMemo %>?mpage=<%= mPageBean.getCurrentBlock()*mPageBean.getPagePerBlock()+ 1%><%=argumentMemo%>" class="next" title="다음페이지"><img src="/vodman/include/images/but_l.gif" alt="다음페이지" /></a>
<%			
		}
	  %>
      <%	
		if (mPageBean.getCurrentPage() < mPageBean.getTotalPage()) {
	  %>
			<a href="<%= jspNameMemo %>?mpage=<%= mPageBean.getTotalPage() %><%=argumentMemo%>" class="next" title="마지막페이지"><img src="/vodman/include/images/but_ll.gif" alt="마지막페이지" /></a>
 <%				 
		}
	  %>
<%		 
	}
//}
%>
</div>

