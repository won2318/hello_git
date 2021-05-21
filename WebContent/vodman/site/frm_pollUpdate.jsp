<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id = "question" class="com.vodcaster.sqlbean.QuestionSqlBean"/>

<%
	/**
	 * @author 박종성
	 *
	 * @description : 설문 수정.
	 * date : 2009-10-16
	 */

	 int quest_id = Integer.parseInt((String)(request.getParameter("quest_id")));

	    // 값을 가져옵니다.
	    int item_count = 0;
	    String content = CharacterSet.toKorean(request.getParameter("content"));
	    if(request.getParameter("item_count")!=null) item_count = Integer.parseInt((String)(request.getParameter("item_count")));
	    String[] item = request.getParameterValues("item_content");
		if(item!=null){
		    for(int i = 0; i < item.length; i++) {
				item[i]=CharacterSet.toKorean(item[i]);
			}
		}

		Vector quest= null;
		Vector quest_item = null;
		String sdate = "";
		String edate = "";
		java.sql.Timestamp temp1;
		java.sql.Timestamp temp2;
//	    if(content == null){

	        try{
	            //[0]quest_id [1]content [2]insert_day [3] sdate_day [4] edate_day

	            quest = question.getQuestion(quest_id);
	            content = (String)(quest.elementAt(1));

	            temp1 = (java.sql.Timestamp)(quest.elementAt(3));
	            temp2 = (java.sql.Timestamp)(quest.elementAt(4));

	            sdate = temp1.toString();
	            edate = temp2.toString();

	        }catch(NullPointerException e){
	            out.println("<SCRIPT LANGUAGE='JavaScript'>");
	            out.println("alert('처리 중 오류가 발생하였습니다.')");
	            out.println("history.go(-1)");
	            out.println("</SCRIPT>");
	        }
//	    }

	    if(item_count == 0 && item == null){
	        try{
	            //[0]quest_id [1]item_no [2]item_content [3]ans_count
	            quest_item = question.getQuestionItem(quest_id);
	            item_count = quest_item.size();
	            item = new String[item_count];

	            for(int i = 0; i < item_count; i++) {
	                Vector temp = (Vector)quest_item.elementAt(i);
	                item[i] = (String)(temp.elementAt(2));
	            }
	        }catch(NullPointerException e){
	            out.println("<SCRIPT LANGUAGE='JavaScript'>");
	            out.println("alert('처리 중 오류가 발생하였습니다.')");
	            out.println("history.go(-1)");
	            out.println("</SCRIPT>");
	        }
	    }
	    QuestionInfoBean bean2 = new QuestionInfoBean();

	 	bean2.setRstime1(sdate.substring(0,4));
	    bean2.setRstime2(sdate.substring(5,7));
	    bean2.setRstime3(sdate.substring(8,10));
	    bean2.setRstime4(sdate.substring(11,13));
	    bean2.setRstime5(sdate.substring(14,16));

	    bean2.setRetime1(edate.substring(0,4));
	    bean2.setRetime2(edate.substring(5,7));
	    bean2.setRetime3(edate.substring(8,10));
	    bean2.setRetime4(edate.substring(11,13));
	    bean2.setRetime5(edate.substring(14,16));


%>

<%@ include file="/vodman/include/top.jsp"%>


<script language="JavaScript">
function submitSubNum() {
		if(!isNumber(document.quest.item_count)){
			return ;
		}
		var form = document.quest;
		if(!form.rstime1.value || !form.rstime2.value ||!form.rstime3.value || !form.rstime4.value || !form.rstime5.value) {
			alert("시작일시를 입력해주세요.");
			form.rstime1.focus();
			return false;
		}

		if(!form.retime1.value || !form.retime2.value ||!form.retime3.value || !form.retime4.value || !form.retime5.value) {
			alert("종료일시를 입력해주세요.");
			form.retime1.focus();
			return false;
		}

		
		document.quest.action = "frm_pollUpdate.jsp";
		document.quest.submit();
}

function submitKey(e){
	if(e.keyCode == 13){
		submitSubNum(e);
	}
}

function isNumber (obj)
{
	var str = obj.value
	if(str.length==0){
		alert("설문 문항 수를 입력하세요");
		return false;
	}
	if(str=='0'){
		alert("설문 문항에 1~10 까지의 수만 넣을 수 있습니다.");
		return false;
	}
	for(var i=0; i< str.length; i++){
		if(!('0' <= str.charAt(i) && str.charAt(i) <='9')){
			alert("설문 문항에 1~10 까지의 수만 넣을 수 있습니다.");
			return false;
		}
	}
	if(eval(str)>10){
			alert("설문 문항에 1~10 까지의 수만 넣을 수 있습니다.");
			return false;
	}
	return true;
}

