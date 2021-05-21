<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%
	String flag = "W";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag");

	int iDateSumMon = 0;
	try{
		iDateSumMon = Integer.parseInt(request.getParameter("iDateSumMon"));
	}catch(Exception e){
		iDateSumMon = 0;
	}
	
	Calendar cal = Calendar.getInstance();
 
	
	Calendar temp=Calendar.getInstance ( );
	temp.add ( cal.MONTH, iDateSumMon );
	
	int month = cal.get(Calendar.MONTH)+1;
	Vector row=null;
	Vector col=null;
	
	int viewMonth = iDateSumMon + month;
	if(viewMonth <= 0) {
		viewMonth += 12;
	} else if(viewMonth > 12) {
		viewMonth-= 12;
	}
	cal.set(cal.get ( Calendar.YEAR ), viewMonth-1, cal.get ( Calendar.DATE ));
	
	
	String temp_month="";
	if (viewMonth < 10) {
		
		temp_month= "0"+viewMonth;
	} else {
		temp_month= ""+viewMonth;
	}
	
	int maxDays = cal.getActualMaximum(Calendar.DAY_OF_MONTH); 


	int[] iCntArray = new int[maxDays];
	for(int a=0;a<maxDays;a++){
		iCntArray[a] = 0;
	}
	//�ش� ���� ��� ������ �����´�.
	//ī��Ʈ, ��¥
	// 20,05
	// 13,08
	// 2,25
	// 1,29
	// 3,30
	row=stat.getMonthState(iDateSumMon, flag);
	//���� ū �� ��������(���� ����ū���� �������� �����ϱ� ����)
	int max_height=1;
	int valSum=0;
	if(row != null && row.size() >= 1){
		for(int i=0; i<row.size(); i++)
		{
			col=(Vector)row.elementAt(i);

			try{
				int tmpVal = Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
				int tmpDate_ = Integer.parseInt(String.valueOf(col.elementAt(1)));
				//�ش� ��¥�� ���� ī��Ʈ �Է�
				iCntArray[tmpDate_-1] = tmpVal;
				//ī��Ʈ ����
				valSum += tmpVal;
				//���� ū �� ã��
				if(tmpVal>max_height)
					max_height=tmpVal;
			}catch(Exception e){System.out.println("#21. "+e); }
		}
	}
	%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/vodman/include/js/script.js"></script>

<script language="javascript">
<!--
    function NextMon(idx){
        form.iDateSumMon.value = idx;
        form.submit();
    }

function go_day_view(month, type){
	if (month < 10) {
		month = "0"+month;
	}
	var day =  month;
	window.open('stat_day.jsp?to_day=<%=temp.get ( Calendar.YEAR )%><%=temp_month%>'+day+'&type='+type, '', 'width=650,height=700,toolbar=no,statusbar=no,resize=yes');
}
//-->
</script>
</head>

<body style="background-image:none;height:">

	<table cellspacing="0" class="connection_view01" summary="����������Ȳ">
	<caption>����������Ȳ</caption>
	<colgroup>
		<col width="5%"/>
		<col width="3%"/>
		<col width="3%" span="30"/>
	</colgroup>
	<thead>
		<tr>
			<th colspan="27" class="connection_view01_title"><b>����������Ȳ</b></th>
			<td colspan="5" class="font_117 back_f7 bor_1e6"><a href="javascript:NextMon(<%=iDateSumMon-1%>);" title="������"><img src="/vodman/include/images/but_r.gif" alt="���� �޺���"/></a>&nbsp;&nbsp;<b><%=temp_month%>�� ��</b>&nbsp;&nbsp;<a href="javascript:NextMon(<%=iDateSumMon+1%>);" title="������"><img src="/vodman/include/images/but_l.gif" alt="���� �޺���"/></a></td>
		</tr>
	</thead>
	<tbody>
		<tr class="height_200 font_117" valign="bottom">
			<td class="bor_top02">&nbsp;</td>
<%
	
	
	
	int val=0;

		//�׷��� ���

		for(int i=0; i<maxDays; i++)
		{
			int height=0;
			
			if(iCntArray[i] > 0){
				height=iCntArray[i]*200/max_height;
			}
%>
			<td class="bor_top02"><img src="/vodman/include/images/dot04.gif" alt="<%=iCntArray[i]%>" width="8" height="<%=height%>" /></td>
<%
		}

%>
<%	if(maxDays % 2 == 0) {%>
			<td class="bor_top02">&nbsp;</td>
<%	} %>
		</tr>
		<tr class="height_25 bor_1e6 font_117">
			<td><b>������</b></td>
<%

		//��ġ�� ���
		for(int i=0; i<maxDays; i++)
		{
%>
			<td><%=iCntArray[i]%></td>
<%
		}

%>
<%	if(maxDays%2 == 0) {%>
			<td>&nbsp;</td>
<%	} %>
		</tr>
		<tr class="height_25 back_f7">
			<td><strong>��</strong></td>
<%
		for(int i=0; i<maxDays; i++)
		{
%>
			<td><a href="javascript:go_day_view('<%=i+1%>', '<%=flag%>');"><strong><%=i+1%></strong></a></td>
<%
		}
%>
<%
	if(maxDays%2 == 0) {
%>
			<td>&nbsp;</td>
<%	} %>
		</tr>
		<tr class="height_25 back_f7">
<%
	
		int colspan = maxDays;
		if(maxDays%2 == 0) {
			colspan = (colspan+2)/2;
		} else {
			colspan = (colspan+1)/2;
		}
%>
			<td colspan="<%=colspan%>" class="bor_top01"><strong>�հ� </strong><span class="font_colorBlue"><%=valSum%></span></td>
			<td colspan="<%=colspan%>" class="bor_top01"><strong>�� ��� </strong><span class="font_colorBlue"><%if(valSum > 0){out.println((int)(valSum/maxDays));}else{out.println("0");}%></span></td>
<%
	
%>
		</tr>
	</tbody>
	<form name="form" method="post" action="">
		<input type="hidden" name="iDateSumMon" value="<%=iDateSumMon%>">      
	</form>
	</table>
</body>
</html>