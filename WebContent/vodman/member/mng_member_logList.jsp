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
	 * @author ����
	 *
	 * @description : ȸ���� ��ü������ ������.
	 * date : 2005-01-07
	 */
	

    int pg = 0;
	String searchField = "";
	String searchString = "";
	
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length()>0 && !request.getParameter("searchField").equals("null"))
		searchField = request.getParameter("searchField");

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0 && !request.getParameter("searchString").equals("null"))
		searchString = CharacterSet.toKorean(request.getParameter("searchString"));
	
	

 
    if(request.getParameter("page")==null){
        pg = 1;
    }else{
		try{
			if(com.vodcaster.utils.TextUtil.getValue(request.getParameter("page")) != ""){
				pg = Integer.parseInt(request.getParameter("page"));
			}
		}catch(Exception ex){
			pg =1;
		}
    }

 
	String strtmp = "";
   
	//strtmp = "sex:<font color=red>" +sex+ "</font>|level:<font color=red>" +level+ "</font>|useMailling:<font color=red>" +useMailling+ "</font>|joinDate1:<font color=red>" +joinDate1+ "</font>|joinDate2:<font color=red>" +joinDate2+ "</font>|searchField:<font color=red>" +searchField+ "</font>|searchString:<font color=red>" +searchString;

    MemberManager mgr = MemberManager.getInstance();
	Hashtable result_ht = null;
    result_ht = mgr.getMember_logListAll( searchField, searchString, pg );
 
	int iTotalCount = 0;
	int iTotalPage= 0;
    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
    if(!result_ht.isEmpty()) {
        vt = (Vector)result_ht.get("LIST");
 
        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
        if(vt != null && pageBean != null){
        	pageBean.setPagePerBlock(10);
        	pageBean.setPage(pg);
			iTotalCount = pageBean.getTotalRecord();
			iTotalPage = pageBean.getTotalPage();
        }
    }
String strLink = "";
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
<!--

 
function search() {
    document.search.action = "mng_member_logList.jsp?mcode=<%=mcode%>";
    document.search.submit();
}

function viewStat() {
    document.search.action = "mng_vodMemberExcel.jsp";
    document.search.target="_blank";
    document.search.submit();
}

 
//-->
</script>
<%@ include file="/vodman/member/member_left.jsp"%>
		<!-- ������ -->
		<div id="contents">
			<h3><span>������</span> �α�</h3>
			<p class="location">������������ &gt; �����ڰ��� &gt; <span>������ �α�</span></p>
			<div id="content">
				<!-- ���� -->
				<form name="search" method="post">
				<input type="hidden" name="mode" value="" />
				<table cellspacing="0" class="log_list" summary="������ �˻�">
				<caption>������ �˻�</caption>
				 
				<tbody>
					  
					<tr>
						<th class="bor_bottom01"><strong>�˻�</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<select name="searchField" class="sec01" style="width:80px;">
								<option value="userid" selected <%=(searchField.equals("userid"))?"selected":""%>>
								  ���̵�</option>
								  <option value="name" <%=(searchField.equals("name"))?"selected":""%>>
								  �̸�</option>	   
							</select>
							<input type="text" name="searchString" class="input01" style="width:150px;" value="<%=searchString%>" />
							<a href="javascript:search();"><img src="/vodman/include/images/but_search.gif" alt="�˻�" border="0"></a></td>
					</tr>
					 
					
				</tbody>
				</table>
				</form>
				<br/>
				<p class="to_page">Total<b> <%= iTotalCount%></b>Page<b><%=iTotalCount>0?pageBean.getCurrentPage():1%>/<%=iTotalCount>0?pageBean.getTotalPage():1%></b></p>
				<table cellspacing="0" class="board_list" summary="�Խ��� ����">
				<caption>�Խ��� ����</caption>
 
				<thead>
					<tr> 
                    <th align="center" width="6%">��ȣ</th>
 					<th align="center">���̵�</th>
                    <th align="center">�̸�</th>
                    <!--<th align="center">����⵵</th> 
                    <th align="center">����</th>
					<th align="center">��ȭ��ȣ</th>
                    <!--<th align="center">�޴�����ȣ</th>-->
                    <!-- <th align="center">�����ȣ</th>-->
                    <!--<th align="center">�ּ�</th>-->
                    <th align="center">�̸���</th>
                    <th align="center">�Ҽ�</th>
                    <th align="center">������</th>
                    <th align="center">�Ͻ�</th>
                    <th align="center">��й�ȣ</th>
                    <th align="center">Ż��</th>
                    <th align="center">�۾�ID</th>
                  
                   
					</tr>
				</thead>
				<tbody>

				<%
						MemberLogBean info = new MemberLogBean();
						int list = 0;
						if(vt != null && vt.size()>0){
 
							for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
							com.yundara.beans.BeanUtils.fill(info, (Hashtable)vt.elementAt(list));
					%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="bor_bottom01"><%=info.getUserid()%></td>
						<td class="bor_bottom01"><%=info.getName()%></td>
						<!--<td class="bor_bottom01"><%=info.getBirthday() %></td> 
						<td class="bor_bottom01"><%=info.getSex() %></td>
						<td class="bor_bottom01"><%=info.getTel() %></td>
						<td class="bor_bottom01"><%=info.getMobile() %></td>
						<td class="bor_bottom01"><%=info.getZipcode() %></td>
						<td class="bor_bottom01"><%=info.getAddr1() %> <%=info.getAddr2() %></td>-->
						<td class="bor_bottom01"><%=info.getEmail() %></td>
						<td class="bor_bottom01"><%=info.getDeptcode() %></td>
						<td class="bor_bottom01"><%=info.getIp() %></td>
						<td class="bor_bottom01"><%=info.getUpdate_date() %></td>
						<td class="bor_bottom01"><%=info.getUserpwd() %></td>
						<td class="bor_bottom01"><%=info.getUser_out() %></td>
						<td class="bor_bottom01"><%=info.getEtc() %></td>


					</tr>

					<%
								}
							} else {
					%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01" colspan='9'> ��ϵ� ������ �����ϴ�.</td>
					
					</tr>
					<% }%>
					
				</tbody>
				</table>
				<%
				String jspName = "mng_member_logList.jsp";
				if(vt != null && vt.size()>0){
				%>
				 <%@ include file="page_link.jsp" %>
				 <%}%>
				<br/><br/>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>