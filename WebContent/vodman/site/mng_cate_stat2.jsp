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


<%@ include file="/vodman/site/site_left.jsp"%>

		<div id="contents">
			<h3><span>�з��� �Ǽ�</span> ����</h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>�з��� �Ǽ� ����</span></p>
			<div id="content">
				<!-- ���� -->
				 <ul class="s_tab01_bg">
					<li><a href="mng_cate_stat.jsp" title="������" >������</a></li>
					<li><a href="mng_cate_stat2.jsp" title="��û���" class='visible'>��û���</a></li>
				</ul><br>  
				<br/>
				<div class="to_but">
<%

	int total_count = mgr.getTotalhit("","N");  // ī�װ�, ���� �÷��� 
	Vector cvt = cmgr.getCategoryListALL2(ctype,"A");

%>					
					<p class="to_page">Total<b> ��û : <%=total_count%>�� &nbsp;&nbsp;  </b></p>
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
						<th>���Ƚ��</th>
						 
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
						<td class="bor_bottom01"><%=mgr.getTotalhit(cinfo.getCcode().substring(0,3)+"000000000","N")%></td>
						 
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
						<td class="bor_bottom01"><%=mgr.getTotalhit(cinfo.getCcode().substring(0,6)+"000000","N")%></td>
						 
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
						<td class="bor_bottom01"><%=mgr.getTotalhit(cinfo.getCcode().substring(0,9)+"000","N")%></td>
						 
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