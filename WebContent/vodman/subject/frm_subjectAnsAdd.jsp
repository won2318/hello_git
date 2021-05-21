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
if (Vt != null && Vt.size() > 0 ) {
		 question_content =  String.valueOf(Vt.elementAt(2));
		 question_option =  String.valueOf(Vt.elementAt(3));
		 question_info =  String.valueOf(Vt.elementAt(4));
}

	Vector info = new Vector();

if (question_info != null && question_info.length() > 0) {
	StringTokenizer question_info_st = new StringTokenizer(question_info, ","); 
	while (question_info_st.hasMoreTokens()) {
			info.add(question_info_st.nextToken());
	}
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

<% if (question_option.equals("5")) { %>

		var inputTable = '<div id="textFrom" name="textFrom"><table cellspacing="0" border="0" width="100%" align="left" ><tr>'
<%
		if(sub_flag.equals("E")) { // 이벤트 (주관식)
%>
			+"<td><textarea name='ans_content' cols='70' rows='6'></textarea><input type='hidden' name='ans_num' value='0'>"
			+"<input type='hidden' name='ans_img' value=''><input type='hidden' name='ans_hot7_ocode' value=''><input type='hidden' name='ans_etc'>"
<%
		}else  { // 설문
%>
			+"<td><textarea name='textarea' cols='70' rows='6'></textarea>"
<%
		}  
%>
<%
	} else if (question_option.equals("6")){  // 영상 선택
%>		
 
	var inputTable = '<div id="textFrom" name="textFrom"><table cellspacing="0" border="0" width="100%" align="left" >'
		+'<tr><td width="80">예문 입력<div id="addRowFrom" name="addRowFrom"><a href="javascript:addRow_hot7();"><img src="/vodman/include/images/but_plus.gif" border="0" alt="추가"></a></div></td><td><table cellpadding="2" cellspacing="0" border="0" width="100%" align="left" style="margin-left:5px;"><tr>'
		+'			<td> '
		+'			<img src="/vodman/include/images/no_img02.gif" height="70" width="100"/> '
		+'			</td> '
		+'<td><input type="hidden" name="ans_num" value="1"><input type="hidden" name="ans_img" id="ans_img_1" value=""><input type="hidden" name="ans_hot7_ocode" id="ans_hot7_ocode_1" value=""><input type="text" name="ans_content" id="ans_content_1" size="50" class="inputG"></br>'
		+'<input type="text" name="ans_etc" id="ans_etc_1" size="50" class="inputG"></td><Td><input type="checkbox" name="ans_order" value="1" onclick="check_joo(this.value);"></tD>'
		+'			<td>'
 
		+'				<br/><input type="button" value="영상찾기" class="input" onClick="find_movie(1);">'
		+'			</td>'
		+'</tr><tr>'
		+'			<td> '
		+'			<img src="/vodman/include/images/no_img02.gif" height="70" width="100"/> '
		+'			</td> '
		+'<td> <input type="hidden" name="sel_inx" value="2"> <input type="hidden" name="ans_num" value="2"><input type="hidden" name="ans_img" id="ans_img_2" value=""><input type="hidden" name="ans_hot7_ocode" id="ans_hot7_ocode_2" value="">'
		+'<input type="text" name="ans_content" id="ans_content_2"  size="50" class="inputG"></br>'
		+'<input type="text" name="ans_etc" id="ans_etc_2" size="50" class="inputG"></td><td><input type="checkbox" name="ans_order" value="2" onclick="check_joo(this.value);"></td>'
		+'			<td>'
		+'				<input type="button" value="삭제" class="input" onClick="deleteRow(2);">'
		+'				<br/><input type="button" value="영상찾기" class="input" onClick="find_movie(2);">'
		+'			</td>'

	
<%	} else	{  // question_option 5 일경우
%>
	var inputTable = '<div id="textFrom" name="textFrom"><table cellspacing="0" border="0" width="100%" align="left" ><tr><td width="80">예문 입력<div id="addRowFrom" name="addRowFrom"><a href="javascript:addRow();"><img src="/vodman/include/images/but_plus.gif" alt="추가" border="0"></a></div></td><td><table cellpadding="2" cellspacing="0" border="0" width="100%" align="left" style="margin-left:5px;"><tr>'
		+'<input type="hidden" name="ans_img" id="ans_img_1" value=""><input type="hidden" name="ans_hot7_ocode" id="ans_hot7_ocode_1" value=""><input type="hidden" name="ans_etc" id="ans_etc_1">'
<% 
	if (question_option.equals("4")){
%>
+'<td><input type="hidden" name="ans_num" value="1"><input type="text" name="ans_content" size="35" class="inputG"></td><td align="right"><table width="220" border="0" cellspacing="0" cellpadding="0" bgcolor="#DBE2C9"><tr>'

<%
		if (info != null && info.size() > 0) {
			for ( int i = 0 ; i < info.size() ; i++) {
%>
+'<td><input type="radio" name="radio_1" value=""></td>'
<%
			}
		}
%>
+'</tr></table></td>'
<%
} else {
%>
	+'<td><input type="hidden" name="ans_num" value="1"><input type="text" name="ans_content" size="70" class="inputG"></td><Td><input type="checkbox" name="ans_order" value="1" onclick="check_joo(this.value);"></tD>'

<%
}
%>
	+'</tr><tr>'
	+'<input type="hidden" name="ans_img" id="ans_img_2" value=""><input type="hidden" name="ans_hot7_ocode" id="ans_hot7_ocode_2" value=""><input type="hidden" name="ans_etc" id="ans_etc_2">'
<% 
	if (question_option.equals("4")){
%>
+'<td> <input type="hidden" name="sel_inx" value="2"> <input type="hidden" name="ans_num" value="2"><input type="text" name="ans_content" size="35" class="inputG"></td><td align="right"><table width="220" border="0" cellspacing="0" cellpadding="0" bgcolor="#DBE2C9"><tr>'

<%
		if (info != null && info.size() > 0) {
			for ( int i = 0 ; i < info.size() ; i++) {
%>
	+'<td><input type="radio" name="radio_2" value=""></td>'
<%
			}
		}
%>
+'</tr></table></td>'
<%

} else {
%>
	+'<td> <input type="hidden" name="sel_inx" value="2"> <input type="hidden" name="ans_num" value="2"><input type="text" name="ans_content" size="70" class="inputG"></td><td><input type="checkbox" name="ans_order" value="2" onclick="check_joo(this.value);"></td>'

<%
}

}  /// question_option 5 가 아닐경우
%>

	+'<input type = "hidden" name = "defaultRow" value="0"><input type = "hidden" name = "maxRow" value="0"></td></tr><tr>'
<% if (question_option.equals("6")) { %>	
	+'<td colspan="4" width="100%">'
<%} else { %>
	+'<td colspan="2" width="100%">'
<%}%>
	+'<table width="100%" s cellspacing="0" border="0"><Tr><td><div id="addRowBlock" name="addRowBlock"></div></td></tr></table></td></tr></table></td></tr></table></div>';
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
							<td class="tdB" width="100">질 문  </td>
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
						<% }else if (question_option.equals("6")) {%>
						<tr>
						<td class="tdB" width="100">영상 선택</td>
						<td class="tdB">
						 	※ 영상 찾기를 눌러 영상을 선택하세요!
						</td>
						</tr>
						<% } else  {%>
						<tr>
							<td class="tdB" width="100">예문입력</td>
							<td class="tdB">
							 	※ 아래&nbsp;&nbsp;□&nbsp;&nbsp;박스 체크시 입력(기타) 입니다.
							</td>
						</tr>
						<% } %>
						<tr>
							<td colspan=2 width=100% class="tdB">
								<div id="answer" name="answer"></div>
							</td>
						</tr>
						<tr>
							<td height="1" bgcolor="#DBE2C9" colspan="2"></td>
						</tr>
						<tr>
							<td colspan='2' width="100%" class="tdB">
								<script>
				 
									document.write(inputTable);
								</script>
							</td>
						</tr>

						<tr>
							<td colspan=2 align=center>
								<table border="0" cellspacing="0" cellpadding="5">
									<tr>
										<td><a href="javascript:sub_question();">
											<img src="/vodman/include/images/but_save.gif" border="0"></a></td>
										<td><a href="javascript:frmMedia.reset();">
											<img src="/vodman/include/images/but_cancel.gif" border="0"></a></td>
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

