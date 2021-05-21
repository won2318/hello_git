<?xml version="1.0" encoding="euc-kr" ?>
<%@ page contentType="text/xml; charset=euc-kr" errorPage="/error.jsp"%>

<%@ page import="java.sql.*"%>
<%@ page import= "java.util.*" %>
<%@ page import= "java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*"%>

<% request.setCharacterEncoding("EUC-KR"); %>

<rss version="2.0">
<channel>

<%
	Rss_search mgr = Rss_search.getInstance();
	Hashtable result_ht = null;
 
	
	int pg = 0;
	if(request.getParameter("pageNum")==null){
	    pg = 1;
	}else{
	    
		try{
			pg = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("pageNum")));
		}catch(Exception ex){
			
		}
	}
 
	int rowNum = 10;				//페이지 목록 갯수
	if(request.getParameter("rowNum")==null){
		rowNum = 1;
	}else{
	    
		try{
			rowNum = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("rowNum")));
		}catch(Exception ex){
			
		}
	}
 
	
	String genderType = com.vodcaster.utils.TextUtil.getValue(request.getParameter("genderType"));
	String ageType = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ageType"));
	String sectionType = com.vodcaster.utils.TextUtil.getValue(request.getParameter("sectionType"));
	String prevKwd[] =  request.getParameterValues("prevKwd");
	
	
	result_ht = mgr.suwon_search(genderType, ageType, sectionType, prevKwd, pg, rowNum);
	
	Vector ibt = null;
	com.yundara.util.PageBean pageBean = null;
	
	if(result_ht != null && !result_ht.isEmpty() && result_ht.size() > 0){
		ibt = (Vector)result_ht.get("LIST");
		if(ibt != null && ibt.size()>0){
				pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	
			pageBean.setLinePerPage(100);
			pageBean.setPagePerBlock(4);
			pageBean.setPage(pg);
	
		}
	}

%>
<%
java.util.Date day = new java.util.Date();
SimpleDateFormat sdf = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss Z");
String todyaDate = sdf.format(day);

out.print("<title>수원iTV</title>");
out.print(" <link>http://"+request.getServerName()+"</link> ");
out.print(" <description>수원iTV RSS 서비스 </description> ");
out.print(" <lastBuildDate>"+todyaDate+" </lastBuildDate> ");
out.print(" <copyright>Copyright tv.suwon.go.kr</copyright> ");
//out.print(" <webMaster>dev@withustech.com</webMaster> ");	
out.print(" <language>ko</language> ");	
out.print("    <image>");	
out.print("      <title>수원iTV</title> ");	
out.print("      <url>http://tv.suwon.go.kr/2013/include/images/main/logo.png</url> ");	
out.print("      <link>http://tv.suwon.go.kr/</link> ");	
out.print("      <description>수원iTV RSS 서비스</description> ");	
out.print("    </image>");	

	int list = 0;
	com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	if(ibt != null && ibt.size()>0){
		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<ibt.size()) ; i++, list++){
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
			String otitle =String.valueOf(oinfo.getTitle());
			String strOwdate = "";
			strOwdate = oinfo.getMk_date();
			String ocontents = oinfo.getDescription();
			
			out.print("<item>");
			out.print("<title>");
			out.print("<![CDATA[ "+otitle+ "]]> ");
			out.print(" </title>");
			out.print("<link>");
			out.print("http://"+request.getServerName()+"/index_link.jsp?ocode="+oinfo.getOcode()+"&amp;ccode="+oinfo.getCcode() );
			out.print(" ");
			out.print(" </link>");
			out.print("<description><![CDATA["+ocontents+"]]></description>");
			out.print(" <pubDate>"+strOwdate+"</pubDate> ");
			out.print(" <category>"+oinfo.getCtitle() +"</category> ");
			
		 
			String imgTmp = "http://"+request.getServerName()+"/2013/include/images/noimg_small.gif";
			 
			if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
				imgTmp = DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
			}  
			if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
				imgTmp = "http://"+request.getServerName()+"/upload/vod_file/"+oinfo.getThumbnail_file();
			}
			
			out.print(" <image>"+imgTmp+"</image> ");
			out.print(" </item> ");
		}
	}
	 out.print(" </channel>");
	 out.print(" </rss>");
%>
