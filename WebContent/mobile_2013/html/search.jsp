<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

  
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.news.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@page import="com.yundara.util.TextUtil"%>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%
request.setCharacterEncoding("euc-kr");

	String menu_id = "";
	if(request.getParameter("menu_id") != null && request.getParameter("menu_id").length() > 0 && !request.getParameter("menu_id").equals("null")){
		menu_id = request.getParameter("menu_id");
	}
	
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
<%@ include file="/include/chkLogin.jsp"%><script type="text/javascript">
<!--
function go_searchNews(){
	document.search_form.action="search_news.jsp";
	document.search_form.submit();
}

function go_searchVod(){
	document.search_form.action="search_vod.jsp";
	document.search_form.submit();
}
//-->
</script>
</div>
<div id="container"> 
	<div class="major">
	<section>
		<div class="newsFullList">
<%
	ArticleManager mgr_news = ArticleManager.getInstance(); 
	int totle_news = mgr_news.searchArticle_Count(menu_id, searchField, searchString, date); 
%>
			 
			<h3>뉴스<span><%=totle_news%>건</span></h3>
 			
<%
		if(totle_news > 5){
%> 			
			<p class="more"><a href="javascript:go_searchNews()">+ 더보기</a></p>
<%
		}
%>			
			<ul >
<%
	
	Vector vt_news = mgr_news.searchArticle(menu_id, searchField, searchString, date, 0, 5);
		
	if(vt_news != null && vt_news.size() > 0){

		String idx = "";
		String news_title = "";
		String news_sub_title = "";
		String news_date = "";
		String news_img = "";
		String news_writer = "";
 
		
		for(int i=0; i<vt_news.size(); i++){
			Hashtable ht_news = (Hashtable)vt_news.get(i);
		
			idx = String.valueOf(ht_news.get("idx"));
			news_title = String.valueOf(ht_news.get("title")).replace("\\","");
			if (ht_news.get("sub_title") != null && ht_news.get("sub_title").toString().length() > 0) {
			news_sub_title = String.valueOf(ht_news.get("sub_title")).replace("\\","");
			}
			news_date = String.valueOf(ht_news.get("date"));
			news_writer = String.valueOf(ht_news.get("name"));
			if (news_date != null && news_date.length() > 10) {
				news_date.substring(0,10);
			}
			news_img = String.valueOf(ht_news.get("img_file1"));
			if(news_img != null && news_img.length() > 0 && news_img.lastIndexOf(".") > 0){
				news_img = "http://news.suwon.ne.kr/upload"+news_img;
			}else{
				news_img = "../include/images/noimg.gif";
			} 
%>
 
			<li>
				<a href="javascript:link_colorbox('news_view.jsp?idx=<%=idx%>');">
				<span class="img"><img src="<%=news_img %>" alt="<%=news_title%>"/></span>
				<span class="info">
					<span class="title"><%=news_title%></span>
					<span class="day"><%=news_date%> | <%=news_writer%></span>
					<span class="subject"><%=news_sub_title%></span>
				</span>
				</a>
			</li>
			
<%
		}
	}else{
%>
			<li>
				<p class="sub">검색된 데이터가 없습니다.</p>
			</li>
<%		
	}
%>		
			 
			</ul>
		</div>
<%
	
		MediaManager mgr_vod = MediaManager.getInstance();
		Vector new_list1 = new Vector();
		
		new_list1 = mgr_vod.getMediaList_search(ccode, searchField, searchString, date, 5);  //최신 영상 (뉴스 카테고리)   
		
		int total_vod = mgr_vod.getMediaList_search_count(ccode, searchField, searchString, date);

%>		
		<div class="vodFullList">
			<h3>동영상<span><%=total_vod%>건</span></h3>
<%
		if(total_vod > 5){
%>			
			<p class="more"><a href="javascript:go_searchVod()">+ 더보기</a></p>
<%
		}
%>			
			<ul>
			
			<% 
			if (new_list1 != null && new_list1.size() > 0) {
				try {
				int i = 1;
				for (Enumeration e = new_list1.elements(); e.hasMoreElements(); i++) {
					com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

					String imgurl = "../include/images/noimg.gif";
					String imgTmp = DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

					if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
						imgTmp = imgurl;
					}
					if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
						imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
					}
					%>
 
					<li>
						<a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=oinfo.getOcode()%>');">
						<span class="img"><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></span>
						<span class="info">
							<span class="title"><%=oinfo.getTitle()%></span>
							<span class="subject"><%=oinfo.getContent_simple()%></span>
							<span class="day"><%=oinfo.getMk_date()%></span>
						</span>
						</a>
					</li>
 

					<%
				}
					} catch (Exception e) {
						out.println("error message :" + e);
					}
				}else{
					%>
					<li>
							<p class="sub">검색된 데이터가 없습니다.</p>
					</li>
			<%		
				}
			%>	 
 			
			</ul>
		</div>
	</section>
	</div> 
</div> 

 <%@ include file = "../include/foot.jsp"%>
</body>
</html>