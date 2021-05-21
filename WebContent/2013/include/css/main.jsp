<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 

 
<%@ page import="com.yundara.util.*"%> 
<jsp:useBean id="btsBean" class="com.vodcaster.sqlbean.BestTopSubBean" scope="page" />
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />

<%@ include file = "/include/chkLogin.jsp"%>
<% 
MediaManager mMgr = MediaManager.getInstance();

java.util.Date day = new java.util.Date();
SimpleDateFormat today_sdf = new SimpleDateFormat("yyyy-MM-dd");
String today_string = today_sdf.format(day);
 
//2014-07-16 주석처리 함
//by leeteam
//try {
// 	if (today_string.substring(8,10).trim().equals("01")) {
//		mMgr.insertMohth_log();
//	}
//} catch (Exception e) {
//	System.out.println("월간 로그 등록 에러");
//}

/////////////////////////////
// 오늘의 주요 영상 (금주의영상)
	
// BestWeekManager bwMgr = BestWeekManager.getInstance();
// Vector bwVt = bwMgr.getBestWeekInfo("A");
// if(bwVt != null && bwVt.size() > 0) {
// 	Enumeration e = bwVt.elements();
// 	com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)e.nextElement());
// } 

///////////////////////////////////
	Vector new_list0 = new Vector();

	//Vector new_list1 = new Vector();
	//Vector new_list2 = new Vector();
	//Vector new_list3 = new Vector();
	//Vector new_list4 = new Vector();
	//Vector new_list5 = new Vector();
	
	//Vector new_list6 = new Vector();
	//Vector new_list7 = new Vector();
	//Vector new_list8 = new Vector();
	//Vector new_list9 = new Vector();

	new_list0 = mMgr.getMediaListNew(12); //뉴스
	
	//new_list1 = mMgr.getMediaList_count("001", 5); //뉴스
	//new_list2 = mMgr.getMediaList_count("002", 5); //버라이어티
	//new_list3 = mMgr.getMediaList_count("003", 5); // 라이프
	//new_list4 = mMgr.getMediaList_count("004", 5); // 시청자
	
	//new_list5 = mMgr.getMediaList_count_order_1week("001","hitcount", 10); // 가장많이 본 뉴스
	//new_list6 = mMgr.getMediaList_count_order_not_1week("001","hitcount", 10); // 가장많이 본 영상
	
	//new_list7 = mMgr.getMediaList_count_order("003","mk_date", 1); // 라이프 플러스
	//new_list8 = mMgr.getMediaList_count("006", 4); // 생방송
	//new_list9 = mMgr.getMediaList_count("005", 4); // 홍보영상

	Vector noticeVt1 = blsBean.getRecentBoardList_open_top(10, 6); // 공지 (board_id, limit)
	Vector noticeVt2 = blsBean.getRecentBoardList_open(16, 1); // 제작노트 (board_id, limit)
 
/////////////////////////////////////
// bestTop (관리자 지정 영상/ 화재의 영상, 명예의 전당, hot뉴스)

BestMediaManager Best_mgr = BestMediaManager.getInstance();
	
Vector vtBts_1 = new Vector();
Vector vtBts_2 = new Vector();
//Vector vtBts_3 = new Vector();
Vector vtBts_4 = new Vector();

vtBts_1 = Best_mgr.getBestTopSubList_order(2, 6); // 화재의 영상
vtBts_2 = Best_mgr.getBestTopSubList_order(3, 3); // 명예의 전당
//vtBts_3 = Best_mgr.getBestTopSubList_order(4, 4); // HOT 뉴스

vtBts_4 = Best_mgr.getBestTopSubList_order(1, 7); // 메인 영상

 

//========================================================
// 생방송 정보 가져오기
 // html_head.jsp 로 이동

