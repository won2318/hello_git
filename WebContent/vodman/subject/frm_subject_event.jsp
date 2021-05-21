<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ include file="/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
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
			out.println("<script lanauage='javascript'>alert('정보가 없습니다 창을 닫습니다..'); self.close(); </script>");
	}
	String sub_flag = "E"; // S - 설문 ,  E - 이벤트
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
			alert("정답자 보다 당첨인원자 수가 더 많습니다.");return;
		}
		if(lp <= 0){
			alert("당첨인원이 없습니다. 다시 입력하여 주시기 바랍니다.");return;
		}
		if(confirm("당첨인원 수가 "+lp+"명 맞습니까?")!=0){
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

		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>설문</span> 목록</h3>
			<p class="location">관리자페이지 &gt; 설문 관리 &gt; <span>이벤트 추첨</span></p>
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
																		<td>&nbsp;&nbsp;▶&nbsp;<%=sub_title%></td><td align='right'> 총 : <%=mgr.user_count(sub_idx)%>명&nbsp;</td>
																	</tr>
																	<tr bgcolor="<%=bg_skin%>">
																		<td>&nbsp;&nbsp;</td><td align='right'> 정답자 : <%=cnt%>명&nbsp;</td>
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
																				<td>번호</td><td>이름</td><td>성별</td><td>연락처</td><td>이메일</td><td>아이피</td>
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
																<td >당첨 인원 : <input type="text" name="people" value=""><a href="javascript:eventLucky();"><img src="/include/skin/images/button_enter.gif" border="0"></a></td>
															</tr>
															<tr>
																<Td height='1' bgcolor='<%=bg_skin%>'></td>
															</tr>
															<tr>
																<td align="center" >추첨 결과가 없습니다.</td>
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

