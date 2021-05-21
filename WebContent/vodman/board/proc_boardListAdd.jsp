<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
//request.setCharacterEncoding("EUC-KR");
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
int pg = 1;
if(request.getParameter("page")==null || request.getParameter("page").length()<=0 || request.getParameter("page").equals("null")){
    pg = 1;
}else{
	try{
		pg = Integer.parseInt(request.getParameter("page"));
	}catch(Exception e){
		pg = 1;
	}
    
}

String searchstring = "";
if (request.getParameter("searchstring") != null) {
	searchstring = request.getParameter("searchstring").replaceAll("<","").replaceAll(">","");
}
 
String field = null;
if (request.getParameter("field") != null) {
	field =	request.getParameter("field").replaceAll("<","").replaceAll(">","");
}
 
String mcode= null;
if (request.getParameter("mcode") != null) {
	mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");	
} 
	if(request.getParameter("board_id") != null && request.getParameter("board_id").length()>0 && !request.getParameter("board_id").equals("null")){
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 요청입니다. 게시판 목록 페이지로 이동합니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	int board_id  = 0;
	try{
		board_id  = Integer.parseInt(request.getParameter("board_id") );
	}catch(Exception ex){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 요청입니다. 게시판 목록 페이지로 이동합니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	int iSize =0;
	iSize = 20 * 1024 * 1024;
	int result = 0 ;
	try{
		result = BoardList.write_man(request,iSize);
	}catch(Exception ex){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 요청입니다. 게시판 목록 페이지로 이동합니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

	if(result >= 0){
		//response.sendRedirect("mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode);
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('등록 되었습니다.')");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	} else if(result == -99){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('파일 크기가 제한 용량(20MB) 보다 커서 등록에 실패하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
%>