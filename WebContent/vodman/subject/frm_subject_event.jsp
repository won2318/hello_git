<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ include file="/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
  <%@ include file="/vodman/include/top.jsp"%>
<%

	SubjectManager mgr = SubjectManager.getInstance();
	SubjectInfoBean Sin = new SubjectInfoBean();

//	Vector vt = mgr.getSubjectListDate();
	Vector vt1 = null;

	String sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">",""); 
	if(sub_idx == null){
			out.println("<script lanauage='javascript'>alert('������ �����ϴ� â�� �ݽ��ϴ�..'); self.close(); </script>");
	}
	String sub_flag = "E"; // S - ���� ,  E - �̺�Ʈ
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}

	String skin = "/subject";
	String bg_skin = "#daedfe";
	if (sub_flag.equals("E")) {
		skin = "/event";
		bg_skin = "#e2daff";
	}
	int cnt = mgr.user_count_T(sub_idx);

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
<link href="css<%=skin%>/suwon.css" rel="stylesheet" type="text/css">

</head>
<script language="javascript">
	function eventLucky(){
		var f = document.event_lucky;
		var lp = document.form1.people.value;
		var cnt = "<%=cnt%>";
		if(cnt-1 < lp-1){
			alert("������ ���� ��÷�ο��� ���� �� �����ϴ�.");return;
		}
		if(lp <= 0){
			alert("��÷�ο��� �����ϴ�. �ٽ� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");return;
		}
		if(confirm("��÷�ο� ���� "+lp+"�� �½��ϱ�?")!=0){
			f.people.value=lp;
			f.submit();
		}else{
			f.people.value ="";
			document.form1.people.value ="";
			document.form1.people.focus();
			return;
		}
	}
</script>
<%@ include file="/vodman/subject/subject_left.jsp"%> 

		<!-- ������ -->
		<div id="contents">
			<h3><span>����</span> ���</h3>
			<p class="location">������������ &gt; ���� ���� &gt; <span>�̺�Ʈ ��÷</span></p>
			<div id="content">
			
			
											<form name="form1" method="post"> 
												<!-- main start-->
 
														<table width='100%' border='0' cellspacing='0' cellpadding='5'>
															<tr >
																<td>

																<!-- ////////////////////////////////////// -->
																<%
																	Vector Vt_sub = mgr.getSubject(sub_idx);
																	String sub_title = "";
																	if (Vt_sub != null && Vt_sub.size() > 0) {
																		sub_title =  String.valueOf(Vt_sub.elementAt(1));
																	}
																%>
																<table width='100%' border='0' cellspacing='0' cellpadding='5'>
																	<tr bgcolor="<%=bg_skin%>">
																		<td>&nbsp;&nbsp;��&nbsp;<%=sub_title%></td><td align='right'> �� : <%=mgr.user_count(sub_idx)%>��&nbsp;</td>
																	</tr>
																	<tr bgcolor="<%=bg_skin%>">
																		<td>&nbsp;&nbsp;</td><td align='right'> ������ : <%=cnt%>��&nbsp;</td>
																	</tr>

																</table>
																<!-- ////////////////////////////////////// -->


																</td>
															</tr>



															<%

																Vector Vt_people = mgr.getEvent_user(sub_idx);
																if (Vt_people != null && Vt_people.size() > 0) { 

															%>
															<Tr>
																<Td>
																	<table width='100%' border='0' cellspacing='0' cellpadding='5'>	
																			<tr bgcolor="<%=bg_skin%>">
																				<td height="3" colspan='6'></td>
																			</tr>
																			<tr>
																				<td>��ȣ</td><td>�̸�</td><td>����</td><td>����ó</td><td>�̸���</td><td>������</td>
																			</tr>
																			<tr>
																				<Td colspan='6' height='1' bgcolor='<%=bg_skin%>'></td>
																			</tr>
															<%
																	for (int j = 0; j < Vt_people.size() ; j ++ ) { 
															%>
																			<Tr>
																				<td><%=j+1%></td>
																				<td><%=String.valueOf(((Vector)(Vt_people.elementAt(j))).elementAt(1))%></td>
																				<td><%=String.valueOf(((Vector)(Vt_people.elementAt(j))).elementAt(2))%></td>
																				<td><%=String.valueOf(((Vector)(Vt_people.elementAt(j))).elementAt(3))%></td>
																				<td><%=String.valueOf(((Vector)(Vt_people.elementAt(j))).elementAt(4))%></td>
																				<td><%=String.valueOf(((Vector)(Vt_people.elementAt(j))).elementAt(6))%></td>
																			</tr>
																			<tr>
																				<Td colspan='6' height='1' bgcolor='<%=bg_skin%>'></td>
																			</tr>
															<%
																	} 
															%>
																		</table>
																</td>
															</tr>
															<%
																} else{
															%>

															<tr>
																<td >��÷ �ο� : <input type="text" name="people" value=""><a href="javascript:eventLucky();"><img src="/include/skin/images/button_enter.gif" border="0"></a></td>
															</tr>
															<tr>
																<Td height='1' bgcolor='<%=bg_skin%>'></td>
															</tr>
															<tr>
																<td align="center" >��÷ ����� �����ϴ�.</td>
															</tr>

															<%
																}
															%>

														</table>
														 
										<!-- main end--> 
											</form>
											<form name="event_lucky" method="post" action="proc_subject_event.jsp">
												<input type="hidden" name="sub_idx" value="<%=sub_idx %>">
												<input type="hidden" name="sub_flag" value="<%=sub_flag %>">
												<input type="hidden" name="people" value="">
											</form> 
				</div>
				
				<br/><br/>
			</div> 
<%@ include file="/vodman/include/footer.jsp"%>

