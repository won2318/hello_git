<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<%
	/**
	 * @author ������
	 *
	 * @description : �˾�delete
	 * date : 2009-10-15
	 */

	 String mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
		if(mcode == null || mcode.length() <= 0) {
			mcode = "0101";
		}

	if(request.getParameter("seq") != null) {

        String seq = request.getParameter("seq").replaceAll("<","").replaceAll(">","").trim();
        PopupSqlBean mgr = PopupSqlBean.getInstance();

        int iResult = mgr.deletePopup(seq);

        if(iResult != -1){
            response.sendRedirect("frm_popList.jsp?mcode="+mcode);
        }else{
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
            out.println("alert('�����ڼ��� �ʹ� �����ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
            out.println("history.go(-1)");
            out.println("</SCRIPT>");
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�̵���ڵ尡 �����ϴ�. �ٽ� �������ּ���.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>