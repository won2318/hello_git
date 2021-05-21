<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="oinfo_new" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /> 
 
	<%
MediaManager mgr_new = MediaManager.getInstance(); 
	
//Vector new_list6 = mgr_new.getMediaList_count_order_not("001","ocode", 6); // 최신 영상
Vector new_list6 = mgr_new.getMediaListNew(6);// 최신 영상
//out.println(new_list6);
%>							
							<li <% if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && ( request.getRequestURI().indexOf("video_list.jsp") < 0) ) { out.print(" class='active' ");} %>>
							<a href="#"><span>최신영상</span></a>
								<div>
								<ul> 
									
							<% 
							if (new_list6 != null && new_list6.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list6.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo_new,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo_new.getSubfolder() + "/thumbnail/_medium/" + oinfo_new.getModelimage();
									if (oinfo_new.getModelimage() == null || oinfo_new.getModelimage().length() <= 0 || oinfo_new.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo_new.getThumbnail_file() != null && oinfo_new.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo_new.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo_new.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo_new.getCtitle(); 
									if (oinfo_new.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									}								 
					%> 	  
							<li class="num">
										<a href="/2017/video/video_list.jsp?ccode=<%=oinfo_new.getCcode()%>&ocode=<%=oinfo_new.getOcode()%>">
											<span class="img"><img src="<%=imgTmp %>" alt='<%=title%>'/></span>
											<span class="total">
												<h4><%=oinfo_new.getTitle() %></h4>
												<i class="i_play"><%=oinfo_new.getHitcount() %></i><i class="i_like"><%=oinfo_new.getRecomcount() %></i>
											</span>	
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
							</li>