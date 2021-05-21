<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat, com.hrlee.silver.OrderMediaInfoBean"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	//request.setCharacterEncoding("euc-kr");

if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author �����
	 *
	 * @description : �ֹ��� �̵�� ��ü������ ������.
	 * date : 2012-01-16
	 */
   
    int pg = 0;
 
    String ccode = "";
	ccode = StringUtils.defaultString(request.getParameter("ccode"),"");
    if(request.getParameter("page")==null){
        pg = 1;
    }else{
        pg = Integer.parseInt(request.getParameter("page"));
    }

	String searchField = "";		//�˻� �ʵ�
	String searchString = "";		//�˻���
	String subcode = "";
	String order = "mk_date";		//���ı��� �ʵ� mk_date ( �Կ���) owdate(�����)
	String direction = "desc";		//���� ���� asc, desc
	String sdate = "";
	String edate="";
	if (request.getParameter("order") != null ) {
	order = StringUtils.defaultString(request.getParameter("order"));
	} 
	if (request.getParameter("direction") != null ) {
	direction = StringUtils.defaultString(request.getParameter("direction"));
	}
	String mtype = "C"; 			//�̵�� Ÿ�� VOD/AOD/CONTENT/PHOTO
	String mtitle = "VOD";
	int listCnt = 10;				//������ ��� ����

	if(request.getParameter("searchField") != null)
		searchField = request.getParameter("searchField").replaceAll("<","").replaceAll(">","");
	
	if(request.getParameter("sdate") != null)
		sdate = request.getParameter("sdate").replaceAll("<","").replaceAll(">","");
	
	if(request.getParameter("edate") != null)
		edate = request.getParameter("edate").replaceAll("<","").replaceAll(">","");
	 

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0)
		searchString = CharacterSet.toKorean(request.getParameter("searchString").replaceAll("<","").replaceAll(">",""));
		//searchString = request.getParameter("searchString");
 
	

    Rss_search mgr = Rss_search.getInstance();
    Hashtable result_ht = null;

   // result_ht = mgr.getOMediaListAll(ccode,order, searchField, searchString, pg,listCnt, direction);
    
    result_ht = mgr.getOMediaListAll(ccode,order, searchField, searchString, pg,listCnt, direction, sdate, edate);
    

    /*
    if (Integer.parseInt(vod_level) > 8) {
    	  result_ht = mgr.getOMediaListAll(ccode,mtype,order, searchField, searchString, pg,listCnt, direction, vcode);
    } else {
    	  result_ht = mgr.getOMediaListAll_userid(ccode,mtype,order, searchField, searchString, pg,listCnt, direction, tmp_id, vcode);
    }
    */

    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");
		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(pg);
	        }
		}
    }
    
    OrderMediaInfoBean minfo = new OrderMediaInfoBean();
	CategoryManager cmgr = CategoryManager.getInstance();
 
	String strLink = "&ctype="+mtype;
	//strtmp = "searchField:<font color=red>" +searchField+ "</font>|searchString:<font color=red>" +searchString;
    strLink += "&searchField=" +searchField+ "&searchString=" +searchString+ "&ccode="+ccode+"&sdate="+sdate+"&edate="+edate;
 
    String menu_title = "������";
    
    if (ccode != null && ccode.length() > 0) {
    	menu_title = cmgr.getCategoryName(ccode, "V");
    }
%>


 

<%@ include file="/vodman/include/top.jsp"%>

<%@page import="com.hrlee.silver.OrderMediaInfoBean"%><script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>



 
<script language="javascript">
<!--
<%
if(ccode != null && ccode.length()>0){
%>
 	window.onload = function() {
			refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
			refreshCategoryList_C('V', '', 'C', '<%=ccode%>');
	}
	function setCcode(form, val) {
			form.ccode.value = val;
		}
<%
}
%>
function checkInverse() {
	if (document.frmMedia.chkAll.checked){
		if(document.frmMedia.v_chk.length) 
		{  // ���� ���� ���
			for(i=0;i<document.frmMedia.v_chk.length;i++) {
				document.frmMedia.v_chk[i].checked = true;
			}
		}
		else
		{
			 document.frmMedia.v_chk.checked = true;
		}
	}else{
		if(document.frmMedia.v_chk.length) {  // ���� ���� ���
			for(i=0;i<document.frmMedia.v_chk.length;i++) {
				document.frmMedia.v_chk[i].checked = false;
			}
		}else{
			document.frmMedia.v_chk.checked = false;
		}
	}
}

