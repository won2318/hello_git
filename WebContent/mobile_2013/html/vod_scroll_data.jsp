<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
<%@page import="com.yundara.util.TextUtil"%>
<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@page import="com.vodcaster.sqlbean.DirectoryNameManager"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /> 
<%@ include file="/include/chkLogin.jsp" %> 
<%
request.setCharacterEncoding("EUC-KR");

String category = TextUtil.nvl(request.getParameter("category"));


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
					
					String temp_ctitle = oinfo.getCtitle(); 
					if (oinfo.getCcode().contains("004001")) {
						temp_ctitle = "나도PD";
					} 
	%>	 			
			<div class="pin">
				<%if ( i < 2) { %>
				<span class="new"><img src="../include/images/icon_new.png" alt="NEW" width="64"/></span>
				<%} %>
				<% if (oinfo.getCcode() != null && oinfo.getCcode().equals("004001001000")) {%>
				<span class="vj"><img src="../include/images/icon_vj.png" alt="VJ채택" width="64"/></span>
				<%} %>
				<span class="img"><a  href="javascript:link_colorbox('vod_view.jsp?ocode=<%=oinfo.getOcode() %>');" ><span class="playBig"></span><img src="<%=thumb%>" alt="<%=title%>"/></a></span>
				<span class="total">
					<span class="cate">[<%=temp_ctitle %>]</span>
					<span class="title"><a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=oinfo.getOcode() %>')"><%=title%></a></span>
<%-- 					<span class="subject"><%=description%></span> --%>
				</span>
				<span class="info">
					<span class="time"><%=oinfo.getPlaytime() %></span>
				</span>
			</div> 
<%
				}
			}catch(Exception e){}
	 
%>
					<%}else{%>
					<div class="pin">
			 
						<span class="img"><img src="../include/images/noimg.gif" alt="등록된 정보가 없습니다."/></span>
						<span class="total">
							<span class="cate"> </span>
							<span class="title"><a href="#">등록된 정보가 없습니다.</a></span>
							<span class="subject"> </span>
						</span>
						<span class="info">
							<span class="time"> </span>
						</span>
					</div>
					
					<%}%>
  
 