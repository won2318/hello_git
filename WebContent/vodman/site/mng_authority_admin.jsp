
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
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
	 * @description : 관리자 권한관리.
	 * date : 2009-10-15
	 */


	AuthManagerBean mgr = AuthManagerBean.getInstance();
    Vector v = mgr.getAuthInfo();			// 예약형미디어정보
	MenuAuthInfo info = new MenuAuthInfo();

	try {
		Enumeration e = v.elements();
        com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());

	} catch (Exception e) {
        System.out.println(e.getMessage());
    }


%>
<%@ include file="/vodman/include/top.jsp"%>
<%@ include file="/vodman/site/site_left.jsp"%>

<div id="contents">
	<h3><span>권한</span>관리(관리자)</h3>
	<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>권한관리(관리자)</span></p>
	<div id="content">
		<!-- 내용 -->
		<form name='frmSkin' method='post' action="proc_authority_admin.jsp">
			<input type="hidden" name="mcode" value="<%=mcode%>">
		<table cellspacing="0" class="autho_list" summary="권한관리(관리자)">
		<caption>권한관리(관리자)</caption>
		<colgroup>
			<col/>
			<col width="8%"/>
			<col width="10%"/>
			<col width="8%"/>
			<col width="10%"/>
			<col width="5%"/>
			<col width="10%"/>
			<col width="5%"/>
			<col width="10%"/>
			<col width="8%"/>
			<col width="10%"/>
		</colgroup>
		<tbody class="bor_top03">
			<tr class="height_35">
				<th class="bor_bottom01"><strong>사이트 관리자 권한</strong></th>
				<td class="bor_bottom01 align_right02">리스트보기</td>
				<td class="bor_bottom01">
					<select name="s_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getS_list() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getS_list() == 9 ){out.println("selected");}%>>관리자</option> 
					</select>
				</td>
				<td class="bor_bottom01 align_right02">내용보기</td>
				<td class="bor_bottom01">
					<select name="s_content" class="input01" style="width:80px;">
						<option value='1' <%if(info.getS_content() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getS_content() == 9 ){out.println("selected");}%>>관리자</option> 
					</select>
				</td>
				<td class="bor_bottom01 align_right02">쓰기</td>
				<td class="bor_bottom01">
					<select name="s_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getS_write() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getS_write() == 9 ){out.println("selected");}%>>관리자</option> 
					</select>
				</td>
				<td class="bor_bottom01 align_right02">삭제</td>
				<td class="bor_bottom01">
					<select name="s_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getS_del() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getS_del() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>메인화면 권한</strong></th>
				<td class="bor_bottom01 align_right02">리스트보기</td>
				<td class="bor_bottom01">
					<select name="be_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getBe_list() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getBe_list() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">등록</td>
				<td class="bor_bottom01">
					<select name="be_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getBe_write() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getBe_write() == 9 ){out.println("selected");}%>>관리자</option>
						
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">Player보기</td>
				<td class="bor_bottom01">
					<select name="be_player" class="input01" style="width:80px;">
						<option value='1' <%if(info.getBe_player() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getBe_player() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>카테고리 권한</strong></th>
				<td class="bor_bottom01 align_right02">리스트보기</td>
				<td class="bor_bottom01">
					<select name="cate_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getCate_list() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getCate_list() == 9 ){out.println("selected");}%>>관리자</option>
						
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">등록</td>
				<td class="bor_bottom01">
					<select name="cate_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getCate_write() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getCate_write() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">삭제</td>
				<td class="bor_bottom01">
					<select name="cate_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getCate_del() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getCate_del() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>VOD 권한</strong></th>
				<td class="bor_bottom01 align_right02">리스트보기</td>
				<td class="bor_bottom01">
					<select name="v_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getV_list() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getV_list() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">내용보기</td>
				<td class="bor_bottom01">
					<select name="v_content" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getV_content() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getV_content() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">등록</td>
				<td class="bor_bottom01">
					<select name="v_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getV_write() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getV_write() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">삭제</td>
				<td class="bor_bottom01">
					<select name="v_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getV_del() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getV_del() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">Player보기</td>
				<td class="bor_bottom01">
					<select name="v_player" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getV_player() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getV_player() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
			</tr>
			<input type="hidden" name="p_write" value="9">
			<input type="hidden" name="p_list" value="9">
			<input type="hidden" name="p_del" value="9">
			<input type="hidden" name="p_content" value="9">
			
			<tr class="height_35">
				<th class="bor_bottom01"><strong>생방송 권한</strong></th>
				<td class="bor_bottom01 align_right02">리스트보기</td>
				<td class="bor_bottom01">
					<select name="r_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getR_list() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getR_list() == 9 ){out.println("selected");}%>>관리자</option>
						
					</select>
				</td>
				<td class="bor_bottom01 align_right02">내용보기</td>
				<td class="bor_bottom01">
					<select name="r_content" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getR_content() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getR_content() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">등록</td>
				<td class="bor_bottom01">
					<select name="r_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getR_write() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getR_write() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">삭제</td>
				<td class="bor_bottom01">
					<select name="r_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getR_del() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getR_del() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">Player보기</td>
				<td class="bor_bottom01">
					<select name="r_player" class="input01" style="width:80px;">
						<option value='1' <%if(info.getR_player() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getR_player() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>회원관리 권한</strong></th>
				<td class="bor_bottom01 align_right02">리스트보기</td>
				<td class="bor_bottom01">
					<select name="m_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getM_list() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getM_list() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">등록</td>
				<td class="bor_bottom01">
					<select name="m_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getM_write() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getM_write() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">삭제</td>
				<td class="bor_bottom01">
					<select name="m_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getM_del() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getM_del() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>게시판 권한</strong></th>
				<td class="bor_bottom01 align_right02">리스트보기</td>
				<td class="bor_bottom01">
					<select name="b_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getB_list() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getB_list() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">내용보기</td>
				<td class="bor_bottom01">
					<select name="b_content" class="input01" style="width:80px;">
						<option value='1' <%if(info.getB_content() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getB_content() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">쓰기</td>
				<td class="bor_bottom01">
					<select name="b_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getB_write() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getB_write() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">삭제</td>
				<td class="bor_bottom01">
					<select name="b_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getB_del() == 1){out.println("selected");}%>>일반회원</option>
						<option value='9' <%if(info.getB_del() == 9 ){out.println("selected");}%>>관리자</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			
			<input type="hidden" name="menu_write" value="9">
			<input type="hidden" name="menu_list" value="9">
			<input type="hidden" name="menu_del" value="9">
			<input type="hidden" name="p_write" value="9">
			<input type="hidden" name="p_list" value="9">
			<input type="hidden" name="p_del" value="9">
			<input type="hidden" name="p_content" value="9">
		</tbody>
		</table>
		</form>
		<div class="but01">
			<a href="javascript:document.frmSkin.submit();"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
		</div>	
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>