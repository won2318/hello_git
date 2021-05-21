<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	String flag = "M";
	if(request.getParameter("flag") != null && request.getParameter("flag").length() > 0)
		flag = request.getParameter("flag");
	int muid = 1;
	try{
		if(request.getParameter("muid") != null && request.getParameter("muid").length() > 0){
			muid = Integer.parseInt( request.getParameter("muid"));
		}
	}catch(Exception ex){
	}
	Calendar cal = Calendar.getInstance();
	int year  = cal.get(Calendar.YEAR),
	    month = cal.get(Calendar.MONTH)+1,
	    date = cal.get(Calendar.DATE);
	
	Vector row=null;
	Vector col=null;
	
	String ydate = "";
	String mdate1 = "";
	
	
	try{	
		if(request.getParameter("ydate") != null && request.getParameter("ydate").length() > 0){
			ydate = request.getParameter("ydate");
		}
	}catch(Exception e){
		ydate = null;
	}
	
	try{	
		if(request.getParameter("mdate") != null && request.getParameter("mdate").length() > 0){
			mdate1 = request.getParameter("mdate");
		}
	}catch(Exception e){
		mdate1 = null;
	}
	
	
	
	
	int mdate =0;
	//out.print("::"+mdate+"::");
	if (request.getParameter("mdate") != null && request.getParameter("mdate").length() > 0){
		mdate= Integer.parseInt(request.getParameter("mdate").trim());
	}
	
	
	String today = "";
	if(request.getParameter("ydate") == null){	
		today = Integer.toString(year)+Integer.toString(month);
	}else{
		if(mdate <= 9){
			mdate1 = "0"+mdate;
		}
		today = ydate+mdate1;
	}
	
// 	StatsManager mgr1 = StatsManager.getInstance();
// 	Vector vt1 = (Vector)mgr1.getBestList();
			
// 	BestTopInfoBean btiBean1 = new BestTopInfoBean();
	
// 	Hashtable sel = (Hashtable)vt1.get(0);
	
	
// 	out.println(sel);
// 	out.print("abcd");
	
	//com.yundara.beans.BeanUtils.fill(btiBean1, (Hashtable)e.nextElement());
	
	
   
	
    
    
    
    

	//int today_ip_count=0;		//���� ������ ��
	int today_contact_count=0;	//���� ī��Ʈ ��
	//int month_ip_count=0;		//�̴� ������ ��
	int month_contact_count=0;	//�̴� ī��Ʈ ��
	//int total_ip_count=0;		//��ü ������ ��
	int total_contact_count=0;	//��ü ī��Ʈ ��
	
	
	int today_contact_count1=0;	//���� ī��Ʈ ��
	int month_contact_count2=0;	//�̴� ī��Ʈ ��
	int total_contact_count3=0;	//��ü ī��Ʈ ��
	
	int m = 0;
	int y = year;
	if(request.getParameter("ydate") == null){
		m = month;
	}else{
		m = mdate;
	}
	int d=0;
	switch(m){
	case 1:
	case 3:
	case 5:
	case 7:
	case 8:
	case 10:
	case 12:
	d = 31;
	break;
	case 4:
	case 6:
	case 9:
	case 11:
	d=30;
	break;
	case 2:
		if(((y%4==0)&&!(y%100==0))||(y%400==0))
			d=29;		
		else
			d = 28;
		
	break;
	}
%>

<%@ include file="/vodman/include/top.jsp"%>
<script>
	function go_month_view(month){
		window.open('stat_month.jsp?year_month='+month, '', 'width=650,height=700,toolbar=no,statusbar=no,resize=yes');
	}
	
	
	//////////////////////////////////////////////////////
	//�޷� open window event 
	//////////////////////////////////////////////////////
	
	var calendar=null;
	
	/*��¥ hidden Type ���*/
	var dateField;
	
	/*��¥ text Type ���*/
	var dateField2;
	
	
	function Search(){
		location.href='mng_stat_menu_month_total.jsp?mcode=<%=mcode%>&ydate='+document.frmpop.ytime.value+'&mdate='+document.frmpop.mtime.value;
	}
	
	function ExcelDown(){
		location.href='mng_stat_menu_month_total_excel2.jsp?mcode=<%=mcode%>&ydate='+document.frmpop.ytime.value+'&mdate='+document.frmpop.mtime.value;
	}
	
	function Popup_OPEN(){
		window.open('mng_stat_menu_month_total_popup.jsp?ydate='+document.frmpop.ytime.value+'&mdate='+document.frmpop.mtime.value+'&flag2=M&flag=<%=flag%>',"new_popup", "width=1200,height=600,scrollbars=yes");
	}
