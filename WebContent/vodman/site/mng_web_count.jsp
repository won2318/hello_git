<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
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
<jsp:useBean id="oinfo" class="com.vodcaster.sqlbean.ContactInfoBean" scope="page" />

<%
ContactBean mgr = ContactBean.getInstance();

Hashtable result_ht = null;

String rstime="";
if (request.getParameter("rstime") != null && request.getParameter("rstime").length() > 0) {
	rstime =request.getParameter("rstime").replaceAll("<","").replaceAll(">","");
}
String retime="";
if (request.getParameter("retime") != null && request.getParameter("retime").length() > 0) {
	retime =request.getParameter("retime").replaceAll("<","").replaceAll(">","");
}
 
String flag = "W";
if (request.getParameter("flag") != null && request.getParameter("flag").length() > 0) {
	flag =request.getParameter("flag").replaceAll("<","").replaceAll(">","");
}

 int pg =1;
 int limit =20; 
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
			<h3><span>��� ī��Ʈ</span> ����</h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>���ī��Ʈ ��Ȳ</span></p>
			<div id="content">
				<!-- ���� -->
				 
				<br/>
				<div class="to_but">
<%

 
String cpage = request.getParameter("page");

if(cpage == null || cpage.equals("")) {
    pg = 1;
}else {
	try{
		pg = Integer.parseInt(cpage);
	}catch(Exception e){
		pg = 0;
	}
    
}


result_ht = mgr.getPageCnnCnt(rstime,retime, flag, pg, limit);

Vector vt = null;
com.yundara.util.PageBean pageBean = null;
int iTotalPage = 0;
int iTotalRecord = 0;
if(result_ht != null && !result_ht.isEmpty() && result_ht.size() > 0){
	vt = (Vector)result_ht.get("LIST");
	if(vt != null && vt.size()>0){
		pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		iTotalRecord = pageBean.getTotalRecord();
		iTotalPage = pageBean.getTotalPage();

	}
}
 

String strLink = "rstime="+rstime+"&retime="+retime+"&flag=" +flag+"&pg="+pg;
%>					
				 
				</div>
				<table cellspacing="0" class="board_list" summary="������ ��û�α�">
				<caption>��� ī��Ʈ</caption>
				<colgroup>
					<col width="10%"/>
				 
					<col width="35%"/>
					<col />
				</colgroup>
				<thead> 
				<form name="listForm" method="post" action="mng_web_count.jsp">
				<input type="hidden" value="<%=mcode %>" name="mcode" />
				<tr>
						<td colspan='2'  align='left'><p class="to_page"><p class="to_page">Total<b><%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>Page<b><%=vt != null && vt.size()>0?pageBean.getCurrentPage():0%>/<%=vt != null && vt.size()>0?pageBean.getTotalPage():0%></b></p></td>
						<td class="align_right"  >
							<input type="radio" value="W" name="flag" <%if (flag == null || flag.equals("W")) {out.print("checked");} %>/>��  <input type="radio" value="M" name="flag" <%if (flag != null && flag.equals("M")) {out.print("checked");} %>/>����� | 
							������:<input type="text" name="rstime" value="<%=rstime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.rstime)" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a> 
							~
							������:<input type="text" name="retime" value="<%=retime %>" class="input01" style="width:80px;"/><a href="javascript:openCalendarWindow(document.listForm.retime)" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
							<input type="image" src="/vodman/include/images/but_search.gif" alt="�˻�" class="pa_bottom" />
						</td>
					</tr>
					
					<tr>
						<th>��ȣ</th>
						<th>����</th>
						<th>������ ��� ī��Ʈ</th>
						 
				 
					</tr>
				</form>
				</thead>
				<tbody>
 <%
 int list = 0;
	if ( vt != null && vt.size() > 0){
		
		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++)
		{ 
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)vt.elementAt(list));
%> 
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="bor_bottom01"><%=oinfo.getDay()%></td>
						<td class="bor_bottom01"><%=oinfo.getCnt()%></td>					 
					</tr> 
<%
 
		}
	}else{
		%><tr class="height_25 font_127">
			<td colspan='3'>��ϵ� ������ �����ϴ�.</td>
		</tr>
		<%
	}
%>	
				</tbody>
			</table>
			<%
			if (vt != null && vt.size() > 0) {
			strLink = strLink + "&mcode="+mcode;
			String jspName = "mng_web_count.jsp";%>
			<%@ include file="pop_page_link.jsp" %>
			<%} %>
			<br/><br/>
			</div>
			<!-- ���� �� -->
		</div>	
		<!-- ������ �� -->
<%@ include file="/vodman/include/footer.jsp"%>