<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.news.*"%>
 
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@page import="com.yundara.util.TextUtil"%>
 
<jsp:useBean id="btsBean" class="com.vodcaster.sqlbean.BestTopSubBean" scope="page" />
 
<jsp:useBean id="LiveSqlBean" class="com.hrlee.sqlbean.LiveSqlBean" scope="page"/>
 <jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%@ include file="/include/chkLogin.jsp"%>

<%
	ArticleManager mgr = ArticleManager.getInstance(); 
	MediaManager mgr_vod = MediaManager.getInstance();
	BestMediaManager Best_mgr = BestMediaManager.getInstance();

Vector vtBts = new Vector(); 
Vector new_list1 = new Vector();
 
//new_list1 = mgr_vod.getMediaListCode("001000000000",3);  //최신 영상 (뉴스 카테고리)
new_list1 = mgr_vod.getMediaListNew(3);  //최신 영상 (뉴스 카테고리)

vtBts = Best_mgr.getBestTopSubList_order(2, 3); // 추천 영상

%> 

<%@ include file = "../include/head.jsp"%></div>
<div id="container"> 
	<div class="major">
	<section>
		<div class="mNewsList">
			<h3>주요뉴스</h3>
			<ul>
<% 
Vector vt2 = mgr.getArticleList_main("0101", 0, 5);

	String title = "";
	String idx = "";
	String img = "";
	
	if(vt2 != null && vt2.size() > 0){
		for(int i=0; i<vt2.size(); i++){
			Hashtable ht = (Hashtable)vt2.get(i);
			
			idx = String.valueOf(ht.get("idx"));
			title = String.valueOf(ht.get("title")).replace("\\", "");
			img = String.valueOf(ht.get("img_file1"));
			
			if(img != null && img.length() > 0 && img.lastIndexOf(".") > 0){
				img = "http://news.suwon.ne.kr/upload"+img; 
			}else{
				img = "/include/images/simbol.gif";
			}
%>
				<li><a href="javascript:link_colorbox('news_view.jsp?idx=<%=idx%>&menu_id=0101');"><%=title%></a></li>			
<%	
		}
	}	
%>
	 
			</ul>
		</div>
		<div class="mVodList">
			<h3>최신영상</h3>
			<ul>
			
				<% 
							if (new_list1 != null && new_list1.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list1.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "../include/images/noimg.gif";
									String imgTmp = SilverLightPath + "/ClientBin/Media/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
											imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
				%>
 
		 			<li>
						<a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=oinfo.getOcode() %>')">
							<span class="img"><img src="<%=imgTmp%>" width="100%" alt="<%=oinfo.getTitle()%>"/></span>
							<span class="title"><%=oinfo.getTitle()%></span>
						</a>
					</li>

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>	 
		</ul>
		</div>
		<div class="mVodList">
			<h3>추천영상</h3>
			<ul>
<% 
 	 		int cnt = 1;
			for (Enumeration e = vtBts.elements(); e.hasMoreElements(); cnt++ ) {
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mgr_vod.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
						
							String imgurl ="../include/images/noimg.gif";
							String imgTmp = SilverLightPath + "/ClientBin/Media/"+oinfo.getSubfolder()+"/thumbnail/_small/"+oinfo.getModelimage();
							String strTitle = oinfo.getTitle();
							strTitle = strTitle.length()>10?strTitle.substring(0,8)+"...":strTitle;
							
							String strContent = oinfo.getDescription();
							strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
							
							if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
								imgTmp = imgurl;
							}
							if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
									imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
							}
%> 
 
						<li>
							<a href="javascript:link_colorbox('vod_view.jsp?ocode=<%=oinfo.getOcode()%>');">
							<span class="img"><img src="<%=imgTmp %>" width="100%" alt="<%=oinfo.getTitle()%>"/></span>
							<span class="title"><%=oinfo.getTitle()%></span>
							</a>
						</li>
						
<%							
						} catch (Exception best_e) {
							out.println("error message :"+best_e);
						}
					}
			}
%> 
			 
			</ul>
		</div>
	</section>
	</div>

</div> 
<%@ include file = "../include/foot.jsp"%>
</body>
</html>