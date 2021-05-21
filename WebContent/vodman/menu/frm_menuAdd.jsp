<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*,  com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "cate_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 이희락
	 *
	 * @description : 메뉴정보 입력.
	 * date : 2009-01-09
	 */


	String strTitle = "";


	MenuManager mgr = MenuManager.getInstance();
	Vector vt = mgr.getMenuListALL( "A");


%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="./ajax_menu_select.js"></script>
<script language="javascript">
// 대분류 menu 불러오기 (ajax_menu_select.js)
		window.onload = function() {
			refreshMenuList( '', 'A', 'mmenu1');
		}
</script>
<script language="javascript">
<!--
	

	function chk_form(form) {

		if(form.mtitle.value == "") {
			alert("타이틀을 입력해주세요.");
			form.ctitle.focus();
			return;
		}
		if(form.murl.value == "") {
			alert("URL을 입력해주세요.");
			form.murl.focus();
			return;
		}
		if(confirm("등록하시겠습니까?")) {
			form.submit();
		}
	}
//-->
</script>
<%mcode="0302"; %>
<%@ include file="/vodman/menu/menu_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메뉴</span> 등록</h3>
			<p class="location">관리자페이지 &gt; 메뉴관리 &gt; <span>메뉴 등록</span></p>
			<div id="content">
				<form name='frmMenu' method='post' action="proc_menuAdd.jsp">
					<input type="hidden" name="mcode" value="<%=mcode%>" />
					 
				<table cellspacing="0" class="board_view" summary="메뉴 등록">
				<caption>메뉴 등록</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>분류</strong></th>
						<td class="bor_bottom01 pa_left">							
							<select id="mmenu1" name="mmenu1" class="sec01" style="width:120px;" onchange="javascript:refreshMenuList( this.value, 'B', 'mmenu2','mmenu3');">
								<option value="">---대분류선택---</option>
							</select>
							<select id="mmenu2" name="mmenu2" class="sec01" style="width:120px;" onchange="javascript:refreshMenuList( this.value, 'C', 'mmenu3');">
								<option value="">---중분류선택---</option>
							</select>
							<select id="mmenu3" name="mmenu3" class="sec01" style="width:120px;">
								<option value="">---소분류선택---</option>
							</select>
						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>타이틀</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="mtitle" maxlength="25" value="" class="input01" style="width:500px;"/></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>URL</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="murl" value="" maxlength="100" class="input01" style="width:500px;"/></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>접근권한</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="mlevel" class="sec01" style="width:100px;">
								<option value="0">전체</option>
								<option value="1">로그인 회원</option>
<%--
	for(int i=1; i<=9; i++) {
		if(i==9)
			out.println("<option value='" +i+ "' selected>" +i+ "</option>");
		else
			out.println("<option value='" +i+ "'>" +i+ "</option>");
	}
--%>
							</select>
						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>순서</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="morder" class="sec01" style="width:50px;">
<%
	for(int i=1; i<=100; i++) {
		if(i==10)
			out.println("<option value='" +i+ "' selected>" +i+ "</option>");
		else
			out.println("<option value='" +i+ "'>" +i+ "</option>");
	}
%>
							</select>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:chk_form(document.frmMenu);"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="mng_menuList.jsp?mcode=0301"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>