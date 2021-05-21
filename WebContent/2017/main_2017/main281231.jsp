<%@page import="com.yundara.beans.BeanUtils"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>  
 
<%@ page import="com.yundara.util.*,com.vodcaster.sqlbean.*,com.hrlee.sqlbean.*"%> 
 
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="pop"   class="com.vodcaster.sqlbean.PopupInfoBean"/>

<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<jsp:useBean id="contactLog" class="com.vodcaster.sqlbean.WebLogManager" />

<%@ include file = "/include/chkLogin.jsp"%>
<%

String muid ="";
if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && (request.getRequestURI().indexOf("main.jsp")> -1  || request.getRequestURI().indexOf("main_link.jsp")> -1) ) {
	 muid = "main"; 
	 contact.setValue(request.getRemoteAddr(),"guest", "W");  //  접속 카운트
} else if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0) {
	 muid = request.getParameter("ccode") ;
}else if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 muid = "B_"+request.getParameter("board_id") ;
}  else {
	 muid = "etc";
}

contactLog.setStatVisitInfo(request);

contactMenu.setValueMenu(request.getRemoteAddr(),"guest", "W", muid);  // 서브페이지 메뉴 카운트
contact.setPage_cnn_cnt("W"); // 페이지 접속 카운트 증가

LiveManager lMgr = LiveManager.getInstance();
String channel = "";
String stream = "";
String live_title ="";
String live_rcontents ="";
String live_popup = "";
String live_rcode ="";
Vector live_v = null;
try {
 // rcode, rtitle, rcontents, rbcst_time, ralias, 
  // rstart_time, rend_time, rflag, rstatus, rwdate, 
  // rhit, rlevel,rfilename, rid, rimagefile,
  // property_id, openflag,group_id, del_flag, ocode, 
  // otitle, mobile_sream, inoutflag, org_rfilename 
  
    live_v = lMgr.getLive(); 


if(live_v != null && live_v.size() > 0) {

		live_popup = "window.open('/2017/info/live_info.jsp','live_comment', 'width=400, height=300, scrollbars=no, toolbars=no');";
		live_rcode = String.valueOf(live_v.elementAt(0)); 
		live_title = String.valueOf(live_v.elementAt(1)); 
		live_rcontents  = String.valueOf(live_v.elementAt(2)); 
		String[] data= null;
		 
		data=String.valueOf(live_v.elementAt(4)).split("/");

		if(data.length > 2){
			channel = data[1];
			stream = data[2];
		}
		
} 
}catch(Exception e) {}


//공지사항
Vector noticeVt1 = blsBean.getRecentBoardList_open_top(10, 4); // 공지 (board_id, limit)

//오늘의 주요 영상
//MediaManager mMgr = MediaManager.getInstance();
BestMediaManager Best_mgr = BestMediaManager.getInstance();
	
Vector vtBts_1 = new Vector();
vtBts_1 = Best_mgr.getBestTopSubList_order(1, 7); // 오늘의 주요 영상  bti_id = 1, limit = 7
 
Vector main_list1 =new Vector();
Vector main_list2 =new Vector();
Vector main_list3 =new Vector();
Vector main_list4 =new Vector();
Vector main_list5 =new Vector();
Vector main_list6 =new Vector();
Vector main_list7 =new Vector();

//=====================================
//팝업정보 가져오기

