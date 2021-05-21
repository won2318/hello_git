 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
 <%@ page import="org.apache.commons.lang.math.NumberUtils" %>
 
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
  
<%@ include file = "../include/head.jsp"%>
<%
 request.setCharacterEncoding("EUC-KR");
 
int board_id = 16;  // 제작현장

if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
{
	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
	 
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");

	//out.println("history.go(-1)");
	out.println("</SCRIPT>");
}

%>
<%

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
	String board_page_line = "12";
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
		board_auth_read = Integer.parseInt(String.valueOf(v_bi.elementAt(10)));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));
		 
	}
	
 
	String searchField = TextUtil.nvl(request.getParameter("searchField"));
	if(searchField.equals("")){
		searchField = "1";
	}
	String searchString = TextUtil.nvl(request.getParameter("searchString"));
	
	int pageSize = Integer.parseInt(board_page_line);
	int totalArticle =0; //총 레코드 갯수
	int totalPage =0;
	int pg = NumberUtils.toInt(request.getParameter("page"), 1);
	
	Hashtable result_ht = null;
	Vector vt_list = null;
	com.yundara.util.PageBean pageBean = null;
	try{
		result_ht = blsBean.getBoardList(board_id, searchField, searchString,  pg, pageSize);
 
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
	
	
%>
  <script type="text/javascript">
function login(type){
	location.href="login.jsp?board_id=<%=board_id%>&type="+type;
}
  
 
jQuery(document).ready(function( $ ) {  
  lastPostFunc();
});  
  
    var page_cnt = 0;
        function lastPostFunc() {
        	 
        	if (page_cnt < <%=totalPage%>) {
        		page_cnt++;
        		//alert(page_cnt);
                 //데이타(data) 가져 오는 부분
                 $.post("board_scroll_data.jsp?board_id=<%=board_id%>&page=" + page_cnt,

                 //post에서 전송 받은 데이터(data)
                 function (data) {
               
                     if (data != "") {  
                    	 $("#vodList:last").append(data);
                     } 
                     
                     $("div#lastPostsLoader").empty();
                 });
        	}
           
        };

        //스크롤 감지하는 부분
//         $(window).scroll(function () {
        	 
//             if ($(window).scrollTop() == $(document).height() - $(window).height()) {
//                 lastPostFunc();
//             }
//         });
        
 
 
 
function name_check(){
//	var url = "/include/name_gpin.jsp?board_id=<%=board_id%>&type=mobile_write";    
	var url = "/mobile/include/name_gpin.jsp?board_id=<%=board_id%>&type=mobile_write";
	location.href=url;    
	//window.open(url, "name_check", "width=400, height=300, toolbar=no,location=no,status=yes,menubar=no,scrollbars=no,resizable=no" );
// 	jQuery.colorbox({href:url, 
// 		 iframe:true,
// 		 innerWidth:420, 
// 		 innerHeight:430,
// 		 open:true});
	 
}

function pwd_check(listId, boardId){ 
	var url = "./pwd_check.jsp?board_id="+boardId+"&list_id="+listId+"&type=view";
	 //window.open(url, "name_check", "width=400, height=300, toolbar=no,location=no,status=yes,menubar=no,scrollbars=no,resizable=no" );
	 location.href=url;
	    
//  	jQuery.colorbox({href:url, 
// 		 iframe:true,
// 		 innerWidth:420, 
// 		 innerHeight:430,
// 		 open:true});
}


function name_check2(){ 
	 window.open("/include/certnc_main.jsp?result_url=type=mobile_write::board_id=<%=board_id%>", "name_check", "width=400, height=300, toolbar=no,location=no,status=yes,menubar=no,scrollbars=no,resizable=no" );
}
 
     </script>   
		<section>
			<div id="container">
				<div class="snb_head">
					<h2><%= board_title%></h2>
					<div class="snb_back"><a href="javascript:history.back();"><span class="hide_txt">뒤로</span></a></div><!--이전페이지로 이동-->
					<div class="snb_write"> 
					
					<%if(board_user_flag != null && board_user_flag.equals("t")){  } else{ %>
						<% if (board_auth_write == 0) { %>
							<a href="board_write.jsp?board_id=<%=board_id%>"><span class="hide_txt">글쓰기</span></a>
						<%} else {
						  if (vod_name != null && vod_name.length() > 0) { %>
							<a href="board_write.jsp?board_id=<%=board_id%>"><span class="hide_txt">글쓰기</span></a>
						<%} else { %>
							<% if (board_auth_write > 1) { %>
								<a href="javascript:login('write');"><span class="hide_txt">글쓰기</span></a> 
							<%} else { %>
								<a href="javascript:name_check();"><span class="hide_txt">글쓰기</span></a> 
							<%} %>
						<%} %>
						<%} %>
					<%} %>
					
	
					</div><!--글쓰기가 있을때만 존재-->
				</div>
<!-- 				<div class="mLive"> -->
<!-- 					<a href=""><span class="onair">ON-AIR</span><span class="live_time">07:50~</span><strong>2017년 4월의 만남만남만남만남만남만남만남만만남만남만남만남만남만남만남만남만남만남만남만남만남만남남만남만남만남만남만남만남</strong></a> -->
<!-- 				</div>//생방송안내(생방송이 있을때만 표출:mLive -->
				<%@ include file = "../include/live_check.jsp"%>
 					
				<div class="<% if (flag != null && flag.equals("N")) { out.print("newsList"); }else {out.print("vodList"); } %>" >
				
				<%			
				if(v_bt != null && v_bt.size()>0)
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
					%>
					<ul>
					<%
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
 
					<li style="border:1px solid #e4e5e7"><a href="./board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><span class="notice">공지</span><%=list_title%>
					<span class="update"><strong><%String temp_writer = list_name;
						out.println(temp_writer); %></strong><%=list_date%></span></a>
					</li>
					
			
						
 <%
					}
					%>
					</ul>
					<%
				}
%>				
					<ul  id="vodList" >	</ul>
				</div><!--게시판리스트:newsList-->
				 <div id="lastPostsLoader"></div> 
				<div class="btn4"><a href="javascript:lastPostFunc();">more</a></div>
			</div>
<!-- 			<div class="mNotice"> -->
<!-- 				<h3>공지</h3> -->
<!-- 				<a href="">2017년 2월 수원시 행사 안내입니다안내입니다안내입니다안내입니다.</a> -->
<!-- 			</div>//공지사항:mNotice -->
		</section><!--//콘텐츠부분:section-->    
		
<%@ include file = "../include/foot.jsp"%>	 