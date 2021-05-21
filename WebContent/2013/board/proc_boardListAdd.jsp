<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ include file="/include/chkLogin.jsp"%>

<%
//request.setCharacterEncoding("EUC-KR");
 
%>
<jsp:useBean id="BoardList" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%

// 	String write_check = TextUtil.nvl((String)session.getValue("write_check"));
 
// 	if(!write_check.equals("1")){
// 		out.println("<SCRIPT LANGUAGE='JavaScript'>");
// 		//out.println("alert('"+write_check+"');");
// 		out.println("alert('잘못 된 요청입니다.  잠시후에 다시 시도하여 주세요!');");
// 		out.println("history.go(-1)");
// 		out.println("</SCRIPT>");
// 		return;
// 	}

// 	String session_random_num =	TextUtil.nvl((String)session.getValue("random_num"));
// 	if(!session_random_num.equals(request.getParameter("chk_word")) ){
// 		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		 
// 		out.println("alert('잘못 된 요청입니다. 이전 페이지로 이동합니다.')");
// 		out.println("history.go(-1);");
// 		out.println("</SCRIPT>");
// 		return;
// 	}

	String searchField = TextUtil.nvl(request.getParameter("searchField"));
	String searchstring = "";
	if (request.getParameter("searchstring") != null && request.getParameter("searchstring").length() > 0) {
		searchstring = TextUtil.nvl(request.getParameter("searchstring"));
	}
	 
 	 
	if(request.getParameter("board_id") != null && request.getParameter("board_id").length()>0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id"))){
	}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 요청입니다. 이전 페이지로 이동합니다.');");
		out.println("history.go(-1);");
		out.println("</SCRIPT>");
		return;
	}
 
	int pg = NumberUtils.toInt(request.getParameter("page"), 1);
 
	int board_id = NumberUtils.toInt(request.getParameter("board_id"), 4);
	int iSize =0;
	iSize = 100 * 1024 * 1024;

	int result = BoardList.write(request,iSize);
//	session.putValue("write_check", "");//글 쓰는 화면에 1로 설정, 등록하는 페이지에서 1인지 체크, 2로 변경
//	session.putValue("random_num", "");

	if(result >= 0){

		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		if (board_id == 2) {
			out.println("alert('등록 되었습니다. 관리자 승인후 게시 됩니다!')");
		} else {
			out.println("alert('등록 되었습니다.')");
		}
		out.println("top.location.href='board_list.jsp?board_id="+board_id+"&searchField="+searchField+"&searchString="+searchstring+"&page="+pg +"';");
		out.println("</SCRIPT>");
 
	} else if(result == -99){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('파일 크기가 너무 커서 등록에 실패하였습니다.');");
		out.println("history.go(-1);");
		out.println("</SCRIPT>");
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.');");
		out.println("history.go(-1);");
		out.println("</SCRIPT>");
	}
%>