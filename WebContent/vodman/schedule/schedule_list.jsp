<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
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
	TimeMediaSqlBean bean = new TimeMediaSqlBean();

	String clickDate = request.getParameter("clickDate");
	if(clickDate == null || clickDate.length() <= 0) {
		clickDate = TimeUtil.getCurDate().substring(0,8);
	}

	String ccode = request.getParameter("ccode");
	if(ccode == null || ccode.length() <= 0) {
		ccode = "";
	}

	String ocode = request.getParameter("ocode");
	if(ocode == null || ocode.length() <= 0) {
		ocode = "";
	}

	String hour = request.getParameter("hour");
	if(hour == null || hour.length() <= 0) {
		hour = "";
	}

	String minute = request.getParameter("minute");
	if(minute == null || minute.length() <= 0) {
		minute = "";
	}
	
	String input_time = request.getParameter("input_time");
	if(input_time == null || input_time.length() <= 0) {
		input_time = "";
	}
	String middle = request.getParameter("middle");
	if(middle == null || middle.length() <= 0) {
		middle = "";
	}
 
	String ccode_group = request.getParameter("ccode_group");
    String ocode_group = request.getParameter("ocode_group");
    
   	String input_schedule="";
   	
  	if(ocode.length() > 0 ) {
   			MediaManager mgr = MediaManager.getInstance();
   			Vector mediaVt = mgr.getOMediaInfo(ocode);
   			//OrderMediaInfoBean minfo = new OrderMediaInfoBean();
   			com.hrlee.silver.OrderMediaInfoBean minfo = new com.hrlee.silver.OrderMediaInfoBean();
   			try {
   				for(Enumeration e = mediaVt.elements(); e.hasMoreElements();) {
   					com.yundara.beans.BeanUtils.fill(minfo, (Hashtable)e.nextElement());
   				}
   			}catch(Exception e) {}

   			String runningtime = minfo.getPlaytime(); 
   			int result = bean.insertTimeMedia(ccode, ocode, clickDate, runningtime, hour, minute);

   			if(result == -1) {
   				out.println("<script language='javascript'>");
   				out.println("alert('���̻� �������� �߰��� �� �����ϴ�.');");
   				out.println("</script>");
   			} else if(result == -2) {
   				out.println("<script language='javascript'>");
   				out.println("alert('������ ���۽ð��� ����Ͽ� �ּ���.');");
   				out.println("</script>");
   			} else if(result == -99) {
   				out.println("<script language='javascript'>");
   				out.println("alert('������ ���� �� ������ �߻��Ͽ����ϴ�.');");
   				out.println("</script>");
   			}
   			
   			input_schedule=bean.input_media_return (clickDate);
 
   	} else if (ocode_group != null) {
   		Vector attach_file_v = new Vector();
   		Vector attach_file_c = new Vector();
		StringTokenizer attach_file_st = new StringTokenizer(ocode_group, ","); 
		while (attach_file_st.hasMoreTokens()) {
				attach_file_v.add(attach_file_st.nextToken());
		}
		
		 attach_file_st = new StringTokenizer(ccode_group, ","); 
		while (attach_file_st.hasMoreTokens()) {
				attach_file_c.add(attach_file_st.nextToken());
		}
		
		for (int i=0 ; i < attach_file_v.size() ; i++) {
//			out.println(i+":"+String.valueOf(attach_file_v.elementAt(i)));
//			out.println(i+":"+String.valueOf(attach_file_c.elementAt(i)));
			ocode = String.valueOf(attach_file_v.elementAt(i));
			ccode = String.valueOf(attach_file_c.elementAt(i));
			
			if(ocode.length() > 0 ) {
				MediaManager mgr = MediaManager.getInstance();
				Vector mediaVt = mgr.getOMediaInfo(ocode);
				//OrderMediaInfoBean minfo = new OrderMediaInfoBean();
				com.hrlee.silver.OrderMediaInfoBean minfo = new com.hrlee.silver.OrderMediaInfoBean();
				try {
					for(Enumeration e = mediaVt.elements(); e.hasMoreElements();) {
						com.yundara.beans.BeanUtils.fill(minfo, (Hashtable)e.nextElement());
					}
				}catch(Exception e) {}

				String runningtime = minfo.getPlaytime(); 
				int result = bean.insertTimeMedia(ccode, ocode, clickDate, runningtime, hour, minute);
			 
				if(result == -1) {
					out.println("<script language='javascript'>");
					out.println("alert('���̻� �������� �߰��� �� �����ϴ�.');");
					out.println("</script>");
					break;
				} else if(result == -2) {
					out.println("<script language='javascript'>");
					out.println("alert('������ ���۽ð��� ����Ͽ� �ּ���.');");
					out.println("</script>");
					break;
				} else if(result == -99) {
					out.println("<script language='javascript'>");
					out.println("alert('������ ���� �� ������ �߻��Ͽ����ϴ�.');");
					out.println("</script>");
					break;
				}
				
				input_schedule=bean.input_media_return (clickDate);
				
			}
			
		}
		 
   	}
   	
	

	String tableRow = "2";
	String display = "none";

	Vector vt = bean.selectTimeMedia(clickDate);
	if(vt == null || vt.size() <= 0) {
		if(hour.equals("") || minute.equals("")) {
			display = "block";
		}
	}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
