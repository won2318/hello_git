<%@ page language="java" contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="oinfo" class="com.vodcaster.sqlbean.WebLogInfo" scope="page" />

<%
  

WebLogManager mgr = com.vodcaster.sqlbean.WebLogManager.getInstance();
 

String rstime="";
if (request.getParameter("rstime") != null && request.getParameter("rstime").length() > 0) {
	rstime =request.getParameter("rstime");
}
String retime="";
if (request.getParameter("retime") != null && request.getParameter("retime").length() > 0) {
	retime =request.getParameter("retime");
}
String browser="";
 String method="";
 String ip="";
 String referer="";
 String uri="";
 String sessionID="";
	response.setHeader("Content-Disposition", "inline; filename=web_Log.xls");


Vector vt = mgr.getWebLog( rstime, retime, browser,  method,  ip,  referer,  uri,  sessionID );
%>
 


<html>
<head>
<title>접속 통계</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
 
		  <table width="640" border="0" cellspacing="0" cellpadding="0" align="center">
		  <tr>
		  <th>번호</th>
			<th>IP</th>
			<th>일자</th>
			 
			<th>접속페이지</th>
			<th>이전페이지 주소</th>
		</tr> 
<%
 
	if ( vt != null && vt.size() > 0){
		
		for(int i = 0 ; i <vt.size() ; i++)
		{
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)vt.elementAt(i));
%>
                              <tr>
								<td ><%=vt.size() -i%></tD>
								<TD ><%=oinfo.getLog_ip()%></TD>
								<td ><%=oinfo.getLog_date()%></td>
							 
							    <td ><%=oinfo.getLog_uri()%></tD>
							    <td ><%=oinfo.getLog_referer()%></td>
							</tr> 
<%  } 
}%>
 	 </table>
</body>

</html>
 
  