<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%
	String flag = "WV";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag");
	
	String flag2 = "T";
	if(request.getParameter("flag2") != null && request.getParameter("flag2").length() > 0)
		flag2 = request.getParameter("flag2");
	
	
	int muid = 1;
	try{
		if(request.getParameter("muid") != null && request.getParameter("muid").length() > 0){
			muid = Integer.parseInt( request.getParameter("muid"));
		}
	}catch(Exception ex){
	}
	
	int year=0, month=0, date=0;
	Calendar cal = Calendar.getInstance();
	
	if(request.getParameter("year") != null && request.getParameter("month") != null && request.getParameter("date") != null){
		year  = Integer.parseInt(request.getParameter("year"));
		month  = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
	}else{
		year  = cal.get(Calendar.YEAR);
	    month = cal.get(Calendar.MONTH)+1;
	    date = cal.get(Calendar.DATE);
	}
	
	Vector row=null;
	Vector col=null;

	//int today_ip_count=0;		//오늘 접속자 수
	int today_contact_count=0;	//오늘 카운트 수
	//int month_ip_count=0;		//이달 접속자 수
	int month_contact_count=0;	//이달 카운트 수
	//int total_ip_count=0;		//전체 접속자 수
	int total_contact_count=0;	//전체 카운트 수
	
	
	int today_contact_count1=0;	//오늘 카운트 수
	//int month_ip_count=0;		//이달 접속자 수
	int month_contact_count2=0;	//이달 카운트 수
	//int total_ip_count=0;		//전체 접속자 수
	int total_contact_count3=0;	//전체 카운트 수
	String dt = "";
	
	try{	
		if(request.getParameter("cdate") != null && request.getParameter("cdate").length() > 0){
		dt = request.getParameter("cdate");
		}
	}catch(Exception e){
		dt = "";
	}
	
%>

<%@ include file="/vodman/include/top.jsp"%>
<script>
	function go_month_view(month){
		window.open('stat_month.jsp?year_month='+month, '', 'width=650,height=700,toolbar=no,statusbar=no,resize=yes');
	}
	
	
	//////////////////////////////////////////////////////
	//달력 open window event 
	//////////////////////////////////////////////////////
	
	var calendar=null;
	
	/*날짜 hidden Type 요소*/
	var dateField;
	
	/*날짜 text Type 요소*/
	var dateField2;
	
	function openCalendarWindow(elem) 
	{
		dateField = elem;
		dateField2 = elem;
	
		if (!calendar) {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		} else if (!calendar.closed) {
			calendar.focus();
		} else {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		}
	}
	
	
	function Search(){
		var frm = document.frmpop;
		var str = frm.rstime.value;
		var result1 = "";
		var result2 = "";
		var result3 = "";
		var temp = str.split("-");
		result1 += temp[0];
		result2 += temp[1];
		result3 += temp[2];
		location.href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&year="+result1+"&month="+result2+"&date="+result3+"&flag=<%=flag%>";
	}
	
	
	function ExcelDown(){
		var frm = document.frmpop;
		var str = frm.rstime.value;
		var result1 = "";
		var result2 = "";
		var result3 = "";
		var temp = str.split("-");
		result1 += temp[0];
		result2 += temp[1];
		result3 += temp[2];
		location.href="mng_stat_menu_hit_total_excel.jsp?year="+result1+"&month="+result2+"&date="+result3+"&flag=<%=flag%>";
	}
	
