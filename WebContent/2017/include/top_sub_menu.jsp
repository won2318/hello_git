<%@page import="com.vodcaster.sqlbean.BoardListInfoBean"%>
<%@page import="com.vodcaster.sqlbean.BoardListSQLBean"%>
<%@page import="com.vodcaster.sqlbean.BoardInfoInfoBean"%>
<%@page import="com.vodcaster.sqlbean.BoardInfoSQLBean"%>
<%@page import="com.hrlee.sqlbean.CategoryManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
 <%
  	String menu_title_top ="";
   String menu_title_top2="";
   
   CategoryManager c_title = CategoryManager.getInstance();
   menu_title_top2 = c_title.getCategoryMemo(ccode, "V");
   
    
   if (ccode == null || ccode.length() <= 0) {
  	 if (board_id != 0) {
  	 menu_title_top2 =BoardInfoSQLBean.getInstance().getBoardInfo_Memo(board_id);
  	 }
   }
  %>
<div class="topmenu">
		<div class="major">
		<% if (ccode != null && ccode.startsWith("001") && !ccode.startsWith("001004")) { %>
			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=001000000000" 
			<%if (ccode != null && ccode.contains("001000000000")) {out.println("class='visible'"); }%>>전체</a>
				<span class="sub"><%=c_title.getCategoryMemo("001000000000", "V") %></span>
			</span>
 
			<span class="m2"><a href="/2017/video/video_list.jsp?ccode=001001000000" 
			<%if (ccode != null && ccode.contains("001001000000")) {out.println("class='visible'"); }%>>수원 iTV 뉴스</a>
				<span class="sub"><%=c_title.getCategoryMemo("001001000000", "V") %></span>
			</span>  
			
			<span class="m3"><a href="/2017/video/video_list.jsp?ccode=001008000000" 
			<%if (ccode != null && ccode.contains("001008000000")) {out.println("class='visible'"); }%>>기획영상</a>
				<span class="sub"><%=c_title.getCategoryMemo("001008000000", "V") %></span>
			</span> 
			
			<span class="m4"><a href="/2017/video/video_list.jsp?ccode=001009000000" 
			<%if (ccode != null && ccode.contains("001009000000")) {out.println("class='visible'"); }%>>수원시 홍보영상</a>
				<span class="sub"><%=c_title.getCategoryMemo("001009000000", "V") %></span>
			</span> 
			
  
			<span class="m5"><a href="/2017/video/video_list.jsp?ccode=001003000000" 
			<%if (ccode != null && ccode.contains("001003000000")) {out.println("class='visible'"); }%>>종영프로그램</a>
				<span class="sub"><%=c_title.getCategoryMemo("001003000000", "V") %></span>
			</span> 
			
  		<%}else if ((ccode != null && ccode.startsWith("002")) || board_id==24) { %>

			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=002007000000" 
			<%if (ccode != null && ccode.contains("002007000000")) {out.println("class='visible'"); }%>>방송영상</a>
				<span class="sub"><%=c_title.getCategoryMemo("002007000000", "V") %></span>
			</span>
 
			<span class="m2"><a href="/2017/board/board_list.jsp?board_id=24" 
			<%if ( board_id==24) {out.println("class='visible'"); }%>>방송모음</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(24) %></span>
			</span>
  
		 
		<%}  else if (ccode != null && ccode.startsWith("003")) { %>
			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=003000000000" 
			<%if (ccode != null && ccode.contains("003000000000")) {out.println("class='visible'");}%>>전체</a>
				<span class="sub"><%=c_title.getCategoryMemo("003000000000", "V") %></span>
			</span>
 
			<span class="m2"><a href="/2017/video/video_list.jsp?ccode=003001000000" 
			<%if (ccode != null && ccode.contains("003001000000")) {out.println("class='visible'"); }%>>라이프</a>
				<span class="sub"><%=c_title.getCategoryMemo("003001000000", "V") %></span>
			</span>
  
			<span class="m3"><a href="/2017/video/video_list.jsp?ccode=003006000000" 
			<%if (ccode != null && ccode.contains("003006000000")) {out.println("class='visible'"); }%>>홍보영상</a>
				<span class="sub"><%=c_title.getCategoryMemo("003006000000", "V") %></span>
			</span>
	 
			<span class="m4"><a href="/2017/video/video_list.jsp?ccode=003007000000" 
			<%if (ccode != null && ccode.contains("003007000000")) {out.println("class='visible'"); }%>>타임머신</a>
				<span class="sub"><%=c_title.getCategoryMemo("003007000000", "V") %></span>
			</span>
	 
			 
	 
		<%}else if ((ccode != null &&  ccode.startsWith("004")) || board_id==10 || board_id==16 || board_id==12 ||
			board_id==17 || board_id==11 || board_id==13 || board_id==18 || board_id==19 || board_id==21 || board_id==22 || board_id==23) { %>
 
			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=004001000000" 
			<%if (ccode != null && ccode.contains("004001000000") || board_id==11 || board_id==13) {out.println("class='visible'"); }%>>나도PD</a>
				<span class="sub"><%=c_title.getCategoryMemo("004001000000", "V") %></span>
			</span>
 
			<span class="m2"><a href="/2017/board/board_list.jsp?board_id=10" 
			<%if ( board_id==10) {out.println("class='visible'"); }%>>공지사항</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(10) %></span>
			</span>
 
			<span class="m3"><a href="/2017/board/board_list.jsp?board_id=17" 
			<%if (board_id == 17) {out.println("class='visible'"); }%>>휴먼스토리</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(17) %></span>
			</span>  
			
<!-- 			<span class="m4"><a href="/2017/board/board_list.jsp?board_id=22"  -->
<%-- 			<%if (board_id == 22) {out.println("class='visible'"); }%>>시민모니터단</a> --%>
<%-- 				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(22) %></span> --%>
<!-- 			</span> -->
 
			
		<%}else if (ccode != null && (ccode.startsWith("005") )  || board_id==25) { %>
			 
 
			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=005002000000" 
			<%if (ccode != null && ccode.contains("005002000000")) {out.println("class='visible'"); }%>>수원시의회</a>
				<span class="sub"><%=c_title.getCategoryMemo("005002000000", "V") %></span>
			</span>
			<span class="m2"><a href="/2017/board/board_list.jsp?board_id=25" 
			<%if ( board_id==25) {out.println("class='visible'"); }%>>방송모음</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(25) %></span>
			</span>
	  
		<%} else if ((ccode != null && ccode.startsWith("006")) || (request.getRequestURI() != null &&  request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("live_list.jsp")> -1)  ) { %>
 			 
 		 
			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=006001000000" 
			<%if (ccode != null && ccode.contains("006001000000")
			)
			{out.println("class='visible'"); }%>>생방송 다시보기</a>
				<span class="sub"><%=c_title.getCategoryMemo("006001000000", "V") %></span>
			</span> 
		 
		 <%}else if (ccode != null && (ccode.startsWith("009") )) { %>
			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=009000000000" 
			<%if (ccode != null && ccode.contains("009000000000")) {out.println("class='visible'");}%>>전체</a>
				<span class="sub"><%=c_title.getCategoryMemo("009000000000", "V") %></span>
			</span>
			
			<span class="m1"><a href="/2017/video/video_list.jsp?ccode=009002000000" 
			<%if (ccode != null && ccode.contains("009002000000")) {out.println("class='visible'"); }%>>Promotional Video</a>
				<span class="sub"><%=c_title.getCategoryMemo("009002000000", "V") %></span>
			</span>
			
			<span class="m2"><a href="/2017/video/video_list.jsp?ccode=009001000000" 
			<%if (ccode != null && ccode.contains("009001000000") ) {out.println("class='visible'"); }%>>Global Suwon (End program)</a>
				<span class="sub"><%=c_title.getCategoryMemo("009001000000", "V") %></span>
			</span>
			
		<%} else if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("search.jsp")> -1 ) { %>
			 
			<span class="m1"><a href="/2017/info/search.jsp" 
			<%if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("search.jsp")> -1 ) {out.println("class='visible'"); }%>>전체프로그램</a>
				<span class="sub"></span>
			</span> 
		<%}else { %>	
		 
		<%} %> 
		</div>
	</div>
	<div class="subTitle"><%=menu_title_top2 %></div>