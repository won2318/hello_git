 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<%@ page import="java.sql.*"%>
<%@ page import= "java.util.*" %>
<%@ page import= "java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*"%>


 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
 
<%
 
request.setCharacterEncoding("EUC-KR");
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
	
 
	 out.println(genderType);
	 for (int i = 0; i <prevKwd.length ; i++ ) {
		 out.println("테스트1:"+prevKwd[i]);
		 
		 
		 out.println("테스트3:"+new String(prevKwd[i].getBytes("8859_1"), "KSC5601"));
		 out.println("테스트4:"+new String(prevKwd[i].getBytes("utf-8"), "euc-kr"));
		 out.println("테스트5:"+new String(prevKwd[i].getBytes("utf-8"), "ksc5601"));
		 out.println("테스트6:"+new String(prevKwd[i].getBytes("utf-8"), "x-windows-949"));
		 out.println("테스트7:"+new String(prevKwd[i].getBytes("utf-8"), "iso-8859-1"));
		 
		 out.println("테스트8:"+new String(prevKwd[i].getBytes("iso-8859-1"), "euc-kr"));
		 out.println("테스트9:"+new String(prevKwd[i].getBytes("iso-8859-1"), "ksc5601"));
		 out.println("테스트0:"+new String(prevKwd[i].getBytes("iso-8859-1"), "x-windows-949"));
		 out.println("테스트11:"+new String(prevKwd[i].getBytes("iso-8859-1"), "iso-8859-1"));
		 out.println("테스트12:"+new String(prevKwd[i].getBytes("iso-8859-1"), "utf-8"));
		 
		 out.println("테스트13:"+new String(prevKwd[i].getBytes("euc-kr"), "utf-8"));
		 out.println("테스트14:"+new String(prevKwd[i].getBytes("euc-kr"), "ksc5601"));
		 out.println("테스트15:"+new String(prevKwd[i].getBytes("euc-kr"), "x-windows-949"));
		 out.println("테스트16:"+new String(prevKwd[i].getBytes("euc-kr"), "iso-8859-1"));
		 
		 out.println("테스트17:"+new String(prevKwd[i].getBytes("ksc5601"), "euc-kr"));
		 out.println("테스트18:"+new String(prevKwd[i].getBytes("ksc5601"), "utf-8"));
		 out.println("테스트19:"+new String(prevKwd[i].getBytes("ksc5601"), "x-windows-949"));
		 out.println("테스트20:"+new String(prevKwd[i].getBytes("ksc5601"), "iso-8859-1"));
		 
		 
		 
	 }
	 
%>
 
</html>