<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%

 
String to_day = "";

if (request.getParameter("to_day") != null && request.getParameter("to_day").length() > 0) {
	to_day =  request.getParameter("to_day").replaceAll("<","").replaceAll(">","");
}
String type = "W";
if(request.getParameter("type") != null && request.getParameter("type").length() > 0) {
	type = String.valueOf(request.getParameter("type").replaceAll("<","").replaceAll(">",""));
}
 
Vector row = stat.getStatDayS(to_day, type);
Vector col= null; 

int max_height=1;
int val=0;

if(row != null && row.size()>0){
	for(int i=0; i<row.size(); i++)
	{
		col=(Vector)row.elementAt(i);

		try{
			val = Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			if(val>max_height)
				max_height=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
		}catch(Exception e){System.out.println("#21. "+e); }
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
								  <td height="30" width="50%" valign="bottom"> <%=to_day%> 접속통계</td>
								  <td height="30" width="50%" valign="bottom" align="right"><a href="stat_day_excel.jsp?to_day=<%=to_day%>"><img src="/vodman/include/images/excel_view.gif" border="0"></a><a href="javascript:window.print();">[인쇄]</a></td>
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
										  	  <td height="30" colspan="3" align="right">총 <%=max_height%> 건&nbsp;&nbsp;</td>
										  </tr>
										  <Tr>
										  <td colspan="3" height="3" bgcolor="#DBE2C9"></tD>
										  </tr>
<%

					

					if(row != null && row.size()>0){
						//그래프 출력
						for(int i=1; i<row.size(); i++)
						{
							col=(Vector)row.elementAt(i);
							int cnt=0;
							int height=0;
	
							try{
								cnt=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
								if(cnt < 0) cnt=0;
							}catch(Exception e){System.out.println("#31. "+e); cnt=0;}
	
							height=cnt*200/max_height;
						%>
							<tr>
							<td width="15%" height="15"><%=i%>시</tD>
							<TD width="20%" align="right"><%=cnt%>건&nbsp;</TD>
							<td width="65%" valign="middle"><img src="/vodman/include/images/graph.gif" height="12"  width="<%= height %>"></td>
							</tr>
							<tr>
							  <td colspan="3" height="3" bgcolor="#DBE2C9"></tD>
							</tr>
	                    <%
						}
					}
					%>


							 
									 
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

