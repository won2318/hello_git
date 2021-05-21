<%@ page language="java"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ page
	import="java.sql.*,java.util.*,java.util.Vector,com.vodcaster.sqlbean.*,com.yundara.util.*,com.vodcaster.utils.TextUtil"%>

<jsp:useBean id="charSet" class="com.yundara.util.CharacterSet" />
<jsp:useBean id="skinContent" class="com.vodcaster.sqlbean.SkinManager" />
<jsp:useBean id="questionBean" class="com.vodcaster.sqlbean.QuestionSqlBean" />
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_content")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다.');\n" +
                "self.close();\n" +
                "</script>");
    return;
}
%>
<%-- jstl --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	/**
	 * @author 박종성
	 *
	 * @description : 설문 결과 보기
	 * date : 2009-10-19
	 */

	String proc = request.getParameter("proc");
	int quest_id = 0;
	int item_no = 0;

	if(request.getParameter("quest_id") != null && request.getParameter("quest_id").length() > 0) {
		try{
			quest_id = Integer.parseInt(request.getParameter("quest_id"));
		}catch(Exception e){
			quest_id = 0;
		}
	}
	
	if(request.getParameter("item_no") != null && request.getParameter("item_no").length() > 0) {
		
		try{
			item_no = Integer.parseInt(request.getParameter("item_no"));
		}catch(Exception e){
			item_no = 0;
		}
	}

	
	if (proc == null)
		proc = "";
	else if (proc.equals("updateCount")) {
		try {
			questionBean.updateQuestionItem(quest_id, item_no);
		} catch (Exception e) {
			System.out.println("2---------------->" + e);
		}
	}

	/*----------------------------------
	 *투표하기 정보
	 *----------------------------------*/

	Vector v_question = null;
	String question = "";

	try {
		v_question = questionBean.getQuestion(quest_id);
		question = String.valueOf(v_question.elementAt(1));
	} catch (Exception e) {
	}

	Vector v_ques_item = null;
	Vector v_ques_item_column = null;
	if (v_question != null && v_question.size() > 0)
		v_ques_item = questionBean.getQuestionItem(quest_id);
	

	int total = 0;// 총계

	for (int i = 0; v_ques_item != null && i < v_ques_item.size(); i++) {
		v_ques_item_column = (Vector) (v_ques_item.elementAt(i));
		total += Integer.parseInt(String.valueOf(v_ques_item_column.elementAt(3)));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<title>관리자페이지</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
		<script language=JavaScript src="/vodman/include/js/resizewin.js"></script>

<script language="JavaScript">
<!-- 
	function resizeFrame(iframeObj){
	  var innerBody = iframeObj.document.body;
	  
	  var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
	  var innerWidth = innerBody.scrollWidth + (innerBody.offsetWidth - innerBody.clientWidth);
	  
//	alert(innerHeight);
//	alert(innerWidth);
	  restage = new resizeWin(innerWidth+5,innerHeight+30);
	  restage.onResize();

	}
//-->
</script>
	</head>
<body onload="resizeFrame(this)">
<div id="research">
	<h3><img src="/vodman/include/images/a_research_title.gif" alt="결과보기"/></h3>
	<div id="research_top"></div>
	<div id="research_cen">
		<div style="word-break:break-all;width:500px"><h3><%=question%></h3></div><br/>
		<div id="reserch_con">
			<table cellspacing="0" class="reserch" summary="결과보기">
				<caption>결과보기</caption>
				<colgroup>
					<col width="5%"/>
					<col/>
					<col width="16%"/>
				</colgroup>
				<tbody class="font_127">
<%
	if (v_ques_item != null && v_ques_item.size() >= 1) {
		for (int i = 0; v_ques_item != null && i < v_ques_item.size(); i++) {// 그래프를 출력합니다.
			v_ques_item_column = (Vector) (v_ques_item.elementAt(i));
			int result_cnt = 0;
			result_cnt = Integer.parseInt(String.valueOf(v_ques_item_column.elementAt(3)));
%>
					<tr class="height_25">
						<th><%=(i+1)%>)</th>
						<td colspan="2" style="word-break:break-all;width:500px"><%=String.valueOf(v_ques_item_column.elementAt(2))%></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01">&nbsp;</th>
						<td class="bor_bottom01"><img src="/vodman/include/images/a_research_bar.gif" alt="1번결과그래프" width="<%= Math.round( (result_cnt / (double)total )*100) %>%" height="8" /></td>
						<td class="bor_bottom01">(<%=result_cnt%>명, <%=Math.round((result_cnt / (double) total) * 100)%>%)</td>
					</tr>
<%
		}
	}
%>
				</tbody>
			</table>
		</div>
	</div>
	<div id="research_bot"></div>
	<div class="but01">
		<a href="javascript:window.close();" title="닫기"><img src="/vodman/include/images/but_close.gif" alt="닫기"/></a>
	</div>	
</div>
</body>
</html>