//==========================================================
// 팝업 정보 가져오기


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
	Vector popv_C = pMgr.getVisible_dateflag("C");  // flag = P  popup , M main, C 이슈
	
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
				pop_width = Integer.parseInt(p_width)+8;		
			}	
				pop_script[i] = "window.open('/2013/info/popup_dd.jsp?seq="+seq+"', 'vodcaster_"+seq+"', 'left="+pos_x+", top="+pos_y+", width="+pop_width+", height="+pop_height+", scrollbars=no, toolbars=no');";

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
                "noticeWindow2  =  window.open(\"/2013/info/event_info.jsp?sub_flag=S\", \"subject\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=300\");\n" +
                "if(noticeWindow2){noticeWindow2.opener = self;} \n" +
                "} ";
  }

Vector event = null;
String event_script ="";
event = smgr.getSubjectListDate("E") ; //이벤트
if( event != null && event.size() >= 4 && Integer.parseInt( String.valueOf(event.elementAt(4))) >=  Integer.parseInt( String.valueOf(event.elementAt(12))) ) {
        event_script = "if ( getCookie( \"event\" ) != \"true\" ) { \n" +
                "noticeWindow3  =  window.open(\"/2013/info/event_info.jsp?sub_flag=E\", \"event\", \"status=no,scrollbars=no,width=400,height=300,top=120,left=500\");\n" +
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
					  "noticeWindow4  =  window.open(\"/2013/info/event_info.jsp?sub_flag=H\", \"hot7\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=700\");\n" +
					  "noticeWindow4.opener = self; \n" +
					  "} ";
		}
	}catch(Exception ex){
 
	}
 
String ccode="";
int board_id=0;  

//thumbnail size
double dFrom = Double.parseDouble("20131226102100000");
%>

<%
	Vector new_week = mMgr.getMediaList_count_week("","hitcount", 12); // 주간
	Vector new_month = mMgr.getMediaList_count_month("","hitcount", 12); // 월간 영상
	Vector new_year = mMgr.getMediaList_count_year("","hitcount", 12); // 년간 영상
%>
<%@ include file = "../include/html_head.jsp"%>
<% if(live_v != null && live_v.size() > 0) {  %>
<script language="javascript">AC_FL_RunContent = 0;</script>
<script type="text/javascript" src="../include/js/AC_RunActiveContent.js" ></script>

<script language="javascript">
 
    function getFlashMovie(movieName) {
        var isIE = navigator.appName.indexOf("Microsoft") != -1;
		 return (isIE) ? window[movieName] : document[movieName];
        }
    function callToActionscript(str) 
	{
	  
	 getFlashMovie("live_wide").sendToActionscript(str);
		 
	 $('#today_live').css('display', '');
	}

	function sendToActionscript()
	{
 	 //document.getElementById('boxX').value = val;

	 $('#today_live').css('display', 'none');
	}

    </script>
	<%} %>

<script type="text/javascript">
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


function overimg1(ocode, title){
	var obj = document.getElementById('test_id1');
	obj.innerHTML = 
	"<a  href=\"javascript:link_open('../video/video_player.jsp?ocode="+ocode+"')\" onclick='StopSilverlight();' >"+title+"</a>"; 
}
function overimg2(ocode, title){
	var obj = document.getElementById('test_id2');
	obj.innerHTML = 
	"<a  href=\"javascript:link_open('../video/video_player.jsp?ocode="+ocode+"')\" onclick='StopSilverlight();' >"+title+"</a>"; 
}
function overimg3(ocode, title){
	var obj = document.getElementById('test_id3');
	obj.innerHTML = 
	"<a  href=\"javascript:link_open('../video/video_player.jsp?ocode="+ocode+"')\" onclick='StopSilverlight();'  >"+title+"</a>"; 
}

function point_go(ocode){ 
	 $.get("proc_best_point.jsp", { ocode: ocode },  function(data) { 
		// $("#recomcount").html(data); 
		alert('추천 되었습니다!');
		 },   "text" ); 

}
 
