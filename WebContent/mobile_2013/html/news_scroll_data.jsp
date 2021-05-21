 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.news.*"%> 
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
 
<%@ include file="/include/chkLogin.jsp" %> 
<%
 request.setCharacterEncoding("EUC-KR");
 
String menu_id = "0101" ;
String menu_title="주요뉴스";

if(request.getParameter("menu_id") != null && request.getParameter("menu_id").length() > 0 && !request.getParameter("menu_id").equals("null") )
{
	menu_id =TextUtil.nvl(request.getParameter("menu_id"));
	 
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");

	//out.println("history.go(-1)");
	out.println("</SCRIPT>");
}
if (menu_id != null && menu_id.equals("0101") ) {
	menu_title="주요뉴스";
} else if (menu_id != null && menu_id.equals("0102")) {
	menu_title="최신뉴스";
} else if (menu_id != null && menu_id.equals("0301")) {
	menu_title="시민기자";
} else if (menu_id != null && menu_id.equals("0302")) {
	menu_title="만화";
}else if (menu_id != null && menu_id.equals("0303")) {
	menu_title="칼럼";
}
  
int pageSize = 12;
int totalArticle =0; //총 레코드 갯수
int totalPage =0;
int pg = 0; 

String cpage = TextUtil.nvl(request.getParameter("page"));
if(cpage.equals("")) {
    pg = 1;
}else {
	try{
		pg = Integer.parseInt(cpage);
	}catch(Exception e){
		pg = 0;
	}
}
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
	out.println("alert('처리 중 오류가 발생했습니다. 잠시후에 다시 시도하여 주세요.')");
	out.println("history.go(-1)");
	out.println("</SCRIPT>");
}
 
 if (menu_id != null && (menu_id.equals("0301") || menu_id.equals("0302")) ) {  // 포토 게시판 목록
 
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
					String date =  TextUtil.nvl(String.valueOf(ht_list.get("date")));
					if (date != null && date.length() > 10) {
						date = date.substring(0,10);
					}
					String name =  TextUtil.nvl(String.valueOf(ht_list.get("name")));
					if (name != null && name.length() > 0) {
						name = "["+name+"]";
					}
					String img =  TextUtil.nvl(String.valueOf(ht_list.get("img_file1")));
					if(img != null && img.length() > 0 && img.lastIndexOf(".") > 0){
						img = "http://news.suwon.ne.kr/upload"+img; 
					}else{
						img = "../include/images/noimg.gif";
					}
			 
			%>			 
		
			<div class="pin">
				 
				<span class="img"><a  href="javascript:link_colorbox('news_view.jsp?idx=<%=idx%>');" ><img src="<%=img %>" alt="<%=title %>"/></a></span>
				<span class="total">
					 <span class="cate"><%=name %></span> 
					<span class="title"><a href="javascript:link_colorbox('news_view.jsp?idx=<%=idx%>');"><%=title %></a></span>
				 
				</span>
				<span class="info">
					<span class="time"><%=date%></span>
				</span>
			</div>  
		
<%
			}  
			}catch(Exception e){}
	 
%>
			<%
			}else{
			%>
			<div class="pin">
	 
				<span class="img"><img src="../include/images/noimg.gif" alt="등록된 정보가 없습니다."/></span>
				<span class="total">
				 
					<span class="title"><a href="#">등록된 정보가 없습니다.</a></span>
					 
				</span>
				<span class="info">
					<span class="time"> </span>
				</span>
			</div>
			
			<%}
 } else { 
	 ///////////////////////
	 // 일반 게시판 목록  	 ///
	 ///////////////////////
 
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
					String date =  TextUtil.nvl(String.valueOf(ht_list.get("date")));
					String name =  TextUtil.nvl(String.valueOf(ht_list.get("name")));
					 
			 
			%>	
			<li><a href="javascript:link_colorbox('news_view.jsp?idx=<%=idx%>&menu_id=<%=menu_id%>');"><%=title %>
			 
			 <span class="subt"><%if (menu_id.equals("0303")) {out.println(sub_title);} else {out.println(name);}%></span>
			 <span class="update"><%=date %></span></a></li>
			
	 <%
			}  
			}catch(Exception e){
				//System.out.println(e);
			}
 			
		}else{
		%>
			<li>등록된 정보가 없습니다.</li>
		<% }
	 
 } %>
  
 