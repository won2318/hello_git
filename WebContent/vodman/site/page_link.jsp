
<%
    
if (pageBean.getTotalRecord() > pageBean.getLinePerPage()) {
	String argument = strLink;
%>

<div class="paginate">

    <%  if (pageBean.getCurrentPage() != 1) { %>
	<!-- <a href="<%= jspName %>?mcode=<%=mcode%>&page=1<%= argument %>" class="pre" title="ù������"><img src="/vodman/include/images/but_rr.gif" alt="����������" /></a> -->
	<% } %>

	<% if (pageBean.getCurrentBlock() != 1) { %>
	<a href="<%= jspName %>?mcode=<%=mcode%>&page=<%=((pageBean.getCurrentBlock()-2)*pageBean.getPagePerBlock()+1)%><%=argument%>" class="pre" title="����������"><img src="/vodman/include/images/but_r.gif" alt="ù������" /></a>
	<%
		} // the end of if statement
	%>


	<%
			for (int b=pageBean.getStartPage(); b<=pageBean.getEndPage(); b++) {
				if (b != pageBean.getCurrentPage()){
	%>
				<a href="<%= jspName %>?mcode=<%=mcode%>&page=<%= b %><%=argument%>"><%=b%></a>
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
				<a href="<%= jspName %>?mcode=<%=mcode%>&page=<%= pageBean.getCurrentBlock()*pageBean.getPagePerBlock()+ 1%><%=argument%>" class="next" title="����������"><img src="/vodman/include/images/but_l.gif" alt="����������" /></a>
	<%
			}
	%>

	<%
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) {
	%>
			<!-- <a href="<%= jspName %>?mcode=<%=mcode%>&page=<%= pageBean.getTotalPage() %><%=argument%>" class="next" title="������������"><img src="/vodman/include/images/but_ll.gif" alt="������������" /></a> -->
	<%
			}
	%>

</div>
<%
	}
%>