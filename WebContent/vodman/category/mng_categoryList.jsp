<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,  com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "cate_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author ������
	 *
	 * @description : ī�װ� ���.
	 * date : 2009-10-19
	 */

	String ctype = "";
	String strTitle = "";
	int num = 1;

	if(request.getParameter("ctype") != null && request.getParameter("ctype").length()>0 && !request.getParameter("ctype").equals("null")){
		ctype = String.valueOf(request.getParameter("ctype"));
	}else{
		ctype = "V";
	}


	//ctype = "V";
	if(ctype.equals("V"))
		strTitle = "VOD";
	else if(ctype.equals("A"))
		strTitle = "AOD";
    else if(ctype.equals("C"))
        strTitle = "������";
	else if(ctype.equals("P"))
		strTitle ="PHOTO";
	else if(ctype.equals("R"))
		strTitle ="Live";
	else if(ctype.equals("X"))
		strTitle ="�о�";
	else if(ctype.equals("Y"))
		strTitle ="���α׷�";


	CategoryManager mgr = CategoryManager.getInstance();
	Vector vt = mgr.getCategoryListALL2(ctype,"A");
	
%>

<%@ include file="/vodman/include/top.jsp"%>
<%@ include file="/vodman/category/category_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>ī�װ�</span> ���</h3>
			<p class="location">������������ &gt; ī�װ����� &gt; <span>ī�װ� ���</span></p>
			<div id="content">
				<div id="tab02">
				<ul class="s_tab01_bg">
					<li><a href="mng_categoryList.jsp?mcode=0401&ctype=V" title="VOD" <%if(ctype.equals("V")){out.println("class='visible'");}%>>VOD</a></li>
					<li><a href="mng_categoryList.jsp?mcode=0401&ctype=X" title="�о�" <%if(ctype.equals("X")){out.println("class='visible'");}%>>�о�</a></li>
					<li><a href="mng_categoryList.jsp?mcode=0401&ctype=Y" title="���α׷�" <%if(ctype.equals("Y")){out.println("class='visible'");}%>>���α׷�</a></li>
					<%-- <li><a href="mng_categoryList.jsp?mcode=0401&ctype=P" title="PHOTO" <%if(ctype.equals("P")){out.println("class='visible'");}%>>PHOTO</a></li> --%>
				</ul>
				</div>
				<table cellspacing="0" class="menu_list" summary="�޴� ���">
				<caption>�޴� ���</caption>
				<colgroup>
					<col width="15%"/>
					<col class="back_f7" width="15%"/>
					<col width="10%"/>
 					<col class="back_f7" />
					<col width="8%"/>
					<col class="back_f7" width="8%"/>
					<col width="12%"/>
				</colgroup>
				<thead>
					<tr>
						<th>1�ܰ�</th>
						<th>2�ܰ�</th>
						<th>3�ܰ�</th>
						<th>����</th>
 						<th>����</th> 
						<th>��������</th>
						<th>����</th>
					</tr>
				</thead>
				<tbody>
<%
if(vt != null && vt.size()>0)
{
						CategoryInfoBean info = new CategoryInfoBean();
						
						for(Enumeration e = vt.elements(); e.hasMoreElements();) {
						
							com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
%>
					<tr>
						<td class="bor_bottom01 align_left"><b><%=info.getCtitle()%></b><br/><%=info.getCcode()%></td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left"><%=info.getMemo() %>&nbsp;</td>
 						<td class="bor_bottom01"><%=info.getClevel()%></td> 
						<td class="bor_bottom01"><%if(info.getOpenflag().equals("Y")) {out.println("����");} else {out.println("�����");} %></td>
						<td class="bor_bottom01"><a href="frm_categoryUpdate.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;<a href="proc_categoryDel.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>&ctype=<%=ctype%>" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
					</tr>
<%
		Vector vtB = mgr.getCategoryListALL2(ctype,"B",info.getCcode());
		if(vtB != null && vtB.size()>0)
		{
			for (Enumeration eb = vtB.elements(); eb.hasMoreElements();)
			{
				com.yundara.beans.BeanUtils.fill(info, (Hashtable)eb.nextElement());
	%>
						<tr>
							<td class="bor_bottom01 align_left">&nbsp;</td>
							<td class="bor_bottom01 align_left"><b><%=info.getCtitle()%></b><br/><%=info.getCcode()%></td>
							<td class="bor_bottom01 align_left">&nbsp;</td>
							<td class="bor_bottom01 align_left"><%=info.getMemo() %>&nbsp;</td>
							<td class="bor_bottom01"><%=info.getClevel()%></td>
							<td class="bor_bottom01"><%if(info.getOpenflag().equals("Y")) {out.println("����");} else {out.println("�����");} %></td>
							<td class="bor_bottom01"><a href="frm_categoryUpdate.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;<a href="proc_categoryDel.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>&ctype=<%=ctype%>" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
						</tr>
	<%

				Vector vtC = mgr.getCategoryListALL2(ctype,"C",info.getCcode());
				if(vtC != null && vtC.size()>0)
				{
					for (Enumeration ec = vtC.elements(); ec.hasMoreElements();)
					{
						com.yundara.beans.BeanUtils.fill(info, (Hashtable)ec.nextElement());
		%>
							<tr>
								<td class="bor_bottom01 align_left">&nbsp;</td>
								<td class="bor_bottom01 align_left">&nbsp;</td>
								<td class="bor_bottom01 align_left"><b><%=info.getCtitle()%></b><br/><%=info.getCcode()%></td>
								<td class="bor_bottom01 align_left"><%=info.getMemo() %>&nbsp;</td>
								<td class="bor_bottom01"><%=info.getClevel()%></td> 
								<td class="bor_bottom01"><%if(info.getOpenflag().equals("Y")) {out.println("����");} else {out.println("�����");} %></td>
								<td class="bor_bottom01"><a href="frm_categoryUpdate.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;<a href="proc_categoryDel.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>&ctype=<%=ctype%>" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
							</tr>
		<%

						Vector vtD= mgr.getCategoryListALL2(ctype,"D",info.getCcode());
						if(vtD != null && vtD.size()>0)
						{
							for (Enumeration ed = vtD.elements(); ed.hasMoreElements();)
							{
								com.yundara.beans.BeanUtils.fill(info, (Hashtable)ed.nextElement());
			%>
								<tr>
									<td class="bor_bottom01 align_left">&nbsp;</td>
									<td class="bor_bottom01 align_left">&nbsp;</td>
									<td class="bor_bottom01 align_left">&nbsp;</td>
									<td class="bor_bottom01 align_left"><b><%=info.getCtitle()%></b><br/><%=info.getCcode()%></td>
									<td class="bor_bottom01"><%=info.getClevel()%></td> 
									<td class="bor_bottom01"><%if(info.getOpenflag().equals("Y")) {out.println("����");} else {out.println("�����");} %> </td>
									<td class="bor_bottom01"><a href="frm_categoryUpdate.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;<a href="proc_categoryDel.jsp?mcode=<%=mcode%>&cuid=<%=info.getCuid()%>&ctype=<%=ctype%>" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
								</tr>
			<%
							}
						}
					}
				}
			}
		}
	}
}
%>
				</tbody>
				</table>
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>