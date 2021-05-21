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

String ocode = "";
String list_id = "";
 
if ( request.getParameter("link_ocode") != null && request.getParameter("link_ocode").length() > 0 ) {
	ocode = request.getParameter("link_ocode");
	if (ocode.length() < 16  && (com.vodcaster.utils.TextUtil.isNumber(ocode))) {
	       ocode = MediaManager.getInstance().getReturn_ocode(ocode);
		} 
} else if ( request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0  ) {
	if (com.vodcaster.utils.TextUtil.isNumber(request.getParameter("list_id"))) {
	list_id = request.getParameter("list_id");
	} 
} 

MediaManager mMgr = MediaManager.getInstance();

java.util.Date day = new java.util.Date();
SimpleDateFormat today_sdf = new SimpleDateFormat("yyyy-MM-dd");
String today_string = today_sdf.format(day);
 
///////////////////////////////////
	Vector new_list0 = new Vector();
 
	new_list0 = mMgr.getMediaListNew(5); //���� 

	Vector noticeVt1 = blsBean.getRecentBoardList_open_top(10, 5); // ���� (board_id, limit)
//	Vector noticeVt2 = blsBean.getRecentBoardList_open(16, 1); // ���۳�Ʈ (board_id, limit)
 
/////////////////////////////////////
// bestTop (������ ���� ����/ ȭ���� ����, ���� ����, hot����)

BestMediaManager Best_mgr = BestMediaManager.getInstance();
	
Vector vtBts_1 = new Vector();
Vector vtBts_2 = new Vector();
//Vector vtBts_3 = new Vector();
Vector vtBts_4 = new Vector();

vtBts_1 = Best_mgr.getBestTopSubList_order(2, 5); // ȭ���� ����
//vtBts_2 = Best_mgr.getBestTopSubList_order(3, 6); // ���� ����
//vtBts_3 = Best_mgr.getBestTopSubList_order(4, 4); // HOT ����

//vtBts_4 = Best_mgr.getBestTopSubList_order(1, 7); // ���� ����
 
vtBts_4 = Best_mgr.getBestTopSubList_toDay(1); // ���ο��� ��ü
 
//========================================================
// ����� ���� ��������
 // html_head.jsp �� �̵�

//==========================================================
// �˾� ���� ��������


	String[] pop_seq = null;
	String seq = null;
	String pos_x = "";
	String pos_y = "";
	String p_width = "";
	String p_height = "";

	String[] pop_script = null;
	String[] pop_scriptM = null;
	PopupManager pMgr = new PopupManager();
	Vector popv_P = pMgr.getVisible_dateflag("P");  // flag = P  popup , M main, C �̽�
	Vector popv_M = pMgr.getVisible_dateflag("M");  // flag = P  popup , M main, C �̽�
	Vector popv_C = pMgr.getVisible_dateflag("C");  // flag = P  popup , M main, C �̽�
	
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
// ���� ���� ��������



SubjectManager smgr = SubjectManager.getInstance();
Vector subject = null;
String subject_script = "";
subject = smgr.getSubjectListDate("S");  // ����

if( subject != null && subject.size() >= 4 && Integer.parseInt( String.valueOf(subject.elementAt(4))) >=  Integer.parseInt( String.valueOf(subject.elementAt(12))) ) {
        subject_script = "if ( getCookie( \"subject\" ) != \"true\" ) { \n" +
                "noticeWindow2  =  window.open(\"/2013/info/event_info.jsp?sub_flag=S\", \"subject\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=300\");\n" +
                "if(noticeWindow2){noticeWindow2.opener = self;} \n" +
                "} ";
  }

Vector event = null;
String event_script ="";
event = smgr.getSubjectListDate("E") ; //�̺�Ʈ
if( event != null && event.size() >= 4 && Integer.parseInt( String.valueOf(event.elementAt(4))) >=  Integer.parseInt( String.valueOf(event.elementAt(12))) ) {
        event_script = "if ( getCookie( \"event\" ) != \"true\" ) { \n" +
                "noticeWindow3  =  window.open(\"/2013/info/event_info.jsp?sub_flag=E\", \"event\", \"status=no,scrollbars=no,width=400,height=300,top=120,left=500\");\n" +
                "if(noticeWindow3){noticeWindow3.opener = self;} \n" +
                "} ";
  }