String[] pop_seq = null;
	String seq = null;
	String pos_x = "";
	String pos_y = "";
	String p_width = "";
	String p_height = "";
	
	String[] pop_script = null;
	String[] pop_scriptM = null;
	PopupManager pMgr = new PopupManager();
	Vector popv_P = pMgr.getVisible_dateflag("P");  // flag = P  popup , M main, C 이슈
		
	Vector popv_M = pMgr.getVisible_dateflag("M");  // flag = P  popup , M main, C 이슈
	
	if(popv_P != null && popv_P.size() > 0) {
		pop_script = new String[popv_P.size()];
		pop_seq = new String[popv_P.size()];
		for(int i=0;i<popv_P.size();i++){
			seq = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(0));
			pos_x = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(10));
			pos_y = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(11));
			p_width = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(4));
			p_height = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(5));

			int pop_height = 160;
			if (p_height != null && p_height.length() > 0) {
				//pop_height = Integer.parseInt(p_height)+150;		
				pop_height = Integer.parseInt(p_height)+80;		
			}
			int pop_width = 160;
			if (p_width != null && p_width.length() > 0) {
				pop_width = Integer.parseInt(p_width);		
			}	
				pop_script[i] = "window.open('/2017/info/popup_dd.jsp?seq="+seq+"', 'vodcaster_"+seq+"', 'left="+pos_x+", top="+pos_y+", width="+pop_width+", height="+pop_height+", scrollbars=no, toolbars=no');";

			pop_seq[i] = seq;
		}
	}
	
	 
	//==========================================================
	// 설문 정보 가져오기 

	SubjectManager smgr = SubjectManager.getInstance();
	Vector subject = null;
	String subject_script = "";
	subject = smgr.getSubjectListDate("S");  // 설문

	if( subject != null && subject.size() >= 4 && Integer.parseInt( String.valueOf(subject.elementAt(4))) >=  Integer.parseInt( String.valueOf(subject.elementAt(12))) ) {
	        subject_script = "if ( getCookie( \"subject\" ) != \"true\" ) { \n" +
	                "noticeWindow2  =  window.open(\"/2017/info/event_info.jsp?sub_flag=S\", \"subject\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=300\");\n" +
	                "if(noticeWindow2){noticeWindow2.opener = self;} \n" +
	                "} ";
	  }

	Vector event = null;
	String event_script ="";
	event = smgr.getSubjectListDate("E") ; //이벤트
	if( event != null && event.size() >= 4 && Integer.parseInt( String.valueOf(event.elementAt(4))) >=  Integer.parseInt( String.valueOf(event.elementAt(12))) ) {
	        event_script = "if ( getCookie( \"event\" ) != \"true\" ) { \n" +
	                "noticeWindow3  =  window.open(\"/2017/info/event_info.jsp?sub_flag=E\", \"event\", \"status=no,scrollbars=no,width=400,height=300,top=120,left=500\");\n" +
	                "if(noticeWindow3){noticeWindow3.opener = self;} \n" +
	                "} ";
	  }

	Vector hot7 = null;
	String hot7_script ="";
	hot7 = smgr.getSubjectListDate("H") ; //핫세븐
	 
	try{
		  if( hot7 != null && hot7.size() >= 4 
				&& Integer.parseInt( String.valueOf(hot7.elementAt(4))) >=  Integer.parseInt( String.valueOf(hot7.elementAt(12))) ) {
			  hot7_script = "if ( getCookie( \"hot7\" ) != \"true\" ) { \n" +
						  "noticeWindow4  =  window.open(\"/2017/info/event_info.jsp?sub_flag=H\", \"hot7\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=700\");\n" +
						  "noticeWindow4.opener = self; \n" +
						  "} ";
			}
		}catch(Exception ex){
	 
		}
	 

if (vtBts_1 != null && vtBts_1.size() > 0) {
	int cnt = 1;
	for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++) {
		com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
		 			String imgTmp = "/2017/include/images/noimg_small.gif";
					 
					if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
						imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();
					}  
					if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
						imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
					}
					String strTitle = oinfo.getTitle();
					strTitle = strTitle.length()>26?strTitle.substring(0,26)+"...":strTitle;
					
					String strContent = oinfo.getDescription();
					strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
					
					if (cnt==1 ) {
					    main_list1.add(strTitle);
					    main_list1.add( imgTmp);
					    main_list1.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					} else if (cnt==2) {
						main_list2.add(strTitle);
					    main_list2.add( imgTmp);
					    main_list2.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					}else if (cnt==3) {
						main_list3.add(strTitle);
					    main_list3.add( imgTmp);
					    main_list3.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					}else if (cnt==4) {
						main_list4.add(strTitle);
					    main_list4.add( imgTmp);
					    main_list4.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					}else if (cnt==5) {
						main_list5.add(strTitle);
					    main_list5.add( imgTmp);
					    main_list5.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					}else if (cnt==6) {
						main_list6.add(strTitle);
					    main_list6.add( imgTmp);
					    main_list6.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					}else if (cnt==7) {
						main_list7.add(strTitle);
					    main_list7.add( imgTmp);
					    main_list7.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					}
	}
} 
 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta NAME="title" content="수원 iTv" />
