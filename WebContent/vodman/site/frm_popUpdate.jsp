<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
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
	 * @description : �˾� update.
	 * date : 2009-10-15
	 */

	int seq = 0;
	if (Integer.parseInt(request.getParameter("seq")) == 0 || request.equals("")) {
		out.println("<script lanauage='javascript'>alert('�˾��ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); window.close(); </script>");
	} else {
		if (TextUtil.isNumeric(request.getParameter("seq")) == true) {
			try{
				seq = Integer.parseInt(request.getParameter("seq"));
			}catch(Exception e){
				seq = 0;
			}			
		} else {
			out.println("<script lanauage='javascript'>alert('�˾��ڵ尡 �߸��Ǿ����ϴ�. �ٽ� �������ּ���.'); window.close(); </script>");
		}
	}
	PopupInfoBean qinfo = new PopupInfoBean();

	String title = "";
	String width = "";
	String height = "";
	String content = "";
	String pop_link = "";
	String is_visible = "";
	String img_name = "";
	String img_name_mobile = "";
	String pos_x = "";
	String pos_y = "";
	int pop_level = 0;
	String rstime ="";
	String retime ="";
	String pop_flag="";

	PopupManager mgr = PopupManager.getInstance();
	Vector vt = mgr.getPop(seq);

	// getPopup()���� ���� ������ �ѷ��ִ� �޼ҵ�
	if (vt != null && vt.size() > 0) {
//		seq = Integer.valueOf(seq); // �˾� ����
		title = String.valueOf(vt.elementAt(1)); // �˾�â ����
		img_name = String.valueOf(vt.elementAt(9)); // �˾�â �̹���
		img_name_mobile = String.valueOf(vt.elementAt(15)); // ����Ͽ� �̹���
		qinfo.setImg_name(img_name);
		qinfo.setImg_name_mobile(img_name_mobile);
		width = String.valueOf(vt.elementAt(4)); // �˾�â ����
		height = String.valueOf(vt.elementAt(5)); // �˾�â ����
		content = String.valueOf(vt.elementAt(3)); // �˾���
		pop_link = String.valueOf(vt.elementAt(8)); // �˾� ��ũ
		is_visible = String.valueOf(vt.elementAt(6));//ȭ�����
		pos_x = String.valueOf(vt.elementAt(10));//X ������ǥ
		pos_y = String.valueOf(vt.elementAt(11));//Y ������ǥ
		pop_flag = String.valueOf(vt.elementAt(12));//�˾�â ���� ����
		try{
			pop_level = Integer.parseInt(String.valueOf(vt.elementAt(7))); // �˾� ����
		}catch(Exception ex){
		}
		rstime = String.valueOf(vt.elementAt(13)); // ������
		retime = String.valueOf(vt.elementAt(14)); // ������
	} else {
		out.println("<script lanauage='javascript'>alert('�˾��ڵ忡 �ش��ϴ� ������ �����ϴ�. �ٽ� �������ּ���.'); window.close(); </script>");
	}
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
	function chkForm(form) {
		
		
		if(form.title.value == "") {
			alert("������ �Է����ּ���.");
			form.title.focus();
			return;
		}
		if(form.rstime.value == "") {
			alert("�Խ� �������ڸ� �Է����ּ���.");
			form.rstime.focus();
			return;
		}
	
		//if(form.width.value == "") {
		//	alert("���̸� �Է����ּ���.");
		//	form.width.focus();
		//	return;
		//}
	
		//if(form.height.value == "") {
		//	alert("���̸� �Է����ּ���.");
		//	form.height.focus();
		//	return;
		//}
	
		//if(form.img_name.value == "") {
		//	alert("��� �̹����� �Է����ּ���.");
		//	form.img_name.focus();
		//	return;
		//}
	
//		if(form.content.value == "") {
//			alert("������ �Է����ּ���.");
//			form.content.focus();
//			return;
//		}
	
		//if(!form.pop_link.value) {
		//	alert("�˾���ũ�� �Է����ּ���.");
		//	form.pop_link.focus();
		//	return false;
		//}
	
		// if(!form.pop_level.value) {
			// alert("������ �Է����ּ���.");
			// form.pop_level.focus();
			// return;
		// }
		if(confirm("�����Ͻðڽ��ϱ�?") == false) {
			return;
		}
		form.submit();
	}
	
	function add_img(seq,gubun) {
	    if(seq == "") {
	        alert("�߸��� �����Դϴ�.");
	        return;
	    }
	    window.open("proc_popUpdateImg.jsp?seq=" +seq+"&gubun="+gubun, "", "width=550,height=160,scrollbars=0,status=0");
	}
	
	
	function del_img(seq,gubun) {
	    if(seq == "") {
	        alert("�߸��� �����Դϴ�.");
	        return;
	    }
	    window.open("proc_popDeleteImg.jsp?seq=" +seq+"&gubun="+gubun, "", "width=400,height=200,scrollbars=0,status=0");
	}
	//////////////////////////////////////////////////////
	//�޷� open window event 
	//////////////////////////////////////////////////////
	
	var calendar=null;
	
	/*��¥ hidden Type ���*/
	var dateField;
	
	/*��¥ text Type ���*/
	var dateField2;
	
	function openCalendarWindow(elem) 
	{
		dateField = elem;
		dateField2 = elem;
	
		if (!calendar) {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		} else if (!calendar.closed) {
			calendar.focus();
		} else {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		}
	}
	
	