</script>
<%@ include file="/vodman/site/site_left.jsp"%>
		<div id="contents">
			<h3><span><span>시청통계</span></h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>시청통계</span></p>
			<div id="content">
			
				<!-- 내용 -->
				<ul class="s_tab01_bg">
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=WV" title="Today" <%if(flag.equals("WV")){out.println("class='visible'");}%>>웹 VOD통계</a></li>
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=WL" title="Month" <%if(flag.equals("WL")){out.println("class='visible'");}%>>웹 LIVE통계</a></li>
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=MV" title="Year" <%if(flag.equals("MV")){out.println("class='visible'");}%>>모바일 VOD통계</a></li>
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=ML" title="Year" <%if(flag.equals("ML")){out.println("class='visible'");}%>>모바일 LIVE통계</a></li>
				</ul>
				<br/><br/>
				
				<br/>
				<div id="s_tab01">
				<ul class="s_tab01_bg">
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag2=T&flag=<%=flag%>" title="Today" <%if(flag2.equals("T")){out.println("class='visible'");}%>>일 통계</a></li>				
				<li><a href="mng_stat_menu_hit_month_total.jsp?mcode=<%=mcode%>&flag2=M&flag=<%=flag%>" title="Month" <%if(flag2.equals("M")){out.println("class='visible'");}%>>월 통계</a></li>
				<li><a href="mng_stat_menu_hit_year_total.jsp?mcode=<%=mcode%>&flag2=Y&flag=<%=flag%>" title="Year" <%if(flag2.equals("Y")){out.println("class='visible'");}%>>년 통계</a></li>
				</ul>
				<span class="total_right">
				<form name='frmpop' method='post' action="mng_stat_menu_total.jsp?mcode=<%=mcode%>&flag=<%=flag%>">
					<!-- 내용 -->
					<h4>날짜  
					<input type="text" name="rstime" value="<%=year%>-<%=month%>-<%=date%>" class="input01" style="width:80px;"   maxlength="10" readonly="readonly" /></input>
					<a href="javascript:openCalendarWindow(document.frmpop.rstime)" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>&nbsp;
					<a href="javascript:Search();"><img src="/vodman/include/images/but_search.gif" alt="검색" border="0"></a>
					</h4>
				</form>
				</span>
				</div>
				<table cellspacing="0" class="connection_list" summary="메뉴접속통계-종합">
				<caption>메뉴접속통계종합</caption>
				<thead>
					<tr>
						<th width="40%">웹 통계</th>
						<th></th>
						<th>오늘</th>
						<th>이달</th>
						<th>올해</th>
					</tr>
				</thead>
				
				<%
					MenuManager2 mgr = MenuManager2.getInstance();
					Vector vt;
					try{
						
						if(flag.equals("WL")){
							vt= (Vector)mgr.getHitCount(year,month,date,flag,"L");
						}else if(flag.equals("ML")){
							vt= (Vector)mgr.getHitCount(year,month,date,flag,"M");
						}else{
							vt= (Vector)mgr.getHitCount(year,month,date,flag,"V");
						}
					
						if(vt != null && vt.size()>0){	
					
						MenuInfoBean info = new MenuInfoBean();
						
							for(Enumeration e = vt.elements(); e.hasMoreElements();) {
								com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());		
								today_contact_count += info.getCday();
								month_contact_count += info.getCmonth();
								total_contact_count += info.getCyear();
				%>
				<tr>
				<td><%=info.getCtitle() %></td>
				<td></td>
				<td><b><%=info.getCday() %></b></td>
				<td><b><%=info.getCmonth() %></b></td>
				<td><b><%=info.getCyear() %></b></td>
				</tr>
				<%
							}
				%>
				<tr>
						<td><span class="font_size12">합계</span></td>
						<td class="left_border">&nbsp;</td>
						<td><span class="font_colorBlue"><%=today_contact_count%></span></td>
						<td><span class="font_colorBlue"><%=month_contact_count%></span></td>
						<td><span class="font_colorBlue"><%=total_contact_count%></span></td>
				</tr>
				<%
						}else{
				%>
				<tr><td colspan="5"> 검색된 결과가 없습니다.</td></tr>
				<%							
						}
					}catch(Exception ex){
						System.err.println(" mng_stat_menu_hit_total.jsp error = "+ex);
					}		
				%>
				</table>
				<table width="100%">
				<tr>
				<td align="right"></br>&nbsp;&nbsp;<a href="javascript:ExcelDown();"><img src="/vodman/include/images/but_excel.gif" alt="Excel받기" border="0"></a></td>
				</tr>
				</table>		
				</br></br>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>