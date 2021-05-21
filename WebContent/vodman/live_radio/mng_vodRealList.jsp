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

	String ctype = "";
// 	if(request.getParameter("ctype") != null && request.getParameter("ctype").length()>=0 && !request.getParameter("ctype").equals("null")) {
// 		ctype = com.vodcaster.utils.TextUtil.getValue( String.valueOf(request.getParameter("ctype")));
// 	}else
		ctype = "R";

    LiveManager mgr = LiveManager.getInstance();
         
    Hashtable result_ht = null;
    result_ht = mgr.getLive_ListAll(ctype, pg,listCnt );
    
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
<%@ include file="/vodman/live_radio/radio_left.jsp"%>
		<!--	������	-->
		<div id="contents">
			<h3><span>���̴� ����</span> ���</h3>
			<p class="location">������������ &gt; ���̴� ���� &gt; <span>���̴� ���� ���</span></p>
			<div id="content">
				<!-- ���� -->
				<p class="to_page">Total<b> <%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>Page<b><%=vt != null && vt.size()>0?pageBean.getCurrentPage():0%>/<%=vt != null && vt.size()>0?pageBean.getTotalPage():0%></b></p>
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

			    for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
				 
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
						String jspName = "mng_vodRealList.jsp"; 
					    String argument = "&mcode="+mcode;
						if(vt != null && vt.size() > 0 && pageBean!= null){ 
					  %>
					  <%@ include file="page_link.jsp" %>
					  <%	}	%>
				</div>
				<br/><br/>
			</div>
		</div>	

<%@ include file="/vodman/include/footer.jsp"%>	
