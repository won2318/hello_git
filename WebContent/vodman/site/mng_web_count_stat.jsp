<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="stat" class="com.vodcaster.sqlbean.StatManagerBean" scope="page"/>

<%
	String flag = "W";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");

	Calendar cal = Calendar.getInstance();
	int year  = cal.get(Calendar.YEAR),
	    month = cal.get(Calendar.MONTH)+1,
	    date = cal.get(Calendar.DATE);

	Vector row=null;
	Vector col=null;
	

	int today_count=0;		//���� 
	int month_count=0;	//�̹���
	int year_count=0;		//����
	int total_count=0;	//��ü


 	row=stat.getPageCount_hit(flag);
 	for(int i=0; i<row.size(); i++)
	{
		col=(Vector)row.elementAt(i);
		if(i==0)
		{
			try{
				today_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#10. "+e);today_count=0;}
		}
		else if(i==1)
		{
			try{
				month_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#11. "+e);month_count=0;}
		}
		else if(i==2)
		{
			try{
				year_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#12. "+e);year_count=0;}
		}
		else if(i==3)
		{
			try{
				total_count=Math.round(Float.parseFloat(String.valueOf(col.elementAt(0))));
			}catch(Exception e){System.out.println("#13. "+e);total_count=0;}
		}
		

	}

%>

<%@ include file="/vodman/include/top.jsp"%>
 
<%@ include file="/vodman/site/site_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>���ī��Ʈ</span></h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>���ī��Ʈ ����</span></p>
			
				<div id="content">
					<!-- ���� -->
					<ul class="s_tab01_bg">
					<li><a href="mng_web_count_stat.jsp?mcode=<%=mcode%>&flag=W" title="Web" <%if(flag.equals("W")){out.println("class='visible'");}%>>Web</a></li>
					<li><a href="mng_web_count_stat.jsp?mcode=<%=mcode%>&flag=M" title="Mobile" <%if(flag.equals("M")){out.println("class='visible'");}%>>Mobile</a></li>
				</ul><br><br>
			
				<h4>���� : <%=year%>�� <%=month%>�� <%=date%>��</h4>
				<table cellspacing="0" class="connection_list" summary="������� ���� ">
				<caption>���ī��Ʈ</caption>
				<colgroup>
					<col width="20%"/>
					<col />
					<col width="18%" span="4"/>
				</colgroup>
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>����</th>
						<th>�̴�</th>
						<th>����</th>
						<th>����</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><span class="font_size12">���ī��Ʈ</span></td>
						<td class="left_border">&nbsp;</td>
						<td><span class="font_colorBlue"><%=today_count%></span></td>
						<td><b><%=month_count%></b></td>
						<td><b><%=year_count%></b></td>
						<td><b><%=total_count%></b></td>
					</tr>
				</tbody>
				</table>
				
				<br/><br/>

				<iframe id="week_stat" name="week_stat" src="./mng_week_count.jsp?flag=<%=flag%>" scrolling=no width="795" height='300' marginwidth=0 frameborder=0 framespacing=0 ></iframe>
				
				<br/><br/>

				<iframe id="month_stat" name="month_stat" src="./mng_month_count.jsp?flag=<%=flag%>" scrolling=no width="795" height='320' marginwidth=0 frameborder=0 framespacing=0 ></iframe>

				<br/><br/>

				<iframe id="year_stat" name="year_stat" src="./mng_year_count.jsp?flag=<%=flag%>" scrolling=no width="795" height='300' marginwidth=0 frameborder=0 framespacing=0 ></iframe>
				
				<br/><br/>
			</div>
			<!-- ���� �� -->
		</div>	
		<!-- ������ �� -->
<%@ include file="/vodman/include/footer.jsp"%>