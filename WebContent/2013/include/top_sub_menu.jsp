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
			<span class="m1"><a href="/2013/video/video_list.jsp?ccode=001000000000" 
			<%if (ccode != null && ccode.contains("001000000000")) {out.println("class='visible'"); }%>>��ü</a>
				<span class="sub"><%=c_title.getCategoryMemo("001000000000", "V") %></span>
			</span>
 
			<span class="m2"><a href="/2013/video/video_list.jsp?ccode=001001000000" 
			<%if (ccode != null && ccode.contains("001001000000")) {out.println("class='visible'"); }%>>NEWS</a>
				<span class="sub"><%=c_title.getCategoryMemo("001001000000", "V") %></span>
			</span>
 
 
  
			<span class="m4"><a href="/2013/video/video_list.jsp?ccode=001003000000" 
			<%if (ccode != null && ccode.contains("001003000000")) {out.println("class='visible'"); }%>>����Best5</a>
				<span class="sub"><%=c_title.getCategoryMemo("001003000000", "V") %></span>
			</span>
  

 
			<span class="m5"><a href="/2013/video/video_list.jsp?ccode=001005000000" 
			<%if (ccode != null && ccode.contains("001005000000")) {out.println("class='visible'"); }%>>��мӼ���</a>
				<span class="sub"><%=c_title.getCategoryMemo("001005000000", "V") %></span>
			</span>
			
 
			<span class="m7"><a href="/2013/video/video_list.jsp?ccode=001008000000" 
			<%if (ccode != null && ccode.contains("001008000000")) {out.println("class='visible'"); }%>>���ܿ���</a>
				<span class="sub"><%=c_title.getCategoryMemo("001008000000", "V") %></span>
			</span>
	 
		<%} else if (ccode != null && ccode.startsWith("002")) { %>
			<span class="m1"><a href="/2013/video/video_list.jsp?ccode=002000000000" 
			<%if (ccode != null && ccode.contains("002000000000")) {out.println("class='visible'"); }%>>��ü</a>
				<span class="sub"><%=c_title.getCategoryMemo("002000000000", "V") %></span>
			</span>
 

			<span class="m2"><a href="/2013/video/video_list.jsp?ccode=002001000000" 
			<%if (ccode != null && ccode.contains("002006000000")) {out.println("class='visible'"); }%>>��ȹ���α׷�</a>
				<span class="sub"><%=c_title.getCategoryMemo("002006000000", "V") %></span>
			</span>
 
			<span class="m3"><a href="/2013/video/video_list.jsp?ccode=002002000000" 
			<%if (ccode != null && ccode.contains("002002000000")) {out.println("class='visible'"); }%>>�ݰ�����</a>
				<span class="sub"><%=c_title.getCategoryMemo("002002000000", "V") %></span>
			</span>
 
			<span class="m4"><a href="/2013/video/video_list.jsp?ccode=002003000000" 
			<%if (ccode != null && ccode.contains("002003000000")) {out.println("class='visible'"); }%>>Ÿ�Ӹӽ�</a>
				<span class="sub"><%=c_title.getCategoryMemo("002003000000", "V") %></span>
			</span>
 
			<span class="m5"><a href="/2013/video/video_list.jsp?ccode=002005000000" 
			<%if (ccode != null && ccode.contains("002005000000")) {out.println("class='visible'"); }%>>������</a>
				<span class="sub"><%=c_title.getCategoryMemo("002005000000", "V") %></span>
			</span>
		 
		<%}  else if (ccode != null && ccode.startsWith("003")) { %>
			<span class="m1"><a href="/2013/video/video_list.jsp?ccode=003000000000" 
			<%if (ccode != null && ccode.contains("003000000000")) {out.println("class='visible'");}%>>��ü</a>
				<span class="sub"><%=c_title.getCategoryMemo("003000000000", "V") %></span>
			</span>
 
			<span class="m2"><a href="/2013/video/video_list.jsp?ccode=003001000000" 
			<%if (ccode != null && ccode.contains("003001000000")) {out.println("class='visible'"); }%>>����&#183;����</a>
				<span class="sub"><%=c_title.getCategoryMemo("003001000000", "V") %></span>
			</span>
  
			<span class="m3"><a href="/2013/video/video_list.jsp?ccode=003002000000" 
			<%if (ccode != null && ccode.contains("003002000000")) {out.println("class='visible'"); }%>>��Ȱ&#183;����</a>
				<span class="sub"><%=c_title.getCategoryMemo("003002000000", "V") %></span>
			</span>
	 
			<span class="m4"><a href="/2013/video/video_list.jsp?ccode=003003000000" 
			<%if (ccode != null && ccode.contains("003003000000")) {out.println("class='visible'"); }%>>����&#183;�ǰ�</a>
				<span class="sub"><%=c_title.getCategoryMemo("003003000000", "V") %></span>
			</span>
	 
			<span class="m5"><a href="/2013/video/video_list.jsp?ccode=003004000000" 
			<%if (ccode != null && ccode.contains("003004000000")) {out.println("class='visible'"); }%>>����&#183;��ȭ</a>
				<span class="sub"><%=c_title.getCategoryMemo("003004000000", "V") %></span>
			</span>
		
			<span class="m6"><a href="/2013/video/video_list.jsp?ccode=003005000000" 
			<%if (ccode != null && ccode.contains("003005000000")) {out.println("class='visible'"); }%>>��ﰭ��</a>
				<span class="sub"><%=c_title.getCategoryMemo("003005000000", "V") %></span>
			</span>
	 
		<%}else if ((ccode != null &&  ccode.startsWith("004")) || board_id==10 || board_id==16 || board_id==12 ||
			board_id==17 || board_id==11 || board_id==13 || board_id==18 || board_id==19 || board_id==21 || board_id==22) { %>
		<%--
			<span class="m1"><a href="/2013/video/video_list.jsp?ccode=004000000000" 
			<%if (ccode != null && ccode.contains("004000000000") ) {out.println("class='visible'"); }%>>��ü</a>
			<span class="sub"><%=c_title.getCategoryMemo("004000000000", "V") %></span>
			</span>
 	--%>
			<span class="m2"><a href="/2013/video/video_list.jsp?ccode=004001000000" 
			<%if (ccode != null && ccode.contains("004001000000") || board_id==11 || board_id==13) {out.println("class='visible'"); }%>>����PD</a>
				<span class="sub"><%=c_title.getCategoryMemo("004001000000", "V") %></span>
			</span>
 
			<span class="m3"><a href="/2013/board/board_list.jsp?board_id=16" 
			<%if ( board_id==16) {out.println("class='visible'"); }%>>��������</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(16)%></span>
			</span>
 
 
			<span class="m5"><a href="/2013/board/board_list.jsp?board_id=10" 
			<%if ( board_id==10) {out.println("class='visible'"); }%>>��������</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(10) %></span>
			</span>
			<span class="m6"><a href="/2013/board/board_list.jsp?board_id=23" 
			<%if ( board_id==10) {out.println("class='visible'"); }%>>�̺�Ʈ ����</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(23) %></span>
			</span>
		
			<span class="m7"><a href="/2013/board/board_list.jsp?board_id=17" 
			<%if (board_id == 17) {out.println("class='visible'"); }%>>�޸ս��丮</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(17) %></span>
			</span> 
		 
			
			<span class="m9"><a href="/2013/board/board_list.jsp?board_id=22" 
			<%if (board_id == 22) {out.println("class='visible'"); }%>>�ùθ���ʹ�</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(22) %></span>
			</span>
			<!--<span class="m8"><a href="/2013/board/board_list.jsp?board_id=18" 
			<%if (board_id == 18) {out.println("class='visible'"); }%>>���ƶ�~å���� UCC ����</a>
				<span class="sub"><%=BoardInfoSQLBean.getInstance().getBoardInfo_Memo(18) %></span>
			</span>
			
			 -->
			
		<%}else if (ccode != null && (ccode.startsWith("005") )) { %>
			
 	
			<span class="m2"><a href="/2013/video/video_list.jsp?ccode=005001000000" 
			<%if (ccode != null && (ccode.contains("005001000000") || ccode.contains("005000000000"))) {out.println("class='visible'"); }%>>ȫ������</a>
				<span class="sub"><%=c_title.getCategoryMemo("005001000000", "V") %></span>
			</span>
 
			<span class="m3"><a href="/2013/video/video_list.jsp?ccode=005002000000" 
			<%if (ccode != null && ccode.contains("005002000000")) {out.println("class='visible'"); }%>>��������ȸ</a>
				<span class="sub"><%=c_title.getCategoryMemo("005002000000", "V") %></span>
			</span>
	  
		<%} else if ((ccode != null && ccode.startsWith("006")) || (request.getRequestURI() != null &&  request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("live_list.jsp")> -1)  ) { %>
 			 
 			 <span class="m1"><a href="/2013/live/live_list.jsp" 
			<%if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("live_list.jsp")> -1 ) {out.println("class='visible'");  }%>>����۸��</a>
				<span class="sub"></span>
			</span> 
			<span class="m2"><a href="/2013/video/video_list.jsp?ccode=006001000000" 
			<%if (ccode != null && ccode.contains("006001000000")
			)
			{out.println("class='visible'"); }%>>�����</a>
				<span class="sub"><%=c_title.getCategoryMemo("006001000000", "V") %></span>
			</span> 
		 
		 <%}else if (ccode != null && (ccode.startsWith("009") )) { %>
			
 	
			<span class="m2"><a href="/2013/video/video_list.jsp?ccode=009001000000" 
			<%if (ccode != null && (ccode.contains("009001000000") || ccode.contains("009000000000"))) {out.println("class='visible'"); }%>>I��m in Suwon</a>
				<span class="sub"><%=c_title.getCategoryMemo("009001000000", "V") %></span>
			</span>
 
			<span class="m3"><a href="/2013/video/video_list.jsp?ccode=009002000000" 
			<%if (ccode != null && ccode.contains("009002000000")) {out.println("class='visible'"); }%>>Promotional Video</a>
				<span class="sub"><%=c_title.getCategoryMemo("009002000000", "V") %></span>
			</span>
		<%} else if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("search.jsp")> -1 ) { %>
			 
			<span class="m1"><a href="/2013/info/search.jsp" 
			<%if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("search.jsp")> -1 ) {out.println("class='visible'"); }%>>��ü���α׷�</a>
				<span class="sub"></span>
			</span> 
		<%}else { %>	
		 
		<%} %> 
		</div>
	</div>
	<div class="subTitle"><%=menu_title_top2 %></div>