<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
	
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="oinfo_best" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" /> 	

 
<%
MediaManager mgr_best = MediaManager.getInstance(); 

Vector new_week = mgr_best.getMediaList_count_week("","hitcount", 5); // 주간
Vector new_month = mgr_best.getMediaList_count_month("","hitcount", 5); // 월간 영상
Vector new_year = mgr_best.getMediaList_count_year("","hitcount", 5); // 년간 영상

%>					
					<div class="NewTab list5">
						<ul>
							<li class="active"><a href="#"><span>주간 Best</span></a>
								<div>
									<ul>
									
									<% 
							if (new_week != null && new_week.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_week.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo_best,(Hashtable) e.nextElement());
									String imgurl = "/2017/include/images/noImg.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo_best.getSubfolder() + "/thumbnail/_medium/" + oinfo_best.getModelimage();
									if (oinfo_best.getModelimage() == null || oinfo_best.getModelimage().length() <= 0 || oinfo_best.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo_best.getThumbnail_file() != null && oinfo_best.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo_best.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo_best.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo_best.getCtitle(); 
									if (oinfo_best.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									} 
								 
					%> 	 
 
									<li class="<%if (i == 1){ out.print("numS");} else {out.print("num");} %>">
										<a href="/2017/video/video_list.jsp?ccode=<%=oinfo_best.getCcode()%>&ocode=<%=oinfo_best.getOcode()%>">
											<span class="number"><%=i%></span>
											<span class="img"><img src="<%=imgTmp %>" alt='<%=title%>'/></span>
											<%if (i == 1){ %>											 
												<h4><%=oinfo_best.getTitle() %></h4>												 
											<% } else { %>
											<span class="total">
												<h4><%=oinfo_best.getTitle() %></h4>
												<i class="i_play"><%=oinfo_best.getHitcount() %></i><i class="i_like"><%=oinfo_best.getRecomcount() %></i>
											</span>
											<%} %> 
											
												
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
								</div>
							</li>
							<li><a href="#"><span>월간 Best</span></a>
								<div>
									<ul>
								 
									 
					<% 
							if (new_month != null && new_month.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_month.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo_best,(Hashtable) e.nextElement());
									String imgurl = "/2017/include/images/noImg.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo_best.getSubfolder() + "/thumbnail/_medium/" + oinfo_best.getModelimage();

									if (oinfo_best.getModelimage() == null || oinfo_best.getModelimage().length() <= 0 || oinfo_best.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo_best.getThumbnail_file() != null && oinfo_best.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo_best.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo_best.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo_best.getCtitle(); 
									if (oinfo_best.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									} 
								 
					%> 	 
					
									<li class="<%if (i == 1){ out.print("numS");} else {out.print("num");} %>">
										<a href="/2017/video/video_list.jsp?ccode=<%=oinfo_best.getCcode()%>&ocode=<%=oinfo_best.getOcode()%>">
											<span class="number"><%=i%></span>
											<span class="img"><img src="<%=imgTmp %>" alt='<%=title%>'/></span>
											<%if (i == 1){ %>											 
												<h4><%=oinfo_best.getTitle() %></h4>												 
											<% } else { %>
											<span class="total">
												<h4><%=oinfo_best.getTitle() %></h4>
												<i class="i_play"><%=oinfo_best.getHitcount() %></i><i class="i_like"><%=oinfo_best.getRecomcount() %></i>
											</span>
											<%} %> 
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
								</div>
							</li>
							<li><a href="#"><span>연간 Best</span></a>
								<div>
									<ul>
<% 
							if (new_year != null && new_year.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_year.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo_best,(Hashtable) e.nextElement());
									String imgurl = "/2017/include/images/noImg.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo_best.getSubfolder() + "/thumbnail/_medium/" + oinfo_best.getModelimage();

									if (oinfo_best.getModelimage() == null || oinfo_best.getModelimage().length() <= 0 || oinfo_best.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo_best.getThumbnail_file() != null && oinfo_best.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo_best.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo_best.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","");
									String temp_ctitle = oinfo_best.getCtitle(); 
									if (oinfo_best.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									} 
							 
					%> 	 
 
									<li class="<%if (i == 1){ out.print("numS");} else {out.print("num");} %>">
										<a href="/2017/video/video_list.jsp?ccode=<%=oinfo_best.getCcode()%>&ocode=<%=oinfo_best.getOcode()%>">
											<span class="number"><%=i%></span>
											<span class="img"><img src="<%=imgTmp %>" alt='<%=title%>'/></span>
											<%if (i == 1){ %>											 
												<h4><%=oinfo_best.getTitle() %></h4>												 
											<% } else { %>
											<span class="total">
												<h4><%=oinfo_best.getTitle() %></h4>
												<i class="i_play"><%=oinfo_best.getHitcount() %></i><i class="i_like"><%=oinfo_best.getRecomcount() %></i>
											</span>
											<%} %> 
										</a> 
									</li>
		   
					<%
							 
						}
							} catch (Exception e) {
								//out.println("error message :" + e);
								out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
							}
						}
					%>
														
									 
									</ul>
								</div>
							</li>
						</ul>
					</div><!--//NewTab list5-->