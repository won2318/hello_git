<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
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
	 * @description : �˾� ��� table.
	 * date : 2009-10-15
	 */
	PopupInfoBean pinfo = new PopupInfoBean();
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
	function chkForm(form) {
		
		
		if(form.title.value == "") {
			alert("������ �Է����ּ���.");
			form.title.focus();
			return;
		}
		if(form.rstime.value =="") {
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
	
	function add_img(seq) {
	    if(seq == "") {
	        alert("�߸��� �����Դϴ�.");
	        return;
	    }
	    window.open("proc_popUpdateImg.jsp?seq=" +seq, "", "width=400,height=200,scrollbars=0,status=0");
	}
	
	
	function del_img(seq) {
	    if(seq == "") {
	        alert("�߸��� �����Դϴ�.");
	        return;
	    }
	    window.open("proc_popDeleteImg.jsp?seq=" +seq, "", "width=400,height=200,scrollbars=0,status=0");
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
		<form name='frmpop' method='post' action="proc_popAdd.jsp?mcode=<%=mcode%>" enctype="multipart/form-data">
		<table cellspacing="0" class="board_view" summary="�˾�����">
		<caption>�˾�����</caption>
		<colgroup>
			<col width="15%"/>
			<col/>
		</colgroup>
		<tbody class="bor_top03">
			<tr class="height_25">
				<th class="bor_bottom01 back_f7"><strong>����</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="title" maxlength="200" value="" class="input01" style="width:500px;" onkeyup="checkLength(this,200)" /></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>�ԽñⰣ</strong></th>
				<td class="bor_bottom01 pa_left">������: <input type="text" name="rstime" value="" class="input01" style="width:80px;"   maxlength="10" readonly="readonly" /></input>
						<a href="javascript:openCalendarWindow(document.frmpop.rstime)" title="ã�ƺ���"><img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���"/></a>&nbsp;~&nbsp;
						������:<input type="text" name="retime" value="" class="input01" style="width:80px;"   maxlength="10"  readonly="readonly" />
						<a href="javascript:openCalendarWindow(document.frmpop.retime)" title="ã�ƺ���"><img src="/vodman/include/images/but_seek.gif" alt="ã�ƺ���"/></a></td>
			</tr>
 
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>ũ��</strong></th>
				<td class="bor_bottom01 pa_left">���� : <input type="text" name="width" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" />&nbsp;&nbsp;&nbsp;&nbsp;���� : <input type="text" name="height" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" /></td>
			</tr>
			
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>��ǥ</strong></th>
				<td class="bor_bottom01 pa_left">X��ǥ : <input type="text" name="pos_x" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" />&nbsp;&nbsp;&nbsp;&nbsp;Y��ǥ : <input type="text" name="pos_y" maxlength="5" value="" class="input01" style="width:50px;" onKeyDown="onlyNumber(this);" /></td>
			</tr>
 
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>�˾� ����̹���</strong></th>
				<td class="bor_bottom01 pa_left"><input type="file" name="img_name" value="" class="input01" style="width:300px;"/>
				<br/> * �˾��� �̹��� ������� 525 x 267�Դϴ�.
				</td>
			</tr>
<!-- 			<tr class="height_25 font_127"> -->
<!-- 				<th class="bor_bottom01 back_f7"><strong>����Ͽ� �̹���</strong></th> -->
<!-- 				<td class="bor_bottom01 pa_left"><input type="file" name="img_name_mobile" value="" class="input01" style="width:300px;"/> -->
<!-- 				<br/> * �̹��� ������� 320 x 64 �Դϴ�. -->
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>��뿩��</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="is_visible" value="Y" checked /> ���&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="is_visible" value="N" /> ������</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>ǥ����</strong></th>
				<td class="bor_bottom01 pa_left"><input type="radio"  name="pop_flag" value="P" checked /> ��â �˾�&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="M" /> ����ȭ�� �˾���&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="C" />����ȭ�� �̽�(���̾��˾�)&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pop_flag" value="D" />����ȭ�� �̽�(��â)
				</td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>����</strong></th>
				<td class="bor_bottom01 pa_left"><textarea name="content" class="input01" style="width:600px;height:150px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"></textarea></td>
			</tr>
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>�˾� �̹��� ��ũ</strong></th>
				<td class="bor_bottom01 pa_left"><input type="text" name="pop_link" maxlength="200" value="" class="input01" style="width:500px;"/></td>
			</tr>
			<input type="hidden" name="pop_level" value="0" />
			<%--
			<tr class="height_25 font_127">
				<th class="bor_bottom01 back_f7"><strong>���� ����</strong></th>
				<td class="bor_bottom01 pa_left">
					<select name="pop_level" class="sec01" style="width:130px;">
						<option value="0">��ü</option>
						<option value="1">�α��� ȸ��</option>
					</select>
				</td>
			</tr>
			--%>
		</tbody>
		</table>
		</form>
		<div class="but01">
			<a href="javascript:chkForm(document.frmpop);"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
			<a href="frm_popList.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
		</div>
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>

