<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	if (pageBean.getTotalRecord() > pageBean.getLinePerPage()){
%>
<div class="paginate">
<%		
		if(pageBean.getTotalPage() > 1){
			if(pageBean.getCurrentPage() != 1 && pageBean.getCurrentBlock() != 1){
%>
				<a  class="back2" href="javascript:goPage(<%=pageBean.getCurrentPage()-1%>);"  title="����������">
					<img src="../include/images/icon_back1.gif" alt="����������" />
				</a>
<%
			}
		}	  
		for (int b=pageBean.getStartPage(); b<=pageBean.getEndPage(); b++){
			if (b != pageBean.getCurrentPage()){
%>
					<a href="javascript:goPage(<%= b %>);" title="<%=b%>page�� �̵�"><%= b %></a>
<%
			}else{%>
					<strong><%=b%></strong>
<%
			}
		}

		if(pageBean.getTotalPage() > 1){
			if(pageBean.getTotalPage() > pageBean.getCurrentPage() && pageBean.getTotalBlock() > pageBean.getCurrentBlock()){
%>				
				<a  href="javascript:goPage(<%= pageBean.getCurrentPage()+1 %>);" class="next1" title="����������" >
					<img src="../include/images/icon_next1.gif" alt="����������" />					 
				</a>		
<%		
			}
		}
%></div>
<%		
	}
%>

 
				