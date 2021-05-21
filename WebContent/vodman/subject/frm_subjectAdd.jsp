<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
 
<%@ include file="/vodman/include/top.jsp"%>
 
<%
if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	request.setCharacterEncoding("euc-kr");
 %>
 <script language="JavaScript" type="text/JavaScript">
<!--
 
function goPage(v_pageNo , v_pageSize){
    var f = document.form1;
    f.pageNo.value = v_pageNo;
    f.pageSize.value = v_pageSize;
    f.action = "list_admin_member.jsp";
    f.target = "_self";
    f.submit();
}

	var calendar=null;
	
	/*��¥ hidden Type ���*/
	var dateField;
	
	/*��¥ text Type ���*/
	var dateField2;
		
	function openCalendarWindow(elem){
		dateField = elem;
		dateField2 = elem;
	
		if (!calendar) {
			calendar = window.open('/vodman/subject/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		} else if (!calendar.closed) {
			calendar.focus();
		} else {
			calendar = window.open('/vodman/subject/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		}
	}
	function sub_question(){
		var f = document.subject;
		if(f.sub_title.value == ""){
			alert("������ �Է� �ϼ���!");
			f.sub_title.focus();
			return;
		}
		
		
		if(f.sub_start.value == ""){
			alert("�������� �Է� �ϼ���!");
			f.sub_start.focus();
			return;
		}
		if(f.sub_end.value == ""){
			alert("�������� �Է� �ϼ���!");
			f.sub_end.focus();
			return;
		}
		
		document.subject.submit();

	}
	
	function isOnlyNumberNotMessage(obj) {
		var str = obj.value;
		var chkstr = "0123456789";    
		for ( var i=0 ; i<str.length ; i++ ) {
			if ( chkstr.indexOf(str.substring(i, i+1)) == -1) {
				obj.focus();
				obj.select();
				return false;
			}
		}
		return true;
	}

 

function submitQuest() {
	var form = document.quest;
    if(document.quest.content.value == "") {
        alert("���� ������ �Է��ϼ���.");
        return;
    }
    if(!form.rstime1.value || !form.rstime2.value ||!form.rstime3.value || !form.rstime4.value || !form.rstime5.value) {
		alert("�����Ͻø� �Է����ּ���.");
		form.rstime1.focus();
		return false;
	}

	if(!form.retime1.value || !form.retime2.value ||!form.retime3.value || !form.retime4.value || !form.retime5.value) {
		alert("�����Ͻø� �Է����ּ���.");
		form.retime1.focus();
		return false;
	}
    document.quest.submit();
}

//-->
</script> 

<%
 
	String sub_flag = "S"; // S - ���� ,  E - �̺�Ʈ
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag");
	}
 
%>
<%@ include file="/vodman/subject/subject_left.jsp"%> 

		<!-- ������ -->
		<div id="contents">
			<h3><span>����</span> ���</h3>
			<p class="location">������������ &gt; ���� ���� &gt; <span>���� ���</span></p>
			<div id="content">
 
				<br/>

				<form name="subject" method="post" action="proc_subjectAdd.jsp">
  
						<table cellspacing="0" class="board_view" summary="�̺�Ʈ ����">
							<tr>
								<td class="bor_bottom01">����</td>
								<td class="bor_bottom01 pa_left">
									<input name="sub_flag" type="radio"  value='S' <%if (sub_flag != null && sub_flag.equals("S")) out.println("checked"); %>> ���� &nbsp;&nbsp;
									<input name="sub_flag" type="radio"  value='H' <%if (sub_flag != null && sub_flag.equals("H")) out.println("checked"); %>> �ּ��� &nbsp;&nbsp;
									<input name="sub_flag" type="radio"  value='E' <%if (sub_flag != null && sub_flag.equals("E")) out.println("checked"); %>> �̺�Ʈ
									 
								</td>
							</tr>
							<tr>
								<td class="bor_bottom01">����</td>
								<td class="bor_bottom01 pa_left">
									<input name="sub_title" type="text" size="50" maxlength="50" class="inputG">
								</td>
							</tr>
 
							<tr>
								<td class="bor_bottom01">������</td>
								<td class="bor_bottom01 pa_left" align="left" >
									<input name="sub_start" type="text" size="18" class="inputG" value="" readonly="readonly">
									<a href="javascript:openCalendarWindow(document.subject.sub_start)">
										<img src="/vodman/include/images/but_seek.gif" border="0" align="absmiddle"></a> ~&nbsp;������
									<input name="sub_end" type="text" size="18" class="inputG" value="" readonly="readonly">
									<a href="javascript:openCalendarWindow(document.subject.sub_end)">
										<img src="/vodman/include/images/but_seek.gif" border="0" align="absmiddle">
									</a>
								</td>
							</tr>
							<tr>
								<td class="bor_bottom01">�ο��� ����</td>
								<td class="bor_bottom01 pa_left">
									<input name="sub_person" type="text" size="10" value='0' > �� (0�ϰ�� ������ �����ϴ�.)
									 
								</td>
							</tr>
							<tr>
								<td class="bor_bottom01">�Ǹ��������</td>
								<td class="bor_bottom01 pa_left">
									<input name="sub_user_on" type="radio"  value='Y' checked> ��� &nbsp;&nbsp;
									<input name="sub_user_on" type="radio"  value='N' > ��� ����
									 
								</td>
							</tr>
							<tr>
								<td class="bor_bottom01">����� ����</td>
								<td class="bor_bottom01 pa_left">
									<input type='checkbox' name='sub_name' value='Y' > ����� �̸�&nbsp;&nbsp;
									<input type='checkbox' name='sub_mf' value='Y'  > ����&nbsp;&nbsp;
									<input type='checkbox' name='sub_tel' value='Y' > ����ó&nbsp;&nbsp;
									<input type='checkbox' name='sub_email' value='Y' > �̸���&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<td class="bor_bottom01">���� ����</td>
								<td class="bor_bottom01 pa_left"><textarea name="sub_etc" cols="60" rows="6"></textarea>
								</td>
							</tr>

							<tr>
								<td colspan=2 align=center>
	                                            <table border="0" cellspacing="0" cellpadding="5">
	                                            	<tr>
											<td><a href="javascript:sub_question();"><img src="/vodman/include/images/but_save.gif" border="0"></a></td>
											<td><a href="javascript:subject.reset();"><img src="/vodman/include/images/but_cancel.gif"  border="0"></a></td>
										</tr>
									</table>
								<td>
							</tr>
						</table>
						</form>
 
				</div>
				
				<br/><br/>
			</div>
		 
		
<%@ include file="/vodman/include/footer.jsp"%>