//	 if (Number(f.defaultRow.value) > 2 ){
//       alert("더 이상 추가하실 수 없습니다.");
//        return;
//	} else{

		var mr = Number(f.maxRow.value) + 1;
		var dr = Number(f.defaultRow.value) + 1;
		f.maxRow.value = mr;
		f.defaultRow.value = dr;

		var sel_inx = mr+2;

		var html = "<div id=block" + mr + ">"
			+ "<table cellpadding='0' cellspacing='0' border='0' width='100%' style='margin-top:5px;'>"
			+"<input type='hidden' name='sel_inx' value='"+sel_inx+"'><input type='hidden' name='ans_num' value='"+sel_inx+"'>"
			+"<input type='hidden' name='ans_hot7_ocode' id='ans_hot7_ocode_"+sel_inx+"' value=''><input type='hidden' name='ans_img' id='ans_img_"+sel_inx+"' value=''>"
			+ "<tr>"
			+"			<td>"
			+"			<img src='/vodman/include/images/no_img02.gif' height='70' width='100'/> "
			+"			</td> "
<% 
if (question_option.equals("4")){
%>
			+"<td> <input type='text' name='ans_content' id='ans_content_"+sel_inx+"' size='50' class='inputG'></br><input type='text' name='ans_etc' id='ans_etc_"+sel_inx+"'  size='50' class='inputG'></td><td align='right'><table width='220' border='0' cellspacing='0' cellpadding='0' bgcolor='#DBE2C9'><tr>"
		<%
				if (info != null && info.size() > 0) {
					for ( int i = 0 ; i < info.size() ; i++) {
		%>
			+"<td><input type='radio' name='radio_'"+mr+" value=''></td>"
		<%
					}
				}
		%>
			+"</tr></table><input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'></br><input type='button' value='영상찾기' class='input' onClick='find_movie(" + sel_inx + ");'></td>"
		<%

} else {
%>

			+ "<td> <input type='text' name='ans_content'  id='ans_content_"+sel_inx+"' size='50' class='inputG'></br><input type='text' name='ans_etc'  id='ans_etc_"+sel_inx+"' size='50' class='inputG'></td>"
			+"<td><input type='checkbox' name='ans_order' value='"+sel_inx+"' onclick='check_joo(this.value);'></td><td><input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'></br><input type='button' value='영상찾기' class='input' onClick='find_movie(" + sel_inx+ ");'></td>"
<% } %>
			+ "</tr>";
			+ "</table>";
			+ "</div>";
			document.getElementById('addRowBlock').insertAdjacentHTML("BeforeEnd", html);