</script>

<%@ include file="/vodman/best/best_left.jsp"%>

<div id="contents">
	<h3><span>�˾�</span>����</h3>
	<p class="location">������������ &gt; ����ȭ����� &gt; �˾����� &gt; <span>�˾��Է�</span></p>
 
	<div id="content">
		<!-- ���� -->
		<form name='frmpop' method='post' action="proc_popUpdate.jsp">
			<input type="hidden" name="seq" value="<%=seq%>">
			<input type="hidden" name="mcode" value="<%=mcode%>">
		<table cellspacing="0" class="board_view" summary="�˾�����">
		<caption>�˾�����</caption>
		<colgroup>
			<col width="15%"/>
			<col/>
		</colgroup>
		<tbody class="bor_top03">
			<tr class="height_25">
				<th class="bor_bottom01 back_f7"><strong>����</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="title" maxlength="200" value="<%=title%>" class="input01" style="width:500px;"  onkeyup="checkLength(this,200)" /></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>�ԽñⰣ</strong></th>
				<td class="bor_bottom01 pa_left">������: <input type="text" name="rstime" value="<%=rstime%>" class="input01" style="width:80px;" onKeyDown="onlyNumber(this);" maxlength="10" readonly="readonly" />
						<a href="javascript:openCalendarWindow(document.frmpop.rstime)" title="ã�ƺ���"><img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���"/></a>&nbsp;~&nbsp;
						������:<input type="text" name="retime" value="<%=retime%>" class="input01" style="width:80px;" onKeyDown="onlyNumber(this);" maxlength="10" readonly="readonly" />
						<a href="javascript:openCalendarWindow(document.frmpop.retime)" title="ã�ƺ���"><img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���"/></a></td>
			</tr>
 
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>ũ��</strong></th>
				<td class="bor_bottom01 pa_left">���� : <input type="text" name="width" maxlength="5" value="<%=width%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/>&nbsp;&nbsp;&nbsp;&nbsp;���� : <input type="text" name="height" maxlength="5" value="<%=height%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>��ǥ</strong></th>
				<td class="bor_bottom01 pa_left">X��ǥ : <input type="text" name="pos_x" maxlength="5" value="<%=pos_x%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/>&nbsp;&nbsp;&nbsp;&nbsp;Y��ǥ : <input type="text" name="pos_y" maxlength="5" value="<%=pos_y%>" class="input01" style="width:50px;"  onKeyDown="onlyNumber(this);"/></td>
			</tr>
 			
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>�˾� ����̹���</strong></th>
				<td class="bor_bottom01 pa_left">
					<input type="hidden" name="img_name" value="<%=img_name %>">
