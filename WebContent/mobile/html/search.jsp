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
<%@ include file = "../include/head.jsp"%>



<%
request.setCharacterEncoding("euc-kr");
	String search_ycode = "";
	if(request.getParameter("search_ycode") != null && request.getParameter("search_ycode").length() > 0 && !request.getParameter("search_ycode").equals("null")){
	search_ycode = request.getParameter("search_ycode").replaceAll("<","").replaceAll(">","");
	}
	String search_ccode = "";
	if(request.getParameter("search_ccode") != null && request.getParameter("search_ccode").length() > 0 && !request.getParameter("search_ccode").equals("null")){
	search_ccode = request.getParameter("search_ccode").replaceAll("<","").replaceAll(">","");
	}
	String menu_id = "";
	if(request.getParameter("menu_id") != null && request.getParameter("menu_id").length() > 0 && !request.getParameter("menu_id").equals("null")){
		menu_id = request.getParameter("menu_id").replaceAll("<","").replaceAll(">","");
	}
	String searchField = "all";
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length() > 0 && !request.getParameter("searchField").equals("null")){
		searchField = request.getParameter("searchField").replaceAll("<","").replaceAll(">","");
	}else{
		searchField = "all";
	}
	
	String searchString = "";
	if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 && !request.getParameter("searchString").equals("null")){
		//searchString = request.getParameter("searchString");
		searchString =  com.yundara.util.CharacterSet.toKorean(request.getParameter("searchString").replaceAll("<","").replaceAll(">",""));
	}
	
	String type ="";
	if(request.getParameter("type") != null && request.getParameter("type").length() > 0 && !request.getParameter("type").equals("null")){
		type = request.getParameter("type").replaceAll("<","").replaceAll(">","");
	}else{
		type = "all";
	}
	
	String date ="";
	if(request.getParameter("date") != null && request.getParameter("date").length() > 0 && !request.getParameter("date").equals("null")){
		date = request.getParameter("date").replaceAll("<","").replaceAll(">","");
	}else{
		date = "all";
	}

%>

<%
int pageSize = 6;
int totalArticle =0; //총 레코드 갯수
int totalPage =0;
int pg = 0; 

int pagePerBlock = 3;
MediaManager mgr = MediaManager.getInstance();

Hashtable result_ht = null;
Vector vt_list = null;
com.yundara.util.PageBean pageBean = null;
try{
	//result_ht = mgr.getMediaList_search(ccode, searchField, searchString, date, pg, pageSize, pagePerBlock);
	result_ht = mgr.getMediaList_search(search_ccode, searchField, searchString, date, pg, pageSize, pagePerBlock);
	
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

<script language="javascript" src="../include/js/ajax_category_select2.js"></script>
<script type="text/javascript">
//대분류 카테고리 불러오기 (ajax_category_select.js)
window.onload = function() {
	refreshCategoryList_A('V', '', 'A', '<%=search_ccode%>');
	refreshCategoryList_B('V', '', 'B', '<%=search_ccode%>');

} 

function setCcode(form, val) {
	form.search_ccode.value = val;
}
function setCcodeY(form, val) {
	form.search_ycode.value = val;
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
         $.post("search_vod_scroll_data.jsp?searchField=<%=searchField%>&searchString=<%=searchString%>&date=<%=date%>&ccode=<%=search_ccode%>&page=" + page_cnt,

         //post에서 전송 받은 데이터(data)
         function (data) {
             if (data != "") { 
            	 $("#wrdLatest:last").append(data);
             } 
             
             $("div#lastPostsLoader").empty();
         });
	}
   
};


function search_form(){
document.search_form.action = "search.jsp";
document.search_form.submit(); 
}

<!--
 
function go_searchVod(){
	document.search_form.action="search_vod.jsp";
	document.search_form.submit();
}
//-->
</script>

		<section>
			<div id="container">
			
				<div class="snb_head">
					<h2>전체검색</h2>
					<div class="snb_back"><a href="javascript:history.back();"><span class="hide_txt">뒤로</span></a></div><!--이전페이지로 이동-->
				</div>
<!-- 				<div class="mLive"> -->
<!-- 					<a href=""><span class="onair">ON-AIR</span><span class="live_time">07:50~</span><strong>2017년 4월의 만남만남만남만남만남만남만남만만남만남만남만남만남만남만남만남만남만남만남만남만남만남남만남만남만남만남만남만남</strong></a> -->
<!-- 				</div>//생방송안내(생방송이 있을때만 표출:mLive -->
<%@ include file = "../include/live_check.jsp"%>
				<div class="content_inner">
				<form name="search_form" method="post">
				<input type="hidden" name="search_ycode" value="<%=search_ycode%>" />
				<input type="hidden" name="search_ccode" value="<%=search_ccode%>" />
					<div id="searchInfo">
						<fieldset>
						<legend> 검색</legend>
						<p>
							<input type="search" name="searchString" title="검색어입력" value="<%=searchString%>" class="style"/>
							<a href="javascript:search_form();" data-role="button" class="btn3">검색</a>
						</p>
						</fieldset>	
						<ul class="search"> 
							<li><span>영역</span>
								<input type="radio" id="domain1" name="searchField" value="all" title="전체"  <%if(searchField.equals("all")){%>checked="true"<%}%>/><label for="domain1">전체</label> 
				<input type="radio" id="domain2" name="searchField" value="title" title="제목"  <%if(searchField.equals("title")){%>checked="true"<%}%>/><label for="domain2">제목</label> 
				<input type="radio" id="domain2" name="searchField" value="tag_kwd" title="키워드"  <%if(searchField.equals("tag_kwd")){%>checked="true"<%}%>/><label for="domain2">키워드</label>
				<input type="radio" id="domain3" name="searchField" value="content" title="내용"  <%if(searchField.equals("content")){%>checked="true"<%}%>/><label for="domain3">내용</label>
							</li>
							<li><span><label for="search_ccode">분류</label></span>
								<select id="ccategory1" name="ccategory1" class="select1" style="width:125px;" onchange="javascript:setCcode(document.search_form, this.value); refreshCategoryList('V', this.value, 'B', 'ccategory2');">
									<option value="">- 대분류 선택 -</option>
								</select>
								<select id="ccategory2" name="ccategory2" class="select1" style="width:125px;" onchange="javascript:setCcode(document.search_form, this.value)">
									<option value="">- 중분류 선택 -</option>
								</select> 
							</li>
						</ul>			
					</div>
					</form>
					<div class="vodFullList">
						<h3>총<span><%=totalArticle%></span>건이 검색되었습니다.</h3>
						<ul  id="wrdLatest">
					 
							
						</ul> 
						<div id="lastPostsLoader"></div>  
					</div>
				</div>	<!--//content_inner-->	 
				<div class="btn4"><a href="javascript:lastPostFunc();">more</a></div>
 	
			</div>
<!-- 			<div class="mNotice"> -->
<!-- 				<h3>공지</h3> -->
<!-- 				<a href="">2017년 2월 수원시 행사 안내입니다안내입니다안내입니다안내입니다.</a> -->
<!-- 			</div>//공지사항:mNotice -->
		</section><!--//콘텐츠부분:section-->    
		
 
 <%@ include file = "../include/foot.jsp"%>