Vector hot7 = null;
String hot7_script ="";
hot7 = smgr.getSubjectListDate("H") ; //�ּ���
 
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
	Vector new_week = mMgr.getMediaList_count_week("","hitcount", 1); // �ְ�
	Vector new_month = mMgr.getMediaList_count_month("","hitcount", 1); // ���� ����
	Vector new_year = mMgr.getMediaList_count_year("","hitcount", 1); // �Ⱓ ����
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
<% if ( request.getParameter("link_ocode") != null && request.getParameter("link_ocode").length() > 0 ) { %> 
window.link_open('/2013/video/video_player.jsp?ocode=<%=ocode%>');
<% } else if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0) { %>

window.link_open('/2013/board/board_view.jsp?board_id=<%=request.getParameter("board_id")%>&list_id=<%=list_id%>');
<% } %>
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
	"<a  href=\"javascript:link_open('../video/video_player.jsp?ocode="+ocode+"')\" onclick='videoStop();' >"+title+"</a>"; 
}
function overimg2(ocode, title){
	var obj = document.getElementById('test_id2');
	obj.innerHTML = 
	"<a  href=\"javascript:link_open('../video/video_player.jsp?ocode="+ocode+"')\" onclick='videoStop();' >"+title+"</a>"; 
}
function overimg3(ocode, title){
	var obj = document.getElementById('test_id3');
	obj.innerHTML = 
	"<a  href=\"javascript:link_open('../video/video_player.jsp?ocode="+ocode+"')\" onclick='videoStop();'  >"+title+"</a>"; 
}

function point_go(ocode, id){ 
	 $.get("proc_best_point.jsp", { ocode: ocode },  function(data) { 
		 $("#recomcount"+id).html(data); 
			alert('��õ �Ǿ����ϴ�!');
		 },   "text" ); 
} 
function pop_link(link){
	window.link_open(link);
	videoStop();
		
}

function videoPlayer(ocode){
 
	document.getElementById("play_ocode").value=ocode
	var obj = document.getElementById("play"+ocode);
	obj.innerHTML =
'<iframe title="������ ��� â" id="'+ocode+'" name="js_player'+ocode+'" src="/videoJs/jsPlayer.jsp?ocode='+ocode+'&type=main" scrolling="no" width="1024" height="576" marginwidth="0" frameborder="0" framespacing="0"  allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true"></iframe>';
}

 
function videoStop(){ 
		var play_ocode =  document.getElementById("play_ocode").value;
		if (play_ocode != '') {
			document.getElementById(play_ocode).contentWindow.pause();
		} 
}	
 
 

