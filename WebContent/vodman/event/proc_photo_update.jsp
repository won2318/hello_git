<%@ page language="java" pageEncoding="EUC-KR" %>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "b_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="BoardList" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%
	String mcode= request.getParameter("mcode");
	String field = request.getParameter("field");
	String searchstring = request.getParameter("searchstring");
	String pg = request.getParameter("page");
 
	int board_id  = 0;
 	
	int list_id  = -1;
	try{
		if(request.getParameter("list_id") != null && request.getParameter("list_id").length()>0 && !request.getParameter("list_id").equals("null")){
			list_id  = Integer.parseInt(request.getParameter("list_id") );
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다1.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="photo_list.jsp?field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;

		}
	}catch(Exception ex){
		System.err.println(ex);
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다2.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="photo_list.jsp?field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	
	String event_seq = request.getParameter("event_seq");
		
	int result = -1;
	try{
		result = BoardList.update_photo(request);
	}catch(Exception ex){
		result = -1;
		System.err.println(ex);
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다3.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="photo_list.jsp?field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode+"&event_seq="+event_seq ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

	if(result >= 0){
		//response.sendRedirect("mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode);
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('등록되었습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="photo_list.jsp?field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode +"&event_seq="+event_seq ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}  else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다4.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="photo_list.jsp?field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode+"&event_seq="+event_seq ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

%>