</script>
<%@ include file="/vodman/site/site_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�޴������������</span> ����</h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>�޴�������� ����</span></p>
			<div id="content">
			
			
				<!-- ���� -->
				
				<ul class="s_tab01_bg">
				<li><a href="mng_stat_menu_total.jsp?mcode=<%=mcode%>&flag=T" title="Today" <%if(flag.equals("T")){out.println("class='visible'");}%>>�� ���</a></li>
				<li><a href="mng_stat_menu_month_total.jsp?mcode=<%=mcode%>&flag=M" title="Month" <%if(flag.equals("M")){out.println("class='visible'");}%>>�� ���</a></li>
				<li><a href="mng_stat_menu_year_total.jsp?mcode=<%=mcode%>&flag=Y" title="Year" <%if(flag.equals("Y")){out.println("class='visible'");}%>>�� ���</a></li>
				</ul>
				<br><br>
				
			<form name='frmpop' method='post' action="mng_stat_menu_total.jsp?mcode=<%=mcode%>&flag=<%=flag%>">
				<!-- ���� -->
				<h4>��¥  
				<%
				if(ydate==null){
				%>
				<select  name="ytime" class="sec01" style="width:60px;">
					<option value="2012" <%if(year==2012){out.println("selected='selected'");}%>>2012</option>
					<option value="2013" <%if(year==2013){out.println("selected='selected'");}%>>2013</option>
					<option value="2014" <%if(year==2014){out.println("selected='selected'");}%>>2014</option>
					<option value="2015" <%if(year==2015){out.println("selected='selected'");}%>>2015</option>
					<option value="2016" <%if(year==2016){out.println("selected='selected'");}%>>2016</option>
					<option value="2017" <%if(year==2017){out.println("selected='selected'");}%>>2017</option>
					<option value="2018" <%if(year==2018){out.println("selected='selected'");}%>>2018</option>
					<option value="2019" <%if(year==2019){out.println("selected='selected'");}%>>2019</option>
					<option value="2020" <%if(year==2020){out.println("selected='selected'");}%>>2020</option>
				</select> �� 
				<%}else{%> 				
				<select  name="ytime" class="sec01" style="width:60px;">
					<option value="2012" <%if(ydate.equals("2012")){out.println("selected='selected'");}%>>2012</option>
					<option value="2013" <%if(ydate.equals("2013")){out.println("selected='selected'");}%>>2013</option>
					<option value="2014" <%if(ydate.equals("2014")){out.println("selected='selected'");}%>>2014</option>
					<option value="2015" <%if(ydate.equals("2015")){out.println("selected='selected'");}%>>2015</option>
					<option value="2016" <%if(ydate.equals("2016")){out.println("selected='selected'");}%>>2016</option>
					<option value="2017" <%if(ydate.equals("2017")){out.println("selected='selected'");}%>>2017</option>
					<option value="2018" <%if(ydate.equals("2018")){out.println("selected='selected'");}%>>2018</option>
					<option value="2019" <%if(ydate.equals("2019")){out.println("selected='selected'");}%>>2019</option>
					<option value="2020" <%if(ydate.equals("2020")){out.println("selected='selected'");}%>>2020</option>
				</select> �� 
				<%} %>
				
				<select  name="mtime" class="sec01" style="width:40px;">				
				<%	
					if(mdate==0){
						for(int i=0; i<12; i++){
				%>					
					<option value="<%=i+1 %>" <%if(month==i+1){out.println("selected='selected'");}%>><%=i+1 %></option>
				<%
						}
					}else{
						for(int i=0; i<12; i++){
				%>
					<option value="<%=i+1 %>" <%if(mdate==i+1){out.println("selected='selected'");}%>><%=i+1 %></option>
				<%
						}
					}
				%>
				</select> ��
				&nbsp;&nbsp;<a href="javascript:Search();"><img src="/vodman/include/images/but_search.gif" alt="�˻�" border="0"></a>
				</h4>
			</form>
			</br>
				<table cellspacing="0" class="connection_list" summary="�޴��������-����">
				<caption>�޴������������</caption>
						<thead>
							<tr>
							<th>�� ���</th>
							<th></th>
							<%
							for(int i=0; i<d; i++){
							%>
							<th width="21px"><%=i+1%></th>						
							<%} %>						
							<th width="40px">�հ�</th>
							</tr>
						</thead>
						<tbody>					
						<%
						//�޴� Ÿ��Ʋ and Size �̱�
						MenuManager mgr = MenuManager.getInstance();
						Vector vt;
						Vector vt1;
						int[] Websum = new int [d];
						int[] Mosum = new int [d];
						vt= (Vector)mgr.getMenuListALL3(today, "W");
						vt1= (Vector)mgr.getMenuListALL3_1(today, "W");
						try{
							if(vt != null && vt.size()>0){						
						MenuInfoBean info = new MenuInfoBean();
						String[] month_count = new String [d];
						for(Enumeration e = vt.elements(); e.hasMoreElements();) {
							com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());																	
						%>
						<tr>
						<td class="font_size12"><%=info.getMtitle() %></td>
						<td class="left_border">&nbsp;</td>
							<%
							int x = 1;
							int gubun = info.getMuid();
							int gubun2 = 0;
							int gubun3 = 0;
							int cnt = 0;
							int csum = 0;
							String td = "";
							
							MenuInfoBean info1 = new MenuInfoBean();
									for(int g=0; g<d; g++){
										month_count[g] = "<td><b>0</b></td>";										
										for(Enumeration e1 = vt1.elements();e1.hasMoreElements();){
											com.yundara.beans.BeanUtils.fill(info1, (Hashtable)e1.nextElement());
											
											gubun2 = info1.getMuid();
											gubun3 = info1.getDay();
											if(gubun==gubun2&& gubun3==g+1){
												month_count[g] = "<td>"+"<span class='font_colorBlue'>"+info1.getCnt()+"</span></td>";
												Websum[g] += info1.getCnt();
												csum += info1.getCnt();
											}
										}
										
							%>
							<%=month_count[g] %>
							<%
									}
							%>
							<td><span class='font_colorBlue'><%=csum %></span></td>
						</tr>
						<%
						}
						%>
						<tr>
						<td>�հ�</td>						
						<td class="left_border"></td>
						<%
							int Totalsum = 0;
							for(int v=0; v<d; v++){
							Totalsum += Websum[v];  
						%>
						<td><span class='font_colorBlue'><%=Websum[v] %></span></td>
						<%
							}
						%>
						<td><span class='font_colorBlue'><%=Totalsum %></span></td>
						</tr>
						<%
						}else{%>
						<tr>
						<td colspan="<%=d+3%>">�˻��� ����� �����ϴ�.</td>
						</tr>
						<%
							}
						}catch(Exception ex){
							System.err.println(" mng_stat_menu_month_total.jsp error = "+ex);
						}						
						%>							
					</tbody>
				</tbody>
				</table>
				</br></br>
				<table cellspacing="0" class="connection_list" summary="�޴��������-����">
				<caption>�޴������������</caption>
					<thead>
						<tr>
						<th>����� ���</th>
						<th></th>
						<%
						for(int i=0; i<d; i++){
						%>
						<th width="21px"><%=i+1%></th>						
						<%} %>						
						<th width="40px">�հ�</th>
						</tr>
						</thead>
				</tbody>
				<tbody>
						<%
						//�޴� Ÿ��Ʋ and Size �̱�
						MenuManager mgrM = MenuManager.getInstance();
						Vector vtM;
						Vector vt1M;						
						vtM= (Vector)mgrM.getMenuListALL3(today, "M");
						try{
							if(vtM != null && vtM.size()>0){
						MenuInfoBean infoM = new MenuInfoBean();
						String[] month_countM = new String [d];
						for(Enumeration eM = vtM.elements(); eM.hasMoreElements();) {
							com.yundara.beans.BeanUtils.fill(infoM, (Hashtable)eM.nextElement());																	
						%>
						<tr>
						<td class="font_size12"><%=infoM.getMtitle() %></td>
						<td class="left_border">&nbsp;</td>
							<%
							int xM = 1;
							int gubunM = infoM.getMuid();
							int gubun2M = 0;
							int gubun3M = 0;
							int cntM = 0;
							int csumM = 0;
							String tdM = "";
							vt1M= (Vector)mgrM.getMenuListALL3_1(today, "M");
							MenuInfoBean info1M = new MenuInfoBean();
									for(int g=0; g<d; g++){
										month_countM[g] = "<td><b>0</b></td>";
										for(Enumeration e1M = vt1M.elements();e1M.hasMoreElements();){
											com.yundara.beans.BeanUtils.fill(info1M, (Hashtable)e1M.nextElement());
											
											gubun2M = info1M.getMuid();
											gubun3M = info1M.getDay();
											if(gubunM==gubun2M&& gubun3M==g+1){
												month_countM[g] = "<td>"+"<span class='font_colorBlue'>"+info1M.getCnt()+"</span></td>";
												csumM += info1M.getCnt();
												Mosum[g] += info1M.getCnt();
											}
										}
										
							%>
							<%=month_countM[g] %>
							<%
									}							
							%>
							<td><span class='font_colorBlue'><%=csumM %></span></td>							
						</tr>
						<%
							}
						%>
						<tr>
						<td>�հ�</td>						
						<td class="left_border"></td>
						<%
							int TotalsumM = 0;
							for(int v=0; v<d; v++){
							TotalsumM += Mosum[v]; 
						%>
						<td><span class='font_colorBlue'><%=Mosum[v] %></span></td>
						<%
							}
						%>
						<td><span class='font_colorBlue'><%=TotalsumM %></span></td>
						</tr>
						<%
						}else{%>
						<tr>
						<td colspan="<%=d+3%>">�˻��� ����� �����ϴ�.</td>
						</tr>						
						<%
						}
						}catch(Exception ex){
							System.err.println(" mng_stat_menu_month_total.jsp error = "+ex);
						}	
						%>						
					</tbody>
				</table>
				<table width="100%">
				<tr>
				<td align="right"></br>&nbsp;&nbsp;<a href="javascript:Popup_OPEN();"><img src="/vodman/include/images/but_view.gif" alt="�̸�����" border="0"></a>&nbsp;&nbsp;<a href="javascript:ExcelDown();"><img src="/vodman/include/images/but_excel.gif" alt="Excel�ޱ�" border="0"></a></td>
				</tr>
				</table>
			</div>
			</br></br>
			<!-- ���� �� -->
		</div>	
		<!-- ������ �� -->
<%@ include file="/vodman/include/footer.jsp"%>