//-->
</script>
<input type="hidden" id="play_ocode" value=""/>

	<div id="body">

		<div class="container_top">

			<div class="section">

				<div class="main_vod">

					<div id="popupzone_a">
					
					<%  if(live_v != null && live_v.size() > 0) {
						String temp_server_name = DirectoryNameManager.SV_LIVE_SERVER_IP;
						 if (stream.startsWith("suwon01r") ) {
							 temp_server_name = "livetv.suwon.go.kr"; 
						 }
//////////////////////////////////////////////////////////////
//ȸ������ �α�ȭ�Ͽ� ����
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
	mgr2.insertHit(live_rcode ,year,month,date,GB);	// ��û ��� �α�
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
									'width', '1024',
									'height', '576',
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
							 
							<embed src="/2013/live/swf/live_wide_main.swf" quality="high" bgcolor="#000000" width="1204px" height="576px" name="live_wide" align="middle" 
								allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash" 
								FlashVars="userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>" 
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
 
							</object>		
						</noscript>
						
						<span class="data">
							<a href="javascript:videoPlayer('<%=oinfo.getOcode()%>' );" class="entry-title"><%=live_title %></a>
							<span class="subject"><%=chb.getContent_2( oinfo.getContent_simple() ,"true")%><%=live_rcontents %></span>
							<span class="blank"><a class="" href="javascript:live_open();" onclick="videoStop();"><img src="../include/images/main/btn_blank.gif"  alt="��â" /></a></span>
						</span>
				</div>
<!-- 				<div class="fr"> -->
<!-- 					<div class="fr_in"> -->
<%-- 							<p class="title"><a class="" href="javascript:live_open();" onclick="callToActionscript()" title="����� ��â���� ����"><%=live_title %></a></p> --%>
<!-- 							<p class="subject"> -->
<%-- 							<%=live_rcontents %> --%>
<!-- 							</p> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<%}
				else
				{ %>

						<div id="popup_zone_a">
							<div id="popup_btn_a1">
								<a href="#popup_a_1" onclick="change_popup_a(current_popup_a-1);videoStop();" title="����"><img src="../include/images/main/btn_left.gif"  alt="����" /></a> 
							</div>

							<div id="photo_zone_a" class="basic_photo_banner">	
 
															 
							<%
							 if (vtBts_4 != null && vtBts_4.size() > 0) {
								 
 							try {
 								
								int i = 1;
								for (Enumeration e = vtBts_4.elements(); e.hasMoreElements(); i++) 
								{
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement()); 
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									
									String temp_ctitle = oinfo.getCtitle();	 
					%>
							
							   <p id="popup_a<%=i%>">
							  
									<span class="thumb" id="play<%=oinfo.getOcode()%>">
										<a href="javascript:videoPlayer('<%=oinfo.getOcode()%>' );">
											<img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/>
											<span class="play_icon"></span>
										</a>
									</span>

									<span class="data">
										<a href="javascript:videoPlayer('<%=oinfo.getOcode()%>' );" class="entry-title"><%=oinfo.getTitle()%></a>
										<span class="like"><a href="javascript:point_go('<%=oinfo.getOcode()%>','<%=i%>');"><span id="recomcount<%=i%>"><%=oinfo.getRecomcount()%></span></a></a></span>
										<span class="subject"><%=chb.getContent_2( oinfo.getContent_simple() ,"true")%></span>
										<span class="blank"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="videoStop();"><img src="../include/images/main/btn_blank.gif"  alt="��â" /></a></span>
									</span>
								</p>
					<%
								}
							} catch (Exception e) {
								System.out.println("error message :" + e);
							}
						}
					%>	  

							</div>

							<div id="popup_btn_a2">
								<a href="#popup_a_1" onclick="change_popup_a(current_popup_a+1);videoStop();" title="����"><img src="../include/images/main/btn_right.gif" alt="����" /></a>
							</div> 
						</div>

						<script type="text/javascript">
