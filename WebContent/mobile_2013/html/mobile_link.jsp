<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/html; charset=UTF-8"%> 
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%><%  
String ocode = ""; 
if(request.getParameter("ocode") == null || request.getParameter("ocode").length()<=0 || request.getParameter("ocode").equals("null")) {
	//out.println("<script lanauage='javascript'>alert('미디어코드가 없습니다. 다시 선택해주세요.'); self.close(); </script>");
} else
	ocode = request.getParameter("ocode");
  
com.hrlee.sqlbean.MediaManager mgr = com.hrlee.sqlbean.MediaManager.getInstance();
	Vector vt = mgr.getOMediaInfo_cate(ocode);			// 주문형미디어 서브정보
	com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();
	if(vt != null && vt.size()>0){
		
		try {
			Enumeration e = vt.elements();
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
 			ocode = info.getOcode();
%>	
<values>
<% if (info.getMediumfilename() != null && info.getMediumfilename().length() > 0) { %>
<high>rtsp://<%=DirectoryNameManager.SV_LIVE_SERVER_IP %>:1935/newsuwon/_definst_/mp4:<%=info.getSubfolder() %>/<%= info.getMediumfilename()%></high>
<%} if (info.getMobilefilename() != null && info.getMobilefilename().length() > 0) { %>
<low>rtsp://<%=DirectoryNameManager.SV_LIVE_SERVER_IP %>:1935/newsuwon/_definst_/mp4:<%=info.getSubfolder() %>/<%= info.getMobilefilename()%></low>		    
<%} %>
</values>
 <%
 		} catch (Exception e) {
			//out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.');self.close(); </script>");
		}
	}else{
		//out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.'); self.close(); </script>");
	} 
%>