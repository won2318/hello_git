<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page language="java" import="
java.sql.*,
java.util.*,
java.text.*,
java.io.*,
java.net.*,
com.rsa.*,
com.vodcaster.utils.*
"%>
<%-- <%@ page import="com.login.LoginManager"%> --%>
<%@ page import="com.rsa.LoginRsa"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%

String localIP = request.getRemoteAddr();

// if (localIP.startsWith("211.114.22.71") ||  localIP.startsWith("27.101.101.")||  localIP.startsWith("211.114.22.131") ) {

// } else {
// response.sendRedirect("/");

// }

%>
<%
//LoginManager handler = new LoginManager( request, response );
LoginRsa handler = new LoginRsa( request, response );
int tempLoginFaile = 0;
try{
 
	handler.processRequest(request,response );
 
}catch(Exception ex){
	//out.println("<script>alert('��Ȯ�� ȸ�� ������ �Է��Ͻñ� �ٶ��ϴ�.');location.href='mancheck.jsp';</script>");
	tempLoginFaile = 1;
} 
if ((String)session.getValue("admin_id") != null 
	&& session.getValue("admin_id").toString().length() > 0 
	&& (String)session.getValue("vod_level")!= null 
	&& session.getValue("vod_level").toString().length() > 0
	&& tempLoginFaile == 0	) {
	String REF_URL="/vodman/vod_aod/mng_vodOrderList.jsp?mcode=0701";

	if (request.getAttribute("pwd_chk_date") != null && request.getAttribute("pwd_change_date") != null && Integer.parseInt(request.getAttribute("pwd_chk_date").toString().substring(0,10).replaceAll("-","")) <  Integer.parseInt( request.getAttribute("pwd_change_date").toString().substring(0,10).replaceAll("-","")) ) {
		 
	}  else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('��й�ȣ ������ 6���� �̻� ��� �Ͽ����ϴ�. \\n ��й�ȣ�� �����ϼ���!')");
 
		out.println("</SCRIPT>");
	}
 
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	 
} else if(request.getAttribute("login_cnt") != null && request.getAttribute("login_cnt").toString().length()  > 0) {
	 
	if (TextUtil.isNumber(request.getAttribute("login_cnt").toString() ) ) { // ���ڰ� �ƴϸ�
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	if (Integer.parseInt(request.getAttribute("login_cnt").toString()) < 5 && request.getAttribute("login_check") != null && request.getAttribute("login_check").equals("N") ) {
		out.println("alert(' ��й�ȣ  "+(Integer.parseInt(request.getAttribute("login_cnt").toString()) +1) +" ȸ ����!  5ȸ ������ �α����� ���ѵ˴ϴ�.')");
	} else {
		out.println("alert(' "+Integer.parseInt(request.getAttribute("login_cnt").toString())*6+" �� �� �α��� �����մϴ�.')");	
		
	} 
  
    out.println("location.href='/vodman/mancheck.jsp';");
	out.println("</SCRIPT>");
	return;
	} else {
		out.println("<script>alert('��Ȯ�� ȸ�� ������ �Է��Ͻñ� �ٶ��ϴ�.');location.href='mancheck.jsp';</script>");
	}
} else { 
	out.println("<script>alert('��Ȯ�� ȸ�� ������ �Է��Ͻñ� �ٶ��ϴ�.');location.href='mancheck.jsp';</script>");
}
%>
