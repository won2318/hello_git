<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="Ucc" class="com.vodcaster.sqlbean.UccSQLBean"/>
<%
if(!chk_auth(vod_id, vod_level, "m_write")) {
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
	 
    // ��ũ����
    int pg = 0;
	String event_seq = "";
	String ocode = "";
	 
	String searchField = "";
	String searchString = "";

    if(request.getParameter("page")==null || request.getParameter("page").length()<= 0 || request.getParameter("page").equals("null")){
        pg = 1;
    }else{
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception e){
			pg = 1;
		}
    }
    if(request.getParameter("event_seq") != null && request.getParameter("event_seq").length()>0 && !request.getParameter("event_seq").equals("null"))
    event_seq = String.valueOf(request.getParameter("event_seq"));
	 
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length()>0 && !request.getParameter("searchField").equals("null"))
		searchField = request.getParameter("searchField");

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0 && !request.getParameter("searchString").equals("null"))
		searchString = CharacterSet.toKorean(request.getParameter("searchString"));

    String strLink = "&page=" +pg+ "&event_seq=" +event_seq+ "&ocode=" +ocode+"&searchField=" +searchField+ "&searchString=" +searchString;
    // ��ũ����
	
	
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "1001";
	}


    // ��ũ����
String REF_URL="ucc_list.jsp?mcode="+mcode+strLink ;
	if(  request.getParameter("event_seq") != null &&  request.getParameter("event_seq").length() > 0 && request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0 ) {

		
		ocode = String.valueOf(request.getParameter("ocode"));
		String event_gread = String.valueOf( request.getParameter("event_gread") );
 

		int result = Ucc.delete_ucc(request);
		
		if(result >= 0){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('���� �Ǿ����ϴ�.')");
			out.println("</SCRIPT>");
			 
		} else {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			out.println("</SCRIPT>");
			 
		}

	} else {

		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�� ���� ��û�Դϴ�. ���� �������� �̵��մϴ�.')");
		out.println("</SCRIPT>");
	}
	 
	%>
	<%@ include file = "/vodman/include/REF_URL.jsp"%>

