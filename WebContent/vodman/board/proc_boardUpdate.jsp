<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	/**
	 * @author Jong-Hyun Ho
	 *
	 * @description : �Խ��Ǽ����� ���� ������ �Է¹޾� ó���ϴ� ������
	 * date : 2005-01-04
	 */

%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "b_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>

<%
String mcode= null;
if (request.getParameter("mcode") != null) {
	mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");	
} 
	int result = -1;
	try{
		result = BoardInfoSQLBean.updateBoardInfo(request);
	}catch(Exception ex){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardListt.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

	if(result >= 0){
		//response.sendRedirect("mng_boardList.jsp"+"?mcode="+mcode);
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�����Ǿ����ϴ�.')");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

%>