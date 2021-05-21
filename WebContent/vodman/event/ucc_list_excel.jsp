<%@ page language="java" contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
 
<%
if ((String)session.getValue("admin_id") != null &&  session.getValue("admin_id").toString().length() > 0) {
 
Vector vt = null;
 
String event_seq = String.valueOf(request.getParameter("event_seq"));

MediaManager mgr = MediaManager.getInstance();
String ccode="007000000000";
String mtype="V";

String searchField = "";		//검색 필드
String searchString = "";		//검색어
 

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "ocode");
String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

int listCnt = 5;				//페이지 목록 갯수

if(request.getParameter("searchField") != null  && request.getParameter("searchField").length() > 0 )
	searchField = com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchField"));

if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 )
	searchString = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchString")));

vt = mgr.getOMediaListAll_admin_cateExcel(ccode,  mtype,   order, searchField,  searchString,  direction ,  event_seq);

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