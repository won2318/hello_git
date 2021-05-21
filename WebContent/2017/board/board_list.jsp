  <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*"%>


<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
	
	
 
 <%@ include file = "/include/chkLogin.jsp"%>
 
 <%
 request.setCharacterEncoding("EUC-KR");
String ccode ="";
if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
}

int board_id = 10;  // 공지사항 게시판

if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
{
	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
	 
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");

	out.println("history.go(-1)");
	out.println("</SCRIPT>");
}



MediaManager mgr = MediaManager.getInstance();
 	
 	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<script type='text/javascript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}

	String board_title = "";
	String board_page_line = "10";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_security_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	String view_comment ="";
	String flag = "";
	String board_hidden_flag = "";
	int board_auth_list = 0;
	int board_auth_read = 0;
	int board_auth_write = 1;
 
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
		view_comment = String.valueOf(v_bi.elementAt(13));
		board_security_flag = String.valueOf(v_bi.elementAt(15));
		board_hidden_flag= String.valueOf(v_bi.elementAt(16));
		board_auth_list = Integer.parseInt(String.valueOf(v_bi.elementAt(9)));
		board_auth_read = Integer.parseInt(String.valueOf(v_bi.elementAt(10)));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));
		 
	}
 
	String searchField = TextUtil.nvl(request.getParameter("searchField"));
	if(searchField.equals("")){
		searchField = "1";
	}
	String searchstring = "";
	if (request.getParameter("searchstring") != null && request.getParameter("searchstring").length() > 0) {
		searchstring = TextUtil.nvl(request.getParameter("searchstring"));
	}
	 
	
	int pageSize = Integer.parseInt(board_page_line);
	int totalArticle =0; //총 레코드 갯수
	int totalPage =0;
	int pg = NumberUtils.toInt(request.getParameter("page"), 1);
 
	Hashtable result_ht = null;
	Vector vt_list = null;
	com.yundara.util.PageBean pageBean = null;
	try{
		result_ht = blsBean.getBoardList(board_id, searchField, searchstring,  pg, pageSize);
 
		if(!result_ht.isEmpty() ) {
			vt_list = (Vector)result_ht.get("LIST");
 
			if ( vt_list != null && vt_list.size() > 0){
		        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		        if(pageBean != null){
		        	pageBean.setPage(pg);
		        	pageBean.setLinePerPage(5);
					pageBean.setPagePerBlock(4);	
					totalArticle = pageBean.getTotalRecord();
		        	totalPage = pageBean.getTotalPage();
		        }
			}
	    }
	}catch(NullPointerException e){
		out.println("<script type='text/javascript'>");
		out.println("alert('처리 중 오류가 발생했습니다. 잠시후에 다시 시도하여 주세요.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	
	//리스트의 공지 불러오기

	Vector v_bt = null;
	try{
		v_bt = blsBean.getAllBoardList(board_id, "", "", "Y");
	}catch(NullPointerException e){
		out.println("<script type='text/javascript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	
	if (board_auth_list ==9) {
		// 관리자  
		if (vod_level != "9") {
			vt_list = null;
		 	out.println("<script language='javascript'>\n" +
		              "alert('등록 권한이 없습니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		}
	} else if (board_auth_list == 1) {
		// 실명인증 사용자
		if(!chk_login(vod_id, vod_level )) {
			
			vt_list = null;
		   	out.println("<script language='javascript'>\n" +
		              "alert('실명인증 후 이용 가능합니다. 이전페이지로 이동합니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		return;
		}
	} else if (vod_level != null && Integer.parseInt(vod_level) < board_auth_list) {
		 
// 		   	out.println("<script language='javascript'>\n" +
// 		              "alert('접근 권한이 없습니다. 이전페이지로 이동합니다.');\n" +
// 		              "history.go(-1);\n" +
// 		              "</script>");
		vt_list = null;
		 
	}else {
		// 비회원 등록
		
	}
	
%>


     <%@ include file = "../include/html_head.jsp"%>  


<script type="text/javascript">
<!--
function goPage(page){
	var f = document.frm1;
	f.page.value = page;
	f.action = "board_list.jsp";
	f.submit();
}

function search_I(){
	var f = document.frm1;
	f.page.value = 1;
	f.action = "board_list.jsp";
	f.submit();
}

function name_check(){
//	var url = "/include/name_gpin.jsp?board_id=<%=board_id%>&type=write";    
	var url = "https://tv.suwon.go.kr/include/name_gpin.jsp?board_id=<%=board_id%>&type=2017_write";    
	
	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
	 
}

function pwd_check(listId, boardId){ 
	var url = "./pwd_check.jsp?board_id="+boardId+"&list_id="+listId+"&type=view";   
 	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
}

function login(type){
    
	var url = "/2017/include/login.jsp?board_id=<%=board_id%>&type="+type;
	
	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
	 
}

// -->
</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 


</noscript>

		
		<section id="body">
			<div id="container_out">
			<div id="container_inner">
			<%
 		try{
			
  		if (flag != null && flag.equals("N")) { %>	
				
					<div class="btn_write_ab2 i_write">
					<%if(board_user_flag != null && board_user_flag.equals("t")){  } else{ %>
						<% if (board_auth_write == 0) { %>
							<a href="board_write.jsp?board_id=<%=board_id%>">등록</a> 
						<%} else {
						  if (vod_name != null && vod_name.length() > 0) { %>
							<a href="board_write.jsp?board_id=<%=board_id%>">등록</a> 
						<%} else { %>
							<% if (board_auth_write > 1) { %>
								<a href="javascript:login('write');">등록</a> 
							<%} else { %>
								<a href="javascript:name_check();">등록</a> 
							<%} %>
						<%} %>
						<%} %>
						
					<%} %>
					
					</div>
					
					<div class="pageSort"><span>총<strong> <%=totalArticle%> </strong>건&nbsp;&nbsp;&nbsp;&nbsp;페이지 <strong><%=pg%>/<%=totalPage%></strong></span></div>
					<div class="board_search">
					<form name="frm1" action="board_list.jsp" method="post">
					<input type="hidden" name="page" value="<%=pg%>" />
					<input type="hidden" name="board_id" value="<%=board_id%>" />
						<fieldset>
							<legend>게시판검색</legend>
						<select name="searchField">
							<option value="1" <%if (searchField != null && searchField.equals("1")){out.println("selected"); }%>>제목</option>
							<option value="2" <%if (searchField != null && searchField.equals("2")){out.println("selected"); }%>>내용</option>
							<option value="3" <%if (searchField != null && searchField.equals("3")){out.println("selected"); }%>>제목+내용</option>
						</select>
							<input type="text" title="검색어" name="searchstring" value="" class="input_text"/> 
							<input type="image" src="../include/images/icon_search.png" alt="검색" onclick="search_I();"/>
							</fieldset>
						</form>
						
					</div>
					
					<table class="boardList" cellspacing="0" summary="게시판 목록으로 번호, 제목,작성자, 등록일, 첨부파일 제공">
						<caption>게시판 목록</caption>
						<colgroup>
							<col width="10%"/>
							<col width="*"/>
							<col width="16%"/>
							<col width="5%"/>
							<col width="14%"/>
						</colgroup>
						<thead>
						<tr>
							<th scope="col" abbr="번호">번호</th>
							<th scope="col" abbr="제목">제목</th>
							<th scope="col" abbr="작성자">작성자</th>
							<th scope="col" abbr="첨부">첨부</th>
							<th scope="col" abbr="등록일">등록일</th>
						</tr>
						</thead>
						<tbody>
<%			if(v_bt != null && v_bt.size()>0)
				{  //공지 읽어 오기
					String list_id ="";
					String list_title ="";
					String list_name ="";
					String ip="";
					String list_date ="";
					String list_count ="";
					String img_url = "";
					String list_data_file = "";
					String list_open = "";
					int re_level = 0;
					for(int i = 0; i < v_bt.size(); i++) {
						list_id = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(0));
						list_name = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(3));
		 				
						list_title = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(4));
						list_data_file = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(7));
						re_level = Integer.parseInt(String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(11)));
						list_count = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(12));
						list_date = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(16));
						if(list_date != null && list_date.length()>10){
							list_date = list_date.substring(0,10);
						}
%>					 
					<tr> 
							<td><span class="notice">공지</span></td> 
							<td class="td_left"><a href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%=list_title%></a></td> 
							<td><%String temp_writer = list_name;
						out.println(temp_writer);
						%></td> 
							<td><span class="img"><% if (list_data_file != null && list_data_file.contains(".") ) { %><img src="../include/images/icon_file.gif" alt="첨부파일"/><%} %></span></td> 
							<td><%=list_date%></td> 
					</tr>
						
 <%
					}
				}
							
							
				if(vt_list != null && vt_list.size() >0){  //게시물 읽어 오기
					int list = 0;
					for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<vt_list.size()); i++, list++)
					{
 
								Hashtable ht_list = (Hashtable)vt_list.get(list);
							    String list_id = TextUtil.nvl(String.valueOf(ht_list.get("list_id")));
								String list_title = TextUtil.nvl(String.valueOf(ht_list.get("list_title")));
								String list_contents = TextUtil.nvl(String.valueOf(ht_list.get("list_contents")));
								String list_image_file = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file")));
								String thumb = "/upload/board_list/img_middle/" + list_image_file;
								String list_read_count = TextUtil.nvl(String.valueOf(ht_list.get("list_read_count")));
								String list_date = TextUtil.nvl(String.valueOf(ht_list.get("list_date")));
								if(list_date != null && list_date.length()>10){
									list_date = list_date.substring(0,10);
								}
								String list_name = TextUtil.nvl(String.valueOf(ht_list.get("list_name")));
								String list_data_file = TextUtil.nvl(String.valueOf(ht_list.get("list_data_file")));
								String list_security = TextUtil.nvl(String.valueOf(ht_list.get("list_security")));
								String memo_cnt =  TextUtil.nvl(String.valueOf(ht_list.get("memo_cnt")));
								int re_level = 0;
								if (ht_list.get("list_re_level") != null ) {
									re_level = Integer.parseInt(String.valueOf(ht_list.get("list_re_level")));
								}
								String list_pwd = TextUtil.nvl(String.valueOf(ht_list.get("list_passwd")));								
								String image_text8 = TextUtil.nvl(String.valueOf(ht_list.get("image_text8")));
								String list_link =  TextUtil.nvl(String.valueOf(ht_list.get("list_link"))); 
					%>		
				 
									
					<tr>
						<td><%=pageBean.getTotalRecord()-i %></td>
						<td class="td_left">
						<%
						if(board_hidden_flag != null && board_hidden_flag.equals("t")){  // 비밀글(숨김) 게시판
							if ( board_auth_write == 0){

								%>
								<a href="javascript:pwd_check(<%=list_id%>,<%=board_id%>);"><%
									if(re_level > 0) {
										for(int j=1; j < re_level; j++) {
								%>
										&nbsp;&nbsp;
								<%		} %>
										<img src="../include/images/icon_reply.gif" alt="답글"/>
								<%	} %><%=list_title%> <span class="secret"><img src="../include/images/icon_secret.png" alt="비밀"/></span></a>
								<%
								
								
							} else if(  vod_id != null && vod_name != null && user_key != null && user_key.equals(list_pwd) )
							{
							%>
							<a  href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif"  alt="답글"/>
							<%	} %>
							<%=list_title%></a>
						<%
							}else{
							%>
							<a href="javascript:alert('비공개 글입니다.');"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif" alt="답글"/>
							<%	} %><%=list_title%> <span class="secret"><img src="../include/images/icon_secret.png" alt="비밀"/></span></a>
							<%
							}
						}else if(board_security_flag != null && board_security_flag.equals("t")){ //비밀글 사용 하는 게시판
							if ( board_auth_write == 0){
 
								if (list_name != null && list_name.trim().equals("수원iTV")) {  // 관리자 허용
								%>
									<a  href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%
											if(re_level > 0) {
												for(int j=1; j < re_level; j++) {
										%>
												&nbsp;&nbsp;
										<%		} %>
												<img src="../include/images/icon_reply.gif"  alt="답글"/>
										<%	} %>
										<%=list_title%></a>
								<%
								} else if(list_security != null && list_security.equals("Y")) {  // 비밀글 체크한 게시물 
								%>
								<a href="javascript:pwd_check(<%=list_id%>,<%=board_id%>);"><%
									if(re_level > 0) {
										for(int j=1; j < re_level; j++) {
								%>
										&nbsp;&nbsp;
								<%		} %>
										<img src="../include/images/icon_reply.gif" alt="답글"/>
								<%	} %><%=list_title%> <span class="secret"><img src="../include/images/icon_secret.png" alt="비밀"/></span></a>
								<%
								} else {  // 비밀글 아님
									%>
									<a  href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%
											if(re_level > 0) {
												for(int j=1; j < re_level; j++) {
										%>
												&nbsp;&nbsp;
										<%		} %>
												<img src="../include/images/icon_reply.gif"  alt="답글"/>
										<%	} %>
										<%=list_title%></a>
								<%
								}
								
							} else if( list_security == null 
								||  (list_security != null && list_security.equals("") ) 
								||  (list_security != null && list_security.equals("null") ) 
								||  (list_security != null && list_security.equals("N") )
								||  (vod_id != null && vod_name != null && user_key != null && user_key.equals(list_pwd) ) 
								)
							{
							%>
							<a href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif"  alt="답글"/>
							<%	} %>
							<%=list_title%></a>
						<%
							}else{
							%>
							<a href="javascript:alert('비공개 글입니다.');"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif" alt="답글"/>
							<%	} %><%=list_title%> <span class="secret"><img src="../include/images/icon_secret.png" alt="비밀"/></span></a>
							<%
							}
						}else{
						%>
						<%if (board_id == 22 && image_text8 != null && image_text8.equals("V") ) {out.println("<font color='#00a1e0'>영상(수원iTV)</font><br/> ");} 
						else if (board_id == 22 && image_text8 != null && image_text8.equals("N")) {out.println("<font color='#388cff;'>기사(e수원뉴스)</font><br/> ");} %>
						
						<% if (board_id == 24 || board_id == 25)  { %>
						<a href="<%=list_link %>" target="_blank"> 
						<% }else { %>
						<a href="board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%
						}
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif" alt="답글"/>
							<%	} %><%=list_title%></a>
						<%
						}
						%>
						 <%if(view_comment != null && view_comment.equals("t")){
							if(memo_cnt != null && !memo_cnt.equals("0")){
						 %>
						 <span class="reply_number">(<%=memo_cnt %>)</span>
						 <%	} 
						}
						%></td>
						<td><%
						 String temp_writer = list_name;
 						out.println(temp_writer);
						%></td>
						<td><% if (list_data_file != null && list_data_file.contains(".") ) { %><img src="../include/images/icon_file.gif" alt="첨부파일"/><%} %></td>
						<td><%=list_date %></td>
					</tr>
 <%
					}
					%>
					<%}else{%>
					<tr> 
						<td colspan="5">등록된 정보가 없습니다.</td> 

					</tr>
			<%}%>					 
							
						</tbody>	
					</table>
					
					<%@ include file="page_link.jsp" %>
					
				 
			