<link rel="stylesheet" href="schedule.css" type="text/css">
<script language="javascript" src="/vodman/include/script.js"></script>
<script language="javascript">
<!--
	window.onload = function() {
<%if (input_time != null && input_time.length() > 0 && middle != null && middle.length() > 0 && middle.equals("middle")) { %>
	moveSchedule('<%=input_schedule%>', "middle");
<% } %>
	
		var display = "<%=display%>";
		if(display == "block" ) {
			document.listForm.hour.focus();
		}
	}

	function moveSchedule(id, flag) {
		if (id != '') {
		document.getElementById("middle").value=flag;
		document.listForm.action = "proc_scheduleUpdate.jsp?id="+id+"&flag="+flag;
		document.listForm.submit();
		}
	}

	function play_media(time,ocode) {
		document.getElementById("input_time").value=time;
		document.getElementById("middle").value='middle';
		top.mediaPlayer.document.location.href="mediaPlayer.jsp?ocode="+ocode;

	}

	function openCalendar() {
		window.open("schedule_calendar.jsp?day=<%=clickDate%>","openCalendar","width=270, height=280, scrollbars=no, toolbars=no");
	}

	function deleteSchedule() {
		if(<%=vt.size()%> > 0) {
			if(confirm("������ ��������� ��� �����Ͻðڽ��ϱ�?")) {
				document.location = "proc_scheduleDelete.jsp?day=<%=clickDate%>";
			}
		}
	}

	function changeStartTime() {
		document.getElementById("timeSetting").style.display = "block";
		document.getElementById("timeTitle").innerHTML = "���۽ð��� �����ϼ���.";
	}

	function checkStartTime() {
		var f = document.listForm;
		if(f.hour.value == "") {
			alert("���� �ð�(��)�� �Է��Ͽ� �ּ���.");
			f.hour.focus();
			return;
		}

		if(f.minute.value == "") {
			alert("���� �ð�(��)�� �Է��Ͽ� �ּ���.");
			f.minute.focus();
			return;
		}

		if(<%=vt.size()%> > 0) {
			if(confirm("���۽ð���  �����Ͻðڽ��ϱ�? \n ������ �Ͻø� 24�ð��� �Ѿ�� �������� �ڵ����� �����˴ϴ�.")) {
				f.action = "proc_changeStartTime.jsp";
				f.submit();
			}
		} else {
			f.submit();
		}
	}

	function cancelStartTime() {
		document.getElementById("timeSetting").style.display = "none";
	}

	function chkNum(obj) {
		var f = document.listForm;
		searchko = obj.value;
		
		for (i = 0 ; i < searchko.length ; i++) {
			sko = searchko.charAt(i);
			if ((sko < '0' || sko > '9')) {
				alert("���ڸ� �Է��ϼ���!");
				obj.value = "";
				obj.focus();
				return;
			}
		}

		if(obj.name=="hour" && (searchko < 0 || searchko > 23)) {
			alert("���۽ð�(��)�� 0~23 ���̷� �Է��Ͽ� �ּ���.");
			obj.value = "";
			obj.focus();
			return;
		}

		if(obj.name=="minute" && (searchko < 0 || searchko > 59)) {
			alert("���۽ð�(��)�� 0~59 ���̷� �Է��Ͽ� �ּ���.");
			obj.value = "";
			obj.focus();
			return;
		}
		
		if(obj.name=="hour" && searchko.length == 2) {
			f.minute.focus();
		}
		if(obj.name=="minute") {
			if(f.hour.value == "") {
				f.hour.value = "00";
			}
		}
	}
//-->
</script>
</head>

<body leftmargin="5" topmargin="0" marginwidth="0" marginheight="0">

<form name="listForm" action="schedule_list.jsp" method="post">
<input type="hidden" name="clickDate" value="<%=clickDate%>" />
<input type="hidden" id="input_time" name="input_time" value="<%=input_time%>" />
<input type="hidden" id="middle" name="middle" value="" />
<div class="s_ex_scroll">
	<span id='mp_div1' style='display:'>
		<table cellspacing="5" class="live_calender" summary="���">
		<caption>���</caption>
		<colgroup>
			<col width="200px;"/>
			<col width="100px;"/>
		</colgroup>
		<tbody>
