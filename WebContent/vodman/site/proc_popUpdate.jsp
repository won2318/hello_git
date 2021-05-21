<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 박종성
	 *
	 * @description : 팝업 update.
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
		//out.println("<script language='javascript'>alert('수정되었습니다.');location.href='frm_popList.jsp?mcode="+mcode+"';</script>");
		out.println("<script language='javascript'>alert('수정되었습니다.');</script>");
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생했습니다. 잠시후에 다시 시도하여 주세요.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	String REF_URL="frm_popList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%

%>