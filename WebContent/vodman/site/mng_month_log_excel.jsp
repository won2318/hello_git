<%@ page language="java" contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%//@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
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
 
	response.setHeader("Content-Disposition", "inline; filename=month_log.xls");
    
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
										<tr bgcolor="#DBE2ed"> 
											<td height="4" colspan="6"></td>
										</tr>
										<tr> 
											<td align="center"  colspan="6" ><%=yy%>-<%=mm%>���� ���</td>
										 
										</tr>
										<tr> 
											<td align="center" width="30" >��ȣ</td>
											<td align="center" width="50" >��¥</td>
											<td align="center" width="50" >����</td>
											<td align="center" width="50" >�з�</td>
											<td align="center">hit</td>
											<td align="center">��������</td>
 
										</tr>
										<tr> 
											<td height="1" colspan="6" bgcolor="#DBE2ed"></td>
										</tr>
<%
	try {
 		 if (vt != null && vt.size() > 0) {
			for(int i = 0; i < vt.size() ; i++) {
		%>
				<tr  class="height_25 font_127">
				<td  class="bor_bottom01"><b><%=i%></b></td>
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(1)%>-<%=((Vector)(vt.elementAt(i))).elementAt(2)%></b></td>
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(4)%></b></td>
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(6)%></b></td>
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(0)%></b></td>
				<td  class="bor_bottom01"><b><%=((Vector)(vt.elementAt(i))).elementAt(5)%></b></td>
			</tr>
		<%} } else {%>
			<tr>
					<td colspan="6"><b>�˻��� ������ �����ϴ�.</b></td>
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