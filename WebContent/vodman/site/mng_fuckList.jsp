<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}

%>
<%
	/**
	 * @author lee hee rak
	 *
	 * @description : �弳	 ���� ���.
	 * date : 2012-5-4
	 */

 
	String order = "fuck_id";
	if(request.getParameter("order")!=null && request.getParameter("order").length()>0 ){
		order = com.vodcaster.utils.TextUtil.getValue(request.getParameter("order"));
	}
	String searchstring = "";
	if(request.getParameter("searchstring")!=null && request.getParameter("searchstring").length()>0 ){
		searchstring = com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchstring"));
	}
	
	int pg = 0;
    if(request.getParameter("page")==null || (request.getParameter("page") != null && request.getParameter("page").length()<=0)){
        pg = 1;
    }else{
		try{
			pg = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("page")));
		}catch(Exception ex){
			pg =1;
		}
    }
	int listCnt = 20;				//������ ��� ���� 


	FucksInfoManager mgr = FucksInfoManager.getInstance();
    Hashtable result_ht = null;
    result_ht = mgr.getAllFucks_admin( searchstring, pg,listCnt,"desc", order );


    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
	int totalArticle =0; //�� ���ڵ� ����
	int totalPage = 0 ; //
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(pg);
				totalArticle = pageBean.getTotalRecord();
		        	totalPage = pageBean.getTotalPage();
	        }
		}
    }
	String strLink = "&searchstring="+searchstring+"&order="+order;
    
%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript">
	
	function f_newChange(){
		if(document.frmMedia.buseo_code.value == ""){
			return;
		}else{
	       document.frmMedia.submit();
	    }
    }
	function refreshOrder(){
		
	   document.frmMedia.submit();
	   
    }
</script>

<%@ include file="/vodman/site/site_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�弳</span> ���</h3>
			<p class="location">������������ &gt; ȸ������ &gt; <span>�弳 ���</span></p>
			<div id="content">
			
				<!-- ���� -->
				<form name="frmMedia" action="mng_fuckList.jsp">
				<input type="hidden" name="page" value="<%=pg %>" />
				<input type="hidden" name="mcode" value="<%=mcode%>" />
				<p class="to_page">Total<b><%=totalArticle%></b> &nbsp;<b><%=pg%>/<%=totalPage%></b>Page
					
					<select name="order" id="order" class="sec01" style="width:60px;margin-bottom:5px;" onchange="javascript:refreshOrder();">
						<option value="">���ı��� </option>
						<option value="fuck_id" <%=order.equals("fuck_id")?" selected ":"" %>>��ϼ�</option>
						<option value="fucks" <%=order.equals("fucks")?" selected ":"" %>>�弳</option>
					</select>
				</p> </form>
				<table cellspacing="0" class="board_list" summary="�弳 ���">
				<caption>�弳 ���</caption>
				<colgroup>
					<col width="7%"/>
					<col/>
					<col width="12%"/>
				</colgroup>
				<thead>
					<tr>
						<th>��ȣ</th>
						<th>�弳</th>
						<th>����</th>
					</tr>
				</thead>
				<tbody>
				 <%
					 FuckInfoBean linfo = new FuckInfoBean();

					  String sub_link = "";
					  int list = 0;
					if ( vt != null && vt.size() > 0){

					for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
						  com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)vt.elementAt(list));
				  %>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="bor_bottom01"><a href="frm_fuck_Update.jsp?mcode=<%=mcode%>&fuck_id=<%=linfo.getFuck_id()%>&page=<%=pg%>"><%=linfo.getFucks()%></a></td>
						<td class="bor_bottom01">
						<a href="frm_fuck_Update.jsp?mcode=0109&fuck_id=<%=linfo.getFuck_id()%>" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;
						<a href="proc_fuck_del.jsp?mcode=<%=mcode%>&fuck_id=<%=linfo.getFuck_id()%>" title="����" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
					</tr>
					<%
							}
						}else {
					 %>
					<tr class="height_25 font_127 bor_bottom01 back_f7">
						<td class="bor_bottom01" colspan='3'>��ϵ� ������ �����ϴ�.</td>

					</tr>
					<%	}	%>
					
				</tbody>
				</table>
				<div class="paginate">
				  <%
					String jspName = "mng_fuckList.jsp"; 
					if(vt != null && vt.size() > 0 && pageBean!= null){ 
				  %>
				  <%@ include file="page_link.jsp" %>
				  <%	}	%>
				</div>
				<div class="but01">
					<a href="frm_fuckAdd.jsp?mcode=0109"><img src="/vodman/include/images/but_addi.gif" alt="�߰�"/></a>
				</div>
				<br/><br/>
				
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>