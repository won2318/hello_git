<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
//request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "p_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 최 희 성
	 *
	 * @description : 주문형미디어코드를 받아서 삭제. media테이블정보 삭제
	 * date : 2005-01-18
	 */

	String seq = "";
 
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0801";
	}

	if(request.getParameter("seq") != null) {

        try {
			seq = request.getParameter("seq").trim();
			EventManager pmgr = EventManager.getInstance();
			int iReuslt = pmgr.deleteEvent(seq);

                if(iReuslt != -1){

					out.println("<script>");
					out.println("alert('삭제 되었습니다')");
					out.println("location.href='mng_eventList.jsp?mcode="+mcode+"'");
					out.println("</script>");
				 
				}else{
                    out.println("<SCRIPT LANGUAGE='JavaScript'>");
                    out.println("alert('처리 중 오류가 발생했습니다. 이전 페이지로 이동합니다.')");
                    out.println("history.go(-1)");
                    out.println("</SCRIPT>");
                }
           
        }catch(Exception e) {
            System.out.println(e);
        }

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근입니다. 다시 선택해주세요.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>