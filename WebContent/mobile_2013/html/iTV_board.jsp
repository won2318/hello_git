 <%@ page language="java" contentType="text/html; charset=EUC-KR"    pageEncoding="EUC-KR"%><%@ page import="java.util.*"%><%@ page import="java.text.*" %><%@ page import="org.apache.commons.lang.StringUtils" %><%@ page import="com.hrlee.sqlbean.*"%><%@ page import="com.vodcaster.sqlbean.*"%><%@ page import="com.yundara.util.*"%> <%@ page import="org.apache.commons.lang.math.NumberUtils" %> <jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> <jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" /><jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>  <%@ include file = "../include/head.jsp"%><%@ include file="/include/chkLogin.jsp"%><% request.setCharacterEncoding("EUC-KR"); int board_id = 16;  // 제작현장if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id"))){	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));	 } else {	out.println("<script type='text/javascript'>");	out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");	//out.println("history.go(-1)");	out.println("</SCRIPT>");}%><%  	Vector v_bi = null;	try{		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);	}catch(NullPointerException e){		out.println("<script type='text/javascript'>");		out.println("alert('처리 중 오류가 발생하였습니다.')");		out.println("history.go(-1)");		out.println("</SCRIPT>");	}	String board_title = "";	String board_page_line = "12";	String board_image_flag = "";	String board_file_flag = "";	String board_link_flag = "";	String board_security_flag = "";	String board_user_flag = "";	String board_top_comments = "";	String board_footer_comments = "";	String board_priority = "";	String view_comment ="";	String flag = "";	int board_auth_read = 0;	int board_auth_write = 1;		if(v_bi != null && v_bi.size() >0){		board_title = String.valueOf(v_bi.elementAt(0));		board_page_line = String.valueOf(v_bi.elementAt(1));		board_image_flag = String.valueOf(v_bi.elementAt(2));		board_file_flag = String.valueOf(v_bi.elementAt(3));		board_link_flag = String.valueOf(v_bi.elementAt(4));		board_user_flag = String.valueOf(v_bi.elementAt(5));		board_top_comments = String.valueOf(v_bi.elementAt(6));		board_footer_comments = String.valueOf(v_bi.elementAt(7));		board_priority = String.valueOf(v_bi.elementAt(8));		flag = String.valueOf(v_bi.elementAt(12));		view_comment = String.valueOf(v_bi.elementAt(13));		board_security_flag = String.valueOf(v_bi.elementAt(15));		board_auth_read = Integer.parseInt(String.valueOf(v_bi.elementAt(10)));		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));		 	}	 	String searchField = TextUtil.nvl(request.getParameter("searchField"));	if(searchField.equals("")){		searchField = "1";	}	String searchString = TextUtil.nvl(request.getParameter("searchString"));		int pageSize = Integer.parseInt(board_page_line);	int totalArticle =0; //총 레코드 갯수	int totalPage =0;	int pg = NumberUtils.toInt(request.getParameter("page"), 1);		Hashtable result_ht = null;	Vector vt_list = null;	com.yundara.util.PageBean pageBean = null;	try{		result_ht = blsBean.getBoardList(board_id, searchField, searchString,  pg, pageSize); 		if(!result_ht.isEmpty() ) {			vt_list = (Vector)result_ht.get("LIST"); 			if ( vt_list != null && vt_list.size() > 0){		        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");		        if(pageBean != null){		        	pageBean.setPage(pg);		        	pageBean.setLinePerPage(5);					pageBean.setPagePerBlock(4);						totalArticle = pageBean.getTotalRecord();		        	totalPage = pageBean.getTotalPage();		        }			}	    }	}catch(NullPointerException e){		out.println("<script type='text/javascript'>");		out.println("alert('처리 중 오류가 발생했습니다. 잠시후에 다시 시도하여 주세요.')");		out.println("history.go(-1)");		out.println("</SCRIPT>");	}	 %>  <script type="text/javascript">function login(type){	location.href="login.jsp?board_id=<%=board_id%>&type="+type;}  jQuery(document).ready(function( $ ) {  lastPostFunc();});        var page_cnt = 0;        function lastPostFunc() {        	         	if (page_cnt < <%=totalPage%>) {        		page_cnt++;        		//alert(page_cnt);                 //데이타(data) 가져 오는 부분                 $.post("board_scroll_data.jsp?board_id=<%=board_id%>&page=" + page_cnt,                 //post에서 전송 받은 데이터(data)                 function (data) {                                     if (data != "") {                     	 //alert(data);                    	 <%if (flag != null && flag.equals("N")) { %>                    	 $("#wrdLatest:last").append(data);                    	<% } else { %>	                     	 var $moreBlocks = $( data );						    // Append new blocks						    $container_list.append( $moreBlocks ); 						    // Have Masonry position new blocks						    $container_list.masonry( 'appended', $moreBlocks );                    	<% } %>                      }                                           $("div#lastPostsLoader").empty();                 });        	}                   };        //스크롤 감지하는 부분//         $(window).scroll(function () {        	 //             if ($(window).scrollTop() == $(document).height() - $(window).height()) {//                 lastPostFunc();//             }//         });                      </script>   
 
	
	<div class="snb">
		<strong><%= board_title%></strong>
		<span><button onclick="showHide('menuFull');return false;" class="menu_view">영상더보기</button></span>
		<div id="menuFull" style="display:none;">
		<ul class="menuView">
			<%@ include file = "../include/iTV_menu.jsp"%>
		</ul>
		<button onclick="showHide('menuFull');return false;" class="menu_close">메뉴닫기</button>
	</div>
</div>
</div>
<div id="container"> 
	<div class="major">
	<section>
		<!-- vodList -->
				<%if (flag != null && flag.equals("N")) { %>		<div class="newsList">			<ul id="wrdLatest"><!-- element 1 --> 			</ul>		</div>		<%} else { %>		<div class="vodList"  id="vodList" >			<!-- pin element 1 --> 		</div>		<%} %> 
				 <div id="lastPostsLoader"></div> 		 <div class="btn5">		 	<%if (vod_name != null && vod_name.length() > 0) {%>			<a href="board_write.jsp?board_id=<%=board_id%>">글쓰기</a>			<%} else { %>			<a href="javascript:login('write')">글쓰기</a>			<%} %>		</div>
	</section>
	</div>	<div class='btn4'><a href="javascript:lastPostFunc();">more</a></div>  
</div>
<%if (vod_name != null && vod_name.length() > 0) { } else{%><% if (board_auth_write > 1) { %><script type="text/javascript"><!--window.onload = function(){if (confirm("시민모니터단 로그인 하시겠습니까?") == true){    //확인    login('list');}else{   //취소    return;}}//--></script>	<%} %><%} %> <%@ include file = "../include/foot.jsp"%>
</body>
</html>