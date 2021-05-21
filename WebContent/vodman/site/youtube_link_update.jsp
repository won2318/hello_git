<%@ page contentType="text/html; charset=euc-kr"%>
    
    <%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
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
<jsp:useBean id="YoutubeeSqlBean" class= "com.vodcaster.sqlbean.YoutubeeSqlBean"/>
<%

int iSize = 0;
iSize = 20 * 1024 * 1024;
String mcode = request.getParameter("mcode");
String flag = request.getParameter("flag");
YoutubeeSqlBean.update_youtubee(request, iSize);
out.println("mcode="+mcode);
out.println("flag="+flag);

String REF_URL ="youtube_link.jsp?mcode="+mcode+"&flag="+flag;
%>
 <%@ include file = "/vodman/include/REF_URL.jsp"%>
				


