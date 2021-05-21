<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file="/vodman/include/auth.jsp"%>
<%
	String sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">",""); 
	if(sub_idx == null){
		out.println("<script lanauage='javascript'>alert('미디어 코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
	}
	String question_idx = request.getParameter("question_idx").replaceAll("<","").replaceAll(">",""); 
	if(question_idx == null){
		out.println("<script lanauage='javascript'>alert('미디어 코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
	}
	String sub_flag = "S"; // S - 설문 ,  E - 이벤트
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
	SubjectManager mgr = SubjectManager.getInstance();
    Vector Vt_sub = mgr.getSubject(sub_idx);
	String sub_title = "";
	if (Vt_sub != null && Vt_sub.size() > 0) {
		sub_title =  String.valueOf(Vt_sub.elementAt(1));
	}
	Vector Vt = mgr.getSubject_Question(question_idx);


//	String question_idx = "";
//	String sub_idx = "";
	String question_content = "";
	String question_option = "";
	String question_info = "";
	String question_etc = "";
	String question_num = "";
	String question_image = "";


if (Vt != null && Vt.size() > 0 ) {
		 question_idx = String.valueOf(Vt.elementAt(0));
		 sub_idx = String.valueOf(Vt.elementAt(1));
		 question_content =  String.valueOf(Vt.elementAt(2));
		 question_option = String.valueOf(Vt.elementAt(3));
		 question_info = String.valueOf(Vt.elementAt(4));
		 question_etc = String.valueOf(Vt.elementAt(5));
		 question_num = String.valueOf(Vt.elementAt(6));
		 question_image = String.valueOf(Vt.elementAt(7));
		 
}


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
</head>

<script language="javascript">
	function rdoChecked( radioValue, order){ 
        if("4" == order){ 
            document.getElementById('first_one').style.display = ''; 
            document.getElementById('first_two').style.display = 'none'; 
            document.subQuestion.question_etc.value='';
        }else if("3" == order){ 
            document.getElementById('first_two').style.display = ''; 
            document.getElementById('first_one').style.display = 'none'; 
            document.subQuestion.question_info.value='';
        }else if("6" == order){  // 영상등록
            document.getElementById('first_two').style.display = ''; 
            document.getElementById('first_one').style.display = 'none'; 
            document.subQuestion.question_info.value='';
        }else{ 
			document.getElementById('first_two').style.display = 'none'; 
            document.getElementById('first_one').style.display = 'none'; 
            document.subQuestion.question_etc.value='';
            document.subQuestion.question_info.value='';
        } 
    }
    function go_aquestionAdd(){
		var f = document.subQuestion;
		if(f.question_num.value == ""){
			alert("번호를 입력 하세요!");
			f.question_num.focus();
			return;
		}
		
		if(f.question_content.value == ""){
			alert("설문문항을 입력 하세요!");
			f.question_content.focus();
			return;
		}

		document.subQuestion.submit();
	}
</script>

<body leftmargin="5" topmargin="0" marginwidth="0" marginheight="0" scrolling="auto">
<form name="subQuestion" method="post" action="proc_subjectQuestionUpdate.jsp?sub_idx=<%=sub_idx%>&question_idx=<%=question_idx%>&sub_flag=<%=sub_flag%>" enctype="multipart/form-data">
<input type="hidden" name="sub_idx" value="<%=sub_idx%>">
<input type="hidden" name="question_idx" value="<%=question_idx%>">

<table width="600" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">
		<table width=100% border=0 cellpadding=0 cellspacing=0 align="center">
			<tr>
				<td align="center">
					<table width="100%" border=0 cellpadding=3 cellspacing=0 align="center">
						<tr bgcolor="#dbe2ed">
							<td  colspan="2">&nbsp;&nbsp;▶&nbsp;<%=sub_title%></td>
						</tr>
						<tr >
							<td  colspan="2" height="10"> </td>
						</tr>

						<tr>
							<td class="tdB" width="80">번호</td>
							<td class="tdB">
								<input name="question_num" type="text" size="5" class="inputG" value="<%=question_num%>">
							</td>
						</tr>
						
						<tr>
							<td class="tdB" width="80">설문 문항입력</td>
							<td class="tdB">
								<input name="question_content" type="text" size="70" class="inputG" value="<%=question_content%>">
							</td>
						</tr>
						<tr>
							<td class="tdB" width="80">옵션</td>
							<td class="tdB">
								<input name="question_option" type="radio" size="5" onclick='rdoChecked(this,1)' <% if (question_option.equals("1")) { out.println("checked"); } %> value="1">단일선택&nbsp;&nbsp;
								<% if (sub_flag.equals("S")|| sub_flag.equals("H")) { %>
								<input name="question_option" type="radio" size="5" onclick='rdoChecked(this,2)'  <% if (question_option.equals("2")) { out.println("checked"); } %> value="2">다중선택(무제한)&nbsp;&nbsp;
								<input name="question_option" type="radio" size="5" onclick='rdoChecked(this,3)'  <% if (question_option.equals("3")) { out.println("checked"); } %> value="3">다중선택(제한)&nbsp;&nbsp;
								<input name="question_option" type="radio" size="5" onclick='rdoChecked(this,4)'  <% if (question_option.equals("4")) { out.println("checked"); } %> value="4">다중선택(반복)&nbsp;&nbsp;
								<% if (sub_flag.equals("H")) { %></br><input name="question_option" type="radio" size="5" onclick='rdoChecked(this,6)' <% if (question_option.equals("6")) { out.println("checked"); } %>value="6">영상선택&nbsp;&nbsp;
								<%} } %>
								<input name="question_option" type="radio" size="5" onclick='rdoChecked(this,5)'  <% if (question_option.equals("5")) { out.println("checked"); } %> value="5">입력(객관식)&nbsp;&nbsp;
							</td>
							<br />
						</tr>
						<tr>
							<td colspan="2">
								<div id='first_one' <%if(question_option!=null && question_option.equals("4"))out.println("style='display:'"); else out.println("style='display:none;'"); %>>
									<table width="100%" border=0 cellpadding=3 cellspacing=0 align="center">
									<tr>
										<td width="60">구분자</td>
										<td>
											<input name="question_info" type="text" size="50" maxlength="50" class="inputG" value="<%=question_info %>">
											※ 구분자는 (,)콤마로 구분됩니다.
										</td>
									</tr>
								</table>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div id='first_two' <%if(question_option!=null && ( question_option.equals("3") || question_option.equals("6") ))out.println("style='display:'"); else out.println("style='display:none;'"); %>>
								<table width="100%" border=0 cellpadding=3 cellspacing=0 align="center">
									<tr>
										<td width="80">다중선택 갯수</td>
										<td>
											<input name="question_etc" type="text" size="20" maxlength="50" class="inputG" value="<%=question_etc %>"> 개
										</td>
									</tr>
								</table>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="tdB">
								<table width="100%" border=0 cellpadding=0 cellspacing=0 align="center">
									<tr>
										<td width="80">이미지</td>
										<td><input name="question_image" type="file" size="60" class="inputG" value=''> </td>
									</tr>
									<% if (question_image != null && question_image.length() > 0) { %>
									<tr>
										<td >&nbsp;삭제&nbsp;<input type='checkbox' name='question_image_del' value='delete'></td><td>&nbsp;<%=question_image%></td>
									</tr>
									<% } %>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan=2 align=center>
								<table border="0" cellspacing="0" cellpadding="5">
									<tr>
										<td><a href="javascript:go_aquestionAdd();"><img src="/vodman/include/images/but_addi.gif" border="0"></a></td>
										<td><a href="javascript:subQuestion.reset();"><img src="/vodman/include/images/but_cancel.gif" border="0"></a></td>
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
</form>
</body>
</html>
