<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.* , com.hrlee.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	/**
	 * @author lee hee rak
	 *
	 * @description :�Խ����� ������ ���� ������ �Է��ϴ� ���Դϴ�.
	 * date : 2009-10-19
	 */

%>
<%
if(!chk_auth(vod_id, vod_level, "b_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
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
		   alert ("�Խ��� ������ �Է����� �����̽��ϴ�.")
		   f.board_title.focus();
		   return
		}
		if (f.board_page_line.value=="") {
		   alert ("������ ���μ��� �Է����� �����̽��ϴ�.")
		   f.board_page_line.focus();
		   return
		}
		if (f.board_priority.value=="") {
		   alert ("�Խ��ǿ켱������ �Է����� �����̽��ϴ�.")
		   f.board_priority.focus();
		   return
		}
		
		f.action='proc_boardAdd.jsp';
		f.submit();

	}


	function isNumber ()
	{
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert("���ڸ� �����մϴ� �ٽ� �Է��ϼ���!");
			event.returnValue=false;
		}
	}

</script>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�Խ���</span> ���</h3>
			<p class="location">������������ &gt; �Խ��ǰ��� &gt; <span>�Խ��� ���</span></p>
			<div id="content">
			<form name='frmBoard' method='post'>
			<input type="hidden" name="mcode" value="<%=mcode%>" />
				<table cellspacing="0" class="board_view" summary="�Խ���  ���">
				<caption>�Խ���  ���</caption>
				<colgroup>
					<col width="17%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03 font_127">
					<tr>
						<th class="bor_bottom01"><strong>�Խ�������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="board_title" value="" maxlength="200" class="input01" style="width:300px;" onkeyup="checkLength(this,200)"/></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>���������μ�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="board_page_line" value="" maxlength="2" class="input01" onKeyDown="onlyNumber(this);" style="width:20px;"/>&nbsp;�Խ��� ����Ʈ�� �Խù� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�̹������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_image_flag" value="t" style="width:20px;"/>&nbsp;�Խ��� �̹��� ���ε� �������</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>���ϻ��</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_file_flag" value="t" style="width:20px;"/>&nbsp;�Խ��� ���� ���ε� �������</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��ũ���</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_link_flag" value="t" style="width:20px;"/>&nbsp;�Խ��� ��ũ ���� ��� �������</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�۾�����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_user_flag" value="t" style="width:20px;"/>&nbsp;üũ�� �����ڸ� �۾��� ��� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��۾�����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="view_comment" value="t" style="width:20px;"/>&nbsp;üũ�� ��۾��� ��� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��б� ���� ���</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_security_flag" value="t" style="width:20px;"/>&nbsp;üũ�� ��б� ���� ����</td>
					</tr>
					<tr>
					<tr>
						<th class="bor_bottom01"><strong>��б� �Խ���</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_hidden_flag" value="t" style="width:20px;"/>&nbsp;üũ�� �۾� ���θ� Ȯ�� ����</td>
					</tr>
						<th class="bor_bottom01"><strong>ȸ�� ��Ϻ��� ����</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="board_auth_list" class="sec01" style="width:130px;">
								 			
                                            <option value="0">��ü</option>
                                            <option value="1">�α��� ȸ�� </option>
                                            <option value="2">����͸� ȸ��</option>
											<%--
                                            <option value="2">����2 ȸ�� �̻�</option>
                                            <option value="3">����3 ȸ�� �̻�</option>
                                            <option value="4">����4 ȸ�� �̻�</option>
                                            <option value="5">����5 ȸ�� �̻�</option>
                                            <option value="6">����6 ȸ�� �̻�</option>
                                            <option value="7">����7 ȸ�� �̻�</option>
                                            <option value="8">����8 ȸ�� �̻�</option>
											--%>
                                            <option value="9">������</option>
                                            
							</select>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>ȸ�� �ۺ��� ����</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="board_auth_read" class="sec01" style="width:130px;">
											
                                            <option value="0">��ü</option>
                                            <option value="1">�α��� ȸ��</option>
                                            <option value="2">����͸� ȸ��</option>
											<%--
                                            <option value="2">����2 ȸ�� �̻�</option>
                                            <option value="3">����3 ȸ�� �̻�</option>
                                            <option value="4">����4 ȸ�� �̻�</option>
                                            <option value="5">����5 ȸ�� �̻�</option>
                                            <option value="6">����6 ȸ�� �̻�</option>
                                            <option value="7">����7 ȸ�� �̻�</option>
                                            <option value="8">����8 ȸ�� �̻�</option>
											--%>
                                            <option value="9">������</option>
                                            
							</select>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>ȸ�� �۾��� ����</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="board_auth_write" class="sec01" style="width:130px;">
								 			
                                            <option value="0">��ü</option>
                                            <option value="1">�α��� ȸ��</option>
                                            <option value="2">����͸� ȸ��</option>
											<%--
                                            <option value="2">����2 ȸ�� �̻�</option>
                                            <option value="3">����3 ȸ�� �̻�</option>
                                            <option value="4">����4 ȸ�� �̻�</option>
                                            <option value="5">����5 ȸ�� �̻�</option>
                                            <option value="6">����6 ȸ�� �̻�</option>
                                            <option value="7">����7 ȸ�� �̻�</option>
                                            <option value="8">����8 ȸ�� �̻�</option>
											--%>
                                            <option value="9">������</option>
                                            
							</select>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>�� �ؽ�Ʈ</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="board_top_comments" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="fc_chk_byte(this,200);"></textarea></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>�Ʒ� �ؽ�Ʈ</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="board_footer_comments" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="fc_chk_byte(this,200);"></textarea></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�Խ��ǿ켱����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="board_priority" value="" maxlength="2" class="input01" style="width:20px;" onKeyDown="onlyNumber(this);" />&nbsp;������ �Խ����� �켱���� �ο�</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>�Խ��� ����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name='flag' value="N" checked /> �Ϲ�&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name='flag' value="P" /> ����&nbsp;&nbsp;&nbsp;&nbsp;
					 
						<%--&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name='flag' value="V" /> ���� --%></td>
					</tr>
					<%--
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>�а� ����</strong></th>
						<td class="bor_bottom01 pa_left">
<%
CategoryManager cate_mgr = CategoryManager.getInstance();
Vector cate_vt = cate_mgr.getCategoryListALL2("V","B","002000000000");
CategoryInfoBean cate_info = new CategoryInfoBean();
%>						
						<select name="board_ccode" class="sec01" style="width:130px;">
								<option value="" >��ü</option>
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
					<a href="javascript:insertBoard();" title="����"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
					<a href="mng_boardList.jsp?mcode=<%=mcode%>" title="�Է��� ����ϰ� ������������ �̵�"><img src="/vodman/include/images/but_new.gif" alt="�Է��� ����ϰ� ������������ �̵�"/></a>
				</div>	
				
				<br/><br/>
			</div>
		</div>	
		<%@ include file="/vodman/include/footer.jsp"%>