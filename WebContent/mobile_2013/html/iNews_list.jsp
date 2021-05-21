 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 <%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
 <%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.news.*"%> 
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
  
<%@ include file = "../include/head.jsp"%>
<%@ include file="/include/chkLogin.jsp"%>
<%
 request.setCharacterEncoding("EUC-KR");
 
String menu_id = "0101" ;
String menu_title="�ֿ䴺��";
if(request.getParameter("menu_id") != null && request.getParameter("menu_id").length() > 0 && !request.getParameter("menu_id").equals("null") )
{
	menu_id =TextUtil.nvl(request.getParameter("menu_id"));
	 
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�.')");

	//out.println("history.go(-1)");
	out.println("</SCRIPT>");
}
 
if (menu_id != null && menu_id.equals("0101") ) {
	menu_title="�ֿ䴺��";
} else if (menu_id != null && menu_id.equals("0102")) {
	menu_title="�ֽŴ���";
} else if (menu_id != null && menu_id.equals("0301")) {
	menu_title="�ùα���";
} else if (menu_id != null && menu_id.equals("0302")) {
	menu_title="��ȭ";
}else if (menu_id != null && menu_id.equals("0303")) {
	menu_title="Į��";
}
  
 	
	int pageSize = 12;
	int totalArticle =0; //�� ���ڵ� ����
	int totalPage =0;
	int pg = NumberUtils.toInt(request.getParameter("page"), 1);
	int pagePerBlock = 3;
	
	ArticleManager mgr = ArticleManager.getInstance();
	
	Hashtable result_ht = null;
	Vector vt_list = null;
	com.yundara.util.PageBean pageBean = null;
	try{
		result_ht = mgr.getArticleList(menu_id, pg, pageSize,pagePerBlock);
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
  
jQuery(document).ready(function( $ ) {
  lastPostFunc();
});  
  
    var page_cnt = 0;
        function lastPostFunc() {
        	 
        	if (page_cnt < <%=totalPage%>) {
        		page_cnt++;
        		//alert(page_cnt);
                 //����Ÿ(data) ���� ���� �κ�
                 $.post("news_scroll_data.jsp?menu_id=<%=menu_id%>&page=" + page_cnt,

                 //post���� ���� ���� ������(data)
                 function (data) {
                     if (data != "") {  
                    	// alert(data);
                    	<%if (menu_id != null && (menu_id.equals("0301") || menu_id.equals("0302")) ) { %>
                    	 var $moreBlocks = $( data );
						    // Append new blocks
						    $container_list.append( $moreBlocks ); 
						    // Have Masonry position new blocks
						    $container_list.masonry( 'appended', $moreBlocks );
                    	<% } else { %>	 
                    	 $("#wrdLatest:last").append(data);
                    	<% } %>
						    
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
 
	<div class="snb">
		<strong><%= menu_title%></strong>
		<span><button onclick="showHide('menuFull');return false;" class="menu_view">����������</button></span>
		<div id="menuFull" style="display:none;">
		<ul class="menuView">
			<%@ include file = "../include/iNews_menu.jsp"%>
		</ul>
		<button onclick="showHide('menuFull');return false;" class="menu_close">�޴��ݱ�</button>
	</div>
</div>

</div>
<div id="container"> 
	<div class="major">
	
	<section>
		<!-- vodList -->
		
		<%if (menu_id != null && (menu_id.equals("0301") || menu_id.equals("0302")) ) { %>
		
		<div class="vodList"  id="vodList" >
			<!-- pin element 1 --> 
		</div>
		<%} else { %>
		<div class="newsList">
			<ul id="wrdLatest"><!-- element 1 --> 
			</ul>
		</div>
		<%} %> 
		
		 <div id="lastPostsLoader"></div> 
	</section> 
	</div>
	<div class='btn4'><a href="javascript:lastPostFunc();">more</a></div>  
</div>

 <%@ include file = "../include/foot.jsp"%>
</body>
</html>