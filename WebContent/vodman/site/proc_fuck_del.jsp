<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "r_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 이희락 
	 *
	 * @description : 욕설 정보 삭제 
	 * date : 2012-05-04
	 */

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0109";
	}
		
	String binx = "";

	if(request.getParameter("fuck_id") != null) {

		binx = request.getParameter("fuck_id");
        FucksInfoManager mgr = FucksInfoManager.getInstance();

        int iResult = mgr.deleteFuck(binx);

        if(iResult != -1){
            response.sendRedirect("mng_fuckList.jsp?mcode="+mcode);
        }else{
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
            out.println("alert('정보 수정 중 오류가 발생하였습니다. 잠시후에 다시 시도하여 주세요.')");
            out.println("history.go(-1)");
            out.println("</SCRIPT>");
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('욕설정보가  없습니다. 다시 선택해주세요.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>