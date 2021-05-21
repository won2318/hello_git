<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@page import="java.util.*"%>
<%@page import="com.yundara.util.TextUtil"%>
 
 
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />

<%@ include file = "../include/head.jsp"%>

<%
	request.setCharacterEncoding("EUC-KR");
 
	String category = TextUtil.nvl(request.getParameter("category"));
 
String menu_title = "��ü����";

if (category != null && category.length() > 0) {
	 
	menu_title= CategoryManager.getInstance().getCategoryOneName_like(category, "V");
}
	int pageSize = 12;
	int totalArticle =0; //�� ���ڵ� ����
	int totalPage =0;
	int pg = 0; 
 
	int pagePerBlock = 3;
	MediaManager mgr = MediaManager.getInstance();
	
	Hashtable result_ht = null;
	Vector vt_list = null;
	com.yundara.util.PageBean pageBean = null;
	try{
		result_ht = mgr.getMediaList(category, pg, pageSize,pagePerBlock);
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
		out.println("alert('ó�� �� ������ �߻��߽��ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");
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


 var $container_list;
jQuery(document).ready(function( $ ) {
	
//    $container_list =
//    $('#vodList').masonry({
//        // options
//    //	columnWidth: 5,  
//        itemSelector : '.pin',
//        isAnimated: true,
//        isFitWidth: true
		
//    });
 
  lastPostFunc();
  
});  
  
    var page_cnt = 0;
        function lastPostFunc() {
        	 
        	if (page_cnt < <%=totalPage%>) {
        		page_cnt++;
        		//alert(page_cnt);
                 //����Ÿ(data) ���� ���� �κ�
                 $.post("vod_scroll_data.jsp?category=<%=category%>&page=" + page_cnt,

                 //post���� ���� ���� ������(data)
                 function (data) {
                	//alert(data);
                     if (data != "") { 
 
// 						    var $moreBlocks = $( data );
// 						    $container_list.append( $moreBlocks );
// 						    $container_list.masonry( 'appended', $moreBlocks );

						    $("#vodList:last").append(data);
 
                     } 
                     
                     $("div#lastPostsLoader").empty();
                 });
        	}
           
        };

        //��ũ�� �����ϴ� �κ�
//         $(window).scroll(function () {
        	 
//             if ($(window).scrollTop() == $(document).height() - $(window).height()) {
//                 lastPostFunc();
//             }
//         });
        
 
        
     </script>   

		<section>
			<div id="container">
				<div class="snb_head">
					<h2><%=menu_title %></h2>
					<div class="snb_back"><a href="javascript:history.back();"><span class="hide_txt">�ڷ�</span></a></div><!--������������ �̵�-->
					<% if (category != null && category.equals("004001000000") ) { // ���� PD �۾��� �Խ��� ��ũ%>
					<div class="snb_write"><a href="./board_list.jsp?board_id=11"><span class="hide_txt">�۾���</span></a></div>
					<%} %>
				</div>
<!-- 				<div class="mLive"> -->
<!-- 					<a href=""><span class="onair">ON-AIR</span><span class="live_time">07:50~</span><strong>2017�� 4���� ����������������������������������������������������������������������������������������������������������������</strong></a> -->
<!-- 				</div>//����۾ȳ�(������� �������� ǥ��:mLive -->
<%@ include file = "../include/live_check.jsp"%>
				<div class="vodList" id="vodList"><!--¦���� �����ٰ�-->
					 
				 
				</div><!--//������:vodList-->
				 <div id="lastPostsLoader"></div> 
				<div class="btn4"><a href="javascript:lastPostFunc();">more</a></div>
			</div>
<!-- 			<div class="mNotice"> -->
<!-- 				<h3>����</h3> -->
<!-- 				<a href="">2017�� 2�� ������ ��� �ȳ��Դϴپȳ��Դϴپȳ��Դϴپȳ��Դϴ�.</a> -->
<!-- 			</div>//��������:mNotice -->
		</section><!--//�������κ�:section-->    

		
 <%@ include file = "../include/foot.jsp"%>