// 						play_pop_a();
						change_popup_a(<%=(int)(Math.random()*vtBts_4.size())%>);
						</script> 
						
					<%}%>
					</div> 
				</div> 

			</div>

		</div>

		<div class="container_cen">

			<div class="section">
				<div id="popupzone_b">
					<h3><img src="../include/images/main/notice.gif" alt="NOTICE" /></h3>
					<div id="popup_zone_b">
						<div id="popup_num_b">
							<a href="#popup_b" onclick="play_popup_b(1);" title="���"><img src="../include/images/main/btn_play.gif" alt="���" /></a> 
							<a href="#popup_b" onclick="play_popup_b(0);" title="����"><img src="../include/images/main/btn_stop.gif" alt="����" /></a> 

						<%
						if (noticeVt1 != null && noticeVt1.size() > 0) {
							String list_title = "";
							String list_date = "";
							String list_contents = "";
							int cnt_notice = 0;
							try {
								for (Enumeration e = noticeVt1.elements(); e.hasMoreElements();) {
									com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement()); 
									cnt_notice++;
								%>
									<a href="#popup_b" onclick="select_num_b('<%=cnt_notice%>');"><img src="../include/images/main/1_on.png" id="popup_img_b<%=cnt_notice %>" alt="<%=cnt_notice %>"/></a>
								<%
								}
							}  catch (Exception e) {  }
						}
						%> 	

						</div>
						<div id="photo_zone_b" class="basic_photo_banner">
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
							<p id="popup_b<%=cnt_notice%>">
								<a href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>" class="view_page"><%=bliBean.getList_title() %></a>
							</p>
					<% 
  							}
 						} 
 						catch (Exception e) {
 						}
 					}
					%>  

						</div> 
					</div>
					<script type="text/javascript">play_pop_b();</script>
				</div>
			</div>
		</div>
		<div class="container_bott">
			<div class="section">
				<div id="popupzone_c">
					<h3><img src="../include/images/main/new.gif" alt="NEW" /></h3>
					<div id="popup_zone_c">
						<div id="photo_zone_c" class="basic_photo_banner">
				<%
							 if (new_list0 != null && new_list0.size() > 0) {
 							try {
 								 
								int i = 1;
								for (Enumeration e = new_list0.elements(); e.hasMoreElements(); i++) 
								{
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement()); 
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									
									String temp_ctitle = oinfo.getCtitle(); 
							 
					%>
 							 <p id="popup_c<%=i%>">

								<a href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" class="view_page" onclick="videoStop();"> 
									<span class="thumb"> 
										<img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/>
									</span> 
									<span class="data"><%=oinfo.getTitle()%></span> 
								</a>

							</p> 
					<%
								}
							} catch (Exception e) {
								System.out.println("error message :" + e);
							}
						}
					%>	

							

						</div>

						<div id="popup_num_c"> 
							<a href="#popup_c" onclick="play_popup_c(1);" title="���"><img src="../include/images/main/btn_play.gif" alt="���" /></a>  
							<a href="#popup_c" onclick="play_popup_c(0);" title="����"><img src="../include/images/main/btn_stop.gif" alt="����" /></a> 

 <%
							 if (new_list0 != null && new_list0.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list0.elements(); e.hasMoreElements(); i++) 
								{
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());  
							 
					%>
 							<a href="#popup_c" onclick="select_num_c('<%=i%>');"><img src="../include/images/main/1_on.png" id="popup_img_c<%=i%>" alt="<%=i%>"/></a>	
					<%
								}
							} catch (Exception e) {
								System.out.println("error message :" + e);
							}
						}
					%>	
 
							

						</div>

					</div>

					<script type="text/javascript">play_pop_c();</script>

				</div>

				<div id="popupzone_d">

					<h3><img src="../include/images/main/hot.gif" alt="HOT" /></h3>

					<div id="popup_zone_d">

						<div id="photo_zone_d" class="basic_photo_banner">

 <% 					
		if (vtBts_1 != null && vtBts_1.size() > 0) {
			int cnt = 1;
			for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++) {
				com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
				 			String imgTmp = "/2013/include/images/noimg_small.gif";
							 
							if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
								imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
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
								<p id="popup_d<%=cnt%>"> 
								<a href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" class="view_page" onclick="videoStop();"> 
									<span class="thumb"> 
										<img src="<%=imgTmp %>" alt="<%=strTitle%>"/> 
									</span> 
									<span class="data"><%=oinfo.getTitle()%></span> 
								</a> 
							</p>
<%					 	 
			}
		} 			
%>	
						</div>

						<div id="popup_num_d">

							<a href="#popup_d" onclick="play_popup_d(1);" title="���"><img src="../include/images/main/btn_play.gif" alt="���" /></a> 
							<a href="#popup_d" onclick="play_popup_d(0);" title="����"><img src="../include/images/main/btn_stop.gif" alt="����" /></a> 

 <% 					
		if (vtBts_1 != null && vtBts_1.size() > 0) {
			int cnt = 1;
			for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++) {
				com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());					
%>
							<a href="#popup_d" onclick="select_num_d('<%=cnt%>');"><img src="../include/images/main/1_on.png" id="popup_img_d<%=cnt%>" alt="<%=cnt%>"/></a>	
<%					 	 
			}
		} 			
%>
						</div>

					</div>

					<script type="text/javascript">play_pop_d();</script>

				</div>

				<div id="popupzone_e">

					<h3><img src="../include/images/main/best.gif" alt="BEST" /></h3>

					<div id="popup_zone_e">

						<div id="photo_zone_e" class="basic_photo_banner">
<% 
						if (new_week != null && new_week.size() > 0) 
						{
 							try {
								int i = 1;
								for (Enumeration e = new_week.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
								 
								%>
						   <p id="popup_e1">
								<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="videoStop();">
									<span class="thumb">
										<img  src="<%=imgTmp %>" alt="<%=title%>"/>
									</span>
									<span class="data"><%=oinfo.getTitle()%></span>
								</a>
							</p>
										 
								<%
								 
								}
							} 
							catch (Exception e) {
								//out.println("error message :" + e);
							}
						}
							%>
							
