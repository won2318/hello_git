<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, javazoom.upload.*"%>
<%@page import="com.vodcaster.multpart.DefaultFileRenamePolicyITNC21"%>
<jsp:useBean id="DirectoryNameManager" class="com.vodcaster.sqlbean.DirectoryNameManager"/>
<%@ page import="java.util.Calendar, java.text.SimpleDateFormat, java.sql.Timestamp" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="Photo" class="com.vodcaster.sqlbean.PopupManager"/>

<%
	String seq = request.getParameter("seq");

    try {
        if(request.getParameter("seq") == null) {
    		out.println("<script lanauage='javascript'>alert('�˾� �ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
    	} else{
    		seq = request.getParameter("seq");
    	}
		int result = Photo.imageUpdatePOP(request);
	
	
	
		if(result >= 0){

				out.println("<script>");
				out.println("opener.document.location.reload();");
				out.println("self.close();");
				out.println("</script>");

		}else{
	            out.println("<SCRIPT LANGUAGE='JavaScript'>");
	            out.println("alert('�̹��� ��Ͽ� �����Ͽ����ϴ�.')");
	            out.println("history.go(-1)");
	            out.println("</SCRIPT>");
	        }

    } catch(Exception e){
        System.out.println(e);
    }
%>