//-->
</script>

	<!-- container::컨텐츠 -->
	<div id="container">
	<div id="container_in">
		<div id="main_content">
			
			<!-- main -->
			<div class="section1">
				<%  if(live_v != null && live_v.size() > 0) {
						String temp_server_name = DirectoryNameManager.SV_LIVE_SERVER_IP;
						 if (stream.startsWith("suwon01r") ) {
							 temp_server_name = "livetv.suwon.go.kr"; 
						 }
//////////////////////////////////////////////////////////////
//회원정보 로그화일에 저장
	if ( live_rcode != "" && live_rcode .length() > 0) {
	if(deptcd == null) deptcd = "";
	if(gradecode == null) gradecode = "";
	com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, live_rcode , request.getRemoteAddr(),"R" );

	String GB = "WL";
	int year=0, month=0, date=0;
	Calendar cal = Calendar.getInstance();
	year  = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;
	date = cal.get(Calendar.DATE);

	MenuManager2 mgr2 = MenuManager2.getInstance();
	mgr2.insertHit(live_rcode ,year,month,date,GB);	// 시청 통계 로그
	}
//////////////////////////////////////////////////////////////	
					%>
				<div class="fl">
						<script type="text/javascript" >
							if (AC_FL_RunContent == 0) {
								alert("This page requires AC_RunActiveContent.js.");
							} else {
						 
								AC_FL_RunContent(
									'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
									'width', '703',
									'height', '441',
									'src', '/2013/live/swf/live_wide_main',
					 
									'quality', 'high',
									'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
									'align', 'middle',
									'play', 'true',
									'loop', 'true',
									'scale', 'showall',
									'wmode', 'opaque',
									'devicefont', 'false',
									'id', 'live_wide',
									'bgcolor', '#FFFFFF',
									'name', 'live_wide',
									'menu', 'true',
									'allowFullScreen', 'true',
									'allowScriptAccess','always',
									'movie', '/2013/live/swf/live_wide_main',
									'FlashVars', 'userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>',
									'salign', ''
									); //end AC code
						 
							}
						</script>
							
							<noscript>
							<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="703px" height="441px" id="live" align="middle">
							<param name="allowScriptAccess" value="always" />
							<param name="allowFullScreen" value="true" />
							<param name="movie" value="/2013/live/swf/live_wide_main.swf" />
							<param name="quality" value="high" />
							<param name="bgcolor" value="#000000" />
							 
							<embed src="/2013/live/swf/live_wide_main.swf" quality="high" bgcolor="#000000" width="703px" height="441px" name="live_wide" align="middle" 
								allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash" 
								FlashVars="userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>" 
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
 
							</object>		
						</noscript>
				</div>
				<div class="fr">
					<div class="fr_in">
							<p class="title"><a class="" href="javascript:live_open();" onclick="callToActionscript()" title="생방송 새창으로 보기"><%=live_title %></a></p>
							<p class="subject">
							<%=live_rcontents %>
							</p>
					</div>
				</div>
				<%}
				else
				{
					String main_ocode = "";
					for (Enumeration e = vtBts_4.elements(); e.hasMoreElements();  ) {			 
						com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
							Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
							if (btsBean.getBts_uid() != null && btsBean.getBts_uid().equals("default")) {
								main_ocode = btsBean.getBts_ocode();
							}
		 
							if (btsBean.getBts_uid() != null && btsBean.getBts_uid().equals(today_string)) {  //일자 설정 영상
								main_ocode = btsBean.getBts_ocode();
							} 
					}
					
					Vector main_vod = mMgr.getOMediaInfo(main_ocode);
					if(main_vod != null && main_vod.size()>0){
						try {
							Enumeration best_e = main_vod.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
/////////////////////////////		
	if (oinfo.getOcode() != null && oinfo.getOcode().length() > 0) {
	//회원정보 로그화일에 저장
	if(deptcd == null) deptcd = "";
	if(gradecode == null) gradecode = "";
	com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, main_ocode, request.getRemoteAddr(),"V" );

	String GB = "WV";
	int year=0, month=0, date=0;
	Calendar cal = Calendar.getInstance();
	year  = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;
	date = cal.get(Calendar.DATE);
	MenuManager2 mgr2 = MenuManager2.getInstance();
	mgr2.insertHit(oinfo.getCcode(),year,month,date,GB);	// 시청 통계 로그
	}
//////////////////////////////							
						} catch (Exception e) {
							System.out.println("error message :" + e);
						}
					}
				%>
				
				
				<div class="fl">
					<div id="SilverlightControlHost" class="silverlightHost" >
							<textarea id="player_" style="display:none;" rows="0" cols="0"/>
								<object id="silver_player" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="703" height="441" style="z-index:0;">
							  <param name="source" value="/WowzaPlayer.xap"/> 
