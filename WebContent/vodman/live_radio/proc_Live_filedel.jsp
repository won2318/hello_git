<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*, javazoom.upload.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "r_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="DirectoryNameManager" class="com.vodcaster.sqlbean.DirectoryNameManager"/>

<%
	/**
	 * @author �� �� ��
	 *
	 * @description : �ֹ��� VOD���� �̹��� ����ó��
	 * date : 2005-01-20
	 */
	
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0601";
	}
		
	String rcode = "";
    String flag = "";

	if(request.getParameter("rcode") != null && request.getParameter("flag") != null) {

		rcode = request.getParameter("rcode");
        flag = request.getParameter("flag");

        LiveManager mngMedia = LiveManager.getInstance();

        int rtn = mngMedia.deletefile(rcode, flag);

		if(rtn >= 0){
            out.println("<script language='javascript'>\n" +
                        "alert(' �����Ǿ����ϴ�.')\n;" +
                        //"opener.location.href='frm_Live_Update.jsp?mcode="+mcode+"&rcode=" +rcode+ "';\n" +
						"opener.location.reload();\n" +
                        "window.close();\n" +
                        "</script>");
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�. ���� �������� �̵��մϴ�.');");
			out.println("window.close();");
			out.println("</SCRIPT>");
		}

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('������ ������ �����ϴ�. �ٽ� �������ּ���.');");
		out.println("window.close();");
		out.println("</SCRIPT>");

	}

%>