function submitQuest(){
		if(!isNumber(document.quest.item_count)){
			return ;
		}

		var start_date = document.quest.rstime1.value*12*31*24*60 + document.quest.rstime2.value* 31 *24*60 + document.quest.rstime3.value* 24*60 + document.quest.rstime4.value*60 + document.quest.rstime5.value ;
		var end_date = document.quest.retime1.value*12*31*24*60 + document.quest.retime2.value* 31 *24*60 + document.quest.retime3.value* 24*60 + document.quest.retime4.value*60 + document.quest.retime5.value ;
			
 
		if (start_date > end_date) {  
			alert("시작일자가 종료일자보다 작아야 합니다.");
			return false;
		 }  		
		if (confirm('설문 내용을 수정하시겠습니까?수정 하시면 이전의 설문 카운트 정보는 삭제 됩니다.')) {
			document.quest.action = "proc_pollUpdate.jsp";
			document.quest.submit();
		}else {
			alert('수정을 취소하셨습니다.');
			return;
		}
}

function maxNumber(obj,flag) {
	if(flag == 1) {
		if(obj.value >= 24 ||obj.value < 0) {
			alert("시간은 00시부터 23시까지만 입력할 수 있습니다.")
			obj.value="";
			obj.focus();
			return;
		}
	}
	if(flag == 2) {
		if(obj.value >= 60 ||obj.value < 0) {
			alert("분은 00분부터 59분까지만 입력할 수 있습니다.")
			obj.value="";
			obj.focus();
			return;
		}
	}
}
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<div id="contents">
			<h3><span>설문</span>관리</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>설문관리</span></p>
			<div id="content">
				<!-- 내용 -->
				<table cellspacing="0" class="board_view" summary="설문등록">
				<caption>설문 수정</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody>
					<form name="quest" method="post" action="">
					<input type="hidden" name="mcode" value="<%=mcode%>" />
					<tr>
						<th class="bor_bottom01 back_f7"><strong>선택항목개수</strong></th>
						<td class="bor_bottom01 pa_left">
							<input type="hidden" name="quest_id" value="<%=quest_id%>">
							<select name="item_count" onChange="submitSubNum()" class="sec01" style="width:40px;">
<%	for(int j=2; j<=10; j++) {%>
								<option value="<%=j%>" <%=(j==item_count)? "selected" : ""%>><%=j%></option>
<%	}%>
							</select>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>시작일시</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="rstime1" maxlength='4' value="<%=bean2.getRstime1()%>" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" onkeypress="onlyNumber();" readonly />년&nbsp;
						<input type="text" name="rstime2" maxlength='2' value="<%=bean2.getRstime2()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />월&nbsp;
						<input type="text" name="rstime3" maxlength='2' value="<%=bean2.getRstime3()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />일&nbsp;
						<input type="text" name="rstime4" maxlength='2' value="<%=bean2.getRstime4()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();"  onblur="maxNumber(this,1);" />시&nbsp;
						<input type="text" name="rstime5" maxlength='2' value="<%=bean2.getRstime5()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();"  onblur="maxNumber(this,2);" />분&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="찾아보기" onclick="window.open('calendar.jsp?mode=1','','width=200,height=180,scrollbars=0,statusbar=0');" />
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>종료일시</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="retime1" maxlength='4' value="<%=bean2.getRetime1()%>" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" onkeypress="onlyNumber();" readonly />년&nbsp;
						<input type="text" name="retime2" maxlength='2' value="<%=bean2.getRetime2()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />월&nbsp;
						<input type="text" name="retime3" maxlength='2' value="<%=bean2.getRetime3()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />일&nbsp;
						<input type="text" name="retime4" maxlength='2' value="<%=bean2.getRetime4()%>" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();"  onblur="maxNumber(this,1);" />시&nbsp;
						<input type="text" name="retime5" maxlength='2' value="<%=bean2.getRetime5()%>" class="input01" style="width:15px;" onFocus="this.select();" onkeypress="onlyNumber();"  onblur="maxNumber(this,2);" />분&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="찾아보기" onclick="window.open('calendar.jsp?mode=2','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>내용</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="content" class="input01" style="width:600px;height:70px;" cols="100" rows="100"><%=content%></textarea></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>선택항목 입력</strong></th>
						<td class="bor_bottom01 pa_left">
<%	 for(int i = 0; i < item_count; i++) {%>
						<%=i+1%>&nbsp;<input type="text" name="item_content" value="<%=(i<item.length)? item[i]:""%>" class="input01" style="width:450px;"/><br/>
<%	} %>
						</td>
					</tr>
				</form>
				</tbody>
				</table>
				<div class="but01">
					<a href="javascript:submitQuest();"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="mng_poll.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>