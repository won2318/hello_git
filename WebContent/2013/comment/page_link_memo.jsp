<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- ----------------------------------- -->
<!--	// 0. 링크 연결 시작               -->
<!-- ----------------------------------- -->
<%
      if (mPageBean.getTotalRecord() > mPageBean.getLinePerPage()) {
 %>

<div class="paginate">
 

	<% if (mPageBean.getCurrentBlock() != 1) { %>
	<a href="javascript:page_go(<%=((mPageBean.getCurrentBlock()-2)*mPageBean.getPagePerBlock()+1)%>)" class="pre" title="이전페이지"></a>
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
				<a href="javascript:page_go(<%= mPageBean.getCurrentBlock()*mPageBean.getPagePerBlock()+ 1%>)" class="next" title="다음페이지"></a>
	<%
			}
	%>

 </div>
<%
	}
%>

<!-- ----------------------------------- -->
<!--	// 0. 링크 연결 끝                -->
<!-- ----------------------------------- -->