//   }
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
				+ "<input type='hidden' name='sel_inx' value='"+sel_inx+"'><input type='hidden' name='ans_num' value='"+sel_inx+"'>"
				+ "<input type='hidden' name='ans_hot7_ocode' id='ans_hot7_ocode_"+sel_inx+"' value=''><input type='hidden' name='ans_img' id='ans_img_"+sel_inx+"' value=''><input type='hidden' name='ans_etc'  id='ans_etc_"+sel_inx+"'> "
				+ "<tr>"
<% 
	if (question_option.equals("4")){
%>
				+"<td> <input type='text' name='ans_content' size='35' class='inputG'><input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'></td><td align='right'><table width='220' border='0' cellspacing='0' cellpadding='0' bgcolor='#DBE2C9'><tr>"
			<%
					if (info != null && info.size() > 0) {
						for ( int i = 0 ; i < info.size() ; i++) {
			%>
				+"<td><input type='radio' name='radio_'"+mr+" value=''></td>"
			<%
						}
					}
			%>
				+"</tr></table></td>"
			<%

} else {
%>

				+ "<td> <input type='text' name='ans_content' size='70' class='inputG'><input type='button' value='삭제' class='input' onClick='deleteRow(" + mr + ");'></td><td><input type='checkbox' name='ans_order' value='"+sel_inx+"' onclick='check_joo(this.value);'></td>"
<% } %>
				+ "</tr>";
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
