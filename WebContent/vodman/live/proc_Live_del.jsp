<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*,  com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "r_del")) {    out.println("<script language='javascript'>\n" +                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +                "history.go(-1);\n" +                "</script>");    return;
}
%>
<%
	/**
	 * @author 최 희 성
	 *
	 * @description : 주문형미디어코드를 받아서 삭제. media테이블정보 삭제
	 * date : 2005-01-18
	 */
	 
	 String mcode = request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0601";
		}

	String rcode = "";

	if(request.getParameter("rcode") != null && request.getParameter("rcode").length()>0 && !request.getParameter("rcode").equals("null")) {

        rcode = request.getParameter("rcode");
        LiveManager mgr = LiveManager.getInstance();

        int iResult = mgr.deleteLive(rcode);

        if(iResult != -1){
            //response.sendRedirect("mng_vodRealList.jsp?mcode="+mcode);
			out.println("<script>");
				out.println("alert('삭제되었습니다.');");
				//out.println("location.href='mng_vodRealList.jsp?mcode="+mcode+"'");
				out.println("</script>");
        }else{
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
            out.println("alert('처리 중 오류가 발생하였습니다. 이전 페이지로 이동합니다.')");
            //out.println("history.go(-1)");
            out.println("</SCRIPT>");
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('생방송 정보가 없습니다. 이전 페이지로 이동합니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}
String REF_URL="mng_vodRealList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
%>