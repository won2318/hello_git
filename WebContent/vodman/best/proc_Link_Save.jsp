<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "be_write")) {
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
	 * description : ����Ʈvod �Է�
	 * date : 2005-01-26
	 */
	 request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
 	String urllink = "mng_list_link.jsp?mcode="+mcode;
	BestMediaManager mgr = BestMediaManager.getInstance();
    int result = mgr.saveList_link(request );
  
	if(result >= 0){
 		out.println("<script language='javascript'>alert('�����Ͽ����ϴ�.');</script>");
		 String REF_URL=urllink ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
%>