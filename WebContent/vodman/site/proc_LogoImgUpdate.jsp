<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*, javazoom.upload.*"%>
<jsp:useBean id="DirectoryNameManager" class="com.vodcaster.sqlbean.DirectoryNameManager"/>
<jsp:useBean id="logoInfo" class="com.vodcaster.sqlbean.LogoSqlBean" scope="page" />

<%@ page import="java.util.Calendar, java.text.SimpleDateFormat, java.sql.Timestamp" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "v_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author �� �� ��
	 *
	 * @description : �ֹ��� VOD���� �̹��� �Է�ó��
	 * date : 2005-01-20
	 */

	request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0105";
	}

        String uploadFolder = "";
        String todo = null;
        String col = request.getParameter("flag");
        String image = request.getParameter("oimage");
//        out.println("<script language='javascript'>\n" +
//                "alert('"+image+"')\n;" +
//                "</script>");
        
        int iSize =0;
    	iSize = 5 * 1024 * 1024;
    	
    	
    	int result = logoInfo.updateLogoImg(request,iSize);

    	if(result >= 0){
    		out.println("<SCRIPT LANGUAGE='JavaScript'>");
    		out.println("alert('����Ǿ����ϴ�.')");
    		out.println("</SCRIPT>");
    		//response.sendRedirect("frm_mainLogo.jsp?mcode="+mcode);
    	} else{
    		out.println("<SCRIPT LANGUAGE='JavaScript'>");
    		out.println("alert('�ΰ� �̹��� ���� �� ������ �߻��߽��ϴ�.')");
    		//out.println("history.go(-1)");
    		out.println("</SCRIPT>");
    	}
	String REF_URL="frm_mainLogo.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
%>