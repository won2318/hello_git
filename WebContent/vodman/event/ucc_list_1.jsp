<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "p_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	request.setCharacterEncoding("euc-kr");
 
	MediaManager mgr = MediaManager.getInstance();
 
	Hashtable result_ht = null;
 
	String ccode_list ="007000000000"; //ucc ī�װ�
	String event_seq = "";
	if (request.getParameter("event_seq") != null && request.getParameter("event_seq").length() > 0  && !request.getParameter("event_seq").equals("null")) {
		event_seq = com.vodcaster.utils.TextUtil.getValue(request.getParameter("event_seq"));
	}
	
	
    int pg = 0;
	if(request.getParameter("page")==null || !com.yundara.util.TextUtil.isNumeric(request.getParameter("page"))){
        pg = 1;
    }else{
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception ex){
			pg = 1;
		}
    }

	String searchField = "";		//�˻� �ʵ�
	String searchString = "";		//�˻���
	String mtype = "V";

	String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "ocode");
  	String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

	int listCnt = 5;				//������ ��� ����

	if(request.getParameter("searchField") != null  && request.getParameter("searchField").length() > 0 )
		searchField = com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchField"));

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 )
		searchString = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchString")));

   	result_ht = mgr.getOMediaListAll_admin_cate(ccode_list,mtype, order, searchField, searchString, pg, listCnt, direction, event_seq);
   
    Vector ibt = null;
    com.yundara.util.PageBean pageBean = null;

    int iTotalRecord = 0;
	int iTotalPage = 1;
	
    if(result_ht != null && !result_ht.isEmpty() && result_ht.size() > 0){
    	ibt = (Vector)result_ht.get("LIST");
		if(ibt != null && ibt.size()>0){
   			pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");

			pageBean.setLinePerPage(10);
			pageBean.setPagePerBlock(10);
			pageBean.setPage(pg);
			iTotalRecord = pageBean.getTotalRecord();
        	iTotalPage = pageBean.getTotalPage();

		}
    }
	String strLink = "";
    strLink += "&event_seq="+event_seq+"&searchField=" +searchField+ "&searchString=" +searchString;
    
%>
<%@ include file="/vodman/include/top.jsp"%>
 

<%@page import="com.security.SEEDUtil"%><script type="text/JavaScript">
<!--
 
 
function change_event_gread(cObject, ocode) {
	if(confirm('���� �����Ͻðڽ��ϱ�?')) {
		var gread = cObject.options[cObject.selectedIndex].value;
		var url = "proc_ucc_update.jsp?ocode=" + ocode + "&event_gread="+gread;
		var form = document.frmMedia;
		form.action = url;
		form.submit();
	}
}

function change_open_flag(cObject, ocode) {
	if(confirm('������ �����Ͻðڽ��ϱ�?')) {
		var openflag = cObject.options[cObject.selectedIndex].value;
		var url = "proc_ucc_update.jsp?ocode=" + ocode + "&openflag="+openflag;
		var form = document.frmMedia;
		form.action = url;
		form.submit();
	}
}

function change_openflag_mobile(cObject, ocode) {
	if(confirm('����ϰ����� �����Ͻðڽ��ϱ�?')) {
		var openflag = cObject.options[cObject.selectedIndex].value;
		var url = "proc_ucc_update.jsp?ocode=" + ocode + "&openflag_mobile="+openflag;
		var form = document.frmMedia;
		form.action = url;
		form.submit();
	}
}

function ucc_delete(ocode) {
	if(confirm('���� �Ͻðڽ��ϱ�?')) {
	 
		var url = "proc_ucc_delete.jsp?ocode=" + ocode ;
		var form = document.frmMedia;
		form.action = url;
		form.submit();
	}
}

function vod_view(ocode){
	sv_wm_viewer = window.open("/vodman/vod_aod/pop_vod_viewer.jsp?ocode="+ocode,"sv_wm_viewer","toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,width=480,height=630\"");
}

