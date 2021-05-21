<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.yundara.util.*"%>

<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%

request.setCharacterEncoding("euc-kr");
 
MediaManager mgr = MediaManager.getInstance();
Hashtable result_ht = null; 

 String ccode ="";
 String this_ccode ="";
 
 if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
 	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
 } 
 

 if (request.getParameter("this_ccode") != null && request.getParameter("this_ccode").length() > 0  && !request.getParameter("this_ccode").equals("null")) {
	 this_ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("this_ccode"));
 } else {
	 if (ccode != null &&  ccode.equals("005002000") ) { // 월례만남
	 	this_ccode = "006001001000";
	 } else if (ccode != null &&  ccode.equals("005003000") ) {  //확대간부회의
	 	this_ccode = "006001002000";
	 }
 }
 int board_id = 0;   

 if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
 {
 	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
 	 
 } 

	CategoryManager cmgr = CategoryManager.getInstance();
	Vector cate_x = cmgr.getCategoryListALL2("X","A");
	
 
	String search_ycode = "";
	if(request.getParameter("search_ycode") != null && request.getParameter("search_ycode").length() > 0 && !request.getParameter("search_ycode").equals("null")){
		search_ycode = request.getParameter("search_ycode");
	}
	
	String searchField = "";
	if(request.getParameter("searchField") != null && request.getParameter("searchField").length() > 0 && !request.getParameter("searchField").equals("null")){
		searchField = request.getParameter("searchField");
	} 
	
	String searchString = "";
	if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 && !request.getParameter("searchString").equals("null")){
		searchString = request.getParameter("searchString");
	}
  
	String[] xcodes = request.getParameterValues("xcode");
	String xcode ="";
	if (xcodes != null && xcodes.length > 0) {
		for (int i = 0 ; xcodes != null && i < xcodes.length ; i++ ) {
			xcode += xcodes[i]+"/";				
		}
	}  
 

int pg = 0;
if(request.getParameter("_page_")==null || !com.yundara.util.TextUtil.isNumeric(request.getParameter("_page_"))){
    pg = 1;
}else{
	try{
		pg = Integer.parseInt(request.getParameter("_page_"));
	}catch(Exception ex){
		pg = 1;
	}
}

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "mk_date");
String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

int listCnt = 5;				//페이지 목록 갯수
int totalArticle =0; //총 레코드 갯수
 	result_ht = mgr.getOMediaListAllSearch(this_ccode, xcode, search_ycode, order ,searchField,  searchString, pg, listCnt, direction, 0);
 
	String frontPage = "<a href='#'><img src='../css/sub_left.gif' alt='첫페이지입니다.'></a>";
	String nextPage= "<a href='#'><img src='../css/sub_right.gif' alt='마지막 페이지입니다.'></a>";

	Vector ibt = null;
	com.yundara.util.PageBean pageBean = null;
	int iTotalPage = 0;
	int iTotalRecord = 0;
	if(result_ht != null && !result_ht.isEmpty() && result_ht.size() > 0){
		ibt = (Vector)result_ht.get("LIST");
		if(ibt != null && ibt.size()>0){
			pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
			iTotalRecord = pageBean.getTotalRecord();
			iTotalPage = pageBean.getTotalPage();
			totalArticle = pageBean.getTotalRecord();
			

			
			if (pageBean.getCurrentPage() != 1) {
						
					frontPage = "<a href='video_list.jsp?_page_="+(pg-1)+"&this_ccode="+this_ccode+"'><img src='../css/sub_left.gif' border='0' name='frontPage' alt='"+(pg-1)+" 페이지'></a>";
				}
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) { 
					
					nextPage = "<a href='video_list.jsp?_page_="+(pg+1)+"&this_ccode="+this_ccode+"'><img src='../css/sub_right.gif' name='nextPage' alt='"+(pg+1)+" 페이지'></a>";
				}


		}
	} 
 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
		<title>수원 iTV - 수원시 인터넷 방송입니다.</title>
		<link href="../css/style.css" rel="stylesheet" type="text/css" />
	</head>
<body>

<div class="outLink4">
<p class="prev"><%=frontPage%></p>
<ul>
	<form name="form1" action="video_list.jsp" method="post">
	<input type="hidden" name="_page_" value="<%=pg%>" />
	<input type="hidden" name="this_ccode" value="<%=this_ccode %>" />
<%
	//com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	int list = 0;
	if ( ibt != null && ibt.size() > 0){

		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<ibt.size()) ; i++, list++)
		{
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
			//String ocontents = oinfo.getDescription();
			String ocontents = oinfo.getContent_simple();
			String imgurl ="/2013/include/images/noimg_small.gif";
			String imgTmp = DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media/"+oinfo.getSubfolder()+"/thumbnail/_small/"+oinfo.getModelimage();
			String strTitle = oinfo.getTitle();
		 	
			if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
				imgTmp = imgurl;
			}
			if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
				imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
			}
     		if((ocontents != null) &&   !ocontents.equals("")) {
				ocontents = ocontents.length() <= 100 ? ocontents : ocontents.substring(0, 98) + "..";
				ocontents = ocontents.replaceAll("<p>","").replaceAll("</p>","").replaceAll("<P>","").replaceAll("</P>","");
			}
 			String wdate = "";
			if(oinfo.getOcode() != null && oinfo.getOcode().length()>0){
				
				wdate = oinfo.getMk_date();
				String temp_ocode = oinfo.getOcode().substring(0,8);
			
%>					 
						
			<li>
				<span class="img"><a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title='<%=oinfo.getTitle()%>' target="_blank"><img src="<%=imgTmp%>" alt='<%=oinfo.getTitle()%>'/></a></span>
				<span class="total">
					<a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" class="main_weekly2" target="_blank"><%=oinfo.getTitle()%></a>
					<span class="cate">[<%=oinfo.getMk_date()%>]</span>
				</span>
			</li>
			
					 
<%
			}
		}
	}else{
		if (searchString != null && searchString.length() > 0) {
		%> 
		<li class="no">등록된 정보가 없습니다.</li>
		<%
		} 
	}
%>	 
	</form>
</ul>
<p class="next"><%=nextPage %></p>
 
<%if(ibt != null && ibt.size()>0){ %>	 
<%@ include file = "./search_pageing.jsp"%>
<%} 
%>	
	<!-- 동영상 이미지 끝 -->
 	 
</div>
<!-- order list view -->
 
</body>
</html>