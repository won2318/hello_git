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
 
try {
 	if (today_string.substring(8,10).trim().equals("01")) {
		mMgr.insertMohth_log();
	}
} catch (Exception e) {
	System.out.println("���� �α� ��� ����");
}

/////////////////////////////
// ������ �ֿ� ���� (�����ǿ���)
	
// BestWeekManager bwMgr = BestWeekManager.getInstance();
// Vector bwVt = bwMgr.getBestWeekInfo("A");
// if(bwVt != null && bwVt.size() > 0) {
// 	Enumeration e = bwVt.elements();
// 	com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)e.nextElement());
// } 

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

	new_list0 = mMgr.getMediaListNew(5); //����
	
	new_list1 = mMgr.getMediaList_count("001", 5); //����
	new_list2 = mMgr.getMediaList_count("002", 5); //�����̾�Ƽ
	new_list3 = mMgr.getMediaList_count("003", 5); // ������
	new_list4 = mMgr.getMediaList_count("004", 5); // ��û��
	
	new_list5 = mMgr.getMediaList_count_order_1week("001","hitcount", 10); // ���帹�� �� ����
	new_list6 = mMgr.getMediaList_count_order_not_1week("001","hitcount", 10); // ���帹�� �� ����
	
	new_list7 = mMgr.getMediaList_count_order("003","mk_date", 1); // ������ �÷���
	new_list8 = mMgr.getMediaList_count("006", 4); // �����
	new_list9 = mMgr.getMediaList_count("005", 4); // ȫ������

	Vector noticeVt1 = blsBean.getRecentBoardList_open_top(10, 6); // ���� (board_id, limit)
	Vector noticeVt2 = blsBean.getRecentBoardList_open(16, 1); // ���۳�Ʈ (board_id, limit)
 
/////////////////////////////////////
// bestTop (������ ���� ����/ ȭ���� ����, ���� ����, hot����)

BestMediaManager Best_mgr = BestMediaManager.getInstance();
	
Vector vtBts_1 = new Vector();
Vector vtBts_2 = new Vector();
Vector vtBts_3 = new Vector();
Vector vtBts_4 = new Vector();

vtBts_1 = Best_mgr.getBestTopSubList_order(2, 4); // ȭ���� ����
vtBts_2 = Best_mgr.getBestTopSubList_order(3, 4); // ���� ����
vtBts_3 = Best_mgr.getBestTopSubList_order(4, 4); // HOT ����

vtBts_4 = Best_mgr.getBestTopSubList_order(1, 7); // ���� ����

 

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
	Vector popv_P = pMgr.getVisible_dateflag("P");  // flag = P  popup , M main
	Vector popv_M = pMgr.getVisible_dateflag("M");  // flag = P  popup , M main
	
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
                "noticeWindow2.opener = self; \n" +
                "} ";
  }

