<%--
date   : 2007-07-04
�ۼ��� : ����
����   : vod ���  

	openflag - ����, �����
	user_id, user_pwd - ����� ���̵�, ��� ��й�ȣ

--%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
	if(!chk_auth(vod_id, vod_level, "v_write")) {
	    out.println("<script language='javascript'>\n" +
	                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
	                "history.go(-1);\n" +
	                "</script>");
	    return;
	} 
%>
<%
	/**
	 * @author �����
	 *
	 * description : �ֹ��� VOD ���� ���
	 * date : 2007-09-05
	 */

//	 VOD�� �ʱ�ȭ
	String type = request.getParameter("type");
	if(type == null || (type != null && type.length()<=0))
		type = "M";

	 Calendar cal = Calendar.getInstance();
		int year  = cal.get(Calendar.YEAR),
		    month = cal.get(Calendar.MONTH)+1,
		    date = cal.get(Calendar.DATE),
		hour = cal.get(Calendar.HOUR_OF_DAY),
		min = cal.get(Calendar.MINUTE),
		sec = cal.get(Calendar.MILLISECOND);
		 
		
	String temp_month = "";
	String temp_date="";
	if (month <= 9) {
		temp_month = "0"+ month;
		} else {
			temp_month = Integer.toString(month);
		}
	if (date <= 9) {
		temp_date = "0"+ date;
		} else {
			temp_date = Integer.toString(date);
		}
	
	String today = year+"-"+temp_month+"-"+temp_date;
	String tcode = year+temp_month+temp_date+hour+min+sec;
	
	String ocode = "";
	
	if(request.getParameter("ocode") == null) {
		//out.println("<script lanauage='javascript'>alert('�̵���ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
	} else
		ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

										<%-- xap ������ ȣ���ؾ� �Ѵ�.  --%> 
<iframe src="/VODManagerTestPage.jsp?type=M&ocode=<%=ocode%>" width=950 height=600></iframe>

</body>
</html>
