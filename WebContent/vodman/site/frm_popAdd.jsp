<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
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
	 * @description : 팝업 목록 table.
	 * date : 2009-10-15
	 */
	PopupInfoBean pinfo = new PopupInfoBean();
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
	function chkForm(form) {
		
		
		if(form.title.value == "") {
			alert("제목을 입력해주세요.");
			form.title.focus();
			return;
		}
		if(form.rstime.value =="") {
			alert("게시 시작일자를 입력해주세요.");
			form.rstime.focus();
			return;
		}
	
		//if(form.width.value == "") {
		//	alert("넓이를 입력해주세요.");
		//	form.width.focus();
		//	return;
		//}
	
		//if(form.height.value == "") {
		//	alert("높이를 입력해주세요.");
		//	form.height.focus();
		//	return;
		//}
	
		//if(form.img_name.value == "") {
		//	alert("배경 이미지를 입력해주세요.");
		//	form.img_name.focus();
		//	return;
		//}
	
//		if(form.content.value == "") {
//			alert("내용을 입력해주세요.");
//			form.content.focus();
//			return;
//		}
	
		//if(!form.pop_link.value) {
		//	alert("팝업링크를 입력해주세요.");
		//	form.pop_link.focus();
		//	return false;
		//}
		
	
		// if(!form.pop_level.value) {
			// alert("레벨을 입력해주세요.");
			// form.pop_level.focus();
			// return;
		// }
		if(confirm("저장하시겠습니까?") == false) {
			return;
		}
		form.submit();
	}
	
	function add_img(seq) {
	    if(seq == "") {
	        alert("잘못된 실행입니다.");
	        return;
	    }
	    window.open("proc_popUpdateImg.jsp?seq=" +seq, "", "width=400,height=200,scrollbars=0,status=0");
	}
	
	
	function del_img(seq) {
	    if(seq == "") {
	        alert("잘못된 실행입니다.");
	        return;
	    }
	    window.open("proc_popDeleteImg.jsp?seq=" +seq, "", "width=400,height=200,scrollbars=0,status=0");
	}

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

<%@ include file="/vodman/best/best_left.jsp"%>

<div id="contents">
	<h3><span>팝업</span>관리</h3>
	<p class="location">관리자페이지 &gt; 메인화면관리 &gt; 팝업관리 &gt; <span>팝업입력</span></p>
 
	<div id="content">
		<!-- 내용 -->
		<form name='frmpop' method='post' action="proc_popAdd.jsp?mcode=<%=mcode%>" enctype="multipart/form-data">
		<table cellspacing="0" class="board_view" summary="팝업관리">
		<caption>팝업관리</caption>
		<colgroup>
			<col width="15%"/>
			<col/>
		</colgroup>
		<tbody class="bor_top03">
			<tr class="height_25">
				<th class="bor_bottom01 back_f7"><strong>제목</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="title" maxlength="200" value="" class="input01" style="width:500px;" onkeyup="checkLength(this,200)" /></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>게시기간</strong></th>
				<td class="bor_bottom01 pa_left">시작일: <input type="text" name="rstime" value="" class="input01" style="width:80px;"   maxlength="10" readonly="readonly" /></input>
						<a href="javascript:openCalendarWindow(document.frmpop.rstime)" title="찾아보기"><img src="/vodman/include/images/but_seek.gif" alt="찾아보기"/></a>&nbsp;~&nbsp;
						종료일:<input type="text" name="retime" value="" class="input01" style="width:80px;"   maxlength="10"  readonly="readonly" />
						<a href="javascript:openCalendarWindow(document.frmpop.retime)" title="찾아보기"><img src="/vodman/include/images/but_seek.gif" alt="찾아보기"/></a></td>
			</tr>
 
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>크기</strong></th>
				<td class="bor_bottom01 pa_left">가로 : <input type="text" name="width" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" />&nbsp;&nbsp;&nbsp;&nbsp;세로 : <input type="text" name="height" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" /></td>
			</tr>
			
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>좌표</strong></th>
				<td class="bor_bottom01 pa_left">X좌표 : <input type="text" name="pos_x" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" />&nbsp;&nbsp;&nbsp;&nbsp;Y좌표 : <input type="text" name="pos_y" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" /></td>
			</tr>
 
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>팝업 배경이미지</strong></th>
				<td class="bor_bottom01 pa_left"><input type="file" name="img_name" value="" class="input01" style="width:300px;"/>
				<br/> * 팝업존 이미지 사이즈는 525 x 267입니다.
				</td>
			</tr>
<!-- 			<tr class="height_25 font_127"> -->
<!-- 				<th class="bor_bottom01 back_f7"><strong>모바일용 이미지</strong></th> -->
<!-- 				<td class="bor_bottom01 pa_left"><input type="file" name="img_name_mobile" value="" class="input01" style="width:300px;"/> -->
<!-- 				<br/> * 이미지 사이즈는 320 x 64 입니다. -->
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>사용여부</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="is_visible" value="Y" checked /> 사용&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="is_visible" value="N" /> 사용안함</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>표출방식</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="pop_flag" value="P" checked /> 새창 팝업&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="M" /> 메인화면 팝업존&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="C" />메인화면 이슈(레이어팝업)&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="D" />메인화면 이슈(새창)
				</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>내용</strong></th>
				<td class="bor_bottom01 pa_left"><textarea name="content" class="input01" style="width:600px;height:150px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"></textarea></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>팝업 이미지 링크</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="pop_link" maxlength="200" value="" class="input01" style="width:500px;"/></td>
			</tr>
			<input type="hidden" name="pop_level" value="0" />
			<%--
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>레벨 구분</strong></th>
				<td class="bor_bottom01 pa_left">
					<select name="pop_level" class="sec01" style="width:130px;">
						<option value="0">전체</option>
						<option value="1">로그인 회원</option>
					</select>
				</td>
			</tr>
			--%>
		</tbody>
		</table>
		</form>
		<div class="but01">
			<a href="javascript:chkForm(document.frmpop);"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
			<a href="frm_popList.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
		</div>
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>

