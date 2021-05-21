
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>

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
	 * @description : ������ ���Ѱ���.
	 * date : 2009-10-15
	 */


	AuthManagerBean mgr = AuthManagerBean.getInstance();
    Vector v = mgr.getAuthInfo();			// �������̵������
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
	<h3><span>����</span>����(������)</h3>
	<p class="location">������������ &gt; ����Ʈ���� &gt; <span>���Ѱ���(������)</span></p>
	<div id="content">
		<!-- ���� -->
		<form name='frmSkin' method='post' action="proc_authority_admin.jsp">
			<input type="hidden" name="mcode" value="<%=mcode%>">
		<table cellspacing="0" class="autho_list" summary="���Ѱ���(������)">
		<caption>���Ѱ���(������)</caption>
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
				<th class="bor_bottom01"><strong>����Ʈ ������ ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="s_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getS_list() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getS_list() == 9 ){out.println("selected");}%>>������</option> 
					</select>
				</td>
				<td class="bor_bottom01 align_right02">���뺸��</td>
				<td class="bor_bottom01">
					<select name="s_content" class="input01" style="width:80px;">
						<option value='1' <%if(info.getS_content() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getS_content() == 9 ){out.println("selected");}%>>������</option> 
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="s_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getS_write() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getS_write() == 9 ){out.println("selected");}%>>������</option> 
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="s_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getS_del() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getS_del() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>����ȭ�� ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="be_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getBe_list() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getBe_list() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">���</td>
				<td class="bor_bottom01">
					<select name="be_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getBe_write() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getBe_write() == 9 ){out.println("selected");}%>>������</option>
						
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">Player����</td>
				<td class="bor_bottom01">
					<select name="be_player" class="input01" style="width:80px;">
						<option value='1' <%if(info.getBe_player() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getBe_player() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>ī�װ� ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="cate_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getCate_list() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getCate_list() == 9 ){out.println("selected");}%>>������</option>
						
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">���</td>
				<td class="bor_bottom01">
					<select name="cate_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getCate_write() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getCate_write() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="cate_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getCate_del() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getCate_del() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>VOD ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="v_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getV_list() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getV_list() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">���뺸��</td>
				<td class="bor_bottom01">
					<select name="v_content" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getV_content() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getV_content() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">���</td>
				<td class="bor_bottom01">
					<select name="v_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getV_write() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getV_write() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="v_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getV_del() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getV_del() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">Player����</td>
				<td class="bor_bottom01">
					<select name="v_player" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getV_player() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getV_player() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
			</tr>
			<input type="hidden" name="p_write" value="9">
			<input type="hidden" name="p_list" value="9">
			<input type="hidden" name="p_del" value="9">
			<input type="hidden" name="p_content" value="9">
			
			<tr class="height_35">
				<th class="bor_bottom01"><strong>����� ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="r_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getR_list() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getR_list() == 9 ){out.println("selected");}%>>������</option>
						
					</select>
				</td>
				<td class="bor_bottom01 align_right02">���뺸��</td>
				<td class="bor_bottom01">
					<select name="r_content" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getR_content() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getR_content() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">���</td>
				<td class="bor_bottom01">
					<select name="r_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getR_write() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getR_write() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="r_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getR_del() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getR_del() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">Player����</td>
				<td class="bor_bottom01">
					<select name="r_player" class="input01" style="width:80px;">
						<option value='1' <%if(info.getR_player() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getR_player() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>ȸ������ ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="m_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getM_list() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getM_list() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
				<td class="bor_bottom01 align_right02">���</td>
				<td class="bor_bottom01">
					<select name="m_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getM_write() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getM_write() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="m_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getM_del() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getM_del() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">&nbsp;</td>
				<td class="bor_bottom01">&nbsp;</td>
			</tr>
			<tr class="height_35">
				<th class="bor_bottom01"><strong>�Խ��� ����</strong></th>
				<td class="bor_bottom01 align_right02">����Ʈ����</td>
				<td class="bor_bottom01">
					<select name="b_list" class="input01 " style="width:80px;">
						<option value='1' <%if(info.getB_list() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getB_list() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">���뺸��</td>
				<td class="bor_bottom01">
					<select name="b_content" class="input01" style="width:80px;">
						<option value='1' <%if(info.getB_content() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getB_content() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="b_write" class="input01" style="width:80px;">
						<option value='1' <%if(info.getB_write() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getB_write() == 9 ){out.println("selected");}%>>������</option>
					</select>
				</td>
				<td class="bor_bottom01 align_right02">����</td>
				<td class="bor_bottom01">
					<select name="b_del" class="input01" style="width:80px;">
						<option value='1' <%if(info.getB_del() == 1){out.println("selected");}%>>�Ϲ�ȸ��</option>
						<option value='9' <%if(info.getB_del() == 9 ){out.println("selected");}%>>������</option>
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
			<a href="javascript:document.frmSkin.submit();"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
		</div>	
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>