<%@ page language="java" contentType="text/html; charset=EUC-KR"    pageEncoding="EUC-KR"%><%@ page import="org.apache.commons.lang.StringUtils" %><%@ page import="com.hrlee.sqlbean.*"%><%@ page import="com.vodcaster.sqlbean.*"%><%@page import="java.util.*"%><%@page import="com.yundara.util.TextUtil"%>  <jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /><%@ include file = "../include/head.jsp"%><%@ include file="/include/chkLogin.jsp"%><%	request.setCharacterEncoding("EUC-KR"); 	String category = TextUtil.nvl(request.getParameter("category")); String menu_title = "��ü����";if (category != null && category.length() > 0) {	 	menu_title= CategoryManager.getInstance().getCategoryOneName_like(category, "V");}	int pageSize = 12;	int totalArticle =0; //�� ���ڵ� ����	int totalPage =0;	int pg = 0;  	int pagePerBlock = 3;	MediaManager mgr = MediaManager.getInstance();		Hashtable result_ht = null;	Vector vt_list = null;	com.yundara.util.PageBean pageBean = null;	try{		result_ht = mgr.getMediaList(category, pg, pageSize,pagePerBlock);		if(!result_ht.isEmpty() ) {			vt_list = (Vector)result_ht.get("LIST");			if ( vt_list != null && vt_list.size() > 0){		        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");		        if(pageBean != null){		        	pageBean.setPage(pg);		        	//pageBean.setLinePerPage(5);					pageBean.setPagePerBlock(pagePerBlock);						totalArticle = pageBean.getTotalRecord();		        	totalPage = pageBean.getTotalPage();		        }			}	    }	}catch(NullPointerException e){		out.println("<SCRIPT LANGUAGE='JavaScript'>");		out.println("alert('ó�� �� ������ �߻��߽��ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");		out.println("history.go(-1)");		out.println("</SCRIPT>");	}%>  <script type="text/javascript"> //   var $container_list//   jQuery(document).ready(function( $ ) {// 	  // Start Masonry// 	   $container_list = $('#vodList').masonry({// 	    columnWidth: 150,// 	    itemSelector: '.pin',// 	    gutter: 20,// 	    isFitWidth: true// 	  });           // 	});jQuery(document).ready(function( $ ) {  lastPostFunc();});        var page_cnt = 0;        function lastPostFunc() {        	         	if (page_cnt < <%=totalPage%>) {        		page_cnt++;        		//alert(page_cnt);                 //����Ÿ(data) ���� ���� �κ�                 $.post("vod_scroll_data.jsp?category=<%=category%>&page=" + page_cnt,                 //post���� ���� ���� ������(data)                 function (data) {                	//alert(data);                     if (data != "") {  						   var $moreBlocks = $( data );						    // Append new blocks						    $container_list.append( $moreBlocks );						    						    // Have Masonry position new blocks						    $container_list.masonry( 'appended', $moreBlocks );                      }                                           $("div#lastPostsLoader").empty();                 });        	}                   };        //��ũ�� �����ϴ� �κ�//         $(window).scroll(function () {        	 //             if ($(window).scrollTop() == $(document).height() - $(window).height()) {//                 lastPostFunc();//             }//         });                      </script>   

	
	<div class="snb">
		<strong><%=menu_title %></strong>
		<span><button onclick="showHide('menuFull');return false;" class="menu_view">���������</button></span>
		<div id="menuFull" style="display:none;">
		<ul class="menuView">
			 <%@ include file = "../include/iTV_menu.jsp"%>
		</ul>
		<button onclick="showHide('menuFull');return false;" class="menu_close">�޴��ݱ�</button>
		</div>
	</div>
</div>
<div id="container"> 
	<div class="major">
	<section>
		<!-- vodList -->
		<div class="vodList" id="vodList">
			<!-- pin element 1 --> 
		</div>		 <div id="lastPostsLoader"></div> 
	</section>
	</div>	<div class='btn4'><a href="javascript:lastPostFunc();">more</a></div>

	
</div>
 <%@ include file = "../include/foot.jsp"%>
</body>
</html>