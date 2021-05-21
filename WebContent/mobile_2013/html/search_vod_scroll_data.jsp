<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
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
//request.setCharacterEncoding("euc-kr");
 
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
	searchString = new String(searchString.getBytes("8859_1"),"euc-kr")  ; 
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
MediaManager mgr = MediaManager.getInstance();

Hashtable result_ht = null;
Vector vt_list = null;
com.yundara.util.PageBean pageBean = null;
try{
	result_ht = mgr.getMediaList_search(ccode, searchField, searchString, date, pg, pageSize, pagePerBlock);
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
			//Hashtable ht_list = (Hashtable)vt_list.get(list);
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)vt_list.elementAt(list));
			
			String ocode = TextUtil.nvl(oinfo.getOcode());
			String title = TextUtil.nvl(oinfo.getTitle());
			//if (title != null && title.length() > 32) {
		//		title= title.substring(0,30)+"..";
   		//	}
			String description = TextUtil.nvl(oinfo.getContent_simple());
			
			description = description.replaceAll("<P>","");
			description = description.replaceAll("</P>","");
			description = description.replaceAll("<p>","");
			description = description.replaceAll("</p>","");
			
			if (description != null && description.length() > 102) {
				description= description.substring(0,100)+"..";
   				
   			}
			String modelimage = TextUtil.nvl(oinfo.getModelimage());
			String subfolder = TextUtil.nvl(oinfo.getSubfolder());

			String thumb = DirectoryNameManager.SILVERLIGHT_SERVERNAME + DirectoryNameManager.SILVERMEDIA + "/" 
								+ subfolder + "/thumbnail/_small/" + modelimage;
			if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
					thumb = "/upload/vod_file/"+oinfo.getThumbnail_file();
			}
%>	 			
 
					<li class="pin">
						<a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=oinfo.getOcode()%>');">
						<span class="img"><img src="<%=thumb%>" alt="<%=oinfo.getTitle()%>"/></span>
						<span class="info">
							<span class="title"><%=oinfo.getTitle()%></span>
							<span class="subject"><%=oinfo.getContent_simple()%></span>
							<span class="day"><%=oinfo.getMk_date()%></span>
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
 