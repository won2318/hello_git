<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.hrlee.sqlbean.CategoryManager"%> 
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@page import="com.yundara.util.TextUtil"%>
 <%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@page import="com.vodcaster.sqlbean.DirectoryNameManager"%>
 
 
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />

<%@ include file = "../include/head.jsp"%>
<%@ include file="/include/chkLogin.jsp"%>
<%
	request.setCharacterEncoding("EUC-KR");

java.util.Date day = new java.util.Date();
SimpleDateFormat today_sdf = new SimpleDateFormat("yyyy");
String this_year = today_sdf.format(day);

SimpleDateFormat today_check = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String today_string = today_check.format(day);


MediaManager mgr = MediaManager.getInstance();
Hashtable result_ht = null; 

String ccode ="";
if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
} 
int board_id = 0;   

if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
{
	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
	 
} 

String year =this_year;
if (request.getParameter("year") != null && request.getParameter("year").length() > 0  && !request.getParameter("year").equals("null")) {
	year = com.vodcaster.utils.TextUtil.getValue(request.getParameter("year"));
}  
 
	 
	Vector vt = lMgr.getLive_ListAll_out("L", year);
	com.hrlee.sqlbean.LiveInfoBean linfo = new com.hrlee.sqlbean.LiveInfoBean();

%>
 
    <script language="JavaScript" type="text/JavaScript">
    function pre(year){
    	var this_value = parseInt(year) - 1;
    	location.href="LiveSchedule.jsp?year="+this_value;
    }
    
    function next(year){
    	var this_value = parseInt(year) + 1;
 
    	location.href="LiveSchedule.jsp?year="+this_value;
    }
    </script>
	
	<div class="snb">
		<strong>생방송 일정</strong>
		<span><button onclick="showHide('menuFull');return false;" class="menu_view">영상더보기</button></span>
		<div id="menuFull" style="display:none;">
		<ul class="menuView">
			 <%@ include file = "../include/iTV_menu.jsp"%>
		</ul>
		<button onclick="showHide('menuFull');return false;" class="menu_close">메뉴닫기</button>
		</div>
	</div>


</div>
<div id="container"> 
	<div class="major">
	<section>
		<div class="year">
			<a href="javascript:pre('<%=year%>');" class="btn2">◀</a>
			<span><%=year %></span>
			<a href="javascript:next('<%=year%>');" class="btn2">▶</a>
		</div>
		<div class="ScheduleList">
			<ul>
<% 				
			if(vt != null && vt.size()>0){
				try {
					String temp_month2 = "temp";
					boolean check_month = true;
					for(int i = 0;  i < vt.size() ; i++ )
					{
					
							Hashtable ht_list = (Hashtable)vt.get(i); 
							com.yundara.beans.BeanUtils.fill(linfo, ht_list);
							String temp_year = "";
							String temp_month = "";
							String temp_day = "";
							String temp_time = "";
							
							if (linfo.getRstart_time() != null) {
								temp_year = linfo.getRstart_time().substring(0,4);
								temp_month = linfo.getRstart_time().substring(5,7);
								temp_day = linfo.getRstart_time().substring(8,10);
								temp_time = linfo.getRstart_time().substring(11);
								 
							}
						 
							long s_date = Long.parseLong(linfo.getRstart_time().replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "").trim());
							long e_date = Long.parseLong(linfo.getRend_time().replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "").trim());
							long this_date = Long.parseLong(today_string.replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "").trim());
				 
							
	%> 		
				<li>
					<span class="day"><strong><%=linfo.getRstart_time() %></strong>  </span>
					<span class="title"><%=linfo.getRtitle() %></span>
					<span class="replay">
					<%if ( s_date <= this_date && this_date <= e_date) {%> <a href='<%=live_url%>' onclick="live_log('<%=linfo.getRcode()%>');"><img src='../include/images/icon_onair.gif' alt='ON-AIR'/></a><%} %>
					<%if (linfo.getOcode() != null && linfo.getOcode().length() > 0) { %>
						<a  href="javascript:link_colorbox('vod_view.jsp?ocode=<%=linfo.getOcode()%>');"><img src="../include/images/icon_tv1.gif" alt="1"/></a>
					<%} 
					if (linfo.getOcode2() != null && linfo.getOcode2().length() > 0) { %>
						<a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=linfo.getOcode2()%>');"><img src="../include/images/icon_tv2.gif" alt="2"/></a>
					<%} 
					if (linfo.getOcode3() != null && linfo.getOcode3().length() > 0) { %>
						<a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=linfo.getOcode3()%>');"><img src="../include/images/icon_tv3.gif" alt="3"/></a>
					<%} %>
						 
					</span>
				</li>
				 
				<% 
				}
					
				} catch (Exception e) {
					out.println("생방송 정보를 읽어 오는중 오류가 발생하였습니다. 관리자에게 문의 하세요");
				}
			}
%>
			
			</ul>
		</div>
	</section>
	</div>


</div>

 <%@ include file = "../include/foot.jsp"%>
</body>
</html>