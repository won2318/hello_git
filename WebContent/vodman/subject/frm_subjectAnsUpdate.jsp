<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file="/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "v_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

<%
	String question_idx = "";
	if(request.getParameter("question_idx") != null && request.getParameter("question_idx").length()>0){
		question_idx = request.getParameter("question_idx").replaceAll("<","").replaceAll(">","");
	}

	String sub_flag = "S"; // S - 설문 ,  E - 이벤트
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}

    SubjectManager mgr = SubjectManager.getInstance();

    Vector Vt = mgr.getSubject_Question(question_idx);

	String question_content = "";
	String question_option = "";
	String question_info = "";
	String question_etc = "";
	String question_num = "";
	String sub_idx = "";
if (Vt != null && Vt.size() > 0 ) {
//		 question_idx = String.valueOf(Vt.elementAt(0));
		 sub_idx = String.valueOf(Vt.elementAt(1));
		 question_content =  String.valueOf(Vt.elementAt(2));
		 question_option = String.valueOf(Vt.elementAt(3));
		 question_info = String.valueOf(Vt.elementAt(4));
		 question_etc = String.valueOf(Vt.elementAt(5));
		 question_num = String.valueOf(Vt.elementAt(6));
}

	Vector info = new Vector();

if (question_info != null && question_info.length() > 0) {
	StringTokenizer question_info_st = new StringTokenizer(question_info, ","); 
	while (question_info_st.hasMoreTokens()) {
			info.add(question_info_st.nextToken());
	}
}

	String ans_idx = "";
//	String question_idx = "";
	String step_flag = "";
	String ans_num = "";
	String ans_content = ""; 
	String ans_order = "";
	String ans_etc = "";  // 간략 설명
	String ans_img = "";  // 대표이미지
	String ans_hot7_ocode = "";  // 영상코드
    Vector Vt2 = null;
    Vt2 = mgr.getSubject_AnsList(question_idx);

	String max_inx = "0";

	 if (Vt2 != null && Vt2.size() > 0) {

		  max_inx = mgr.getSubject_AnsInx(question_idx);
		 /*
//		for (int i = 0 ; i <Vt2.size() ; i++) {
//		 seq_sub = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(0));
//		 sel_inx = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(2));
//		 sel_content = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(3));
//		}
		*/
//		out.println(Vt2);
	 } else {
		 out.println("<script lanauage='javascript'>location.href='/vodman/subject/frm_subjectAnsAdd.jsp?question_idx="+question_idx+"&sub_flag="+sub_flag+"'</script>");
	 }



%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
</head>

<script language="javascript">
	function sub_question(){
		var f = document.frmMedia;
		
		document.frmMedia.submit();

	}
	
	function find_movie(val){
		window.open('pop_hot7.jsp?val='+val,'vod_find','WIDTH=670,HEIGHT=600,toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,resizable=no');
	}

function check_joo(val)
{

    var obj = document.getElementsByName("ans_order"); 
	 for(i=0;i<obj.length;i++) {
		if(obj[i].checked==true){
			if(obj[i].value != val){
				obj[i].checked = false;
			}
		}
	}

}

//    function sub_question(){
//		window.open('/vodman/subject/frm_subjectQuestionAdd.jsp','subject','width=630,height=500,scrollbars=auto');
//	}
	var inputTable = '<div id="textFrom" name="textFrom"><table cellspacing="0" border="0" width="100%" align="left" ><tr><td width="80">예문 입력<div id="addRowFrom" name="addRowFrom">'
	<% if (question_option.equals("6"))  { /* 주관식 일경우 */ %>
		+'<a href="javascript:addRow_hot7();"><img src="/vodman/include/images/but_plus.gif" border="0"></a>'
	<% } else if (!question_option.equals("5")) { %>
		+'<a href="javascript:addRow();"><img src="/vodman/include/images/but_plus.gif" border="0"></a>'
	<%} %>
	+'</div></td><td><table cellpadding="2" cellspacing="0" border="0" width="100%" align="left" style="margin-left:5px;">'
