<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.* , com.hrlee.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	/**
	 * @author lee hee rak
	 *
	 * @description :게시판을 생성을 위한 정보를 입력하는 폼입니다.
	 * date : 2009-10-19
	 */

%>
<%
if(!chk_auth(vod_id, vod_level, "b_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script language='javascript'>
	function insertBoard(){
		var f = document.frmBoard;

		if (f.board_title.value=="") {
		   alert ("게시판 제목을 입력하지 않으셨습니다.")
		   f.board_title.focus();
		   return
		}
		if (f.board_page_line.value=="") {
		   alert ("페이지 라인수를 입력하지 않으셨습니다.")
		   f.board_page_line.focus();
		   return
		}
		if (f.board_priority.value=="") {
		   alert ("게시판우선순위를 입력하지 않으셨습니다.")
		   f.board_priority.focus();
		   return
		}
		
		f.action='proc_boardAdd.jsp';
		f.submit();

	}


	function isNumber ()
	{
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert("숫자만 가능합니다 다시 입력하세요!");
			event.returnValue=false;
		}
	}

</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>게시판</span> 등록</h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; <span>게시판 등록</span></p>
			<div id="content">
			<form name='frmBoard' method='post'>
			<input type="hidden" name="mcode" value="<%=mcode%>" />
				<table cellspacing="0" class="board_view" summary="게시판  등록">
				<caption>게시판  등록</caption>
				<colgroup>
					<col width="17%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03 font_127">
					<tr>
						<th class="bor_bottom01"><strong>게시판제목</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="board_title" value="" maxlength="200" class="input01" style="width:300px;" onkeyup="checkLength(this,200)"/></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>페이지라인수</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="board_page_line" value="" maxlength="2" class="input01" onKeyDown="onlyNumber(this);" style="width:20px;"/>&nbsp;게시판 리스트의 게시물 갯수</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>이미지사용</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_image_flag" value="t" style="width:20px;"/>&nbsp;게시판 이미지 업로드 사용유무</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>파일사용</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_file_flag" value="t" style="width:20px;"/>&nbsp;게시판 파일 업로드 사용유무</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>링크사용</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_link_flag" value="t" style="width:20px;"/>&nbsp;게시판 링크 정보 등록 사용유무</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>글쓰기사용</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_user_flag" value="t" style="width:20px;"/>&nbsp;체크시 관리자만 글쓰기 등록 가능</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>댓글쓰기사용</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="view_comment" value="t" style="width:20px;"/>&nbsp;체크시 댓글쓰기 등록 가능</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>비밀글 쓰기 사용</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_security_flag" value="t" style="width:20px;"/>&nbsp;체크시 비밀글 쓰기 가능</td>
					</tr>
					<tr>
					<tr>
						<th class="bor_bottom01"><strong>비밀글 게시판</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_hidden_flag" value="t" style="width:20px;"/>&nbsp;체크시 글쓴 본인만 확인 가능</td>
					</tr>
						<th class="bor_bottom01"><strong>회원 목록보기 제한</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="board_auth_list" class="sec01" style="width:130px;">
								 			
                                            <option value="0">전체</option>
                                            <option value="1">로그인 회원 </option>
                                            <option value="2">모니터링 회원</option>
											<%--
                                            <option value="2">레벨2 회원 이상</option>
                                            <option value="3">레벨3 회원 이상</option>
                                            <option value="4">레벨4 회원 이상</option>
                                            <option value="5">레벨5 회원 이상</option>
                                            <option value="6">레벨6 회원 이상</option>
                                            <option value="7">레벨7 회원 이상</option>
                                            <option value="8">레벨8 회원 이상</option>
											--%>
                                            <option value="9">관리자</option>
                                            
							</select>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>회원 글보기 제한</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="board_auth_read" class="sec01" style="width:130px;">
											
                                            <option value="0">전체</option>
                                            <option value="1">로그인 회원</option>
                                            <option value="2">모니터링 회원</option>
											<%--
                                            <option value="2">레벨2 회원 이상</option>
                                            <option value="3">레벨3 회원 이상</option>
                                            <option value="4">레벨4 회원 이상</option>
                                            <option value="5">레벨5 회원 이상</option>
                                            <option value="6">레벨6 회원 이상</option>
                                            <option value="7">레벨7 회원 이상</option>
                                            <option value="8">레벨8 회원 이상</option>
											--%>
                                            <option value="9">관리자</option>
                                            
							</select>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>회원 글쓰기 제한</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="board_auth_write" class="sec01" style="width:130px;">
								 			
                                            <option value="0">전체</option>
                                            <option value="1">로그인 회원</option>
                                            <option value="2">모니터링 회원</option>
											<%--
                                            <option value="2">레벨2 회원 이상</option>
                                            <option value="3">레벨3 회원 이상</option>
                                            <option value="4">레벨4 회원 이상</option>
                                            <option value="5">레벨5 회원 이상</option>
                                            <option value="6">레벨6 회원 이상</option>
                                            <option value="7">레벨7 회원 이상</option>
                                            <option value="8">레벨8 회원 이상</option>
											--%>
                                            <option value="9">관리자</option>
                                            
							</select>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>위 텍스트</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="board_top_comments" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="fc_chk_byte(this,200);"></textarea></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>아래 텍스트</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="board_footer_comments" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="fc_chk_byte(this,200);"></textarea></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>게시판우선순위</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="board_priority" value="" maxlength="2" class="input01" style="width:20px;" onKeyDown="onlyNumber(this);" />&nbsp;생성된 게시판의 우선순위 부여</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>게시판 구분</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name='flag' value="N" checked /> 일반&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name='flag' value="P" /> 사진&nbsp;&nbsp;&nbsp;&nbsp;
					 
						<%--&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name='flag' value="V" /> 영상 --%></td>
					</tr>
					<%--
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>학과 선택</strong></th>
						<td class="bor_bottom01 pa_left">
<%
CategoryManager cate_mgr = CategoryManager.getInstance();
Vector cate_vt = cate_mgr.getCategoryListALL2("V","B","002000000000");
CategoryInfoBean cate_info = new CategoryInfoBean();
%>						
						<select name="board_ccode" class="sec01" style="width:130px;">
								<option value="" >전체</option>
								<% for(Enumeration e = cate_vt.elements(); e.hasMoreElements();) {
									com.yundara.beans.BeanUtils.fill(cate_info, (Hashtable)e.nextElement()); %>
								<option value="<%=cate_info.getCcode()%>"><%=cate_info.getCtitle() %></option>
								<%} %>
						</select>
						</td>
					</tr>
					--%>
					<input type="hidden" name="board_ccode" value="">
				</tbody>
				</table>
				 </form>
				<div class="but01">
					<a href="javascript:insertBoard();" title="저장"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="mng_boardList.jsp?mcode=<%=mcode%>" title="입력을 취소하고 이전페이지로 이동"><img src="/vodman/include/images/but_new.gif" alt="입력을 취소하고 이전페이지로 이동"/></a>
				</div>	
				
				<br/><br/>
			</div>
		</div>	
		<%@ include file="/vodman/include/footer.jsp"%>