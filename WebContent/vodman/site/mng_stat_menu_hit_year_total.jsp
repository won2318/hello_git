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
	
	String flag2 = "Y";
	if(request.getParameter("flag2") != null && request.getParameter("flag2").length() > 0)
		flag2 = request.getParameter("flag2");
	
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
	
	Vector row=null;
	Vector col=null;
	
	String ydate = "";
	
	try{	
		if(request.getParameter("ydate") != null && request.getParameter("ydate").length() > 0){
			ydate = request.getParameter("ydate");
		}
	}catch(Exception e){
		ydate = null;
	}
	
	String mdate1 = request.getParameter("mdate");
	int mdate =0;
	//out.print("::"+mdate+"::");
	if (request.getParameter("mdate") != null && request.getParameter("mdate").length() > 0){
		mdate= Integer.parseInt(request.getParameter("mdate").trim());
	}
	
	
	String today = "";
	if(request.getParameter("ydate") == null){	
		today = Integer.toString(year)+Integer.toString(month);
	}else{
		if(mdate <= 9){
			mdate1 = "0"+mdate;
		}
		today = ydate+mdate1;
	}
	
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
	

	int m = 0;
	int y = year;
	if(request.getParameter("ydate") == null){
		m = month;
	}else{
		m = mdate;
	}
	int d=0;
	switch(m){
	case 1:
	case 3:
	case 5:
	case 7:
	case 8:
	case 10:
	case 12:
	d = 31;
	break;
	case 4:
	case 6:
	case 9:
	case 11:
	d=30;
	break;
	case 2:
		if(((y%4==0)&&!(y%100==0))||(y%400==0))
			d=29;		
		else
			d = 28;
		
	break;
	}
	
	//Calendar now = Calendar.getInstance();
	//int d = now.getActualMaximum(Calendar.DAY_OF_MONTH);
	
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
	
	
	function Search(){
		location.href='mng_stat_menu_hit_year_total.jsp?mcode=<%=mcode%>&ydate='+document.frmpop.ytime.value+'&flag2=Y&flag=<%=flag%>';
	}
	
	function ExcelDown(){
		location.href='mng_stat_menu_hit_year_total_excel2.jsp?mcode=<%=mcode%>&ydate='+document.frmpop.ytime.value+'&chk_gb='+document.frmpop.chk_gb.value+'&flag=<%=flag%>';;
	}
