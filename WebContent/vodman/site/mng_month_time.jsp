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
 
 
	int[] iCntArray = new int[24];
	for(int a=0;a<24;a++){
		iCntArray[a] = 0;
	}
 
	row=stat.getStatDayS_time(iDateSumMon, flag);
	
	//제일 큰 값 가져오기(높이 제일큰것을 기준으로 조절하기 위해)

int max_height=1;
int val=0;

if(row != null && row.size()>0){
	for(int i=1; i<row.size(); i++)
	{
		col=(Vector)row.elementAt(i);

		try{
			val = Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			if(val>max_height)
				max_height=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
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
//-->
</script>
</head>

<body style="background-image:none;height:">

	<table cellspacing="0" class="connection_view01" summary="월간접속현황">
	<caption>월간접속현황</caption>
	<colgroup>
 
		<col width="4%" span="24"/>
	</colgroup>
	<thead>
		<tr>
			<th colspan="20" class="connection_view01_title"><b>월간 시간별 접속 현황</b></th>
			<td colspan="4" class="font_117 back_f7 bor_1e6"><a href="javascript:NextMon(<%=iDateSumMon-1%>);" title="이전달"><img src="/vodman/include/images/but_r.gif" alt="이전 달보기"/></a>&nbsp;&nbsp;<b><%=viewMonth%>월 달</b>&nbsp;&nbsp;<a href="javascript:NextMon(<%=iDateSumMon+1%>);" title="다음달"><img src="/vodman/include/images/but_l.gif" alt="다음 달보기"/></a></td>
		</tr>
	</thead>
	<tbody>
		<tr class="height_200 font_117" valign="bottom">
  
			 	<% 
					if(row != null && row.size()>0){
						//그래프 출력
						for(int i=1; i<row.size(); i++)
						{
							col=(Vector)row.elementAt(i);
							int cnt=0;
							int height=0;
	
							try{
								cnt=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
								if(cnt < 0) cnt=0;
							}catch(Exception e){System.out.println("#31. "+e); cnt=0;}
	
							height=cnt*200/max_height;
						%>
	                        <td class="bor_top02"><img src="/vodman/include/images/dot04.gif" alt="<%=cnt%>" width="8" height="<%=height%>" /><br/><%=cnt %></td>
	                    <%
						}
					}
					%>
		</tr>
		<tr class="height_25 back_f7"> 		
		  <td>00h</td>
		  <td>01h</td>
		  <td>02h</td>
		  <td>03h</td>
		  <td>04h</td>
		  <td>05h</td>
		  <td>06h</td>
		  <td>07h</td>
		  <td>08h</td>
		  <td>09h</td>
		  <td>10h</td>
		  <td>11h</td>
		  <td>12</td>
		  <td>13h</td>
		  <td>14h</td>
		  <td>15h</td>
		  <td>16h</td>
		  <td>17h</td>
		  <td>18h</td>
		  <td>19</td>
		  <td>20h</td>
		  <td>21h</td>
		  <td>22h</td>
		  <td>23h</td>
		</tr>
	</tbody>
	<form name="form" method="post" action="mng_month_time.jsp">
		<input type="hidden" name="iDateSumMon" value="<%=iDateSumMon%>">      
	</form>
	</table>
</body>
</html>