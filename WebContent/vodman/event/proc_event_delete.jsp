<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
//request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "p_del")) {
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
	 * @description : �ֹ����̵���ڵ带 �޾Ƽ� ����. media���̺����� ����
	 * date : 2005-01-18
	 */

	String seq = "";
 
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0801";
	}

	if(request.getParameter("seq") != null) {

        try {
			seq = request.getParameter("seq").trim();
			EventManager pmgr = EventManager.getInstance();
			int iReuslt = pmgr.deleteEvent(seq);

                if(iReuslt != -1){

					out.println("<script>");
					out.println("alert('���� �Ǿ����ϴ�')");
					out.println("location.href='mng_eventList.jsp?mcode="+mcode+"'");
					out.println("</script>");
				 
				}else{
                    out.println("<SCRIPT LANGUAGE='JavaScript'>");
                    out.println("alert('ó�� �� ������ �߻��߽��ϴ�. ���� �������� �̵��մϴ�.')");
                    out.println("history.go(-1)");
                    out.println("</SCRIPT>");
                }
           
        }catch(Exception e) {
            System.out.println(e);
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�߸��� �����Դϴ�. �ٽ� �������ּ���.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>