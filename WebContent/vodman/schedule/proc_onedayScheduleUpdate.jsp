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
	
	
	String day = request.getParameter("selectday");
	if(day == null || day.length() == 0) {
		day = TimeUtil.getCurDate().substring(0,8);
	}
	
	String clickDate = request.getParameter("clickDate");
	if(clickDate == null || clickDate.length() == 0) {
		out.println("<script language='javascript'>alert('잘못된 선택입니다.');history.go(-1);</script>");
	}
	
	Vector vt = bean.selectTimeMedia(clickDate);
	
	if(vt !=null && vt.size() > 0) {
		
		int result = bean.insertTimeMediaAll(day, clickDate);
		
		if(result > -1) {
			
			out.println("<script language='javascript'>" +
				"alert('스케쥴 정보를 가져왔습니다.');" +
				"opener.document.location='schedule_list.jsp?clickDate="+day+"';" +
				"window.close();" +
				"</script>");
		} else {
			out.println("<script language='javascript'>alert('스케쥴을 가져오는 중 오류가 발생하였습니다.');window.close();</script>");
		}
	} else {
		out.println("<script language='javascript'>" +
				"alert('선택하신 날짜에는 스케쥴정보가 없습니다.\\n다른 날짜를 선택하십시오.');" +
				"history.go(-1);" +
				"</script>");
	}
	
%>
	