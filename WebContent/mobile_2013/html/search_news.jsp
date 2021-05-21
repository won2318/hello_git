 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
  
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.news.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@page import="com.yundara.util.TextUtil"%>
 
 <%
 request.setCharacterEncoding("euc-kr");
  
	String ccode = "";
	if(request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0 && !request.getParameter("ccode").equals("null")){
		ccode = request.getParameter("ccode");
	}
	
	String searchField = "all";
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length() > 0 && !request.getParameter("searchField").equals("null")){
		searchField = request.getParameter("searchField");
	}else{
		searchField = "all";
	}
	
	String searchString = "";
	if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 && !request.getParameter("searchString").equals("null")){
		searchString = request.getParameter("searchString");
		//searchString = new String(searchString.getBytes("8859_1"),"euc-kr")  ; 
	}
	
	String type ="";
	if(request.getParameter("type") != null && request.getParameter("type").length() > 0 && !request.getParameter("type").equals("null")){
		type = request.getParameter("type");
	}else{
		type = "all";
	}
	
	String date ="";
	if(request.getParameter("date") != null && request.getParameter("date").length() > 0 && !request.getParameter("date").equals("null")){
		date = request.getParameter("date");
	}else{
		date = "all";
	}
 
%>
<%@ include file = "../include/search_head.jsp"%>
<%@ include file="/include/chkLogin.jsp"%>
<% 

int pageSize = 12;
int totalArticle =0; //총 레코드 갯수
int totalPage =0;
int pg = 0; 
 
int pagePerBlock = 3;

ArticleManager mgr = ArticleManager.getInstance();

Hashtable result_ht = null;
Vector vt_list = null;
com.yundara.util.PageBean pageBean = null;
try{
	result_ht = mgr.getArticleList_search( searchField,  searchString,  date,   pg,  pageSize,  pagePerBlock) ;
	
	if(!result_ht.isEmpty() ) {
		vt_list = (Vector)result_ht.get("LIST");

		if ( vt_list != null && vt_list.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPage(pg);
	        	//pageBean.setLinePerPage(5);
				pageBean.setPagePerBlock(pagePerBlock);	
				totalArticle = pageBean.getTotalRecord();
	        	totalPage = pageBean.getTotalPage();
	        }
		}
    }
}catch(NullPointerException e){
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('처리 중 오류가 발생했습니다. 잠시후에 다시 시도하여 주세요.')");
	out.println("history.go(-1)");
	out.println("</SCRIPT>");
}
%>

  <script type="text/javascript">
 
//   var $container_list
//   jQuery(document).ready(function( $ ) {

// 	  // Start Masonry
// 	   $container_list = $('#vodList').masonry({
// 	    columnWidth: 150,
// 	    itemSelector: '.pin',
// 	    gutter: 20,
// 	    isFitWidth: true
// 	  });
           
// 	});

jQuery(document).ready(function( $ ) {
  lastPostFunc();
});  
  
    var page_cnt = 0;
        function lastPostFunc() {
        	 
        	if (page_cnt < <%=totalPage%>) {
        		page_cnt++;
        		//alert(page_cnt);
                 //데이타(data) 가져 오는 부분
                 $.post("search_news_scroll_data.jsp?searchField=<%=searchField%>&searchString=<%=searchString%>&date=<%=date%>&ccode=<%=ccode%>&page=" + page_cnt,

                 //post에서 전송 받은 데이터(data)
                 function (data) {
                	//alert(data);
                     if (data != "") { 
                    	 $("#wrdLatest:last").append(data);
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
        
 
        
     </script>   
     
     
<div id="container"> 
	<div class="major">
	<section> 
 	
		<div class="vodFullList">
			<h3>동영상<span><%=totalArticle%>건</span></h3>
 		
			<ul id="wrdLatest"><!-- element 1 --> 
			</ul>
		</div>
		 <div id="lastPostsLoader"></div> 
	</section> 
	</div>
	<div class='btn4'><a href="javascript:lastPostFunc();">more</a></div>  
	 
</div>   

 <%@ include file = "../include/foot.jsp"%>
</body>
</html>