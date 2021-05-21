<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>

 <%@ include file = "/include/chkLogin.jsp"%>
 
<jsp:useBean id="oinfo_new" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /> 
 
	<%
	request.setCharacterEncoding("euc-kr");
 
	Hashtable result_ht = null;
	
	int pg = NumberUtils.toInt(request.getParameter("_page_"), 1);
	 
	int listCnt = 5;				//페이지 목록 갯수

MediaManager mgr_new = MediaManager.getInstance(); 
	
//Vector new_list6 = mgr_new.getMediaList_count_order_not("001","ocode", 6); // 최신 영상
result_ht = mgr_new.getMediaListNew_page( pg, listCnt);// 최신 영상
//out.println(new_list6);

Vector ibt = null;
com.yundara.util.PageBean pageBean = null;

int iTotalPage = 0;
int iTotalRecord = 0;
if(result_ht != null && !result_ht.isEmpty() && result_ht.size() > 0){
	ibt = (Vector)result_ht.get("LIST");
	if(ibt != null && ibt.size()>0){
		pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		iTotalRecord = pageBean.getTotalRecord();
		iTotalPage = pageBean.getTotalPage();

	}
}

%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta NAME="title" content="수원 iTv" />
	<title>수원인터넷방송</title>
	<link rel="stylesheet" type="text/css" href="../include/css/default.css" />
	<link rel="stylesheet" type="text/css" href="../include/css/content.css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	
	<script>
function go_VideoView(ccode, ocode) {
	//parent.document.getElementById("video_player").src = "video_player.jsp?ccode="+ccode+"&ocode="+ocode;
	top.location.href = "/2017/video/video_list.jsp?ccode="+ccode+"&ocode="+ocode;
 
}
	</script>
</head>
<body>

						 
								<div class="vodList">
								<span class="pageSort"><span>Total<strong> <%=iTotalRecord %> </strong>&nbsp;&nbsp;&nbsp;&nbsp;Page <strong><%=pg %>/<%=iTotalPage%></strong></span></span>
								<ul> 
									
							<%
	//com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	int list = 0;
	if ( ibt != null && ibt.size() > 0){

		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<ibt.size()) ; i++, list++)
		{
			com.yundara.beans.BeanUtils.fill(oinfo_new, (Hashtable)ibt.elementAt(list));
			//String ocontents = oinfo_new.getDescription();
			String ocontents = oinfo_new.getContent_simple();
			String imgurl ="/2017/include/images/noImg.gif";
			String imgTmp = SilverLightPath + "/"+oinfo_new.getSubfolder()+"/thumbnail/_small/"+oinfo_new.getModelimage();
			
			String strTitle =  com.vodcaster.utils.TextUtil.text_replace(oinfo_new.getTitle(), false);
			strTitle = strTitle.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r","");
			if(oinfo_new.getModelimage()== null || oinfo_new.getModelimage().length() <=0 ||oinfo_new.getModelimage().equals("null")) {
				imgTmp = imgurl;
			}
			if (oinfo_new.getThumbnail_file() != null && oinfo_new.getThumbnail_file().indexOf(".") > 0) {
				imgTmp = "/upload/vod_file/"+oinfo_new.getThumbnail_file();
			}
     		if((ocontents != null) &&   !ocontents.equals("")) {
				ocontents = ocontents.length() <= 100 ? ocontents : ocontents.substring(0, 98) + "..";
				ocontents = ocontents.replaceAll("<p>","").replaceAll("</p>","").replaceAll("<P>","").replaceAll("</P>","");
			}
 			String wdate = "";
			if(oinfo_new.getOcode() != null && oinfo_new.getOcode().length()>0){
				
				wdate = oinfo_new.getMk_date();
				String temp_ocode = oinfo_new.getOcode().substring(0,8);
				double dA = Double.parseDouble(oinfo_new.getOcode());
				
				double dFrom = Double.parseDouble("20131226102100000");
				if(dA > dFrom){
					 imgTmp = SilverLightPath + "/"+oinfo_new.getSubfolder()+"/thumbnail/_medium/"+oinfo_new.getModelimage();
					 if (oinfo_new.getThumbnail_file() != null && oinfo_new.getThumbnail_file().indexOf(".") > 0) {
							imgTmp = "/upload/vod_file/"+oinfo_new.getThumbnail_file();
					 }
				}
%>					 				<li class="num">
										<a href="javascript:go_VideoView('<%=oinfo_new.getCcode()%>','<%=oinfo_new.getOcode()%>')">
											<span class="img"><img src="<%=imgTmp %>" alt='<%=strTitle %>'/></span>
											<span class="total">
												<h4><%=oinfo_new.getTitle() %></h4>
												<i class="i_play"><%=oinfo_new.getHitcount() %></i><i class="i_like"><%=oinfo_new.getRecomcount() %></i>
											</span>	
										</a>
									</li>
									
<%
			}
		}
	}else{
		%>
 
									<li class="num">
										<a href="">
											<span class="img"><img src="../include/images/noImg.png" alt="이미지명"/></span>
											<span class="total">
												<h4>등록된 정보가 없습니다.</h4>
											</span>	
										</a>
									</li>
		<%
	}
