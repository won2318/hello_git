<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
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
<%
	/**
	 * @author ����� 
	 *
	 * @description : �弳 ���� ���� 
	 * date : 2012-05-04
	 */

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0109";
	}
		
	String binx = "";

	if(request.getParameter("fuck_id") != null) {

		binx = request.getParameter("fuck_id");
        FucksInfoManager mgr = FucksInfoManager.getInstance();

        int iResult = mgr.deleteFuck(binx);

        if(iResult != -1){
            response.sendRedirect("mng_fuckList.jsp?mcode="+mcode);
        }else{
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
            out.println("alert('���� ���� �� ������ �߻��Ͽ����ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
            out.println("history.go(-1)");
            out.println("</SCRIPT>");
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�弳������  �����ϴ�. �ٽ� �������ּ���.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>