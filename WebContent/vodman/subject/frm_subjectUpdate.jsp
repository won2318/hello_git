<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>

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
 
<%@ include file="/vodman/include/top.jsp"%>
 
 
<%
 String sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">",""); 
	if(sub_idx == null){
		out.println("<script lanauage='javascript'>alert('�̵�� �ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
	}
	String sub_flag = "S"; // S - ���� ,  E - �̺�Ʈ
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}

    SubjectManager mgr = SubjectManager.getInstance();

	 Vector Vt = mgr.getSubject(sub_idx);


//	String sub_idx = "";
	String sub_title = "";
	String sub_start = "";
	String sub_end = "";
	String sub_person = "";
	String sub_name = "";
	String sub_mf = "";
	String sub_tel = "";
	String sub_email = "";
	String sub_etc = "";
	String sub_user_on = "";
//	String sub_flag = "S";

	if (Vt != null && Vt.size() > 0 ) {
		 sub_idx = String.valueOf(Vt.elementAt(0));
		 sub_title =  String.valueOf(Vt.elementAt(1));
		 sub_start = String.valueOf(Vt.elementAt(2));
		 sub_end = String.valueOf(Vt.elementAt(3));
		 sub_person = String.valueOf(Vt.elementAt(4));
		 sub_name = String.valueOf(Vt.elementAt(5));
		 sub_mf = String.valueOf(Vt.elementAt(6));
		 sub_tel = String.valueOf(Vt.elementAt(7));
		 sub_email = String.valueOf(Vt.elementAt(8));
		 sub_etc = String.valueOf(Vt.elementAt(9));
		 sub_flag = String.valueOf(Vt.elementAt(10));
		 sub_user_on = String.valueOf(Vt.elementAt(11));

	}

%>
 <script language="JavaScript" type="text/JavaScript">
<!--
  
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

		f.action="proc_subjectUpdate.jsp?sub_idx=<%=sub_idx%>";
		f.submit();

	}
  

//-->
</script> 

<%
 mcode="0801" ;
%>
<%@ include file="/vodman/subject/subject_left.jsp"%> 

		<!-- ������ -->
		<div id="contents">
			<h3><span>����</span> ���</h3>
			<p class="location">������������ &gt; ���� ���� &gt; <span>���� ����</span></p>
			<div id="content">
 
				<br/>

				<form name="subject" method="post">
					<input type='hidden' name='sub_idx' value='<%=sub_idx%>'>
					<input type='hidden' name=sub_flag value='<%=sub_flag%>'>
					<table cellspacing="0" class="board_view" summary="�̺�Ʈ ����">
						<tr>
							<td class="bor_bottom01">����</td>
							<td class="bor_bottom01">
								<input name="sub_title" type="text" size="50" maxlength="50" class="inputG" value="<%=sub_title%>">
							</td>
						</tr>
 
						<tr>
							<td class="bor_bottom01">������</td>
							<td class="bor_bottom01" align="left" >
								<input name="sub_start" type="text" size="18" class="inputG" value="<%=sub_start%>" readonly="readonly">
								<a href="javascript:openCalendarWindow(document.subject.sub_start)">
									<img src="/vodman/include/images/but_seek.gif" border="0" align="absmiddle"></a> ~&nbsp;������
								<input name="sub_end" type="text" size="18" class="inputG" value="<%=sub_end%>" readonly="readonly">
								<a href="javascript:openCalendarWindow(document.subject.sub_end)">
									<img src="/vodman/include/images/but_seek.gif" border="0" align="absmiddle">
								</a>
							</td>
						</tr>
						<tr>
								<td class="bor_bottom01">�ο��� ����</td>
								<td class="bor_bottom01 pa_left">
									<input name="sub_person" type="text" size="10" value='<%=sub_person%>'  > �� (0�ϰ�� ������ �����ϴ�.)
									 
								</td>
							</tr>
							<tr>
								<td class="bor_bottom01">�Ǹ��������</td>
								<td class="bor_bottom01 pa_left">
									<input name="sub_user_on" type="radio"  value='Y' <%if (sub_user_on.equals("Y")) out.println("checked"); %>> ��� &nbsp;&nbsp;
									<input name="sub_user_on" type="radio"  value='N' <%if (sub_user_on.equals("N")) out.println("checked"); %>> ��� ����
									 
								</td>
							</tr>
						<tr>
							<td class="bor_bottom01">����� ����</td>
							<td class="bor_bottom01">
								<input type='checkbox' name='sub_name' value='Y' <% if (sub_name.equals("Y")) { out.println("checked"); } %>> ����� �̸�&nbsp;&nbsp;
								<input type='checkbox' name='sub_mf' value='Y' <% if (sub_mf.equals("Y")) { out.println("checked"); } %>> ����&nbsp;&nbsp;
								<input type='checkbox' name='sub_tel' value='Y' <% if (sub_tel.equals("Y")) { out.println("checked"); } %>> ����ó&nbsp;&nbsp;
								<input type='checkbox' name='sub_email' value='Y' <% if (sub_email.equals("Y")) { out.println("checked"); } %>> �̸���&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td class="bor_bottom01">���� ����</td>
							<td class="bor_bottom01"><textarea name="sub_etc" cols="60" rows="6"><%=sub_etc%></textarea>
							</td>
						</tr>

						<tr>
							<td colspan=2 align=center>
                                <table border="0" cellspacing="0" cellpadding="5">
                                	<tr>
										<td><a href="javascript:sub_question();"><img src="/vodman/include/images/but_save.gif" border="0"></a></td>
										<td><a href="javascript:subject.reset();"><img src="/vodman/include/images/but_cancel.gif" border="0"></a></td>
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