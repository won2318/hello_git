<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="BoardList" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "b_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
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
	
	
	String data_file = "";
	String image_file = "";
	if(request.getParameter("data_file") != null) data_file = CharacterSet.toKorean(request.getParameter("data_file").replaceAll("<","").replaceAll(">",""));
	if(request.getParameter("image_file") != null) image_file = CharacterSet.toKorean(request.getParameter("image_file").replaceAll("<","").replaceAll(">",""));
	int list_id  = -1;
	int board_id  = -1;
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length()>0 && !request.getParameter("list_id").equals("null")
		&& request.getParameter("board_id")  != null && request.getParameter("board_id") .length()>0 && !request.getParameter("board_id") .equals("null")){
		
		
		try{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
		}catch(Exception ex){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('처리 중 오류가 발생하였습니다.')");
				//out.println("history.go(-1)");
				out.println("</SCRIPT>");
				String REF_URL="mng_boardList.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
		
		try{
			list_id  = Integer.parseInt(request.getParameter("list_id") );
		}catch(Exception ex){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('처리 중 오류가 발생하였습니다.')");
				//out.println("history.go(-1)");
				out.println("</SCRIPT>");
				String REF_URL="mng_boardListList.jsp?mcode="+mcode+"&board_id="+board_id;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
		
		boolean replyFlg = BoardList.replyCheck( list_id );
		if(!replyFlg) {
			int result = BoardList.delete_man(list_id);
			
			int iReuslt_memo = com.vodcaster.sqlbean.MemoManager.getInstance().deleteMemo(String.valueOf(list_id),"B");
	
			if(result >= 0){
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('삭제되었습니다.')");
				out.println("</SCRIPT>");
				//response.sendRedirect("mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode);
				String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
			}
			else{
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('처리 중 오류가 발생하였습니다.')");
				//out.println("history.go(-1)");
				out.println("</SCRIPT>");
				String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
			}
		} else {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('답글이 있어 삭제하지 못했습니다.')");
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
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page=1"+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;

	}

%>