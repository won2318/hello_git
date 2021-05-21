<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%


	SubjectManager mgr = SubjectManager.getInstance();
	SubjectInfoBean Sin = new SubjectInfoBean();

	Vector vt = mgr.getSubjectListDate();
	Vector vt1 = null;

if (vt != null && vt.size() > 0) {  // if (vt)
		String sub_idx = String.valueOf(vt.elementAt(0));
		String sub_name = String.valueOf(vt.elementAt(5));
		String sub_mf = String.valueOf(vt.elementAt(6));
		String sub_tel = String.valueOf(vt.elementAt(7));
		String sub_email = String.valueOf(vt.elementAt(8));

%>

<html>
<head>
<title>설문지</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/include/skin/css/suwon.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
	function checkCheckbox(frm,obj,num) {
		var str = obj.name;
		var len = frm.length;

		var chk = 0;
			for(i=0; i<len; i++) {
				if (frm[i].name == str && frm[i].checked == true) {
					chk++;
				}

				if (chk > num) {
					alert(num + "개 까지 선택할 수 있습니다.");
					obj.checked = false;
					break;
				}
		}
	}

	function go_submit() {
			var f = document.subject_user;
		
		<% if (sub_name != null && sub_name.equals("Y")) { %>
		if(f.user_name.value == ""){
				alert("이름을 입력 하세요!");
				f.user_name.focus();
			return;
		}
		<% } 
		if (sub_mf != null && sub_mf.equals("Y")) { 
		%>
			if(f.user_mf.value == ""){
				alert("성별을 선택하세요!");
				f.user_mf.focus();
			return;
			}

		<% } 
		if (sub_tel != null && sub_tel.equals("Y")) { 
		%>
			if(f.user_tel.value == ""){
				alert("연락처를 입력 하세요!");
				f.user_tel.focus();
			return;
		}

		<%
		}
		if (sub_email != null && sub_email.equals("Y")) { 
		%>
			if(f.user_email.value == ""){
				alert("이메일을 입력 하세요!");
				f.user_email.focus();
			return;
		}

		<% } %>

//		for (var i=0; i< count ; i++) {
//			var obj = eval("document.subject_user" + ".Q"+i );
//	alert(obj);
//	obj.value = "a";

//		}
		document.subject_user.submit();
	}
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='subject_user' method='post' action="proc_subject_user.jsp">
<table id="Table_01" width="600" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><img src="images/question_01.jpg" width="10" height="70" alt=""></td>
		<td><img src="images/question_02.jpg" width="580" height="70" alt=""></td>
		<td><img src="images/question_03.jpg" width="10" height="70" alt=""></td>
	</tr>
	<tr>
		<td background="images/question_04.jpg" width="10"></td>
		<td>
		<!-- 질문시작-->
		<table id="Table_01" width="580" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="images/question_05_01.jpg" width="15" height="31" alt=""></td>
				<td><img src="images/question_05_02.jpg" width="549" height="31" alt=""></td>
				<td><img src="images/question_05_03.jpg" width="16" height="31" alt=""></td>
			</tr>
			<tr>
				<td background="images/question_05_04.jpg" width="15"></td>
				<td width="549" bgcolor="daedfe" valign="top">
				<table width="549" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td height="73" align="center">
						<table width="530" border="0" cellspacing="0" cellpadding="0">

<% if (sub_name != null && sub_name.equals("Y")) { %>
						<tr> 
						  <td >&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2" width='100'>▷&nbsp;&nbsp;이름</td><td class="qu_2"><input type='text' name='user_name'></td>
							  </tr>
							</table>
							</td>
						</tr>
<% } 
if (sub_mf != null && sub_mf.equals("Y")) { 
%>
						<tr> 
						  <td >&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2" width='100'>▷&nbsp;&nbsp;성별</td><td class="qu_2"><input type="radio" name="user_mf" value="M">남 &nbsp;&nbsp;&nbsp;<input type="radio" name="user_mf" value="W">여</td>
							  </tr>
							</table>
							</td>
						</tr>
<% } 
if (sub_tel != null && sub_tel.equals("Y")) { 
%>
						<tr> 
						  <td >&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2" width='100'>▷&nbsp;&nbsp;연락처</td><td class="qu_2"><input type='text' name='user_tel'></td>
							  </tr>
							</table>
							</td>
						</tr>
<% } 
if (sub_name != null && sub_name.equals("Y")) { 
%>

						<tr> 
						  <td >&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2" width='100'>▷&nbsp;&nbsp;이메일</td><td class="qu_2"><input type='text' name='user_email'></td>
							  </tr>
							</table>
							</td>
						</tr>

<% } %>


<%
        vt1 =  mgr.getSubject_QuiestionList( sub_idx );  // sub_idx
		
		String question_idx = "";
//		String sub_idx = "";
		String question_content = "";
		String question_option = "";
		String question_info = "";
		String question_etc = "";
		String question_num = "";

		if ( vt1 != null && vt1.size() > 0){  // if (vt1)
%>
<input type='hidden' name='sub_idx' value='<%=sub_idx%>'>
<input type='hidden' name='question_count' value='<%=vt1.size()%>'>
<%
			for(int i = 0 ; i < vt1.size() ; i++){ // for (vt1)

			 question_idx = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(0));
//			 sub_idx = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(1));
			 question_content = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(2));
			 question_option = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(3));
			 question_info = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(4));
			 question_etc = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(5));
			 question_num = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(6));
	             
	    	    Vector vt2 = mgr.getSubject_AnsList( question_idx );   
				String ans_idx = "";
			//	String question_idx = "";
				String step_flag = "";
				String ans_num = "";
				String ans_content = "";
				String ans_order = "";
				String ans_etc = "";
