<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.rsa.*,com.vodcaster.utils.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
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
	 * date : 2005-01-08
	 */
	//request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "1001";
	}
 
	try {
		LoginRsa handler = new LoginRsa( request, response );
		handler.processRequestMember(request,response );
		if (request.getAttribute("return_value") != null  && Integer.parseInt(request.getAttribute("return_value").toString()) > 0 ) {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('��ϵǾ����ϴ�.')");
			//out.println("location.href='mng_memberList.jsp?mcode="+mcode+"';");
			out.println("</SCRIPT>");	
		} else if (request.getAttribute("return_value") != null  && Integer.parseInt(request.getAttribute("return_value").toString()) == -99 ) {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('���̵� �ߺ� �˴ϴ�!')");
			//out.println("location.href='/';");
			out.println("</SCRIPT>");
			
		}else {
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('��Ͽ� �����Ͽ����ϴ�. �����ڿ��� ���� �ϼ���!')");
			//out.println("location.href='/';");
			out.println("</SCRIPT>");
		}
 
	}catch(Exception e) {
		System.err.println(e.getMessage());
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('��Ͽ� �����Ͽ����ϴ�. �����ڿ��� ���� �ϼ���!')");
		//out.println("location.href='/';");
		out.println("</SCRIPT>");
	}
	String REF_URL="mng_memberList.jsp?mcode="+mcode ;
		%>
	<%@ include file = "/vodman/include/REF_URL.jsp"%>
		
