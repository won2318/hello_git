<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="subjectbean" class="com.vodcaster.sqlbean.SubjectSqlBean"/>

<%
	/**
	 * @author 주현
	 *
	 * @description : 설문생성
	 * date : 2008-03-25
	 */
	//SubjectManager mgr = SubjectManager.getInstance();
//	int result = mgr.insert_subject(request);

    request.setCharacterEncoding("euc-kr");
	String sub_flag = "E"; // S - 설문 ,  E - 이벤트
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
    try {
		int result = subjectbean.insert_subject(request);


		if(result >= 0){
			
			out.println("<script language='javascript'>location.href='frm_subjectList.jsp?sub_flag="+sub_flag+"'</script>");
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