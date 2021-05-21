<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat, java.util.Date"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");

if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

 
<%
	PlanManager mgr = PlanManager.getInstance();

	String num_month = request.getParameter("num_month").replaceAll("<","").replaceAll(">","");
    String year = request.getParameter("year").replaceAll("<","").replaceAll(">","");
    String selectday = request.getParameter("day").replaceAll("<","").replaceAll(">","");

	if(num_month == null) {
		num_month = TimeUtil.getCurDate().substring(4,6);
    }

    String str_month = com.yundara.util.TextUtil.zeroFill(1,2,num_month);


 	if(year == null) {
		year = TimeUtil.getCurDate().substring(0,4);
    }

    String org_month = TimeUtil.getCurDate().substring(4,6);
    String org_year = TimeUtil.getCurDate().substring(0,4);
    String org_day = TimeUtil.getCurDate().substring(6,8);

	int day = 1;
    int prevmonth = Integer.parseInt(num_month) - 1;
    int nextmonth = Integer.parseInt(num_month) + 1;
    int prevyear = Integer.parseInt(year) - 1;
    int nextyear = Integer.parseInt(year) + 1;


	String left_arrow = "";
    String right_arrow = "";
    if(Integer.parseInt(num_month) > 1)
        left_arrow = "schedule_calendar.jsp?day="+selectday+"&num_month=" +prevmonth+ "&year=" +year;
    else {
        String new_month1 = "12";
        left_arrow = "schedule_calendar.jsp?day="+selectday+"&num_month=" +new_month1+ "&year=" +prevyear;
    }


    if(Integer.parseInt(num_month) == 12) {
        String new_month2 = "1";
        right_arrow = "schedule_calendar.jsp?day="+selectday+"&num_month=" +new_month2+ "&year=" +nextyear;
    } else if(Integer.parseInt(num_month) < 12) {
        right_arrow = "schedule_calendar.jsp?day="+selectday+"&num_month=" +nextmonth+ "&year=" +year;
	}
    
    // ������ ��¥ üũ
    String clickDate = request.getParameter("clickDate").replaceAll("<","").replaceAll(">","");
    if(clickDate == null || clickDate.length() < 8) {
    	clickDate = TimeUtil.getCurDate().substring(0,8);
    }

	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
<link rel="stylesheet" href="schedule.css" type="text/css">


<script language="javascript">
<!--
	function go_link(clickDate) {
		var year = clickDate.substring(0,4);
		var month = clickDate.substring(4,6);

		document.location = "schedule_calendar.jsp?num_month="+month+"&year="+year+"&day=<%=selectday%>&clickDate="+clickDate;
	}

	function save() {
		var f = document.calForm;
		if(f.selectday.value == "") {
			alert("��ϵ� ���������ڰ� �����ϴ�.");
			window.close();
			return;
		}

		if(f.clickDate.value == "" || f.clickDate.value == f.selectday.value) {
			alert( "������ ��¥�� �������� �ʾҰų� ���õ� ��¥�� ����� ��¥�� �����ϴ�.");
			return;
		}
		if(confirm("������ ������ �������ðڽ��ϱ�? ���� ��ϵ� ������ �����˴ϴ�.")) {
			f.submit();
		}
	}
//-->
</script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="calForm" action="proc_onedayScheduleUpdate.jsp" method="post">
	<input type="hidden" name="selectday" value="<%=selectday%>" />
	<input type="hidden" name="clickDate" value="<%=clickDate%>" />
<table style="margin-left:20px" cellpadding="0" cellspacing="0" border="0" width="233">
				<tr height="30">
					<td class="sch_time3" align="center"><b>�ҷ��� ��¥�� �����ϼ���.</b></td>
				</tr>
				<tr>
					<td style="background: url(images/sch_bg2.gif) no-repeat; padding-top: 10px;height: 219px;" valign="top" align="center">
						<div class="border_type2">
							<table cellpadding="0" cellspacing="0" class="calendar_simple2" summary="�޷�">
								<caption>
									<a href="<%=left_arrow%>"><img src="images/but_sch_left.gif" width="14" height="14" alt="������"></a>
									<strong><%=year%>�� <%=num_month%>��</strong>
									<a href="<%=right_arrow%>"><img src="images/but_sch_right.gif" width="14" height="14" alt="������"></a>
								</caption>
								<thead>
								<tr>
								<th scope="col">��</th>
								<th scope="col">��</th>
								<th scope="col">ȭ</th>
								<th scope="col">��</th>
								<th scope="col">��</th>
								<th scope="col">��</th>
								<th scope="col">��</th>
								</tr>
								</thead>
								<tbody>
<%


    while(mgr.validDate(year, num_month, String.valueOf(day))){
		out.println("<tr>");

        for(int m=0; m<7; m++){


            boolean check = mgr.validDate(year, num_month, String.valueOf(day));
			String className = "";
            if(check){

                com.yundara.util.TimeTerm tm = new com.yundara.util.TimeTerm(Integer.parseInt(year),Integer.parseInt(num_month),day,0,0);
                //long checkday = tm.getMTime();

                //String eng_month = mgr.getWeekDay(year + num_month + day);

                Date d = new Date(Integer.parseInt(year)-1900, Integer.parseInt(num_month)-1, day);

                if(m == d.getDay()){

                    String link_day = "";
                    String str_date = "";

					link_day = String.valueOf(day);
					
					str_date = year+com.yundara.util.TextUtil.zeroFill(1,2,num_month)+ com.yundara.util.TextUtil.zeroFill(1,2,link_day);

					if(clickDate != null && clickDate.length() > 7 && clickDate.equals(str_date)) {
						out.println("<td><a href=\"javascript:go_link('"+str_date+"');\" title='"+str_date+"'><strong>"+link_day+"</strong></a></td>");
					} else {
						out.println("<td><a href=\"javascript:go_link('"+str_date+"');\" title='"+str_date+"'>" +link_day+ "</a></td>");
					}

                    day++;

                }else{
                    out.println("<td>&nbsp;</td>");
				}

			}else{
				out.println("<td>&nbsp;</td>");
			}
		}

		out.println("</tr>");
	}



%>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="but01">
							<a href="javascript:save();" title="Ȯ��"><img src="images/bu_confirm.gif" alt="Ȯ��"/></a>
							<a href="javascript:window.close();" title="���"><img src="images/bu_cancel.gif" alt="���"/></a>
						</div>
					</td>
				</tr>
			</table>
			
</body>
</html>