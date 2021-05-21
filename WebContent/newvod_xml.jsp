<?xml version="1.0" encoding="utf-8"?>
<%@ page contentType="text/html; charset=utf-8"%>

<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 

<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%
MediaManager mMgr = MediaManager.getInstance();

	Vector new_list0 = null;
	
	new_list0 = mMgr.getMediaListNew(12); //뉴스

 %>
 <NEW_LIST>
 
 <% 
		if (new_list0 != null && new_list0.size() > 0) {
			try {
			int i = 1;
			for (Enumeration e = new_list0.elements(); e.hasMoreElements(); i++) {
				com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

				String imgurl = "http://tv.suwon.go.kr/2013/include/images/default_img.jpg";
				String imgTmp = DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

				if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
					imgTmp = imgurl;
				}
%>
 
<NEW>
    <DATETIME><%=oinfo.getMk_date()%></DATETIME>
    <TITLE><![CDATA[<%=oinfo.getTitle()%>]]></TITLE>
    <CATE><![CDATA[<%=oinfo.getCtitle()%>]]></CATE>
    <TEXT><![CDATA[<%=oinfo.getContent_simple()%>]]>
    </TEXT>
    <IMG_LIST>
        <IMG>
            <URL><![CDATA[<%=imgTmp%>]]></URL>
        </IMG>
    </IMG_LIST>
    <EXT>
        <OUTLINK><![CDATA[http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>]]></OUTLINK>
        <COPYRIGHT><![CDATA[본 기사 및 동영상의 저작권은 수원iTV에 있습니다.]]></COPYRIGHT>
    </EXT>
</NEW>



<%
	}
		} catch (Exception e) {
			out.println("error message :" + e);
		}
	}
%>	
</NEW_LIST>