<!--					          <param name="initparams" value="Server=<%=DirectoryNameManager.SERVERNAME %>,Post=<%=main_ocode%>,Auto_p=False,Default_q=<%=oinfo.getEncodedfilename() == null || oinfo.getEncodedfilename().length()<= 0 || oinfo.getEncodedfilename().equals("null")?"M":"H"%>"/>
-->
							  <param name="initparams" value="Server=<%=DirectoryNameManager.SERVERNAME %>,Post=<%=main_ocode%>,Auto_p=False,Default_q=M"/>
							  <param name="onError" value="onSilverlightError" />
							  <param name="onLoad" value="onSilverlightLoad" />
							  <param name="background" value="white" />
							  <param name="minRuntimeVersion" value="4.0.50826.0" />
							  <param name="enablehtmlaccess" value="true"/>
							  <param name="autoUpgrade" value="true" />
							  <param name="windowless" value="true" />
							 
							  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=4.0.50826.0" style="text-decoration:none">
					 			  <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight" style="border-style:none"/>
							  </a>
							  </object><iframe title="_sl_historyFrame" id="_sl_historyFrame" style="display:none;visibility:hidden;height:0px;width:0px;border:0px"></iframe>
 						 </textarea>
						 <script type="text/javascript">
						  mplayer('player_');  // embed 테두리 제거 ( textarea 로 감싼후 인클루드한 스크립터 파일에서 getElementById()를 한다.
						 </script>
 					</div> 
				</div>
				<div class="fr">
					<div class="fr_in">
							<div class="title"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle() %></a></div>
							<div class="subject">
							<%=chb.getContent_2( oinfo.getContent_simple() ,"true")%>							
							</div>							
					</div>
					<div class="etc">
						  <ul>
								<li><a href="#url"><img src="../include/images/main/m_etc_icon1.gif" alt="" /><%=oinfo.getHitcount()%></a></li>
								<li><a href="#url"><img src="../include/images/main/m_etc_icon2.gif" alt="" /><%=oinfo.getRecomcount()%></a></li>
								<li class="last"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><img src="../include/images/main/m_etc_icon3.gif" alt="" />새창보기</a></li>
						  </ul>
					</div>
				</div>
				<%}%>
				
			</div>
			<div class="section2">
			    <div class="fl">
					<!-- new_movie -->
					<div class="new_movie">
					   <h3>
					       <div class="tit"><img src="../include/images/main/h3_new.gif" alt="최신영상"/></div>
					   </h3>
					   <div id="popupzone_a">

						<div id="popup_zone_a">
							<div id="popup_num_a">
								<a href="#popup_a" onclick="select_num_a('1');"><img src="../include/images/main/1_on.gif" id="popup_img_a1" alt="1"/></a>						
								<a href="#popup_a" onclick="select_num_a('2');"><img src="../include/images/main/1_on.gif" id="popup_img_a2" alt="2"/></a>						
								<a href="#popup_a" onclick="select_num_a('3');"><img src="../include/images/main/1_on.gif" id="popup_img_a3" alt="3"/></a>	
							</div>
							<div id="photo_zone_a">
							 <% 
						if (new_list0 != null && new_list0.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list0.elements(); e.hasMoreElements(); i++) 
								{
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									
									String temp_ctitle = oinfo.getCtitle(); 
									
									
									if(i == 1){
					%>
								<p id="popup_a1" class="photo_banner_a">
									<%
									}
									%>
									<span class="sub">
										<span class="photo"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
										<span class="txt"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a></span>
									</span>
									<%
									if(i%4 == 0){
										out.println("</p>");
										if(new_list0.size() == i){
											break;
										}
										if(i == 8){
											out.println("<p id='popup_a3'>");
										}else if(i == 4){
											out.println("<p id='popup_a2'>");
										}
									}
							%>
<%
								}
							} catch (Exception e) {
								System.out.println("error message :" + e);
							}
						}
					%>					
									
							</div>
						</div>
						<script type="text/javascript">play_pop_a();</script>
									
					   </div>
					   
					</div>
					<!-- //new_movie -->
				</div>
				<div class="fr">
				<% 
					 
								if(popv_C != null && popv_C.size() > 0){ 
									for(int i=0;i<popv_C.size();i++){
								%>
					<a href="<%=String.valueOf(((Vector)(popv_C.elementAt(i))).elementAt(8))%>" class="view_page" onclick="StopSilverlight();"><img src="/upload/popup/<%=String.valueOf(((Vector)(popv_C.elementAt(i))).elementAt(9))%>" alt="<%=String.valueOf(((Vector)(popv_C.elementAt(i))).elementAt(1))%>"/></a>
					<%
									}
								}
					%>
				</div>
			</div>
			<!-- section3 -->
			<div class="section3">
			    <div class="fl">
					<script type="text/javascript">
					<!--	
						
						$(document).ready(function(){	

						    $("#board_img1").attr('src','../include/images/main/tab_board1_on.gif');  
							$("#board_tab2_view").css("display","none"); 
							$("#board_tab3_view").css("display","none"); 
													 
							$("#board_tab1").click(function() {  
								$("#board_img1").attr('src','../include/images/main/tab_board1_on.gif'); 
								$("#board_img2").attr('src','../include/images/main/tab_board2_off.gif'); 
								$("#board_img3").attr('src','../include/images/main/tab_board3_off.gif'); 
								$("#board_tab1_view").css("display","block");
								$("#board_tab2_view").css("display","none"); 
								$("#board_tab3_view").css("display","none");
								return false;
							});   
							$("#board_tab2").click(function() {  
								$("#board_img1").attr('src','../include/images/main/tab_board1_off.gif'); 
								$("#board_img2").attr('src','../include/images/main/tab_board2_on.gif'); 
								$("#board_img3").attr('src','../include/images/main/tab_board3_off.gif'); 
								$("#board_tab1_view").css("display","none"); 
								$("#board_tab2_view").css("display","block");
								$("#board_tab3_view").css("display","none");
								return false;
							}); 
							$("#board_tab3").click(function() {  
								$("#board_img1").attr('src','../include/images/main/tab_board1_off.gif'); 
								$("#board_img2").attr('src','../include/images/main/tab_board2_off.gif'); 
								$("#board_img3").attr('src','../include/images/main/tab_board3_on.gif'); 
								$("#board_tab1_view").css("display","none"); 
								$("#board_tab2_view").css("display","none");
								$("#board_tab3_view").css("display","block");
								return false;
							}); 
						 });   
					//-->
					</script>
					<!-- board_best -->									   
					<div id="board_best" class="best">
						 <h3><a href="#url" id="board_tab1" ><img id="board_img1" src="../include/images/main/tab_board1_on.gif" alt="주간베스트" /></a></h3>
						 <div id="board_tab1_view" class="best_list">			  
							<div id="popupzone_b">

								<div id="popup_zone_b">
									<div id="popup_num_b">
										<a href="#popup_b" onclick="select_num_b('1');"><img src="../include/images/main/1_on.gif" id="popup_img_b1" alt="1"/></a>						
										<a href="#popup_b" onclick="select_num_b('2');"><img src="../include/images/main/1_on.gif" id="popup_img_b2" alt="2"/></a>						
										<a href="#popup_b" onclick="select_num_b('3');"><img src="../include/images/main/1_on.gif" id="popup_img_b3" alt="3"/></a>	
									</div>
									<div id="photo_zone_b">
