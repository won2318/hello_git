<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "be_write")) {
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
	 * description : 베스트vod 입력
	 * date : 2005-01-26
	 */
	 request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
 	String urllink = "mng_list_link.jsp?mcode="+mcode;
	BestMediaManager mgr = BestMediaManager.getInstance();
    int result = mgr.saveList_link(request );
  
	if(result >= 0){
 		out.println("<script language='javascript'>alert('저장하였습니다.');</script>");
		 String REF_URL=urllink ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
%>