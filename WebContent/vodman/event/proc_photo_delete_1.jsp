<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="BoardList" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "b_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	String field = request.getParameter("field");
	String searchstring = request.getParameter("searchstring");
	String pg = request.getParameter("page");

	String mcode= request.getParameter("mcode");
	String event_seq = request.getParameter("event_seq");
	
	int list_id  = -1;
	int board_id  = -1;
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length()>0 && !request.getParameter("list_id").equals("null")
		&& request.getParameter("board_id")  != null && request.getParameter("board_id") .length()>0 && !request.getParameter("board_id") .equals("null")){
		
		
		try{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
		}catch(Exception ex){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
				//out.println("history.go(-1)");
				out.println("</SCRIPT>");
				String REF_URL="photo_list.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode+"&event_seq="+event_seq;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
		
		try{
			list_id  = Integer.parseInt(request.getParameter("list_id") );
		}catch(Exception ex){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
				//out.println("history.go(-1)");
				out.println("</SCRIPT>");
				String REF_URL="photo_list.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode+"&event_seq="+event_seq;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
		
		boolean replyFlg = BoardList.replyCheck( list_id );
		if(!replyFlg) {
			int result = BoardList.delete(list_id);
			
			int iReuslt_memo = com.vodcaster.sqlbean.MemoManager.getInstance().deleteMemo(String.valueOf(list_id),"B");
	
			if(result >= 0){
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('�����Ǿ����ϴ�.')");
				out.println("</SCRIPT>");
				//response.sendRedirect("mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode);
				String REF_URL="photo_list.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode+"&event_seq="+event_seq;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
			}else{
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
				//out.println("history.go(-1)");
				out.println("</SCRIPT>");
				String REF_URL="photo_list.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode+"&event_seq="+event_seq;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
			}
		} else {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('����� �־� �������� ���߽��ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;

	}

%>