<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.hrlee.sqlbean.MediaManager"%>

<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /> 

 <%@ include file = "/include/chkLogin.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
String jspName = "vod_cate_list.jsp";

Hashtable result_ht = null;

MediaManager mgr = MediaManager.getInstance(); 
  
String ccode ="";
if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
}
int pg = NumberUtils.toInt(request.getParameter("_page_"), 1);
 
String searchField = "";		//검색 필드
String searchString = "";		//검색어
 

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "mk_date");
String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

int listCnt = 5;				//페이지 목록 갯수

if(request.getParameter("searchField") != null)
	searchField = com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchField"));

if(request.getParameter("searchString") != null)
	searchString = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchString")));

result_ht = mgr.getOMediaListAll_open2_cate(ccode,"V", order, searchField, searchString, pg, listCnt, direction, Integer.parseInt(vod_level));

CategoryManager mgr_cate = CategoryManager.getInstance();
String categoryOneName = mgr_cate.getCategoryOneName(ccode, "V");


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
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="../include/css/default.css" />
	<link rel="stylesheet" type="text/css" href="../include/css/content.css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	
	<script>
function go_VideoView(ccode, ocode) {
	parent.document.getElementById("video_player").src = "video_player.jsp?ccode="+ccode+"&ocode="+ocode;
}
	</script>
</head>
<body>

								<div class="vodList">
								<h3><%=categoryOneName%></h3>
								<span class="pageSort"><span>Total<strong> <%=iTotalRecord %> </strong>&nbsp;&nbsp;&nbsp;&nbsp;Page <strong><%=pg %>/<%=iTotalPage%></strong></span></span>
								<ul>
<%
	//com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	int list = 0;
	if ( ibt != null && ibt.size() > 0){

		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<ibt.size()) ; i++, list++)
		{
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
			//String ocontents = oinfo.getDescription();
			String ocontents = oinfo.getContent_simple();
			String imgurl ="/2017/include/images/noImg.gif";
			String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_small/"+oinfo.getModelimage();
			
			String strTitle =  com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(), false);
			strTitle = strTitle.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r","");
			if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
				imgTmp = imgurl;
			}
			if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
				imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
			}
     		if((ocontents != null) &&   !ocontents.equals("")) {
				ocontents = ocontents.length() <= 100 ? ocontents : ocontents.substring(0, 98) + "..";
				ocontents = ocontents.replaceAll("<p>","").replaceAll("</p>","").replaceAll("<P>","").replaceAll("</P>","");
			}
 			String wdate = "";
			if(oinfo.getOcode() != null && oinfo.getOcode().length()>0){
				
				wdate = oinfo.getMk_date();
				String temp_ocode = oinfo.getOcode().substring(0,8);
				double dA = Double.parseDouble(oinfo.getOcode());
				
				double dFrom = Double.parseDouble("20131226102100000");
				if(dA > dFrom){
					 imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_medium/"+oinfo.getModelimage();
					 if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
							imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
					 }
				}
%>					 				<li class="num">
										<a href="javascript:go_VideoView('<%=oinfo.getCcode()%>','<%=oinfo.getOcode()%>')">
											<span class="img"><img src="<%=imgTmp %>" alt='<%=strTitle %>'/></span>
											<span class="total">
												<h4><%=oinfo.getTitle() %></h4>
												<i class="i_play"><%=oinfo.getHitcount() %></i><i class="i_like"><%=oinfo.getRecomcount() %></i>
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
									<input type="hidden" name="searchField" value="<%=searchField%>" />
									<input type="hidden" name="searchString" value="<%=searchString%>" />
								</form>
								<%@ include file = "./hs_list.jsp"%>
								<%} %>
								
								</div>
</body>
</html>								