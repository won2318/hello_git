<?xml version="1.0" encoding="utf-8"?>
<%@ page contentType="text/html; charset=utf-8"%>

<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 

<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%

 
String SilverLightPath = com.vodcaster.sqlbean.DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media";
 
BestMediaManager Best_mgr = BestMediaManager.getInstance();	
Vector vtBts_1 = new Vector();
vtBts_1 = Best_mgr.getBestTopSubList_order(1, 7); 
Vector main_list =new Vector();  
 
 %>
 <NEW_LIST>
 <%
 
 if (vtBts_1 != null && vtBts_1.size() > 0) {
	 try {
		int cnt = 1;
		System.out.println(vtBts_1.toString());
		for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++) {
			com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
			 			String imgTmp = "http://tv.suwon.go.kr/2017/include/images/noimg_small.gif";
						 
						if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
							imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();
						}  
						if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
							imgTmp = "http://tv.suwon.go.kr/upload/vod_file/"+oinfo.getThumbnail_file();
						}
						String strTitle = oinfo.getTitle();
						strTitle = strTitle.length()>26?strTitle.substring(0,26)+"...":strTitle;
 
						String cate = oinfo.getCtitle();
 
						if (cnt==4 || cnt == 5) { // 메인 4, 5번
						
%>
 <NEW>
    <DATETIME><%=oinfo.getMk_date()%></DATETIME>
    <TITLE><![CDATA[<%=strTitle%>]]></TITLE>
    <CATE><![CDATA[<%=cate%>]]></CATE>
 
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
<%						}
 
		}
		 } catch (Exception e) {
			 out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
		}
	} 
 
%>
</NEW_LIST>

