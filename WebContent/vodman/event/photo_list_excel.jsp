<%@ page language="java" contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
 
<%
if ((String)session.getValue("admin_id") != null &&  session.getValue("admin_id").toString().length() > 0) {
 
Vector vt = null;
 
String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "list_id");
	String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

String field = com.vodcaster.utils.TextUtil.getValue(request.getParameter("field"));
String searchstring = "";
try{
	searchstring = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchstring")));
}catch(Exception ex){
	searchstring = "";
}
if(field == null) field = "";
if(searchstring == null) searchstring = "";

int pg = 1;
if(request.getParameter("page") != null && com.yundara.util.TextUtil.isNumeric(request.getParameter("page"))){
	try{
		Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("page")));
	}catch(Exception ex){
		pg =1;
	}
}
String event_seq = "";
if (request.getParameter("event_seq") != null && request.getParameter("event_seq").length() > 0  && !request.getParameter("event_seq").equals("null")) {
	event_seq = com.vodcaster.utils.TextUtil.getValue(request.getParameter("event_seq"));
}

int board_id = 2; // 이벤트 PHOTO

vt = BoardListSQLBean.getAllBoardList_admin_eventExcel(board_id, field, searchstring, "", event_seq, order, direction );

	response.setHeader("Content-Disposition", "inline; filename=ucc_event_list.xls");
    
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="990" border="0" align="center" cellpadding="0" cellspacing="0">
 
	<tr>
		<td align="center" valign="top">
			<!-- main start-->
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr> 
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr> 
								<td>
									<table width='100%' border='0' cellspacing='0' cellpadding='5'>
										 
										<tr> 
											<td align="center" width="30" >순위</td>
											<td align="center" width="50" >이름</td>
											<td align="center" width="50" >연락처</td>
											<td align="center" width="50" >이메일</td>
											<td align="center" width="50" >제목</td>

										</tr>

<%
	try {
 		 if (vt != null && vt.size() > 0) {
			for(int i = 0; i < vt.size() ; i++) {
		%>
				<tr  class="height_25 font_127">
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(0)%></b></td>
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(1)%></b></td>
				<td  class="bor_bottom01"><b><%=com.security.SEEDUtil.getDecrypt(((Vector)(vt.elementAt(i))).elementAt(2).toString())%></b></td>
				<td  class="bor_bottom01"><b><%=com.security.SEEDUtil.getDecrypt(((Vector)(vt.elementAt(i))).elementAt(3).toString())%></b></td>
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(4)%></b></td>
			 
			</tr>
		<%} } else {%>
			<tr>
					<td colspan="5"><b>검색된 정보가 없습니다.</b></td>
			</tr>
		<%}  
	} catch(Exception e) {}
%>
									</table>
								</td>
							</tr>
						</table>
						<!-- form end-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>

<%} else {
	out.println("<script>alert('올바르지 않은 접근입니다. 메인화면으로 이동합니다.');location.href='/';</script>");
}
%>