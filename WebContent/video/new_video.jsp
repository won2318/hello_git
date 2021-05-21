<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 

<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%
MediaManager mMgr = MediaManager.getInstance();

	Vector new_list0 = null;
	
	new_list0 = mMgr.getMediaListNew(5); //뉴스

 %>

<html>
<head>
<title>new_VIDEO_LIST</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script type="text/javascript" language="javascript" src="/include/skin/js/script.js"></script>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="outLink2">
<ul>

 <% 
		if (new_list0 != null && new_list0.size() > 0) {
			try {
			int i = 1;
			for (Enumeration e = new_list0.elements(); e.hasMoreElements(); i++) {
				com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

				String imgurl = "http://tv.suwon.go.kr/2013/include/images/noimg_small.gif";
				String imgTmp = DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

				if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
					imgTmp = imgurl;
				}
				if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
					imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
				}
%>
	<li>
		<span class="img"><a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title="<%=oinfo.getTitle()%>"><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
		<span class="total">
			<a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" class="main_weekly2"><%=oinfo.getTitle()%>sdfsdfsdfdsgwegawegaegersere</a>
			<span class="cate">[<%=oinfo.getMk_date()%>]</span>
		</span>
	</li>

<%
	}
		} catch (Exception e) {
			 out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
		}
	}
%>	
		 
	</ul>

<%
if (new_list0 == null || new_list0.size() <= 0) {
%>
	<ul>
		<li class="no">등록된 정보가 없습니다.</li>
	</ul>
<%	}	%>
	<!-- 동영상 이미지 끝 -->
 	 
</div>
<!-- order list view -->
 
</body>
</html>