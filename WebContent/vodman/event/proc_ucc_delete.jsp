<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="Ucc" class="com.vodcaster.sqlbean.UccSQLBean"/>
<%
if(!chk_auth(vod_id, vod_level, "m_write")) {
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
	 * @description : 회원정보생성을 위한 정보를 입력받아 처리하는 페이지
	 * date : 2005-01-10
	 */
	 request.setCharacterEncoding("EUC-KR");
	 
    // 링크유지
    int pg = 0;
	String event_seq = "";
	String ocode = "";
	 
	String searchField = "";
	String searchString = "";

    if(request.getParameter("page")==null || request.getParameter("page").length()<= 0 || request.getParameter("page").equals("null")){
        pg = 1;
    }else{
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception e){
			pg = 1;
		}
    }
    if(request.getParameter("event_seq") != null && request.getParameter("event_seq").length()>0 && !request.getParameter("event_seq").equals("null"))
    event_seq = String.valueOf(request.getParameter("event_seq"));
	 
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length()>0 && !request.getParameter("searchField").equals("null"))
		searchField = request.getParameter("searchField");

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0 && !request.getParameter("searchString").equals("null"))
		searchString = CharacterSet.toKorean(request.getParameter("searchString"));

    String strLink = "&page=" +pg+ "&event_seq=" +event_seq+ "&ocode=" +ocode+"&searchField=" +searchField+ "&searchString=" +searchString;
    // 링크유지
	
	
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "1001";
	}


    // 링크유지
String REF_URL="ucc_list.jsp?mcode="+mcode+strLink ;
	if(  request.getParameter("event_seq") != null &&  request.getParameter("event_seq").length() > 0 && request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0 ) {

		
		ocode = String.valueOf(request.getParameter("ocode"));
		String event_gread = String.valueOf( request.getParameter("event_gread") );
 

		int result = Ucc.delete_ucc(request);
		
		if(result >= 0){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('삭제 되었습니다.')");
			out.println("</SCRIPT>");
			 
		} else {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			out.println("</SCRIPT>");
			 
		}

	} else {

		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 요청입니다. 이전 페이지로 이동합니다.')");
		out.println("</SCRIPT>");
	}
	 
	%>
	<%@ include file = "/vodman/include/REF_URL.jsp"%>

