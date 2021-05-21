<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
 
Vector vt = null;
com.hrlee.sqlbean.MediaManager mgr = com.hrlee.sqlbean.MediaManager.getInstance();
String flag = "V";
if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0 && !request.getParameter("flag").equals("null")){
	flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
}
String yy = request.getParameter("yy").replaceAll("<","").replaceAll(">","");
String mm = request.getParameter("mm").replaceAll("<","").replaceAll(">","");
if (yy != null && yy.length() > 0 && mm != null && mm.length() > 0) {
	vt =  mgr.month_cnt_log(yy,mm, flag);
}
 
%>

<%@ include file="/vodman/include/top.jsp"%>
<script>
	function go_month_view(){
 
		//location.href='mng_month_log.jsp?flag='+document.getElementById("flag").value+'&yy='+document.getElementById("year").value +'&mm='+document.getElementById("month").value ;
		document.frmMedia.action="mng_month_log.jsp";
		document.frmMedia.submit();
	}

	function go_month_excel(){
 	 	//location.href='mng_month_log_excel.jsp?flag='+document.getElementById("flag").value+'&yy='+document.getElementById("year").value +'&mm='+document.getElementById("month").value ;
 	 	location.href='mng_month_log_excel2.jsp?flag='+document.getElementById("flag").value+'&yy='+document.getElementById("yy").value +'&mm='+document.getElementById("mm").value ;
<%--  	 	//location.href="mng_month_log_excel2.jsp?year="+result1+"&month="+result2+"&date="+result3+"&flag=<%=flag%>"; --%>
 	}
	function input_log(){
		alert('이전달 통계를 입력합니다.');
		location.href="proc_month_log_input.jsp";
	}
	
</script>
<%@ include file="/vodman/site/site_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>영상별시청누계</span><a href="javascript:input_log();">&nbsp;</a></h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>월별통계 목록</span></p>
			 
			<div id="content">
 
 				 
				<table cellspacing="0" class="connection_list" summary="월별통계">
				<caption>시청통계 통계(종합)</caption>
				<colgroup>
					<col width="20%"/>
					<col width="20%" />
 					<col width="20%"/>
 					<col width="20%" />
 					<col width="20%" />
				</colgroup>
				<thead>
				<form name="frmMedia" method="post">
					<input type="hidden" name="mcode" value="<%=mcode%>">
 					<input type="hidden" name="search_true" value="Y">
					<input type="hidden" id="flag" name="flag" value="<%=flag%>" />
					
				<tr>
					<td colspan="5">
					<select name="yy" id="yy" class="sec01" style="width:60px;">
						<% for(int year=2012; year < 2020; year++) { %>
						<option value='<%=year%>' <%if (yy != null && Integer.parseInt(yy)==year ) {out.println("selected");} %>><%=year%></option>
						<%} %>

					</select> 년
					<select name="mm" id="mm" class="sec01" style="width:40px;">
					<% for(int month=1; month <= 12; month++) {
						String temp_month = month+"" ;
						if (month < 10 ) {
							temp_month = "0"+month ;
						}
					%>
						<option value='<%=temp_month%>'  <%if (mm != null && mm.equals(temp_month) ) {out.println("selected");} %>><%=temp_month%></option>
					<%} %>
					</select> 월
					<a href="javascript:go_month_view();"><img src="/vodman/include/images/but_search.gif" alt="검색" border="0"></a>
					&nbsp;&nbsp;<a href="javascript:go_month_excel();"><img src="/vodman/include/images/but_excel.gif" alt="Excel받기" border="0"></a>
					</td>
				</tr>
					<tr>
						<th>날짜</th>
						<th>영상제목</th>
						<th>영상분류</th>
						<th>hit</th>
						<th>삭제구분</th>
					</tr>
				</thead>
				<tbody>
				<% if (vt != null && vt.size() > 0) {
					for(int i = 0; i < vt.size() ; i++) {
				%>
 					<tr  class="height_25 font_127">
 						<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(1)%>-<%=((Vector)(vt.elementAt(i))).elementAt(2)%></b></td>
						<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(4)%></b></td>
						<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(6)%></b></td>
	 
						<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(0)%></b></td>
						<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(5)%></b></td>
					</tr>
				<%} } else {%>
					<tr>
 						<td colspan="5"><b>검색된 정보가 없습니다.</b></td>
					</tr>
				<%} %>
				</tbody>
				</table>
				<IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0"></IFRAME>
 
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>