<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "r_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 주현
	 *
	 * @description : 생방송 리스트 제공
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
	int listCnt = 10;				//페이지 목록 갯수 

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
		<!--	컨텐츠	-->
		<div id="contents">
			<h3><span>보이는 라디오</span> 목록</h3>
			<p class="location">관리자페이지 &gt; 보이는 라디오 &gt; <span>보이는 라디오 목록</span></p>
			<div id="content">
				<!-- 내용 -->
				<p class="to_page">Total<b> <%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>Page<b><%=vt != null && vt.size()>0?pageBean.getCurrentPage():0%>/<%=vt != null && vt.size()>0?pageBean.getTotalPage():0%></b></p>
				<table cellspacing="0" class="board_list" summary="생방송 목록">
				<caption>생방송 목록</caption>
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
						<th>번호</th>
						<th>방송제목</th>
						<th>방송시간</th>
						<th>회원레벨</th>
						<th>시청횟수</th>
						<th>출력</th>
						<th>관리</th>
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
						<td class="bor_bottom01"><%=linfo.getRlevel() == 0? "전체":"로그인회원"%></td>
						<td class="bor_bottom01"><%=linfo.getRhit()%></td>
						<td class="bor_bottom01"><%=(linfo.getOpenflag().equals("Y") ? "보임" : "숨김")%></td>
						<td class="bor_bottom01"><a href="proc_Live_del.jsp?mcode=<%=mcode%>&rcode=<%=linfo.getRcode()%>" title="삭제" onClick="return confirm('정말 삭제하시겠습니까?')"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
					  <%
				}
			}else {
					 %>
					<tr class="height_25 font_127 bor_bottom01 back_f7">
						<td class="bor_bottom01" colspan='7'>등록된 정보가 없습니다.</td>
						
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
