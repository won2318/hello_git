<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,  com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "cate_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author ������
	 *
	 * @description : ī�װ����� ����
	 * date : 2009-10-19
	 */
	 request.setCharacterEncoding("EUC-KR");
	String ctype = "";
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0401";
	}
	if(request.getParameter("ctype") != null && request.getParameter("ctype").length()>0 && !request.getParameter("ctype").equals("null")){
		ctype = request.getParameter("ctype");
	}else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ī�װ��з��� �������ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		
			

			String REF_URL="mng_categoryList.jsp?mcode="+mcode +"&ctype=V" ;;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	
	
		


	CategoryManager mgr = CategoryManager.getInstance();
	int result = mgr.updateCategory(request);

	if(result >= 0){
		//out.println("<script language='javascript'>location.href='mng_categoryList.jsp?mcode="+mcode+"&ctype=" +ctype+ "';</script>");
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��߽��ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		
	}
	String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype=" +ctype ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
%>