<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
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
SimpleDateFormat today_sdf = new SimpleDateFormat("yyyy.MM.dd");
String today_string = today_sdf.format(day);
 
try {
 	if (today_string.substring(8,10).trim().equals("01")) {
		mMgr.insertMohth_log();
	}
} catch (Exception e) {
	System.out.println("월간 로그 등록 에러");
}

/////////////////////////////
// 오늘의 주요 영상 (금주의영상)
	
BestWeekManager bwMgr = BestWeekManager.getInstance();
Vector bwVt = bwMgr.getBestWeekInfo("A");
 
if(bwVt != null && bwVt.size() > 0) {
	Enumeration e = bwVt.elements();
	com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)e.nextElement());
 
} 

///////////////////////////////////
	Vector new_list0 = new Vector();

	Vector new_list1 = new Vector();
	Vector new_list2 = new Vector();
	Vector new_list3 = new Vector();
	Vector new_list4 = new Vector();
	Vector new_list5 = new Vector();
	
	Vector new_list6 = new Vector();
	Vector new_list7 = new Vector();
	Vector new_list8 = new Vector();
	Vector new_list9 = new Vector();

	new_list0 = mMgr.getMediaListNew(5); //뉴스
	
	new_list1 = mMgr.getMediaList_count("001", 5); //뉴스
	new_list2 = mMgr.getMediaList_count("002", 5); //버라이어티
	new_list3 = mMgr.getMediaList_count("003", 5); // 라이프
	new_list4 = mMgr.getMediaList_count("004", 5); // 시청자
	
	new_list5 = mMgr.getMediaList_count_order("001","hitcount", 10); // 가장많이 본 뉴스
	new_list6 = mMgr.getMediaList_count_order_not("001","hitcount", 10); // 가장많이 본 영상
	
	new_list7 = mMgr.getMediaList_count_order("003","hitcount", 1); // 라이프 플러스
	new_list8 = mMgr.getMediaList_count("006", 4); // 생방송
	new_list9 = mMgr.getMediaList_count("005", 4); // 홍보영상

	Vector noticeVt1 = blsBean.getRecentBoardList_open(10, 7); // 공지 (board_id, limit)
	Vector noticeVt2 = blsBean.getRecentBoardList_open(16, 1); // 제작노트 (board_id, limit)
 
/////////////////////////////////////
// bestTop (관리자 지정 영상/ 화재의 영상, 명예의 전당, hot뉴스)
BestMediaManager Best_mgr = BestMediaManager.getInstance();
	
Vector vtBts_1 = new Vector();
Vector vtBts_2 = new Vector();
Vector vtBts_3 = new Vector();
vtBts_1 = Best_mgr.getBestTopSubList_order(2, 4); // 화재의 영상
vtBts_2 = Best_mgr.getBestTopSubList_order(3, 4); // 명예의 전당
vtBts_3 = Best_mgr.getBestTopSubList_order(4, 4); // HOT 뉴스

 
//Vector v_live = skinMgr.getNowLive();
//========================================================
	String play_btn = "";
	String live_popup = "";
	
try {

	String cur_date = TimeUtil.getDetailTime();
      cur_date = cur_date.substring(0,19);

      String query = "select a.mtitle,b.ralias, b.mcode,b.rcode from media a, real_media b where (a.mcode=b.mcode) and ((b.rstart_time <= '" +
              cur_date+ "') and " + "(b.rend_time >= '" +cur_date+ "'))";

      Vector v_onair = mMgr.selectQuery(query);


      if(v_onair != null && v_onair.size() > 0) {
			//play_btn = "live_view('"+v_onair.elementAt(1)+"&mcode=" +v_onair.elementAt(2)+ "&rcode=" +v_onair.elementAt(3)+"');";
			live_popup = "window.open('/2013/live/live_info.jsp','live_comment', 'width=300, height=250, scrollbars=no, toolbars=no');";
      } 
  }catch(Exception e) {}

