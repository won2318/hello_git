<%@ page language="java" contentType="application/vnd.ms-excel; charset=euc-kr"%>
 <%@ page import="java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file="/vodman/include/auth.jsp"%>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean" />
<%
	SubjectManager mgr = SubjectManager.getInstance();
	SubjectInfoBean Sin = new SubjectInfoBean();

	//	Vector vt = mgr.getSubjectListDate();
	Vector vt1 = null;

	String sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">","");
	if (sub_idx == null) {
		out.println("<script lanauage='javascript'>alert('정보가 없습니다 창을 닫습니다..'); self.close(); </script>");
	}
	String sub_flag = "S"; // S - 설문 ,  E - 이벤트
	if (request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length() > 0) {
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}

	String user_mf = ""; // M - 남 ,  W - 여
	if (request.getParameter("user_mf") != null && request.getParameter("user_mf").length() > 0) {
		user_mf = request.getParameter("user_mf").replaceAll("<","").replaceAll(">","");
	}

	String event_point = "";
	if (request.getParameter("event_point") != null && request.getParameter("event_point").length() > 0) {
		event_point = request.getParameter("event_point").replaceAll("<","").replaceAll(">","");
	}

	String skin = "/subject";
	String bg_skin = "#daedfe";
	if (sub_flag.equals("E")) {
		skin = "/event";
		bg_skin = "#e2daff";
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

	if (vt != null && vt.size() > 0) {
		sub_idx = String.valueOf(vt.elementAt(0));
		sub_title = String.valueOf(vt.elementAt(1));
		sub_start = String.valueOf(vt.elementAt(2));
		sub_end = String.valueOf(vt.elementAt(3));
		sub_person = String.valueOf(vt.elementAt(4));
		sub_name = String.valueOf(vt.elementAt(5));
		sub_mf = String.valueOf(vt.elementAt(6));
		sub_tel = String.valueOf(vt.elementAt(7));
		sub_email = String.valueOf(vt.elementAt(8));
		sub_etc = String.valueOf(vt.elementAt(9));
		
		response.setHeader("Content-Disposition", "inline; filename=SubjectUserList.xls");		
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
 
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor='#FFFFFF'>
<form name="subjectList" method="post">
<table id="Table_01" width="800" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align='center' colspan="7"><font color="084299" size="+1"><b><%=sub_title%></b></font></td>
	</tr>
	<tr>
		<td align="right" class='qu_5' colspan="7">
<%
		if (user_mf.equals("M")) {
			out.println("남성");
		} else if (user_mf.equals("W")) {
			out.println("여성");
		} else {
			out.println("총");
		}
%> 설문 인원수 : 
<%
		if (user_mf != null && user_mf.length() > 0 && !user_mf.equals("")) {
			out.println(mgr.user_count(sub_idx, user_mf));
		} else {
			out.println(mgr.user_count(sub_idx));
		}
%>
		</td>
	</tr>
	<tr>
		<td colspan="7" height="1" bgcolor="<%=bg_skin%>">&nbsp;</td>
	</tr>
<%
		vt1 = mgr.getSubject_QuiestionList(sub_idx); // sub_idx
	
		String question_idx = "";
		//		String sub_idx = "";
		String question_content = "";
		String question_option = "";
		String question_info = "";
		String question_etc = "";
		String question_num = "";
	
		if (vt1 != null && vt1.size() > 0) { // if (vt1)
%>
<input type='hidden' name='sub_idx' value='<%=sub_idx%>'>
<input type='hidden' name='question_count' value='<%=vt1.size()%>'>
<%
			for (int i = 0; i < vt1.size(); i++) { // for (vt1)
	
				question_idx = String.valueOf(((Vector) (vt1.elementAt(i))).elementAt(0));
				//	 sub_idx = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(1));
				question_content = String.valueOf(((Vector) (vt1.elementAt(i))).elementAt(2));
				question_option = String.valueOf(((Vector) (vt1.elementAt(i))).elementAt(3));
				question_info = String.valueOf(((Vector) (vt1.elementAt(i))).elementAt(4));
				question_etc = String.valueOf(((Vector) (vt1.elementAt(i))).elementAt(5));
				question_num = String.valueOf(((Vector) (vt1.elementAt(i))).elementAt(6));
				Vector vt2 = mgr.getSubject_AnsList(question_idx);
				String ans_idx = "";
				//	String question_idx = "";
				String step_flag = "";
				String ans_num = "";
				String ans_content = "";
				String ans_order = "";
				String ans_etc = "";
				String ans_img = "";
				String ans_hot7_ocode = "";
%>
											<!-- ///////////설문 (질문내용)/////////////  -->
					<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;">
						<td width="50" height="51" class="qu_1" valign="middle">Q<%=i + 1%>.</td>
<%
				if (question_option.equals("4")) {
%>
							<input type='hidden' name="Q<%=i%>" value="option4_<%=question_idx%>">
<%
				} else if (question_option.equals("3") || question_option.equals("2")) {
%>
							<input type='hidden' name="Q<%=i%>" value="option3_<%=question_idx%>">
<%
				} else if (question_option.equals("5")) {
%>
							<input type='hidden' name="Q<%=i%>" value="option5_<%=question_idx%>">
<%
				} else {
%>
							<input type='hidden' name="Q<%=i%>" value="<%=question_idx%>">
<%
				}
%>
						<td class="qu_1"><%=question_content%></td>
						<td class="qu_5" >&nbsp;&nbsp;( <%=mgr.user_count_question(sub_idx, question_idx, user_mf, question_option)%>명)</td>
					</tr>
					<tr>
						<td colspan="7" height="1" bgcolor="<%=bg_skin%>">&nbsp;</td>
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
					<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;">
						<td>&nbsp;</td>
						<td class="qu_2" width="680">&nbsp;</td>
<%
					if (info != null && info.size() > 0) {
						int width_size = 280 / info.size();
						for (int k = 0; k < info.size(); k++) {
%>
						<td align='center'>
							<table>
								<tr>
									<td class="qu_1" align='center'>
										<%=info.elementAt(k)%>
									</td>
								</tr>
							</table>
						</td>
<%
						}
					}
%>
					</tr>
					<tr>
						<td colspan="7" height="1" bgcolor="<%=bg_skin%>">&nbsp;</td>
					</tr>
<%
				} else if (question_option.equals("5")) { //textarea
%>
					<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;">
						<td>&nbsp;</td>
						<td class="qu_2">
<%
					if (sub_flag.equals("E") && vt2 != null && vt2.size() > 0) {
						out.println(String.valueOf(((Vector) (vt2.elementAt(0))).elementAt(4)));
					}
%>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="7" height="1" bgcolor="<%=bg_skin%>">&nbsp;</td>
					</tr>
<%
				}
%>
<%
				if (vt2 != null && vt2.size() > 0) { // if (vt2)
				for (int j = 0; j < vt2.size(); j++) { // for end (vt2)
					ans_idx = String.valueOf(((Vector) (vt2.elementAt(j))).elementAt(0));
					//	 question_idx = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(1));
					step_flag = String.valueOf(((Vector) (vt2.elementAt(j))).elementAt(2));
					ans_num = String.valueOf(((Vector) (vt2.elementAt(j))).elementAt(3));
					ans_content = String.valueOf(((Vector) (vt2.elementAt(j))).elementAt(4));
					ans_order = String.valueOf(((Vector) (vt2.elementAt(j))).elementAt(5));
					ans_etc = String.valueOf(((Vector) (vt2.elementAt(j))).elementAt(6));
					ans_img = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(7));
					 ans_hot7_ocode = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(8));
					if (question_option.equals("4")) { // 다중선택 반복 라디오버튼
%>
											<!-- ////////설문 항목(질문 선택항목)////////////////  -->
					<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;">
						<td>&nbsp;</td>
						<td class="qu_2">(<%=j + 1%>)&nbsp;<%=ans_content%></td>
<%
						if (info != null && info.size() > 0) {
							int width_size = 280 / info.size();
							for (int k = 0; k < info.size(); k++) {
%>
						<td class="qu_6" align='center'>
							<table>
								<tr>
									<td class="qu_6" align='center'>
						(<%=mgr.user_count_ans2(sub_idx,question_idx,ans_num,Integer.toString(k + 1),user_mf)%>건)
									</td>
								</tr>
							</table>
						</td>
<%
							}
						}
%>
					</tr>
<%
					} else if (question_option.equals("3")) { // 다중선택 제한
%>
					<tr style="padding-top:5px;  padding-bottom:5px; padding-right:5px;line-height:1.2em;">
						<td>&nbsp;</td>
						<td class="qu_2">(<%=j + 1%>)<%=ans_content%>&nbsp;</td>
						<td class="qu_6" width='200'>&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx,question_idx, ans_num,user_mf)%>건)</td>
					</tr>
<%
					} else if (question_option.equals("2")) { // 다중선택 무제한
%>
					<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;">
						<td>&nbsp;</td>
						<td class="qu_2">(<%=j + 1%>)<%=ans_content%>&nbsp;</td>
						<td class="qu_6" width='200'>&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx,question_idx, ans_num,user_mf)%>건)</td>
					</tr>