<% 
						if (new_week != null && new_week.size() > 0) 
						{
 							try {
								int i = 1;
								for (Enumeration e = new_week.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									
									if (i == 1) {
					%> 										
										<p id="popup_b1" class="photo_banner_b">
								<%
									}
								%>
											<span class="sub">
												<span class="photo"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><img src="<%=imgTmp %>" alt="<%=title%>"/></a></span>
												<span class="ranking">8</span><span class="txt"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=title%></a></span>
											</span>
								<%
									if(i%4 == 0){
										out.println("</p>");
										if(new_week.size() == i){
											break;
										}
										if(i == 8){
											out.println("<p id='popup_b2'>");
										}else if(i == 4){
											out.println("<p id='popup_b3'>");
										}
									}
									
								}
							} 
							catch (Exception e) {
								//out.println("error message :" + e);
							}
						}
							%>
										
									</div>
								</div>
								<script type="text/javascript">play_pop_b();</script>
											
							   </div>
							
						 </div>
						 <h3><a href="#url" id="board_tab2"><img id="board_img2" src="../include/images/main/tab_board2_off.gif" alt="월간베스트" /></a></h3>
						 <div id="board_tab2_view" class="best_list" >
							<div id="popupzone_c">

								<div id="popup_zone_c">
									<div id="popup_num_c">
										<a href="#popup_c" onclick="select_num_c('1');"><img src="../include/images/main/1_on.gif" id="popup_img_c1" alt="1"/></a>						
										<a href="#popup_c" onclick="select_num_c('2');"><img src="../include/images/main/1_on.gif" id="popup_img_c2" alt="2"/></a>						
										<a href="#popup_c" onclick="select_num_c('3');"><img src="../include/images/main/1_on.gif" id="popup_img_c3" alt="3"/></a>	
									</div>
									<div id="photo_zone_c">
