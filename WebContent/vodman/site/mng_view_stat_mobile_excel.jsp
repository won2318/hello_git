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

	String ctype = "";
	String strTitle = "";
	int num = 1;

	if(request.getParameter("ctype") != null) {
		ctype = String.valueOf(request.getParameter("ctype").replaceAll("<","").replaceAll(">",""));
	}else
		ctype = "V";


	if(ctype.equals("V"))
		strTitle = "������(VOD)";
	

	String ccode = "";
	String ocode = "";
	String user_id = "";


    		
    String rstime = "";

	String retime = "";
	String dept = "";
	String grade = "";

	if(request.getParameter("rstime") !=null && request.getParameter("rstime").length()>0)
		rstime = request.getParameter("rstime").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("retime") !=null && request.getParameter("retime").length()>0)
		retime = request.getParameter("retime").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("ocode") !=null && request.getParameter("ocode").length()>0)
		ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
	if(request.getParameter("user_id") !=null && request.getParameter("user_id").length()>0)
		user_id = request.getParameter("user_id").replaceAll("<","").replaceAll(">","");
    
	if(request.getParameter("dept") !=null && request.getParameter("dept").length()>0)
		dept = request.getParameter("dept").replaceAll("<","").replaceAll(">","");
	if(request.getParameter("grade") !=null && request.getParameter("grade").length()>0)
		grade = request.getParameter("grade").replaceAll("<","").replaceAll(">","");
	
	response.setHeader("Content-Disposition", "inline; filename=mobilew_state.xls");
    
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="990" border="0" align="center" cellpadding="0" cellspacing="0">
<%
	MediaManager mgr = MediaManager.getInstance();
	Vector vt =  null;
	vt = mgr.getOVODMemberListMobile_Excel( rstime, retime, ocode, user_id, ccode, dept, grade);
%>
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
											<td height="4" colspan="5"></td>
										</tr>
										<tr> 
											<td align="center" width="50" >��ȣ</td>
											<td align="center" width="85" >���̵�</td>
											<td align="center">��������</td>
											<td align="center" width="140">��û��</td>
											<td align="center" width="100">������</td>
										</tr>
										<tr> 
											<td height="1" colspan="5" bgcolor="#DBE2ed"></td>
										</tr>
<%
	try {
		if(vt != null && vt.size()>0) {
			int j=0;
			for(int i=0; i<vt.size(); i++) {
 
				String no 		= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(0));
				String ip 		= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(1));
				String list_id 	= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(2));
				String list_name= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(3));
				String vod_code = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(4));
				String regDate 	= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(5));
				String otitle 	= String.valueOf(((Vector)(vt.elementAt(i))).elementAt(6));

%>
										<tr bgcolor="#ffffff" onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''"> 
											<td align="center" width="50"><b><%=vt.size()-j%></b></td>
											<td align="center" width="85"><%=list_name%>(<%=list_id%>)</td>
											<td ><%=otitle%></td>
											<td align="center" width="140"><%=regDate.length()>10?regDate.substring(0,10):regDate%></td>
											<td align="center" width="100"><%=ip%></td>
										</tr>
										<tr bgcolor="#DBE2ed">
											<td height="1" colspan="5"></td>
										</tr>
<%
				j++;
			}
		}
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