<%
	if (Vt != null && Vt.size() > 0 && Vt2 != null && Vt2.size() > 0) {
%>
	+'<input type = "hidden" name = "defaultRow" value="<%=Vt2.size()%>"><input type = "hidden" name = "maxRow" value="<%=max_inx%>">'
<%
		for (int i = 0 ; i <Vt2.size() ; i++) {

			ans_idx = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(0));
			question_idx = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(1));
			step_flag = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(2));
			ans_num = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(3));
			ans_content = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(4));
			ans_order = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(5));
			ans_etc = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(6));
			ans_img = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(7));
			ans_hot7_ocode = String.valueOf(((Vector)(Vt2.elementAt(i))).elementAt(8));
					if (question_option.equals("4")){  // 다중선택 반복(라이오버튼 반복)
%>
					+'<div id="block<%=i%>">'
					+'	<table cellspacing="0" border="0" width="100%">'
					+'		<tr>'
					+'			<td> '
					+'				<input type="hidden" name="ans_etc" value="<%=ans_etc%>">'
					+'				<input type="hidden" name="ans_img" value="<%=ans_img%>">'
					+'				<input type="hidden" name="ans_hot7_ocode" value="<%=ans_hot7_ocode%>">'
					
					+'				<input type="hidden" name="ans_num" value="<%=ans_num%>">'
					+'				<input type="text" name="ans_content" size="35" class="inputG" value="<%=ans_content%>">'
					+'			</td>'
						<%if(!ans_num.equals("1")){%>
					+'			<td>'
					+'				<input type="button" value="삭제" class="input" onClick="deleteRow(<%= i %>);">'
					+'			</td>'
						<%}%>
					+"<td align='right'><table width='220' border='0' cellspacing='0' cellpadding='0' bgcolor='#DBE2C9'><tr>"
						<%
								if (info != null && info.size() > 0) {
									for ( int j = 0 ; j < info.size() ; j++) {
						%>
									+"<td><input type='radio' name='radio_<%= i %>' value=''></td>"
						<%
									}
								}
						%>

					+'</tr></table></td></tr></table></div>'
<%
					} else if (question_option.equals("5"))  {  // 주관식
				%>
						+'<div id="block<%=i%>">'
						+'	<table cellspacing="0" border="0">'
						+'		<tr>'
						+'			<td> '
						+'				<input type="hidden" name="ans_etc" value="<%=ans_etc%>">'
						+'				<input type="hidden" name="ans_img" value="<%=ans_img%>">'
						+'				<input type="hidden" name="ans_hot7_ocode" value="<%=ans_hot7_ocode%>">'
						
						+'				<input type="hidden" name="ans_num" value="<%=ans_num%>">'
						+'				<textarea name="ans_content" cols="70" rows="6"><%=ans_content%></textarea>'
						+'			</td>'
						+'		</tr>'
						+'	</table>'
						+'</div>'
<% 
					} else if (question_option.equals("6")) {
%>
						+'<div id="block<%=i%>">'
						+'	<table cellspacing="0" border="0">'
						+'		<tr>'
						+'			<td> '
						+'			<img src="<%=ans_img%>" height="70" width="100"/> '
						+'			</td> '
						+'			<td> '
						+'				<input type="hidden" name="ans_num" id="ans_num_<%=i%>" value="<%=ans_num%>" >'
						+'				<input type="hidden" name="ans_img" id="ans_img_<%=i%>" value="<%=ans_img%>" >'
						+'				<input type="hidden" name="ans_hot7_ocode" id="ans_hot7_ocode_<%=i%>"  value="<%=ans_hot7_ocode%>">'
						+'				<input type="text" name="ans_content" id="ans_content_<%=i%>" size="50" class="inputG" value="<%=ans_content%>" >&nbsp;&nbsp;'
						+'				</br><input type="text" name="ans_etc" id="ans_etc_<%=i%>" size="50" class="inputG" value="<%=ans_etc%>">&nbsp;&nbsp;'
						+'<input type="checkbox" name="ans_order" value="<%=ans_num%>" <% if (ans_order.equals(ans_num)) { out.print("checked"); } %> onclick="check_joo(this.value);">'
						+'			</td>'
						<%if(ans_num.equals("1")){%>
						+'			<td>'
						
						+'				<input type="button" value="영상찾기" class="input" onClick="find_movie(<%= i %>);">'
						+'			</td>'
						<%} else {%>
						+'			<td>'
						+'				<input type="button" value="삭제" class="input" onClick="deleteRow(<%= i %>);">'
						+'				<br/><input type="button" value="영상찾기" class="input" onClick="find_movie(<%= i %>);">'
						+'			</td>'
						<%} %>
				 
						+'		</tr>'
						+'	</table>'
						+'</div>'
<%
					}else {
%>
						+'<div id="block<%=i%>">'
						+'	<table cellspacing="0" border="0">'
						+'		<tr>'
						+'			<td> '
						+'				<input type="hidden" name="ans_num" value="<%=ans_num%>">'
						+'				<input type="hidden" name="ans_etc" value="<%=ans_etc%>">'
						+'				<input type="hidden" name="ans_img" value="<%=ans_img%>">'
						+'				<input type="hidden" name="ans_hot7_ocode" value="<%=ans_hot7_ocode%>">'
						+'				<input type="text" name="ans_content" size="50" class="inputG" value="<%=ans_content%>">&nbsp;&nbsp;'
						+'				<input type="checkbox" name="ans_order" value="<%=ans_num%>" <% if (ans_order.equals(ans_num)) { out.print("checked"); } %> onclick="check_joo(this.value);">'
						+'			</td>'
						<%if(!ans_num.equals("1")){%>
						+'			<td>'
						+'				<input type="button" value="삭제" class="input" onClick="deleteRow(<%= i %>);">'
						+'			</td>'
						<%}%>
						+'		</tr>'
						+'	</table>'
						+'</div>'
<%
					}
			} // for 종료
	} else {
%>
		+'<table cellspacing="0" border="0"><tr>'
		+'<td><input type="hidden" name="ans_num" value="1"><input type="text" name="ans_content" size="50" class="inputG">&nbsp;&nbsp;<input type="checkbox" name="ans_order" value="1" onclick="check_joo(this.value);"></td>'
		+'</tr><tr>'
		+'<td> <input type="hidden" name="sel_inx" value="2"> <input type="hidden" name="ans_num" value="2"><input type="text" name="ans_content" size="50" class="inputG">&nbsp;&nbsp;<input type="checkbox" name="ans_order" value="2" onclick="check_joo(this.value);"><input type = "hidden" name = "defaultRow" value="2"><input type = "hidden" name = "maxRow" value="2"></td>'
		+'</tr></table>'

<%} %>
	+'<table cellspacing="0" border="0" width="100%"><Tr><td><div id="addRowBlock" name="addRowBlock"></div></td></tr></table></td></tr></table></div>';
