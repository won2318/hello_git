<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
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
	 * @description : 사용자 권한 변경.
	 * date : 2009-10-15
	 */
	request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0103";
	}

    AuthManager mgr = AuthManager.getInstance();

    int result = mgr.editAuthInfo(request);

	if(result >= 0){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('권한이 변경되었습니다.')");
		out.println("</SCRIPT>");
		//response.sendRedirect("mng_authority.jsp?mcode="+mcode);
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('권한 변경 작업중 오류입니다. 잠시후에 다시 시도하여 주세요.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	String REF_URL="mng_authority_admin.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%

%>