Vector event = null;
String event_script ="";
event = smgr.getSubjectListDate("E") ; //�̺�Ʈ
if( event != null && event.size() >= 4 && Integer.parseInt( String.valueOf(event.elementAt(4))) >=  Integer.parseInt( String.valueOf(event.elementAt(12))) ) {
        event_script = "if ( getCookie( \"event\" ) != \"true\" ) { \n" +
                "noticeWindow3  =  window.open(\"/2013/info/event_info.jsp?sub_flag=E\", \"event\", \"status=no,scrollbars=no,width=400,height=300,top=120,left=500\");\n" +
                "noticeWindow3.opener = self; \n" +
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

<%@ include file = "../include/html_head.jsp"%>
<% if(live_v != null && live_v.size() > 0) {  %>
<script language="javascript">AC_FL_RunContent = 0;</script>
<script type="text/javascript" src="../include/js/AC_RunActiveContent.js" ></script>
<%} %>
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
<script type="text/javascript">
 
	$(document).ready(function(){
		
		 $('.popup').PopupZone({
			prevBtn : '#pzPrev', 
			nextBtn : '#pzNext',
			playBtn : '#pzPlay',
			waitingTime : '5000'
		});
	});
 
	</script>
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

function point_go(ocode){ 
	 $.get("proc_best_point.jsp", { ocode: ocode },  function(data) { 
		// $("#recomcount").html(data); 
		alert('��õ �Ǿ����ϴ�!');
		 },   "text" ); 

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
	
//-->
</script>

	<!-- container::������ -->
	<div id="container">
		<div id="content">
			<div class="sectionTop">
				<div class="silver">
					
					<%  if(live_v != null && live_v.size() > 0) {
						String temp_server_name = DirectoryNameManager.SV_LIVE_SERVER_IP;
						 if (stream.startsWith("suwon01r") ) {
							 temp_server_name = "livetv.suwon.go.kr"; 
						 }
					%>
						<span class="hot" id="today_live"><span>SUWON iTV LIVE</span>���̺� ���</span>
						<script type="text/javascript" >
							if (AC_FL_RunContent == 0) {
								alert("This page requires AC_RunActiveContent.js.");
							} else {
						 
								AC_FL_RunContent(
									'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
									'width', '521',
									'height', '339',
									'src', '/2013/live/live_wide_main',
					 
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
									'movie', '/2013/live/live_wide_main',
									'FlashVars', 'userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>',
									'salign', ''
									); //end AC code
						 
							}
						</script>
							
							<noscript>
							<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="521px" height="339px" id="live" align="middle">
							<param name="allowScriptAccess" value="always" />
							<param name="allowFullScreen" value="true" />
							<param name="movie" value="/2013/live/live_wide_main.swf" />
							<param name="quality" value="high" />
							<param name="bgcolor" value="#000000" />
							 
							<embed src="/2013/live/live_wide_main.swf" quality="high" bgcolor="#000000" width="521px" height="339px" name="live_wide" align="middle" 
								allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash" 
								FlashVars="userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>" 
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
 
							</object>		
						</noscript>
					<span class="sub">
						<span class="title"><a>[<%=live_title %>] ����� ���� ��!</a></span>
						<span class="subject"><%=live_rcontents %></span>
						<span class="more"><a href="javascript:live_open();" onclick='callToActionscript()' ><img src="../include/images/btn_blank.gif" alt="��â���� ����"/></a>
						</span>
 					</span>	
				    <%} else { 
 			 
			String main_ocode = "";
			for (Enumeration e = vtBts_4.elements(); e.hasMoreElements();  ) {			 
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
					if (btsBean.getBts_uid() != null && btsBean.getBts_uid().equals("default")) {
						main_ocode = btsBean.getBts_ocode();
					}
 
					if (btsBean.getBts_uid() != null && btsBean.getBts_uid().equals(today_string)) {  //���� ���� ����
						main_ocode = btsBean.getBts_ocode();
					} 
			}
			
			Vector main_vod = mMgr.getOMediaInfo(main_ocode);
			if(main_vod != null && main_vod.size()>0){
				try {
					Enumeration best_e = main_vod.elements();
					com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
				} catch (Exception e) {
					out.println("error message :" + e);
				}
			}
 
			
 
 %>
				    <span class="hot" id="today_vod"><span>SUWON iTV TODAY</span>������ �ֿ� ����</span>
					<div class="vod">
					     
								<div id="SilverlightControlHost" class="silverlightHost" >
							<textarea id="player_" style="display:none;" rows="0" cols="0"/>
								<object id="silver_player" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="522" height="339" style="z-index:0;">
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
						  mplayer('player_');  // embed �׵θ� ���� ( textarea �� ������ ��Ŭ����� ��ũ���� ���Ͽ��� getElementById()�� �Ѵ�.
						 </script>
 						</div> 
 						 
 						</div>
 						<span class="sub">
						<span class="title"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle() %></a></span>
 					    <span class="subject"><%=chb.getContent_2( oinfo.getContent_simple() ,"true")%></span>
						<span class="more"><a  class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><img src="../include/images/btn_today_more.gif" alt="�ڼ�������"/></a>
 	 
						</span>
 					</span>
						<%} %> 
				</div>
				
				<div class="NewTab list1 jx">
					 
					<ul>
					<li class="active total"><a href="#"><span class="newTitle">����iTV<span>�ֽſ���</span></span></a>
					<ul>
					<% 
							if (new_list0 != null && new_list0.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list0.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode() != null && oinfo.getCcode().startsWith("004001")) {
										temp_ctitle = "����PD";
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a href="../video/video_list.jsp?ccode=<%=oinfo.getCcode()%>"><%=temp_ctitle%></a></span>
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"  onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
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
						<li ><a href="#"><span class="newTitle">����</span></a>
							<ul>
					<% 
							if (new_list1 != null && new_list1.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list1.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"  onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a   href="../video/video_list.jsp?ccode=<%=oinfo.getCcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"  onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>								 
								<li class="more"><a href="../video/video_list.jsp?ccode=001000000000" title="����"><img src="../include/images/btn_itv_more.gif" alt="������"/></a></li>
							</ul>
						</li>
						<li><a href="#"><span class="newTitle">�����̾�Ƽ</span></a>
							<ul>
					<% 
							if (new_list2 != null && new_list2.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list2.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"  onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a  href="../video/video_list.jsp?ccode=<%=oinfo.getCcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"  onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
								<li class="more"><a href="../video/video_list.jsp?ccode=002000000000" title="�����̾�Ƽ"><img src="../include/images/btn_itv_more.gif" alt="������"/></a></li>
							</ul>
						</li>
						<li><a href="#"><span class="newTitle">������</span></a>
							<ul>
					<% 
							if (new_list3 != null && new_list3.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list3.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a  href="../video/video_list.jsp?ccode=<%=oinfo.getCcode()%>"><%=oinfo.getCtitle()%></a></span>
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
								<li class="more"><a href="../video/video_list.jsp?ccode=003000000000" title="������"><img src="../include/images/btn_itv_more.gif" alt="������"/></a></li>
							</ul>
						</li>
						<li><a href="#"><span class="newTitle">��û��</span></a>
							<ul>
					<% 
							if (new_list4 != null && new_list4.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list4.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode().contains("004001")) {
										temp_ctitle = "����PD";
									}
					%>
					
								<li>
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<span class="cate"><a href="../video/video_list.jsp?ccode=<%=oinfo.getCcode()%>"><%=temp_ctitle%></a></span>
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
									</span>
								</li>
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
								<li class="more"><a href="../video/video_list.jsp?ccode=004000000000" title="��û��"><img src="../include/images/btn_itv_more.gif" alt="������"/></a></li>
							</ul>
						</li>

					</ul>
				</div>
			</div>
			<div class="sectionCen">
				<div class="NewTab list2">
					<ul>
						<li class="active"><a href="#"><span>���� ���� �� ����</span></a>
							<ul>
							
					<% 
							if (new_list5 != null && new_list5.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list5.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
					%> 	 
								<li><span class="time"><img src="../include/images/icon_best<%=i %>.gif" alt="<%=i %>"/></span> <a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"  onclick="StopSilverlight();"><strong>[<%=oinfo.getCtitle() %>]</strong> <%=oinfo.getTitle()%></a> </li>
  
					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
							</ul>
						</li>
						<li><a href="#"><span>���� ���� �� ����</span></a>
							<ul>
					<% 
							if (new_list6 != null && new_list6.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list6.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
									
									String temp_ctitle = oinfo.getCtitle(); 
									if (oinfo.getCcode().contains("004001")) {
										temp_ctitle = "����PD";
									} 
					%> 	 
								<li><span class="time"><img src="../include/images/icon_best<%=i %>.gif" alt="<%=i %>"/></span> <a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>"  onclick="StopSilverlight();"><strong>[<%=temp_ctitle %>]</strong> <%=oinfo.getTitle()%></a> </li>

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
					<h3>ȭ���� ����</h3>

					<ul>
<% 					
			if (vtBts_1 != null && vtBts_1.size() > 0) {
 		 
			int cnt = 1;
			for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++ ) {
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
						
							String imgurl ="/2013/include/images/noimg_small.gif";
							String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_small/"+oinfo.getModelimage();
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
				
						<li <%if (cnt ==1) { %> class="active" <%} %>><a href="#"><span class="newTitle"><%=cnt %></span></a>
							<ul>
								<li>
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
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
					<h3>������ �÷���</h3>

					<ul>
					<li>
					<% 
							if (new_list7 != null && new_list7.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list7.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
					%>
					
								
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
									</span>
								
 

					<%
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
					</li>
					</ul>
					 <%
				 
					Vector links =Best_mgr.getList_link();			 
					String list_link = "";		 
					if(links != null && links.size() >0){
					 
						list_link = String.valueOf(links.elementAt(2));
					}
					 %>

					<span class="more"><a href="<%=list_link%>" class="view_page"><img src="../include/images/btn_life_organ.gif" alt="��ǥ"/></a></span>
				</div>
				
				<div class="NewTab list4">
					<h3>���� ����</h3>

					<ul>
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
						
							String imgurl ="/2013/include/images/noimg_small.gif";
							String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_small/"+oinfo.getModelimage();
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
						<li <%if (cnt ==1) { %> class="active" <%} %>><a href="#"><span class="newTitle"><%=cnt %></span></a>
							<ul>
								<li>
									<span class="img"><a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
									<span class="total">
										<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
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
					<h3><a href="/2013/board/board_list.jsp?board_id=16">��������</a></h3>

					
					<% 
					if (noticeVt2 != null && noticeVt2.size() > 0) {
						String list_title = "";
						String list_date = "";
						String list_contents = "";
						try {
							for (Enumeration e = noticeVt2.elements(); e.hasMoreElements();) {
								com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement());
					 %>
					  
					 	<span class="img"><a class="view_page" href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>" onclick="StopSilverlight();"><img src="../board/img_2.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>" alt="��������"/></a></span>
						<span class="total">
						<a class="view_page" href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>" onclick="StopSilverlight();"><%=bliBean.getList_title() %></a>
						</span>
					
					 <% 
 							}
						} catch (Exception e) {
						}
					}
					%>
						
					<span class="more"><a href="../board/board_list.jsp?board_id=16"><img src="../include/images/btn_itv_more.gif" alt="������"/></a></span>
				</div>
				<div class="mNotice">
					<h3><a href="../board/board_list.jsp?board_id=10">��������</a></h3>

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
						} catch (Exception e) {
						}
					}
					%> 
					</ul>
					<span class="more"><a href="../board/board_list.jsp?board_id=10"><img src="../include/images/btn_itv_more.gif" alt="������"/></a></span>
				</div>
				
				<div id="popupzone">
					<div class="popup">
					<span class="count">
						<a href="#popupzone" id="pzPrev"><img src="../include/images/icon_left.gif" alt="�˾� ����" /></a>
						<strong class="currentCount">1</strong>&nbsp;/&nbsp;<%=popv_M.size() %>
						<a href="#popupzone" id="pzNext"><img src="../include/images/icon_right.gif" alt="�˾� ����" /></a>
					</span>
					<div class="btn_popup">
						<div>
							<a href="#popupZone" onclick="showHide('popupList');return false;"><img src="../include/images/popup_list.gif" alt="�˾� �����ü����" /></a>
							<div id="popupList" style="display:none;">
								<ul>
								
								<% 
					 
								if(popv_M != null && popv_M.size() > 0){ 
									for(int i=0;i<popv_M.size();i++){
								%>
										<li>
										<a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>" target="_blank"><%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%></a>
										</li>
										  
								<%
										} 
									}
								%> 
								 
								</ul>
							</div>
						</div>
						<a href="#popupzone" id="pzPlay"><img src="../include/images/popup_stop.gif" alt="�˾� �Ѹ�����" /></a>
					</div>
					<dl>
					
					<%	
						
						if(popv_M != null && popv_M.size() > 0){ 
							for(int i=0;i<popv_M.size();i++){
					%>
					<dt><%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%></dt>
						<dd><a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>" target="_blank"><img src="/upload/popup/<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(9))%>"  alt="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%>"/></a></dd>
					<%
							} 
						}
					%>	
					 
					</dl>
					</div>
				</div>
				
			</div>
			
		</div>

		<div class="mAside"> 
			<iframe title="�����ũ" id="photo_bank" name="photo_bank" src="http://photo.suwon.go.kr/photo_bank_withustech.asp" scrolling="no" width="231" height="250" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
			<div class="hotnews">
				<h3>HOT ����</h3>
				<ul>
<% 					
			if (vtBts_3 != null && vtBts_3.size() > 0) {
 			 
			int cnt = 1;
			for (Enumeration e = vtBts_3.elements(); e.hasMoreElements(); cnt++ ) {
			 
				com.yundara.beans.BeanUtils.fill(btsBean, (Hashtable) e.nextElement());
					Vector best_v = mMgr.getOMediaInfo(String.valueOf(btsBean.getBts_ocode()));
					if(best_v != null && best_v.size()>0){
						try {
							Enumeration best_e = best_v.elements();
							com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) best_e.nextElement());
						
							String imgurl ="/2013/include/images/noimg_small.gif";
							String imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_small/"+oinfo.getModelimage();
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
							String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
							title = title.replaceAll("&#39;", "");
%>

				 <%
				 if (cnt ==1) { 
					double dA = Double.parseDouble(oinfo.getOcode());
					if(dA > dFrom){
						 imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_medium/"+oinfo.getModelimage();
						 if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
								imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
						 }
					}
				 %>
				<li class="big">
					<span class="img"><a class="view_page" onmouseover="javascript:overimg1('<%=oinfo.getOcode()%>','<%=title%>');" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playMid"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
					<span class="total" id="test_id1"> 
						<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
					</span>
				</li>
				<%} else { %>
				<li class="small">
					<span class="img"><a class="view_page" onmouseover="javascript:overimg1('<%=oinfo.getOcode()%>','<%=title%>');" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall2"></span><img src="<%=imgTmp %>" alt="<%=oinfo.getTitle()%>"/></a></span>
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
					<span class="img"><span class="playSmall2"></span><img src="/include/skin/images/noimage.gif" alt="��ϵ� ������ �����ϴ�."/></span>
					</li>
					<% 
				}
			}

		}						
%>				
 
				</ul>
			</div>
			<div class="live">
				<h3><a href="../live/live_list.jsp">�����</a></h3>

				<ul>
				<% 
							if (new_list8 != null && new_list8.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list8.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
 
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "");
					%>
 
				<%
				if (i == 1) { 
					double dA = Double.parseDouble(oinfo.getOcode());
					if(dA > dFrom){
						 imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_medium/"+oinfo.getModelimage();
						 if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
								imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
						 }
					}  
				%>				
				<li class="big">
					<span class="img"><a class="view_page" onmouseover="javascript:overimg2('<%=oinfo.getOcode()%>','<%=title%>');" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playMid"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
					<span class="total" id="test_id2">
						
						<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
					</span>
				</li>
				<%} else { %>
				<li class="small">
					<span class="img"><a class="view_page" onmouseover="javascript:overimg2('<%=oinfo.getOcode()%>','<%=title%>');" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall2"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
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
					<span class="img"> <span class="playMid"></span><img src="/2013/include/images/noimg_small.gif" alt="��ϵ� ������ �����ϴ�"/> </span>
					<span class="total"> ��ϵ� ������ �����ϴ�. 

					</span>
				</li>
									<% 
						}
					%>	
					 
				</ul>
			</div>
			<div class="promote">
				<h3><a href="../video/video_list.jsp?ccode=005000000000">ȫ������</a></h3>

				<ul>
				<% 
							if (new_list9 != null && new_list9.size() > 0) {
 							try {
								int i = 1;
								for (Enumeration e = new_list9.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());

									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/_small/" + oinfo.getModelimage();

									if (oinfo.getModelimage() == null || oinfo.getModelimage().length() <= 0 || oinfo.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
									}
									
									String title=com.vodcaster.utils.TextUtil.text_replace(oinfo.getTitle(),false);
									title = title.replaceAll("&#39;", "");
									
					%>
 
				<%
				if (i == 1) {
					double dA = Double.parseDouble(oinfo.getOcode());
					if(dA > dFrom){
						 imgTmp = SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/_medium/"+oinfo.getModelimage();
						 if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
								imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
						  }
					}
				%>				
				<li class="big">
					<span class="img"><a class="view_page" onmouseover="javascript:overimg3('<%=oinfo.getOcode()%>','<%=title%>');" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playMid"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
					<span class="total" id="test_id3"> 
						<a class="view_page" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><%=oinfo.getTitle()%></a>
					</span>
				</li>
				<%} else { %>
				<li class="small">
					<span class="img"><a class="view_page" onmouseover="javascript:overimg3('<%=oinfo.getOcode()%>','<%=title%>');" href="../video/video_player.jsp?ocode=<%=oinfo.getOcode()%>" onclick="StopSilverlight();"><span class="playSmall2"></span><img src="<%=imgTmp%>" alt="<%=oinfo.getTitle()%>"/></a></span>
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
					<span class="img"><span class="playMid"></span><img src="/2013/include/images/noimg_small.gif" alt="��ϵ� ������ �����ϴ�"/></span>
					<span class="total"> ��ϵ� ������ �����ϴ�. 

					</span>
				</li>
				<% 							 
					 }
					%>	
				 
				</ul>
			</div>
			
		</div>
		<div class="family">
			<a href="http://www.suwon.go.kr/" title="��â���� �����մϴ�." target="_blank"><img src="../include/images/suwon.gif" alt="������"/></a>
			<a href="http://news.suwon.go.kr/" title="��â���� �����մϴ�." target="_blank"><img src="../include/images/suwonnews.gif" alt="e-��������"/></a>
			<a href="http://edu.suwon.ne.kr/" title="��â���� �����մϴ�." target="_blank"><img src="../include/images/edu.gif" alt="������ ���ͳݼ��ɹ��"/></a>
			<a href="http://ebook.suwon.ne.kr/" title="��â���� �����մϴ�." target="_blank"><img src="../include/images/e_data.gif" alt="e-�ڷ�ȫ����"/></a>
			<a href="http://symbol.suwon.ne.kr/" title="��â���� �����մϴ�." target="_blank"><img src="../include/images/symbol.gif" alt="������ ��¡��"/></a>
			<a href="https://ite.suwon.go.kr/" title="��â���� �����մϴ�." target="_blank"><img src="../include/images/ite.gif" alt="�ù�����ȭ����"/></a>
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

