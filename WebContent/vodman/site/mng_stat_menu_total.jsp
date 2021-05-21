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
	String flag = "W";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	int muid = 1;
	try{
		if(request.getParameter("muid") != null && request.getParameter("muid").length() > 0){
			muid = Integer.parseInt( request.getParameter("muid"));
		}
	}catch(Exception ex){
	}
	Calendar cal = Calendar.getInstance();
	int year  = cal.get(Calendar.YEAR),
	    month = cal.get(Calendar.MONTH)+1,
	    date = cal.get(Calendar.DATE);
	
	
	String mon = "";
	String dat = "";
	
	if(month<10){
		mon = Integer.toString(month);
		mon = "0" + month;
	}else{
		mon = Integer.toString(month);
	}
	
	if(date<10){
		dat = Integer.toString(date);
		dat = "0" + date;
	}else{
		dat = Integer.toString(date);
	}
	
	
	String today = Integer.toString(year)+mon+dat;
	
	Vector row=null;
	Vector col=null;
	
	
	
	
// 	StatsManager mgr1 = StatsManager.getInstance();
// 	Vector vt1 = (Vector)mgr1.getBestList();
			
// 	BestTopInfoBean btiBean1 = new BestTopInfoBean();
	
// 	Hashtable sel = (Hashtable)vt1.get(0);
	
	
// 	out.println(sel);
// 	out.print("abcd");
	
	//com.yundara.beans.BeanUtils.fill(btiBean1, (Hashtable)e.nextElement());
	
	
   
	
    
    
    
    

	//int today_ip_count=0;		//오늘 접속자 수
	int today_contact_count=0;	//오늘 카운트 수
	//int month_ip_count=0;		//이달 접속자 수
	int month_contact_count=0;	//이달 카운트 수
	//int total_ip_count=0;		//전체 접속자 수
	int total_contact_count=0;	//전체 카운트 수
	
	
	int today_contact_count1=0;	//오늘 카운트 수
	int month_contact_count2=0;	//이달 카운트 수
	int total_contact_count3=0;	//전체 카운트 수
	String dt = request.getParameter("cdate").replaceAll("<","").replaceAll(">","");
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
		location.href='mng_stat_menu_total.jsp?mcode=<%=mcode%>&cdate='+document.frmpop.rstime.value;
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
		location.href="mng_view_stat_excel.jsp?year="+result1+"&month="+result2+"&date="+result3;
	}
	
</script>
<%@ include file="/vodman/site/site_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메뉴접속통계종합</span> 보기</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>메뉴접속통계 종합</span></p>
			<div id="content">
			
			
				<!-- 내용 -->
				
