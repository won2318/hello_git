<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="subjectbean" class="com.vodcaster.sqlbean.SubjectSqlBean"/>

<%
    request.setCharacterEncoding("euc-kr");


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
    try {
		int result = subjectbean.update_question(request);


		if(result >= 0){
			
			//out.println("<script language='javascript'>location.href='frm_subjectQuestionUpdate.jsp?sub_idx="+sub_idx+"&question_idx="+question_idx+"'</script>");
			out.println("<script language='javascript'>opener.location.reload();self.close();</script>");
		}
		else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('접속자수가 너무 많습니다. 잠시후에 다시 시도하여 주세요.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}
    } catch(Exception e){
        System.out.println(e);
    }

%>