%>
<!-- ///////////설문 (질문내용)/////////////  -->
						<tr> 
						  <td width="50" height="51" class="qu_1" valign="middle">Q <%=question_num%>.</td>
						  <% if (question_option.equals("4")) { %>
						   <input type='hidden' name="Q<%=i%>" value="option4_<%=question_idx%>">
						   <% } else if (question_option.equals("3") || question_option.equals("2")){%>
						   <input type='hidden' name="Q<%=i%>" value="option3_<%=question_idx%>">
						   <% } else if (question_option.equals("5"))  { %>
						   <input type='hidden' name="Q<%=i%>" value="option5_<%=question_idx%>">
						   <% } else {%>
						   <input type='hidden' name="Q<%=i%>" value="<%=question_idx%>">
						   <% } %>
						  <td class="qu_1" valign="middle">
						  <%if(question_option.equals("3")){out.println(question_content+"("+question_etc+"개 까지 체크해주세요.)");}else{out.println(question_content);}%></td>
						</tr>
<!-- ///////////설문 (질문내용 끝)/////////////  -->

<!-- ///////////설문 (다중반복)/////////////  -->

<%
	Vector info = new Vector();
	if (question_option.equals("4")) { // 다중선택 반복

			if (question_info != null && question_info.length() > 0) {
				StringTokenizer question_info_st = new StringTokenizer(question_info, ","); 
				while (question_info_st.hasMoreTokens()) {
						info.add(question_info_st.nextToken());
				}
			}
%>
						<tr>
							<td >&nbsp;</td>
							<td>
								<table width="480" border="0" cellspacing="0" cellpadding="0">
									<td width='280'>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="qu_2">※ 다음 선택항목 중에 선택하세요 !</td>
											</tr>
										</table>
									</td>
									<td width='200' align='right'>
										<table border="0" cellspacing="0" cellpadding="0" width='100%'>
											<tr class="qu_3_1">
											<%
											if (info != null && info.size() > 0) {
												for ( int k = 0 ; k < info.size() ; k++) {
											%>
											<td><%=info.elementAt(k) %></td>
											<% } } %>
											</tr>
										</table>
									</td>
									
								</table>
							</tD>
						</tr>
<%
    } else if (question_option.equals("5")) {  //textarea
%>
						<tr> 
						  <td >&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2"><textarea name="<%=question_idx%>" cols="60" rows="6"></textarea></td>
							  </tr>
							</table>
							</td>
						</tr>
<% } %>
<!-- ////////////////////////  -->

<%
				if (vt2 != null && vt2.size() > 0) {		// if (vt2)
					 for (int j = 0 ; j < vt2.size() ; j++ ) { // for end (vt2)
						 ans_idx = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(0));
					//	 question_idx = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(1));
						 step_flag = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(2));
						 ans_num = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(3));
						 ans_content = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(4));
						 ans_order = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(5));
						 ans_etc = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(6));