function setSorder(order, direction) {
	var form = document.frmMedia;
	form.order.value = order;
	form.direction.value = direction;
	form.submit();
}   

 
function rank_cnt(){
 
	document.frmMedia.target="hiddenFrame";
	//document.frmMedia.action="ucc_list_excel.jsp";
	document.frmMedia.action="copy_to_rank_ucc.jsp";
	
	document.frmMedia.submit();
}
//-->
</script>
 
<%
 mcode="0801" ;
%>
<%@ include file="/vodman/event/event_left.jsp"%> 

		<!-- ������ -->
		<div id="contents">
			<h3><span>UCC</span> ���</h3>
			<p class="location">������������ &gt; �̺�Ʈ ���� &gt; <span>UCC ���</span></p>
			<div id="content">
			 <form name="frmMedia" method="post" action="ucc_list.jsp">
			 
			 <input type="hidden" id="page" name="page" value="<%=pg%>" />
			 <input type="hidden" id="event_seq" name="event_seq" value="<%=event_seq%>" />
			 <input type="hidden" name="order" value="<%=order%>">
			 <input type="hidden" name="direction" value="<%=direction%>">
			  
				<table cellspacing="0" class="log_list" summary="UCC ���">
				<caption>UCC ���</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
 					<tr>
						<th class="bor_bottom01"><strong>�˻�</strong></th>
						<td class="bor_bottom01 pa_left"><select name="searchField" class="sec01" style="width:80px;">
								<option value="title" selected="selected" <%=(searchField.equals("title"))?"selected":""%>>����</option>
								<option value="content" <%=(searchField.equals("content"))?"selected":""%>>����</option>
								<option value="all" <%=(searchField.equals("all"))?"selected":""%>>��ü</option>

							</select><input type="text" name="searchString" value="<%=searchString%>" class="input01" style="width:150px;"/>
						<a href="javascript:document.frmMedia.submit();" title="�˻�"><img src="/vodman/include/images/but_search.gif" alt="�˻�"/></a>
						<a href="javascript:rank_cnt();" title="��÷�� ����"><img src="/vodman/include/images/btn_wincopy.gif" alt="��÷�� ����"/></a>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
				  
				<IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0"></IFRAME>
				 
				<br/>
				<p class="to_page">Total<b><%=iTotalRecord%></b>Page<b><%=pg %>/<%=iTotalPage%></b></p>
				<table cellspacing="0" class="board_list" summary="�̺�Ʈ ���">
				<caption>�̺�Ʈ ���</caption>
				<colgroup>
					<col width="6%"/>
					<col/>
					<col width="15%"/>
					<col width="10%"/>
					 
					<col width="10%"/>
					<col width="6%"/>
				</colgroup>
				<thead>
					<tr>
						<th>��ȣ</th>
						<th>����
						<% if ( order != null && order.equals("title")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="���� ���� ����"/></a> 
								<a href="javascript:setSorder('title', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="���� ���� ����"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="���� ���� ����"/></a> 
								<a href="javascript:setSorder('title', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="���� ���� ����"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="���� ���� ����"/></a> 
						<a href="javascript:setSorder('title', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="���� ���� ����"/></a> 
						<%} %>
						</th>
						<th>�����
						<% if ( order != null && order.equals("ownerid")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('ownerid', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="����� ���� ����"/></a> 
								<a href="javascript:setSorder('ownerid', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="����� ���� ����"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('ownerid', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="����� ���� ����"/></a> 
								<a href="javascript:setSorder('ownerid', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="����� ���� ����"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('ownerid', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="����� ���� ����"/></a> 
						<a href="javascript:setSorder('ownerid', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="����� ���� ����"/></a> 
						<%} %>
						</th>
						<th>����
						<% if ( order != null && order.equals("event_gread")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('event_gread', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="���� ���� ����"/></a> 
								<a href="javascript:setSorder('event_gread', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="���� ���� ����"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('event_gread', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="���� ���� ����"/></a> 
								<a href="javascript:setSorder('event_gread', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="���� ���� ����"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('event_gread', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="���� ���� ����"/></a> 
						<a href="javascript:setSorder('event_gread', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="���� ���� ����"/></a> 
						<%} %>
						</th>
						<th>����</th>
						
						<th>����</th>
					</tr>
				</thead>
				<tbody>
				  
<%
	com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	int list = 0;
	if ( ibt != null && ibt.size() > 0){

		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<ibt.size()) ; i++, list++){
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
			String ocontents = oinfo.getDescription();
			String imgurl ="/vodman/include/images/no_img01.gif";
			String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/"+oinfo.getModelimage();
			String strTitle = oinfo.getTitle();
			strTitle = strTitle.length()>20?strTitle.substring(0,20):strTitle;
			
			if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
				imgTmp = imgurl;
			}
//			File file = new File(imgTmp);
//			out.println(file.exists());
//			if(!file.exists()) {
//				imgTmp = imgurl;
//			}
			
			
			
			
			
			if((ocontents != null) &&   !ocontents.equals("")) {
				ocontents = ocontents.length() <= 34 ? ocontents : ocontents.substring(0, 32) + "..";
			}
			// �ܺ� URL�Ǻ��� ��ũ HTML ���� || go_view()ȣ��
			String strOwdate = "";
			String wdate = "";
			if(oinfo.getOcode() != null && oinfo.getOcode().length()>0){
				strOwdate = oinfo.getOcode().substring(0,4)+"-"+oinfo.getOcode().substring(4,6)+"-"+oinfo.getOcode().substring(6,8);
				wdate = oinfo.getOcode().substring(0,14);
			
%>	
		<tr class="height_25 font_127">
			<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
			<td class="align_left bor_bottom01">
				<table cellspacing="0">
					<tr>
						<td rowspan="2"><a href="javascript:vod_view('<%=oinfo.getOcode()%>')"><img src="<%=imgTmp%>" alt="<%=strTitle%>"  class="img_style07"/></a></td>
						<td class="main_list_cate" valign="middle"><%=strTitle%></td>
					</tr>
					<tr>
						<td class="main_list_title" valign="top"><%=oinfo.getMk_date()%></td>
					</tr>
				</table>
			</td>
			
			<td class="bor_bottom01">
			 <%=oinfo.getOwnerid()%><br/>(<%=SEEDUtil.getDecrypt(oinfo.getUser_tel()) %>)
		   </td>
		   
			<td class="bor_bottom01">
			<select name="event_gread" class="sec01" style="width:40px;" onChange="return change_event_gread(this, '<%=oinfo.getOcode()%>')">
			<% for ( int gread = 0; gread < 100 ; gread++) { %> 
			<option value='<%=gread%>' <%=(oinfo.getEvent_gread() == gread) ? "selected" : ""%>><%=gread %></option>
			<%} %>
			</select>
			</td>
			<td class="bor_bottom01">
			<select name="open_flag" class="sec01" style="width:60px;" onChange="return change_open_flag(this, '<%=oinfo.getOcode()%>')">
			<option value='Y' <%=(oinfo.getOpenflag().equals("Y")) ? "selected" : ""%>>����</option>
			<option value='N' <%=(oinfo.getOpenflag().equals("N")) ? "selected" : ""%>>�����</option>
			</select>
			 </td>
			
			<td class="bor_bottom01"><a href="javascript:ucc_delete('<%=oinfo.getOcode()%>');" title="����" ><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
		</tr>
		
	
						 
<%
			}
		}	
		 
	} else {
%>
							<tr class="height_25 font_127 back_f7">
						<td class="bor_bottom01" colspan="6">��ϵ� ������ �����ϴ�.</td>
					
					</tr>
<%		
	}
%>
 
						<tr>
							<td colspan="5">
 					 <%
						String jspName = "ucc_list.jsp";
					 	strLink += "&mcode=" + mcode;
						if(ibt != null && ibt.size() > 0 && pageBean!= null){ 
					  %>
					  <%@ include file="page_link.jsp" %>
					  <%	}	%>
							</td>
						</tr>
					</tbody>
					</table>
 
				</div>
				
				<br/><br/>
			</div>
		 
		
<%@ include file="/vodman/include/footer.jsp"%>