<%
	int i = 0;
boolean end = true;
	if(vt != null && vt.size() > 0) {

		for(Enumeration e = vt.elements(); e.hasMoreElements();) {
			//OrderMediaInfoBean info = new OrderMediaInfoBean();
			com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());

			String play_time = "";
			TimeMediaManager tMgr = TimeMediaManager.getInstance();			 
			play_time = tMgr.reformTime(info.getTime()) + " ~ " + tMgr.reformTime(info.getEndtime());
		 
			i++;

%>
			<tr>
				<td><span class="sch_time"><%=play_time%></span><br><a href="javascript:play_media(<%=info.getTime()%>,<%=info.getOcode()%>);" alt="�̸�����"><img src="images/tv.gif" alt="�̸�����" />&nbsp;<%=info.getTitle()%></a></td>
				<td <% if ( end && middle.equals("middle") && input_time !=null && input_time.length() > 0 && input_time.equals(info.getTime())){ end = false; out.print("id='#end'"); } if ( end && ( input_time.length() <=0 || middle.length() <= 0  )&& i==vt.size() ) { out.print("id='#end'"); }%>>
					<a href="javascript:moveSchedule('<%=info.getId()%>','down');" alt="�Ʒ���"><img src="images/but_bot01.gif" alt="�Ʒ���" /></a>
					<a href="javascript:moveSchedule('<%=info.getId()%>','bottom');" alt="����������"><img src="images/but_bot02.gif" alt="����������" /></a>
					<a href="javascript:moveSchedule('<%=info.getId()%>','up');" alt="����"><img src="images/but_top01.gif" alt="����" /></a>
					<a href="javascript:moveSchedule('<%=info.getId()%>','top');" alt="ó������"><img src="images/but_top02.gif" alt="ó������" /></a>
					<a href="javascript:moveSchedule('<%=info.getId()%>','delete');" alt="����"><img src="images/but_sch_del.gif" alt="����" /></a>
				</td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="#dbe2ed" height="1"></td>
			</tr>
<%
		}
	} else {
%>
			<tr>
				<td colspan="2" height="35" align="center">��ϵ� �������� �����ϴ�.</td>
			</tr>

			<tr>
				<td colspan="2" bgcolor="#dbe2ed" height="1"></td>
			</tr>
<%
	}
%>

		</tbody>
		</table>
	</span>
</div>
<div class="but01">
<!--  	<a href="#" title="�����ϱ�"><img src="images/bu_save.gif" alt="�����ϱ�"/></a> -->
	<a href="javascript:openCalendar();" title="���� ������ �ҷ�����"><img src="images/bu_summon.gif" alt="���� ������ �ҷ�����"/></a>
	<a href="javascript:changeStartTime();" title="���۽ð�����"><img src="images/bu_starttimeedit.gif" alt="���۽ð�����"/></a>
	<a href="javascript:deleteSchedule();" title="����"><img src="images/bu_delete.gif" alt="����"/></a>
</div>
<div id="timeSetting" style="display:<%=display%>; position:absolute; top:70px; left: 50px; z-index:999999; ">
<table cellpadding="0" cellspacing="0" border="0" width="233" style="background-color:#ffffff; filter:alpha(opacity=90);">
<tr>
<td style="background: url(images/time_bg.gif) no-repeat; padding-top: 7px; height: 141px;" >
<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td valign="top" align="center">
				<div class="border_type2">
					<table cellpadding="0" cellspacing="15" class="calendar_simple2" summary="���۽ð�">
						<caption>
							<strong id="timeTitle">���۽ð��� ����ϼ���.</strong>
						</caption>
						<tbody>
						<tr height="30">
						<td width="100"></td>
						<td><input type="text" name="hour" style="width:30px" class="inputG" maxlength="2" value="<%=hour%>" onFocus="this.select();" onkeyup="chkNum(this);" /></td>
						<td>��</td>
						<td><input type="text" name="minute" style="width:30px" class="inputG" maxlength="2" value="<%=minute%>" onFocus="this.select();" onkeyup="chkNum(this);"/></td>
						<td>��</td>
						<td width="100"></td>
						</tr>
						</tbody>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="but01">
					<a href="javascript:checkStartTime();" title="Ȯ��"><img src="images/bu_confirm.gif" alt="Ȯ��"/></a>
<%	if(vt != null && vt.size() > 0) {%>
 					<a href="javascript:cancelStartTime();" title="���"><img src="images/bu_cancel.gif" alt="���"/></a>
<%	} %>
				</div>
			</td>
		</tr>
</table>
</td>
</tr>
	</table>
</div>
</form>
</body>
</html>