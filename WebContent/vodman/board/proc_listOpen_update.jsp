<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%
if(!chk_auth(vod_id, vod_level, "b_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author �� �� ��
	 *
	 * @description : ȸ������������ ���� ������ �Է¹޾� ó���ϴ� ������
	 * date : 2005-01-10
	 */
	 request.setCharacterEncoding("EUC-KR");
	String flag = "";
	String list_id = "";
	    // ��ũ����
	int pg = 1;
	String searchstring = "";
	if (request.getParameter("searchstring") != null) {
		searchstring = request.getParameter("searchstring").replaceAll("<","").replaceAll(">","");
	}
	if (request.getParameter("list_id") != null) {
		list_id = request.getParameter("list_id").replaceAll("<","").replaceAll(">","");
	}
	String field = null;
	if (request.getParameter("field") != null) {
		field =	request.getParameter("field").replaceAll("<","").replaceAll(">","");
	}
	String board_id = null;
	if (request.getParameter("board_id") != null) {
		board_id = request.getParameter("board_id").replaceAll("<","").replaceAll(">","");	
	}
	String mcode= null;
	if (request.getParameter("mcode") != null) {
		mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");	
	} 
	if(request.getParameter("page")==null || request.getParameter("page").length()<=0 || request.getParameter("page").equals("null")){
        pg = 1;
    }else{
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception e){
			pg = 1;
		}
        
    }

    
	
	
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length()>0 && !request.getParameter("list_id").equals("null")){
		list_id = request.getParameter("list_id");
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&page="+pg+"&searchstring="+searchstring+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	// ��ũ����
	String strLink = "board_id="+board_id+"&list_id="+list_id+"&field="+field+"&page="+pg+"&searchstring="+searchstring+"&mcode="+mcode;

	if(request.getParameter("flag") != null && request.getParameter("flag").length()>0 && !request.getParameter("flag").equals("null")){
		flag = request.getParameter("flag");
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="frm_boardListView.jsp?" +strLink;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%
			return;
	}



	
	
	//int result = BoardListSQLBean.update_listOpen(Integer.parseInt(list_id),flag);
	int result = BoardListSQLBean.update_listOpen(list_id,flag);

	if(result >= 0){
		//response.sendRedirect("frm_boardListView.jsp?" +strLink);
		String REF_URL="frm_boardListView.jsp?" +strLink;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%
			//return;
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="frm_boardListView.jsp?" +strLink;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%
			//return;
	}

	

%>
