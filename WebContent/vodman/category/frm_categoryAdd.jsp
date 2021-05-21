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
	 * @author 박종성
	 *
	 * @description : 카테고리 등록.
	 * date : 2009-10-19
	 */

		String ctype = "";
		String strTitle = "";

		if(request.getParameter("ctype") != null && request.getParameter("ctype").length()>0 && !request.getParameter("ctype").equals("null")){
			ctype = String.valueOf(request.getParameter("ctype"));
		}else{
			ctype = "V";
		}
		
		if(ctype.equals("V"))
			strTitle = "<b>VOD 카테고리 </b>";
	    else if (ctype.equals("P"))
			strTitle = "<b>PHOTO 카테고리 </b>";
		else if(ctype.equals("X"))
			strTitle ="<b>분야 </b>";
		else if(ctype.equals("Y"))
			strTitle ="<b>프로그램 </b>";
		

		CategoryManager mgr = CategoryManager.getInstance();
		Vector vt = mgr.getCategoryListALL2(ctype, "A");


	%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="/vodman/include/js/ajax_category_select.js"></script>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="javascript">
// 대분류 카테고리 불러오기 (ajax_category_select.js)
	window.onload = function() {
		refreshCategoryList('<%=ctype%>', '', 'A', 'ccategory1');
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
			<h3><span><%=strTitle%></span>등록 </h3>
			<p class="location">관리자페이지 &gt; 카테고리관리 &gt; <span><%=strTitle%>등록</span></p>
			<div id="content">
				<%-- <p class="title_dot01"><%=strTitle%></p> --%>

				<form name='frmCategory' method='post' action="proc_categoryAdd.jsp">
					<input type="hidden" name="mcode" value="<%=mcode%>">
					<input type="hidden" name="ctype" value="<%=ctype%>">
				
					<input type="hidden" name="ccategory4" value="">
				
				<table cellspacing="0" class="board_view" summary="카테고리 등록">
				<caption>카테고리 등록</caption>
				<colgroup>
					<col width="15%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>분류</strong></th>
						<td class="bor_bottom01 pa_left">							
							<select id="ccategory1" name="ccategory1" class="sec01" style="width:120px;" onchange="javascript:refreshCategoryList('<%=ctype%>', this.value, 'B', 'ccategory2');">
								<option value="">--- 대분류  선택 ---</option>
							</select>

							<select id="ccategory2" name="ccategory2" class="sec01" style="width:120px;" onchange="javascript:refreshCategoryList('<%=ctype%>', this.value, 'C', 'ccategory3');">
								<option value="">--- 중분류 선택 ---</option>
							</select>
							<select id="ccategory3" name="ccategory3" class="sec01" style="width:120px;">
								<option value="">--- 소분류 선택 ---</option>
							</select>

						</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>타이틀</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="ctitle" maxlength="50" value="" class="input01" style="width:500px;" onkeyup="checkLength(this,50);"/></td>
					</tr>

					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>순서</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="clevel" class="sec01" style="width:50px;">
<%
	for(int i=1; i<=100; i++) {
		if(i==50)
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
						<td class="bor_bottom01 pa_left"><input name="openflag" type="radio" value="Y" checked='checked' /> 공개&nbsp;&nbsp;&nbsp;&nbsp;<input  name="openflag" type="radio" value="N" /> 비공개</td>
					</tr>
					<tr class="height_25">
						<th class="bor_bottom01 back_f7"><strong>설명</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="memo" maxlength="50" value="" class="input01" style="width:500px;" onkeyup="checkLength(this,100);"/></td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:chk_form(document.frmCategory);"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="mng_categoryList.jsp?mcode=0401&ctype=<%=ctype%>"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>