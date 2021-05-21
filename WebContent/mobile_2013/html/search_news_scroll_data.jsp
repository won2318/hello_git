<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
<%@ page import="com.news.*"%>
<%@page import="com.yundara.util.TextUtil"%>
<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@page import="com.vodcaster.sqlbean.DirectoryNameManager"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /> 
<%@ include file="/include/chkLogin.jsp" %> 
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

int pageSize = 12;
int totalArticle =0; //총 레코드 갯수
int totalPage =0;
int pg = NumberUtils.toInt(request.getParameter("page"), 1);
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
 
if(vt_list != null && vt_list.size() > 0 && pageBean != null && pageBean.getEndRecord() > 0)
{
	try{
		int list = 0;
		for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<vt_list.size()); i++, list++)
		{
			Hashtable ht_list = (Hashtable)vt_list.get(list);
			  
			String idx = TextUtil.nvl(String.valueOf(ht_list.get("idx")));
			String title =  TextUtil.nvl(String.valueOf(ht_list.get("title")).replace("\\", ""));
			String sub_title =  TextUtil.nvl(String.valueOf(ht_list.get("sub_title")).replace("\\", ""));
			String this_date =  TextUtil.nvl(String.valueOf(ht_list.get("date")));
			if (this_date != null && this_date.length() > 10) {
				this_date = this_date.substring(0,10);
			}
			String name =  TextUtil.nvl(String.valueOf(ht_list.get("name")));
			String img =  TextUtil.nvl(String.valueOf(ht_list.get("img_file1")));
			if(img != null && img.length() > 0 && img.lastIndexOf(".") > 0){
				img = "http://news.suwon.go.kr/upload"+img; 
			}else{
				img = "../include/images/noimg.gif";
			}
%>	 			
 <%--
					<li class="pin">
						<a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=oinfo.getOcode()%>');">
						<span class="img"><img src="<%=img%>" alt="<%=oinfo.getTitle()%>"/></span>
						<span class="info">
							<span class="title"><%=oinfo.getTitle()%></span>
							<span class="subject"><%=oinfo.getContent_simple()%></span>
							<span class="day"><%=this_date%></span>
						</span>
						</a>
					</li>
					--%>
			<li class="pin">
				<a href="javascript:link_colorbox('news_view.jsp?idx=<%=idx%>');">
				<span class="img"><img src="<%=img %>" alt="<%=title%>"/></span>
				<span class="info">
					<span class="title"><%=title%></span>
					<span class="day"><%=this_date%> | <%=name%></span>
					<span class="subject"><%= sub_title%></span>
				</span>
				</a>
			</li>
			
					
<%
		}
	}catch(Exception e){}

%>
			<%}else{%>
 
			
					<li class="pin">
						 등록된 정보가 없습니다.
					</li>
					
			
			<%}%>
  
 