<%@ page language="java" contentType="application/vnd.ms-excel; name='excel', text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
       <head><meta http-equiv="Content-Type" content="text/html; charset=euc-kr" /></head>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
response.setHeader("Content-Disposition", "attachment; filename=excel.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
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
	
	String today = Integer.toString(year)+Integer.toString(month)+Integer.toString(date);
	
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
	String dt = request.getParameter("cdate").replaceAll("<","").replaceAll(">","");
%>

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
</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메뉴접속통계종합</span> 보기</h3>
			<div id="content">
			<form name='frmpop' method='post' >
				<!-- 내용 -->
				<h4>날짜  <%=dt%></h4>
			</form>
				<table cellspacing="0" class="connection_list" summary="메뉴접속통계-종합">
				<thead>
					<tr>
						<th width="40%">웹 통계</th>
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
				</table>
				
				</br></br>
				<table cellspacing="0" class="connection_list" >
				<thead>
					<tr>
						<th width="40%">모바일 통계</th>
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
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
</html>