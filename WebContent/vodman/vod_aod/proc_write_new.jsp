<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<jsp:useBean id="Ucc" class="com.vodcaster.sqlbean.UccSQLBean"/>
 
<%
if(!chk_auth(vod_id, vod_level, "v_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
 

	int result = Ucc.update_admin_new(request, 50);

	if(result >= 0){
		 
			response.sendRedirect("mng_vodOrderList.jsp");
		 
	} else if(result == -99){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.1')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.2')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
%>