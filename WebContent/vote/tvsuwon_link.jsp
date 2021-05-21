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
	
	new_list0 = mMgr.getMediaListNew(4); //�ֽ� ���� 

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta name="keywords" content="������û, ���Ҿ��� �ູ�� ����, ������, ���Ǽ�������, Happy Suwon" />
	<meta name="description" content="������ ���ͳ� ��۱�" />
	<title>���� iTV</title>
	<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="container">

<div class="listBox suwonTv">
	<h2><img src="../css/tit_hsb.gif" alt="���� iTV"  /></h2>
	<p class="more"><a href="http://tv.suwon.go.kr/" target="_blank">������</a></p>
	<ul class="photoBox">
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
			<a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title='<%=oinfo.getTitle()%>' target="tv_suwon"><img alt="<%=oinfo.getTitle()%>" src="<%=imgTmp%>" /></a>
			<h3><a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title='<%=oinfo.getTitle()%>' target="tv_suwon"><%=oinfo.getTitle()%></a></h3>
		</li>
<%
	}
		} catch (Exception e) {
			out.println("������ �߻� �Ͽ����ϴ�. �����ڿ��� ���� �ּ���");
		}
	}
%>	
		
	</ul>
</div>
					
</div>
</body>
</html>