</script>
<%@ include file="/vodman/site/site_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>시청통계</span></h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>시청통계</span></p>
			<div id="content">
			
			
				<!-- 내용 -->
				<ul class="s_tab01_bg">
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=WV" title="Today" <%if(flag.equals("WV")){out.println("class='visible'");}%>>웹 VOD통계</a></li>
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=WL" title="Month" <%if(flag.equals("WL")){out.println("class='visible'");}%>>웹 LIVE통계</a></li>
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=MV" title="Year" <%if(flag.equals("MV")){out.println("class='visible'");}%>>모바일 VOD통계</a></li>
				<li><a href="mng_stat_menu_hit_total.jsp?mcode=<%=mcode%>&flag=ML" title="Year" <%if(flag.equals("ML")){out.println("class='visible'");}%>>모바일 LIVE통계</a></li>
				</ul>
				<br><br>
			</br>
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
				<%
				if(ydate==null){
				%>
				<select  name="ytime" class="sec01" style="width:60px;">
					<option value="2012" <%if(year==2012){out.println("selected='selected'");}%>>2012</option>
					<option value="2013" <%if(year==2013){out.println("selected='selected'");}%>>2013</option>
					<option value="2014" <%if(year==2014){out.println("selected='selected'");}%>>2014</option>
					<option value="2015" <%if(year==2015){out.println("selected='selected'");}%>>2015</option>
					<option value="2016" <%if(year==2016){out.println("selected='selected'");}%>>2016</option>
					<option value="2017" <%if(year==2017){out.println("selected='selected'");}%>>2017</option>
					<option value="2018" <%if(year==2018){out.println("selected='selected'");}%>>2018</option>
					<option value="2019" <%if(year==2019){out.println("selected='selected'");}%>>2019</option>
					<option value="2020" <%if(year==2020){out.println("selected='selected'");}%>>2020</option>
				</select> 년
				<%}else{%> 				
				<select  name="ytime" class="sec01" style="width:60px;">
					<option value="2012" <%if(ydate.equals("2012")){out.println("selected='selected'");}%>>2012</option>
					<option value="2013" <%if(ydate.equals("2013")){out.println("selected='selected'");}%>>2013</option>
					<option value="2014" <%if(ydate.equals("2014")){out.println("selected='selected'");}%>>2014</option>
					<option value="2015" <%if(ydate.equals("2015")){out.println("selected='selected'");}%>>2015</option>
					<option value="2016" <%if(ydate.equals("2016")){out.println("selected='selected'");}%>>2016</option>
					<option value="2017" <%if(ydate.equals("2017")){out.println("selected='selected'");}%>>2017</option>
					<option value="2018" <%if(ydate.equals("2018")){out.println("selected='selected'");}%>>2018</option>
					<option value="2019" <%if(ydate.equals("2019")){out.println("selected='selected'");}%>>2019</option>
					<option value="2020" <%if(ydate.equals("2020")){out.println("selected='selected'");}%>>2020</option>
				</select> 년
				<%} %>							
				&nbsp;&nbsp;<a href="javascript:Search();"><img src="/vodman/include/images/but_search.gif" alt="검색" border="0"></a>
				</h4>
			
				</span>
			</div>
				<table cellspacing="0" class="connection_list" summary="메뉴접속통계-종합">
				<caption>메뉴접속통계종합</caption>
						<thead>
							<tr>
							<th>웹 통계</th>
							<th></th>
							<%
							for(int i=0; i<12; i++){
							%>
							<th width="50px"><%=i+1%></th>						
							<%} %>						
							<th width="30px">합계</th>
							</tr>
						</thead>
						<tbody>
						<%
						try{
						//메뉴 타이틀 and Size 뽑기
						MenuManager mgr = MenuManager.getInstance();
						MenuManager2 mgr2 = MenuManager2.getInstance();
						Vector vt;
						Vector vt1;
						int[] Websum = new int [12];
						int[] Mosum = new int [12];
						
						String chk_gb = "";
						
						if(flag.equals("WV")){
							chk_gb = "V";
							
						}else if(flag.equals("WL")){
							chk_gb = "L";
						}else if(flag.equals("MV")){
							chk_gb = "V";
						}else if(flag.equals("ML")){
							chk_gb = "M";
						}else{
							chk_gb = "";
						}
						
						vt= (Vector)mgr2.getSelectMenu(chk_gb);
						vt1= (Vector)mgr2.getSelectYCount(today, flag, chk_gb);
						if(vt != null && vt.size()>0){						
						MenuInfoBean info = new MenuInfoBean();
						String[] month_count = new String [12];
						for(Enumeration e = vt.elements(); e.hasMoreElements();) {
							com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());																	
						%>
						<tr>
						<td class="font_size12"><%=info.getCtitle() %></td>
						<td class="left_border">&nbsp;</td>
							<%
							int x = 1;
							String gubun = info.getCcode();
							
							String gubun2 = "0";
							int gubun3 = 0;
							int cnt = 0;
							int csum = 0;
							String td = "";														
							MenuInfoBean info1 = new MenuInfoBean();
									for(int g=0; g<12; g++){
										month_count[g] = "<td><b>0</b></td>";										
										for(Enumeration e1 = vt1.elements();e1.hasMoreElements();){
											com.yundara.beans.BeanUtils.fill(info1, (Hashtable)e1.nextElement());
											
											gubun2 = info1.getCcode();
											gubun3 = info1.getDay();
											if(gubun.equals(gubun2)&& gubun3==g+1){
												month_count[g] = "<td>"+"<span class='font_colorBlue'>"+info1.getCnt()+"</span></td>";
												Websum[g] += info1.getCnt();
												csum += info1.getCnt();
											}
										}
										
							%>
							<%=month_count[g] %>
							<%
									}
							%>
							<td><span class='font_colorBlue'><%=csum %></span></td>
						</tr>
						<%
						}
						%>
						<tr>
						<input type="hidden" name="chk_gb" value="<%=chk_gb%>" />
						<td>합계</td>						
						<td class="left_border"></td>
						<%
							int Totalsum = 0;
							for(int v=0; v<12; v++){
							Totalsum += Websum[v];  
						%>
						<td><span class='font_colorBlue'><%=Websum[v] %></span></td>
						<%
							}
						%>
						<td><span class='font_colorBlue'><%=Totalsum %></span></td>
						</tr>
						<%
						}else{%>
						<tr>
						<td colspan="<%=d+3%>">검색된 결과가 없습니다.</td>
						</tr>
						<%
							}
						}catch(Exception ex){
							System.err.println(" mng_stat_menu_year_total.jsp error = "+ex);
						}						
						%>							
					</tbody>
				</tbody>
				</table>
				<table width="100%">
				<tr>
				<td align="right"></br>&nbsp;&nbsp;<a href="javascript:ExcelDown();"><img src="/vodman/include/images/but_excel.gif" alt="Excel받기" border="0"></a></td>
				</tr>
				</table>
				</br></br>
				</form>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>