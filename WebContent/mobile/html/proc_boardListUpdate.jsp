<%@ page language="java" pageEncoding="EUC-KR" %>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@page import="com.security.SEEDUtil"%>
<%@ include file="/include/chkLogin.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
 
%>
<jsp:useBean id="BoardList" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%
String searchField = TextUtil.nvl(request.getParameter("searchField"));
	String searchstring = "";
	if (request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0) {
		searchstring = TextUtil.nvl(request.getParameter("searchString"));
	}
	 
	if(request.getParameter("board_id") != null && request.getParameter("board_id").length()>0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id"))){
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 요청입니다. 이전 페이지로 이동합니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	int board_id  = Integer.parseInt(request.getParameter("board_id") );
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length()>0 && !request.getParameter("list_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id"))){
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 요청입니다. 이전 페이지로 이동합니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	int list_id  = Integer.parseInt(request.getParameter("list_id") );
 
 
 	if ( request.getParameter("pwd") != null ) {
		user_key = SEEDUtil.getEncrypt(request.getParameter("pwd").toString());
 	}
	
	
	if (BoardList.getPassCheckBoardList(board_id, list_id , user_key).equals("true")) {  
	
		int pg = NumberUtils.toInt(request.getParameter("page"), 1);
 
	//=================================================
	int iSize =0;
	iSize = 20 * 1024 * 1024;
	int result = BoardList.update(request, iSize);

	if(result >= 0){
 
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('수정 되었습니다.');");
		out.println("top.location.href='./board_list.jsp?board_id="+board_id+"&searchField="+searchField+"&searchstring="+searchstring+"&page="+pg+"';");
		out.println("</SCRIPT>");
		
	} else if(result == -99){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('파일 크기가 너무 커서 등록에 실패하였습니다.');");
		out.println("history.go(-1);");
		out.println("</SCRIPT>");
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.');");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근입니다. 이전페이지로 이동합니다!');");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
%>