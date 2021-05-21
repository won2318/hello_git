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
<%
	/**
	 * @author 박종성
	 *
	 * @description : 설문 추가.
	 * date : 2009-10-16
	 */

    String hquest = CharacterSet.toKorean(request.getParameter("hquest"));
    String num = request.getParameter("num");
	if (num == null ) {num = "2";}

%>

<%@ include file="/vodman/include/top.jsp"%>


<script language="javascript">
<!--

    function submitSubNum() {
        document.subnum.hquest.value = document.quest.content.value;
        document.subnum.action.value = "frm_pollAdd.jsp?mcode=<%=mcode%>";
        document.subnum.submit();
    }

    function submitQuest() {
    	var form = document.quest;
        if(document.quest.content.value == "") {
            alert("설문 내용을 입력하세요.");
            return;
        }
        if(!form.rstime1.value || !form.rstime2.value ||!form.rstime3.value || !form.rstime4.value || !form.rstime5.value) {
			alert("시작일시를 입력해주세요.");
			form.rstime1.focus();
			return;
		}

		if(!form.retime1.value || !form.retime2.value ||!form.retime3.value || !form.retime4.value || !form.retime5.value) {
			alert("종료일시를 입력해주세요.");
			form.retime1.focus();
			return;
		}

		var start_date = document.quest.rstime1.value*12*31*24*60 + document.quest.rstime2.value* 31 *24*60 + document.quest.rstime3.value* 24*60 + document.quest.rstime4.value*60 + document.quest.rstime5.value ;
		var end_date = document.quest.retime1.value*12*31*24*60 + document.quest.retime2.value* 31 *24*60 + document.quest.retime3.value* 24*60 + document.quest.retime4.value*60 + document.quest.retime5.value ;

		if (start_date > end_date) {  
			alert("시작일자가 종료일자보다 작아야 합니다.");
			return;
		 }  	
        document.quest.submit();
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

//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<div id="contents">
			<h3><span>설문</span>관리</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>설문관리</span></p>
			<div id="content">
				<!-- 내용 -->
				<table cellspacing="0" class="board_view" summary="설문등록">
				<caption>설문등록</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody>
					<form name="subnum" method="post" action="">
					<tr>
						<th class="bor_bottom01 back_f7"><strong>선택항목개수</strong></th>
						<td class="bor_bottom01 pa_left">
							<input type="hidden" name="hquest">
							<select name="num" onChange="submitSubNum()" class="sec01" style="width:40px;">
<%	for(int i=2; i<=10; i++) {%>

								<option value="<%=i%>" <%=(String.valueOf(i).equals(num)) ? "selected" : ""%>><%=i%></option>

<%	}%>
							</select>
						</td>
					</tr>
					</form>
					<form name="quest" method="post" action="proc_pollAdd.jsp">
						<input type="hidden" name="mcode" value="<%=mcode%>" />
					<tr>
						<th class="bor_bottom01 back_f7"><strong>시작일시</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="rstime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" onkeypress="onlyNumber();" readonly />년&nbsp;
						<input type="text" name="rstime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />월&nbsp;
						<input type="text" name="rstime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />일&nbsp;
						<input type="text" name="rstime4" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();"  onblur="maxNumber(this,1);" />시&nbsp;
						<input type="text" name="rstime5" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();"  onblur="maxNumber(this,2);" />분&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="찾아보기" onclick="window.open('calendar.jsp?mode=1','','width=200,height=180,scrollbars=0,statusbar=0');" />
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>종료일시</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="text" name="retime1" maxlength='4' value="" class="input01" style="width:30px;" onFocus="this.select();" onKeyUp="return autoTab(this, 4, event);" onkeypress="onlyNumber();" readonly />년&nbsp;
						<input type="text" name="retime2" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />월&nbsp;
						<input type="text" name="retime3" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();" readonly />일&nbsp;
						<input type="text" name="retime4" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onKeyUp="return autoTab(this, 2, event);" onkeypress="onlyNumber();"  onblur="maxNumber(this,1);" />시&nbsp;
						<input type="text" name="retime5" maxlength='2' value="" class="input01" style="width:15px;" onFocus="this.select();" onkeypress="onlyNumber();"  onblur="maxNumber(this,2);" />분&nbsp;
						<img src="/vodman/include/images/but_seek.gif" alt="찾아보기" onclick="window.open('calendar.jsp?mode=2','','width=200,height=180,scrollbars=0,statusbar=0')" />
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01 back_f7"><strong>내용</strong></th>
<%	if(hquest != null) { %>
						<td class="bor_bottom01 pa_left"><textarea name="content" class="input01" style="width:600px;height:70px;" cols="100" rows="100"><%= hquest %></textarea></td>
<%	} else { %>
						<td class="bor_bottom01 pa_left"><textarea name="content" class="input01" style="width:600px;height:70px;" cols="100" rows="100"></textarea></td>
<%	} %>
					</tr>
<%
	// num의 값이 null이 아니면...
	if(num != null) {
%>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>선택항목 입력</strong></th>
						<td class="bor_bottom01 pa_left">
<%
		int cnt;
		try {
			cnt = Integer.parseInt(num);
		} catch (NumberFormatException e) {
			cnt = 0;
		}

		for(int i=1; i<=cnt; i++) {
%>
						<%=i%>&nbsp;<input type="text" name="item_content" value="" class="input01" style="width:450px;"/><br/>
<%		} %>
						</td>
					</tr>
				</form>
				</tbody>
				</table>
				<div class="but01">
<%		if( cnt > 0){	%>
					<a href="javascript:submitQuest();"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
<%		} %>
					<a href="mng_poll.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>
<%	} %>
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>