<%if (qinfo.getImg_name().equals("")|| qinfo.getImg_name() == null || (qinfo.getImg_name() != null && qinfo.getImg_name().equals("null"))) {%> 
					<a href="javascript:add_img('<%=seq%>','1');" title="�̹��� �߰�"><img src="/vodman/include/images/but_imgaddi.gif" alt="�̹����߰�"/></a> 
<%} else {
	String imgTmp = qinfo.getImg_name();
	imgTmp = java.net.URLEncoder.encode(imgTmp, "EUC-KR");
	imgTmp = "/upload/popup/" + imgTmp.replace("+", "%20");
	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();
	File file = new File(DirectoryNameManager.VODROOT+imgTmp);
	if(!file.exists()) {
		imgTmp = "/vodman/include/images/no_img01.gif";
	}
%> 
					<img src="<%=imgTmp%>" alt="����̹���" class="img_style01"/><br/>
					<a href="javascript:del_img('<%=seq%>','1');" title="�̹�������"><img src="/vodman/include/images/but_imgdel.gif" alt="�̹�������"/></a>
<%}%>
					<br/><br/> �˾��� �̹��� ������� 525 x 267�Դϴ�.<br/>����̹��� ���� ����̹����� ���� �ʹ� ���ϰų� �Էµ� ����� ��ĥ��� ������ �� ������ ������ �ֽ��ϴ�.
				</td>
			</tr>
 
<%-- 
 			
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>����Ͽ� �̹���</strong></th>
				<td class="bor_bottom01 pa_left">
					<input type="hidden" name="img_name_mobile" value="<%=img_name_mobile %>">
					<%=qinfo.getImg_name_mobile() %>
<%if (qinfo.getImg_name_mobile().equals("")|| qinfo.getImg_name_mobile() == null || (qinfo.getImg_name_mobile() != null && qinfo.getImg_name_mobile().equals("null"))) {%> 
					<a href="javascript:add_img('<%=seq%>','2');" title="�̹��� �߰�"><img src="/vodman/include/images/but_imgaddi.gif" alt="�̹����߰�"/></a> 
<%} else {
	String imgTmp = qinfo.getImg_name_mobile();
	imgTmp = java.net.URLEncoder.encode(imgTmp, "EUC-KR");
	imgTmp = "/upload/popup/" + imgTmp.replace("+", "%20");
	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();
	File file = new File(DirectoryNameManager.VODROOT+imgTmp);
	if(!file.exists()) {
		imgTmp = "/vodman/include/images/no_img01.gif";
	}
%> 
					<img src="<%=imgTmp%>" alt="mobile�� �̹���" class="img_style01"/><br/>
					<a href="javascript:del_img('<%=seq%>','2');" title="�̹�������"><img src="/vodman/include/images/but_imgdel.gif" alt="�̹�������"/></a>
<%}%>
					<br/><br/> * �̹��� ������� 320 x 64 �Դϴ�.
				</td>
			</tr>
 
--%>
 			
			<tr class="height_25 font_127">  
				<th class="bor_bottom01 back_f7"><strong>��뿩��</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="is_visible" value="Y" <%=is_visible.equals("Y") ? "checked" : ""%> /> ���&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="is_visible" value="N" <%=is_visible.equals("N") ? "checked" : ""%> /> ������</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>ǥ����</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="pop_flag" value="P" <%=pop_flag.equals("P") ? "checked" : ""%> /> ��â �˾�&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="M" <%=pop_flag.equals("M") ? "checked" : ""%>/> ����ȭ�� �˾���&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="C" <%=pop_flag.equals("C") ? "checked" : ""%>/> ����ȭ�� �̽�(���̾� �˾�)&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="D" <%=pop_flag.equals("D") ? "checked" : ""%>/> ����ȭ�� �̽�(��â)</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>����</strong></th>
				<td class="bor_bottom01 pa_left"><textarea name="content" id="content" class="input01" style="width:600px;height:150px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"><%=content%></textarea></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>�˾� �̹��� ��ũ</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="pop_link" maxlength="200" value="<%=pop_link %>" class="input01" style="width:500px;"/></td>
			</tr>
			<input type="hidden" name="pop_level" value="0">
			<%--
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>���� ����</strong></th>
				<td class="bor_bottom01 pa_left">
					<select name="pop_level" class="sec01" style="width:130px;">
						<option value="0" <%if(pop_level == 0) {out.println("selected='selected'");}%>>��ü</option>
						<option value="1" <%if(pop_level == 1) {out.println("selected='selected'");}%>>�α��� ȸ��</option>
					</select>
				</td>
			</tr>
			--%>
		</tbody>
		</table>
		</form>
		<div class="but01">
			<a href="javascript:chkForm(document.frmpop);"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
			<a href="/vodman/site/frm_popList.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
		</div>
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>

