<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*"%>

<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
 
 <%@ include file = "/include/chkLogin.jsp"%>
 <%

request.setCharacterEncoding("euc-kr");
String jspName = "video_list.jsp";

// java.util.Date day = new java.util.Date();
// SimpleDateFormat today_sdf = new SimpleDateFormat("yyyyMMdd");
// String today_string = today_sdf.format(day);

// long lCurTime = day.getTime();
// day = new java.util.Date(lCurTime+(1000*60*60*24*-1));
// String sYesterDay  = today_sdf.format(day);  

MediaManager mgr = MediaManager.getInstance();
Hashtable result_ht = null;


  
String ccode ="";
if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
}
int pg = NumberUtils.toInt(request.getParameter("_page_"), 1);
 
String searchField = "";		//검색 필드
String searchString = "";		//검색어
 

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "mk_date");
String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

int listCnt = 10;				//페이지 목록 갯수

if(request.getParameter("searchField") != null)
	searchField = com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchField"));

if(request.getParameter("searchString") != null)
	searchString = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchString")));

result_ht = mgr.getOMediaListAll_open2_cate(ccode,"V", order, searchField, searchString, pg, listCnt, direction, Integer.parseInt(vod_level));

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
    
int board_id = NumberUtils.toInt(request.getParameter("board_id"), 0);
 
%>
    <%@ include file = "../include/html_head.jsp"%>
    
	<div id="snb">
		<%@ include file = "../include/top_sub_menu.jsp"%>
		
	</div>
	
	<!-- container::메인컨텐츠 --><!-- containerS::서브컨텐츠 -->
	<div id="containerS">
		<div id="content">
			<div class="sectionS">
			<% if (ccode.contains("004001")) { %> 
					<span class="btn1"><a href="../board/board_list.jsp?board_id=11"><img src="../include/images/btn_register.gif" alt="등록하기"></a></span> 
			<%} else if (ccode.contains("004002")) { %>
					<span class="btn1"><a href="../board/board_list.jsp?board_id=13"><img src="../include/images/btn_register.gif" alt="등록하기"></a></span>
			<%} else if (ccode.contains("004003")) { %>
					<span class="btn1"><a href="../board/board_list.jsp?board_id=19"><img src="../include/images/btn_register.gif" alt="등록하기"></a></span>
			<% }%>
				<!-- vodList -->
				<div class="vodList">
					<!-- pin element 1 -->
<%
	//com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	int list = 0;
	if ( ibt != null && ibt.size() > 0){

		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<ibt.size()) ; i++, list++)
		{
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
			//String ocontents = oinfo.getDescription();
			String ocontents = oinfo.getContent_simple();
			String imgurl ="/2013/include/images/noimg_small.gif";
			String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_small/"+oinfo.getModelimage();
			
			String strTitle = oinfo.getTitle(); 
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
%>						
					<div class="pin">
					<%if ( i < 2) { %>
						<span class="new"><img src="../include/images/icon_new.png" alt="NEW"/></span>
					<%} %>
					<% if (oinfo.getCcode() != null && oinfo.getCcode().equals("004001001000")) {%>
						<span class="vj"><img src="../include/images/icon_vj.png" alt="VJ채택"/></span>
					 <%} %> 
						<span class="img"><a class="view_page" href="video_player.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playBig"></span><img src="<%=imgTmp %>" alt='<%=strTitle %>'/></a></span>
						<span class="total">
							<span class="day"><%=wdate %></span>
							<span class="title"><a class="view_page" href="video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle() %></a></span>
							<span class="subject"><%=ocontents %></span>
						</span>
						<span class="info">
							<span class="time"><%=oinfo.getPlaytime() %></span>
							<span class="recom"><%=oinfo.getRecomcount() %></span>
							<span class="view"><%=oinfo.getHitcount() %></span>
							<span class="reply"><%=oinfo.getMemo_cnt() %></span>
						</span>
					</div>
<%
			}
		}
	}else{
		%>
					<div class="pin">						 
						<span class="img"></span>
						<span class="total">
							<span class="day"></span>
							<span class="title">등록된 정보가 없습니다.</span>
							<span class="subject"> </span>
						</span>
						 
					</div>
		<%
	}
%>	 				
				</div>	
				<!--  page -->
				<%if(ibt != null && ibt.size()>0){ %>	
				<form name="form1" method="post" >
				 
					<input type="hidden" name="_page_" value="<%=pg%>" />
					<input type="hidden" name="searchField" value="<%=searchField%>" />
					<input type="hidden" name="searchString" value="<%=searchString%>" />
				</form>
				<%@ include file = "./hs_list.jsp"%>
				<%} %>
			</div>
		</div>

		<%@ include file = "../include/right_menu.jsp"%>
		
	</div>
 <%@ include file = "../include/html_foot.jsp"%>