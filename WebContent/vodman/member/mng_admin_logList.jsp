<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 최희성
	 *
	 * @description : 회원의 전체정보를 보여줌.
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
	
   
    AdminManager agr = AdminManager.getInstance();
	Hashtable result_ht = null;
	result_ht = agr.getAdminListAll(searchField, searchString, pg);
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
    document.search.action = "mng_admin_logList.jsp?mcode=<%=mcode%>";
    document.search.submit();
}

 
 
//-->
</script>
<%@ include file="/vodman/member/member_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>관리자</span> 로그인 로그</h3>
			<p class="location">관리자페이지 &gt; 관리자관리 &gt; <span>관리자 로그 남기기</span></p>
			<div id="content">
				<!-- 내용 -->
				<form name="search" method="post">
				<input type="hidden" name="mcode" value="<%=mcode%>" />
				<table cellspacing="0" class="log_list" summary="관리자 검색">
				<caption>관리자 검색</caption>
				 
				<tbody>
					  
					<tr>
						<th class="bor_bottom01"><strong>검색</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<select name="searchField" class="sec01" style="width:80px;">
								<option value="user_id" <%=(searchField.equals("user_id"))?"selected":""%>>
								  아이디</option>
							</select>
							<input type="text" name="searchString" class="input01" style="width:150px;" value="<%=searchString%>" />
							<a href="javascript:search();"><img src="/vodman/include/images/but_search.gif" alt="검색" border="0"></a></td>
					</tr>
					 
					
				</tbody>
				</table>
				</form>
				<br/>
				<p class="to_page">Total<b> <%= iTotalCount%></b>Page<b><%=iTotalCount>0?pageBean.getCurrentPage():1%>/<%=iTotalCount>0?pageBean.getTotalPage():1%></b></p>
				<table cellspacing="0" class="board_list" summary="게시판 정보">
				<caption>게시판 정보</caption>
 
				<thead>
					<tr> 
					<th align="center">번호
 					<th align="center">아이디</th>
                    <th align="center">ip</th>
                    <th align="center">날짜</th>
                    <th align="center">성공여부</th>
                    <th align="center">기타</th>
                  
                   
					</tr>
				</thead>
				<tbody>

				<%
					 
						AdminLoginLog info = new AdminLoginLog();
						int list = 0;
					 
						if(vt != null && vt.size()>0){
							for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<vt.size()); i++, list++) {
							com.yundara.beans.BeanUtils.fill(info, (Hashtable)vt.elementAt(list));

				%>
					<tr class="height_25 font_127">
 						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td> 
 						<td class="bor_bottom01"><%=info.getUser_id()%></td> 
 						<td class="bor_bottom01"><%=info.getUser_ip()%></td> 
 						<td class="bor_bottom01"><%=info.getInput_date()%></td>
 						 <td class="bor_bottom01"><%=info.getInput_flag()%></td>
 						 <td class="bor_bottom01"><%=info.getEtc()%></td>

					</tr>


					<%
								}
							} else {
					%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01" colspan='9'> 등록된 정보가 없습니다.</td>
					
					</tr>
					<% }%>
					
				</tbody>
				</table>
				<%
				String jspName = "mng_admin_logList.jsp";
				if(vt != null && vt.size()>0){
				%>
				 <%@ include file="page_link.jsp" %>
				 <%}%>
				<br/><br/>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>