function sel_del() {

	if ( confirm('���� �����Ͻðڽ��ϱ�?') ) {
		if(document.frmMedia.v_chk.length) {  // ���� ���� ���
			var num = document.frmMedia.v_chk.length;
		    for(var i = 0; i < num; i++) {
		        if(document.frmMedia.v_chk[i].checked == true) {
		            document.frmMedia.action = "proc_selectDel.jsp";
					document.frmMedia.submit();
		            break;
				}
			}
		    if(i == num) {
				alert('�ϳ� �̻��� ������ �����ϼ���');
				return;
			}
		}else{
			if(document.frmMedia.v_chk.checked == true) {
	            document.frmMedia.action = "proc_selectDel.jsp";
				document.frmMedia.submit();
	           
			}else{
				alert(' ������ �����ϼ���');
				return;
			}
		}
	}
	
}

function sel_close() {

	if ( confirm('����� ó�� �Ͻðڽ��ϱ�?') ) {
		if(document.frmMedia.v_chk.length) {  // ���� ���� ���
			var num = document.frmMedia.v_chk.length;
		    for(var i = 0; i < num; i++) {
		        if(document.frmMedia.v_chk[i].checked == true) {
		            document.frmMedia.action = "proc_selectClose.jsp";
					document.frmMedia.submit();
		            break;
				}
			}
		    if(i == num) {
				alert('�ϳ� �̻��� ������ �����ϼ���');
				return;
			}
		}else{
			if(document.frmMedia.v_chk.checked == true) {
	            document.frmMedia.action = "proc_selectClose.jsp";
				document.frmMedia.submit();
	           
			}else{
				alert(' ������ �����ϼ���');
				return;
			}
		}
	}
	
}

function pop_cate_move(flag) {
		var frm = document.frmMedia;
		if(frm.v_chk.length) {  // ���� ���� ���

			
			var num = frm.v_chk.length;
			 for(var i = 0; i < num; i++) {
				if(frm.v_chk[i].checked == true) { 
					break;
				}
			 }
		    if(i == num) {
				alert('�ϳ� �̻��� ������ �����ϼ���');
				return;
			} else {
				var win_open = window.open("about:blank", "cate_move");
			 
				frm.action = "pop_moveCate.jsp?mocde=<%=mcode%>&flag="+flag;


				frm.target="cate_move";
				frm.submit();
			}



		}else{
			if(frm.v_chk.checked == true) {
				var win_open = window.open("about:blank", "cate_move");
			 
				frm.action = "pop_moveCate.jsp?mocde=<%=mcode%>&flag="+flag;
				frm.target="cate_move";
				frm.submit();
	           
			}else{
				alert(' ������ �����ϼ���');
				return;
			}
		}


		 
}


  
function setSorder(order, direction) {
    var f = document.frmMedia;
    f.order.value = order;
    f.direction.value = direction;
    f.submit();
}   

 

function go_page(page_no){
	var f = document.frmMedia; 
	f.searchString.value = "<%=searchString%>";
    f.page.value = page_no;
    f.submit();
}


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


function do_search(){
	document.frmMedia.action="./mng_vodOrderList.jsp";
	document.frmMedia.page.value="1";
	document.frmMedia.submit();
}


function go_excel(){
		document.frmMedia.action="./mng_vodOrderList_excel.jsp";
	 	document.frmMedia.submit();
	}
	
//-->
</script>

<%@ include file="/vodman/vod_aod/vod_left.jsp"%>
<%
strLink += strLink + "&mcode="+mcode;
%>
		<div id="contents">
			<h3><%=menu_title %> </h3>
			 
			<div id="content">
				<!-- ���� -->
				<form name="frmMedia" method="post" action="mng_vodOrderList.jsp">
				<input type="hidden" name="ccode" value="<%=ccode%>">

				<input type="hidden" name="page" value="<%=pg%>">
				<input type="hidden" name="url" value=""/>
				<input type="hidden" name="mcode" value="<%=mcode%>">
				<input type="hidden" name="ctype" value="<%=mtype%>">
				<input type="hidden" name="order" value="<%=order%>">
				<input type="hidden" name="direction" value="<%=direction%>">
				<table cellspacing="0" class="log_list" summary="������ ���">
				<caption>������ ���</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
