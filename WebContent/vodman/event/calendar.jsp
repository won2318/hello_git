<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.yundara.util.CharacterSet,com.vodcaster.utils.TextUtil,com.yundara.util.TimeUtil,java.util.Date,
                 com.hrlee.sqlbean.*,
				 com.vodcaster.sqlbean.*,
                 java.util.Vector,
                 java.util.Enumeration,
                 java.util.Hashtable"%>

<%
    PlanManager mgr = PlanManager.getInstance();

	String num_month = request.getParameter("num_month");
    String year = request.getParameter("year");
    String mode = request.getParameter("mode");

	if(num_month == null) {
		num_month = TimeUtil.getCurDate().substring(4,6);
    }
    String str_month = com.yundara.util.TextUtil.zeroFill(1,2,num_month);

 	if(year == null) {
		year = TimeUtil.getCurDate().substring(0,4);
    }

    if(mode == null) {
        mode = "1";
    }


    int day = 1;
    String prevmonth = "";
    String nextmonth = "";
	if (Integer.parseInt(num_month) - 1 < 10) {
		prevmonth = "0" + (Integer.parseInt(num_month) - 1);
	} else {
		prevmonth = "" + (Integer.parseInt(num_month) - 1);
	}
	if (Integer.parseInt(num_month) + 1 < 10) {
		nextmonth = "0" + (Integer.parseInt(num_month) + 1);
	} else {
		nextmonth = "" + (Integer.parseInt(num_month) + 1);
	}
    int prevyear = Integer.parseInt(year) - 1;
    int nextyear = Integer.parseInt(year) + 1;

    String left_arrow = "";
    String right_arrow = "";
    if(Integer.parseInt(num_month) > 1)
        left_arrow = "<a href='calendar.jsp?num_month=" +prevmonth+ "&year=" +year+ "&mode=" +mode+ "'><img src='/vodman/include/images/mini_calendar_05.gif' alt='이전달' width='10' border='0' height='10'></a>";
    else {
        String new_month1 = "12";
        left_arrow = "<a href='calendar.jsp?num_month=" +new_month1+ "&year=" +prevyear+ "&mode=" +mode+ "'><img src='/vodman/include/images/mini_calendar_05.gif' alt='이전달' width='10' border='0' height='10'></a>";
    }


    if(Integer.parseInt(num_month) == 12) {
        String new_month2 = "01";
        right_arrow = "<a href='calendar.jsp?num_month=" +new_month2+ "&year=" +nextyear+ "&mode=" +mode+ "'><img src='/vodman/include/images/mini_calendar_03.gif' alt='다음달' width='10' height='10' border='0'></a>";
    } else if(Integer.parseInt(num_month) < 12) {
        right_arrow = "<a href='calendar.jsp?num_month=" +nextmonth+ "&year=" +year+ "&mode=" +mode+ "'><img src='/vodman/include/images/mini_calendar_03.gif' alt='다음달' width='10' height='10' border='0'></a>";
	}


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<script language="javascript">
<!--
    function rtn_date(year,month,day,mode) {
        if(mode == "1") {
            opener.document.frmMedia.rstime1.value = year;
            opener.document.frmMedia.rstime2.value = month;
            opener.document.frmMedia.rstime3.value = day;
            opener.document.frmMedia.rstime4.focus();
            window.close();
        }else if(mode == "2") {
            opener.document.frmMedia.retime1.value = year;
            opener.document.frmMedia.retime2.value = month;
            opener.document.frmMedia.retime3.value = day;
            opener.document.frmMedia.retime4.focus();            
            window.close();
        } else {
			opener.document.frmMedia.pubtime1.value = year;
            opener.document.frmMedia.pubtime2.value = month;
            opener.document.frmMedia.pubtime3.value = day;
              
            window.close();
		}
    }

//-->
</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

 <table width="174" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="center">
	  <table width="174" height="123" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" valign="top" bgcolor="#FFFFFF">
            <!-- 갤린더 테이블-->
            <table width="161" border="0" cellpadding="2" cellspacing="0">
              <tr>
                <td height="25" colspan="7" class="small">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td class="small"><%=year%>년 <%=num_month%>월</td>
                      <td align="right">
					  <table width="20" border="0" cellspacing="2" cellpadding="0">
                          <tr> 
                            <td><%=left_arrow%></td>
                            <td><%=right_arrow%></td>
                          </tr>
                        </table>
						</td>
                    </tr>
                  </table> </td>
              </tr>
              <tr> 
                <td align="center"><img src="/vodman/include/images/mini_calendar_10.gif" width="23" height="13"></td>
                <td align="center"><img src="/vodman/include/images/mini_calendar_11.gif" width="23" height="13"></td>
                <td align="center"><img src="/vodman/include/images/mini_calendar_12.gif" width="23" height="13"></td>
                <td align="center"><img src="/vodman/include/images/mini_calendar_13.gif" width="23" height="13"></td>
                <td align="center"><img src="/vodman/include/images/mini_calendar_14.gif" width="23" height="13"></td>
                <td align="center"><img src="/vodman/include/images/mini_calendar_15.gif" width="23" height="13"></td>
                <td align="center"><img src="/vodman/include/images/mini_calendar_16.gif" width="23" height="13"></td>
              </tr>
              <tr> 
                <td height="3" colspan="7"></td>
              </tr>
              <%


    while(mgr.validDate(year, num_month, String.valueOf(day))){

        for(int m=0; m<7; m++){

            String[] color = {"#E8741D","#333333","#333333","#333333","#333333","#333333","#3789B8"};

            boolean check = mgr.validDate(year, num_month, String.valueOf(day));

            if(check){

                com.yundara.util.TimeTerm tm = new com.yundara.util.TimeTerm(Integer.parseInt(year),Integer.parseInt(num_month),day,0,0);
                //long checkday = tm.getMTime();

                //String eng_month = mgr.getWeekDay(year + num_month + day);

                Date d = new Date(Integer.parseInt(year)-1900, Integer.parseInt(num_month)-1, day);

                if(m == d.getDay()){

                    String font_color= "";
                    String link_day = "";
                    String str_day = com.yundara.util.TextUtil.zeroFill(1,2,day);
                    //String date_str = "";

                    font_color = color[m];
                    link_day = String.valueOf(day);
                    out.println("<td align='center' onClick=\"javascript:rtn_date('" +year+ "','" +num_month+ "','" +str_day+ "','" +mode+ "')\" class='small' style='cursor:hand' onMouseOver=\"this.style.backgroundColor='#F6F6F6'\" onMouseOut=\"this.style.backgroundColor=''\"><font color='" +font_color+ "'>" +link_day+ "</font></td>");
                    day++;

                }else{
                    out.println("<td align='center' class='small'>&nbsp;</td>");
				}

			}else{
				out.println("<td align='center' class='small'>&nbsp;</td>");
			}
		}

		out.println("</tr>");
	}

%>
            </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
<table width="174" height="10" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td></td>
  </tr>
</table>
</body>
</html>

