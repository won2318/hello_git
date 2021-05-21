<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 

<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%
MediaManager mMgr = MediaManager.getInstance();

	Vector new_list0 = null;
	
	new_list0 = mMgr.getMediaListNew(3); //뉴스

 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
		<title>수원 iTV - 수원시 인터넷 방송입니다.</title>
		<link href="../css/style.css" rel="stylesheet" type="text/css" />
	</head>
<body>
<!-- wrap -->
<div class="section_new">
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
					imgTmp = "http://tv.suwon.go.kr/upload/vod_file/"+oinfo.getThumbnail_file();
				}
%>

	
		<li class="pic">
		<a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title="<%=oinfo.getTitle()%>" target="tv_suwon">
		<img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/>
		</a>
		</li>
		<li class="title"><a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title="<%=oinfo.getTitle()%>" target="tv_suwon"><%=oinfo.getTitle()%></a> </li>
	
<%
	}
		} catch (Exception e) {
			out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
		}
	}
%>	
 </ul>

	</div>
</body>
</html>