<%
if(ccode != null && ccode.length()>0){
%>
				<tbody>
					<tr>
						<th class="bor_bottom01">�з� ����</th>
						<td class="bor_bottom01 pa_left">
							<select id="ccategory2" name="ccategory2" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);refreshCategoryList('V', this.value, 'C', 'ccategory3');">
								<option value="">--- �ߺз� ���� ---</option>
							</select>
		 
							<select id="ccategory3" name="ccategory3" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);">
								<option value="">--- �Һз� ���� ---</option>
							</select>
							<a href="javascript:document.frmMedia.submit();" title="�˻�"><img src="/vodman/include/images/but_search.gif" alt="�˻�"/></a>&nbsp;
						</td>
					</tr>
				</tbody>
<%
}
%>				
				</table>
				<br/>
				
				<p class="to_page">Total<b><%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>Page<b><%=vt != null && vt.size()>0?pageBean.getCurrentPage():0%>/<%=vt != null && vt.size()>0?pageBean.getTotalPage():0%></b>
				<a href="./frm_AddContent.jsp?mcode=<%=mcode %>&ccode=<%=ccode%>"><img src="/vodman/include/images/but_plus.gif" alt="������"/></a>
				</p>
				
				<!--<a href="javascript:sel_del();" alte="���� �� ���� ����">���� ����</a>
				<a href="javascript:sel_cate_move();" alte="���� �� ���� �μ� �̵�">������ ���� �μ� �̵�</a>-->
				<table cellspacing="0" class="board_list" summary="������ ���">
				<caption>������ ���</caption>
				<colgroup>
					<col width="6%"/>
					<col width="6%"/>
					<col/>
					 
					<col width="12%"/>
					<col width="7%"/>
					<col width="10%"/>
					<col width="17%"/>
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkAll" onclick="javascript:checkInverse();"></th>
						<th>����</th>
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
						<span class="sort">
						<% if ( order != null && order.equals("mk_date")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('mk_date', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="����� ���� ����"/></a> 
								<a href="javascript:setSorder('mk_date', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="����� ���� ����"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('mk_date', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="����� ���� ����"/></a> 
								<a href="javascript:setSorder('mk_date', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="����� ���� ����"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('mk_date', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="����� ���� ����"/></a> 
						<a href="javascript:setSorder('mk_date', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="����� ���� ����"/></a> 
						<%} %>
							</span>
						</th>
						
						 
						<th>����/��ȯ</th>
						<th>hit��
							<span class="sort">
						<% if ( order != null && order.equals("hitcount")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('hitcount', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="hit�� ���� ����"/></a> 
								<a href="javascript:setSorder('hitcount', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="hit�� ���� ����"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('hitcount', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="hit�� ���� ����"/></a> 
								<a href="javascript:setSorder('hitcount', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="hit�� ���� ����"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('hitcount', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="hit�� ���� ����"/></a> 
						<a href="javascript:setSorder('hitcount', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="hit�� ���� ����"/></a> 
						<%} %>
							</span>
						</th>
						 
						<th>����</th>
					</tr>
				</thead>
				<tbody>

				<%
				


				String sub_link = "";
				int list = 0;
				if ( vt != null && vt.size() > 0){

				for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
					//OrderMediaInfoBean oinfo = new OrderMediaInfoBean();
					com.yundara.beans.BeanUtils.fill(minfo, (Hashtable)vt.elementAt(list));
					//com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
 
					 
					String goView = "<a href='javascript:media_player("+minfo.getOcode()+");'>"+String.valueOf(minfo.getTitle().length()>30?minfo.getTitle().substring(0,30):minfo.getTitle())+"</a>";
					 String tmp_mcode = "0702";
						 if(minfo.getCcode() != null && minfo.getCcode().length()>=3){
							if (minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("001")) {
								tmp_mcode = "0702";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("002")) {
								tmp_mcode = "0703";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("004")) {

								tmp_mcode = "0704";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("005")) {

								tmp_mcode = "0705";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("006")) {

								tmp_mcode = "0706";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("007")) {
 								tmp_mcode = "0707";
							} 
					 }
						 
					String temp_img = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+minfo.getSubfolder()+"/thumbnail/_small/"+minfo.getModelimage();
					 if (minfo.getThumbnail_file() != null && minfo.getThumbnail_file().indexOf(".") > 0) {
						 temp_img = "/upload/vod_file/"+minfo.getThumbnail_file();
					 }	 
					%>

					<tr class="height_25 font_127">
						<td class="bor_bottom01"><input name="v_chk" type="checkbox" value="<%=minfo.getOcode()%>"></td>
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01">
							<a href='frm_updateContent.jsp?ocode=<%=minfo.getOcode()%>&ccode=<%=minfo.getCcode()%>&mcode=<%=tmp_mcode%>&page=<%=pg%>'>
							<img src="<%=temp_img %>" alt="����� �̹���" class="img_style11" style="float:left;"/></a>
							<div class="vodCategory">
								<ul>
							 
								<li class="main_list_cate2"><%=minfo.getCtitle()%></li>
								<li><span class="main_list_title"><a href='frm_updateContent.jsp?ocode=<%=minfo.getOcode()%>&ccode=<%=minfo.getCcode()%>&mcode=<%=tmp_mcode%>&page=<%=pg%>' title='������ ���� �� Ȯ�� �������� �̵�'>
								<%=String.valueOf(minfo.getTitle().length()>30?minfo.getTitle().substring(0,30):minfo.getTitle())%></a></span></li>
								</ul>
							</div>
						</td>
						 
						<td class="bor_bottom01 font_117"><%=minfo.getMk_date()%></td>
						<td class="bor_bottom01"><%=(minfo.getOpenflag().equals("Y") ? "����" : "�����")%>/<%=(minfo.getIsended()==1 ? "�Ϸ�" : "���")%></td>
						<td class="bor_bottom01 font_117"><%=minfo.getHitcount()%></td>
						<td class="bor_bottom01"> 
							<a href="proc_ovodDel.jsp?page=<%=pg%>&ocode=<%=minfo.getOcode()%>&ccode=<%=ccode%><%=strLink%>" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a>

						</td>
					</tr>
					 <%
									}
						}else {
					 %>
					 <tr class="height_25 font_127">
						 
						<td class="align_left bor_bottom01" colspan='7' align='center'> ��ϵ� ������ �����ϴ�.</td>
						 
					</tr>

					 <%	}	%>

					
					<tr>
						 
						<td class="bor_bottom01 pa_left" colspan="7">
  						<input type="text" name="sdate" value="<%=sdate%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.sdate);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
  						~
						<input type="text" name="edate" value="<%=edate%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.edate);" title="ã�ƺ���"><img src="/vodman/include/images/icon_calender.gif" alt="ã�ƺ���"/></a>
 					
						<select name="searchField" class="sec01" style="width:100px;">
								<option value="title" selected="selected" <%=(searchField.equals("title"))?"selected":""%>>����</option>
								<option value="content" <%=(searchField.equals("content"))?"selected":""%>>����</option>
								<option value="all" <%=(searchField.equals("all"))?"selected":""%>>��ü</option>
							</select>
						<input type="text" name="searchString" value="<%=searchString %>" class="input01" style="width:150px;"/>
						<a href="javascript:do_search();" title="�˻�"><img src="/vodman/include/images/but_search.gif" alt="�˻�"/></a>
						
						<a href="javascript:go_excel();"><img src="/vodman/include/images/but_excel.gif" alt="Excel�ޱ�" border="0"></a>
						</td>
					</tr>
					</form>
				</tbody>
			</table>
			
			<p class="but03">
				<span class="check">
				<a href="javascript:sel_del();"><img src="/vodman/include/images/btn_checkDel.gif" alt="���û���"/></a>
				<a href="javascript:sel_close();"><img src="/vodman/include/images/btn_checkClose.gif" alt="�����"/></a>
				<a href="javascript:pop_cate_move('V');"><img src="/vodman/include/images/btn_category_go.gif" alt="ī�װ��̵�"/></a>
				<a href="javascript:pop_cate_move('Y');"><img src="/vodman/include/images/btn_program_go.gif" alt="���α׷��̵�"/></a>
				</span>
			</p>
			<div class="paginate">
				<%if(vt != null && vt.size() > 0 && pageBean!= null){ 


 				%>
						<%@ include file="page_link.jsp" %>
				<%	}	%>
				</div>

				<br/><br/>
			</div>

		</div>
<%@ include file="/vodman/include/footer.jsp"%>	
