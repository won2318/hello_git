<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.security.SEEDUtil"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "b_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}


%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%

	int board_id = 0;
	if(request.getParameter("board_id") == null || request.getParameter("board_id").length()<=0 || request.getParameter("board_id").equals("null")){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('접근경로가 잘못되었습니다. 다시 한번 확인 하여 주시기 바랍니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0901";
		}
		 String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}else{
		try{
			board_id = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("board_id")));
		}catch(Exception ex){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('접근경로가 잘못되었습니다. 다시 한번 확인 하여 주시기 바랍니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String mcode= request.getParameter("mcode");
			if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
				mcode = "0901";
			}

			String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
	}

//게시판 정보 불러오기
	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0901";
		}
			String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	//board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag, board_user_flag, board_top_comments, board_footer_comments, board_priority
	String board_title = "";
	String board_page_line = "";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	String flag = "";

	if(v_bi != null && v_bi.size() >0){
		board_title = String.valueOf(v_bi.elementAt(0));
		board_page_line = String.valueOf(v_bi.elementAt(1));
		board_image_flag = String.valueOf(v_bi.elementAt(2));
		board_file_flag = String.valueOf(v_bi.elementAt(3));
		board_link_flag = String.valueOf(v_bi.elementAt(4));
		board_user_flag = String.valueOf(v_bi.elementAt(5));
		board_top_comments = String.valueOf(v_bi.elementAt(6));
		board_footer_comments = String.valueOf(v_bi.elementAt(7));
		board_priority = String.valueOf(v_bi.elementAt(8));
		flag = String.valueOf(v_bi.elementAt(12));
	}else{
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0901";
		}
			String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}


	String field = com.vodcaster.utils.TextUtil.getValue(request.getParameter("field"));
	String search_field = com.vodcaster.utils.TextUtil.getValue(request.getParameter("search_field"));
	String searchstring = "";
	try{
		searchstring = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchstring")));
	}catch(Exception ex){
		searchstring = "";
	}
	if(field == null) field = "";
	if(search_field == null) search_field = "";
	if(searchstring == null) searchstring = "";

	int pg = 1;
	if(request.getParameter("page") != null && com.yundara.util.TextUtil.isNumeric(request.getParameter("page"))){
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception ex){
			pg =1;
		}
	}
	
	//리스트의 공지 불러오기
	Vector v_bt = null;
	try{
		v_bt = BoardListSQLBean.getAllBoardList_admin(board_id, field, searchstring, "Y");
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0901";
		}
		 String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

	
	
	int limit=10;
	int totalArticle =0; //총 레코드 갯수
	int totalPage = 0 ; //
	
	String jspName="mng_boardListList.jsp";
	
    com.yundara.util.PageBean pageBean = null;
    Hashtable result_ht = null;
	//리스트 불러오기
	Vector v_bl = null;
	try{
		result_ht = BoardListSQLBean.getAllBoardList_admin(board_id, field, search_field, searchstring, "", pg, limit);
		if(!result_ht.isEmpty() ) {
			v_bl = (Vector)result_ht.get("LIST");

			if ( v_bl != null && v_bl.size() > 0){
		        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		        if(pageBean != null){
		        	totalArticle = pageBean.getTotalRecord();
		        	totalPage = pageBean.getTotalPage();
		        }
			}
	    }
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length()<=0 || mcode.equals("null")){
			mcode = "0901";
		}
		 String REF_URL="mng_boardList.jsp?mcode=0901" ;
		%>
		<%@ include file = "/vodman/include/REF_URL.jsp"%>
		<%
		return;
	}

%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script src=../include/js/script.js></script>
<script language='javascript'>
	function searchI(){
	 
			listForm.action='mng_boardListList.jsp';
			listForm.submit();
		 
		return
	}

	function chkMain(object,list_id){
		var url = "proc_updateMain.jsp?board_id=<%=board_id%>";
		var param = "";
		if(object.checked){
			param="&open_space=Y";
		}else{
			param="&open_space=N";
		}

		param = param + "&list_id="+list_id
		url = url+ param;
		//document.location.href=url;
		var anchor = document.createElement("a");
		if (!anchor.click) { //Providing a logic for Non IE
			location.href = url;
		 
		}
		anchor.setAttribute("href", url);
		anchor.style.display = "none";
		var aa = document.getElementById('contents');
		if( aa ){
			aa.appendChild(anchor);
			anchor.click();
		}		
	}