</script>

           
<body leftmargin="5" topmargin="0" marginwidth="0" marginheight="0"  >
<form name='frmMedia' method='post' action="proc_subjectAnsAdd.jsp?question_idx=<%=question_idx%>&sub_flag=<%=sub_flag%>">
	<input type="hidden" name="question_idx" value="<%=question_idx %>">
	<input type="hidden" name="step_flag" value="0">
<table width="600" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">
		<table width=100% border=0 cellpadding=0 cellspacing=0 align="center">
			<tr>
				<td height='15'></td>
			</tr>
			<tr>
				<td align="center">
					<table width="100%" border=0 cellpadding=3 cellspacing=0 align="center">
						<tr>
							<td class="tdB" width="100">질 문 <a href="/vodman/subject/frm_subjectQuestionUpdate.jsp?sub_idx=<%=sub_idx%>&question_idx=<%=question_idx%>&sub_flag=<%=sub_flag%>"><img src='/vodman/include/images/but_edit.gif' border='0'></a></td>
							<td class="tdB" width="500" bgcolor='#dbe2ed'>&nbsp;&nbsp;▶&nbsp;<%=question_content%></td>
						</tr>
						<% if (question_option.equals("4")){ %>
						<tr>
							<Td  class="tdB" width="100">구분</tD>
							<td  class="tdB"  align='right'>
								<table width='220' border="0" cellspacing="0" cellpadding="0" bgcolor='#DBE2C9'>
									<tr>
									  <%
									  if (info != null && info.size() > 0) {
										  for ( int i = 0 ; i < info.size() ; i++) {
									  %> 
										<td><%=info.elementAt(i) %><td>
									  <%		 } 
										}
									  %>
									</tr>
								</table>
							</td>
						</tr>
						<% }else if (question_option.equals("5")){ %>
						<tr>
							<td class="tdB" width="100">&nbsp;</td>
							<td class="tdB">내용 입력 폼입니다.	</td>
						</tr>
						<% } else { %>
						
						<tr>
							<td class="tdB" width="100">번호</td>
							<td class="tdB" width="500"> 설문 문항 </td>
						</tr>
						<% }%>
						<tr>
							<td height="1" bgcolor="#DBE2C9" colspan="2"></td>
						</tr>
						<tr>
							<td colspan='2' width="100%" class="tdB">
