<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*,  com.hrlee.sqlbean.*, com.yundara.util.*,java.text.SimpleDateFormat,java.io.*"%>
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
	 * @description : ī�װ����� �Է�
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
	}
	else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ī�װ��з��� �������ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype=V" ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	
	

	CategoryManager mgr = CategoryManager.getInstance();
	int result = mgr.createCategory(request);

	if(result >= 0){
		/* ������ ���� ����
			BufferedReader bufferedReader = null;
			String Cmd = "chown -R voduser:voduser "+ com.vodcaster.sqlbean.DirectoryNameManager.UPLOAD_MEDIA;   // root �������� ���� ���� �Ȱ��� voduser �������� ����

			try {
				Process process = Runtime.getRuntime().exec(Cmd);
				
				String line;        
				bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
				bufferedReader.close();

				process.waitFor();
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if (bufferedReader != null) try { bufferedReader.close(); } catch (Exception _ignored){}
			}
		*/
		//out.println("<script language='javascript'>location.href='mng_categoryList.jsp?mcode=0401&ctype=" +ctype+ "';</script>");
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('��ϵǾ����ϴ�.')");
		out.println("</SCRIPT>");
		String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype="+ctype ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��߽��ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype="+ctype ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
	}

%>