%>
								
								</ul>
 
								<%if(ibt != null && ibt.size()>0){ %>	
								<form name="form1" method="post" >
									<input type="hidden" name="_page_" value="<%=pg%>" />
								 
								</form>
								<%
    

    if (pageBean.getTotalRecord() > pageBean.getLinePerPage()) {
%>
<script language="JavaScript">
<!--
function goPage(page)
{
	var path_='right_new_video_iframe.jsp';
	document.form1._page_.value=page;
	document.form1.action=path_;
	document.form1.submit();
}


// -->
</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
</noscript>
 
<span class="paginate">

    <%  if (pageBean.getCurrentPage() != 1) { %>
			<a href="javascript:goPage('1');" class="back1" title="첫페이지"><img src="../include/images/icon_back2.gif" alt="첫페이지" /></a>
	<% } %>

	<% if (pageBean.getCurrentBlock() != 1) { %>
			<a href="javascript:goPage('<%=((pageBean.getCurrentBlock()-2)*pageBean.getPagePerBlock()+1)%>');" class="back2" title="이전페이지"><img src="../include/images/icon_back1.gif" alt="이전페이지" /></a>

	<%
		} // the end of if statement
	%>


	<%
			for (int b=pageBean.getStartPage(); b<=pageBean.getEndPage(); b++) {
				if (b != pageBean.getCurrentPage()){
	%>
				<a href="javascript:goPage('<%= b %>');"><%=b%></a>
	<%
				}else{
	%>
				<strong><%= b %></strong>
	<%
				} // the end of else statement
			} // the end of for statement
	%>

	<%
			if ( (pageBean.getCurrentBlock()/(pageBean.getPagePerBlock()+0.0)) < (pageBean.getTotalBlock()/(pageBean.getPagePerBlock()+0.0)) ) {
	%>
			<a href="javascript:goPage('<%= pageBean.getCurrentBlock()*pageBean.getPagePerBlock()+ 1%>');"  class="next1" title="다음페이지"><img src="../include/images/icon_next1.gif" alt="다음페이지" /></a>

	<%
			}
	%>

	<%
			if (pageBean.getCurrentPage() < pageBean.getTotalPage()) {
	%>
			<a href="javascript:goPage('<%= pageBean.getTotalPage() %>');" class="next2" title="마지막페이지"><img src="../include/images/icon_next2.gif" alt="마지막페이지" /></a>

	<%
			}
	%>

</span>
<%
	}
%>
<!-- ----------------------------------- -->
<!--	// 0. 링크 연결 끝                -->
<!-- ----------------------------------- -->
								<%} %>
								
								</div>
							
</body>
</html>									