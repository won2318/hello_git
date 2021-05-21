<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- ----------------------------------- -->
<!--	// 0. 링크 연결 시작               -->
<!-- ----------------------------------- -->


<%
    

    if (pageBean.getTotalRecord() > pageBean.getLinePerPage()) {
%>
<script language="JavaScript">
<!--
function goPage(page)
{
	var path_='<%= jspName %>?ccode=<%=ccode%>';
	document.form1._page_.value=page;
	document.form1.action=path_;
	document.form1.submit();
}
// -->
</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
</noscript>
 
<div class="paginate">

    <%  if (pageBean.getCurrentPage() != 1) { %>
			<a href="javascript:goPage('1');" class="pre" title="첫페이지">첫페이지</a>
			<!--<img src="/2012/include/images/but_ll.gif" alt="첫페이지" /></a>-->
	<% } %>

	<% if (pageBean.getCurrentBlock() != 1) { %>
			<a href="javascript:goPage('<%=((pageBean.getCurrentBlock()-2)*pageBean.getPagePerBlock()+1)%>');" class="pre" title="이전페이지">이전</a>
			<!--<img src="/2012/include/images/but_l.gif" alt="이전페이지" /></a>-->
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
			<a href="javascript:goPage('<%= pageBean.getCurrentBlock()*pageBean.getPagePerBlock()+ 1%>');" class="next" title="다음페이지">다음</a>
			<!--<img src="/2012/include/images/but_r.gif" alt="다음페이지" /></a>-->
	<%
			}
	%>

	<%
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) {
	%>
			<a href="javascript:goPage('<%= pageBean.getTotalPage() %>');" class="next" title="마지막페이지">마지막페이지</a>
			<!--<img src="/2012/include/images/but_rr.gif" alt="마지막페이지" /></a>-->
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