<meta NAME="description" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원" />
<meta NAME="Keywords" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원" />

<title>수원인터넷방송</title>
<link rel="stylesheet" type="text/css" href="../include/css/default.css" />
<link rel="stylesheet" type="text/css" href="../include/css/main.css" />
<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css" />
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8"  src="../include/js/jquery.leanModal.min.js"></script> <!-- 메인메뉴모달 -->
<script type="text/javascript" charset="utf-8"src="../include/js/popup_2015.js" ></script>
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.colorbox.js"></script> <!-- 레이어팝업 -->
<script type="text/javascript" charset="utf-8" src="../include/js/script.js"></script> <!-- 서브탭버튼 -->

<script>
<!--
function getCookie(Name){
	var search = Name + "=";
	if(document.cookie.length > 0 ){
		offset = document.cookie.indexOf(search);
		if( offset != -1){
			offset += search.length;
			end = document.cookie.indexOf(";",offset);
			if( end == -1){
				end = document.cookie.length;
			}
			return unescape(document.cookie.substring(offset, end));
			
		}
	}
}
 

function isPopupView(seq) {

	if(!(getCookie("vodcaster_"+seq) == "true")) { 
		return true;
	}
}

//-->
</script>
</head>
<body>
	<div id="wapper"> 
		<header> 
			<div class="head_inner">
			<div id="accessibility">
				<ul>
				<li><a href="#lnb" accesskey="1">메인메뉴바로가기</a></li>
				<li><a href="#body" accesskey="2">컨텐츠바로가기</a></li>
				</ul>
			</div> <!-- //accessibility::skip -->
			<div class="top-nav"> 
				<h1><a href="/"><img src="../include/images/logo.png" alt="SUWON TV"/></a></h1>
				<div class="gnb_area">
					<a href="/2017/info/search.jsp"><img src="../include/images/icon_search.png" alt="검색"/></a>
					<a href="#menuFull" class="flatbtn" id="modaltrigger"><img src="../include/images/icon_menu_yellow.png" alt="메뉴"/></a>
				</div>
				<div class="sns">
					<a href="http://www.youtube.com/user/suwonloves" target="_blank" title="새창으로 연결"><img src="../include/images/sns_youtube.png" alt="유투브"/></a>
					<a href="http://blog.naver.com/suwonitv/" target="_blank" title="새창으로 연결"><img src="../include/images/sns_blog.png" alt="네이버 블로그"/></a>
					<a href="https://tv.kakao.com/channel/2711566/cliplink/303361751?metaObjectType=Channel" target="_blank" title="새창으로 연결"><img src="../include/images/sns_cacaotv.png" alt="카카오TV"/></a>
					<a href="https://twitter.com/suwonitv" target="_blank" title="새창으로 연결"><img src="../include/images/sns_twitter.png" alt="트위터"/></a>
					<a href="http://tv.naver.com/suwonitv" target="_blank" title="새창으로 연결"><img src="../include/images/sns_navertv.png" alt="네이버TV"/></a>
					
				</div>
			</div>
			</div>
		</header> <!--헤더:header-->               
		<nav id="lnb">            
			
		</nav> <!--네비게이션:nav-->          
	
		<section id="body">
			<div class="container_out">
	
			<div class="container_inner">
				<div class="box">
					<!--첫째 줄(lineFirst)-->
					<div class="lineF">
 					  <div class="boxF">
					  <div class="boxS" >
								<div class="boxT">
									<div id="popupzone_f">
										<div id="popup_zone_f">
											<div id="photo_zone_f" class="basic_photo_banner">
												 
												 <% 
													  if(popv_M != null && popv_M.size() >0){
														  for(int i=0; i<popv_M.size(); i++){
														 
												 %> 
												<p id="popup_f<%=i+1%>">
													<a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>">
													<span class="thumb">
														<img src="/upload/popup/<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(9))%>" alt="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%>"/>
													</span>
													 
													</a>
												</p>
															
												<%
															  }
													  }
												%> 
												 
											</div>
											<div id="popup_num_f">
												<a href="#popup_f" onclick="play_popup_f(1);"><img src="../include/images/btn_play.png" alt="재생" /></a> 
												<a href="#popup_f" onclick="play_popup_f(0);"><img src="../include/images/btn_stop.png" alt="정지" /></a> 
												<% 
													  if(popv_M != null && popv_M.size() >0){
														  for(int i=0; i<popv_M.size(); i++){
												 %>
												<a href="#popup_f" onclick="select_num_f('<%=i+1%>');"><img src="../include/images/1_on.png" id="popup_img_f<%=i+1%>" alt="<%=i+1%>"/></a>
												<%
															}
													  }
												%>						
													
											</div>
										</div>
										<script type="text/javascript">play_pop_f();</script>
									</div>
								</div>
							</div> 					  
						</div>
					 
					 
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
								<% if (main_list1 != null && main_list1.size() >0) { %>
								<a href="<%=main_list1.get(2).toString()%>">
									<img src="<%=main_list1.get(1).toString()%>" alt="<%=main_list1.get(0).toString()%>"/>
									<div class="overlay"><%=main_list1.get(0).toString()%></div>
								</a>
								<%} %>
								</div>
							</div>
						</div>
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
								<% if(main_list2 !=null && main_list2.size() >0){%>
								<a href="<%=main_list2.get(2).toString()%>">
								 <img src="<%=main_list2.get(1).toString() %>" alt="<%=main_list2.get(0).toString()%>"/>
								 <div class="overlay"><%=main_list2.get(0).toString()%></div>		
								 </a>	
								<%} %>
								</div>
							</div>
						</div>
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
									<div class="m_notice">
									<h3>공지사항</h3>
									<ul>
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
	 
												<li><a href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><%=bliBean.getList_title() %></a></li>
										<% 
					  							}
					 						} 
					 						catch (Exception e) {
					 						}
					 					} 
					 					%>
								 
									</ul>
									</div>						
								</div>
							</div>
						</div>
					</div>
					<!--둘째 줄(lineSecond)-->
					 <div class="lineS" style=" top: 247px;left: 130px;">
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
									<% if(main_list3 !=null && main_list3.size() >0){%>
									<a href="<%=main_list3.get(2).toString()%>">
								 <img src="<%=main_list3.get(1).toString() %>" alt="<%=main_list3.get(0).toString()%>"/>
								 <div class="overlay"><%=main_list3.get(0).toString()%></div>
								 </a>
								<%} %>
								</div>
							</div>
						</div>
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
								<% if (main_list4 != null && main_list4.size() >0) { %>
								<a href="<%=main_list4.get(2).toString()%>">
								 <img src="<%=main_list4.get(1).toString() %>" alt="<%=main_list4.get(0).toString()%>"/>
								 <div class="overlay"><%=main_list4.get(0).toString()%></div>
								 </a>			
								<%} %>
								</div>
							</div>
						</div>
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
									<% if (main_list5 != null && main_list5.size() >0) { %>
									<a href="<%=main_list5.get(2).toString()%>">
								 <img src="<%=main_list5.get(1).toString() %>" alt="<%=main_list5.get(0).toString()%>"/>
								 <div class="overlay"><%=main_list5.get(0).toString()%></div>
								 </a>		
								<%} %>
								</div>
							</div>
						</div>
					</div>
					 <!--둘째 줄(lineThree)-->
					<div class="lineT">
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
									<div class="youtube_inner">
									<% 
									YoutubeeManager ytm = YoutubeeManager.getInstance();
									Vector youTb = ytm.getYoutubeeLink();
									String title = "";
									String img = "";
									String link =  "";
									if (youTb != null && youTb.size() > 0) {
										 title = youTb.get(0).toString();
										 img =youTb.get(1).toString();
										 link = youTb.get(2).toString();
									}
								
									%>
									 
										<!-- <img src="../include/images/5.png"/> -->
										<a href="http://<%=link %>" target="_blank">
										<img src="/upload/board_list/<%=img %>"  alt="유트브 채널"/>
										<div class="overlay2"><%=title %></div>
										</a>
										<div class="icon_you"><a href="http://<%=link %>" target="_blank" title="새창으로 연결" ><img src="../include/images/sns_youtube2.png" alt="유트브 채널"/></a></div>
									
									</div>
								</div>
							</div>
						</div>
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
									<div class="banner b_bg"> 
										<a href="/2017/video/video_list.jsp?ccode=002007000000"><img src="../include/images/banner_3.png" alt="방송영상"/></a>
										<a href="/2017/board/board_list.jsp?board_id=24"><img src="../include/images/banner_4.png" alt="방송모음/"></a>
									</div>
									<!--<% if (main_list6 != null && main_list6.size() >0) { %>
									<a href="<%=main_list6.get(2).toString()%>">
								 <img src="<%=main_list6.get(1).toString() %>"  alt="<%=main_list6.get(0).toString()%>"/>
								 <div class="overlay"><%=main_list6.get(0).toString()%> </div>			
								 </a>
								<%} %>-->
								</div>
							</div>
						</div>
						<div class="boxF">
							<div class="boxS">
								 <div class="boxT">
									<div class="banner2"> 
										<a href="/2017/video/video_list.jsp?ccode=003000000000"><img src="../include/images/banner_2.png" alt="교양·정보"  style="-ms-interpolation-mode: nearest-neighbor;"/></a>
									</div>
									<!--<% if (main_list7 != null && main_list7.size() >0) { %>
									<a href="<%=main_list7.get(2).toString()%>">
								 <img src="<%=main_list7.get(1).toString() %>"  alt="<%=main_list7.get(0).toString()%>"/>
								 <div class="overlay"><%=main_list7.get(0).toString()%></div>
								 </a>	
								<%} %>-->
								</div>
							</div>
						</div>
						<div class="boxF">
							<div class="boxS">
								<div class="boxT">
									<div class="banner"> 
										<a href="/2017/video/video_list.jsp?ccode=004001000000"><img src="../include/images/banner_pd.png" alt="나도 PD GO"/></a>
										<a href="/2017/board/board_list.jsp?board_id=22"><img src="../include/images/banner_monitor.png"  alt="시민모니터단 GO"/></a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
			</section><!--콘텐츠부분:section-->    
			<%
	if(popv_P != null && popv_P.size() > 0) {
		for (int i = 0; i < pop_seq.length; i++) {
			// IE일때 쿠키검사 후 팝업

				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				//out.println("var isPop = isPopupView(\'"+pop_seq[i]+"\');");
				//out.println("if (isPop) {");
				out.println("if (getCookie( \"vodcaster_"+pop_seq[i]+"\" ) != \"true\" ) {");
				out.println(pop_script[i]);
				out.println("}</SCRIPT>");
		} 
	}
		
	
	
	//라이브 팝업 안내창을 뛰운다.
 
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println(subject_script);
	out.println(event_script);
	out.println(hot7_script);
	out.println(live_popup);
	out.println("</SCRIPT>");
	
