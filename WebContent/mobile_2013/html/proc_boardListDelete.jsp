<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%> 
<jsp:useBean id="BoardList" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
<%@page import="com.security.SEEDUtil"%>
 <%@ include file="/include/chkLogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
 
</head>
<body>
<%
String searchField = TextUtil.nvl(request.getParameter("searchField"));

String searchstring = "";
if (request.getParameter("searchstring") != null && request.getParameter("searchstring").length() > 0) {
	searchstring = TextUtil.nvl(request.getParameter("searchstring"));
}
 

	String pg = request.getParameter("page");
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length()>0 && !request.getParameter("list_id").equals("null")){
		int list_id  = Integer.parseInt(request.getParameter("list_id") );

		int board_id  = Integer.parseInt(request.getParameter("board_id") );
		
	
	//if (request.getParameter("list_passwd") != null && request.getParameter("list_passwd").length() > 0) {
		
	if (session.getValue("list_passwd") != null && session.getValue("list_passwd").toString().length() > 0) {
		user_key = session.getValue("list_passwd").toString();
	}
 
	if (BoardList.getPassCheckBoardList(board_id, list_id , user_key).equals("true")) {  // 비밀번호 확인
		
 
		boolean replyFlg = BoardList.replyCheck( list_id );
		if(!replyFlg) {
			int result = BoardList.delete(list_id, request);
		 
			int iReuslt_memo = com.vodcaster.sqlbean.MemoManager.getInstance().deleteMemo(String.valueOf(list_id),"B");
			//out.println(result);
			if (result== -99) {
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('정보가 올바르지 않습니다.')");
				out.println("top.location.href='iTV_board.jsp?board_id="+board_id+"&searchField="+searchField+"&searchstring="+searchstring+"&page=1'");
				out.println("</SCRIPT>");
				 
			}else if(result >= 0){
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('삭제되었습니다.')");
				out.println("top.location.href='iTV_board.jsp?board_id="+board_id+"&searchField="+searchField+"&searchstring="+searchstring+"&page=1'");
				out.println("</SCRIPT>");
				 
			}
			else{
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('처리 중 오류가 발생하였습니다.')");
				out.println("history.go(-1)");
				out.println("</SCRIPT>");
			}
		} else {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('답글이 있어 삭제하지 못했습니다.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('올바른 접근이 아닙니다!')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>
</body>
</html>