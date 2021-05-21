
<%
 
if (pageBean.getTotalRecord() > pageBean.getLinePerPage()) {
 
%>
 
    <%  if (pageBean.getCurrentPage() != 1) { %>
	<!--<span style="cursor:hand" onClick="javascript:go_page('1');">[first]</span>-->
	<% } %>

	<% if (pageBean.getCurrentBlock() != 1) { %>
	<a class="small" onfocus='this.blur()' href="javascript:go_page('<%=((pageBean.getCurrentBlock()-2)*pageBean.getPagePerBlock()+1)%>');"><<</a>
	<%
		} // the end of if statement
	%>


	<%
			for (int b=pageBean.getStartPage(); b<=pageBean.getEndPage(); b++) {
				if (b != pageBean.getCurrentPage()){
	%>
				&nbsp;<a href="javascript:go_page('<%= b %>');"> <%=b%> </a>
	<%
				}else{
	%>
				<a href="javascript:go_page('<%= b %>');"><strong><%= b %></strong></a>
	<%
				} // the end of else statement
			} // the end of for statement
	%>

	<%
			if ( (pageBean.getCurrentBlock()/(pageBean.getPagePerBlock()+0.0)) < (pageBean.getTotalBlock()/(pageBean.getPagePerBlock()+0.0)) ) {
	%>
				<a class="small" onfocus='this.blur()' href="javascript:go_page('<%= pageBean.getCurrentBlock()*pageBean.getPagePerBlock()+ 1%>');">>></a>
	<%
			}
	%>

	<%
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) {
	%>
			<!--<a class="cate" onfocus='this.blur()' href="javascript:go_page('<%= pageBean.getTotalPage() %>');"><font color="black">[end] </font></a>-->
	<%
			}
	%>

<%
	}
%>