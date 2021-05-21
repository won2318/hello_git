<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	/**
	 * @author 이희락 
	 *
	 * @description : 메인화면으로 도출시킬 게시물 선택을  위한 정보 입력받아 처리하는 페이지
	 * date : 2008-02-20
	 */

%>
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
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%
		
	String list_id = null;
	if (request.getParameter("list_id") != null) {
		list_id = request.getParameter("list_id").replaceAll("<","").replaceAll(">","");
	}
	String open_space = null;
	if (request.getParameter("open_space") != null) {
		open_space =	request.getParameter("open_space").replaceAll("<","").replaceAll(">","");
	}
	String board_id = null;
	if (request.getParameter("board_id") != null) {
		board_id = request.getParameter("board_id").replaceAll("<","").replaceAll(">","");	
	}
	String mcode= null;
	if (request.getParameter("mcode") != null) {
		mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");	
	}
	if(list_id == null || list_id.length()<1 || list_id.equals("null")){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생했습니다.')");
		out.println("</SCRIPT>");
		String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}else{
		//공지글 여부 판단
		if(open_space != null && open_space.length()>0 && !open_space.equals("null")){
			
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생했습니다.')");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&mcode="+mcode ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}
	}
	//int result = BoardListSQLBean.update_listOpen(Integer.parseInt(list_id),open_space);
	int result = BoardListSQLBean.update_main(list_id,open_space);
	if(result >= 0){
		//response.sendRedirect("mng_boardListList.jsp?board_id="+board_id);
		 String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생했습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

%>