<% 
						if (new_month != null && new_month.size() > 0) 
						{
 							try {
								int i = 1;
								for (Enumeration e = new_month.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle(); 
									
								%>
 
							<p id="popup_e2">
								<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="videoStop();">
									<span class="thumb">
										<img  src="<%=imgTmp %>" alt="<%=title%>"/>
									</span>
									<span class="data"><%=oinfo.getTitle()%></span>
								</a>
							</p>
									<%
								}
							} 
							catch (Exception e) {
								//out.println("error message :" + e);
							}
						}
							%>	
							<%
						if (new_year != null && new_year.size() > 0) 
						{
 							try {
								int i = 1;
								for (Enumeration e = new_year.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									String imgTmp = "/2013/include/images/noimg_small.gif";
									 
									if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
										imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_medium/" + oinfo.getModelimage();
									}  
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
									String temp_ctitle = oinfo.getCtitle();  
								%>
											
							<p id="popup_e3">

								<a class="view_page" href="/2013/video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="videoStop();">
									<span class="thumb">
										<img  src="<%=imgTmp %>" alt="<%=title%>"/>
									</span>
									<span class="data"><%=oinfo.getTitle()%></span>
								</a>

							</p>
						 <%
								}
							} 
							catch (Exception e) {
								//out.println("error message :" + e);
							}
						}
							%>	

							

						</div>

						<div id="popup_num_e">

							<a href="#popup_e" onclick="play_popup_e(1);" title="���"><img src="../include/images/main/btn_play.gif" alt="���" /></a> 

							<a href="#popup_e" onclick="play_popup_e(0);" title="����"><img src="../include/images/main/btn_stop.gif" alt="����" /></a> 
<%
if (new_week != null && new_week.size() > 0) {%>
							<a href="#popup_e" onclick="select_num_e('1');"><img src="../include/images/main/2_1_on.png" id="popup_img_e1" alt="��"/></a>
<%} %>
<%
if (new_month != null && new_month.size() > 0) {
%>
							<a href="#popup_e" onclick="select_num_e('2');"><img src="../include/images/main/2_2_on.png" id="popup_img_e2" alt="��"/></a>	
<%} %>					
<%
if (new_year != null && new_year.size() > 0) {
%>
							<a href="#popup_e" onclick="select_num_e('3');"><img src="../include/images/main/2_3_on.png" id="popup_img_e3" alt="��"/></a>	
<%} %>
						</div>

					</div>

					<script type="text/javascript">play_pop_e();</script>

				</div>

				<div class="aside">

					<div id="popupzone_f">

						<div id="popup_zone_f">

							<div id="photo_zone_f" class="basic_photo_banner">
						<% 
								if(popv_M != null && popv_M.size() > 0){ 
									for(int i=0;i<popv_M.size();i++){
								%>
 							<p id="popup_f<%=i+1%>">
									<a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>">
									<span class="thumb">
										<img src="/upload/popup/<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(9))%>" alt="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%>"/>
									</span>
									<span class="data">
										<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%>
									</span>
									</a> 
							</p>
								
						<%
										} 
									}
						%>  

							</div>

							<div id="popup_num_f">

								<a href="#popup_f" onclick="play_popup_f(1);" title="���"><img src="../include/images/main/btn_play.gif" alt="���" /></a> 
								<a href="#popup_f" onclick="play_popup_f(0);" title="����"><img src="../include/images/main/btn_stop.gif" alt="����" /></a> 

						<% 
								if(popv_M != null && popv_M.size() > 0){ 
									for(int i=0;i<popv_M.size();i++){
						%>
						<a href="#popup_f" onclick="select_num_f('<%=i+1%>');"><img src="../include/images/main/1_on.png" id="popup_img_f<%=i+1%>" alt="<%=i+1%>"/></a>
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

	</div>

<%
	if(popv_P != null && popv_P.size() > 0) {
		for (int i = 0; i < pop_seq.length; i++) {
			// IE�϶� ��Ű�˻� �� �˾�

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
//���̺� �˾�â�� �ٷ� �ٿ��� �ʴ´�.

//out.println(play_btn);
//���̺� �˾� �ȳ�â�� �ٿ��.

//out.println(live_popup);

%>
</script>
	
<%@ include file = "../include/html_foot.jsp"%>

