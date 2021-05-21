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
	
	
	String day = request.getParameter("clickDate");
	if(day == null || day.length() == 0) {
		day = TimeUtil.getCurDate().substring(0,8);
		
	}
	
	String hour = request.getParameter("hour");
	if(hour == null || hour.length() == 0) {
		out.println("<script language='javascript'>alert('시작시간(시) 설정이 잘못되었습니다.');history.go(-1);</script>");
	}
	
	String minute = request.getParameter("minute");
	if(minute == null || minute.length() == 0) {
		out.println("<script language='javascript'>alert('시작시간(분) 설정이 잘못되었습니다.');history.go(-1);</script>");
		
	}
	
	int start_time = Integer.parseInt(hour)*60*60 + Integer.parseInt(minute)*60;

	TimeMediaManager tMgr = TimeMediaManager.getInstance();
	com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();
	int result = 0;
	
	try {
		Vector vt = tMgr.getTime_ListAll(day);
		int list = 0;
		int parent_id = 0;
		int parent_stime = 0;
		int parent_etime = 0;
		int parent_ptime = 0;
		int max_time = 24*60*60;
		
		if(vt != null && vt.size() > 0) {
				
			for(Enumeration e = vt.elements(); e.hasMoreElements(); list++) {
				com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
				parent_id = Integer.parseInt(String.valueOf(info.getId()));
				parent_ptime = Integer.parseInt(String.valueOf(info.getTemp1()));
				
				if(list == 0) {
					parent_stime = start_time;
					parent_etime = start_time + parent_ptime;
				} else {
					parent_stime = parent_etime + 1;
					parent_etime = parent_stime + parent_ptime;
				}
				
				if(parent_stime > max_time) {
					result = bean.deleteTimeMedia(parent_id, day);
					
				} else if(parent_etime > max_time) {
					result = bean.updateTimeMedia(parent_id, parent_stime, max_time);
					
				} else {
					result = bean.updateTimeMedia(parent_id, parent_stime, parent_etime);
					
				}
			}
				
		}
		
		if(result > -1) {
			response.sendRedirect("schedule_list.jsp?clickDate="+day);
		} else {
			out.println("<script language='javascript'>alert('처리중 오류가 발생하였습니다..');history.go(-1);</script>");
		}
	}catch(Exception e) {
		
	}
	

%>