</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span><%=board_title%></span></h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; 게시판 정보 &gt; <span><%=board_title%></span></p>
			<form name="listForm" method="post">
			<input type="hidden" name="mcode" value="<%=mcode%>">
			<input type="hidden" name="board_id" value="<%=board_id%>">
			<div id="content">
				<!-- 내용 -->
				<%if(board_top_comments != null && board_top_comments.length()>0){%>
				<p class="top_content"><%=board_top_comments%></p>
				<%}%>
				<table cellspacing="0" class="border_search" summary="게시판 검색">
				<caption>게시판 검색</caption>
				<colgroup>
					<col width="50%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<td><p class="to_page"><p class="to_page">Total<b><%=totalArticle%>건 <%=pg %>/<%=totalPage%>Page</b></p></td>
						<td class="align_right">
						<%if (board_id == 22   ) { %> 
							<select name="search_field" class="sec01" style="width:80px;">
							  <option value="">영상+기사</option>
							  <option value="V" <%if (search_field.equals("V")) {out.println("selected='selected'");} %>>영상</option>
							  <option value="N" <%if (search_field.equals("N")) {out.println("selected='selected'");} %>>기사</option>
							 
							</select>
						<%}%>
						
							<select name="field" class="sec01" style="width:80px;">
							  <option value="1" selected>제목</option>
							  <option value="2" <%if (field.equals("2")) {out.println("selected='selected'");} %>>내용</option>
							  <option value="3" <%if (field.equals("3")) {out.println("selected='selected'");} %>>제목+내용</option>
							  <option value="4" <%if (field.equals("4")) {out.println("selected='selected'");} %>>글쓴이</option>
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
					<col/>
					<col width="14%"/>
					<col width="9%"/>
					<col width="7%"/> 
					<col width="6%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>작성일</th>
						<th>조회</th>
						<th>공지</th>
					</tr>
				</thead>
				<tbody>
				 <!-- list start-->
                                        <%if((v_bt != null && v_bt.size()>0) ||(v_bl != null && v_bl.size() > 0)){%>
                                        <%
 											try
											{
												if(v_bt != null && v_bt.size()>0){
													String list_id ="";
													String list_title ="";
													String list_name ="";
													String ip="";
													String list_date ="";
													String list_count ="";
													String img_url = "";
													String list_data_file = "";
													String temp_name = "";
													int re_level = 0;
													for(int i = 0; i < v_bt.size(); i++) {
														list_id = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(0));
														ip = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(39));
														temp_name = SEEDUtil.getDecrypt(String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(40)));
														list_name = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(3));
														int loc = list_name.indexOf("("); 
														if( loc > 1) {
														list_name=list_name.substring(0,loc);
														}
														
														list_title = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(4));
														try{
															re_level = Integer.parseInt(String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(11)));
														}catch(Exception e){
															re_level = 0;
														}
														list_count = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(12));
														list_date = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(16));
														if(list_date != null && list_date.length()>10){
															list_date = list_date.substring(0,10);
														}
														img_url = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(8));
														String img_org = img_url;
														

														list_data_file = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(7));
														
														String wdate = list_date.replace("-","");
														
														
														if(flag.equals("V")){
															img_url = SilverLightServer + "/" + img_url;
														}else{
 
//															img_url = DirectoryNameManager.UPLOAD+"/board_list/img/" +img_org;
// 															DirectoryNameManager Dmanager = new DirectoryNameManager();
// 															File file = new File(Dmanager.VODROOT + img_url);
// 															if(file.isDirectory() ||  !file.exists()) {
// 																img_url = "/vodman/include/images/no_img02.gif";
// 															}else{
// 																img_url = java.net.URLEncoder.encode(img_org, "EUC-KR");
// 																img_url = img_url.replace("+","%20");
// 																img_url = DirectoryNameManager.UPLOAD+"/board_list/img/" +img_url;
// 															}
														}

																			%>
					<tr <% if (flag.equals("P") || flag.equals("V")){%>class="font_12r"<%}else{%> class="height_25 font_12r"<%}%>>
						<td class="bor_bottom01">공지</td>
						<td  <% if (flag.equals("P") || flag.equals("V")){%> class="align_left bor_bottom01 font_12r"<%}else{%> class="align_left bor_bottom01 font_12r"<%}%>> <%	if(re_level > 0) { // 답변 게시물일 경우
											int wid = 10 * re_level; // 들여쓰기 포인트
																
										%><img src="../image/spacer.gif" width="<%=wid%>"> 
                                            <img src="../image/re.gif">
                                            <%}%>
											<% if (flag.equals("P") || flag.equals("V")){%><img src="img_2.jsp?list_id=<%=list_id%>" border="0"  class="img_style02"><%} %><a href="frm_boardListView.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&search_field=<%=search_field%>&page=<%=pg%>&searchstring=<%=searchstring%>&mcode=<%=mcode%>" title="<%=list_title%>"><%= (list_title.length() > 30) ? list_title.substring(0,30)+"..": list_title%></a></td>
						
						


						<td class="bor_bottom01"><%=list_name%></td>
						<td class="bor_bottom01"><%=list_date%></td>
						<td class="bor_bottom01"><%=list_count%></td>
						<td class="bor_bottom01"><input type="checkbox" name="notice" value="v_chk<%=i%>" onClick="javascript:chkMain(this,<%= String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(0))%>);" value="Y" checked/></td>
					</tr>
					 <%
													}
												}
											if(v_bl != null && v_bl.size() >0){
												int list_id =0;
												String list_title ="";
												String list_name ="";
												String ip="";
												String list_date ="";
												int list_count =0;
												String img_url = "";
												int re_level = 0;
												int list = 0;
												String image_text8 = "";
												BoardListInfoBean binfo = new BoardListInfoBean();
												for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<v_bl.size()); i++, list++) {
													  com.yundara.beans.BeanUtils.fill(binfo, (Hashtable)v_bl.elementAt(list));
													  list_id = binfo.getList_id() ;
													  list_name =binfo.getList_name() ;
													  list_title = binfo.getList_title() ;					  
													  re_level = binfo.getList_re_level() ;
													  list_count = binfo.getList_read_count() ;
													  list_date = binfo.getList_date() ;
													  if(list_date != null && list_date.length()>10){
															list_date = list_date.substring(0,10);
														}
													  img_url = binfo.getList_image_file() ; 
													  ip = binfo.getIp();
													 String img_org = img_url;
													  
													 
													if(flag.equals("V")){
														img_url = SilverLightServer + "/" + img_url;
													}else{
//														img_url = DirectoryNameManager.UPLOAD+"/board_list/img/" +img_org;
 
// 														DirectoryNameManager Dmanager = new DirectoryNameManager();
// 														File file = new File(Dmanager.VODROOT + img_url);
// 														if(file.isDirectory() ||  !file.exists()) {
// 															img_url = "/vodman/include/images/no_img02.gif";
// 														}else{
// 															img_url = java.net.URLEncoder.encode(img_org, "EUC-KR");
// 															img_url = img_url.replace("+","%20");
// 															img_url = DirectoryNameManager.UPLOAD+"/board_list/img/" +img_url;
// 														}
													}
													image_text8 = binfo.getImage_text8() ;

																			%>
					<tr <% if (flag.equals("P") || flag.equals("V")){%>class="font_127"<%}else{%> class="height_25 font_127 bor_bottom01"<%}%> onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01">
						<%if (board_id == 22 && image_text8 != null && image_text8.equals("V") ) {out.println("<font color='#00a1e0'>영상(수원iTV)</font><br/> ");} 
						else if (board_id == 22 && image_text8 != null && image_text8.equals("N")) {out.println("<font color='#388cff;'>기사(e수원뉴스)</font><br/> ");}%>
						<% if (flag.equals("P") || flag.equals("V")){%><img src="img_2.jsp?list_id=<%=list_id%>" border="0"  class="img_style02"><%} %>
						<%
							if(re_level > 0) {
								for(int j=1; j < re_level; j++) {
						%>
								&nbsp;&nbsp;
						<%		} %>
								<img src="/vodman/include/images/reply.gif" alt="답글 화살표" />
						<%	} %>
						<a href="frm_boardListView.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&search_field=<%=search_field%>&page=<%=pg%>&searchstring=<%=searchstring%>&mcode=<%=mcode%>" title="Q&amp;A"><%= (list_title.length() > 30) ? list_title.substring(0,30)+"..": list_title%></a></td>

						<td class="bor_bottom01"><%=list_name%></td>
						<td class="bor_bottom01"><%=list_date%></td>
						<td class="bor_bottom01"><%=list_count%></td>
						<td class="bor_bottom01"><%if(re_level <= 0) {%><input name="v_chk<%=i%>" type="checkbox" onClick="javascript:chkMain(this,<%=binfo.getList_id()%>);" value="N"><%}else{%>&nbsp;<%}%></td>
					</tr>
					 <%
												}
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
				<%@ include file="page_link.jsp" %>
				<%} %>
				<p class="but02"><a href="frm_boardListAdd.jsp?board_id=<%=board_id%>&page=<%=pg%>&field=<%=field%>&search_field=<%=search_field%>&searchstring=<%=searchstring%>&mcode=<%=mcode%>" title="쓰기"><img src="/vodman/include/images/but_write.gif" alt="쓰기"/></a></p>
				</div>
				<%if(board_footer_comments != null && board_footer_comments.length()>0){
					%>
				<p class="top_content"><%=board_footer_comments%></p>
				<%}%>
				<br/><br/>
				<br/><br/>
			</div>
		</div>	
	 </form>


			<%@ include file="/vodman/include/footer.jsp"%>