<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
<%@ page import="com.yundara.util.*"%>

<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean"
	scope="page" />
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean"
	scope="page" />
<jsp:useBean id="bliBean"
	class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />

<%@ include file="/include/chkLogin.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");

	java.util.Date day = new java.util.Date();
	SimpleDateFormat today_sdf = new SimpleDateFormat("yyyy");
	String this_year = today_sdf.format(day);

	SimpleDateFormat today_check = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm");
	String today_string = today_check.format(day);

	MediaManager mgr = MediaManager.getInstance();
	Hashtable result_ht = null;

	String ccode = "";
	if (request.getParameter("ccode") != null
			&& request.getParameter("ccode").length() > 0
			&& !request.getParameter("ccode").equals("null")) {
		ccode = com.vodcaster.utils.TextUtil.getValue(request
				.getParameter("ccode"));
	}

	int board_id = NumberUtils.toInt(request.getParameter("board_id"),
			0);

	String year = this_year;
	if (request.getParameter("year") != null
			&& request.getParameter("year").length() > 0
			&& !request.getParameter("year").equals("null")) {
		year = com.vodcaster.utils.TextUtil.getValue(request
				.getParameter("year"));
	}

	LiveManager Lmgr = LiveManager.getInstance();
	Vector vt = Lmgr.getLive_ListAll_out("L", year);
	com.hrlee.sqlbean.LiveInfoBean linfo = new com.hrlee.sqlbean.LiveInfoBean();
%>
<%@ include file="../include/html_head.jsp"%>
<script language="JavaScript" type="text/JavaScript">
	function pre(year) {
		var this_value = parseInt(year) - 1;
		location.href = "live_list.jsp?year=" + this_value;
	}

	function next(year) {
		var this_value = parseInt(year) + 1;

		location.href = "live_list.jsp?year=" + this_value;
	}
</script>
<!-- //header -->
<div id="snb">
	<%@ include file="../include/top_sub_menu.jsp"%>

</div>

<!-- container::메인컨텐츠 -->
<!-- containerS::서브컨텐츠 -->
<div id="containerS">
	<div id="content">
		<div class="sectionS">
			<div class="year">
				<a href="javascript:pre('<%=year%>');"><img
					src="../include/images/btn_back_year.gif" alt="이전 년도" /></a> <span><%=year%></span>
				<a href="javascript:next('<%=year%>');"><img
					src="../include/images/btn_next_year.gif" alt="다음 년도" /></a>
			</div>
			<table class="schedule" cellspacing="0"
				summary="생방송일정으로 방송일, 방송시간, 방송제목, 다시보기를 제공합니다.">
				<caption>생방송일정</caption>
				<colgroup>
					<col width="13%" />
					<col width="13%" />
					<col width="16%" />
					<col width="*" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" colspan="2" abbr="방송일">방송일</th>
						<th scope="col" abbr="시간">시간</th>
						<th scope="col" abbr="방송제목">방송제목</th>
						<th scope="col" abbr="다시보기">다시보기</th>
					</tr>
				</thead>
				<tbody>
					<%
						if (vt != null && vt.size() > 0) {
							try {
								String temp_month2 = "temp";
								boolean check_month = true;
								for (int i = 0; i < vt.size(); i++) {

									Hashtable ht_list = (Hashtable) vt.get(i);
									com.yundara.beans.BeanUtils.fill(linfo, ht_list);
									String temp_year = "";
									String temp_month = "";
									String temp_day = "";
									String temp_time = "";

									if (linfo.getRstart_time() != null) {
										temp_year = linfo.getRstart_time().substring(0, 4);
										temp_month = linfo.getRstart_time().substring(5, 7);
										temp_day = linfo.getRstart_time().substring(8, 10);
										temp_time = linfo.getRstart_time().substring(11);

									}

									long s_date = Long.parseLong(linfo.getRstart_time()
											.replaceAll("-", "").replaceAll(":", "")
											.replaceAll(" ", "").trim());
									long e_date = Long.parseLong(linfo.getRend_time()
											.replaceAll("-", "").replaceAll(":", "")
											.replaceAll(" ", "").trim());
									long this_date = Long.parseLong(today_string
											.replaceAll("-", "").replaceAll(":", "")
											.replaceAll(" ", "").trim());
									if (!linfo.getRstart_time().contains(temp_month2)) {
										temp_month2 = linfo.getRstart_time()
												.substring(0, 7);
										check_month = true;

									} else {
										check_month = false;
									}

									if (check_month) {
										if (i != 0) {
					%>
					</td>
					</tr>
					<%
						}
					%>
					<tr>
						<th scope="row" abbr="월"><%=temp_month%><span>월</span></th>
						<td colspan="4" abbr="일, 시간, 방송제목, 다시보기">
							<%
								}
							%>

							<dl>
								<dt><%=temp_day%></dt>
								<dd>
									<span class="time"><%=temp_time%></span> <span class="title"><%=linfo.getRtitle()%>
									</span> <span class="replay"> <%
 	if (s_date <= this_date && this_date <= e_date) {
 					out.print("<a href='javascript:live_open()'><img src='../include/images/icon_onair.gif' alt='ON-AIR'/></a>");
 				}
 %>
										<%
											if (linfo.getOcode() != null
																&& linfo.getOcode().length() > 0) {
										%>
										<a class="view_page"
										href="../video/video_player.jsp?ocode=<%=linfo.getOcode()%>"><img
											src="../include/images/icon_tv1.gif" alt="1" /></a> <%
 	}
 				if (linfo.getOcode2() != null
 						&& linfo.getOcode2().length() > 0) {
 %>
										<a class="view_page"
										href="../video/video_player.jsp?ocode=<%=linfo.getOcode2()%>"><img
											src="../include/images/icon_tv2.gif" alt="2" /></a> <%
 	}
 				if (linfo.getOcode3() != null
 						&& linfo.getOcode3().length() > 0) {
 %>
										<a class="view_page"
										href="../video/video_player.jsp?ocode=<%=linfo.getOcode3()%>"><img
											src="../include/images/icon_tv3.gif" alt="3" /></a> <%
 	}
 %>
									</span>
								</dd>
							</dl> <%
 	}

 		} catch (Exception e) {
 			out.println("생방송 정보를 읽어 오는중 오류가 발생하였습니다. 관리자에게 문의 하세요" + e);
 		}
 	}
 %>

						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<%@ include file="../include/right_menu.jsp"%>

</div>

<!-- footer -->
<%@ include file="../include/html_foot.jsp"%>