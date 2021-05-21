<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%
	String flag = "W";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");

	int iDateSum = 0;
	try{
		iDateSum = Integer.parseInt(request.getParameter("iDateSum"));
	}catch(Exception e){
		iDateSum = 0;
	}

	
	Calendar cal = Calendar.getInstance();
	Calendar cal2 = Calendar.getInstance();
	Vector row=null;
	Vector col=null;

	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/vodman/include/js/script.js"></script>


	<script language="javascript">
<!--
    function NextWeek(idx){
        form.iDateSum.value = idx;
        form.submit();
    }

//-->
</script>
</head>

<body style="background-image:none;height:">
<%
	//�Ϻ� ���� ���
	int START_DAY_OF_WEEK = 0;
	Calendar sDay = Calendar.getInstance();       // ������ 
	START_DAY_OF_WEEK = sDay.get(Calendar.DAY_OF_WEEK); 
%>
	<table cellspacing="0" class="connection_view01" summary="�ְ�������Ȳ">
	<caption>�ְ�������Ȳ</caption>
	<colgroup>
		<col width="7%"/>
		<col/>
		<col width="7%" span="12"/>
	</colgroup>
	<thead>
	<tr>
		<th colspan="12" class="connection_view01_title"><b>�ְ�������Ȳ</b></th>
		<td colspan="2" class="font_117 back_f7 bor_1e6"><a href="javascript:NextWeek(<%=iDateSum-7%>);" title="������"><img src="/vodman/include/images/but_r.gif" alt="���� �ֺ���"/></a>&nbsp;&nbsp;<b><a href="javascript:NextWeek(0);" title="�̹� ��">�̹� ��</a></b>&nbsp;&nbsp;<a href="javascript:NextWeek(<%=iDateSum+7%>);" title="������"><img src="/vodman/include/images/but_l.gif" alt="���� �ֺ���"/></a></td>
	</tr>
	</thead>
	<tbody>
<%
	//�Ϻ� ���� ���
	row=stat.getWeekState(iDateSum-START_DAY_OF_WEEK+1, flag);
%>
	<tr class="height_200 font_117 align_left" valign="bottom">
<%
					//���� ū �� ��������(���� ����ū���� �������� �����ϱ� ����)
	int max_height=1;
	int valSum=0;
	int val=0;
	if(row.size() >= 1){
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
	int cntSum = 0;
	int tempArr[];
	tempArr = new int[7];
	if(row.size() >= 1){
		
		//�׷��� ���
		for(int i=0; i<row.size(); i++)
		{
			col=(Vector)row.elementAt(i);
			int cnt=0;
			int height=0;

			try{
				cnt=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
				if(cnt < 0) cnt=0;
			}catch(Exception e){System.out.println("#31. "+e); cnt=0;}
			cntSum += cnt;
			tempArr[i] = cnt;
			height=cnt*200/max_height;
%>
		<td class="align_right bor_top02"><img src="/vodman/include/images/dot03.gif" alt="���ӱ׷���" width="8" height="<%= height %>" /></td>
		<td class="bor_top02"><%=cnt%></td>
<%
		}
	}
%>

	</tr>
	<tr class="height_25 back_f7 bor_1e6">
<%
	String weekday = "��ȭ���������";
	if(row.size() >= 1){
		for(int i=0; i<row.size(); i++)
		{
			col=(Vector)row.elementAt(i);
			String ymd = (String)col.elementAt(1);
%>
			<td colspan="2"><strong><%=ymd%> (<%=weekday.substring(i,i+1)%>)</strong></td>
<%
		}
	}
%>
	</tr>
	<tr class="height_25 back_f7">
		<td colspan="7" class="bor_top01"><strong>�հ� </strong><span class="font_colorBlue"><%=cntSum%></span></td>
		<td colspan="7" class="bor_top01"><strong>�� ��� </strong><span class="font_colorBlue"><%if(cntSum >= 1){out.println((int)cntSum/7);}else{out.println("0");}%></span></td>
	</tr>
	</tbody>
	<form name="form" method="post" action="">
		<input type="hidden" name="iDateSum" value="<%=iDateSum%>">
	</form>
	</table>