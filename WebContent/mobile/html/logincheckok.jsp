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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<script type="text/javascript" src="/2017/include/js/jquery.min.js"></script>
<script type="text/javascript" src="/2017/include/js/tab.js"></script>
<script type="text/javascript" src="/2017/include/js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="/2017/include/js/jquery.colorbox.js"></script>
<script type="text/javascript" src="/2017/include/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/2017/include/js/common.js"></script>  
<script>
function win_close(){
	//opener.window.close();

	window.close();
}

</script>
<%

String localIP = request.getRemoteAddr();
 
String result_url  = "";
if (request.getParameter("result_url") != null && request.getParameter("result_url").length() > 0) {
	result_url = request.getParameter("result_url").trim();
}
String result_temp = ""; 

if (result_url != null && result_url.length() > 0) {
	result_temp = result_url.replaceAll("::","&");
}
  
if (result_url != null && result_url.contains("type=write")) {
	result_temp = "board_write.jsp?"+result_temp;
 
}else if (result_url != null && result_url.contains("type=update") ) {
	result_temp = "board_update.jsp?"+result_temp;
}else if ( result_url != null && result_url.contains("type=delete") ) {
	result_temp = "proc_boardListDelete.jsp?"+result_temp;
} else {
	result_url = "list";

	result_temp = "main.jsp";
}
 

%>
<%
LoginRsa handler = new LoginRsa( request, response );
int tempLoginFaile = 0;
try{
	handler.processLoginMember(request,response );
}catch(Exception ex){
	//out.println("<script>alert('정확한 회원 정보를 입력하시기 바람니다.');location.href='mancheck.jsp';</script>");
	tempLoginFaile = 1;
}
 

if ((String)session.getValue("vod_id") != null 
	&& session.getValue("vod_id").toString().length() > 0 
	&& (String)session.getValue("vod_level")!= null 
	&& session.getValue("vod_level").toString().length() > 0
	&& tempLoginFaile == 0	) { 
	 
			out.println("<script>");
			out.println("	top.location.href='"+result_temp+"';"); 	 
			out.println("</script>");
		 
} else {
 
	out.println("<script>alert('정확한 회원 정보를 입력하시기 바람니다.');location.href='./login.jsp';</script>");
}
%>