<%	
		} else{   // 포토 형식 게시판

%>
			 
					<div class="vodList">
	<% 				
					if(vt_list != null && vt_list.size() >0){
							int list = 0;
							for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<vt_list.size()); i++, list++)
							{
	 
									Hashtable ht_list = (Hashtable)vt_list.get(list);
									String list_id = TextUtil.nvl(String.valueOf(ht_list.get("list_id")));
									String list_title = TextUtil.nvl(String.valueOf(ht_list.get("list_title")));
									String strTitle = com.vodcaster.utils.TextUtil.text_replace(list_title,false); 
									strTitle = strTitle.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r","");
									String list_contents = TextUtil.nvl(String.valueOf(ht_list.get("list_contents")));
									String list_image_file = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file")));
									String thumb = DirectoryNameManager.UPLOAD+"/board_list/img_middle/" + list_image_file;
									String list_read_count = TextUtil.nvl(String.valueOf(ht_list.get("list_read_count")));
									String list_date = TextUtil.nvl(String.valueOf(ht_list.get("list_date")));
									if(list_date != null && list_date.length()>10){
										list_date = list_date.substring(0,10);
									}
									String list_name = TextUtil.nvl(String.valueOf(ht_list.get("list_name")));
									String list_data_file = TextUtil.nvl(String.valueOf(ht_list.get("list_data_file")));
									String list_security = TextUtil.nvl(String.valueOf(ht_list.get("list_security")));
									String memo_cnt =  TextUtil.nvl(String.valueOf(ht_list.get("memo_cnt")));
						%>					
	  
					   <div class="pin">
						<%if ( i < 2) { %>
							<span class="new">NEW</span>
						<%} %>
					 
							<span class="img"><a href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><img src="img_2.jsp?list_id=<%=list_id%>" alt='<%=strTitle %>'/></a></span>
							<span class="total"> 
								<span class="title"><a  href="board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%=list_title%></a></span>
	<%-- 							<span class="subject"><%=list_title %></span> --%>
							</span>
							<span class="info">
								<span class="time"><%=list_date %></span>
	<%-- 							<span class="view"><%=list_read_count%></span> --%>
								<span class="reply"><%=memo_cnt %></span>
							</span>
						</div>
						
	 <%
							}
						}else{
	 %>
						 <div>
						 <span>등록된 정보가 없습니다.</span>

						 </div>	
	<%					} 
	%> 
					</div>	
			 		<%@ include file="page_link.jsp" %>
			 		<form name="frm1" action="board_list.jsp" method="post">
					<input type="hidden" name="page" value="<%=pg%>" />
					<input type="hidden" name="board_id" value="<%=board_id%>" />
					</form>
	 <% 
				}


		 }catch(Exception e){
		  System.err.println(e);
		  //out.println(e);
		 
		 } 
						 %>	
				</div>
				<!--//container_inner-->
				
				<aside class="container_right">
					<div class="NewTab list5 list3">
						<ul >
						<%@ include file = "../include/right_new_video.jsp"%>   
							
						</ul>
					</div><!--//NewTab list3-->
						<%@ include file = "../include/right_best_video.jsp"%>   

				</aside><!--//container_right-->
			</div><!--//container_out-->
		</section><!--콘텐츠부분:section-->    
		
<%@ include file = "../include/html_foot.jsp"%>    