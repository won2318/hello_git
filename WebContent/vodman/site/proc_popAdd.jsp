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
	 * @description : 팝업 Add.
	 * date : 2009-10-15
	 */

	//request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0101";
	}

	PopupManager mgr = PopupManager.getInstance();
//	System.out.println("request ::: " + request.toString());
	int result = mgr.insertPOP(request);

	if(result >= 0){
		//out.println("<script language='javascript'>location.href='frm_popList.jsp?mcode="+mcode+"';</script>");
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('등록되었습니다.')");
		out.println("</SCRIPT>");
	
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생했습니다. 잠시후에 다시 시도하여 주세요.')");
	//	out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	String REF_URL="frm_popList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
	
%>