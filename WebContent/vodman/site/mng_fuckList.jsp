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
	 * @author lee hee rak
	 *
	 * @description : 욕설	 정보 목록.
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
	int listCnt = 20;				//페이지 목록 갯수 


	FucksInfoManager mgr = FucksInfoManager.getInstance();
    Hashtable result_ht = null;
    result_ht = mgr.getAllFucks_admin( searchstring, pg,listCnt,"desc", order );


    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
	int totalArticle =0; //총 레코드 갯수
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
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>욕설</span> 목록</h3>
			<p class="location">관리자페이지 &gt; 회원관리 &gt; <span>욕설 목록</span></p>
			<div id="content">
			
				<!-- 내용 -->
				<form name="frmMedia" action="mng_fuckList.jsp">
				<input type="hidden" name="page" value="<%=pg %>" />
				<input type="hidden" name="mcode" value="<%=mcode%>" />
				<p class="to_page">Total<b><%=totalArticle%></b> &nbsp;<b><%=pg%>/<%=totalPage%></b>Page
					
					<select name="order" id="order" class="sec01" style="width:60px;margin-bottom:5px;" onchange="javascript:refreshOrder();">
						<option value="">정렬기준 </option>
						<option value="fuck_id" <%=order.equals("fuck_id")?" selected ":"" %>>등록순</option>
						<option value="fucks" <%=order.equals("fucks")?" selected ":"" %>>욕설</option>
					</select>
				</p> </form>
				<table cellspacing="0" class="board_list" summary="욕설 목록">
				<caption>욕설 목록</caption>
				<colgroup>
					<col width="7%"/>
					<col/>
					<col width="12%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>욕설</th>
						<th>관리</th>
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
						<a href="frm_fuck_Update.jsp?mcode=0109&fuck_id=<%=linfo.getFuck_id()%>" title="수정"><img src="/vodman/include/images/but_edit.gif" alt="수정"/></a>&nbsp;
						<a href="proc_fuck_del.jsp?mcode=<%=mcode%>&fuck_id=<%=linfo.getFuck_id()%>" title="삭제" onClick="return confirm('정말 삭제하시겠습니까?')"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
					<%
							}
						}else {
					 %>
					<tr class="height_25 font_127 bor_bottom01 back_f7">
						<td class="bor_bottom01" colspan='3'>등록된 정보가 없습니다.</td>

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
					<a href="frm_fuckAdd.jsp?mcode=0109"><img src="/vodman/include/images/but_addi.gif" alt="추가"/></a>
				</div>
				<br/><br/>
				
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>