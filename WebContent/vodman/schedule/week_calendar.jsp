<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "r_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%!
	public static String setOperationDate(String inputDateYear,String inputDateMonth,String inputDateDay, String mode, int value){
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd"); 
		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(inputDateYear),Integer.parseInt(inputDateMonth)-1,Integer.parseInt(inputDateDay)); 

		if(mode.equals("plus")){
			cal.add(cal.DATE,value); //���糯¥�� value ���� ���Ѵ�. 
		}else if(mode.equals("minus")){
			cal.add(cal.DATE,-value); //���糯¥�� value ���� ����. 
		}

		Date date = cal.getTime(); //����� ���ڸ� ����. 
		String setDate = fmt.format(date); 

		return setDate;
	}

%>

<%

	String strParamDay = "";
	String strYear = "";
    String strMonth = "";
    String strDay = "";
	if(request.getParameter("param_day") != null && request.getParameter("param_day").length()>0){
		strParamDay = request.getParameter("param_day");
		strYear = strParamDay.substring(0,4);
		strMonth = strParamDay.substring(5,7);
		strDay = strParamDay.substring(8,10);
	}else{
		strYear = TimeUtil.getCurDate("yyyy-MM-dd").substring(0,4);
		strMonth = TimeUtil.getCurDate("yyyy-MM-dd").substring(5,7);
		strDay = TimeUtil.getCurDate("yyyy-MM-dd").substring(8,10);
	}
   

	Calendar now = Calendar.getInstance();
    now.set(Integer.parseInt(strYear), Integer.parseInt(strMonth)-1, Integer.parseInt(strDay));
	  //���� �ش� ������ ���� ���Ѵ�.
    int curDate = now.get(now.DAY_OF_WEEK);
    int curWeek = now.get(now.WEEK_OF_MONTH);
	int curDayOfWeek = now.get(Calendar.WEEK_OF_YEAR);


	String getNextDate = setOperationDate(strYear,strMonth,strDay,"plus",7);
	String getPreDate = setOperationDate(strYear,strMonth,strDay,"minus",7);

	String preWeekDay = "";
	String nextWeekDay = "";

	
	nextWeekDay = getNextDate;
	preWeekDay = getPreDate;
	
	
   String[] week = {"��","��","ȭ","��","��","��","��"};

   out.println();

    int curYear = 0;
    int curMonth = 0;
    int curDay = 0;
    int curTime = 0;
    
  //�Ͽ���(���� 1)�������� �ش� ������ �Ͽ����� �ƴϸ� ���� �������̶�� ���ú��� �׸�ŭ
    //���ش�. �׸��� �������� �ٲ� �� ������ ���Ӱ� ���Ѵ�.
    final int INSUNDAY = 0;
    if (curDate!=INSUNDAY) {
		now.set(Integer.parseInt(strYear), Integer.parseInt(strMonth)-1, Integer.parseInt(strDay)-curDate+1);
        curYear = now.get(Calendar.YEAR);
        curMonth = now.get(Calendar.MONTH)+1;
        curDay = now.get(Calendar.DATE);
        curTime = now.get(Calendar.HOUR_OF_DAY);
    }
%>

<html>
<head>
<title> �޷� </title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
<link rel="stylesheet" href="schedule.css" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--

	window.onload = function() {
		top.schedule_list.location = "schedule_list.jsp?clickDate=<%=strYear+strMonth+strDay%>";
	}
	
	function go_link(clickDate) {
		var year = clickDate.substring(0,4);
		var month = clickDate.substring(5,7);
		var day = clickDate.substring(8,10);
		document.location = "week_calendar.jsp?param_day="+clickDate;
		top.cal_month.location = "month_calendar.jsp?num_month="+month+"&year="+year+"&clickDate="+clickDate.replace("-","");
}


//-->
</script>
</head>
<body>
	<div class="detail_tab">
<%
	
	int iTmp = 6;
	int iVisibleDay = -1;
	
	
	

	
	for(int i=0; i<7; i++) {
		
		Calendar em = Calendar.getInstance();
		em.set(curYear,curMonth-1,curDay+i);

		int nextYear = em.get(Calendar.YEAR);
		int nextMonth = em.get(Calendar.MONTH) + 1;
		int nextDay = em.get(Calendar.DATE);

		String tmpYear = TextUtil.zeroFill(1,2,nextYear);
		String tmpMonth = TextUtil.zeroFill(1,2,nextMonth);
		String tmpDay = TextUtil.zeroFill(1,2,nextDay);

		String date_str = tmpYear+"-"+tmpMonth+"-"+tmpDay;

%>
	<span class="tab<%=i+1%> tab_ttl_<%=tmpDay.equals(strDay)?"on":"off"%>" onclick="go_link('<%=date_str%>')"><%=week[i]%><br /><%=nextMonth%>.<%=nextDay%></span>
<%
	} 
%>
</div>
	
</body>
</html>