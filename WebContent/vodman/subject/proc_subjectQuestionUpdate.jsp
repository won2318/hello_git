<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="subjectbean" class="com.vodcaster.sqlbean.SubjectSqlBean"/>

<%
    request.setCharacterEncoding("euc-kr");


	String sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">",""); 
	if(sub_idx == null){
		out.println("<script lanauage='javascript'>alert('�̵�� �ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
	}
	String question_idx = request.getParameter("question_idx").replaceAll("<","").replaceAll(">",""); 
	if(question_idx == null){
		out.println("<script lanauage='javascript'>alert('�̵�� �ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
	}

	String sub_flag = "S"; // S - ���� ,  E - �̺�Ʈ
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
			out.println("alert('�����ڼ��� �ʹ� �����ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}
    } catch(Exception e){
        System.out.println(e);
    }

%>