<!-- -->

<!-- -->
								<script>
									document.write(inputTable);
								</script>
							</td>
						</tr>

						<tr>
							<td colspan=2 align=center>
								<table border="0" cellspacing="0" cellpadding="5">
									<tr>
										<td><a href="javascript:sub_question();"> <img src="/vodman/include/images/but_ok3.gif" border="0"></a></td>
										<td><a href="javascript:frmMedia.reset();"> <img src="/vodman/include/images/but_cancel.gif" border="0"></a></td>
									</tr>
								</table>
							<td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<script type="text/javascript" language="javascript">
function addRow_hot7(){
    var f = document.frmMedia;
 
		var mr = Number(f.maxRow.value) + 1;
		var dr = Number(f.defaultRow.value) + 1;
		f.maxRow.value = mr;
		f.defaultRow.value = dr;

		var sel_inx = mr+2;

		var html = "<div id=block" + mr + ">"
			+ "<table cellpadding='0' cellspacing='0' border='0' width='100%' style='margin-top:5px;'>"

<% 
if (question_option.equals("4")){
%>
+ "	<tr>"
+ "    <td align='right'> "
+ "			<input type='hidden' name='sel_inx' value='"+sel_inx+"'>"
+ "			<input type='hidden' name='ans_num' value='"+sel_inx+"'>"
+"<input type='hidden' name='ans_hot7_ocode' id='ans_hot7_ocode_"+sel_inx+"' value=''><input type='hidden' name='ans_img' value=''>"
+ "<input type='text' name='ans_content' id='ans_content_"+sel_inx+"' size='35' class='inputG'></br><input type='text' name='ans_etc' size='50' class='inputG'>"
+ "		</td>"
<%if(!ans_num.equals("1")){%>
+ "		<td>"
+ "<input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'>"
+ "		</td>"
<%}%>
+"<td align='right'><table width='220' border='0' cellspacing='0' cellpadding='0' bgcolor='#DBE2C9'><tr>"
<%
		if (info != null && info.size() > 0) {
		for ( int i = 0 ; i < info.size() ; i++) {

%>
+"<td><input type='radio' name='radio_"+mr+"' value=''></td>"
<%
		}
	}
%>
+"</tr></table></td>"
+ "</tr>";

<% } else { %>
			+ "	<tr>"
			+ "		<td>"
			+ "			<img src='/vodman/include/images/no_img02.gif' height='70' width='100'/> "
			+ "		</td> "
			+ "		<td> "
			+ "<input type='hidden' name='sel_inx' value='"+sel_inx+"'>"
			+ "<input type='hidden' name='ans_num' value='"+sel_inx+"'>"
			+ "<input type='hidden' name='ans_hot7_ocode' id='ans_hot7_ocode_"+sel_inx+"'  value=''><input type='hidden' id='ans_img_"+sel_inx+"'  name='ans_img' value=''>"
			+ "			<input type='text' name='ans_content' id='ans_content_"+sel_inx+"'  size='50' class='inputG'></br><input type='text' name='ans_etc' id='ans_etc_"+sel_inx+"'  size='50' class='inputG'>&nbsp;&nbsp;"
			+ "<input type='checkbox' name='ans_order' value='"+sel_inx+"' onclick='check_joo(this.value);'>"
			+ "		</td>"
			+ "		<td> "
		
			<%if(!ans_num.equals("1")){%>
			+ "<input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'></br>"
			<%}%>
			+ "<input type='button' value='영상찾기' class='input' onClick='find_movie(" + sel_inx + ");'>"
			+ "		</td>"
			+ "</tr>";
<% } %>

			+ "</table>";
			+ "</div>";
			document.getElementById('addRowBlock').insertAdjacentHTML("BeforeEnd", html);
 
}

    function addRow(){
        var f = document.frmMedia;

//		 if (Number(f.defaultRow.value) > 2 ){
//           alert("더 이상 추가하실 수 없습니다.");
//            return;
//		} else{

			var mr = Number(f.maxRow.value) + 1;
			var dr = Number(f.defaultRow.value) + 1;
			f.maxRow.value = mr;
			f.defaultRow.value = dr;

			var sel_inx = mr+2;

			var html = "<div id=block" + mr + ">"
				+ "<table cellpadding='0' cellspacing='0' border='0' width='100%' style='margin-top:5px;'>"
				+ "<input type='hidden' name='ans_hot7_ocode' id='ans_hot7_ocode_"+sel_inx+"' value=''><input type='hidden' name='ans_img' id='ans_img_"+sel_inx+"' value=''><input type='hidden' name='ans_etc'  id='ans_etc_"+sel_inx+"'> "
<% 
	if (question_option.equals("4")){
%>
	+ "	<tr>"
	+ "    <td align='right'> "
	+ "			<input type='hidden' name='sel_inx' value='"+sel_inx+"'>"
	+ "			<input type='hidden' name='ans_num' value='"+sel_inx+"'>"
	+ "			<input type='text' name='ans_content' size='35' class='inputG'>&nbsp;&nbsp;"
	+ "		</td>"
	<%if(!ans_num.equals("1")){%>
	+ "		<td>"
	+ "			<input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'>"
	+ "		</td>"
	<%}%>
	+"<td align='right'><table width='220' border='0' cellspacing='0' cellpadding='0' bgcolor='#DBE2C9'><tr>"
<%
			if (info != null && info.size() > 0) {
			for ( int i = 0 ; i < info.size() ; i++) {

%>
	+"<td><input type='radio' name='radio_"+mr+"' value=''></td>"
<%
			}
		}
%>
	+"</tr></table></td>"
	+ "</tr>";

<% } else { %>
				+ "	<tr>"
				+ "		<td> "
				+ "			<input type='hidden' name='sel_inx' value='"+sel_inx+"'>"
				+ "			<input type='hidden' name='ans_num' value='"+sel_inx+"'>"
				+ "			<input type='text' name='ans_content' size='50' class='inputG'>&nbsp;&nbsp;"
				+ "			<input type='checkbox' name='ans_order' value='"+sel_inx+"' onclick='check_joo(this.value);'>"
				<%if(!ans_num.equals("1")){%>
				+ "			<input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'>"
				<%}%>
				+ "		</td>"
				+ "</tr>";
<% } %>

				+ "</table>";
				+ "</div>";
				document.getElementById('addRowBlock').insertAdjacentHTML("BeforeEnd", html);
//	   }
    }
    function deleteRow(delGap){
        var f = document.frmMedia;
        var defaultRowNum = f.defaultRow.value;
        if (Number( defaultRowNum ) == 0 ){
            alert("더 이상 삭제하실 수 없습니다.");
            return;
        } else {
            f.defaultRow.value = Number(defaultRowNum) - 1;
            eval("document.getElementById('block" + delGap + "').outerHTML = '';");
        }
    }
</script>
</form>
</body>
</html>