<%
					} else if (question_option.equals("1")) {
%>
					<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;">
						<td height="27">&nbsp;</td>
						<td class="qu_2">(<%=j + 1%>)<%=ans_content%>&nbsp;</td>
						<td class="qu_6">&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx,question_idx, ans_num,user_mf)%>건)</td>
					</tr>
 
					<% } else if (question_option.equals("6")){ %>
					<tr style="padding-top:5px; padding-bottom:5px; padding-right:5px;line-height:1.2em;"> 
					  <td height="27">&nbsp;</td>
					  <td class="research_img">
						<table width="680" border="0" cellspacing="0" cellpadding="0"  style=" line-height:1.1em;">
						  <tr> 
						   
							<td width="40" class="qu_2">(<%=j+1%>)</td>
							<td width="40" class="qu_2"><img src="<%=ans_img %>" boarder='0' width="120" /></td>
							<td class="qu_2"><%=ans_content%>
							</br><%=ans_etc %>
							&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)<a href='javascript:go_content("+question_idx+","+ans_num+");'>[내용보기]</a>"); } %></td>
							<td class="qu_6" width='200'>&nbsp;&nbsp;( <%=mgr.user_count_ans(sub_idx, question_idx,ans_num,user_mf)%> 건)</td>
							 
						  </tr>
						</table>
						</td>
					</tr>
 <%
					}
				} // for end (vt2)
%>
					<tr>
						<td colspan="7" height="3" bgcolor="<%=bg_skin%>">&nbsp;</td>
					</tr>
<% 		
			} // if end (vt2)
		} // for end (vt1)
	} // if end (vt1)
} // if end (vt)
												
%>
					
</table>
</form>
</body>
</html>
