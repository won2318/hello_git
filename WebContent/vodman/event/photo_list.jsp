<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.security.SEEDUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

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

	int board_id = 2; // 이벤트 PHOTO
 
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
	String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "list_id");
  	String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

	String field = com.vodcaster.utils.TextUtil.getValue(request.getParameter("field"));
	String searchstring = "";
	try{
		searchstring = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchstring")));
	}catch(Exception ex){
		searchstring = "";
	}
	if(field == null) field = "";
	if(searchstring == null) searchstring = "";

	int pg = 0;
	if(request.getParameter("page")==null || !com.yundara.util.TextUtil.isNumeric(request.getParameter("page"))){
        pg = 1;
    }else{
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception ex){
			pg = 1;
		}
    }
	String event_seq = "";
	if (request.getParameter("event_seq") != null && request.getParameter("event_seq").length() > 0  && !request.getParameter("event_seq").equals("null")) {
		event_seq = com.vodcaster.utils.TextUtil.getValue(request.getParameter("event_seq"));
	}
	
	//리스트의 공지 불러오기
 
	
	
	int limit=10;
	int totalArticle =0; //총 레코드 갯수
	int totalPage = 0 ; //
 
	
    com.yundara.util.PageBean pageBean = null;
    Hashtable result_ht = null;
	//리스트 불러오기
	Vector v_bl = null;
	try{
		result_ht = BoardListSQLBean.getAllBoardList_admin_event(board_id, field, searchstring, "", pg, limit, event_seq, order, direction );
		if(!result_ht.isEmpty() ) {
			v_bl = (Vector)result_ht.get("LIST");

			if ( v_bl != null && v_bl.size() > 0){
		        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		        if(pageBean != null){
		        	pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");

					pageBean.setLinePerPage(limit);
					pageBean.setPagePerBlock(10);
					pageBean.setPage(pg);
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

	
	String strLink = "";
    strLink += "&event_seq="+event_seq+"&field=" +field+ "&searchstring=" +searchstring;
    
%>

<%@ include file="/vodman/include/top.jsp"%>
<%
 mcode="0801" ;
%>

<%@ include file="/vodman/event/event_left.jsp"%> 

<script src="/vodman/include/js/script.js"></script>
<script language='javascript'>
	function searchI(){
		if (listForm.searchstring.value == ''){
			 alert("검색어를 입력하세요");
			 return;
		}
		else{
			listForm.action='photo_list.jsp';
			listForm.submit();
		}
		return
	}


	function change_event_gread(cObject, list_id) {
		if(confirm('순위 변경하시겠습니까?')) {
			var gread = cObject.options[cObject.selectedIndex].value;
			var url = "proc_photo_update.jsp?list_id=" + list_id + "&event_gread="+gread;
			var form = document.frmMedia;
			form.action = url;
			form.submit();
		}
	}

	function change_open_flag(cObject, list_id) {
		if(confirm('공개를 변경하시겠습니까?')) {
			var list_open = cObject.options[cObject.selectedIndex].value;
			var url = "proc_photo_update.jsp?list_id=" + list_id + "&list_open="+list_open;
			var form = document.frmMedia;
			form.action = url;
			form.submit();
		}
	}

 

	function photo_delete(list_id) {
		if(confirm('삭제 하시겠습니까?')) {
		 
			var url = "proc_photo_delete.jsp?list_id=" + list_id ;
			var form = document.frmMedia;
			form.action = url;
			form.submit();
		}
	}


	function photo_view(board_id,list_id){
		sv_wm_viewer = window.open("pop_photo_viewer.jsp?board_id="+board_id+"&list_id="+list_id,"photo_viewer","toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes, scrollbars=yes,width=600,height=630\"");
	}

	function setSorder(order, direction) {
		var form = document.frmMedia;
		form.order.value = order;
		form.direction.value = direction;
		form.submit();
	}   


	function rank_cnt(){
		 
		document.frmMedia.target="hiddenFrame";
		//document.frmMedia.action="photo_list_excel.jsp";
		document.frmMedia.action="copy_to_rank_photo.jsp";
		
		document.frmMedia.submit();
	}
		
</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span><%=board_title%></span></h3>
			<p class="location">관리자페이지 &gt; 이벤트 관리 &gt; <span><%=board_title%></span></p>
			<form name="frmMedia" method="post" action="photo_list.jsp">
			<input type="hidden" name="mcode" value="<%=mcode%>" />
			<input type="hidden" name="board_id" value="<%=board_id%>" />
			<input type="hidden" name="event_seq" value="<%=event_seq%>" />
			 <input type="hidden" name="order" value="<%=order%>">
			 <input type="hidden" name="direction" value="<%=direction%>">
			 <input type="hidden" id="page" name="page" value="<%=pg%>" />
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
						<td><p class="to_page">Total<b><%=totalArticle%>건 <%=pg %>/<%=totalPage%>Page</b></p></td>
						<td class="align_right">
							<select name="field" class="sec01" style="width:80px;">
													  <option value="1"  <% if (field != null && field.equals("1")) {out.println("selected");} %>>제목</option>
													  <option value="2"  <% if (field != null && field.equals("2")) {out.println("selected");} %>>내용</option>
													  <option value="3"  <% if (field != null && field.equals("3")) {out.println("selected");} %>>제목+내용</option>
													  <option value="4"  <% if (field != null && field.equals("4")) {out.println("selected");} %>>글쓴이</option>
													</select>
							<input type="text" name="searchstring" value="" class="input01" style="width:150px;"/>
							<a href="javascript:searchI();" title="검색"><img src="/vodman/include/images/but_search.gif" alt="검색" class="pa_bottom" /></a>
							<a href="javascript:rank_cnt();" title="당첨자 복사"><img src="/vodman/include/images/btn_wincopy.gif" alt="당첨자 복사" class="pa_bottom" /></a>
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
						<th>제목<% if ( order != null && order.equals("list_title")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('list_title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="제목 역순 정렬"/></a> 
								<a href="javascript:setSorder('list_title', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="제목 정순 정렬"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('list_title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="제목 역순 정렬"/></a> 
								<a href="javascript:setSorder('list_title', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="제목 정순 정렬"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('list_title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="제목 역순 정렬"/></a> 
						<a href="javascript:setSorder('list_title', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="제목 정순 정렬"/></a> 
						<%} %></th>
						<th>글쓴이<% if ( order != null && order.equals("list_name")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('list_name', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="글쓴이 역순 정렬"/></a> 
								<a href="javascript:setSorder('list_name', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="글쓴이 정순 정렬"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('list_name', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="글쓴이 역순 정렬"/></a> 
								<a href="javascript:setSorder('list_name', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="글쓴이 정순 정렬"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('list_name', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="글쓴이 역순 정렬"/></a> 
						<a href="javascript:setSorder('list_name', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="글쓴이 정순 정렬"/></a> 
						<%} %></th>
						<th>순위<% if ( order != null && order.equals("event_gread")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('event_gread', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="순위 역순 정렬"/></a> 
								<a href="javascript:setSorder('event_gread', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="순위 정순 정렬"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('event_gread', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="순위 역순 정렬"/></a> 
								<a href="javascript:setSorder('event_gread', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="순위 정순 정렬"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('event_gread', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="순위 역순 정렬"/></a> 
						<a href="javascript:setSorder('event_gread', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="순위 정순 정렬"/></a> 
						<%} %></th>
						<th>공개</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				 <!-- list start-->
                                        <%if( v_bl != null && v_bl.size() > 0){%>
                                        <%
											
		
		
											try
											{
											 
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
												int event_gread = 0;
												String list_open = "";
												String user_tel ="";
												String user_email ="";
												BoardListInfoBean binfo = new BoardListInfoBean();
												for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<v_bl.size()); i++, list++) {
													  com.yundara.beans.BeanUtils.fill(binfo, (Hashtable)v_bl.elementAt(list));
													  list_id = binfo.getList_id() ;
													  list_name =binfo.getList_name() ;
													  list_title = binfo.getList_title() ;					  
													  re_level = binfo.getList_re_level() ;
													  list_count = binfo.getList_read_count() ;
													  list_open = binfo.getList_open();
													  event_gread=binfo.getEvent_gread();
													  list_date = binfo.getList_date() ;
													  user_tel = binfo.getUser_tel() ;
													  user_email = binfo.getUser_email() ;
													  if(list_date != null && list_date.length()>10){
															list_date = list_date.substring(0,10);
														}
													  img_url = binfo.getList_image_file() ; 
													  ip = binfo.getIp();
													 
													  img_url = java.net.URLEncoder.encode(img_url, "EUC-KR");
													  img_url = img_url.replace("+","%20");
													 
													if(flag.equals("V")){
														img_url = SilverLightServer + "/" + img_url;
													}else{
														img_url = "/upload/board_list/img/" +img_url;
														DirectoryNameManager Dmanager = new DirectoryNameManager();
														File file = new File(Dmanager.VODROOT + img_url);
														if(file.isDirectory() ||  !file.exists()) {
															img_url = "/include/cms/images/no_img02.gif";
														}
													}

																			%>
					<tr <% if (flag.equals("P") || flag.equals("V")){%>class="font_127"<%}else{%> class="height_25 font_127 bor_bottom01"<%}%> onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01">
						<% if (flag.equals("P") || flag.equals("V")){%><img src="<%=img_url%>" border="0"  class="img_style02"><%} %>
						<%
							if(re_level > 0) {
								for(int j=1; j < re_level; j++) {
						%>
								&nbsp;&nbsp;
						<%		} %>
								<img src="/vodman/include/images/reply.gif" alt="답글 화살표" />
						<%	} %>
						<a href="javascript:photo_view('<%=board_id%>','<%=list_id %>');" title="Q&amp;A"><%= (list_title.length() > 30) ? list_title.substring(0,30)+"..": list_title%></a></td>

						<td class="bor_bottom01"><%=list_name%>
						<br/>[<%=SEEDUtil.getDecrypt(user_tel) %>]
						<br/>[<%=SEEDUtil.getDecrypt(user_email) %>]
						</td>
						<td class="bor_bottom01"> 
						<select name="event_gread" class="sec01" style="width:40px;" onChange="return change_event_gread(this, '<%=list_id%>')">
						<% for ( int gread = 0; gread < 100 ; gread++) { %> 
						<option value='<%=gread%>' <%=(event_gread == gread) ? "selected" : ""%>><%=gread %></option>
						<%} %>
						</select>
						</td>
						<td class="bor_bottom01"> 
						<select name="list_open" class="sec01" style="width:60px;" onChange="return change_open_flag(this, '<%=list_id%>')">
						<option value='Y' <%=(list_open.equals("Y")) ? "selected" : ""%>>공개</option>
						<option value='N' <%=(list_open.equals("N")) ? "selected" : ""%>>비공개</option>
						</select>
						</td>
						<td class="bor_bottom01"><a href="javascript:photo_delete('<%=list_id%>');" title="삭제" ><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
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
	 				  <%
						String jspName = "photo_list.jsp";
					 	strLink += "&mcode=" + mcode;
						if(v_bl != null && v_bl.size() > 0 && pageBean!= null){ 
					  %>
					  <%@ include file="page_link.jsp" %>
					  <%	}	%>
					  
				<br/><br/>
				<br/><br/>
			</div>
		</div>	
	 </form>
	<IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0"></IFRAME>

			<%@ include file="/vodman/include/footer.jsp"%>