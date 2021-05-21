<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%

String year = "2007";
String month = "10";
String year_month="";

	if(request.getParameter("year_month") != null) {
		year_month = String.valueOf(request.getParameter("year_month").replaceAll("<","").replaceAll(">",""));
	}
	if (year_month != null && year_month.length()> 0) {
	 year = year_month.substring(0,4);
	 month = year_month.substring(4,6);
		
	}


String day = year+month;
String type = "W";
if(request.getParameter("type") != null) {
	type = String.valueOf(request.getParameter("type"));
}

int month_count = 0;
String month_contact_count = stat.getStatMonthS(day, type);
 if (month_contact_count != null && month_contact_count.length() >0) {
	try{
		month_count = Integer.parseInt(month_contact_count);
	}catch(Exception e){
		month_count = 0;
	}
 }
%>




<html>
<head>
<title>접속 통계</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/include/css/style.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table width="640" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
<!-- main start-->
                        <table width=640 border=0 cellpadding=0 cellspacing=0>
                          <tr>
                            <td>
							  <table width="640" border="0" cellspacing="0" cellpadding="0" align="center">
							    <tr>
								  <td height="30" width="50%" valign="bottom"> <%=year%>년 <%=month%>월 접속통계</td>
								  <td height="30" width="50%" valign="bottom" align="right"><a href="stat_month_excel.jsp?year_month=<%=year_month%>"><img src="/vodman/include/images/excel_view.gif" border="0"></a><a href="javascript:window.print();">[인쇄]</a></td>
								</tr>
								<tr>
								  <td height="5" colspan="2" valign="bottom"></td>
								</tr>
							  </table>

							  <table width="640" border="0" cellspacing="1" cellpadding="3" bgcolor="#DBE2C9" align="center">

								<tr valign="bottom">
								  <td align="center" class="font1" bgcolor="#F3F3F3" height="250" colspan="3">
								    <br>
									<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" height="240" width="640">
									  <tr>
									    <td bgcolor="#FFFFFF" valign="bottom" background="/vodman/include/images/gra1_back.gif">
										  <table cellpadding="0" cellspacing="0" border="0" width="100%">
										  <tr>
										  	  <td height="30" colspan="3" align="right">총 <%=month_count%> 건&nbsp;&nbsp;</td>
										  </tr>
										  <Tr>
										  <td colspan="3" height="3" bgcolor="#DBE2C9"></tD>
										  </tr>

											<% 

											Calendar cal = Calendar.getInstance ( );
											cal.set ( Integer.parseInt (year), Integer.parseInt (month ) - 1, 1 );

												int end_day =  ( cal.getActualMaximum ( Calendar.DATE ) );
												int day_cnt = 0;

												for (int i = 1; i <= end_day ; i++ ) { 
													if (i < 10){
														day = year + month+"0"+ i ;
												    } else {
														day = year + month + i ;
													}

												day_cnt = stat.getMonthStatDay(day);
												%>


							<TR>
                              <td width="15%" height="15"><%=year%>년 <%=month%>월 <%=i%>일</tD>
							  <TD width="20%" align="right"><%=day_cnt%>건&nbsp;</TD>
                              <TD width="65%" valign="middle"><IMG height=12 src="/vodman/include/images/graph.gif" width="<%= Math.round( (day_cnt / (double)month_count )*100) %>%"><%= Math.round( (day_cnt / (double)month_count )*100) %>%</TD>
                              </TR>
							  <Tr>
							  <td colspan="3" height="3" bgcolor="#DBE2C9"></tD>
							  </tr>


											

											<%  } %>

											
										  </table>
										</td>
									  </tr>
									</table>
									<br>
								  </td>
								</tr>
								
							  </table>
							</td>
						  </tr>
                        </table>
                        <!-- main end-->
	</td>
  </tr>
</table>
</body>

</html>

