<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<div class="paginate">
<%
	if (pageBean.getTotalRecord() > pageBean.getLinePerPage()){
		if(pageBean.getTotalPage() > 1){
			if(pageBean.getCurrentPage() != 1 && pageBean.getCurrentBlock() != 1){
%>
				<a  class="pre" href="javascript:goPage(<%=pageBean.getCurrentPage()-1%>);"  title="이전페이지">
					<%-- <img src="../include/images/icon_left2.gif" alt="이전페이지" /> --%> 이전
				</a>
<%
			}
		}	 


		for (int b=pageBean.getStartPage(); b<=pageBean.getEndPage(); b++){
			if (b != pageBean.getCurrentPage()){
%>
					<a href="javascript:goPage(<%= b %>);" title="<%=b%>page로 이동"><%= b %></a>
<%
			}else{
%>
					<strong><%=b%></strong>
<%
			}
		}

		if(pageBean.getTotalPage() > 1){
			if(pageBean.getTotalPage() > pageBean.getCurrentPage() && pageBean.getTotalBlock() > pageBean.getCurrentBlock()){
%>				
				<a  href="javascript:goPage(<%= pageBean.getCurrentPage()+1 %>);" class="next" title="다음페이지">
					<%-- <img src="../include/images/icon_right2.gif" alt="다음페이지" /> --%> 다음
				</a>		
<%		
			}
		}
	}
%>
</div>

 
				