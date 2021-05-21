<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
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
<jsp:useBean id="oinfo" class="com.vodcaster.sqlbean.WebLogInfo" scope="page" />

<%
  
WebLogManager mgr = com.vodcaster.sqlbean.WebLogManager.getInstance();
 
Hashtable result_ht = null;

String rstime="";
if (request.getParameter("rstime") != null && request.getParameter("rstime").length() > 0) {
	rstime =request.getParameter("rstime").replaceAll("<","").replaceAll(">","");
}
String retime="";
if (request.getParameter("retime") != null && request.getParameter("retime").length() > 0) {
	retime =request.getParameter("retime").replaceAll("<","").replaceAll(">","");
}
String browser="";
 String method="";
 String ip="";
 String referer="";
 String uri="";
 String sessionID="";
 int pg =1;
 int limit =20; 

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
			<h3><span>웹로그</span> 보기</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>웹로그 현황</span></p>
			<div id="content">
			<form name="listForm" method="post" action="mng_web_log.jsp">
				<input type="hidden" value="<%=mcode %>" name="mcode" />
				<!-- 내용 -->
				 
				<br/>
				<div class="to_but">
<%

 
String cpage = "";
if (request.getParameter("page") != null && request.getParameter("page").length() > 0) {
	cpage = request.getParameter("page").replaceAll("<","").replaceAll(">","");
}

if(cpage == null || cpage.equals("")) {
    pg = 1;
}else {
	try{
		pg = Integer.parseInt(cpage);
	}catch(Exception e){
		pg = 0;
	}
    
}


result_ht = mgr.getWebLog( rstime, retime, browser,  method,  ip,  referer,  uri,  sessionID,  pg,  limit );

Vector vt = null;
com.yundara.util.PageBean pageBean = null;
int iTotalPage = 0;
int iTotalRecord = 0;
if(result_ht != null && !result_ht.isEmpty() && result_ht.size() > 0){
	vt = (Vector)result_ht.get("LIST");
	if(vt != null && vt.size()>0){
		pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		iTotalRecord = pageBean.getTotalRecord();
		iTotalPage = pageBean.getTotalPage();

	}
}
 

String strLink = "rstime="+rstime+"&retime="+retime+"&browser=" +browser+ "&method=" +method+ "&ip="+ip+"&referer="+referer+"&sessionID="+sessionID+"&pg="+pg;
%>					
				 
				</div>
				
				<table cellspacing="0" class="log_list" summary="웹 로그 날짜선택">
				<caption>날짜선택</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th class="bor_bottom01">날짜선택</th>
						<td class="bor_bottom01 pa_left">
							시작일 : <input type="text" name="rstime" value="<%=rstime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.rstime)" title="새창연결"> <img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a> 
							~
							종료일 : <input type="text" name="retime" value="<%=retime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.retime)" title="새창연결"> <img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
							<input type="image" src="/vodman/include/images/but_search.gif" alt="검색"/>
							<a href='proc_excel_web_log.jsp?<%=strLink%>'><img src="/vodman/include/images/but_excel.gif" alt="엑셀받기"/></a>
						</td>
					</tr>
				</tbody>
				</table>
				<br/>
				<p class="to_page"><p class="to_page">Total<b><%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>Page<b><%=vt != null && vt.size()>0?pageBean.getCurrentPage():0%>/<%=vt != null && vt.size()>0?pageBean.getTotalPage():0%></b></p>
				<table cellspacing="0" class="board_list" summary="동영상 시청로그">
				<caption>웹로그</caption>
				<colgroup>
					<col width="13%"/>
					<col width="13%"/>
					<col width="8%"/>
					<col width="30%"/>
					<col width="36%"/>
				</colgroup>
				<thead> 
				
					<tr>
						<th>번호</th>
						<th>IP</th>
						<th>일자</th>
						<th>접속페이지</th>
						<th>이전페이지 주소</th>
					</tr>
				
				</thead>
				<tbody>
 <%
 int list = 0;
	if ( vt != null && vt.size() > 0){
		
		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++)
		{
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)vt.elementAt(list));
%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="bor_bottom01"><%=oinfo.getLog_ip()%></td>
						<td class="bor_bottom01"><%=oinfo.getLog_date()%></td>
						
						<td class="bor_bottom01"><%=oinfo.getLog_uri()%></td>
						<td class="bor_bottom01"><%=oinfo.getLog_referer()%></td>
						 
					</tr>
					
 
<%
 
		}
	}else{
		%><tr class="height_25 font_127">
			<td colspan=''>등록된 정보가 없습니다.</td>
		</tr>
		<%
	}
%>	
				</tbody>
			</table>
			<%
			if (vt != null && vt.size() > 0) {
			strLink = strLink + "&mcode="+mcode;
			String jspName = "mng_web_log.jsp";%>
			<%@ include file="pop_page_link.jsp" %>
			<%} %>
			<br/><br/>
			</form>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>