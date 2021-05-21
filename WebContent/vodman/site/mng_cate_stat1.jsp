<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>

<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%

String rstime="";
if (request.getParameter("rstime") != null && request.getParameter("rstime").length() > 0) {
	rstime =request.getParameter("rstime").replaceAll("<","").replaceAll(">","");
}
String retime="";
if (request.getParameter("retime") != null && request.getParameter("retime").length() > 0) {
	retime =request.getParameter("retime").replaceAll("<","").replaceAll(">","");
}

String ctype = "";
if(request.getParameter("ctype") != null) {
	ctype = String.valueOf(request.getParameter("ctype").replaceAll("<","").replaceAll(">",""));
}else
	ctype = "V";
CategoryManager cmgr = CategoryManager.getInstance();
CategoryInfoBean cinfo = new CategoryInfoBean();
MediaManager mgr = MediaManager.getInstance();
 
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language='javascript'>


//////////////////////////////////////////////////////
	//�޷� open window event 
	//////////////////////////////////////////////////////
	
	var calendar=null;
	
	/*��¥ hidden Type ���*/
	var dateField;
	
	/*��¥ text Type ���*/
	var dateField2;
	
	function openCalendarWindow(elem) 
	{
		dateField = elem;
		dateField2 = elem;
	
		if (!calendar) {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		} else if (!calendar.closed) {
			calendar.focus();
		} else {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		}
	}
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<div id="contents">
			<h3><span>�з��� �Ǽ�</span> ����</h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>�з��� �Ǽ� ����</span></p>
			<div id="content">
				<!-- ���� -->
				 	<ul class="s_tab01_bg">
					<li><a href="mng_cate_stat.jsp" title="������" class='visible'>������</a></li>
					<li><a href="mng_cate_stat2.jsp" title="��û���" >��û���</a></li>
				</ul><br>  
				
				<table cellspacing="0" class="log_list" summary="�� �α� ��¥����">
				<caption>��¥����</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
				<form name="listForm" method="post" action="mng_cate_stat.jsp">
				<input type="hidden" value="<%=mcode %>" name="mcode" />
					<tr>
						<th class="bor_bottom01">��¥����</th>
						<td class="bor_bottom01 pa_left">
							������ : <input type="text" name="rstime" value="<%=rstime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.rstime)" title="��â����"> <img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a> 
							~
							������ : <input type="text" name="retime" value="<%=retime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.retime)" title="��â����"> <img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
							<input type="image" src="/vodman/include/images/but_search.gif" alt="�˻�"/>
						 
						</td>
					</tr>
				</form>
				</tbody>
				</table>
				<br/>
				<div class="to_but">
<%

//	int total_count = mgr.getTotalhit("","N");  // ī�װ�, ���� �÷���
	int total_vcount = mgr.getTotalvod_date("","N", rstime, retime);  // ī�װ�, ���� �÷���

	Vector cvt = cmgr.getCategoryListALL2(ctype,"A");

%>					
					<p class="to_page">Total<b> ���� : <%= total_vcount%>��</b></p>
					<p class="align_right02 height_25"></p>
				</div>
				<table cellspacing="0" class="board_list" summary="������ ��û�α�">
				<caption>��û�Ǽ�</caption>
				<colgroup>
					<col width="25%"/>
					<col width="25%"/>
					<col width="25%"/>
					 
					<col width="25%"/>
				</colgroup>
				<thead>
			
					<tr>
						<th>1�ܰ�</th>
						<th>2�ܰ�</th>
						<th>3�ܰ�</th>
 
						<th>����Ǽ�</th>
					</tr>
				</thead>
				<tbody>
 <%
				try{		
						for(Enumeration e = cvt.elements(); e.hasMoreElements();) {
						
							com.yundara.beans.BeanUtils.fill(cinfo, (Hashtable)e.nextElement());
%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=cinfo.getCtitle()%></td>
						<td class="bor_bottom01"> </td>
						<td class="bor_bottom01"> </td>
					 
						<td class="bor_bottom01"><%=mgr.getTotalvod_date(cinfo.getCcode().substring(0,3)+"000000000","N", rstime, retime)%></td>
					</tr>
					
 <%
							Vector cvtB = cmgr.getCategoryListALL2(ctype,"B",cinfo.getCcode());

							for (Enumeration eb = cvtB.elements(); eb.hasMoreElements();){
								com.yundara.beans.BeanUtils.fill(cinfo, (Hashtable)eb.nextElement());
%>

					<tr class="height_25 font_127">
						<td class="bor_bottom01"></td>
						<td class="bor_bottom01"><%=cinfo.getCtitle()%></td>
						<td class="bor_bottom01"> </td>
						 
						<td class="bor_bottom01"><%=mgr.getTotalvod_date(cinfo.getCcode().substring(0,6)+"000000","N", rstime, retime)%></td>
					</tr>
<%

								Vector cvtC = cmgr.getCategoryListALL2(ctype,"C",cinfo.getCcode());
								for (Enumeration ec = cvtC.elements(); ec.hasMoreElements();){
								com.yundara.beans.BeanUtils.fill(cinfo, (Hashtable)ec.nextElement());
%>					
					<tr class="height_25 font_127">
						<td class="bor_bottom01"></td>
						<td class="bor_bottom01"></td>
						<td class="bor_bottom01"><%=cinfo.getCtitle()%></td>
						 
						<td class="bor_bottom01"><%=mgr.getTotalvod_date(cinfo.getCcode().substring(0,9)+"000","N", rstime, retime)%></td>
					</tr>
<%
								}
							}
						}
 
		}catch(Exception e) {System.out.println("�з��� ��û ��� ����:"+e);}
	
%>
				</tbody>
			</table>
			 
			</div>
			<!-- ���� �� -->
		</div>	
		<!-- ������ �� -->
<%@ include file="/vodman/include/footer.jsp"%>