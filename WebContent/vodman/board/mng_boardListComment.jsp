<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.security.SEEDUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.yundara.util.CharacterSet" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<%
if(!chk_auth(vod_id, vod_level, "b_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}


%>

<%
	String paramOcode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
	paramOcode = StringUtils.defaultString(request.getParameter("ocode"),"");
	String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	if (flag == null || flag.length()<=0 || flag.equals("null")) {
		flag = "B";
	}
	int limit=10;
	int totalArticle =0; //총 레코드 갯수
	int totalPage = 0 ; //
	
	//메모 읽기
	int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
	Hashtable memo_ht = new Hashtable();
	MemoManager memoMgr = MemoManager.getInstance();
	//if (paramOcode != null && paramOcode.length() > 0) {
	memo_ht = memoMgr.getMemoListLimitMan( paramOcode, mpg, limit, flag);
	//}
	
	Vector v_bl = (Vector)memo_ht.get("LIST");
	
	com.yundara.util.PageBean mPageBean = null;
	
	if(v_bl != null && v_bl.size()>0){
		mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
		if(mPageBean != null){
			mPageBean.setPagePerBlock(10);
	    	mPageBean.setPage(mpg);
	    	totalPage = mPageBean.getTotalPage();
	    	totalArticle = mPageBean.getTotalRecord();
		}
	}else{
		//결과값이 없다.
		//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
	}
	String jspName="mng_boardListComment.jsp";
	
	int memo_size = 0;
	if (paramOcode != null && paramOcode.length() > 0) {
		memo_size = memoMgr.getMemoCount(paramOcode,flag);
	}

	
%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script src=../include/js/script.js></script>
<script language='javascript'>
	function searchI(){
		if (listForm.searchstring.value == ''){
			 alert("검색어를 입력하세요");
			 return;
		}
		else{
			listForm.action='mng_boardListComment.jsp';
			listForm.submit();
		}
		return
	}

	function sel_del() {

		if ( confirm('정말 삭제하시겠습니까?') ) {
			if(document.listForm.v_chk.length) {  // 여러 개일 경우
				var num = document.listForm.v_chk.length;
			    for(var i = 0; i < num; i++) {
			        if(document.listForm.v_chk[i].checked == true) {
			            document.listForm.action = "proc_boardCommentDelArray.jsp?mpage=<%=mpg%>&muid="+document.listForm.v_chk[i].value + "&mcode=<%=mcode%>&jaction=delete&flag=<%=flag%>";
						document.listForm.submit();
			            break;
					}
				}
			    if(i == num) {
					alert('하나 이상의 댓글을 선택하세요');
					return;
				}
			}else{
				if(document.listForm.v_chk.checked == true) {
		            document.listForm.action = "proc_boardCommentDel.jsp?mpage=<%=mpg%>&muid="+document.listForm.v_chk[i].value + "&mcode=<%=mcode%>&jaction=delete&flag=<%=flag%>";
					document.listForm.submit();
		           
				}else{
					alert(' 댓글을 선택하세요');
					return;
				}
			}
		}
		
	}
		
	
	function checkInverse() {
		if (document.listForm.chkAll.checked){
			if(document.listForm.v_chk.length) 
			{  // 여러 개일 경우
				for(i=0;i<document.listForm.v_chk.length;i++) {
					document.listForm.v_chk[i].checked = true;
				}
			}
			else
			{
				 document.listForm.v_chk.checked = true;
			}
		}else{
			if(document.listForm.v_chk.length) {  // 여러 개일 경우
				for(i=0;i<document.listForm.v_chk.length;i++) {
					document.listForm.v_chk[i].checked = false;
				}
			}else{
				document.listForm.v_chk.checked = false;
			}
		}
	}	

</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>게시물 댓글관리</span></h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; 게시판 정보 &gt; <span>게시물 댓글</span></p>
			<form name="listForm" method="post">
			<input type="hidden" name="mcode" value="<%=mcode%>">
			
			<div id="content">
				<!-- 내용 -->
				
				<table cellspacing="0" class="border_search" summary="게시판 검색">
				<caption>게시판 검색</caption>
				<colgroup>
					<col width="50%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<td><p class="to_page"><p class="to_page">Total<b><%=totalArticle%>건 <%=mpg %>/<%=totalPage%>Page</b></p></td>
						<td class="align_right">
							<select name="field" class="sec01" style="width:80px;">
													  <option value="1" selected>제목</option>
													  <option value="2">내용</option>
													  <option value="3">제목+내용</option>
													  <option value="4">글쓴이</option>
													</select>
							<input type="text" name="searchstring" value="" class="input01" style="width:150px;"/>
							<a href="javascript:searchI();" title="검색"><img src="/vodman/include/images/but_search.gif" alt="검색" class="pa_bottom" /></a>
						</td>
					</tr>
				</tbody>
				</table>

				<table cellspacing="0" class="board_list" summary="게시판 정보">
				<caption>게시판 정보</caption>
				<colgroup>
				<col width="7%"/>
					<col width="7%"/>
					<col/>
					<col width="14%"/>
					<col width="9%"/>
					<col width="9%"/>
					
				</colgroup>
				<thead>
					<tr>
					<th><input type="checkbox" name="chkAll" onclick="javascript:checkInverse();"></th>
						<th>번호</th>
						<th>내용</th>
						<th>글쓴이</th>
						<th>작성일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				 <!-- list start-->
                                        <%if(v_bl != null && v_bl.size() > 0){%>
                                        <%
											
		
		
											try
											{
												
												if(v_bl != null && v_bl.size() >0){
													String list_id ="";
													String list_title ="";
													String list_name ="";
													String ip="";
													String list_date ="";
													int list_count =0;
													String img_url = "";
													int re_level = 0;
													int list = 0;
													String ccode = "";
													int board_id = 0;
													MemoInfoBean binfo = new MemoInfoBean();
													for(int i = mPageBean.getStartRecord()-1; i < mPageBean.getEndRecord() && (list<v_bl.size()); i++, list++) {
														  com.yundara.beans.BeanUtils.fill(binfo, (Hashtable)v_bl.elementAt(list));
														  list_id = binfo.getOcode() ;
														  list_name =binfo.getWnick_name() ;
														  //list_name = SEEDUtil.getDecrypt(binfo.getWname());
														  list_title = StringUtils.replace(StringEscapeUtils.escapeHtml(binfo.getComment()), "\n", "<br>") ;					  
														  list_date = binfo.getWdate() ;
														  ccode = binfo.getCcode();
														  board_id = binfo.getBoard_id();
														  if(list_date != null && list_date.length()>10){
																list_date = list_date.substring(0,10);
															}
														 
														  ip = binfo.getIp();
													 

																			%>
					<tr class="height_25 font_127 bor_bottom01"  onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''">
					<td class="bor_bottom01"><input type="checkbox" name="v_chk" value="<%=binfo.getMuid()%>"/>&nbsp;</td>
						<td class="bor_bottom01"><%=mPageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01">
						<%
						if(flag != null && flag.equals("B")){
						%>
						<a href="/vodman/board/frm_boardListView.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>" title="게시물 확인">
						<%}else if (flag != null && flag.equals("M")){ %>
						<a href="/vodman/vod_aod/frm_updateContent.jsp?ocode=<%=list_id%>&ccode=<%=ccode%>&mcode=0701" title="게시물 확인">
						<%} %>
						<%=list_title%></a></td>
						<td class="bor_bottom01"><%=list_name%></td>
						<td class="bor_bottom01"><%=list_date%></td>
						<td class="bor_bottom01"><a href="proc_boardCommentDel.jsp?mpage=<%=mpg%>&muid=<%=binfo.getMuid()%>&mcode=<%=mcode%>&jaction=delete&flag=<%=flag%>" onClick="return confirm('정말 삭제하시겠습니까?')" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
					 <%
												}
					%>
					 <tr  >
                           <td colspan="6" align="center"> <input type="button" onclick='javascript:sel_del();' value="선택삭제" /></td>
                  	</tr> 
					<%
											}
										  }catch(Exception e){
											  out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
										  
										  }
									%>
                                        <%}else{%>
                                        <tr class="height_25 font_127 bor_bottom01 back_f7">
                                          <td colspan="6" align="center">등록된 게시물이없습니다.</td>
                                        </tr>
                                        <%}%>
										
				</tbody>
				</table>
				<div class="paginate">
				<%if(v_bl != null && v_bl.size() >0){ %>
				<%@ include file="page_link_memo2.jsp" %>
				<%} %>
				</div>
				
				
				<br/><br/>
			</div>
		</div>	
	 </form>


			<%@ include file="/vodman/include/footer.jsp"%>