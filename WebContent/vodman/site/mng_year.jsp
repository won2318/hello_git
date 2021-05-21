<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%
	String flag = "W";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");

	int iDateSumYear = 0;
	try{
		iDateSumYear = Integer.parseInt(request.getParameter("iDateSumYear"));
	}catch(Exception e){
		iDateSumYear = 0;
	}

	
	Calendar cal = Calendar.getInstance();
	Calendar cal2 = Calendar.getInstance();

	
	int year  = cal.get(Calendar.YEAR);
	Vector row=null;
	Vector col=null;
	int maxDays = 12;
	int[] iCntArray = new int[maxDays];
	for(int a=0;a<maxDays;a++){
		iCntArray[a] = 0;
	}
	//�ش� ���� ��� ������ �����´�.
	//ī��Ʈ, ��¥
	// 20,01
	// 13,02
	// 2,03
	// 1,04
	// 3,05
	// 1,06
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/vodman/include/js/script.js"></script>


	<script language="javascript">
<!--

	function NextYear(idx){
        form.iDateSumYear.value = idx;
        form.submit();
    }

	function go_month_view(month, type){
		if (month < 10) {
			month = "0"+month;
		}
		var day = <%=year+iDateSumYear%> + month;
		window.open('stat_month.jsp?year_month='+day+'&type='+type, '', 'width=650,height=700,toolbar=no,statusbar=no,resize=yes');
	}

//-->
</script>
</head>

<body style="background-image:none;height:">

	<table cellspacing="0" class="connection_view01" summary="����������Ȳ">
	<caption>����������Ȳ</caption>
	<colgroup>
		<col width="4%"/>
		<col width="4%"/>
		<col width="4%" span="22"/>
	</colgroup>
	<thead>
		<tr>
			<th colspan="21" class="connection_view01_title"><b>����������Ȳ</b></th>
			<td colspan="3" class="font_117 back_f7 bor_1e6"><a href="javascript:NextYear(<%=iDateSumYear-1%>);" title="������"><img src="/vodman/include/images/but_r.gif" alt="������"/></a>&nbsp;&nbsp;<b><%=year+iDateSumYear%>��</b>&nbsp;&nbsp;<a href="javascript:NextYear(<%=iDateSumYear+1%>);" title="������"><img src="/vodman/include/images/but_l.gif" alt="������"/></a></td>
		</tr>
	</thead>
	<tbody>
		<tr class="height_200 font_117 align_left" valign="bottom">
<%
	row=stat.getYearState(iDateSumYear, flag);
					
	//���� ū �� ��������(���� ����ū���� �������� �����ϱ� ����)
	int max_height=1;
	int valSum=0;
	int val=0;
	int iYearSumV = 0;

	if(row != null && row.size() >= 1){
		for(int i=0; i<row.size(); i++)
		{
			col=(Vector)row.elementAt(i);
	
			try{
				val = Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
				if(val>max_height)
					max_height=val;
				int tmpMonth_ = Integer.parseInt(String.valueOf(col.elementAt(1)));
				//�ش� �޿� ���� ī��Ʈ �Է�
				iCntArray[tmpMonth_-1] = val;
				//ī��Ʈ ����
				valSum += val;
				//���� ū �� ã��
				if(val>max_height)
					max_height=val;
				
			}catch(Exception e){System.out.println("#21. "+e); }
		}
	}
		//�׷��� ���
		for(int i=0; i<maxDays; i++)
		{
			int height=0;
			if(iCntArray[i] >0){
				height=iCntArray[i]*200/max_height;
			}
			iYearSumV += iCntArray[i];
%>
			<td class="align_right bor_top02"><img src="/vodman/include/images/dot05.gif" alt="<%=iCntArray[i]%>��" width="8" height="<%=height%>" /></td>
			<td class="bor_top02"><%=iCntArray[i]%></td>
<%
		}
%>
		</tr>
		<tr class="height_25 back_f7 bor_1e6">
<%
	
		for(int i=0; i<maxDays; i++)
		{
%>
			<td colspan="2"><a href="javascript:go_month_view('<%=i+1%>', '<%=flag%>');"><strong><%=i+1%>��</strong></a></td>
<%
		}
%>
		</tr>
		<tr class="height_25 back_f7">
			<td colspan="8" class="bor_top01"><strong>�հ� </strong><span class="font_colorBlue"><%=iYearSumV%></span></td>
			<td colspan="8" class="bor_top01"><strong>�� ��� </strong><span class="font_colorBlue"><%if(iYearSumV > 0){out.println((int)(iYearSumV/12));}else{out.println("0");}%></span></td>
			<td colspan="8" class="bor_top01"><strong>�� ��� </strong><span class="font_colorBlue"><%if(iYearSumV > 0){out.println((int)(iYearSumV/365));}else{out.println("0");}%></span></td>
		</tr>
	</tbody>
	<form name="form" method="post" action="">
		<input type="hidden" name="iDateSumYear" value="<%=iDateSumYear%>">
	</form>
	</table>