//==========================================================
 

	String[] pop_seq = null;
	String seq = null;
	String pos_x = "";
	String pos_y = "";
	String p_width = "";
	String p_height = "";

	String[] pop_script = null;
	String[] pop_scriptM = null;
	PopupManager pMgr = new PopupManager();
	Vector popv_P = pMgr.getVisible_flag("P");  // flag = P  popup , M main
	Vector popv_M = pMgr.getVisible_flag("M");  // flag = P  popup , M main
	
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
				pop_height = Integer.parseInt(p_height)+150;		
			}
			int pop_width = 160;
			if (p_width != null && p_width.length() > 0) {
				pop_width = Integer.parseInt(p_width)+8;		
			}	
				pop_script[i] = "window.open('/2013/info/popup_dd.jsp?seq="+seq+"', 'vodcaster_"+i+"', 'left="+pos_x+", top="+pos_y+", width="+pop_width+", height="+pop_height+", scrollbars=no, toolbars=no');";

			pop_seq[i] = seq;
		}
	}



SubjectManager smgr = SubjectManager.getInstance();
Vector subject = null;
String subject_script = "";
subject = smgr.getSubjectListDate("S");  // 설문

if( subject != null && subject.size() >= 4 && Integer.parseInt( String.valueOf(subject.elementAt(4))) >=  Integer.parseInt( String.valueOf(subject.elementAt(12))) ) {
        subject_script = "if ( getCookie( \"subject\" ) != \"true\" ) { \n" +
                "noticeWindow2  =  window.open(\"/2013/info/event_info.jsp?sub_flag=S\", \"subject\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=300\");\n" +
                "noticeWindow2.opener = self; \n" +
                "} ";
  }

