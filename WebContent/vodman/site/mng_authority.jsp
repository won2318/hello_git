<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>


<%
	/**
	 * @author ������
	 *
	 * @description : ����� ���Ѱ���.
	 * date : 2009-10-15
	 */


	AuthManager mgr = AuthManager.getInstance();
    Vector v = mgr.getAuthInfo();			// �������̵������
	AuthInfoBean info = new AuthInfoBean();

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
	<h3><span>����</span>����(����)</h3>
	<p class="location">������������ &gt; ����Ʈ���� &gt; <span>���Ѱ���(����)</span></p>
	<div id="content">
	<!-- ���� -->
	<form name='frmSkin' method='post' action="proc_authority.jsp">
		<input type="hidden" name="mcode" value="<%=mcode%>">
		<table cellspacing="0" class="autho_list" summary="���Ѱ���(����)">
		<caption>���Ѱ���(����)</caption>
		<colgroup>
			<col/>
			<col width="9%"/>
			<col width="12%"/>
			<col width="6%"/>
			<col width="12%"/>
			<col width="9%"/>
			<col width="12%"/>
			<col width="9%"/>
			<col width="15%"/>
		</colgroup>
		<tbody class="bor_top03">
			<tr class="height_35">
				<th class="bor_bottom01"><strong>����� ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="r_list" class="sec01 " style="width:100px;">
						<option value="0" <%if(info.getR_list() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getR_list() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getR_list() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="r_content" class="sec01" style="width:100px;">
						<option value="0" <%if(info.getR_content() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getR_content() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getR_content() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">Player����</td>
				<td class="bor_bottom01">
					<select name="r_player" class="sec01" style="width:100px;">
						<option value="0" <%if(info.getR_player() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getR_player() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getR_player() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>VOD ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="v_list" class="sec01 " style="width:100px;" onchange="document.frmSkin.v_content.value=this.value;document.frmSkin.v_player.value=this.value;">
						<option value="0" <%if(info.getV_list() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getV_list() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getV_list() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="v_content" class="sec01" style="width:100px;" onchange="document.frmSkin.v_list.value=this.value;document.frmSkin.v_player.value=this.value;">
						<option value="0" <%if(info.getV_content() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getV_content() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getV_content() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">Player����</td>
				<td class="bor_bottom01">
					<select name="v_player" class="sec01" style="width:100px;" onchange="document.frmSkin.v_content.value=this.value;document.frmSkin.v_list.value=this.value;">
						<option value="0" <%if(info.getV_player() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getV_player() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getV_player() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>�Խ��� ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="b_list" class="sec01 " style="width:100px;">
						<option value="0" <%if(info.getB_list() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getB_list() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getB_list() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="b_content" class="sec01" style="width:100px;">
						<option value="0" <%if(info.getB_content() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getB_content() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getB_content() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}
												--%>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">�Խù�����</td>
				<td class="bor_bottom01">
					<select name="b_write" class="sec01" style="width:100px;">
					
						<option value="0" <%if(info.getB_write() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getB_write() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getB_write() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}--%>
												
					</select>
				</td>
				<td class="bor_bottom01 align_right02">�Խù�����</td>
				<td class="bor_bottom01">
					<select name="b_del" class="sec01" style="width:100px;">
					
						<option value="0" <%if(info.getB_del() == 0) {out.println("selected");}%>>��ü</option>
						<option value="1" <%if(info.getB_del() == 1) {out.println("selected");}%>>�α��� ȸ��</option>
						<%--
													for(int i=0; i<=9; i++){
                                                        if(info.getB_del() == i) {
                                                            out.println("<option value='" +i+ "' selected>" +i+ "</option>");
                                                        } else {
                                                            out.println("<option value='" +i+ "'>" +i+ "</option>");
                                                        }
													}--%>
												
					</select>
				</td>
			</tr>
			
		</tbody>
		</table>
		</form>
		<div class="but01">
			<a href="javascript:document.frmSkin.submit();"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
		</div>	
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>