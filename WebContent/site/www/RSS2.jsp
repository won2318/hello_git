<?xml version="1.0" encoding="euc-kr" ?>
<%@ page contentType="text/xml; charset=euc-kr" errorPage="/error.jsp"%>

<%@ page import="java.sql.*"%>
<%@ page import= "java.util.*" %>
<%@ page import= "java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*"%>

<% request.setCharacterEncoding("MS949"); %>

<rss version="2.0">
<channel>

<%
	MediaManager mgr = MediaManager.getInstance();
	Hashtable result_ht = null;
	String ccode_list = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
	if(ccode_list == null || ccode_list.length() <= 0){
		ccode_list = "";
	}
	
	
	int pg = 0;
	if(request.getParameter("_page_")==null){
	    pg = 1;
	}else{
	    
		try{
			pg = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("_page_")));
		}catch(Exception ex){
			
		}
	}
	
	String searchField = "";		//검색 필드
	String searchString = "";		//검색어
	String mtype = "V";
	
	String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "ocode");
	String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");
	
	int listCnt = 100;				//페이지 목록 갯수
	searchField = "";
	searchString = "";
	
	
	result_ht = mgr.getOMediaListAll_open2_cate(ccode_list,mtype, order, searchField, searchString, pg, listCnt, direction, 0);
	
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
			out.print(" http://"+request.getServerName()+"/index_link.jsp?ocode="+oinfo.getOcode()+"&amp;ccode="+oinfo.getCcode() );
			out.print(" ");
			out.print(" </link>");
			out.print("<description><![CDATA["+ocontents+"]]></description>");
			out.print(" <pubDate>"+strOwdate+"</pubDate> ");
			out.print(" <category>"+oinfo.getCtitle() +"</category> ");
			out.print(" </item> ");
		}
	}
	 out.print(" </channel>");
	 out.print(" </rss>");
%>
