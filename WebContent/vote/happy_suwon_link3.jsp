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
	
	new_list0 = mMgr.getMediaListNew(2); //뉴스

 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE> 수원 iTV - 수원시 인터넷 방송입니다. </TITLE>
 <link href="../css/style.css" rel="stylesheet" type="text/css" />

 <BODY>

 <div class="outLink3"> 
	<h2><img src="../css/link_happysuwon.gif" alt="수원 iTV"  /></h2>
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

				
					<li>
						<span class="img"><a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title="<%=oinfo.getTitle()%>"><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
						<span class="total"><a href="http://<%=request.getServerName()%>/index_link.jsp?ocode=<%=oinfo.getOcode()%>" title="<%=oinfo.getTitle()%>"><%=oinfo.getTitle()%></a></span>
					</li>
				
<%
	}
		} catch (Exception e) {
			out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
		}
	}
%>	
			</ul>
		</div>

 </BODY>
</HTML>