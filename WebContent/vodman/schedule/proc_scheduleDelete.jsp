<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat, java.util.Date"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");

if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>


<%
	TimeMediaSqlBean bean = new TimeMediaSqlBean();
	int id = 0;
	
	
	
	String day = request.getParameter("day").replaceAll("<","").replaceAll(">","");
	if(day == null || day.length() == 0) {
		out.println("<script language='javascript'>alert('�߸��� �����Դϴ�.');history.go(-1);</script>");
	}

	int result = bean.deleteTimeMediaAll(day);
	
	if(result > -1) {
		
		out.println("<script language='javascript'>" +
			"alert('������ ������ �����Ͽ����ϴ�.');" +
			"document.location='schedule_list.jsp?clickDate="+day+"';" +
			"window.close();" +
			"</script>");
	} else {
		out.println("<script language='javascript'>alert('�������� �����ϴ� �� ������ �߻��Ͽ����ϴ�.');window.close();</script>");
	}
	
%>
	