<%@ page language="java"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ page import="java.util.Vector"%>

<jsp:useBean id="textUtil" class="com.vodcaster.utils.TextUtil" />
<jsp:useBean id="charSet" class="com.yundara.util.CharacterSet" />
<jsp:useBean id="quest" class="com.vodcaster.sqlbean.QuestionSqlBean" />
<%
	String vote_title = "시작된 POLL이 없습니다.";
	String vote_list = "";
	int quest_id = 0;
	int item_count = 0;
 	
	if (request.getParameter("quest_id") != null) {
		quest_id = Integer.parseInt(request.getParameter("quest_id"));
	} else {
		out.println("<script language='javascript'>");
		out.println("alert('잘못된 접근입니다');");
		out.println("self.close();");
		out.println("</script>");
	}
 
	try {

		Vector v = quest.getQuestion(quest_id);
//		Vector v = quest.getTodayQuestion();

		if (v != null && v.size() > 0) {
			quest_id = Integer.parseInt(String.valueOf(v.elementAt(0)));
			vote_title = String.valueOf(v.elementAt(1));

			Vector vt = quest.getQuestionItem(quest_id);

			if (vt != null && vt.size() > 0) {

		for (int i = 0; i < vt.size(); i++) {
			Vector v_quest_item_column = (Vector) (vt.elementAt(i));
			String item_s = String.valueOf(v_quest_item_column.elementAt(1));
			String vote_con = String.valueOf(v_quest_item_column.elementAt(2));

			vote_list += "<dt><input type=\"radio\" id=\"a1\" name=\"item_no\" value=\"" + item_s + "\" /> " + vote_con + "</dt><dd></dd>";

			item_count++;
		}

			}

		}

	} catch (Exception e) {
	}

	Vector v_question = null;
	String question = "";

	try {
		v_question = quest.getQuestion(quest_id);
		question = String.valueOf(v_question.elementAt(1));
	} catch (Exception e) {
	}

	Vector v_ques_item = null;
	Vector v_ques_item_column = null;
	if (v_question != null && v_question.size() > 0)
		v_ques_item = quest.getQuestionItem(quest_id);

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
<script language="javascript">
<!--
 

	function getCookie(Name){
	var search = Name + "=";
	if(document.cookie.length > 0 ){
		offset = document.cookie.indexOf(search);
		if( offset != -1){
			offset += search.length;
			end = document.cookie.indexOf(";",offset);
			if( end == -1){
				end = document.cookie.length;
			}
			return unescape(document.cookie.substring(offset, end));
			
		}
	}
}

	function setCookie(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}

	function poll_result(form) {
		window.open('question_result.jsp','','width=730, height=450, scrollbars=yes');
	}


	function question_view(){
		/////////////////////////////
		size = "width=750, height=450, scrollbars=yes";
		/////////////////////////////
		question.proc.value = "";
		window.open("","newWin",size);
		question.submit();
		//window.close(); 
	}

	function item_update(quest_id){
		/////////////////////////////
		size = "width=410, height=350, scrollbars=yes";
		/////////////////////////////
		question.proc.value = "updateCount";
		if(question.item_count.value=="0"){
			alert("의견이 없습니다!");
			return;
		}else if(question.item_count.value=="1"){
			if( !question.item_no.checked ){
				alert("항목을 선택해 주세요.");
				return
			}else{
				window.open("","newWin",size);
				question.submit();
			}
			question.submit();

		}else{
			is_checked = false;
			for(i=0; i<eval(question.item_count.value) ; i++){
				if(question.item_no[i].checked){
					is_checked=true;
					break;
				}
			}

			if(!is_checked){
				alert("항목을 선택해 주세요.");
				return;
			}else{
				setCookie("alert_"+quest_id, "done", 1);
				window.open("","newWin",size);
				question.submit();
				//window.close(); 
			}
		}
	}

	function cookie_check(id){
		 
		if (getCookie("alert_"+id) =="done") {
			alert("이미 설문에 참여 하셨습니다! 창을 닫습니다.");
			window.close(); 
		}
	}
//-->
</script>
</head>
<body class="bn" onload="cookie_check(<%=quest_id%>);">
<form name="question" action="question_result.jsp" target="newWin" method="post">
<input type="hidden" name="quest_id" value="<%=quest_id%>"> <input type="hidden" name="proc">
<input type=hidden name=item_count value="<%=item_count %>">

	<!-- 655*300-->
		<div class="pfirst">
			<p class="result">참여자수:<span class="brown2"><%=total%>명</span></p>
		</div>
			<div class="poll">
				<h2 class="bu4">설문질문</h2>
				<h3><%=vote_title%></h3>
				<span class='poll04'></span>
				<dl>
				<%=vote_list%>
				</dl>
				<p class="poline mb10"></p>
				<p class="tc mt5">
				  <a href="javascript:item_update('<%=quest_id%>');"><img src="../../images/common/btn_poll1.gif" alt="투표하기" /></a>	
				  <a href="javascript:question_view();"><img src="../../images/common/btn_poll2.gif" alt="결과보기" /></a>	
			  </p>
			</div>
	    <div class="pend"></div>
</form>	    
</body>
</html>
