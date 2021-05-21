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
 
<%@ include file="/vodman/include/top.jsp"%> 
 
		<div id="contents">
 
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td width="185" align="center" valign="top">
									<iframe id="cal_month" name="cal_month" src="month_calendar.jsp" width="185" height="220" scrolling="no" frameborder="0"></iframe>
									<iframe id="bestVod" name="bestVod" src="/silverPlayer_admin.jsp?height=185&width=210" scrolling='no' width="185" height="180" marginwidth=0 frameborder=0 framespacing=0 ></iframe>
								</td>
								<td width="340" valign="top">
									<!-- 스케줄목록 -->
									<table cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td valign="top">
												<iframe id="cal_week" name="cal_week" src="week_calendar.jsp" width="333" height="39" scrolling="no" frameborder="0"></iframe>
												<iframe id="schedule_list" name="schedule_list" src="" width="333" height="500" scrolling="no" frameborder="0"></iframe>
											</td>
										</tr>
									</table>
									<!-- 스케줄목록 -->
								</td>
								<td width="400" valign="top">
									<!-- 영상목록, 카테고리 -->
									<table cellpadding="0" cellspacing="0" style="border: 1px solid #dbe2ed;" width="100%" height="550">
										<tr>
											<td style="border-right: 1px solid #dbe2ed;" valign="top">
												<iframe id="search_media" name="search_media" src="frm_bestVodList.jsp" width="400" height="550" scrolling="no" frameborder="0"></iframe>		
											 
											</td>
										</tr>
									</table>
									<!-- 영상목록, 카테고리 -->
								</td>
							</tr>
						</table>
 
 		</div>
<%@ include file="/vodman/include/footer.jsp"%>	
 