<% 
						if (new_month != null && new_month.size() > 0) 
						{
 							try {
								int i = 1;
								for (Enumeration e = new_month.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									
									if (i == 1) {
					%> 										
										<p id="popup_c1" class="photo_banner_c">
									<%
									}
								%>
											<span class="sub">
												<span class="photo"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><img src="<%=imgTmp%>" alt="<%=title%>"/></a></span>
												<span class="ranking">8</span><span class="txt"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=title%></a></span>
											</span>
									<%
									if(i%4 == 0){
										out.println("</p>");
										if(new_month.size() == i){
											break;
										}
										if(i == 8){
											out.println("<p id='popup_c2'>");
										}else if(i == 4){
											out.println("<p id='popup_c3'>");
										}
									}
									
								}
							} 
							catch (Exception e) {
								//out.println("error message :" + e);
							}
						}
							%>		
											
									</div>
								</div>
								<script type="text/javascript">play_pop_c();</script>
											
							   </div>
                            
						 </div>
						 <h3><a href="#url" id="board_tab3"><img id="board_img3" src="../include/images/main/tab_board3_off.gif" alt="년간베스트" /></a></h3>
						 <div id="board_tab3_view" class="best_list">
							<div id="popupzone_d">

								<div id="popup_zone_d">
									<div id="popup_num_d">
										<a href="#popup_d" onclick="select_num_d('1');"><img src="../include/images/main/1_on.gif" id="popup_img_d1" alt="1"/></a>						
										<a href="#popup_d" onclick="select_num_d('2');"><img src="../include/images/main/1_on.gif" id="popup_img_d2" alt="2"/></a>						
										<a href="#popup_d" onclick="select_num_d('3');"><img src="../include/images/main/1_on.gif" id="popup_img_d3" alt="3"/></a>	
									</div>
									<div id="photo_zone_d">
									<%
						if (new_year != null && new_year.size() > 0) 
						{
 							try {
								int i = 1;
								for (Enumeration e = new_year.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									
									if (i == 1) {
					%> 										
										<p id="popup_d1" class="photo_banner_d">
									<%
									}
								%>
											<span class="sub">
												<span class="photo"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><img src="<%=imgTmp%>" alt="<%=title%>"/></a></span>
												<span class="ranking"><img src="../include/images/icon_best11.gif"  alt="11"/></span><span class="txt"><a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=title%></a></span>
											</span>
									<%
									if(i%4 == 0){
										out.println("</p>");
										if(new_month.size() == i){
											break;
										}
										if(i == 8){
											out.println("<p id='popup_d2'>");
										}else if(i == 4){
											out.println("<p id='popup_d3'>");
										}
									}
									
								}
							} 
							catch (Exception e) {
								//out.println("error message :" + e);
							}
						}
							%>			
									</div>
								</div>
								<script type="text/javascript">play_pop_d();</script>
											
							   </div>
							
						 </div>
				   </div>
					<!-- //board_best -->
				</div>
				<div class="fr">
					<!-- honor_board -->
					<div class="honor_board">
					     <h3><div class="tit"><img src="../include/images/main/h3_honor.gif" alt="명예의 전당"/></div></h3>
						 <div id="popupzone_e">
							<div id="popup_zone_e">
								<div id="popup_num_e">
									<a href="#popup_e" onclick="select_num_e('1');"><img src="../include/images/main/1_on.gif" id="popup_img_e1" alt="1"/></a>						
									<a href="#popup_e" onclick="select_num_e('2');"><img src="../include/images/main/1_on.gif" id="popup_img_e2" alt="2"/></a>						
									<a href="#popup_e" onclick="select_num_e('3');"><img src="../include/images/main/1_on.gif" id="popup_img_e3" alt="3"/></a>	
								</div>
								<div id="photo_zone_e">

