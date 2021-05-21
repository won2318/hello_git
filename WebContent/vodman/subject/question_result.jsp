<%@ page language="java"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ page
	import="java.sql.*,java.util.*,java.util.Vector,com.vodcaster.sqlbean.*,com.yundara.util.*,com.vodcaster.utils.TextUtil"%>

<jsp:useBean id="charSet" class="com.yundara.util.CharacterSet" />
<jsp:useBean id="questionBean" class="com.vodcaster.sqlbean.QuestionSqlBean" />

<%
	

	String proc = request.getParameter("proc");
	int quest_id = 0;
	int item_no = 0;

	try {
		quest_id = Integer.parseInt(request.getParameter("quest_id"));
		item_no = Integer.parseInt(request.getParameter("item_no"));
	} catch (Exception e) {
		System.out.println("1---------------->" + e);
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
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>경남평생학습 포털사이트</title>
<link href="../../com/css/total_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../com/js/navigation.js"></script>
<script type="text/javascript" src="../../com/js/active.js"></script>
<style type="text/css">
	body {background-color: #226ac7!important; background:none;overflow-y:scroll;}
</style>
</head>
<body>
	<!--655-->
		<div class="pfirst">
			<p class="result">참여자수:<span class="brown2"><%=total%>명</span></p>
		</div>
			<div class="poll">
				<h2 class="bu4">결과보기</h2>

				<h3>1. 온라인 설문조사를 실시합니다. </h3>
				<span class='poll04'></span>
				<dl>
					<%
					if (v_ques_item != null && v_ques_item.size() >= 1) {
						for (int i = 0; v_ques_item != null && i < v_ques_item.size(); i++) {// 그래프를 출력합니다.
							v_ques_item_column = (Vector) (v_ques_item.elementAt(i));
							int result_cnt = 0;
							result_cnt = Integer.parseInt(String.valueOf(v_ques_item_column.elementAt(3)));
					%>
				
					<dt><%=(i+1)%>) <%=String.valueOf(v_ques_item_column.elementAt(2))%></dt>
					<dd><div><span style="width:<%= Math.round( (result_cnt / (double)total )*100) %>%;"></span></div> (<%=result_cnt%>명 / <strong><%= Math.round( (result_cnt / (double)total )*100) %>%</strong>)</dd>
					<%
							}
						}
					%>
				</dl>
				<p class="poline mb10"></p>
				
				  <p class="tc mt5">
					  <a href="javascript:self.close();"><img src="../../images/common/btn_close2.gif" alt="닫기" /></a>	
				  </p>
			</div>
	   <div class="pend"></div>
</body>
</html>