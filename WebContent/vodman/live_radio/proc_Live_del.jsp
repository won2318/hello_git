<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*,  com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "r_del")) {    out.println("<script language='javascript'>\n" +                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +                "history.go(-1);\n" +                "</script>");    return;
}
%>
<%
	/**
	 * @author �� �� ��
	 *
	 * @description : �ֹ����̵���ڵ带 �޾Ƽ� ����. media���̺����� ����
	 * date : 2005-01-18
	 */
	 
	 String mcode = request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0601";
		}

	String rcode = "";

	if(request.getParameter("rcode") != null && request.getParameter("rcode").length()>0 && !request.getParameter("rcode").equals("null")) {

        rcode = request.getParameter("rcode");
        LiveManager mgr = LiveManager.getInstance();

        int iResult = mgr.deleteLive(rcode);

        if(iResult != -1){
            //response.sendRedirect("mng_vodRealList.jsp?mcode="+mcode);
			out.println("<script>");
				out.println("alert('�����Ǿ����ϴ�.');");
				//out.println("location.href='mng_vodRealList.jsp?mcode="+mcode+"'");
				out.println("</script>");
        }else{
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
            out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�. ���� �������� �̵��մϴ�.')");
            //out.println("history.go(-1)");
            out.println("</SCRIPT>");
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('����� ������ �����ϴ�. ���� �������� �̵��մϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}
String REF_URL="mng_vodRealList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
%>