<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, javazoom.upload.*"%>
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
<jsp:useBean id="DirectoryNameManager" class="com.vodcaster.sqlbean.DirectoryNameManager"/>

<%
	/**
	 * @author �� �� ��
	 *
	 * @description : �˾����� �̹��� ����ó��
	 * date : 2007-12-17
	 */

	String seq = "";
	String gubun = "";

	if(request.getParameter("seq") != null 
			&& request.getParameter("seq").length()>0 
			&& request.getParameter("gubun") != null 
			&& request.getParameter("gubun").length()>0 ) {

		seq = request.getParameter("seq").trim();
		gubun = request.getParameter("gubun").replaceAll("<","").replaceAll(">","").trim();

        PopupManager mngMedia = PopupManager.getInstance();
        int rtn = mngMedia.deletePopupImage(seq, gubun);

		if(rtn >= 0){
            out.println("<script language='javascript'>\n" +
                        "alert('�̹����� �����Ǿ����ϴ�.')\n;" +
                        "opener.location.href='frm_popUpdate.jsp?seq=" +seq+ "';\n" +
                        "window.close();\n" +
                        "</script>");
            
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('�����ڼ��� �ʹ� �����ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.');");
			out.println("window.close();");
			out.println("</SCRIPT>");
		}

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('������ �̵�������� �����ϴ�. �ٽ� �������ּ���.');");
		out.println("window.close();");
		out.println("</SCRIPT>");

	}

	request.setAttribute("seq",seq);

%>