%>	 	
		<!-- Start : layer-popup content --> 
		<div id="layer" class="layer-wrap" style="display: block; width: 455px; height: 503px; margin:auto auto;"> <!-- height = pop-container + padding 68px + btn height 35px //--> 
			<div class="pop-layer"> 
				<div class="pop-container" style="width: 455px; height: auto;"> <!-- 가로세로 padding 값 68px //--> 
					<div class="pop-conts"> <!--content //--> 
						<h3>역사를 품고 밤을 누비다! 2018 수원 야행 첫 번째 관람기</h3>
						<div style="width:387px; height: 286px;background:url(http://tv.suwon.go.kr/upload/popup/20180905135553.png) no-repeat left top;background-size: 100% auto;"></div>
						<img src="../include/images/00_00_25.png" alt="이미지명"/>
						현재 생방송이 진행중입니다.현재 생방송이 
						<p class="btn_go"><a href="">생방송 보러가기</a></p>
					</div> 
				</div> 
				<div class="btn"> <!--height 35px-->
					<input type="checkbox" id="todayclose"/> 
					<label for="todayclose">오늘하루 열지 않음</label>
					<a href="#" class="btn-layerClose">CLOSE</a> 
				</div> <!--// content--> 
			</div> 
		</div> <!-- End : layer-popup content -->
		<script type="text/javascript">
		 $('.btn-layerClose').on('click', function() {
			$('.layer-wrap').fadeOut();
		 });
		</script>
<%@ include file = "../include/html_foot.jsp"%>    
		
 