<% 					
			if (vtBts_2 != null && vtBts_2.size() > 0) {
 			 
				int cnt = 1;
				for (Enumeration e = vtBts_2.elements(); e.hasMoreElements(); cnt++ ) {
				 
					com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
						Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
						if(best_v != null && best_v.size()>0){
							try {
								Enumeration best_e = best_v.elements();
								com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
								String imgTmp = "/2013/include/images/noimg_small.gif";
								 
								if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
									imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();
								}  
								if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
									imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
								} 
								String strTitle = oinfo.getTitle();
								strTitle = strTitle.length()>10?strTitle.substring(0,8)+"...":strTitle;
								
								String strContent = oinfo.getDescription();
								strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
								 
	%>							 
									<p id="popup_e<%=cnt %>" class="photo_banner_e">
										<span class="photo"><a href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" class="view_page" onclick="StopSilverlight();"><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
										<span class="txt"><a href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" class="view_page" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a></span>
									</p>
	<%							
							} catch (Exception best_e) {
								//out.println("error message :"+best_e);
							}
						}
				}

			}						
%>									 
 
									
								</div>
							</div>
							<script type="text/javascript">play_pop_e();</script>
										
						   </div>
					</div>
					<!-- //honor_board -->
				</div>
			</div>
			<!-- //section3 -->
			<!-- section4 -->
			<div class="section4">
				<div class="fl">
					<div class="fl_box1">
						<div class="board_movie">
						   <h3><img src="../include/images/main/h3_board_movie.gif" alt="추천영상"/></h3>
							<ul>
<% 					
		if (vtBts_1 != null && vtBts_1.size() > 0) {
 		 
			int cnt = 1;
			for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++ ) {
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo_cate(String.valueOf(btsBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
						
							String imgTmp = "/2013/include/images/noimg_small.gif";
							 
							if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
								imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();
							}  
							if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
								imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
							}
							String strTitle = oinfo.getTitle();
							strTitle = strTitle.length()>10?strTitle.substring(0,8)+"...":strTitle;
							
							String strContent = oinfo.getDescription();
							strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
							
						 
							//out.println(oinfo.getCtitle()+oinfo.getOcode());
%>							
								<li><a href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" class="view_page" onclick="StopSilverlight();">[<%=oinfo.getCtitle()%>] <%=oinfo.getTitle()%></a></li>
<%							
						} catch (Exception best_e) {
							System.out.println("error message :"+best_e);
						}
					}
			}

		} 			