<!-- 					<ul class="s_tab01_bg"> -->
<%-- 					<li><a href="mng_stat_menu.jsp?mcode=<%=mcode%>&flag=W" title="Web" <%if(flag.equals("W")){out.println("class='visible'");}%>>Web</a></li> --%>
<%-- 					<li><a href="mng_stat_menu.jsp?mcode=<%=mcode%>&flag=M" title="Mobile" <%if(flag.equals("M")){out.println("class='visible'");}%>>Mobile</a></li> --%>
<!-- 				</ul><br><br> -->
				
			<form name='frmpop' method='post' action="mng_stat_menu_total.jsp?mcode=<%=mcode%>&flag=<%=flag%>">
				<!-- 내용 -->
				<h4>날짜  
				<%if(dt==null){ %>
				<input type="text" name="rstime" value="<%=year%>-<%=mon%>-<%=dat%>" class="input01" style="width:80px;"   maxlength="10" readonly="readonly" /></input>
				<%}else{ %>
				<input type="text" name="rstime" value="<%=dt%>" class="input01" style="width:80px;"   maxlength="10" readonly="readonly" /></input>
				<%} %>
				<a href="javascript:openCalendarWindow(document.frmpop.rstime)" title="찾아보기"><img src="/vodman/include/images/but_seek.gif" alt="찾아보기"/></a>&nbsp;
				<a href="javascript:Search();"><img src="/vodman/include/images/but_search.gif" alt="검색" border="0"></a>
				</h4>
			</form>
				<table cellspacing="0" class="connection_list" summary="메뉴접속통계-종합">
				<caption>메뉴접속통계종합</caption>
				<colgroup>
					<col width="20%"/>
					<col/>
					<col width="24%" span="3"/>
				</colgroup>
				<thead>
				<tr>
				<td><br/><br/><b>웹 메뉴클릭 통계 총합</b></td>
				</tr>
				</thead>
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>오늘</th>
						<th>이달</th>
						<th>올해</th>
					</tr>
				</thead>
				<tbody>
				<%
					MenuManager mgr = MenuManager.getInstance();
					Vector vt;
					
					if(dt==null){
						vt= (Vector)mgr.getMenuListALL2(today,"W","");
					}else{
						String [] stt = dt.split("-");
						String jang = stt[0]+stt[1]+stt[2];
						vt= (Vector)mgr.getMenuListALL2(jang,"W","");
					}					
					MenuInfoBean info = new MenuInfoBean();
					
					for(Enumeration e = vt.elements(); e.hasMoreElements();) {
						com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());		
						today_contact_count += info.getSum_hit1();
						month_contact_count += info.getSum_hit2();
						total_contact_count += info.getSum_hit3();
					%>
					<tr>
						<td><span class="font_size12"><%=info.getMtitle()%></span></td>
						<td class="left_border">&nbsp;</td>
						<td><span class="font_colorBlue"><%=info.getSum_hit1()%></span></td>
						<td><b><%=info.getSum_hit2()%></b></td>
						<td><b><%=info.getSum_hit3()%></b></td>
					</tr>
						<%
					}
					%>
					<tr>
						<td><span class="font_size12">합계</span></td>
						<td class="left_border">&nbsp;</td>
						<td><span class="font_colorBlue"><%=today_contact_count%></span></td>
						<td><b><%=month_contact_count%></b></td>
						<td><b><%=total_contact_count%></b></td>
					</tr>
				</tbody>
				<thead>
				<tr>
				<td><br/><br/><br/><br/><b>모바일 메뉴클릭 통계 총합</b></td>
				</tr>
				</thead>
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>오늘</th>
						<th>이달</th>
						<th>올해</th>
					</tr>
				</thead>
				<tbody>				
				<%
					if(dt==null){
						vt= (Vector)mgr.getMenuListALL2(today,"M","");
					}else{
						String [] stt = dt.split("-");
						String jang = stt[0]+stt[1]+stt[2];
						vt= (Vector)mgr.getMenuListALL2(jang,"M","");
					}
					
					for(Enumeration e = vt.elements(); e.hasMoreElements();) {
						com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());		
						
						today_contact_count1 += info.getSum_hit1();
						month_contact_count2 += info.getSum_hit2();
						total_contact_count3 += info.getSum_hit3();
					%>
					<tr>
						<td><span class="font_size12"><%=info.getMtitle()%></span></td>
						<td class="left_border">&nbsp;</td>
						<td><span class="font_colorBlue"><%=info.getSum_hit1()%></span></td>
						<td><b><%=info.getSum_hit2()%></b></td>
						<td><b><%=info.getSum_hit3()%></b></td>
					</tr>
						<%
					}
					%>
					<tr>
						<td><span class="font_size12">합계</span></td>
						<td class="left_border">&nbsp;</td>
						<td><span class="font_colorBlue"><%=today_contact_count1%></span></td>
						<td><b><%=month_contact_count2%></b></td>
						<td><b><%=total_contact_count3%></b></td>
					</tr>
				</tbody>
				</table>
				
				<br/><br/>
				<table width="100%">
				<tr>
				<%
					String strLink = "";
				%>
				<td align="right"></br>&nbsp;&nbsp;<a href="javascript:ExcelDown();"><img src="/vodman/include/images/but_excel.gif" alt="Excel받기" border="0"></a></td>
				</tr>
				</table>
				</br></br>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>