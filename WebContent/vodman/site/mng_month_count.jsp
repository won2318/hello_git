<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%
	int iDateSumMon = 0;
	try{
		iDateSumMon = Integer.parseInt(request.getParameter("iDateSumMon"));
	}catch(Exception e){
		iDateSumMon = 0;
	}
	
	Calendar cal = Calendar.getInstance();
	Calendar cal2 = Calendar.getInstance();

	
	int month = cal.get(Calendar.MONTH)+1;
	Vector row=null;
	Vector col=null;
	
	int viewMonth = iDateSumMon + month;
	if(viewMonth <= 0) {
		viewMonth += 12;
	} else if(viewMonth > 12) {
		viewMonth-= 12;
	}
 
	Vector v_list=null;
	cal.add ( cal.MONTH, iDateSumMon );
	int iMonth = cal.get ( cal.MONTH ) + 1;
	int iYear =  cal.get ( cal.YEAR );
	
	GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
	//달의  날짜 수
	int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH )+1;
	
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
//-->
</script>
</head>

<body style="background-image:none;height:">

	<table cellspacing="0" class="connection_view01" summary="월간페이징현황">
	<caption>월간페이징현황</caption>
	<colgroup>
		<col width="5%"/>
		<col width="3%"/>
		<col width="3%" span="30"/>
	</colgroup>
	<thead>
		<tr>
			<th colspan="27" class="connection_view01_title"><b>월간페이징현황</b></th>
			<td colspan="5" class="font_117 back_f7 bor_1e6"><%=iYear%>년 <a href="javascript:NextMon(<%=iDateSumMon-1%>);" title="이전달"><img src="/vodman/include/images/but_r.gif" alt="이전 달보기"/></a>&nbsp;<b><%=viewMonth%>월 </b>&nbsp;<a href="javascript:NextMon(<%=iDateSumMon+1%>);" title="다음달"><img src="/vodman/include/images/but_l.gif" alt="다음 달보기"/></a></td>
		</tr>
	</thead>
	<tbody>
		<tr class="height_200 font_117" valign="bottom">
			<td class="bor_top02">&nbsp;</td>
<%
String flag = "W";
if(request.getParameter("flag") != null && request.getParameter("flag").length()>0 && !request.getParameter("flag").equals("null")){
	flag = request.getParameter("flag");
}
	v_list=stat.getMonthStatTemp_Count(iDateSumMon,flag);
	
	float[] month_count = new float [maxday];
	try{
		if(v_list != null && v_list.size()>0){
			for (int j=0; j < v_list.size() ; j++) {
				month_count[Integer.parseInt(String.valueOf(((Vector)(v_list.elementAt(j))).elementAt(0)).substring(8,10))] =Integer.parseInt(String.valueOf(((Vector)(v_list.elementAt(j))).elementAt(1)));			
			}
		}
	}catch(Exception ex){
		System.err.println(" month hit error = "+ex);
	}
	
	//제일 큰 값 가져오기(높이 제일큰것을 기준으로 조절하기 위해)
	int max_height=1;
	int valSum=0;
	int val=0;
	 
	for(int i=1; i< maxday; i++)
	{
	  val=Math.round(month_count[i]);

		try{
			 
			if(val>max_height)
				max_height=Math.round(month_count[i]);
			
		}catch(Exception e){System.out.println("month hit error =. "+e); }
	}
 
 
	//그래프 출력
	for(int i=1; i<maxday; i++)
	{

		int cnt=0;
		int height=0;
		try{
			cnt=Math.round(month_count[i]);
			 
			if(cnt < 0) cnt=0;
		}catch(Exception e){System.out.println(" month hit error  "+e); cnt=0;}
		valSum += cnt;
		height=cnt*200/max_height;
%>
			<td class="bor_top02"><img src="/vodman/include/images/dot04.gif" alt="접속그래프" width="8" height="<%=height%>" /></td>
<%
	}
%>

<%
if(maxday < 32){
	for(int a=0;a<32-maxday;a++){	
%>
			<td class="bor_top02">&nbsp;</td>
<%	}
} %>
		</tr>
		<tr class="height_25 bor_1e6 font_117">
			<td><b>접속자</b></td>
<%
//수치만 출력
	for(int i=1; i<maxday; i++)
	{
		int cnt=0;
		int height=0;
		try{
			 
			cnt = Math.round(month_count[i]);
			if(cnt < 0) cnt=0;
		}catch(Exception e){System.out.println("month hit error = . "+e); cnt=0;}
%>
			<td><%=cnt%></td>
<%
	}
%>
<%
if(maxday < 32){
for(int a=0;a<32-maxday;a++){	
%>
			<td>&nbsp;</td>
<%	}} %>
		</tr>
		<tr class="height_25 back_f7">
			<td><strong>일</strong></td>
<% for(int i=1; i<maxday; i++) {%>
			<td><strong><%=i%></strong></td>
<%	}%>
<%
if(maxday < 32){
for(int a=0;a<32-maxday;a++){	
%>
			<td>&nbsp;</td>
<%	}} %>
		</tr>
		<tr class="height_25 back_f7">
<%
	if(maxday > 0) {
		int colspan = maxday;
		if(maxday%2 == 0) {
			colspan = (colspan+2)/2;
		} else {
			colspan = (colspan+1)/2;
		}
%>
			<td colspan="16" class="bor_top01"><strong>합계 </strong><span class="font_colorBlue"><%=valSum%></span></td>
			<td colspan="16" class="bor_top01"><strong>일 평균 </strong><span class="font_colorBlue"><%if(valSum > 0){out.println((int)(valSum/maxday));}else{out.println("0");}%></span></td>
<%
	}
%>
		</tr>
	</tbody>
	<form name="form" method="post" action="">
		<input type="hidden" name="iDateSumMon" value="<%=iDateSumMon%>">      
	</form>
	</table>
