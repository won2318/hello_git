<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
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
		flag = request.getParameter("flag");
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
	

	//int today_ip_count=0;		//오늘 접속자 수
	int today_contact_count=0;	//오늘 카운트 수
	//int month_ip_count=0;		//이달 접속자 수
	int month_contact_count=0;	//이달 카운트 수
	//int total_ip_count=0;		//전체 접속자 수
	int total_contact_count=0;	//전체 카운트 수


%>

<%@ include file="/vodman/include/top.jsp"%>
<script>
	function go_month_view(month){
		window.open('stat_month.jsp?year_month='+month, '', 'width=650,height=700,toolbar=no,statusbar=no,resize=yes');
	}
</script>
<%@ include file="/vodman/site/site_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메뉴접속통계</span> 보기</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>메뉴접속통계 보기</span></p>
			<div id="content">
			
			
				<div id="content">
				<!-- 내용 -->
					<ul class="s_tab01_bg">
					<li><a href="mng_stat_menu.jsp?mcode=<%=mcode%>&flag=W" title="Web" <%if(flag.equals("W")){out.println("class='visible'");}%>>Web</a></li>
					<li><a href="mng_stat_menu.jsp?mcode=<%=mcode%>&flag=M" title="Mobile" <%if(flag.equals("M")){out.println("class='visible'");}%>>Mobile</a></li>
				</ul><br><br>
				
					<!-- 내용 -->
					<ul class="s_tab01_bg">
					<%
					MenuManager mgr = MenuManager.getInstance();
					Vector vt = mgr.getMenuListALL2("A");
					MenuInfoBean info = new MenuInfoBean();
					for(Enumeration e = vt.elements(); e.hasMoreElements();) {
						com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
					%>
					<li><a href="mng_stat_menu.jsp?mcode=<%=mcode%>&flag=<%=flag%>&muid=<%=info.getMuid()%>" title="<%=info.getMtitle()%>" <%if(muid == info.getMuid()){out.println("class='visible'");}%>><%=info.getMtitle()%></a></li>
					<%
					}
					%>
				</ul><br><br>
			
			
				<!-- 내용 -->
				<h4>오늘 : <%=year%>년 <%=month%>월 <%=date%>일</h4>
				<table cellspacing="0" class="connection_list" summary="메뉴접속통계">
				<caption>메뉴접속통계목록</caption>
				<colgroup>
					<col width="20%"/>
					<col/>
					<col width="24%" span="3"/>
				</colgroup>
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>오늘</th>
						<th>이달</th>
						<th>총합</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><span class="font_size12">메뉴접속통계</span></td>
						<td class="left_border">방문횟수</td>
						<td><span class="font_colorBlue"><%=today_contact_count%></span></td>
						<td><b><%=month_contact_count%></b></td>
						<td><b><%=total_contact_count%></b></td>
					</tr>
				</tbody>
				</table>
				
				<br/><br/>

				<br/><br/>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>