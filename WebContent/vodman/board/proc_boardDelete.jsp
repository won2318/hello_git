<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	/**
	 * @author Jong-Hyun Ho
	 *
	 * @description : �Խ����� ���̵� �Է¹޾� ���� ó���ϴ� ������
	 * date : 2005-01-04
	 */

%>
<%@ include file = "/vodman/include/auth.jsp"%>
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
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>

<%
	String mcode= request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
	if(request.getParameter("board_id") != null && request.getParameter("board_id").length()>0 && !request.getParameter("board_id").equals("null")){
	
		int board_id = -1;
		try{
			board_id = Integer.parseInt( String.valueOf( request.getParameter("board_id") ) );
		}catch(Exception ex){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardList.jsp"+"?mcode="+mcode;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%
		}
		int result = BoardInfoSQLBean.deleteBoardInfo(board_id);
		if(result >= 0){
			//response.sendRedirect("mng_boardList.jsp"+"?mcode="+mcode);
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('�����Ǿ����ϴ�.')");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardList.jsp"+"?mcode="+mcode;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%
		}
		else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardList.jsp"+"?mcode="+mcode;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%
		}
	}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('�� ���� ��û�Դϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardList.jsp"+"?mcode="+mcode;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%

	}

%>