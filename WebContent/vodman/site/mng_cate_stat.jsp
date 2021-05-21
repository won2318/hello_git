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

	//int total_count = mgr.getTotalhit("","N");  // ī�װ�, ���� �÷���
	//int total_vcount = mgr.getTotalvod("","N");  // ī�װ�, ���� �÷���
	int total_vcount = mgr.getTotalvod_date("","N", rstime, retime);  // ī�װ�, ���� �÷���

	Vector cvt = mgr.getTotalvod_date_all(rstime,retime);

%>					<p class="to_page">Total<b> ���� : <%= total_vcount%>��</b></p>
					<p class="align_right02 height_25"></p>
				</div>
				<table cellspacing="0" class="board_list" summary="������ ��û�α�">
				<caption>��û�Ǽ�</caption>
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
			
					<tr>
						<th>�з���</th>
						<th>�з� �ڵ�</th>
						<th> </th>
						<th>����Ǽ�</th>
						<th>��û�Ǽ�</th>
					</tr>
				</thead>
				<tbody>
 <%
				try{		
					if(cvt != null && cvt.size()>0 ){
						String ctitle = "";
						String ccode = "";
						String cnt = "";
						String hit = "";
						for(int i = 0; i < cvt.size(); i++) {
							ctitle = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(0));
							ccode = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(1));
							cnt = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(2));
							hit = String.valueOf(((Vector)(cvt.elementAt(i))).elementAt(3));
							
							if (!ccode.endsWith("000000000")) {
%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01" align="left">&nbsp;<%=ctitle%></td>
						<td class="bor_bottom01"><%=ccode%></td>
						<td class="bor_bottom01"> </td>
						<td class="bor_bottom01"><%=cnt%></td>
						<td class="bor_bottom01"><%=hit%></td>
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