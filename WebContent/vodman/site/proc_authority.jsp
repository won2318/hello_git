<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author ������
	 *
	 * @description : ����� ���� ����.
	 * date : 2009-10-15
	 */
	request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0103";
	}

    AuthManager mgr = AuthManager.getInstance();

    int result = mgr.editAuthInfo(request);

	if(result >= 0){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('������ ����Ǿ����ϴ�.')");
		out.println("</SCRIPT>");
		//response.sendRedirect("mng_authority.jsp?mcode="+mcode);
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('���� ���� �۾��� �����Դϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	String REF_URL="mng_authority_admin.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%

%>