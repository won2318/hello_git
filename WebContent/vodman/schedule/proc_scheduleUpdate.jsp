<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
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
	if(day == null || day.length() <= 0) {
		day = TimeUtil.getCurDate().substring(0,8);
		
	}
	
	if(request.getParameter("id") == null || request.getParameter("id").length() == 0) {
		out.println("<script language='javascript'>alert('해당 미디어가 없습니다.');history.go(-1);</script>");
	} else {
		id = Integer.parseInt(request.getParameter("id"));
	}
	
	String flag = request.getParameter("flag");
	if(flag == null || flag.length() <= 0) {
		out.println("<script language='javascript'>alert('잘못된 선택입니다.');history.go(-1);</script>");
	}
	
	TimeMediaManager tMgr = TimeMediaManager.getInstance();
	com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();
	int result = 0;
 	String input_time = "";
 	if(request.getParameter("input_time") != null && request.getParameter("input_time").length() > 0) {
		input_time = request.getParameter("input_time");
	}

	try {
		Vector vt = tMgr.getSchedule(id, day);
 	
		int ptime =Integer.parseInt(String.valueOf(vt.elementAt(6)));
		int stime =Integer.parseInt(String.valueOf(vt.elementAt(3)));
		int etime =Integer.parseInt(String.valueOf(vt.elementAt(4)));
		int list = 0;
		int parent_id = 0;
		int parent_stime = 0;
		int parent_etime = 0;
		int parent_ptime = 0;
		int max_time = 24*60*60;
		
		
		Vector topVt = tMgr.getScheduleTop(day, stime, flag);
 
		if(topVt != null && topVt.size() > 0) {
			if(flag.equals("top")) {
				int tmp_time = 0;
				
				for(Enumeration e = topVt.elements(); e.hasMoreElements(); list++) {
					com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
					parent_id = Integer.parseInt(String.valueOf(info.getId()));
					parent_ptime = Integer.parseInt(String.valueOf(info.getTemp1()));
					parent_stime = Integer.parseInt(String.valueOf(info.getTime()));
	
					if(list == 0) {
						list = list+1;
						stime = parent_stime;
						etime = stime + ptime;
						parent_stime = etime + 1;
						parent_etime = parent_stime + parent_ptime;
					} else {
						parent_stime = parent_etime + 1;
						parent_etime = parent_stime +parent_ptime;
					}
					if(parent_etime > max_time) {
						parent_etime = max_time;
					}
					result = bean.updateTimeMedia(parent_id,parent_stime,parent_etime);
				}
				result = bean.updateTimeMedia(id,stime,etime);
				
			} else if(flag.equals("up")) {
				for(Enumeration e = topVt.elements(); e.hasMoreElements(); list++) {
					com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
					parent_id = Integer.parseInt(String.valueOf(info.getId()));
					parent_ptime = Integer.parseInt(String.valueOf(info.getTemp1()));
					parent_stime = Integer.parseInt(String.valueOf(info.getTime()));
				}
				stime = parent_stime;
				etime = parent_stime + ptime;
				parent_stime = etime + 1;
				parent_etime = parent_stime + parent_ptime;
				
				if(parent_etime > max_time) {
					parent_etime = max_time;
				}
				
				result = bean.updateTimeMedia(id, stime, etime);
				result = bean.updateTimeMedia(parent_id, parent_stime, parent_etime);
				
			} else if(flag.equals("down")) {
				if(topVt.size() > 1) {
					for(Enumeration e = topVt.elements(); e.hasMoreElements(); list++) {
						com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
						parent_id = Integer.parseInt(String.valueOf(info.getId()));
						parent_ptime = Integer.parseInt(String.valueOf(info.getTemp1()));
						if(list == 1) break;
						
					}
					parent_stime = stime;
					parent_etime = stime + parent_ptime;
					stime = parent_etime + 1;
					etime = stime + ptime;
					
					if(etime > max_time) {
						etime = max_time;
					}
					
					
					result = bean.updateTimeMedia(id, stime, etime);
					result = bean.updateTimeMedia(parent_id, parent_stime, parent_etime);
				}
			} else if(flag.equals("bottom")) {
				if(topVt.size() > 1) {
					for(Enumeration e = topVt.elements(); e.hasMoreElements(); list++) {
						com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
						parent_id = Integer.parseInt(String.valueOf(info.getId()));
						parent_ptime = Integer.parseInt(String.valueOf(info.getTemp1()));
						
						if(parent_id != id) {
							if(list == 1) {
								parent_stime = stime;
							} else {
								parent_stime = parent_etime + 1;
							}
							parent_etime =  parent_stime + parent_ptime;
							result = bean.updateTimeMedia(parent_id, parent_stime, parent_etime);
						}
					}
					stime = parent_etime+1;
					etime = stime + ptime;
					
					if(etime > max_time) {
						etime = max_time;
					}
					result = bean.updateTimeMedia(id, stime, etime);
				}
			} else if(flag.equals("delete")) {
				
				for(Enumeration e = topVt.elements(); e.hasMoreElements(); list++) {
					com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
					parent_id = Integer.parseInt(String.valueOf(info.getId()));
					parent_ptime = Integer.parseInt(String.valueOf(info.getTemp1()));
					
					if(parent_id != id) {
						if(list == 1) {
							parent_stime = stime;
						} else {
							parent_stime = parent_etime + 1;
						}
						parent_etime =  parent_stime + parent_ptime;
						
						if(parent_etime > max_time) {
							parent_etime = max_time;
						}
						result = bean.updateTimeMedia(parent_id, parent_stime, parent_etime);
					}
				}
				result = bean.deleteTimeMedia(id, day);
			} else if (flag.trim().equals("middle")) {
 		
				int tmp_time = 0;
				for(Enumeration e = topVt.elements(); e.hasMoreElements(); list++) {
					com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
					parent_id = Integer.parseInt(String.valueOf(info.getId()));
					parent_ptime = Integer.parseInt(String.valueOf(info.getTemp1()));
					parent_stime = Integer.parseInt(String.valueOf(info.getTime()));
					
 
					if ( Integer.parseInt(input_time) <=  parent_stime) {
						if ( Integer.parseInt(input_time) == parent_stime) {
 
							result = bean.updateTimeMedia(id,parent_stime,parent_stime+ptime);
							result = bean.updateTimeMedia(parent_id,parent_stime+ptime+1,parent_stime+ptime+1+parent_ptime);
							tmp_time = parent_stime+ptime+1+parent_ptime+1;
						}else if (stime == parent_stime){
 							
						}else {
 					
							result = bean.updateTimeMedia(parent_id,tmp_time,tmp_time+parent_ptime);
							tmp_time = tmp_time+parent_ptime +1 ;
						}
						
					}
				}
				 
				
			}
		}
		
		if(result > -1) {
			 
				response.sendRedirect("schedule_list.jsp?clickDate="+day+"&input_time="+input_time+"&middle="+flag+"#end");
			 
		} else {
			out.println("<script language='javascript'>alert('처리중 오류가 발생하였습니다..');history.go(-1);</script>");
		}
	}catch(Exception e) {
		
	}
	
	

%>