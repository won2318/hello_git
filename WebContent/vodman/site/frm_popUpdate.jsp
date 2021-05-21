<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>
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
	 * @description : 팝업 update.
	 * date : 2009-10-15
	 */

	int seq = 0;
	if (Integer.parseInt(request.getParameter("seq")) == 0 || request.equals("")) {
		out.println("<script lanauage='javascript'>alert('팝업코드가 없습니다. 다시 선택해주세요.'); window.close(); </script>");
	} else {
		if (TextUtil.isNumeric(request.getParameter("seq")) == true) {
			try{
				seq = Integer.parseInt(request.getParameter("seq"));
			}catch(Exception e){
				seq = 0;
			}			
		} else {
			out.println("<script lanauage='javascript'>alert('팝업코드가 잘못되었습니다. 다시 선택해주세요.'); window.close(); </script>");
		}
	}
	PopupInfoBean qinfo = new PopupInfoBean();

	String title = "";
	String width = "";
	String height = "";
	String content = "";
	String pop_link = "";
	String is_visible = "";
	String img_name = "";
	String img_name_mobile = "";
	String pos_x = "";
	String pos_y = "";
	int pop_level = 0;
	String rstime ="";
	String retime ="";
	String pop_flag="";

	PopupManager mgr = PopupManager.getInstance();
	Vector vt = mgr.getPop(seq);

	// getPopup()에서 값을 가져와 뿌려주는 메소드
	if (vt != null && vt.size() > 0) {
//		seq = Integer.valueOf(seq); // 팝업 순서
		title = String.valueOf(vt.elementAt(1)); // 팝업창 제목
		img_name = String.valueOf(vt.elementAt(9)); // 팝업창 이미지
		img_name_mobile = String.valueOf(vt.elementAt(15)); // 모바일용 이미지
		qinfo.setImg_name(img_name);
		qinfo.setImg_name_mobile(img_name_mobile);
		width = String.valueOf(vt.elementAt(4)); // 팝업창 길이
		height = String.valueOf(vt.elementAt(5)); // 팝업창 높이
		content = String.valueOf(vt.elementAt(3)); // 팝업글
		pop_link = String.valueOf(vt.elementAt(8)); // 팝업 링크
		is_visible = String.valueOf(vt.elementAt(6));//화면출력
		pos_x = String.valueOf(vt.elementAt(10));//X 시작좌표
		pos_y = String.valueOf(vt.elementAt(11));//Y 시작좌표
		pop_flag = String.valueOf(vt.elementAt(12));//팝업창 제공 형태
		try{
			pop_level = Integer.parseInt(String.valueOf(vt.elementAt(7))); // 팝업 레벨
		}catch(Exception ex){
		}
		rstime = String.valueOf(vt.elementAt(13)); // 시작일
		retime = String.valueOf(vt.elementAt(14)); // 종료일
	} else {
		out.println("<script lanauage='javascript'>alert('팝업코드에 해당하는 정보가 없습니다. 다시 선택해주세요.'); window.close(); </script>");
	}
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
	function chkForm(form) {
		
		
		if(form.title.value == "") {
			alert("제목을 입력해주세요.");
			form.title.focus();
			return;
		}
		if(form.rstime.value == "") {
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
		if(confirm("수정하시겠습니까?") == false) {
			return;
		}
		form.submit();
	}
	
	function add_img(seq,gubun) {
	    if(seq == "") {
	        alert("잘못된 실행입니다.");
	        return;
	    }
	    window.open("proc_popUpdateImg.jsp?seq=" +seq+"&gubun="+gubun, "", "width=550,height=160,scrollbars=0,status=0");
	}
	
	
	function del_img(seq,gubun) {
	    if(seq == "") {
	        alert("잘못된 실행입니다.");
	        return;
	    }
	    window.open("proc_popDeleteImg.jsp?seq=" +seq+"&gubun="+gubun, "", "width=400,height=200,scrollbars=0,status=0");
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
		<form name='frmpop' method='post' action="proc_popUpdate.jsp">
			<input type="hidden" name="seq" value="<%=seq%>">
			<input type="hidden" name="mcode" value="<%=mcode%>">
		<table cellspacing="0" class="board_view" summary="팝업관리">
		<caption>팝업관리</caption>
		<colgroup>
			<col width="15%"/>
			<col/>
		</colgroup>
		<tbody class="bor_top03">
			<tr class="height_25">
				<th class="bor_bottom01 back_f7"><strong>제목</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="title" maxlength="200" value="<%=title%>" class="input01" style="width:500px;"  onkeyup="checkLength(this,200)" /></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>게시기간</strong></th>
				<td class="bor_bottom01 pa_left">시작일: <input type="text" name="rstime" value="<%=rstime%>" class="input01" style="width:80px;" onKeyDown="onlyNumber(this);" maxlength="10" readonly="readonly" />
						<a href="javascript:openCalendarWindow(document.frmpop.rstime)" title="찾아보기"><img src="/vodman/include/images/but_seek.gif" alt="찾아보기"/></a>&nbsp;~&nbsp;
						종료일:<input type="text" name="retime" value="<%=retime%>" class="input01" style="width:80px;" onKeyDown="onlyNumber(this);" maxlength="10" readonly="readonly" />
						<a href="javascript:openCalendarWindow(document.frmpop.retime)" title="찾아보기"><img src="/vodman/include/images/but_seek.gif" alt="찾아보기"/></a></td>
			</tr>
 
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>크기</strong></th>
				<td class="bor_bottom01 pa_left">가로 : <input type="text" name="width" maxlength="5" value="<%=width%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/>&nbsp;&nbsp;&nbsp;&nbsp;세로 : <input type="text" name="height" maxlength="5" value="<%=height%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>좌표</strong></th>
				<td class="bor_bottom01 pa_left">X좌표 : <input type="text" name="pos_x" maxlength="5" value="<%=pos_x%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/>&nbsp;&nbsp;&nbsp;&nbsp;Y좌표 : <input type="text" name="pos_y" maxlength="5" value="<%=pos_y%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/></td>
			</tr>
 			
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>팝업 배경이미지</strong></th>
				<td class="bor_bottom01 pa_left">
					<input type="hidden" name="img_name" value="<%=img_name %>">
<%if (qinfo.getImg_name().equals("")|| qinfo.getImg_name() == null || (qinfo.getImg_name() != null && qinfo.getImg_name().equals("null"))) {%> 
					<a href="javascript:add_img('<%=seq%>','1');" title="이미지 추가"><img src="/vodman/include/images/but_imgaddi.gif" alt="이미지추가"/></a> 
<%} else {
	String imgTmp = qinfo.getImg_name();
	imgTmp = java.net.URLEncoder.encode(imgTmp, "EUC-KR");
	imgTmp = "/upload/popup/" + imgTmp.replace("+", "%20");
	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();
	File file = new File(DirectoryNameManager.VODROOT+imgTmp);
	if(!file.exists()) {
		imgTmp = "/vodman/include/images/no_img01.gif";
	}
%> 
					<img src="<%=imgTmp%>" alt="배경이미지" class="img_style01"/><br/>
					<a href="javascript:del_img('<%=seq%>','1');" title="이미지삭제"><img src="/vodman/include/images/but_imgdel.gif" alt="이미지삭제"/></a>
<%}%>
					<br/><br/> 팝업존 이미지 사이즈는 525 x 267입니다.<br/>배경이미지 사용시 배경이미지의 톤이 너무 진하거나 입력된 내용과 겹칠경우 내용이 잘 보이지 않을수 있습니다.
				</td>
			</tr>
 
<%-- 
 			
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>모바일용 이미지</strong></th>
				<td class="bor_bottom01 pa_left">
					<input type="hidden" name="img_name_mobile" value="<%=img_name_mobile %>">
					<%=qinfo.getImg_name_mobile() %>
<%if (qinfo.getImg_name_mobile().equals("")|| qinfo.getImg_name_mobile() == null || (qinfo.getImg_name_mobile() != null && qinfo.getImg_name_mobile().equals("null"))) {%> 
					<a href="javascript:add_img('<%=seq%>','2');" title="이미지 추가"><img src="/vodman/include/images/but_imgaddi.gif" alt="이미지추가"/></a> 
<%} else {
	String imgTmp = qinfo.getImg_name_mobile();
	imgTmp = java.net.URLEncoder.encode(imgTmp, "EUC-KR");
	imgTmp = "/upload/popup/" + imgTmp.replace("+", "%20");
	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();
	File file = new File(DirectoryNameManager.VODROOT+imgTmp);
	if(!file.exists()) {
		imgTmp = "/vodman/include/images/no_img01.gif";
	}
%> 
					<img src="<%=imgTmp%>" alt="mobile용 이미지" class="img_style01"/><br/>
					<a href="javascript:del_img('<%=seq%>','2');" title="이미지삭제"><img src="/vodman/include/images/but_imgdel.gif" alt="이미지삭제"/></a>
<%}%>
					<br/><br/> * 이미지 사이즈는 320 x 64 입니다.
				</td>
			</tr>
 
--%>
 			
			<tr class="height_25 font_127">  
				<th class="bor_bottom01 back_f7"><strong>사용여부</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="is_visible" value="Y" <%=is_visible.equals("Y") ? "checked" : ""%> /> 사용&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="is_visible" value="N" <%=is_visible.equals("N") ? "checked" : ""%> /> 사용안함</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>표출방식</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="pop_flag" value="P" <%=pop_flag.equals("P") ? "checked" : ""%> /> 새창 팝업&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="M" <%=pop_flag.equals("M") ? "checked" : ""%>/> 메인화면 팝업존&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="C" <%=pop_flag.equals("C") ? "checked" : ""%>/> 메인화면 이슈(레이어 팝업)&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="D" <%=pop_flag.equals("D") ? "checked" : ""%>/> 메인화면 이슈(새창)</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>내용</strong></th>
				<td class="bor_bottom01 pa_left"><textarea name="content" id="content" class="input01" style="width:600px;height:150px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"><%=content%></textarea></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>팝업 이미지 링크</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="pop_link" maxlength="200" value="<%=pop_link %>" class="input01" style="width:500px;"/></td>
			</tr>
			<input type="hidden" name="pop_level" value="0">
			<%--
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>레벨 구분</strong></th>
				<td class="bor_bottom01 pa_left">
					<select name="pop_level" class="sec01" style="width:130px;">
						<option value="0" <%if(pop_level == 0) {out.println("selected='selected'");}%>>전체</option>
						<option value="1" <%if(pop_level == 1) {out.println("selected='selected'");}%>>로그인 회원</option>
					</select>
				</td>
			</tr>
			--%>
		</tbody>
		</table>
		</form>
		<div class="but01">
			<a href="javascript:chkForm(document.frmpop);"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
			<a href="/vodman/site/frm_popList.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
		</div>
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>

