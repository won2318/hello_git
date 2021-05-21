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
	//일별 접속 통계
	int START_DAY_OF_WEEK = 0;
	Calendar sDay = Calendar.getInstance();       // 시작일 
	START_DAY_OF_WEEK = sDay.get(Calendar.DAY_OF_WEEK); 
%>
	<table cellspacing="0" class="connection_view01" summary="주간접속현황">
	<caption>주간접속현황</caption>
	<colgroup>
		<col width="7%"/>
		<col/>
		<col width="7%" span="12"/>
	</colgroup>
	<thead>
	<tr>
		<th colspan="12" class="connection_view01_title"><b>주간접속현황</b></th>
		<td colspan="2" class="font_117 back_f7 bor_1e6"><a href="javascript:NextWeek(<%=iDateSum-7%>);" title="이전주"><img src="/vodman/include/images/but_r.gif" alt="이전 주보기"/></a>&nbsp;&nbsp;<b><a href="javascript:NextWeek(0);" title="이번 주">이번 주</a></b>&nbsp;&nbsp;<a href="javascript:NextWeek(<%=iDateSum+7%>);" title="다음주"><img src="/vodman/include/images/but_l.gif" alt="다음 주보기"/></a></td>
	</tr>
	</thead>
	<tbody>
<%
	//일별 접속 통계
	row=stat.getWeekState(iDateSum-START_DAY_OF_WEEK+1, flag);
%>
	<tr class="height_200 font_117 align_left" valign="bottom">
<%
					//제일 큰 값 가져오기(높이 제일큰것을 기준으로 조절하기 위해)
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
		
		//그래프 출력
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
		<td class="align_right bor_top02"><img src="/vodman/include/images/dot03.gif" alt="접속그래프" width="8" height="<%= height %>" /></td>
		<td class="bor_top02"><%=cnt%></td>
<%
		}
	}
%>

	</tr>
	<tr class="height_25 back_f7 bor_1e6">
<%
	String weekday = "월화수목금토일";
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
		<td colspan="7" class="bor_top01"><strong>합계 </strong><span class="font_colorBlue"><%=cntSum%></span></td>
		<td colspan="7" class="bor_top01"><strong>일 평균 </strong><span class="font_colorBlue"><%if(cntSum >= 1){out.println((int)cntSum/7);}else{out.println("0");}%></span></td>
	</tr>
	</tbody>
	<form name="form" method="post" action="">
		<input type="hidden" name="iDateSum" value="<%=iDateSum%>">
	</form>
	</table>