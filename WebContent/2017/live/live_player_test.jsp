<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
<%@ page import="com.yundara.util.*"%>

<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean"	scope="page" />
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" />
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />

<%@ include file="/include/chkLogin.jsp"%>
<%

String ccode = "";
if (request.getParameter("ccode") != null
		&& request.getParameter("ccode").length() > 0
		&& !request.getParameter("ccode").equals("null")) {
	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
}
int board_id = NumberUtils.toInt(request.getParameter("board_id"),	0);


%>
<%@ include file="../include/html_head.jsp"%>
<% 

Vector v_onair = null;
String rcode ="";
 try {
  	      v_onair =  lMgr.getLive();

	  }catch(Exception e) {}
 if(v_onair != null && v_onair.size() > 0) {  
	 rcode =  String.valueOf(v_onair.elementAt(0));
	 
	live_title = String.valueOf(v_onair.elementAt(1)); 
	live_rcontents  = String.valueOf(v_onair.elementAt(2)); 
	String[] data= null;
	 
	data=String.valueOf(v_onair.elementAt(4)).split("/");

	if(data.length > 2){
		channel = data[1];
		stream = data[2];
	}
 
//////////////////////////////////////////////////////////////
	//회원정보 로그화일에 저장
	if (rcode != "" && rcode.length() > 0) {
	if(deptcd == null) deptcd = "";
	if(gradecode == null) gradecode = "";
	com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, rcode, request.getRemoteAddr(),"R" );
	
	String GB = "WL";
	int year=0, month=0, date=0;
	Calendar cal = Calendar.getInstance();
	year  = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH)+1;
    date = cal.get(Calendar.DATE);
	
	MenuManager2 mgr2 = MenuManager2.getInstance();
	mgr2.insertHit(rcode,year,month,date,GB);	// 시청 통계 로그
	}
//////////////////////////////////////////////////////////////
	
}
 
 %>

    <script src="./js/video.js"></script>
    <script src="./js/videojs-flash.js"></script>
    <script src="./js/videojs-contrib-hls.js"></script>
    <link href="./js/video-js.css" rel="stylesheet">   
     
		<section id="body">
			<div id="container_out">
				<div id="container_inner">
<%

if(v_onair != null && v_onair.size() > 0) {
	String temp_server_name = DirectoryNameManager.SV_LIVE_SERVER_IP;
	 if (stream.startsWith("suwon01r") ) {
		 temp_server_name = "livetv.suwon.go.kr"; 
	 }
		    
		    %>			 
				<video id=example-video width="579px" height="370px" class="video-js vjs-default-skin" controls >
<!-- 				  <source src="http://106.255.241.77:1935/live/live.stream/playlist.m3u8" type="application/x-mpegURL"> -->
				  <source src="http://10.10.10.65:1935/live/myStream/playlist.m3u8" type='application/x-mpegURL'/>
				</video>
				
				<script>
				var player = videojs('example-video');
				player.play();
				</script>  
   
			 
			<%} else {
				 out.println("진행중인 생방송이 없습니다.");
			}  
		    %>

				</div><!--//container_inner-->
				<aside class="container_right">
				 
					<div class="NewTab list5 list3">
						<ul >
						<%@ include file = "../include/right_new_video.jsp"%>   
							
						</ul>
					</div><!--//NewTab list3-->
						<%@ include file = "../include/right_best_video.jsp"%>   
					
				</aside><!--//container_right-->
			</div><!--//container_out-->
		</section><!--콘텐츠부분:section-->    
		
	 <%@ include file="../include/html_foot.jsp"%>