<%--
date   : 2007-07-04
작성자 : 주현
내용   : vod 등록  

	openflag - 공개, 비공개
	user_id, user_pwd - 등록자 아이디, 등록 비밀번호

--%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<%@ include file = "/vodman/include/auth.jsp"%>
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
	/**
	 * @author 이희락
	 *
	 * description : 주문형 VOD 정보 등록
	 * date : 2007-09-05
	 */

//	 VOD로 초기화
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
		//out.println("<script lanauage='javascript'>alert('미디어코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
	} else
		ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

										<%-- xap 파일을 호출해야 한다.  --%> 
<iframe src="/VODManagerTestPage.jsp?type=M&ocode=<%=ocode%>" width=950 height=600></iframe>

</body>
</html>
