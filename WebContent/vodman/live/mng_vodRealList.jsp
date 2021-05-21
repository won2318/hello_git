<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "r_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author ����
	 *
	 * @description : ����� ����Ʈ ����
	 * date : 2009-10-19
	 */

    int pg = 0;
    if(request.getParameter("page")==null){
        pg = 1;
    }else{
		try{
			pg = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("page")));
		}catch(Exception ex){
			pg =1;
		}
    }
	int listCnt = 10;				//������ ��� ���� 

	String searchFild = "";
	if (request.getParameter("searchFild") != null && request.getParameter("searchFild").length() > 0) {
		searchFild = request.getParameter("searchFild").replaceAll("<","").replaceAll(">","");
	}
	String searchString = "";
	if (request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0) {
 
		searchString = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchString")));
	}
	
	String ctype = "";
// 	if(request.getParameter("ctype") != null && request.getParameter("ctype").length()>=0 && !request.getParameter("ctype").equals("null")) {
// 		ctype = com.vodcaster.utils.TextUtil.getValue( String.valueOf(request.getParameter("ctype")));
// 	}else
		ctype = "L";

    LiveManager mgr = LiveManager.getInstance();
 
    Hashtable result_ht = null;
   // result_ht = mgr.getLive_ListAll(ctype, pg,listCnt );
    result_ht = mgr.getLive_ListSearch(searchFild, searchString, ctype, pg,listCnt );
    
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


 
%>
<%@ include file="/vodman/include/top.jsp"%>
<%@ include file="/vodman/live/live_left.jsp"%>
<script language='javascript'>

function searchI(){
	if (listForm.searchString.value == ''){
		 alert("�˻�� �Է��ϼ���");
		 return;
	}
	else{
		listForm.action='mng_vodRealList.jsp';
		listForm.submit();
	}
	return
}

</script>
		<!--	������	-->
		<div id="contents">
			<h3><span>�����</span> ���</h3>
			<p class="location">������������ &gt; ����۰��� &gt; <span>����� ���</span></p>
			<div id="content">
				<!-- ���� -->
				
				<form name="listForm" method="post">
				<input type="hidden" name="mcode" value="<%=mcode%>" />
				<table cellspacing="0" class="border_search" summary="�Խ��� �˻�">
				 
				<caption>�Խ��� �˻�</caption>
				<colgroup>
					<col width="50%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<td><p class="to_page"><p class="to_page">Total<b> <%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>Page<b><%=vt != null && vt.size()>0?pageBean.getCurrentPage():0%>/<%=vt != null && vt.size()>0?pageBean.getTotalPage():0%></b></p></td>
						<td class="align_right">
							<select name="searchFild" class="sec01" style="width:80px;">
							  <option value="rtitle" <%if (searchFild.equals("rtitle")) {out.print("selected");} %>>����</option>
							  <option value="rcontents" <%if (searchFild.equals("rcontents")) {out.print("selected");} %>>����</option>
							</select>
							<input type="text" name="searchString" value="<%=searchString %>" class="input01" style="width:150px;"/>
							<a href="javascript:searchI();" title="�˻�"><img src="/vodman/include/images/but_search.gif" alt="�˻�" class="pa_bottom" /></a>
						</td>
					</tr>
				</tbody>
				
				</table>
				</form>
				
				
				<table cellspacing="0" class="board_list" summary="����� ���">
				<caption>����� ���</caption>
				<colgroup>
					<col width="8%"/>
					<col/>
					<col width="30%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
				</colgroup>
				<thead>
					<tr>
						<th>��ȣ</th>
						<th>�������</th>
						<th>��۽ð�</th>
						<th>ȸ������</th>
						<th>��ûȽ��</th>
						<th>���</th>
						<th>����</th>
					</tr>
				</thead>
				<tbody>
				 <%
				 LiveInfoBean linfo = new LiveInfoBean();

			String sub_link = "";
			int list = 0;
			if ( vt != null && vt.size() > 0)
			{

				for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++)
				{
					com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)vt.elementAt(list));
				%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01"><a href="frm_Live_Update.jsp?mcode=<%=mcode%>&rcode=<%=linfo.getRcode()%>"><%=linfo.getRtitle()%></a></td>
						<td class="bor_bottom01"><%=linfo.getRstart_time()%> ~ <%=linfo.getRend_time()%></td>
						<td class="bor_bottom01"><%=linfo.getRlevel() == 0? "��ü":"�α���ȸ��"%></td>
						<td class="bor_bottom01"><%=linfo.getRhit()%></td>
						<td class="bor_bottom01"><%=(linfo.getOpenflag().equals("Y") ? "����" : "����")%></td>
						<td class="bor_bottom01"><a href="proc_Live_del.jsp?mcode=<%=mcode%>&rcode=<%=linfo.getRcode()%>" title="����" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
					</tr>
					  <%
				}
			}else {
					 %>
					<tr class="height_25 font_127 bor_bottom01 back_f7">
						<td class="bor_bottom01" colspan='7'>��ϵ� ������ �����ϴ�.</td>
						
					</tr>
					<%	}	%>
				</tbody>
				</table>
				<div class="paginate">
					<%
					    String argument = "&mcode="+mcode+"&searchFild="+searchFild+"&searchString="+searchString;
						String jspName = "mng_vodRealList.jsp"; 
						if(vt != null && vt.size() > 0 && pageBean!= null){ 
					  %>
					  <%@ include file="page_link.jsp" %>
					  <%	}	%>
				</div>
				<br/><br/>
			</div>
		</div>	

<%@ include file="/vodman/include/footer.jsp"%>	