%>

<!-- ////////설문 항목(질문 선택항목)////////////////  -->
<%
if (question_option.equals("4")) { // 다중선택 반복
%>
						<tr> 
						  <td>&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width='280'>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="qu_2">(<%=j+1%>)&nbsp;<%=ans_content%></td>
											</tr>
										</table>
									</td>
									<td width='200' align='right'>
										<table border="0" cellspacing="0" cellpadding="0" width='100%'>
										<tr> 
											<%
											if (info != null && info.size() > 0) {
											 %>
											 <input type='hidden' name='<%=question_idx%>' value='<%=vt2.size()%>'>
											<%
											for ( int k = 0 ; k < info.size() ; k++) {
											%>
											<td class="qu_2"><input type='radio' name='<%=question_idx%>_<%=ans_num%>' value='<%=k+1%>' ></td>
											<% } } %>
										  </tr>
										</table>
									</td>
								</tr>
							  
							</table>
							</td>
						</tr>
<%
	} else if (question_option.equals("3")) { // 다중선택 제한
%>
						<tr> 
						  <td>&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td width="40" class="qu_2">(<%=j+1%>)<input name="<%=question_idx%>" type="checkbox" onClick='checkCheckbox(this.form,this,<%=question_etc %>)' value="<%=ans_num%>"></td>
								<td class="qu_2"><%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;<input type='text' class='qu_2' name='"+question_idx+"_order_"+ans_num+"' align='absolute' size='30'>"); } %></td>
							  </tr>
							</table>
							</td>
						</tr>
<%
	} else if (question_option.equals("2")) { // 다중선택 무제한
%>
						<tr> 
						  <td>&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td width="40" class="qu_2">(<%=j+1%>)<input name="<%=question_idx%>" type="checkbox" value="<%=ans_num%>"></td><td class="qu_2"><%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;<input type='text' class='qu_2' name='"+question_idx+"_order_"+ans_num+"' align='absolute' size='30'>"); } %></td>
							  </tr>
							</table>
						  </td>
						</tr>
<% } else { %>
						<tr> 
						  <td height="27">&nbsp;</td>
						  <td>
							<table width="480" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td width="40" class="qu_2">(<%=j+1%>)<input type="radio" name="<%=question_idx%>" value="<%=ans_num%>"></td><td class="qu_2"><%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;<input type='text' class='qu_2' name='"+question_idx+"_order_"+ans_num+"' align='absolute' size='30'>"); } %></td>
							  </tr>
							</table>
							</td>
						</tr>
<% } %>
<!-- ////////////////////////  -->

<%
					 } // for end (vt2)

				}  // if end (vt2)

			} // for end (vt1)

		}  // if end (vt1)

	} // if end (vt)
%>

						</table>
						</td>
					</tr>
				</table>
				<td background="images/question_05_06.jpg" width="16"></td>
			</tr>
			<tr>
				<td><img src="images/question_05_07.jpg" width="15" height="26" alt=""></td>
				<td><img src="images/question_05_08.jpg" width="549" height="26" alt=""></td>
				<td><img src="images/question_05_09.jpg" width="16" height="26" alt=""></td>
			</tr>
		</table>
		</td>
		<td background="images/question_06.jpg" width="10"></td>
	</tr>
	<tr>
		<td><img src="images/question_07.jpg" width="10" height="62" alt=""></td>
		<td>
		<table width="580" border="0" cellspacing="0" cellpadding="0">
			<tr>
		    	<td height="22">
		    	<table width="580" height="19" border="0" cellpadding="0" cellspacing="0">
		        	<tr> 
		                <td width="221" height="19">&nbsp;</td>
		                <td width="97"><a href="javascript:go_submit();"><img src="images/bt_01.jpg" width="90" height="19" border="0"></a></td>
		                <td width="262"><a href="javascript:self.close();"><img src="images/bt_02.jpg" width="48" height="19" border="0"></a></td>
		            </tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="bottom"><img src="images/question_08.jpg" width="580" height="40"></td>
			</tr>
		</table>
		</td>
		<td><img src="images/question_09.jpg" width="10" height="62" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
</form>
</body>
</html>
