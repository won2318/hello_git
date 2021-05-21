<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,  com.vodcaster.sqlbean.*,com.yundara.util.*"%>
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
	 * @author 박종성
	 *
	 * @description : Menu정보 수정.
	 * date : 2009-10-20
	 */


	String muid = "";
	String strTitle = "수정";

	if(request.getParameter("muid") != null 
		&& request.getParameter("muid").length()>0 
		&& !request.getParameter("muid").equals("null")
		&& com.yundara.util.TextUtil.isNumeric(request.getParameter("muid")))  {
		muid = com.vodcaster.utils.TextUtil.getValue(request.getParameter("muid"));
	}else {

		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근입니다. 이전 페이지로 이동합니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

	
	MenuManager mgr = MenuManager.getInstance();
	Vector vt = mgr.getMenuInfo(muid);
	MenuInfoBean info = new MenuInfoBean();

	String org_menu1 = "";
	String org_menu2 = "";
	String org_menu3 = "";
	String org_menu4 = "";

	try {
		// infoBean에 수정할 데이타 대입
		Enumeration e = vt.elements();
		com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());

	} catch (Exception e) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근입니다. 이전 페이지로 이동합니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

	

	Vector vs = mgr.separateCode(info.getMcode(), info.getMinfo());
	if(vs != null && vs.size()>0){
		org_menu1 = String.valueOf(vs.elementAt(0));
		org_menu2 = String.valueOf(vs.elementAt(1));
		org_menu3 = String.valueOf(vs.elementAt(2));
		org_menu4 = String.valueOf(vs.elementAt(3));
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근입니다. 이전 페이지로 이동합니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="./ajax_menu_select.js"></script>
<script language="javascript">
<!--
// 대분류 menu 불러오기 (ajax_menu_select.js)
	window.onload = function() {

	var info = "<%=info.getMinfo()%>";
	if(info == "B") {
		document.getElementById("mmenu1").style.display = "block";
	} else if(info == "C") {
		document.getElementById("mmenu1").style.display = "block";
		document.getElementById("mmenu2").style.display = "block";
	} else if(info == "D") {
		document.getElementById("mmenu1").style.display = "block";
		document.getElementById("mmenu2").style.display = "block";
		document.getElementById("mmenu3").style.display = "block";
	} else {
		document.getElementById("mmenu1").style.display = "none";
		document.getElementById("mmenu2").style.display = "none";
		document.getElementById("mmenu3").style.display = "none";
	}
	
		refreshMenuList_A( '', 'A', '<%=info.getMcode()%>');
		refreshMenuList_B( '', 'B', '<%=info.getMcode()%>');
		refreshMenuList_C( '', 'C', '<%=info.getMcode()%>');
	}

	function setMcode(form, val) {
		form.mcode.value = val;
	}
	
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

		form.submit();
	}
//-->
</script>
<%mcode="0301"; %>
<%@ include file="/vodman/menu/menu_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메뉴</span> 수정</h3>
			<p class="location">관리자페이지 &gt; 메뉴관리 &gt; <span>메뉴 수정</span></p>
			<div id="content">
				<form name='frmMenu' method='post' action="proc_menuUpdate.jsp">
					 
					<input type="hidden" name="muid" value="<%=info.getMuid()%>">
					<input type="hidden" name="mcode" value="">
					<input type="hidden" name="m_code" value="<%=info.getMcode()%>">
					<input type="hidden" name="mmenu4" value="">
					<input type="hidden" name="org_menu1" value="<%=org_menu1%>">
					<input type="hidden" name="org_menu2" value="<%=org_menu2%>">
					<input type="hidden" name="org_menu3" value="<%=org_menu3%>">
					<input type="hidden" name="org_menu4" value="<%=org_menu4%>">
				<table cellspacing="0" class="board_view" summary="메뉴 목록">
				<caption>메뉴 목록</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>분류</strong></th>
						<td class="bor_bottom01 pa_left">							
							<select id="mmenu1" name="mmenu1" class="sec01" style="float:left;width:120px;display:none" onchange="javascript:setMcode(document.frmMenu, this.value);refreshMenuList( this.value, 'B', 'mmenu2', 'mmenu3');">
								<option value="">---대분류선택---</option>
							</select>
							<select id="mmenu2" name="mmenu2" class="sec01" style="float:left;width:120px;display:none" onchange="javascript:setMcode(document.frmMenu, this.value);refreshMenuList( this.value, 'C', 'mmenu3');">
								<option value="">---중분류선택---</option>
							</select>
							<select id="mmenu3" name="mmenu3" class="sec01" style="float:left;width:120px;display:none"  onchange="javascript:setMcode(document.frmMenu, this.value);">
								<option value="">---소분류선택---</option>
							</select>
						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>타이틀</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="mtitle" maxlength="25" value="<%=info.getMtitle()%>" class="input01" style="width:500px;"/></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>URL</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="murl" maxlength="100" value="<%=info.getMurl()%>"" class="input01" style="width:500px;"/></td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>접근권한</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="mlevel" class="sec01" style="width:100px;">
								<option value="0" <%if(info.getMlevel() == 0) {out.println("selected='selected'");}%>>전체</option>
								<option value="1" <%if(info.getMlevel() == 1) {out.println("selected='selected'");}%>>로그인 회원</option>
<%--
	for(int i=1; i<=9; i++) {
		if(i==info.getMlevel())
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
		if(i==info.getMorder())
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
					<a href="mng_menuList.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>