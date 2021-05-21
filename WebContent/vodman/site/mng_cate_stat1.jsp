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

String ctype = "";
if(request.getParameter("ctype") != null) {
	ctype = String.valueOf(request.getParameter("ctype").replaceAll("<","").replaceAll(">",""));
}else
	ctype = "V";
CategoryManager cmgr = CategoryManager.getInstance();
CategoryInfoBean cinfo = new CategoryInfoBean();
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
				 	<ul class="s_tab01_bg">
					<li><a href="mng_cate_stat.jsp" title="등록통계" class='visible'>등록통계</a></li>
					<li><a href="mng_cate_stat2.jsp" title="시청통계" >시청통계</a></li>
				</ul><br>  
				
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

//	int total_count = mgr.getTotalhit("","N");  // 카테고리, 삭제 플레그
	int total_vcount = mgr.getTotalvod_date("","N", rstime, retime);  // 카테고리, 삭제 플레그

	Vector cvt = cmgr.getCategoryListALL2(ctype,"A");

%>					
					<p class="to_page">Total<b> 영상 : <%= total_vcount%>건</b></p>
					<p class="align_right02 height_25"></p>
				</div>
				<table cellspacing="0" class="board_list" summary="동영상 시청로그">
				<caption>시청건수</caption>
				<colgroup>
					<col width="25%"/>
					<col width="25%"/>
					<col width="25%"/>
					 
					<col width="25%"/>
				</colgroup>
				<thead>
			
					<tr>
						<th>1단계</th>
						<th>2단계</th>
						<th>3단계</th>
 
						<th>영상건수</th>
					</tr>
				</thead>
				<tbody>
 <%
				try{		
						for(Enumeration e = cvt.elements(); e.hasMoreElements();) {
						
							com.yundara.beans.BeanUtils.fill(cinfo, (Hashtable)e.nextElement());
%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=cinfo.getCtitle()%></td>
						<td class="bor_bottom01"> </td>
						<td class="bor_bottom01"> </td>
					 
						<td class="bor_bottom01"><%=mgr.getTotalvod_date(cinfo.getCcode().substring(0,3)+"000000000","N", rstime, retime)%></td>
					</tr>
					
 <%
							Vector cvtB = cmgr.getCategoryListALL2(ctype,"B",cinfo.getCcode());

							for (Enumeration eb = cvtB.elements(); eb.hasMoreElements();){
								com.yundara.beans.BeanUtils.fill(cinfo, (Hashtable)eb.nextElement());
%>

					<tr class="height_25 font_127">
						<td class="bor_bottom01"></td>
						<td class="bor_bottom01"><%=cinfo.getCtitle()%></td>
						<td class="bor_bottom01"> </td>
						 
						<td class="bor_bottom01"><%=mgr.getTotalvod_date(cinfo.getCcode().substring(0,6)+"000000","N", rstime, retime)%></td>
					</tr>
<%

								Vector cvtC = cmgr.getCategoryListALL2(ctype,"C",cinfo.getCcode());
								for (Enumeration ec = cvtC.elements(); ec.hasMoreElements();){
								com.yundara.beans.BeanUtils.fill(cinfo, (Hashtable)ec.nextElement());
%>					
					<tr class="height_25 font_127">
						<td class="bor_bottom01"></td>
						<td class="bor_bottom01"></td>
						<td class="bor_bottom01"><%=cinfo.getCtitle()%></td>
						 
						<td class="bor_bottom01"><%=mgr.getTotalvod_date(cinfo.getCcode().substring(0,9)+"000","N", rstime, retime)%></td>
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