<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
	String flag = "WV";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag");

	Calendar cal = Calendar.getInstance();
	int year  = cal.get(Calendar.YEAR),
	    month = cal.get(Calendar.MONTH)+1,
	    date = cal.get(Calendar.DATE);

	Vector row=null;
	Vector col=null;
	

	int today_count=0;		//오늘 
	int month_count=0;	//이번달
	int year_count=0;		//올해
	int total_count=0;	//전체


 	row=stat.getAllCount_counter(flag);
 	for(int i=0; i<row.size(); i++)
	{
		col=(Vector)row.elementAt(i);
		if(i==0)
		{
			try{
				today_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#10. "+e);today_count=0;}
		}
		else if(i==1)
		{
			try{
				month_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#11. "+e);month_count=0;}
		}
		else if(i==2)
		{
			try{
				year_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#12. "+e);year_count=0;}
		}
		else if(i==3)
		{
			try{
				total_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#13. "+e);total_count=0;}
		} 
	}

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
			<h3><span>시청통계</span> (그래프)</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>시청통계 보기</span></p>
			
				<div id="content">
					<!-- 내용 -->
					<ul class="s_tab01_bg">
					<li><a href="mng_stat_count2.jsp?mcode=<%=mcode%>&flag=WV" title="VOD" <%if(flag.equals("WV")){out.println("class='visible'");}%>>VOD</a></li>
					<li><a href="mng_stat_count2.jsp?mcode=<%=mcode%>&flag=WL" title="Live" <%if(flag.equals("WL")){out.println("class='visible'");}%>>LIVE</a></li>
					<li><a href="mng_stat_count2.jsp?mcode=<%=mcode%>&flag=MV" title="VOD-Mobile" <%if(flag.equals("MV")){out.println("class='visible'");}%>>VOD-Mobile</a></li>
					<li><a href="mng_stat_count2.jsp?mcode=<%=mcode%>&flag=ML" title="Live_Mobile" <%if(flag.equals("ML")){out.println("class='visible'");}%>>LIVE-Mobile</a></li>
				</ul><br><br>
			
				<h4>오늘 : <%=year%>년 <%=month%>월 <%=date%>일</h4>
				<table cellspacing="0" class="connection_list" summary="접속통계 보기 ">
				<caption>시청통계 보기</caption>
				<colgroup>
					<col width="20%"/>
					<col />
					<col width="18%" span="4"/>
				</colgroup>
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>오늘</th>
						<th>이달</th>
						<th>올해</th>
						<th>총합</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><span class="font_size12">시청통계</span></td>
						<td class="left_border">&nbsp;</td>
						<td><span class="font_colorBlue"><%=today_count%></span></td>
						<td><b><%=month_count%></b></td>
						<td><b><%=year_count%></b></td>
						<td><b><%=total_count%></b></td>
					</tr>
				</tbody>
				</table>
				
				<br/><br/>

				<iframe id="week_stat" name="week_stat" src="mng_week_count2.jsp?flag=<%=flag%>" scrolling=no width="795" height='300' marginwidth=0 frameborder=0 framespacing=0 ></iframe>
				
				<br/><br/>

				<iframe id="month_stat" name="month_stat" src="mng_month_count2.jsp?flag=<%=flag%>" scrolling=no width="795" height='320' marginwidth=0 frameborder=0 framespacing=0 ></iframe>

				<br/><br/>

				<iframe id="year_stat" name="year_stat" src="mng_year_count2.jsp?flag=<%=flag%>" scrolling=no width="795" height='300' marginwidth=0 frameborder=0 framespacing=0 ></iframe>
				
				<br/><br/>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>