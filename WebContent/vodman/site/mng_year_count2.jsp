<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%
	int iDateSumYear = 0;
	try{
		iDateSumYear = Integer.parseInt(request.getParameter("iDateSumYear"));
	}catch(Exception e){
		iDateSumYear = 0;
	}
	
	Calendar cal = Calendar.getInstance();
 	
	int year  = cal.get(Calendar.YEAR);
	Vector v_list=null;
 
	String flag = "WV";
	if(request.getParameter("flag") != null && request.getParameter("flag").length()>0 && !request.getParameter("flag").equals("null")){
		flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	}
	v_list=stat.getYearStatCount(iDateSumYear, flag);

	float[] year_count = new float [12];
 
	if(v_list != null && v_list.size()>0){
		for (int j=0; j < v_list.size() ; j++) {
			try{
				year_count[j] =Integer.parseInt(String.valueOf(((Vector)(v_list.elementAt(j))).elementAt(0)));
			}
			catch(Exception ex)
			{
				System.err.println("month year hit eror = " + ex);
			}
	 
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

	function NextYear(idx){
        form.iDateSumYear.value = idx;
        form.submit();
    }

//-->
</script>
</head>

<body style="background-image:none;height:">

	<table cellspacing="0" class="connection_view01" summary="연간시청현황">
	<caption>연간시청현황</caption>
	<colgroup>
		<col width="4%"/>
		<col width="4%"/>
		<col width="4%" span="22"/>
	</colgroup>
	<thead>
		<tr>
			<th colspan="21" class="connection_view01_title"><b>연간시청현황</b></th>
			<td colspan="3" class="font_117 back_f7 bor_1e6"><a href="javascript:NextYear(<%=iDateSumYear-1%>);" title="이전년"><img src="/vodman/include/images/but_r.gif" alt="이전년"/></a>&nbsp;&nbsp;<b><%=year+iDateSumYear%>년</b>&nbsp;&nbsp;<a href="javascript:NextYear(<%=iDateSumYear+1%>);" title="다음년"><img src="/vodman/include/images/but_l.gif" alt="다음년"/></a></td>
		</tr>
	</thead>
	<tbody>
		<tr class="height_200 font_117 align_left" valign="bottom">
<%
	//제일 큰 값 가져오기(높이 제일큰것을 기준으로 조절하기 위해)
	int max_height=1;
	int valSum=0;
	int val=0;
	int iYearSumV = 0;
					 
	for(int i=0; i<12; i++)
	{
		try{
	
			val = Math.round(year_count[i]);
			if(val>max_height)
				max_height=val;
	
		}catch(Exception e){System.out.println(" month year hit eror = . "+e); }
	}
	 
	//그래프 출력
	for(int i=1; i<13; i++)
	{
		int cnt=0;
		int height=0;
		try{
			cnt = Math.round(year_count[i-1]);
			if(cnt < 0) cnt=0;
		}catch(Exception e){System.out.println("month year hit eror = . "+e); }
	
		height=cnt*200/max_height;
		iYearSumV += cnt;
%>
			<td class="align_right bor_top02"><img src="/vodman/include/images/dot05.gif" alt="<%=cnt%>명" width="8" height="<%=height%>" /></td>
			<td class="bor_top02"><%=cnt%></td>
<%
	}
%>
		</tr>
		<tr class="height_25 back_f7 bor_1e6">
<%	for(int i=1; i<13; i++) {%>
			<td colspan="2"><strong><%=i%>월</strong></td>
<%	}%>
		</tr>
		<tr class="height_25 back_f7">
			<td colspan="8" class="bor_top01"><strong>합계 </strong><span class="font_colorBlue"><%=iYearSumV%></span></td>
			<td colspan="8" class="bor_top01"><strong>월 평균 </strong><span class="font_colorBlue"><%if(iYearSumV > 0){out.println((int)(iYearSumV/12));}else{out.println("0");}%></span></td>
			<td colspan="8" class="bor_top01"><strong>일 평균 </strong><span class="font_colorBlue"><%if(iYearSumV > 0){out.println((int)(iYearSumV/365));}else{out.println("0");}%></span></td>
		</tr>
	</tbody>
	<form name="form" method="post" action="">
		<input type="hidden" name="iDateSumYear" value="<%=iDateSumYear%>">
	</form>
	</table>
