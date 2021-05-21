<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 

 <%
 
/////////////////////////////////////
//bestTop (관리자 지정 영상/ 화재의 영상, 명예의 전당, hot뉴스)
BestMediaManager sub_Best_mgr = BestMediaManager.getInstance();
MediaManager mMgr = MediaManager.getInstance();
 
Vector vtBts_1 = new Vector();
 
vtBts_1 = sub_Best_mgr.getBestTopSubList_order(2, 4); // 화재의 영상
 
com.hrlee.silver.OrderMediaInfoBean sub_topic = new com.hrlee.silver.OrderMediaInfoBean();
com.vodcaster.sqlbean.BestTopSubBean sub_bstBean = new com.vodcaster.sqlbean.BestTopSubBean();
 
 %>
 
 <div class="topic">
				<h4>화제의 영상</h4>
				<ul class="pList">
				
<% 					
			if (vtBts_1 != null && vtBts_1.size() > 0) {
 			String list_img = "/include/skin/images/noimage.gif";

			int cnt = 1;
			for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++ ) {
				com.yundara.beans.BeanUtils.fill(sub_bstBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo(String.valueOf(sub_bstBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(sub_topic,(Hashtable) best_e.nextElement());
						
							String imgurl ="/vodman/include/images/no_img01.gif";
							String imgTmp = SilverLightPath + "/"+sub_topic.getSubfolder()+"/thumbnail/_small/"+sub_topic.getModelimage();
							if (sub_topic.getThumbnail_file() != null && sub_topic.getThumbnail_file().indexOf(".") > 0) {
								imgTmp = "/upload/vod_file/"+sub_topic.getThumbnail_file();
							}
							String strTitle = sub_topic.getTitle();
							strTitle = strTitle.length()>10?strTitle.substring(0,8)+"...":strTitle;
							
							String strContent = sub_topic.getDescription();
							strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
							
							if(sub_topic.getModelimage()== null || sub_topic.getModelimage().length() <=0 ||sub_topic.getModelimage().equals("null")) {
								imgTmp = imgurl;
							}
%>				
					<li>
						<span class="img"><a href="/2013/video/video_player.jsp?ocode=<%=sub_topic.getOcode()%>"><span class="playPop"></span><img src="<%=imgTmp %>" alt="<%=sub_topic.getTitle()%>"/></a></span>
						<span class="total">
							<span class="cate"><a href="/2013/video/video_player.jsp?ocode=<%=sub_topic.getOcode()%>"><%=sub_topic.getCtitle() %></a></span>
							<a href="/2013/video/video_player.jsp?ocode=<%=sub_topic.getOcode()%>"><%=sub_topic.getTitle()%></a>
						</span>
					</li>
					
<%							
						} catch (Exception best_e) {
							out.println("error message :"+best_e);
						}
					}
			}

		} 			
%>	
 
				</ul>
			</div>
	