<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>

<%


	SubjectManager mgr = SubjectManager.getInstance();
	SubjectInfoBean Sin = new SubjectInfoBean();

//	Vector vt = mgr.getSubjectListDate();
	Vector vt1 = null;

	String sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">",""); 
	if(sub_idx == null){
			out.println("<script lanauage='javascript'>alert('정보가 없습니다 창을 닫습니다..'); self.close(); </script>");
	}

	String sub_flag = "S"; // S - 설문 ,  E - 이벤트
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
	String skin = "/subject";
	if (sub_flag.equals("E")) {
		skin = "/event";
	}

	 Vector vt = mgr.getSubject(sub_idx);


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
	String ans_img = "";
	String ans_hot7_ocode = "";
	
	if (vt != null && vt.size() > 0 ) {
		 sub_idx = String.valueOf(vt.elementAt(0));
		 sub_title =  String.valueOf(vt.elementAt(1));
		 sub_start = String.valueOf(vt.elementAt(2));
		 sub_end = String.valueOf(vt.elementAt(3));
		 sub_person = String.valueOf(vt.elementAt(4));
		 sub_name = String.valueOf(vt.elementAt(5));
		 sub_mf = String.valueOf(vt.elementAt(6));
		 sub_tel = String.valueOf(vt.elementAt(7));
		 sub_email = String.valueOf(vt.elementAt(8));
		 sub_etc = String.valueOf(vt.elementAt(9));

%>

<html>
<head>
<title>설문지</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css<%=skin%>/suwon.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript" language="javascript">
function resize_img() { 
        full_image = new Image();
        full_image["src"] = document.img_file.src;
	img_width = full_image["width"];
	img_height = full_image["height"];
	
	var maxDim = 580;
	
	var scale = parseFloat(maxDim)/ parseFloat(img_height);
	if (img_width > img_height)
	    scale = parseFloat(maxDim)/ parseFloat(img_width);
	if (maxDim > img_height && maxDim > img_width) 
	    scale = 1;

	if (scale !=1) {	
		var scaleW = scale * img_width;
		var scaleH = scale * img_height;
	
	        document.img_file.height = scaleH;
	        document.img_file.width = scaleW;
        }
        
}
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='subject_user' method='post' action="proc_subject_user.jsp?sub_flag=<%=sub_flag%>">
<table id="Table_01" width="900" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><img src="images<%=skin%>/question_01.jpg" width="10" height="70" alt=""></td>
		<td>
			 <table id="Table_01" width="880" height="70" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2">
						<img src="images<%=skin%>/question_02_01.jpg" width="880" height="33" alt=""></td>
				</tr>
				<tr>
					<td width="749" height="37">
						<table width="749" border="0" cellspacing="0" cellpadding="0">
						  <tr>
							<td width="190">&nbsp;</td>
							<td width="259"><font color="084299" size="+1"><b><%=sub_title%></b></font></td><td width='300' class='qu_5'> 총 설문 인원수 : <%=mgr.user_count(sub_idx)%></td>
						  </tr>
						</table>

					</td>
					<td>
						<img src="images<%=skin%>/question_02_03.jpg" width="131" height="37" alt=""></td>
				</tr>
			</table>
		</td>
		<td><img src="images<%=skin%>/question_03.jpg" width="10" height="70" alt=""></td>
	</tr>
	<tr>
		<td background="images<%=skin%>/question_04.jpg" width="10"></td>
		<td>
		<!-- 질문시작-->
		<table id="Table_01" width="880" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="images<%=skin%>/question_05_01.jpg" width="15" height="31" alt=""></td>
				<td><img src="images<%=skin%>/question_05_02.jpg" width="849" height="31" alt=""></td>
				<td><img src="images<%=skin%>/question_05_03.jpg" width="16" height="31" alt=""></td>
			</tr>
			<tr>
				<td background="images<%=skin%>/question_05_04.jpg" width="15"></td>
				<td width="849" bgcolor="daedfe" valign="top">
				<table width="849" border="0" cellpadding="0" cellspacing="0">
<% if (sub_etc != null && sub_etc.length() > 0 )  { %>
						<tr > 
						  <td >
							<table width="849" border="0" cellspacing="0" cellpadding="0" align='center'>
								<tr>
									<td><img src="images<%=skin%>/bg_font_13_01.gif" width="15" height="17" alt=""></td>
									<td background='images<%=skin%>/bg_font_13_02.gif' height="17"></td>
									<td><img src="images<%=skin%>/bg_font_13_03.gif" width="13" height="17" alt=""></td>
								</tr>
								<tr>
									<td background="images<%=skin%>/bg_font_13_04.gif" width="15"></td>
									<td width="821" height="47" bgcolor="daedfe">
									   <table width="821" border="0" cellspacing="0" cellpadding="0">
										<tr> 
										  <td width="821" class="bg_font"><p style="padding:1px; width:100%; line-height:140%"><%=chb.getContent(sub_etc)%></p> </td>
										</tr>
									  </table>
									</td>
									<td background="images<%=skin%>/bg_font_13_06.gif" width="13"></td>
								</tr>
								<tr>
									<td><img src="images<%=skin%>/bg_font_13_07.gif" width="15" height="17" alt=""></td>
									<td background='images<%=skin%>/bg_font_13_08.gif'></td>
									<td><img src="images<%=skin%>/bg_font_13_09.gif" width="13" height="17" alt=""></td>
								</tr>
							</table>
							</td>
						</tr>
<% } %>
					<tr>
						<td height="73" align="center">
						<table width="830" border="0" cellspacing="0" cellpadding="0">

						<Tr><td height='7'></td></tr>
<% if (sub_name != null && sub_name.equals("Y")) { %>
						<tr style="padding-top:5px; padding-left:5px; padding-bottom:5px; padding-right:5px;"> 
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
						<tr style="padding-top:5px; padding-left:5px; padding-bottom:5px; padding-right:5px;"> 
						  <td >&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2" width='100'>▷&nbsp;&nbsp;성별</td><td class="qu_2"><input type="radio" name="user_mf" value="M">남 &nbsp;&nbsp;&nbsp;<input type="radio" name="user_mf" value="W">여</td>
							  </tr>
							</table>
							</td>
						</tr>
<% } 
if (sub_tel != null && sub_tel.equals("Y")) { 
%>
						<tr style="padding-top:5px; padding-left:5px; padding-bottom:5px; padding-right:5px;"> 
						  <td >&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2" width='100'>▷&nbsp;&nbsp;연락처</td><td class="qu_2"><input type='text' name='user_tel'></td>
							  </tr>
							</table>
							</td>
						</tr>
<% } 
if (sub_name != null && sub_name.equals("Y")) { 
%>

						<tr style="padding-top:5px; padding-left:5px; padding-bottom:5px; padding-right:5px;"> 
						  <td >&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0">
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
		String question_image = "";

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
			 question_image = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(7));
	             
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
						<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
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
						   <td>
							<table width='100%' border="0" cellspacing="0" cellpadding="0">
								<tr>
								 <td class="qu_1" valign="middle"><%=question_content%></td>  
								 <td class="qu_5" width='300'>&nbsp;&nbsp;( <%=mgr.user_count_question(sub_idx, question_idx)%> 명)</td>
								</tr>
							</table>
						   </td>
						</tr>
						<% if (question_image != null && question_image.length() > 0 ) { %>
						<tr>
							<td width="50"></td><td align='left'><img src='/upload/subject/<%=question_image%>' border='0' onload='resize_img()'   name='img_file'>
							</td>
						</tr>
						<% } %>
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
						<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;">
							<td >&nbsp;</td>
							<td>
								<table width="780" border="0" cellspacing="0" cellpadding="0">
									<td width='200'>
										<table border="0" cellspacing="0" cellpadding="0" >
											<tr>
												<td class="qu_2">※ 다음 선택항목 중에 선택하세요 !</td>
											</tr>
										</table>
									</td>
									<td width='580' align='right'>
										<table border="0" cellspacing="0" cellpadding="0" width='100%' >
											<tr class="qu_3_1">
											<%
											if (info != null && info.size() > 0) {
											int width_size = 280/info.size();
												for ( int k = 0 ; k < info.size() ; k++) {
											%>
											<td width='<%=width_size%>' align='center'><%=info.elementAt(k) %></td>
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
						<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
						  <td >&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								<td class="qu_2" height='100' style="border-width:1; border-color:gray; border-style:solid;">&nbsp;</td><td width='300'></tD>
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
						 ans_img = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(7));
						 ans_hot7_ocode = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(8));
%>

<!-- ////////설문 항목(질문 선택항목)////////////////  -->
<%
if (question_option.equals("4")) { // 다중선택 반복 라디오버튼
%>
						<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
						  <td>&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width='200'>
										<table border="0" cellspacing="0" cellpadding="0" style=" line-height:1.1em;">
											<tr>
												<td class="qu_2">(<%=j+1%>)&nbsp;<%=ans_content%></td>
											</tr>
										</table>
									</td>
									<td width='580' align='right'>
										<table border="0" cellspacing="0" cellpadding="0" width='100%'>
										<tr> 
											<%
											if (info != null && info.size() > 0) {
											int width_size = 280/info.size();
											 %>
											<%
											for ( int k = 0 ; k < info.size() ; k++) {
											%>
											<td class="qu_6" width='<%=width_size%>' align='center'>( <%=mgr.user_count_ans2(sub_idx, question_idx, ans_num , Integer.toString(k+1))%> 건)</td>
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
						<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
						  <td>&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0" style=" line-height:1.1em;">
							  <tr> 
								<td width="20" class="qu_2">(<%=j+1%>)</td><td width='20'></td>
								<td class="qu_2" width='435'><%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)"); } %></td>
								<td class="qu_6" width='300'>&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx, question_idx,ans_num)%> 건)</td>
							  </tr>
							</table>
							</td>
						</tr>
<%
	} else if (question_option.equals("2")) { // 다중선택 무제한
%>
						<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
						  <td>&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0" style=" line-height:1.1em;">
							  <tr> 
								<td width="20" class="qu_2">(<%=j+1%>)</td><td width='20'></td><td class="qu_2"><%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)"); } %></td>
								<td class="qu_6" width='300'>&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx, question_idx,ans_num)%> 건)</td>
							  </tr>
							</table>
						  </td>
						</tr>
