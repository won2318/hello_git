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
	 * @description : 카테고리 수정.
	 * date : 2009-10-19
	 */

		String cuid = "";
		String strTitle = "";
		String ctype = "";

		if(request.getParameter("cuid") != null && request.getParameter("cuid").length() > 0 && !request.getParameter("cuid").equals("null")) {
			cuid = request.getParameter("cuid");
		}else {

			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String mcode = request.getParameter("mcode");
			if(mcode == null || mcode.length() <= 0) {
				mcode = "0401";
			}
			String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype="+ctype ;
						%>
						<%@ include file = "/vodman/include/REF_URL.jsp"%>
						<%
						return;
		}
		
		if(request.getParameter("ctype") != null && request.getParameter("ctype").length()>0 && !request.getParameter("ctype").equals("null")){
			ctype = String.valueOf(request.getParameter("ctype"));
		}else{
			ctype = "V";
		}


		CategoryManager mgr = CategoryManager.getInstance();
		Vector vt = mgr.getCategoryInfo(cuid);
		CategoryInfoBean info = new CategoryInfoBean();

		String org_category1 = "";
		String org_category2 = "";
		String org_category3 = "";
		String org_category4 = "";
		if(vt != null && vt.size()>0){
			try {
				// infoBean에 수정할 데이타 대입
				Enumeration e = vt.elements();
				com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
				if(String.valueOf(info.getCtype()).equals("V"))
					strTitle = "<b>VOD 카테고리 수정</b>";
				else if(String.valueOf(info.getCtype()).equals("A"))
					strTitle = "<b>AOD 카테고리 수정</b>";
				else if(String.valueOf(info.getCtype()).equals("C"))
					strTitle = "<b>영상강좌 카테고리 수정</b>";
				else if(String.valueOf(info.getCtype()).equals("P"))
					strTitle ="<b>PHOTO 카테고리  수정 </b>";
				else if(String.valueOf(info.getCtype()).equals("R"))
					strTitle ="<b>Live 카테고리  수정</b>";
				else if(String.valueOf(info.getCtype()).equals("X"))
					strTitle ="<b>분야  수정 </b>";
				else if(String.valueOf(info.getCtype()).equals("Y"))
					strTitle ="<b>프로그램  수정</b>";
			} catch (Exception e) {
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('처리 중 오류가 발생했습니다.')");
				//out.println("history.go(-1)");
				out.println("</SCRIPT>");
				String mcode = request.getParameter("mcode");
				if(mcode == null || mcode.length() <= 0) {
					mcode = "0401";
				}
				String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype="+ctype ;
						%>
						<%@ include file = "/vodman/include/REF_URL.jsp"%>
						<%
						return;
			}
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생했습니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String mcode = request.getParameter("mcode");
			if(mcode == null || mcode.length() <= 0) {
				mcode = "0401";
			}
			String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype="+ctype ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}

		


		Vector vs = mgr.separateCode(info.getCcode(), info.getCinfo());
		if(vt != null && vs.size()>0){
			org_category1 = String.valueOf(vs.elementAt(0));
			org_category2 = String.valueOf(vs.elementAt(1));
			org_category3 = String.valueOf(vs.elementAt(2));
			org_category4 = String.valueOf(vs.elementAt(3));
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생했습니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String mcode = request.getParameter("mcode");
			if(mcode == null || mcode.length() <= 0) {
				mcode = "0401";
			}
			String REF_URL="mng_categoryList.jsp?mcode="+mcode+"&ctype="+ctype ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}
	%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="/vodman/include/js/ajax_category_select.js"></script>
<script language="javascript">
<!--
	window.onload = function() {

		var info = "<%=info.getCinfo()%>";
		if(info == "B") {
			document.getElementById("ccategory1").style.display = "block";
		} else if(info == "C") {
			document.getElementById("ccategory1").style.display = "block";
			document.getElementById("ccategory2").style.display = "block";
		} else if(info == "D") {
			document.getElementById("ccategory1").style.display = "block";
			document.getElementById("ccategory2").style.display = "block";
			document.getElementById("ccategory3").style.display = "block";
		} else {
			document.getElementById("ccategory1").style.display = "none";
			document.getElementById("ccategory2").style.display = "none";
			document.getElementById("ccategory3").style.display = "none";
		}

		refreshCategoryList_A('V', '', 'A', '<%=info.getCcode()%>');
		refreshCategoryList_B('V', '', 'B', '<%=info.getCcode()%>');
		refreshCategoryList_C('V', '', 'C', '<%=info.getCcode()%>');
	}

	function setCcode(form, val) {
		form.ccode.value = val;
	}

	function chk_form(form) {

		if(form.ctitle.value == "") {
			alert("타이틀을 입력해주세요.");
			form.ctitle.focus();
			return;
		}

		form.submit();
	}

//-->
</script>
<%@ include file="/vodman/category/category_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>카테고리</span> 수정</h3>
			<p class="location">관리자페이지 &gt; 카테고리관리 &gt; <span>카테고리 수정</span></p>
			<div id="content">
				<p class="title_dot01"><%=strTitle%></p>
				<form name='frmCategory' method='post' action="proc_categoryUpdate.jsp" onSubmit="return chk_form(document.frmCategory);">
					<input type="hidden" name="mcode" value="<%=mcode%>">
					<input type="hidden" name="ctype" value="<%=info.getCtype()%>">
					<input type="hidden" name="cuid" value="<%=info.getCuid()%>">
					<input type="hidden" name="ccode" value="<%=info.getCcode()%>">
					<input type="hidden" name="ccategory4" value="">
					<input type="hidden" name="org_category1" value="<%=org_category1%>">
					<input type="hidden" name="org_category2" value="<%=org_category2%>">
					<input type="hidden" name="org_category3" value="<%=org_category3%>">
					<input type="hidden" name="org_category4" value="<%=org_category4%>">
					
				<table cellspacing="0" class="board_view" summary="카테고리 수정">
				<caption>카테고리 수정</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>분류</strong></th>
						<td class="bor_bottom01 pa_left">							
							<select id="ccategory1" name="ccategory1" class="sec01" style="float:left;width:120px;display:none" disabled onchange="javascript:setCcode(document.frmCategory, this.value);refreshCategoryList('<%=info.getCtype()%>', this.value, 'B', 'ccategory2', 'ccategory3');">
								<option value="">--- 대분류  선택 ---</option>
							</select>
							<select id="ccategory2" name="ccategory2" class="sec01" style="float:left;width:120px;display:none" disabled onchange="javascript:setCcode(document.frmCategory, this.value);refreshCategoryList('<%=info.getCtype()%>', this.value, 'C', 'ccategory3');">
								<option value="">--- 중분류 선택 ---</option>
							</select>
							<select id="ccategory3" name="ccategory3" class="sec01" style="width:120px;display:none" disabled onchange="javascript:setCcode(document.frmCategory, this.value);">
								<option value="">--- 소분류 선택 ---</option>
							</select>
						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>타이틀</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="ctitle" maxlength="50" value="<%=info.getCtitle()%>" class="input01" style="width:500px;" onkeyup="checkLength(this,50)" /></td>
					</tr>

					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>순서</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="clevel" class="sec01" style="width:50px;">
<%
	for(int i=1; i<=100; i++) {
		if(i==info.getClevel())
			out.println("<option value='" +i+ "' selected>" +i+ "</option>");
		else
			out.println("<option value='" +i+ "'>" +i+ "</option>");
	}
%>
							</select>
						</td>
					</tr>

					<tr>
						<th class="bor_bottom01 back_f7"><strong>공개구분</strong></th>
						<td class="bor_bottom01 pa_left"><input name="openflag" type="radio" value="Y" <%if(info.getOpenflag().equals("Y")) {out.println("checked='checked'");} %> /> 공개
							&nbsp;&nbsp;&nbsp;&nbsp;<input  name="openflag" type="radio" value="N" <%if(info.getOpenflag().equals("N")) {out.println("checked='checked'");} %> /> 비공개</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>설명</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="memo" maxlength="50" value="<%=info.getMemo()%>" class="input01" style="width:500px;" onkeyup="checkLength(this,100);"/></td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:chk_form(document.frmCategory);"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="mng_categoryList.jsp?mcode=<%=mcode%>&ctype=<%=info.getCtype()%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>