Vector event = null;
String event_script ="";
event = smgr.getSubjectListDate("E") ; //이벤트
if( event != null && event.size() >= 4 && Integer.parseInt( String.valueOf(event.elementAt(4))) >=  Integer.parseInt( String.valueOf(event.elementAt(12))) ) {
        event_script = "if ( getCookie( \"event\" ) != \"true\" ) { \n" +
                "noticeWindow3  =  window.open(\"/2013/info/event_info.jsp?sub_flag=E\", \"event\", \"status=no,scrollbars=no,width=400,height=300,top=120,left=500\");\n" +
                "noticeWindow3.opener = self; \n" +
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


%>

<%@ include file = "../include/html_head.jsp"%>
<script type="text/javascript">

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
</script>
	<!-- container::컨텐츠 -->
	<div id="container">
		<div id="content">
			<div class="sectionTop">
				<div class="silver">
					<span class="hot"><span>SUWON iTV TODAY</span>오늘의 주요 영상</span>
					<div class="vod">
						<img src="../include/images/img2.gif" alt="자세히보기" width="521" height="339"/>
					</div>
					<span class="sub">
						<span class="title"><a><%=oinfo.getTitle() %></a></span>
						<span class="subject"><%=oinfo.getContent_simple() %></span>
<!-- 						<span class="more"><a href="#"><img src="../include/images/btn_today_more.gif" alt="자세히보기"/></a></span> -->
					</span>
				</div>
				
				<div class="NewTab list1 jx">
					 
					<ul>
					<li class="active total"><a href="#"><span class="newTitle">수원iTV<span>최신영상</span></span></a>
					<ul>
					<% 
							if (new_list0 != null && new_list0.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list0.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>	
					
	 						</ul>
						</li>
						<li ><a href="#"><span class="newTitle">뉴스</span></a>
							<ul>
					<% 
							if (new_list1 != null && new_list1.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list1.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>								 
								<li class="more"><a href="../video/video_list.jsp?ccode=001000000000" title="뉴스"><img src="../include/images/btn_itv_more.gif" alt="더보기"/></a></li>
							</ul>
						</li>
						<li><a href="#"><span class="newTitle">버라이어티</span></a>
							<ul>
					<% 
							if (new_list2 != null && new_list2.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list2.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
								<li class="more"><a href="../video/video_list.jsp?ccode=002000000000" title="버라이어티"><img src="../include/images/btn_itv_more.gif" alt="더보기"/></a></li>
							</ul>
						</li>
						<li><a href="#"><span class="newTitle">라이프</span></a>
							<ul>
					<% 
							if (new_list3 != null && new_list3.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list3.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
								<li class="more"><a href="../video/video_list.jsp?ccode=003000000000" title="라이프"><img src="../include/images/btn_itv_more.gif" alt="더보기"/></a></li>
							</ul>
						</li>
						<li><a href="#"><span class="newTitle">시청자</span></a>
							<ul>
					<% 
							if (new_list4 != null && new_list4.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list4.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
								<li class="more"><a href="../video/video_list.jsp?ccode=004000000000" title="시청자"><img src="../include/images/btn_itv_more.gif" alt="더보기"/></a></li>
							</ul>
						</li>

					</ul>
				</div>
			</div>
			<div class="sectionCen">
				<div class="NewTab list2">
					<ul>
						<li class="active"><a href="#"><span>가장 많이 본 뉴스</span></a>
							<ul>
							
					<% 
							if (new_list5 != null && new_list5.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list5.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
					%> 	 
								<li><span class="time"><img src="../include/images/icon_best<%=i %>.gif" alt="<%=i %>"/></span> <a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><strong>[<%=oinfo.getCtitle() %>]</strong> <%=oinfo.getTitle()%></a> </li>
  
					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
							</ul>
						</li>
						<li><a href="#"><span>가장 많이 본 영상</span></a>
							<ul>
					<% 
							if (new_list6 != null && new_list6.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list6.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
					%> 	 
								<li><span class="time"><img src="../include/images/icon_best<%=i %>.gif" alt="<%=i %>"/></span> <a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><strong>[<%=oinfo.getCtitle() %>]</strong> <%=oinfo.getTitle()%></a> </li>
  
					<%
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
					
				<div class="NewTab list3">
					<h3>화제의 영상</h3>
					<ul>
<% 					
			if (vtBts_1 != null && vtBts_1.size() > 0) {
 			String list_img = "/include/skin/images/noimage.gif";

			int cnt = 1;
			for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++ ) {
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
						
							String imgurl ="/vodman/include/images/no_img01.gif";
							String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/"+oinfo.getModelimage();
							String strTitle = oinfo.getTitle();
							strTitle = strTitle.length()>10?strTitle.substring(0,8)+"...":strTitle;
							
							String strContent = oinfo.getDescription();
							strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
							
							if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
								imgTmp = imgurl;
							}
%>
				
						<li <%if (cnt ==1) { %> class="active" <%} %>><a href="#"><span class="newTitle"><%=cnt %></span></a>
							<ul>
								<li>
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<a class="view_page" href="../video/video_player2.jsp?ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								</li>
							</ul>
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
				
				<div class="mLife">
					<h3>라이프 플러스</h3>
					<ul>
					<li>
					<% 
							if (new_list7 != null && new_list7.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list7.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
					
								
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
					</li>
					 <%
				 
					Vector links =Best_mgr.getList_link();			 
					String list_link = "";		 
					if(links != null && links.size() >0){
					 
						list_link = String.valueOf(links.elementAt(2));
					}
					 %>
					 </ul>
					<span class="more"><a href="<%=list_link%>"><img src="../include/images/btn_life_organ.gif" alt="편성표"/></a></span>
				</div>
				
				<div class="NewTab list4">
					<h3>명예의 전당</h3>
					<ul>
<% 					
			if (vtBts_2 != null && vtBts_2.size() > 0) {
 			String list_img = "/include/skin/images/noimage.gif";

			int cnt = 1;
			for (Enumeration e = vtBts_2.elements(); e.hasMoreElements(); cnt++ ) {
			 
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
						
							String imgurl ="/vodman/include/images/no_img01.gif";
							String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/"+oinfo.getModelimage();
							String strTitle = oinfo.getTitle();
							strTitle = strTitle.length()>10?strTitle.substring(0,8)+"...":strTitle;
							
							String strContent = oinfo.getDescription();
							strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
							
							if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
								imgTmp = imgurl;
							}
%>
						<li <%if (cnt ==1) { %> class="active" <%} %>><a href="#"><span class="newTitle"><%=cnt %></span></a>
							<ul>
								<li>
									<span class="img"><a class="view_page" href="../video/video_player2.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playSmall"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<a class="view_page" href="../video/video_player2.jsp?ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
									</span>
								</li>
							</ul>
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
				
				<div class="mNote">
					<h3>제작현장</h3>
					
					<% 
					if (noticeVt2 != null && noticeVt2.size() > 0) {
						String list_title = "";
						String list_date = "";
						String list_contents = "";
						try {
							for (Enumeration e = noticeVt2.elements(); e.hasMoreElements();) {
								com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement());
					 %>
					  
					 	<span class="img"><a class="view_page" href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><img src="../include/images/img.gif" alt="이미지명"/></a></span>
						<span class="total">
						<a class="view_page" href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><%=bliBean.getList_title() %></a>
						</span>
					
					 <% 
 							}
						} catch (Exception e) {
						}
					}
					%>
						
					<span class="more"><a href="../board/board_list.jsp?board_id=16"><img src="../include/images/btn_itv_more.gif" alt="더보기"/></a></span>
				</div>
				<div class="mNotice">
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
					 %>
					 	<li><a class="view_page" href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><%=bliBean.getList_title() %></a></li>
					 <% 
 							}
						} catch (Exception e) {
						}
					}
					%> 
					</ul>
					<span class="more"><a href="../board/board_list.jsp?board_id=10"><img src="../include/images/btn_itv_more.gif" alt="더보기"/></a></span>
				</div>
				
				<div id="popupzone">
					<div class="mainVInfo_Popup">
						<ol id="popup">

					<%	
					int pop_size = 0;  // 6개까지만 보여줌
						if (popv_M != null && popv_M.size() > 6) 
						{
							pop_size = 6;
						} else {
							pop_size =  popv_M.size();
						}
						
						if(popv_M != null && popv_M.size() > 0){ 
							for(int i=0;i<pop_size;i++){
					%>
							<li>
								<a href="#popupZone" class="btn" title="<%=i+1 %> 팝업"><img id="popupZoneBtn<%=i+1 %>" src="../include/images/popup_<%=i+1 %>_on.gif" class="num" alt="<%=i+1 %> 팝업" /></a>
								<a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>" class="popupZoneImg" target="_self"><img src="/upload/popup/<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(9))%>" alt="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%>" class="pop_img"/></a>
							</li>
					 
					<%
							} 
						}
					%>							
							
						 
						</ol>
						<div class="controller" id="popbtn">
							<ul>
								<li><a href="#popupZone" onclick="showHide('popupList');return false;"><img src="../include/images/popup_list.gif" alt="목록" /></a>
									<div id="popupList" style="display:none;">
										<ul>
					<% 
						if(popv_M != null && popv_M.size() > 0){ 
							for(int i=0;i<pop_size;i++){
					%>
							<li>
							<a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>" target="_self"><%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%></a>
							</li>
							  
					<%
							} 
						}
					%>
										
									 
										</ul>
									</div>
								</li>
								<li><a href="#popupZone" onclick="roll.pause(); return false;"><img id="bannerStop" src="../include/images/popup_stop.gif" alt="정지" /></a></li>
								<li><a href="#popupZone" onclick="roll.resume(); return false;"><img id="bannerPlay" src="../include/images/popup_play.gif" alt="시작" /></a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- //팝업존 -->
			</div>
			
		</div>

		<div class="mAside">
			<div class="photobank">
				<h3>포토뱅크</h3>
				<ul>
				<li class="big">
					<span class="img"><a href=""><img src="../include/images/img.gif" alt="이미지명"/></a></span>
					<span class="total">
						 
						<a href="#">것부터것부터것부터것부터작은 것부터 하나씩</a>
					</span>
				</li>
				<li class="small">
					<span class="img"><a href=""><img src="../include/images/img.gif" alt="이미지명"/></a></span>
				</li>
				<li class="small">
					<span class="img"><a href=""><img src="../include/images/img.gif" alt="이미지명"/></a></span>
				</li>
				<li class="small">
					<span class="img"><a href=""><img src="../include/images/img.gif" alt="이미지명"/></a></span>
				</li>
				</ul>
			</div>
			<div class="hotnews">
				<h3>HOT 뉴스</h3>
				<ul>
<% 					
			if (vtBts_3 != null && vtBts_3.size() > 0) {
 			String list_img = "/include/skin/images/noimage.gif";

			int cnt = 1;
			for (Enumeration e = vtBts_3.elements(); e.hasMoreElements(); cnt++ ) {
			 
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
						
							String imgurl ="/vodman/include/images/no_img01.gif";
							String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/"+oinfo.getModelimage();
							String strTitle = oinfo.getTitle();
							strTitle = strTitle.length()>10?strTitle.substring(0,8)+"...":strTitle;
							
							String strContent = oinfo.getDescription();
							strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
							
							if(oinfo.getModelimage()== null || oinfo.getModelimage().length() <=0 ||oinfo.getModelimage().equals("null")) {
								imgTmp = imgurl;
							}
%>

				 <%if (cnt ==1) { %>
				<li class="big">
					<span class="img"><a class="view_page" href="../video/video_player2.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
					<span class="total">
						
						<a class="view_page" href="../video/video_player2.jsp?ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
					</span>
				</li>
				<%} else { %>
				<li class="small">
					<span class="img"><a class="view_page" href="../video/video_player2.jsp?ocode=<%=oinfo.getOcode()%>"><span class="playSmall2"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
				</li>
				<%} %>
				
<%							
						} catch (Exception best_e) {
							out.println("error message :"+best_e);
						}
					}
			}
			if (cnt < 4) {
				for (int c = cnt ; c < 4; c++) {
					%>
					<li class="small">
					<span class="img"><span class="playSmall2"></span><img src="/include/skin/images/noimage.gif" alt="등록된 정보가 업습니다."/></span>
					</li>
					<% 
				}
			}

		}						
%>				
 
				</ul>
			</div>
			<div class="live">
				<h3>생방송</h3>
				<ul>
				<% 
							if (new_list8 != null && new_list8.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list8.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
 
				<%if (i == 1) { %>				
				<li class="big">
					<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
					<span class="total">
						
						<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
					</span>
				</li>
				<%} else { %>
				<li class="small">
					<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall2"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
				</li>
				<%} %>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						} else {
						 
								 
									%>
				<li class="big">
					<span class="img"> <span class="playMid"></span><img src="/2013/include/images/default_img.jpg" alt="등록된 정보가 없습니다"/> </span>
					<span class="total"> 등록된 정보가 없습니다. 
					</span>
				</li>
									<% 
						}
					%>	
					 
				</ul>
			</div>
			<div class="promote">
				<h3>홍보영상</h3>
				<ul>
				<% 
							if (new_list9 != null && new_list9.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list9.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
					%>
 
				<%if (i == 1) { %>				
				<li class="big">
					<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playMid"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
					<span class="total">
						
						<a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><%=oinfo.getTitle()%></a>
					</span>
				</li>
				<%} else { %>
				<li class="small">
					<span class="img"><a class="view_page" href="../video/video_player2.jsp?ccode=<%=oinfo.getCcode()%>&amp;ocode=<%=oinfo.getOcode()%>"><span class="playSmall2"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
				</li>
				<%} %>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}else {
				%>
				<li class="big">
					<span class="img"><span class="playMid"></span><img src="/2013/include/images/default_img.jpg" alt="등록된 정보가 없습니다"/></span>
					<span class="total"> 등록된 정보가 없습니다. 
					</span>
				</li>
				<% 							 
					 }
					%>	
				 
				</ul>
			</div>
			
		</div>
		<div class="family">
			<a href="http://www.suwon.go.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/suwon.gif" alt="수원시"/></a>
			<a href="http://news.suwon.go.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/suwonnews.gif" alt="e-수원뉴스"/></a>
			<a href="http://edu.suwon.ne.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/edu.gif" alt="수원시 인터넷수능방송"/></a>
			<a href="http://ebook.suwon.ne.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/e_data.gif" alt="e-자료홍보관"/></a>
			<a href="http://symbol.suwon.ne.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/symbol.gif" alt="수원시 상징물"/></a>
			<a href="https://ite.suwon.go.kr/" title="새창으로 연결합니다." target="_blank"><img src="../include/images/ite.gif" alt="시민정보화교육"/></a>
		</div>
	</div>
<%@ include file = "../include/html_foot.jsp"%>

<%
	if(popv_P != null && popv_P.size() > 0) {
		for (int i = 0; i < pop_seq.length; i++) {
			// IE일때 쿠키검사 후 팝업
				out.println("<script type='text/javascript'>");
				out.println("var isPop = isPopupView(\'"+pop_seq[i]+"\');");
				out.println("if (isPop) {");
				out.println(pop_script[i]);
				out.println("}</script>");
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
out.println(live_popup);

%>
</script>