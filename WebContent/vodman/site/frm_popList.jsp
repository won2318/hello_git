<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*,java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="popupSQLBean" class="com.vodcaster.sqlbean.PopupSqlBean" />
<%@ include file="/vodman/include/top.jsp"%>
<%
	 /**
	 * @author ������
	 *
	 * @description : �˾� ��� table.
	 * date : 2009-10-15
	 */

	int pg = 0;
	if (request.getParameter("page") == null) {
		pg = 1;
	} else {
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception e){
			pg = 0;
		}
	}
	int limit = 10;
	PopupSqlBean popsql = new PopupSqlBean();
	Hashtable result_ht = null;

	result_ht = popsql.getAllPopup(pg, limit);

	Vector vt = null;
	com.yundara.util.PageBean pageBean = null;
	if (!result_ht.isEmpty()) {
		vt = (Vector) result_ht.get("LIST");

		if (vt != null && vt.size() > 0) {
			pageBean = (com.yundara.util.PageBean) result_ht.get("PAGE");
			pageBean.setPagePerBlock(5);
			pageBean.setPage(pg);
		}
	}
mcode="0206";
	String strLink = "&mcode="+mcode; // ������ ��ũ 

	PopupInfoBean qinfo = new PopupInfoBean();
%>


<script language="javascript">

	function doWindowOpen(seq,width,height){
		if ( width.length > 0 )
		{
			width = 400;
		}
		if ( height.length > 0 )
		{
			height = 500;
		}
		window.open("/vodman/site/popup.jsp?mcode=<%=mcode%>&seq="+seq+"", "popup", "status=no,scrollbars=no,width="+width+",height="+height+",top=60,left=100");
    }
    
</script>

<%@ include file="/vodman/best/best_left.jsp"%>

<div id="contents">
	<h3><span>�˾�</span>����</h3>
	<p class="location">������������ &gt; ����ȭ����� &gt; <span>�˾�����</span></p>
 
	<div id="content">
		<!-- ���� -->
		<p class="to_page">Total<b><%if (vt != null && vt.size() > 0) {out.println(pageBean.getTotalRecord());} else {out.println("0");}%></b>
		Page<b><%if (vt != null && vt.size() > 0) {out.println(pg);} else {out.println("0");}%>/<%if (vt != null && vt.size() > 0) {out.println(pageBean.getTotalPage());} else {out.println("0");}%></b></h4>
		<table cellspacing="0" class="board_list" summary="�˾�����">
		<caption>�˾�����</caption>
		<colgroup>
			<col width="8%"/>
			<col/>
			<col width="17%" />
			<col width="10%" span="2"/>
			<col width="12%"/>
		</colgroup>
		<thead>
			<tr>
				<th>��ȣ</th>
				<th>����</th>
				<th>�ԽñⰣ</th>
				<th>��뿩��</th>
				<th>�̸�����</th>
				<th>����</th>
			</tr>
		</thead>
		<tbody>
<%
	int list = 0;
	if (vt != null && vt.size() > 0) {
	
		for (int i = pageBean.getStartRecord() - 1; (i < pageBean.getEndRecord()) && (list < vt.size()); i++, list++) {
			com.yundara.beans.BeanUtils.fill(qinfo, (Hashtable) vt.elementAt(list));
%>
			<tr class="height_25 font_127">
				<td class="bor_bottom01"><%=pageBean.getTotalRecord() - i%></td>
				<td class="align_left bor_bottom01"><a href="frm_popUpdate.jsp?mcode=<%=mcode%>&seq=<%=qinfo.getSeq()%>" title="����"><%=qinfo.getTitle()%></a></td>
				<td class="bor_bottom01"><%=qinfo.getRstime()%>~<%=qinfo.getRetime()%></td>
				<td class="bor_bottom01"><%=qinfo.getIs_visible()%></td>
				<td class="bor_bottom01"><a href="javascript:doWindowOpen(<%=qinfo.getSeq()%>,'<%=qinfo.getWidth()%>','<%=qinfo.getHeight()%>' );" title="�̸�����"><img src="/vodman/include/images/but_view.gif" alt="�̸�����"/></a></td>
				<td class="bor_bottom01"><a href="frm_popUpdate.jsp?mcode=<%=mcode%>&seq=<%=qinfo.getSeq()%>" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;<a href="proc_popupDel.jsp?mcode=<%=mcode%>&seq=<%=qinfo.getSeq()%>" onclick="return confirm('���� �����Ͻðڽ��ϱ�?')" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
			</tr>
<%
		}
	}
%>
		</tbody>
		</table>
<%
	if (vt != null && vt.size() > 0 && pageBean != null) {
		String jspName = "frm_popList.jsp";
%>
		<%@ include file="pop_page_link.jsp" %>
<%}%>
		<div class="but01">
			<a href="frm_popAdd.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_addi.gif" alt="���"/></a>
		</div>
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>

