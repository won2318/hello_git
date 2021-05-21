<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 

 <%
 
	Vector noticeVt1 = blsBean.getRecentBoardList_open(10, 5); // 공지 (board_id, limit)
	Vector noticeVt2 = blsBean.getRecentBoardList_open(16, 5); // 제작노트 (board_id, limit)
	
	Vector new_list5 = mgr.getMediaList_count_order("001","ocode", 10); // 최신 뉴스
	Vector new_list6 = mgr.getMediaList_count_order_not("001","ocode", 10); // 최신 영상
	
	Vector new_week = mgr.getMediaList_count_week("","hitcount", 10); // 주간
	Vector new_month = mgr.getMediaList_count_month("","hitcount", 10); // 월간 영상
	Vector new_year = mgr.getMediaList_count_year("","hitcount", 10); // 년간 영상
	
 %>
	<script language="JavaScript" type="text/JavaScript">


		function overimg1(imgsrc, ocode, title, ctitle,number){
		 
			
 			var obj = document.getElementById('test_id1');
			obj.innerHTML = 
			"<div id='testid1'>"+
			"<span class='time'><img src='../include/images/icon_best"+number+".gif' alt='"+number+"'/></span>"+
			"<span class='img'><a  href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\"><span class='playMid'></span>"+
			"<img src='"+imgsrc+"' alt='"+title+"' /></a></span>"+
			"<span class='total'>"+
			"<span class='cate'><a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"');\">"+ctitle+"</a></span>"+
			"<a  href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"');\">"+title+"</a>"+	
			"</span>	"+	
			"</div>"; 
		   
		}
		function overimg2(imgsrc, ocode, title, ctitle,number){
 			var obj = document.getElementById('test_id2');
			obj.innerHTML = 
			"<div id='test_id2'>"+
			"<span class='time'><img src='../include/images/icon_best"+number+".gif' alt='"+number+"'/></span>"+
			"<span class='img'><a  href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\"><span class='playMid'></span>"+
			"<img src='"+imgsrc+"' alt='"+title+"' /></a></span>"+
			"<span class='total'>"+
			"<span class='cate'><a  href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\">"+ctitle+"</a></span>"+
			"<a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\"'>"+title+"</a>"+	
			"</span>	"+	
			"</div>"; 
		   
		}
		function overimg3(imgsrc, ocode, title, ctitle,number){
 			var obj = document.getElementById('test_id3');
			obj.innerHTML = 
			"<div id='testid3'>"+
			"<span class='time'><img src='../include/images/icon_best"+number+".gif' alt='"+number+"'/></span>"+
			"<span class='img'><a  href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\"><span class='playMid'></span>"+
			"<img src='"+imgsrc+"' alt='"+title+"' /></a></span>"+
			"<span class='total'>"+
			"<span class='cate'><a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\">"+ctitle+"</a></span>"+
			"<a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\">"+title+"</a>"+	
			"</span>	"+	
			"</div>"; 
		   
		}
		function overimg4(imgsrc, ocode, title, ctitle){
 			var obj = document.getElementById('test_id4');
			obj.innerHTML = 
			"<div id='test_id4'>"+
			"<span class='img'><a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\"><span class='playMid'></span>"+
			"<img src='"+imgsrc+"' alt='"+title+"' /></a></span>"+
			"<span class='total'>"+
			"<span class='cate'><a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\">"+ctitle+"</a></span>"+
			"<a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\">"+title+"</a>"+	
			"</span>	"+	
			"</div>"; 
		   
		}
		function overimg5(imgsrc, ocode, title, ctitle){
 			var obj = document.getElementById('test_id5');
			obj.innerHTML = 
			"<div id='test_id5'>"+
			"<span class='img'><a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\"><span class='playMid'></span>"+
			"<img src='"+imgsrc+"' alt='"+title+"' /></a></span>"+
			"<span class='total'>"+
			"<span class='cate'><a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\">"+ctitle+"</a></span>"+
			"<a href=\"javascript:link_open('/2013/video/video_player.jsp?ocode="+ocode+"')\">"+title+"</a>"+	
			"</span>	"+	
			"</div>"; 
		   
		}
		function overimg6(imgsrc, board_id, list_id, title){
 			var obj = document.getElementById('test_id6');
			obj.innerHTML = 
			"<div id='test_id6'>"+
 			"<span class='img'><a href=\"javascript:link_open('/2013/board/board_view.jsp?board_id="+board_id+"&amp;list_id="+list_id+"')\">"+
 			"<img src='"+imgsrc+"' alt='"+title+"'/></a></span>"+
			"<span class='total'>"+
			"<a href=\"javascript:link_open('/2013/board/board_view.jsp?board_id="+board_id+"&amp;list_id="+list_id+"')\">"+title+"</a>"+
			"</span>	"+	
			"</div>";  
		}

		function outimg(){ 
		}

		function outimg_class(id, this_name){ 
			var obj = document.getElementById(id);
			var temp_id;
			obj.className="mouseup";
	 
			for(i=1;i<11;i++){
				temp_id = this_name+i;
				
				if (document.getElementById(temp_id) != null) {
					
					if(id == temp_id){
						document.getElementById(temp_id).className="mouseup"; 
					}else{
						document.getElementById(temp_id).className='';
					} 
				}
				
			}
		}
	function outimg_class2(id, this_name){ 
			var obj = document.getElementById(id);
			var temp_id;
			obj.className="mouseout";
	 
			for(i=1;i<11;i++){
				temp_id = this_name+i;
				
				if (document.getElementById(temp_id) != null) {
					
					if(id == temp_id){
						document.getElementById(temp_id).className="mouseout"; 
					}else{
						document.getElementById(temp_id).className="mouseout";
					} 
				}
				
			}
		}
		

	</script>
	<div class="sAside">
			<div class="NewTab list5">
				<ul>
					<li class="active"><a href="#"><span>주간 Best</span></a>
						<ul>
						<% 
							if (new_week != null && new_week.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_week.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									} 
								if (i == 1) {
					%> 	 
 
							<li class="numS" >
							  <div id="test_id1">
								<span class="time"><img src="../include/images/icon_best1.gif" alt="1"/></span>
								<span class="img"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp %>" alt='<%=title%>' id="img1"/></a></span>
								<span class="total">
									<span class="cate"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=temp_ctitle%></a></span>								<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a>
								</span>	
								</div>
							</li>
							<li class="num"><div id="week<%=i%>"><span class="time"><img src="../include/images/icon_best<%=i%>.gif" alt="<%=i%>"/></span> <a class="view_page" onclick="javascript:outimg_class2('week<%=i%>', 'week');" onFocus="this.blur();"  onmouseout="javascript:outimg_class('week<%=i%>', 'week');" onmouseover="javascript:overimg1('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>','<%=i %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
							 
							<%} else { %>
						 
							<li class="num"><div id="week<%=i%>"><span class="time"><img src="../include/images/icon_best<%=i%>.gif" alt="<%=i%>"/></span> <a class="view_page" onclick="javascript:outimg_class2('week<%=i%>', 'week');" onFocus="this.blur();"  onmouseout="javascript:outimg_class('week<%=i%>', 'week');" onmouseover="javascript:overimg1('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>','<%=i %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
							
		   
					<%
								}
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
					 
						</ul>
					</li>
					<li><a href="#"><span>월간 Best</span></a>
						<ul>
						
						<% 
							if (new_month != null && new_month.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_month.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									} 
								if (i == 1) {
					%> 	 
 
							<li class="numS" >
							 <div id="test_id2">
								<span class="time"><img src="../include/images/icon_best1.gif" alt="1"/></span>
								<span class="img"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp %>" alt='<%=title%>'/></a></span>
								<span class="total">
									<span class="cate"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=temp_ctitle%></a></span>
									<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a>
								</span>	
							</div>
							</li>
							<li class="num"><div id="mon<%=i%>"><span class="time"><img src="../include/images/icon_best<%=i%>.gif" alt="<%=i%>"/></span> <a class="view_page" onclick="javascript:outimg_class2('mon<%=i%>', 'mon');" onFocus="this.blur();" onmouseout="javascript:outimg_class('mon<%=i%>', 'mon');" onmouseover="javascript:overimg2('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>','<%=i %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
							
							<%} else { %>
						 
							<li class="num"><div id="mon<%=i%>"><span class="time"><img src="../include/images/icon_best<%=i%>.gif" alt="<%=i%>"/></span> <a class="view_page" onclick="javascript:outimg_class2('mon<%=i%>', 'mon');" onFocus="this.blur();" onmouseout="javascript:outimg_class('mon<%=i%>', 'mon');" onmouseover="javascript:overimg2('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>','<%=i %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
							 
					<%
								}
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
					 
						</ul>
					</li>
					<li><a href="#"><span>연간 Best</span></a>
						<ul>
							<% 
							if (new_year != null && new_year.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_year.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","");
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									} 
								if (i == 1) {
					%> 	 
 
							<li class="numS" >
							 <div id="test_id3">
								<span class="time"><img src="../include/images/icon_best1.gif" alt="1"/></span>
								<span class="img"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp %>" alt='<%=title%>'/></a></span>
								<span class="total">
									<span class="cate"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=temp_ctitle%></a></span>
									<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a>
								</span>	
								</div>
							</li>
							<li class="num"><div id="year<%=i%>"><span class="time"><img src="../include/images/icon_best<%=i%>.gif" alt="<%=i%>"/></span> <a class="view_page" onclick="javascript:outimg_class2('year<%=i%>', 'year');" onFocus="this.blur();" onmouseout="javascript:outimg_class('year<%=i%>', 'year');" onmouseover="javascript:overimg3('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>','<%=i %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
							
							<%} else { %>
						 
							<li class="num"><div id="year<%=i%>"><span class="time"><img src="../include/images/icon_best<%=i%>.gif" alt="<%=i%>"/></span> <a class="view_page" onclick="javascript:outimg_class2('year<%=i%>', 'year');" onFocus="this.blur();" onmouseout="javascript:outimg_class('year<%=i%>', 'year');" onmouseover="javascript:overimg3('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>','<%=i %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
							
		   
					<%
								}
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
						</ul>
					</li>
				</ul>
			</div>
			<div class="sNotice">
				<h3>공지사항</h3>
				<ul>
				<% 
					if (noticeVt1 != null && noticeVt1.size() > 0) {
						String list_title = "";
						String list_date = "";
						String list_contents = "";
						try {
							for (Enumeration e = noticeVt1.elements(); e.hasMoreElements();) {
								com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement());
								list_title=com.vodcaster.utils.TextUtil.text_replace(bliBean.getList_title(),false);
								 
								list_title = list_title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
					 %>
					 	<li><a class="view_page" href="/2013/board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><%=list_title %></a></li>
					 <% 
 							}
						} catch (Exception e) {
						}
					}
					%> 
				 
				</ul>
				<span class="more"><a href="/2013/board/board_list.jsp?board_id=10"><img src="../include/images/btn_right_more.gif" alt="더보기"/></a></span>
			</div>
			<div class="sNote">
				<h3>제작현장</h3>
				<ul>
				
				<% 
					if (noticeVt2 != null && noticeVt2.size() > 0) {
						String list_title = "";
						String list_date = "";
  
						try {
							int cnt_a=1;
							for (Enumeration e = noticeVt2.elements(); e.hasMoreElements();cnt_a++) {
								com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement());
								list_title=com.vodcaster.utils.TextUtil.text_replace(bliBean.getList_title(),false);
								  
								list_title = list_title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
								if (cnt_a == 1) {
					 %>
					 <li class="view" >
					 <div id="test_id6">
					<span class="img"><a class="view_page" href="/2013/board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><img src="../board/img_2.jsp?list_id=<%=bliBean.getList_id()%>" alt='<%=list_title%>'/></a></span>
					<span class="total">
						<a class="view_page" href="/2013/board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><%=list_title%></a>
					</span>
					</div>
					</li>
					<li class="no"><div id="board<%=cnt_a%>"><a class="view_page" onclick="javascript:outimg_class2('board<%=cnt_a%>', 'board');" onFocus="this.blur();" onmouseout="javascript:outimg_class('board<%=cnt_a%>', 'board');" onmouseover="javascript:overimg6('../board/img_2.jsp?list_id=<%=bliBean.getList_id()%>','<%=bliBean.getBoard_id()%>','<%=bliBean.getList_id()%>','<%=list_title%>');" href="/2013/board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><%=list_title %></a></div></li>
					
					<%} else { %>
				
					 	<li class="no"><div id="board<%=cnt_a%>"><a class="view_page" onclick="javascript:outimg_class2('board<%=cnt_a%>', 'board');" onFocus="this.blur();" onmouseout="javascript:outimg_class('board<%=cnt_a%>', 'board');" onmouseover="javascript:overimg6('../board/img_2.jsp?list_id=<%=bliBean.getList_id()%>','<%=bliBean.getBoard_id()%>','<%=bliBean.getList_id()%>','<%=list_title%>');" href="/2013/board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><%=list_title %></a></div></li>
					 <% 
								}
 							}
						} catch (Exception e) {
						}
					}
				%> 

				</ul>
				<span class="more"><a href="/2013/board/board_list.jsp?board_id=16"><img src="../include/images/btn_right_more.gif" alt="더보기"/></a></span>
			</div>
			<div class="NewTab list6">
				<ul>
					<li class="active"><a href="#"><span>최신뉴스</span></a>
						<ul>
						
						<% 
							if (new_list5 != null && new_list5.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list5.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false); 
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									} 
									
								if (i == 1) {
					%> 	 
							<li class="numS" >
							<div id="test_id4">
								<span class="img"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp %>" alt='<%=title%>'/></a></span>
								<span class="total">
									<span class="cate"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=temp_ctitle%></a></span>
									<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a>
								</span>	
							</div>
							</li>
							<li class="num"><div id="new_news<%=i%>"><a class="view_page" onclick="javascript:outimg_class2('new_news<%=i%>', 'new_news');" onFocus="this.blur();" onmouseout="javascript:outimg_class('new_news<%=i%>', 'new_news');" onmouseover="javascript:overimg4('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
		   
							<%} else { %>
							<li class="num"><div id="new_news<%=i%>"><a class="view_page" onclick="javascript:outimg_class2('new_news<%=i%>', 'new_news');" onFocus="this.blur();" onmouseout="javascript:outimg_class('new_news<%=i%>', 'new_news');" onmouseover="javascript:overimg4('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
		   
					<%
								}
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%> 
					 
						</ul>
					</li>
					<li><a href="#"><span>최신영상</span></a>
						<ul>
							<% 
							if (new_list6 != null && new_list6.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list6.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode().contains("004001")) {
										temp_ctitle = "나도PD";
									}
								if (i == 1) {
					%> 	 
				
							<li class="numS" >
								<div id="test_id5">
								<span class="img"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp %>" alt='<%=title%>'/></a></span>
								<span class="total">
									<span class="cate"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=temp_ctitle%></a></span>
									<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a>
								</span>	
								</div>
							</li>
							<li class="num"><div id="new_vod<%=i%>"><a class="view_page" onclick="javascript:outimg_class2('new_vod<%=i%>', 'new_vod');" onFocus="this.blur();" onmouseout="javascript:outimg_class('new_vod<%=i%>', 'new_vod');" onmouseover="javascript:overimg5('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
		   		   
							<%} else { %>
							<li class="num"><div id="new_vod<%=i%>"><a class="view_page" onclick="javascript:outimg_class2('new_vod<%=i%>', 'new_vod');" onFocus="this.blur();" onmouseout="javascript:outimg_class('new_vod<%=i%>', 'new_vod');" onmouseover="javascript:overimg5('<%=imgTmp%>','<%=oinfo.getOcode()%>','<%=title%>','<%=oinfo.getCtitle() %>');" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"><%=title%></a></div></li>
		   
					<%
								}
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%> 
						</ul>
					</li>
				</ul>
			</div>
			<div class="banner">
				<a href="http://blog.naver.com/suwonitv/" target="_blank"><img src="../include/images/suwonitv_blog.gif" alt="더보기"/></a>
				<a href="http://www.youtube.com/user/suwonloves" target="_blank"><img src="../include/images/suwonitv_youtube.gif" alt="더보기"/></a>
				<a href="https://twitter.com/suwonitv" target="_blank"><img src="../include/images/suwonitv_twitter.gif" alt="더보기"/></a>
			</div>
		</div>