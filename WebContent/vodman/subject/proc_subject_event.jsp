<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
<jsp:useBean id="subjectbean" class="com.vodcaster.sqlbean.SubjectSqlBean"/>

<%
	/**
	 * @author 주현
	 *
	 * @description : 설문생성
	 * date : 2008-03-25
	 */

    request.setCharacterEncoding("euc-kr");
	String sub_flag = "";  
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
	String sub_idx = "";  
	if(request.getParameter("sub_idx") != null && request.getParameter("sub_idx").length()>0){
		sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">","");
	}
	String people = "";
	if(request.getParameter("people") != null && request.getParameter("people").length()>0){
		people = request.getParameter("people").replaceAll("<","").replaceAll(">","");
	}

	int result = subjectbean.getEvent_userList(sub_idx, Integer.parseInt(people));


	if(result >= 0){
		if(Integer.parseInt(people) > result ){
			out.println("<script language='javascript'>alert('추첨인원("+people+")이  중복(연락처, 이메일)되므로 중복된 인원("+(Integer.parseInt(people)-result)+")을 제외한 인원("+result+")만 당첨됩니다.');</script>");
		}
		out.println("<script language='javascript'>location.href='/vodman/subject/frm_subject_event.jsp?sub_flag="+sub_flag+"&sub_idx="+sub_idx+"'</script>");
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('접속자수가 너무 많습니다. 잠시후에 다시 시도하여 주세요.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}

%>