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
	
	
	String day = request.getParameter("selectday");
	if(day == null || day.length() == 0) {
		day = TimeUtil.getCurDate().substring(0,8);
	}
	
	String clickDate = request.getParameter("clickDate");
	if(clickDate == null || clickDate.length() == 0) {
		out.println("<script language='javascript'>alert('�߸��� �����Դϴ�.');history.go(-1);</script>");
	}
	
	Vector vt = bean.selectTimeMedia(clickDate);
	
	if(vt !=null && vt.size() > 0) {
		
		int result = bean.insertTimeMediaAll(day, clickDate);
		
		if(result > -1) {
			
			out.println("<script language='javascript'>" +
				"alert('������ ������ �����Խ��ϴ�.');" +
				"opener.document.location='schedule_list.jsp?clickDate="+day+"';" +
				"window.close();" +
				"</script>");
		} else {
			out.println("<script language='javascript'>alert('�������� �������� �� ������ �߻��Ͽ����ϴ�.');window.close();</script>");
		}
	} else {
		out.println("<script language='javascript'>" +
				"alert('�����Ͻ� ��¥���� ������������ �����ϴ�.\\n�ٸ� ��¥�� �����Ͻʽÿ�.');" +
				"history.go(-1);" +
				"</script>");
	}
	
%>
	