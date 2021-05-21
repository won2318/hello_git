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
	//out.println("<script>alert('정확한 회원 정보를 입력하시기 바람니다.');location.href='mancheck.jsp';</script>");
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
		out.println("alert('비밀번호 변경후 6개월 이상 경과 하였습니다. \\n 비밀번호를 변경하세요!')");
 
		out.println("</SCRIPT>");
	}
 
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	 
} else if(request.getAttribute("login_cnt") != null && request.getAttribute("login_cnt").toString().length()  > 0) {
	 
	if (TextUtil.isNumber(request.getAttribute("login_cnt").toString() ) ) { // 숫자가 아니면
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	if (Integer.parseInt(request.getAttribute("login_cnt").toString()) < 5 && request.getAttribute("login_check") != null && request.getAttribute("login_check").equals("N") ) {
		out.println("alert(' 비밀번호  "+(Integer.parseInt(request.getAttribute("login_cnt").toString()) +1) +" 회 오류!  5회 오류시 로그인이 제한됩니다.')");
	} else {
		out.println("alert(' "+Integer.parseInt(request.getAttribute("login_cnt").toString())*6+" 분 후 로그인 가능합니다.')");	
		
	} 
  
    out.println("location.href='/vodman/mancheck.jsp';");
	out.println("</SCRIPT>");
	return;
	} else {
		out.println("<script>alert('정확한 회원 정보를 입력하시기 바람니다.');location.href='mancheck.jsp';</script>");
	}
} else { 
	out.println("<script>alert('정확한 회원 정보를 입력하시기 바람니다.');location.href='mancheck.jsp';</script>");
}
%>
