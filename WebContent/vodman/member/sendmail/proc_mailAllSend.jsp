<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/admin/adminMember/security.jsp"%>

<%
/*********************************************************************************
Description :
*********************************************************************************/
%>

<jsp:useBean id="emailSQLBean" class="com.vodcaster.utils.EmailSQLBean"/>
<jsp:useBean id="CharacterSet" class="com.yundara.util.CharacterSet"/>
<jsp:useBean id="convertHtmlBean" class="com.vodcaster.utils.ConvertHtmlBean"/>
<jsp:useBean id="addressSQLBean" class="com.lifelong.sqlbean.AddressSQLBean"/>
<jsp:useBean id="emailTransferBean" class="com.vodcaster.utils.EmailTransferBean"/>
	<%

		String title = CharacterSet.toKorean( request.getParameter("title") );
		String message = CharacterSet.toKorean( request.getParameter("message") );

		String chkFlag =  "2";
		if( request.getParameter("chkFlag") != null ) chkFlag = request.getParameter("chkFlag");
		if(!chkFlag.equals("1")){
			message = convertHtmlBean.getContent(message);
		}

		/******************************************************************************
		 ��üȸ�� ����Ʈ
		******************************************************************************/
		Vector v = null;
		try{
			v = addressSQLBean.getAddressBookList("","","ALL");
		}catch(NullPointerException e){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}

		int result_flag =0;

		String email [] = new String[v.size()];

		for(int i = 0; i < v.size(); i++) {
			email[i] = String.valueOf(((Vector)(v.elementAt(i))).elementAt(3));
		}


		result_flag = emailTransferBean.sendAllMember("�泲���б����������","ad_life@cnu.ac.kr",email,title,message);

		if(result_flag > 0){
			out.println("<script language=javascript>");
			out.println("alert('��ü������ ������Ƚ��ϴ�.');");
			out.println("document.location='/admin/group/sendEmail/frm_allEmailSend.jsp';");
			out.println("</script>");

		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}
%>
