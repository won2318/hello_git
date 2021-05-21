<%@ page contentType="text/html; charset=euc-kr"%>
<%
  
if (pageBean.getTotalRecord() > pageBean.getLinePerPage()) {
	String argument = strLink;
%>

<table border="0" cellpadding="0" cellspacing="0">
  <tr align="center">
    <td class="small">

    <%  if (pageBean.getCurrentPage() != 1) { %>
	<!--<span style="cursor:hand" onClick="javascript:location.href='<%= jspName %>?page=1<%= argument %>';">[first]</span>-->
	<%-- <a class="small" onfocus='this.blur()' href="<%= jspName %>?page=1<%= argument %>">[first]</a> --%>
	<% } %>

	<% if (pageBean.getCurrentBlock() != 1) { %>
	<a class="small" onfocus='this.blur()' href="<%= jspName %>?page=<%=((pageBean.getCurrentBlock()-2)*pageBean.getPagePerBlock()+1)%><%=argument%>"><<</a>
	<%
		} // the end of if statement
	%>


	<%
			for (int b=pageBean.getStartPage(); b<=pageBean.getEndPage(); b++) {
				if (b != pageBean.getCurrentPage()){
	%>
<%--				&nbsp;<span style="cursor:hand" onClick="javascript:location.href='<%= jspName %>?page=<%= b %><%=argument%>';"><%=b%></span> --%>
				&nbsp;<a class="small" onfocus='this.blur()' href="<%= jspName %>?page=<%= b%><%=argument%>"><%= b%></a>
	<%
				}else{
	%>
<%--				<span style="cursor:hand" onClick="javascript:location.href='<%= jspName %>?page=<%= b %><%=argument%>';"><strong><%= b %></strong></span> --%>
				<a class="small" onfocus='this.blur()' href="<%= jspName %>?page=<%= b%><%=argument%>"><strong><%= b%></strong></a>
	<%
				} // the end of else statement
			} // the end of for statement
	%>

	<%
			if ( (pageBean.getCurrentBlock()/(pageBean.getPagePerBlock()+0.0)) < (pageBean.getTotalBlock()/(pageBean.getPagePerBlock()+0.0)) ) {
	%>
				<a class="small" onfocus='this.blur()' href="<%= jspName %>?page=<%= pageBean.getCurrentBlock()*pageBean.getPagePerBlock()+ 1%><%=argument%>">>></a>
	<%
			}
	%>

	<%
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) {
	%>
			<!--<a class="cate" onfocus='this.blur()' href="<%= jspName %>?page=<%= pageBean.getTotalPage() %><%=argument%>"><font color="black">[end] </font></a>-->
	<%
			}
	%>

    </td>
  </tr>
</table>
<%
	}
%>