<% } else if (question_option.equals("1")) { %>
						<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
						  <td height="27">&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0"  style=" line-height:1.1em;">
							  <tr> 
							  <% if (sub_flag.equals("S")) { %>
								<td width="40" class="qu_2">(<%=j+1%>)</td><td class="qu_2"><%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)"); } %></td>
								<% } else { %>
								<td width="40" class="qu_2">(<%=j+1%>)</td><td <% if (ans_order != null && ans_order.equals(ans_num)) { out.println("class='qu_5'"); } else {out.println("class='qu_2'");}%>><%=ans_content%>&nbsp;</td>
								<% } %>
								<td class="qu_6" width='300'>&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx, question_idx,ans_num)%> 건)</td>
							  </tr>
							</table>
							</td>
						</tr>
<% } else if (question_option.equals("6")) { %>
						<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
						  <td height="27">&nbsp;</td>
						  <td>
							<table width="780" border="0" cellspacing="0" cellpadding="0"  style=" line-height:1.1em;">
							  <tr> 
							  
								<td width="40" class="qu_2">(<%=j+1%>)</td>
								<td width="130" class="qu_2"><img src="<%=ans_img %>" boarder='0' width="120" /></td>
								<td class="qu_2"><%=ans_content%>
								</br><%=ans_etc %>
								&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)"); } %></td>
								<td class="qu_6" width='300'>&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx, question_idx,ans_num)%> 건)</td>
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
				<td background="images<%=skin%>/question_05_06.jpg" width="16"></td>
			</tr>
			<tr>
				<td><img src="images<%=skin%>/question_05_07.jpg" width="15" height="26" alt=""></td>
				<td><img src="images<%=skin%>/question_05_08.jpg" width="849" height="26" alt=""></td>
				<td><img src="images<%=skin%>/question_05_09.jpg" width="16" height="26" alt=""></td>
			</tr>
		</table>
		</td>
		<td background="images<%=skin%>/question_06.jpg" width="10"></td>
	</tr>
	<tr>
		<td><img src="images<%=skin%>/question_07.jpg" width="10" height="62" alt=""></td>
		<td>
		<table width="880" border="0" cellspacing="0" cellpadding="0">
			<tr>
		    	<td height="22">
		    	<table width="880" height="19" border="0" cellpadding="0" cellspacing="0">
		        	<tr> 
		                <td width="880" align='center'><a href="javascript:self.close();"><img src="images<%=skin%>/bt_02.jpg" width="48" height="19" border="0"></a></td>
		            </tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="bottom"><img src="images<%=skin%>/question_08.jpg" width="880" height="40"></td>
			</tr>
		</table>
		</td>
		<td><img src="images<%=skin%>/question_09.jpg" width="10" height="62" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
</form>
</body>
</html>
