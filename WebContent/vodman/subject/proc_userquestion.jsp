<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
<jsp:useBean id="subjectbean" class="com.vodcaster.sqlbean.SubjectSqlBean"/>

<%
	/**
	 * @author ����
	 *
	 * @description : ��������
	 * date : 2008-03-25
	 */
	//SubjectManager mgr = SubjectManager.getInstance();
//	int result = mgr.insert_subject(request);

    request.setCharacterEncoding("euc-kr");
	String sub_flag = "S"; // S - ���� ,  E - �̺�Ʈ
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
	String question_idx = "";
	if(request.getParameter("question_idx") != null && request.getParameter("question_idx").length()>0){
		question_idx = request.getParameter("question_idx").replaceAll("<","").replaceAll(">","");
	}

 

%>