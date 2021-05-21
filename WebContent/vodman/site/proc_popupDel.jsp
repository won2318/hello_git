<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
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
	 * @author 박종성
	 *
	 * @description : 팝업delete
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
            out.println("alert('접속자수가 너무 많습니다. 잠시후에 다시 시도하여 주세요.')");
            out.println("history.go(-1)");
            out.println("</SCRIPT>");
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('미디어코드가 없습니다. 다시 선택해주세요.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>