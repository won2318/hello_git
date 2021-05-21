<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.hrlee.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	/**
	 * @author Jong-Sung Park
	 *
	 * @description :�Խ��� ���� ������ �Է��ϴ� ���Դϴ�.
	 * date : 2009-07-16
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
<%
	int board_id =0;
	if(request.getParameter("board_id") == null || request.getParameter("board_id").length()<=0 || request.getParameter("board_id").equals("null")){
		//response.sendRedirect("mng_boardList.jsp");
		String mcode= request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardList.jsp?mcode" +mcode ;
		 if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0901";
		}
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}else{
		try{
			board_id = Integer.parseInt( String.valueOf( request.getParameter("board_id") ) );
		}catch(Exception e){
			//board_id = 0;
			String mcode= request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
			if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
				mcode = "0901";
			}
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			out.println("</SCRIPT>");

			String REF_URL="mng_boardList.jsp?mcode" +mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
		
	}
	
 
	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		String mcode= request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0901";
		}
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_boardList.jsp?mcode" +mcode ;
		%>
		<%@ include file = "/vodman/include/REF_URL.jsp"%>
		<%
		return;
	}
 
	String board_title = "";
	String board_page_line = "10";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	String flag = "";
 	String view_comment = "";
 	String board_security_flag = "";
 	String board_auth_list ="";
 	String board_auth_read ="";
 	String board_auth_write = "";
 	String board_hidden_flag="";
	if(v_bi != null && v_bi.size() >0){
 		
		board_title = String.valueOf(v_bi.elementAt(0));
		board_page_line = String.valueOf(v_bi.elementAt(1));
		board_image_flag = String.valueOf(v_bi.elementAt(2));
		board_file_flag = String.valueOf(v_bi.elementAt(3));
		board_link_flag = String.valueOf(v_bi.elementAt(4));
		board_user_flag = String.valueOf(v_bi.elementAt(5));
		board_top_comments = String.valueOf(v_bi.elementAt(6));
		board_footer_comments = String.valueOf(v_bi.elementAt(7));
		board_priority = String.valueOf(v_bi.elementAt(8));
		board_auth_list= String.valueOf(v_bi.elementAt(9));
		board_auth_read= String.valueOf(v_bi.elementAt(10));
		board_auth_write= String.valueOf(v_bi.elementAt(11));
		flag = String.valueOf(v_bi.elementAt(12));
		view_comment =  String.valueOf(v_bi.elementAt(13));
		board_security_flag =  String.valueOf(v_bi.elementAt(15));
		board_hidden_flag  =  String.valueOf(v_bi.elementAt(16));
 	
	}
	
	 

    //board_title[0], board_page_line[1], board_image_flag[2], board_file_flag[3], board_link_flag[4], board_user_flag[5]
    //board_top_comments[6], board_footer_comments[7], board_priority[8], board_auth_list[9], board_auth_read[10], board_auth_write[11]
%>


<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script language='javascript'>
	function updateBoard(){
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
		
		f.action="proc_boardUpdate.jsp?mcode=<%=mcode%>";
		f.submit();

	}


	
</script>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�Խ���</span> ����</h3>
			<p class="location">������������ &gt; �Խ��ǰ��� &gt; <span>�Խ��� ���� ����</span></p>
			<div id="content">
			<form name='frmBoard' method='post'>
                <input type="hidden" name="board_id" value="<%=board_id%>">
				<input type="hidden" name="mcode" value="<%=mcode%>">
				<table cellspacing="0" class="board_view" summary="���� ����">
				<caption>�Խ��� ���� ����</caption>
				<colgroup>
					<col width="17%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03 font_127">
					<tr>
						<th class="bor_bottom01"><strong>�Խ�������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name=board_title type=text maxlength="200" value='<%=board_title%>' class="input01" style="width:300px;" onkeyup="checkLength(this,200)" /></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>���������μ�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name=board_page_line type=text maxlength="2" value='<%=board_page_line%>' class="input01" style="width:20px;"  onKeyDown="onlyNumber(this);"/>&nbsp;�Խ��� ����Ʈ�� �Խù� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�̹������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox"name=board_image_flag value='t' <%=board_image_flag != null && board_image_flag.equals("t")?"checked":""%> style="width:20px;"/>&nbsp;�Խ��� �̹��� ���ε� �������</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>���ϻ��</strong></th>
						<td class="bor_bottom01 pa_left"><input name=board_file_flag type=checkbox value='t' <%=board_file_flag != null && board_file_flag.equals("t")?"checked":""%> style="width:20px;"/>&nbsp;�Խ��� ���� ���ε� �������</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��ũ���</strong></th>
						<td class="bor_bottom01 pa_left"><input name=board_link_flag type=checkbox value='t' <%=board_link_flag != null && board_link_flag.equals("t")?"checked":""%> style="width:20px;"/>&nbsp;�Խ��� ��ũ ���� ��� �������</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�۾�����</strong></th>
						<td class="bor_bottom01 pa_left"><input name=board_user_flag type=checkbox value='t' <%=board_user_flag != null && board_user_flag.equals("t")?"checked":""%> style="width:20px;"/>&nbsp;üũ�� �����ڸ� �۾��� ��� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��۾�����</strong></th>
						<td class="bor_bottom01 pa_left"><input name=view_comment type=checkbox value='t' <%=view_comment != null && view_comment.equals("t")?"checked":""%> style="width:20px;"/>&nbsp;üũ�� ��۾��� ��� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��б� ���� ���</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_security_flag" value="t" <%=board_security_flag != null && board_security_flag.equals("t")?"checked":""%>  style="width:20px;"/>&nbsp;üũ�� ��б� ���� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��б� �Խ���</strong></th>
						<td class="bor_bottom01 pa_left"><input type="checkbox" name="board_hidden_flag" value="t" <%=board_hidden_flag != null && board_hidden_flag.equals("t")?"checked":""%>  style="width:20px;"/>&nbsp;üũ�� �۾� ���θ� Ȯ�� ����</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>ȸ�� ��Ϻ��� ����</strong></th>
						<td class="bor_bottom01 pa_left">
							 <select name="board_auth_list" class="sec01" style="width:130px;">
							
								<option value="0" <%=board_auth_list != null && board_auth_list.equals("0") ? "selected" : ""%> >��ü</option>
								<option value="1" <%=board_auth_list != null && board_auth_list.equals("1") ? "selected" : ""%> >�α��� ȸ�� </option>
								<option value="2" <%=board_auth_list != null && board_auth_list.equals("2") ? "selected" : ""%> >����͸� ȸ�� </option>
								<%--
								<option value="2" <%=String.valueOf(v_list.elementAt(9)).equals("2") ? "selected" : ""%> >����2 ȸ�� �̻�</option>
								<option value="3" <%=String.valueOf(v_list.elementAt(9)).equals("3") ? "selected" : ""%> >����3 ȸ�� �̻�</option>
								<option value="4" <%=String.valueOf(v_list.elementAt(9)).equals("4") ? "selected" : ""%> >����4 ȸ�� �̻�</option>
								<option value="5" <%=String.valueOf(v_list.elementAt(9)).equals("5") ? "selected" : ""%> >����5 ȸ�� �̻�</option>
								<option value="6" <%=String.valueOf(v_list.elementAt(9)).equals("6") ? "selected" : ""%> >����6 ȸ�� �̻�</option>
								<option value="7" <%=String.valueOf(v_list.elementAt(9)).equals("7") ? "selected" : ""%> >����7 ȸ�� �̻�</option>
								<option value="8" <%=String.valueOf(v_list.elementAt(9)).equals("8") ? "selected" : ""%> >����8 ȸ�� �̻�</option>
								--%>
								<option value="9" <%=board_auth_list != null && board_auth_list.equals("9") ? "selected" : ""%> >������</option>
							</select>
							<%--
							<select name="pop_level" class="input01" style="width:130px;">
								<option value="0">��ü</option>
								<option value="1">����1 ȸ�� �̻�</option>
								<option value="2">����2 ȸ�� �̻�</option>
								<option value="3">����3 ȸ�� �̻�</option>
								<option value="4">����4 ȸ�� �̻�</option>
								<option value="5">����5 ȸ�� �̻�</option>
								<option value="6">����6 ȸ�� �̻�</option>
								<option value="7">����7 ȸ�� �̻�</option>
								<option value="8">����8 ȸ�� �̻�</option>
								<option value="9">����9 ȸ�� �̻�</option>
							</select>
							--%>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>ȸ�� �ۺ��� ����</strong></th>
						<td class="bor_bottom01 pa_left">
							 <select name="board_auth_read" class="sec01" style="width:130px;">
								<option value="0" <%=board_auth_read != null && board_auth_read.equals("0") ? "selected" : ""%> >��ü</option>
								<option value="1" <%=board_auth_read != null && board_auth_read.equals("1") ? "selected" : ""%> >�α��� ȸ��</option>
								<option value="2" <%=board_auth_read != null && board_auth_read.equals("2") ? "selected" : ""%> >����͸� ȸ��</option>
								<%--
								<option value="2" <%=String.valueOf(v_list.elementAt(10)).equals("2") ? "selected" : ""%> >����2 ȸ�� �̻�</option>
								<option value="3" <%=String.valueOf(v_list.elementAt(10)).equals("3") ? "selected" : ""%> >����3 ȸ�� �̻�</option>
								<option value="4" <%=String.valueOf(v_list.elementAt(10)).equals("4") ? "selected" : ""%> >����4 ȸ�� �̻�</option>
								<option value="5" <%=String.valueOf(v_list.elementAt(10)).equals("5") ? "selected" : ""%> >����5 ȸ�� �̻�</option>
								<option value="6" <%=String.valueOf(v_list.elementAt(10)).equals("6") ? "selected" : ""%> >����6 ȸ�� �̻�</option>
								<option value="7" <%=String.valueOf(v_list.elementAt(10)).equals("7") ? "selected" : ""%> >����7 ȸ�� �̻�</option>
								<option value="8" <%=String.valueOf(v_list.elementAt(10)).equals("8") ? "selected" : ""%> >����8 ȸ�� �̻�</option>
								--%>
								<option value="9" <%=board_auth_read != null && board_auth_read.equals("9") ? "selected" : ""%> >������</option>
							</select>

							
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>ȸ�� �۾��� ����</strong></th>
						<td class="bor_bottom01 pa_left">
							 <select name="board_auth_write" class="sec01" style="width:130px;">
								<option value="0" <%=board_auth_write != null && board_auth_write.equals("0") ? "selected" : ""%> >��ü</option>
								<option value="1" <%=board_auth_write != null && board_auth_write.equals("1") ? "selected" : ""%> >�α��� ȸ��</option>
								<option value="2" <%=board_auth_write != null && board_auth_write.equals("2") ? "selected" : ""%> >����͸� ȸ��</option>
								<%--
								<option value="2" <%=String.valueOf(v_list.elementAt(11)).equals("2") ? "selected" : ""%> >����2 ȸ�� �̻�</option>
								<option value="3" <%=String.valueOf(v_list.elementAt(11)).equals("3") ? "selected" : ""%> >����3 ȸ�� �̻�</option>
								<option value="4" <%=String.valueOf(v_list.elementAt(11)).equals("4") ? "selected" : ""%> >����4 ȸ�� �̻�</option>
								<option value="5" <%=String.valueOf(v_list.elementAt(11)).equals("5") ? "selected" : ""%> >����5 ȸ�� �̻�</option>
								<option value="6" <%=String.valueOf(v_list.elementAt(11)).equals("6") ? "selected" : ""%> >����6 ȸ�� �̻�</option>
								<option value="7" <%=String.valueOf(v_list.elementAt(11)).equals("7") ? "selected" : ""%> >����7 ȸ�� �̻�</option>
								<option value="8" <%=String.valueOf(v_list.elementAt(11)).equals("8") ? "selected" : ""%> >����8 ȸ�� �̻�</option>
								--%>
								<option value="9" <%=board_auth_write != null && board_auth_write.equals("9") ? "selected" : ""%> >������</option>
							</select>
						</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>�� �ؽ�Ʈ</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="board_top_comments" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="fc_chk_byte(this,200);"><%=board_top_comments%></textarea></td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>�Ʒ� �ؽ�Ʈ</strong></th>
						<td class="bor_bottom01 pa_left"><textarea name="board_footer_comments" class="input01" style="width:600px;height:50px;" cols="100" rows="100" onkeyup="fc_chk_byte(this,200);"><%=board_footer_comments%></textarea></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�Խ��ǿ켱����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="board_priority" maxlength="2" value="<%=board_priority%>" class="input01" style="width:20px;"  onKeyDown="onlyNumber(this);"/>&nbsp;������ �Խ����� �켱���� �ο�</td>
					</tr>
					<tr class="height_25 font_127">
						<th class="bor_bottom01"><strong>�Խ��� ����</strong></th>
						<td class="bor_bottom01 pa_left">
						<input type="radio" name='flag' value='N' <%=flag != null && flag.equals("N")?"checked":""%>/> 	�Ϲ�&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name='flag' value='P' <%=flag != null && flag.equals("P")?"checked":""%>/> 	����&nbsp;&nbsp;&nbsp;&nbsp;
					 
						<%--<input type="radio" name='flag' value='V' <%=String.valueOf(v_list.elementAt(12)).equals("V")?"checked":""%>/> ���� --%></td>
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
								<option value="" <%=String.valueOf(v_list.elementAt(14)).equals("") ? "selected" : ""%> >��ü</option>
								<% for(Enumeration e = cate_vt.elements(); e.hasMoreElements();) {
									com.yundara.beans.BeanUtils.fill(cate_info, (Hashtable)e.nextElement()); %>
								<option value="<%=cate_info.getCcode()%>" <%=String.valueOf(v_list.elementAt(14)).equals(cate_info.getCcode()) ? "selected" : ""%> ><%=cate_info.getCtitle() %></option>
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
					<a href="javascript:updateBoard();" title="����"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
					<a href="javascript:frmBoard.reset();" title="�ٽ��Է�"><img src="/vodman/include/images/but_new.gif" alt="�ٽ��Է�"/></a>
				</div>	
				
				<br/><br/>
			</div>
		</div>	
	<%@ include file="/vodman/include/footer.jsp"%>