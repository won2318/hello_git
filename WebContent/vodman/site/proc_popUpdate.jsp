<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
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
	 * @description : �˾� update.
	 * date : 2009-10-15
	 */

	//request.setCharacterEncoding("EUC-KR");
	String mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0101";
	}
	
	PopupManager mgr = PopupManager.getInstance();
	
	int result = mgr.updatePOP(request);

	if(result >= 0){
		//out.println("<script language='javascript'>alert('�����Ǿ����ϴ�.');location.href='frm_popList.jsp?mcode="+mcode+"';</script>");
		out.println("<script language='javascript'>alert('�����Ǿ����ϴ�.');</script>");
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��߽��ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	String REF_URL="frm_popList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%

%>