%>								
							</ul>
						</div>
					</div>
					<div class="fl_box2">
					    <div class="board_notice">
						   <h3><img src="../include/images/main/board_notice.gif" alt="공지사항"/><span class="more"><a href="#url"><img src="../include/images/main/h3_more.gif" alt="더보기"/></a></span></h3>
						   <ul>
						   <% 
					if (noticeVt1 != null && noticeVt1.size() > 0) {
						String list_title = "";
						String list_date = "";
						String list_contents = "";
						try {
							for (Enumeration e = noticeVt1.elements(); e.hasMoreElements();) {
								com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement());
					 %>
								<li><a class="view_page" href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>" onclick="StopSilverlight();"><%=bliBean.getList_title() %></a></li>
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
				<div class="fr">
					<!-- popup -->
					<script type="text/javascript" src="../include/js/gallery.js" charset="utf-8"></script>
					<div id="popup" >
						<dl class="popup_list">
						<% 
					 
								if(popv_M != null && popv_M.size() > 0){ 
									for(int i=0;i<popv_M.size();i++){
								%>
							<dt><%=i+1%></dt>
							<dd><a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>" target="_blank"><img src="/upload/popup/<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(9))%>"  alt="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%>"/></a></dd>
						<%
										} 
									}
								%> 
							
						</dl>
						<div class="btn">
							<a href="#popupZone" onclick="showHide('popupList');return false;"><img src="../include/images/main/popup_list.gif" alt="팝업 목록전체보기" /></a>
							<a href="#popupzone" class="btn-play" ><img src="../include/images/main/btn_play.gif" alt="팝업존 재생" /></a>
							<a href="#popupzone" class="btn-stop" ><img src="../include/images/main/btn_pause.gif" alt="팝업존 일시정지" /></a>							
							<!-- popupList -->
							<div id="popupList" style="display:none;">
								<ul>			
								<% 
					 
								if(popv_M != null && popv_M.size() > 0){ 
									for(int i=0;i<popv_M.size();i++){
								%>								
										<li>
										<a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>" target="_blank" title="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%> 새창열기"><%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%></a>
										</li>
								<%
										} 
									}
								%> 										
										
								</ul>
							</div>
							<!-- //popupList -->

						</div>
					</div>
					<script type="text/javascript">
						$("#popup").photoGallery();
					</script>
					<!-- //popup -->
				</div>					
			</div>
			<!-- //section4 -->
		</div>
		<!-- //main -->
			
		</div>		
	</div>
	<div class="family">
		 <ul class="family_in">
			<li><a href="http://www.suwon.go.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/family_bann01.gif" alt="수원시"/></a></li>
			<li><a href="http://news.suwon.go.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/family_bann02.gif" alt="e-수원뉴스"/></a></li>
			<li><a href="http://photo.suwon.go.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/family_bann03.gif" alt="포토뉴스"/></a></li>
			<li><a href="http://ebook.suwon.ne.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/family_bann04.gif" alt="e-자료홍보관"/></a></li>
			<li><a href="http://symbol.suwon.ne.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/family_bann05.gif" alt="수원시 상징물"/></a></li>
			<li><a href="https://ite.suwon.go.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/family_bann06.gif" alt="시민정보화교육"/></a></li>
		</ul>
	</div>

	</div>
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
%>
<script type="text/javascript">

<%

out.println(subject_script);
out.println(event_script);
out.println(hot7_script);
//라이브 팝업창을 바로 뛰우지 않는다.

//out.println(play_btn);
//라이브 팝업 안내창을 뛰운다.

//out.println(live_popup);

%>
</script>
	
<%@ include file = "../include/html_foot.jsp"%>

