<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<jsp:useBean id="Ucc" class="com.vodcaster.sqlbean.UccSQLBean"/>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "v_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

<%
String ocode = "";
	if (request.getParameter("ocode") == null || request.getParameter("ocode").length() <= 0) {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 요청입니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	} else {
	 ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","") ;
	}
 
	String ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");

	if(ccode == null || ccode.length() <= 0)
		ccode = "";

	int result = Ucc.delete_admin(ocode);

	if(result >= 0){
%>		
		<div id="silverlightControlHost">
		<object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="10" height="10">
		<param name="source" value="<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME %>/ClientBin/DeleteMediaFolder.xap"/>
		<param name="initParams" value="ocode=<%=ocode%>"/> <!-- lms folder 아래의 디렉토리명 -->
		<param name="onerror" value="onSilverlightError" />
		<param name="background" value="white" />
		<param name="minRuntimeVersion" value="3.0.40624.0" />
		<param name="autoUpgrade" value="true" />
		<a href="http://go.microsoft.com/fwlink/?LinkID=141205" style="text-decoration: none;">
		<img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none"/>
		</a>
		</object>
		<iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe>
	</div>
<%	
		response.sendRedirect("mng_vodOrderList.jsp?ccode="+ccode);
		
	} else if(result == -99){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.1')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.2')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
%>