<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>

<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
String rstime="";
if (request.getParameter("rstime") != null && request.getParameter("rstime").length() > 0) {
	rstime =request.getParameter("rstime").replaceAll("<","").replaceAll(">","");
}
String retime="";
if (request.getParameter("retime") != null && request.getParameter("retime").length() > 0) {
	retime =request.getParameter("retime").replaceAll("<","").replaceAll(">","");
}
 
MediaManager mgr = MediaManager.getInstance();
 
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language='javascript'>


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

<%@ include file="/vodman/site/site_left.jsp"%>

		<div id="contents">
			<h3><span>분류별 건수</span> 보기</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>분류별 건수 보기</span></p>
			<div id="content">
				<!-- 내용 -->
				 <table cellspacing="0" class="log_list" summary="웹 로그 날짜선택">
				<caption>날짜선택</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
				<form name="listForm" method="post" action="mng_cate_stat.jsp">
				<input type="hidden" value="<%=mcode %>" name="mcode" />
					<tr>
						<th class="bor_bottom01">날짜선택</th>
						<td class="bor_bottom01 pa_left">
							시작일 : <input type="text" name="rstime" value="<%=rstime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.rstime)" title="새창연결"> <img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a> 
							~
							종료일 : <input type="text" name="retime" value="<%=retime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.retime)" title="새창연결"> <img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
							<input type="image" src="/vodman/include/images/but_search.gif" alt="검색"/>
						 
						</td>
					</tr>
				</form>
				</tbody>
				</table>
				<br/>
				<div class="to_but">
<%

	//int total_count = mgr.getTotalhit("","N");  // 카테고리, 삭제 플레그
	//int total_vcount = mgr.getTotalvod("","N");  // 카테고리, 삭제 플레그
	int total_vcount = mgr.getTotalvod_date("","N", rstime, retime);  // 카테고리, 삭제 플레그

	Vector cvt = mgr.getTotalvod_date_all(rstime,retime);

%>					<p class="to_page">Total<b> 영상 : <%= total_vcount%>건</b></p>
					<p class="align_right02 height_25"></p>
				</div>
				<table cellspacing="0" class="board_list" summary="동영상 시청로그">
				<caption>시청건수</caption>
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
			
					<tr>
						<th>분류명</th>
						<th>분류 코드</th>
						<th> </th>
						<th>영상건수</th>
						<th>시청건수</th>
					</tr>
				</thead>
				<tbody>
 <%
				try{		
					if(cvt != null && cvt.size()>0 ){
						String ctitle = "";
						String ccode = "";
						String cnt = "";
						String hit = "";
						for(int i = 0; i < cvt.size(); i++) {
							ctitle = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(0));
							ccode = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(1));
							cnt = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(2));
							hit = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(3));
							
							if (!ccode.endsWith("000000000")) {
%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01" align="left">&nbsp;<%=ctitle%></td>
						<td class="bor_bottom01"><%=ccode%></td>
						<td class="bor_bottom01"> </td>
						<td class="bor_bottom01"><%=cnt%></td>
						<td class="bor_bottom01"><%=hit%></td>
					</tr>
<%
							}
								}
							}
  
		}catch(Exception e) {System.out.println("분류별 시청 통계 에러:"+e);}
	
%>
				</tbody>
			</table>
			 
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>