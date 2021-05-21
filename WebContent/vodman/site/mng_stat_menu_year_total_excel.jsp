<%@ page language="java" contentType="application/vnd.ms-excel; name='excel', text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
       <head><meta http-equiv="Content-Type" content="text/html; charset=euc-kr" /></head>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
response.setHeader("Content-Disposition", "attachment; filename=excel.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
%>
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
	
	Vector row=null;
	Vector col=null;
	
	String ydate = request.getParameter("ydate").replaceAll("<","").replaceAll(">","");
	String mdate1 = "";
	int mdate =0;
	
	
	String today = "";
	if(request.getParameter("ydate") == null){	
		today = Integer.toString(year);
	}else{
		today = ydate;
	}
	

	//int today_ip_count=0;		//오늘 접속자 수
	int today_contact_count=0;	//오늘 카운트 수
	//int month_ip_count=0;		//이달 접속자 수
	int month_contact_count=0;	//이달 카운트 수
	//int total_ip_count=0;		//전체 접속자 수
	int total_contact_count=0;	//전체 카운트 수
	
	
	int today_contact_count1=0;	//오늘 카운트 수
	int month_contact_count2=0;	//이달 카운트 수
	int total_contact_count3=0;	//전체 카운트 수
	
%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>
<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메뉴접속통계종합</span> 보기</h3>			
			<div id="content">
			
			
				<!-- 내용 -->
				
<!-- 					<ul class="s_tab01_bg"> -->
<%-- 					<li><a href="mng_stat_menu.jsp?mcode=<%=mcode%>&flag=W" title="Web" <%if(flag.equals("W")){out.println("class='visible'");}%>>Web</a></li> --%>
<%-- 					<li><a href="mng_stat_menu.jsp?mcode=<%=mcode%>&flag=M" title="Mobile" <%if(flag.equals("M")){out.println("class='visible'");}%>>Mobile</a></li> --%>
<!-- 				</ul><br><br> -->
				
			<form name='frmpop' >
				<!-- 내용 -->
				<h4>날짜  
				<%
				if(ydate==null){
				%>
				<%=year%>
				<%}else{%> 				
				<%=ydate%>
				<%} %>											
				</h4>
			</form>
				<table cellspacing="0" class="connection_list" summary="메뉴접속통계-종합">				
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
						//메뉴 타이틀 and Size 뽑기
						MenuManager mgr = MenuManager.getInstance();
						int[] Websum = new int [12];
						int[] Mosum = new int [12];
						Vector vt;
						Vector vt1;
						vt= (Vector)mgr.getMenuListALL3_0(today, "W");
						if(vt.size()!=0){
						MenuInfoBean info = new MenuInfoBean();
						String[] month_count = new String [12];
						for(Enumeration e = vt.elements(); e.hasMoreElements();) {
							com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());																	
						%>
						<tr>
						<td class="font_size12"><%=info.getMtitle() %></td>
						<td class="left_border">&nbsp;</td>
							<%
							int x = 1;
							int gubun = info.getMuid();
							int gubun2 = 0;
							int gubun3 = 0;
							int cnt = 0;
							int csum = 0;
							String td = "";
							vt1= (Vector)mgr.getMenuListALL3_2(today, "W");
							MenuInfoBean info1 = new MenuInfoBean();
									for(int g=0; g<12; g++){
										month_count[g] = "<td><b>0</b></td>";
										for(Enumeration e1 = vt1.elements();e1.hasMoreElements();){
											com.yundara.beans.BeanUtils.fill(info1, (Hashtable)e1.nextElement());
											
											gubun2 = info1.getMuid();
											gubun3 = info1.getDay();
											if(gubun==gubun2&& gubun3==g+1){
												month_count[g] = "<td>"+"<span class='font_colorBlue'>"+info1.getCnt()+"</span></td>";
												csum += info1.getCnt();
												Websum[g] += info1.getCnt();
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
						}else{
						%>	
						<tr>
						<td colspan="15">검색된 결과가 없습니다.</td>
						</tr>
						<%}%>					
					</tbody>
				</table>
				</br></br>
				<table cellspacing="0" class="connection_list" summary="메뉴접속통계-종합">
				<thead>
					<tr>
					<th>모바일 통계</th>
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
					//메뉴 타이틀 and Size 뽑기
					MenuManager mgrM = MenuManager.getInstance();
					Vector vtM;
					Vector vt1M;
					vtM= (Vector)mgrM.getMenuListALL3_0(today, "M");
					if(vtM.size()!=0){
					MenuInfoBean infoM = new MenuInfoBean();
					String[] month_countM = new String [12];
					for(Enumeration eM = vtM.elements(); eM.hasMoreElements();) {
						com.yundara.beans.BeanUtils.fill(infoM, (Hashtable)eM.nextElement());																	
					%>
					<tr>
					<td class="font_size12"><%=infoM.getMtitle() %></td>
					<td class="left_border">&nbsp;</td>
						<%
						int xM = 1;
						int gubunM = infoM.getMuid();
						int gubun2M = 0;
						int gubun3M = 0;
						int cntM = 0;
						int csumM = 0;
						String tdM = "";
						vt1M= (Vector)mgrM.getMenuListALL3_2(today, "M");
						MenuInfoBean info1M = new MenuInfoBean();
								for(int g=0; g<12; g++){
									month_countM[g] = "<td><b>0</b></td>";
									for(Enumeration e1M = vt1M.elements();e1M.hasMoreElements();){
										com.yundara.beans.BeanUtils.fill(info1M, (Hashtable)e1M.nextElement());
										
										gubun2M = info1M.getMuid();
										gubun3M = info1M.getDay();
										if(gubunM==gubun2M&& gubun3M==g+1){
											month_countM[g] = "<td>"+"<span class='font_colorBlue'>"+info1M.getCnt()+"</span></td>";
											csumM += info1M.getCnt();
											Mosum[g] += info1M.getCnt();
										}
									}
									
						%>
						<%=month_countM[g] %>
						<%
								}
						%>
						<td><span class='font_colorBlue'><%=csumM %></span></td>
					</tr>
					<%
					}
					%>
					<tr>
					<td>합계</td>						
					<td class="left_border"></td>
					<%
						int TotalsumM = 0;
						for(int v=0; v<12; v++){
						TotalsumM += Mosum[v];  
					%>
					<td><span class='font_colorBlue'><%=Mosum[v] %></span></td>
					<%
						}
					%>
					<td><span class='font_colorBlue'><%=TotalsumM %></span></td>
					</tr>
					<%
					}else{
					%>
					<tr>
						<td colspan="15">검색된 결과가 없습니다.</td>
					</tr>		
					<%
					}
					%>				
				</tbody>				
				</table>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
</html>