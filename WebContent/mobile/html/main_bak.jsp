<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>

 
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@page import="com.yundara.util.TextUtil"%>
 
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />

<%@ include file = "../include/head.jsp"%>
<% 
MediaManager mgr_vod = MediaManager.getInstance();
BestMediaManager Best_mgr = BestMediaManager.getInstance();

Vector new_list6 = new Vector();
new_list6 = mgr_vod.getMediaListNew(7);  //최신 영상 (뉴스 카테고리) 
 
Vector vtBts_1 = new Vector();
vtBts_1 = Best_mgr.getBestTopSubList_order(1, 5); // 오늘의 주요 영상  bti_id = 1, limit = 7

//공지사항
Vector noticeVt1 = blsBean.getRecentBoardList_open_top(10, 1); // 공지 (board_id, limit)


%> 


		<section>
			<div id="container">
				<div class="visual">
					<h2><span class="hide_txt">추천영상</span></h2>
					<div id="touchSlider">
						<ul>
<%						
if (vtBts_1 != null && vtBts_1.size() > 0) {
	int cnt = 1;
	for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++) {
		com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
		 			String imgTmp = "/include/images/noimg_small.gif";
					 
					if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
						imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
					}  
					if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
						imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
					}
					String strTitle = oinfo.getTitle();
					//strTitle = strTitle.length()>16?strTitle.substring(0,16)+"...":strTitle;
					
					String strContent = oinfo.getDescription();
					strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
%>
							<li>
								<a href="vod_view.jsp?ocode=<%=oinfo.getOcode() %>">
									<img src="<%=imgTmp%>"/>
									<span class="data">
										<h3><%=strTitle %></h3>
										<span><%=oinfo.getMk_date() %></span>
									</span>
								</a>
							</li>
<%					 
	}
} 
%>													
						</ul>
						
					</div>
					<div class="btn_area">
						<a class="btn_page"></a>
					</div>
					
				</div><!--//메인 이미지:visual-->
<!-- 				<div class="mLive"> -->
<!-- 					<a href=""><span class="onair">ON-AIR</span><span class="live_time">07:50~</span><strong>2017년 4월의 만남만남만남만남만남만남만남만만남만남만남만남만남만남만남만남만남만남만남만남만남만남남만남만남만남만남만남만남</strong></a> -->
<!-- 				</div>//생방송안내(생방송이 있을때만 표출:mLive -->
				<%@ include file = "../include/live_check.jsp"%>
				<div class="mVodList">
					<h2>최신영상</h2>
					<ul>
					<% 
							if (new_list6 != null && new_list6.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list6.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgurl = "/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
 	 
					%> 	  
							<li>	
								<a href="vod_view.jsp?ocode=<%=oinfo.getOcode() %>">
									<img src="<%=imgTmp %>"/>
									<span class="data">
										<h3><%=oinfo.getTitle() %></h3>
										<span><%=oinfo.getMk_date() %></span>
									</span>
								</a>
							</li>
					<% 	 
						}
							} catch (Exception e) {
								 
								 out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
							}
						}
					%>
					</ul>
				</div><!--//최신영상:mVodList-->
			</div>
			<div class="mNotice">
			 <%
				if (noticeVt1 != null && noticeVt1.size() > 0) {
						String list_title = "";
						String list_date = "";
						String list_contents = "";
						int cnt_notice = 0;
						try {
							for (Enumeration e = noticeVt1.elements(); e.hasMoreElements();) {
								com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement());
								cnt_notice ++;
 				%>  
					<h3>공지</h3>
					<a href="board_view.jsp?board_id=<%=bliBean.getBoard_id()%>&list_id=<%=bliBean.getList_id()%>"><%=bliBean.getList_title() %></a>
				<% 
 							}
						} 
						catch (Exception e) {
						}
					} 
				%>					
				 
			</div><!--//공지사항:mNotice-->
		</section><!--//콘텐츠부분:section-->    
		
<%@ include file = "../include/foot.jsp"%>