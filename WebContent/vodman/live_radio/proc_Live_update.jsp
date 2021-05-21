<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
//request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "r_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%> 
<jsp:useBean id="Live" class="com.hrlee.sqlbean.LiveSqlBean"/>

<%
	String mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0601";
	}
	
	String rcode = request.getParameter("rcode").replaceAll("<","").replaceAll(">","");
	if(rcode == null || rcode.length() <= 0 || rcode.equals("null")) {
		rcode = "";
	}

    try {

		int result = Live.update(request);
	
		if(result >= 0){
	
			out.println("<script>");
			out.println("alert('수정되었습니다.')");
			//out.println("location.href='frm_Live_Update.jsp?mcode="+mcode+"&rcode="+rcode+"'");
			out.println("</script>");
			
				
		}else{
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
            out.println("alert('처리 중 오류가 발생했습니다.')");
            //out.println("history.go(-1)");
            out.println("</SCRIPT>");
	    }

    } catch(Exception e){
        System.out.println(e);
         out.println("<SCRIPT LANGUAGE='JavaScript'>");
            out.println("alert('처리 중 오류가 발생했습니다.')");
            //out.println("history.go(-1)");
            out.println("</SCRIPT>");
    }
	String REF_URL="frm_Live_Update.jsp?mcode="+mcode+"&rcode="+rcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
%>
