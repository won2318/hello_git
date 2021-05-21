<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat, java.util.Date"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");

if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
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
		out.println("<script language='javascript'>alert('잘못된 선택입니다.');history.go(-1);</script>");
	}

	int result = bean.deleteTimeMediaAll(day);
	
	if(result > -1) {
		
		out.println("<script language='javascript'>" +
			"alert('스케쥴 정보를 삭제하였습니다.');" +
			"document.location='schedule_list.jsp?clickDate="+day+"';" +
			"window.close();" +
			"</script>");
	} else {
		out.println("<script language='javascript'>alert('스케쥴을 삭제하는 중 오류가 발생하였습니다.');window.close();</script>");
	}
	
%>
	