<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
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
 
	String mcode = "";
	mcode = StringUtils.defaultString(request.getParameter("mcode"),"0701");
	String ccode = "";
	ccode = StringUtils.defaultString(request.getParameter("ccode"),"001000000000");
	String pg = "";
	pg = StringUtils.defaultString(request.getParameter("page"),"1");
	int result = Ucc.update_admin(request, 50);

	if(result >= 0){
		 out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�����Ǿ����ϴ�.')");
		out.println("location.href='mng_vodOrderList.jsp?mcode="+mcode+"&ccode="+ccode+"&page="+pg+"';");
		out.println("</SCRIPT>");
			//response.sendRedirect("mng_vodOrderList.jsp?mcode");
		 
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