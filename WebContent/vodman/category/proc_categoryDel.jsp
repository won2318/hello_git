<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "cate_del")) {
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
	String cuid = "";
    String ctype = "";

    String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0401";
	}
	
    if(request.getParameter("ctype") != null && request.getParameter("ctype").length()>0 && !request.getParameter("ctype").equals("null")){
		ctype = request.getParameter("ctype");
    }else{
		String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype=V" ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

	if(request.getParameter("cuid") != null) {

		cuid = request.getParameter("cuid").trim();

		CategoryManager mgr = CategoryManager.getInstance();

        if(request.getParameter("ctype") != null) {
            ctype = request.getParameter("ctype");
        } else {

            try {
                Vector v = MediaManager.getInstance().selectQuery("select ctype from category where del_flag='N' and cuid=" +cuid);
                ctype = String.valueOf(v.elementAt(0));
            } catch(Exception e) {}
        }

		Vector vr = null;

		vr = mgr.deleteCategory(cuid);

		if(vr != null && vr.size() >= 0){
			//out.println("<SCRIPT LANGUAGE='JavaScript'>");
			//out.println("location.href='mng_categoryList.jsp?mcode="+mcode+"&ctype=" +ctype+ "';");
			//out.println("</SCRIPT>");
			String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype=" +ctype ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('�����з��� ������� ������ �� �����ϴ�. �����з����� �������ּ���.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype=" +ctype ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
		}
	
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ī�װ���ȣ�� �����ϴ�. �ٽ� �������ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype=" +ctype ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				
	}

%>