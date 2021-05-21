<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.hrlee.sqlbean.MediaManager"%>
<%@ page import="com.security.*" %>

<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
 <%@ include file = "/include/chkLogin.jsp"%>
<%
contact.setPage_cnn_cnt("W"); // 페이지 접속 카운트 증가
request.setCharacterEncoding("euc-kr");

	MediaManager mgr = MediaManager.getInstance();
	Hashtable result_ht = null;
	String strMenuName = "";

	String ccode ="";	
	if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
		ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
	}	

	String ocode ="";
	if (request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0  && !request.getParameter("ocode").equals("null")) {
		ocode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ocode"));
	}
	
	String type ="main";
	if (request.getParameter("type") != null && request.getParameter("type").length() > 0  && !request.getParameter("type").equals("null")) {
		type = com.vodcaster.utils.TextUtil.getValue(request.getParameter("type"));
	}
	String size=" width=\"1024\" height=\"576\" ";
	String size2 = "1024";
	if (type != null && type.equals("sub")) {
		size=" width=\"579\" height=\"326\" ";
		size2 = "579";
	}else if (type != null && type.equals("vodman")) {
		size=" width=\"750\" height=\"550\" ";
		size2 = "750";
	}
	
	String auto_p = "True";

// 	if(request.getParameter("auto_p") != null && request.getParameter("auto_p").length()>0 && !request.getParameter("auto_p").equals("null") && request.getParameter("auto_p").equals("True") ) {
// 		auto_p = "True";
// 	} else{
// 		auto_p = "False";
// 	}
 
 
	String imgTmpThumb = "";
	int oHit_count = 0;
	String oPlay_time = "";
	String otitle = "";
	String odesc = "";
	String mk_date = "";
	String simple = "";
	int recomcount =0;
	int replycount =0;
	Vector vo = null;
	if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
		vo = mgr.getOMediaInfo_cate(ocode);

	} 
	int auth_v = 1;
	if (vo != null && vo.size() > 0) {
		try {
			Enumeration e2 = vo.elements();
			com.yundara.beans.BeanUtils.fill(omiBean, (Hashtable) e2.nextElement());
 
			imgTmpThumb = SilverLightPath + "/"+omiBean.getSubfolder()+"/thumbnail/"+omiBean.getModelimage();
			ocode = omiBean.getOcode();
			oHit_count = omiBean.getHitcount();
			simple = omiBean.getContent_simple();
			simple = simple.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
				oPlay_time = omiBean.getPlaytime();
				otitle = omiBean.getTitle();
				odesc = omiBean.getDescription();
				mk_date = omiBean.getMk_date();
			replycount = omiBean.getReplycount();
			recomcount = omiBean.getRecomcount();
			
 
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
 
		}
	}else{
	
	}

	auth_v = omiBean.getOlevel();
	int user_level = 0;
	if (vod_level != null) {
		try{
			user_level = Integer.parseInt(vod_level);
		}catch(Exception e){
			user_level = 0;
		}
	}

	String ofilename = "";
	if (StringUtils.isNotEmpty(omiBean.getFilename())) {
		ofilename = omiBean.getFilename();
 
	} else {
		//미디어 아이디가 없는 경우 
 
	}
//////////////////////////////////////////////////////////////
	if (omiBean.getOcode() != "" && StringUtils.isNotEmpty(ofilename)) {
	//회원정보 로그화일에 저장
	if(deptcd == null) deptcd = "";
	if(gradecode == null) gradecode = "";
	com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, omiBean.getOcode(), request.getRemoteAddr(),"V" );
	
	String GB = "WV";
	int year=0, month=0, date=0;
	Calendar cal = Calendar.getInstance();
	year  = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH)+1;
    date = cal.get(Calendar.DATE);
	MenuManager2 mgr2 = MenuManager2.getInstance();
	mgr2.insertHit(omiBean.getCcode(),year,month,date,GB);	// 시청 통계 로그
	}	 
//////////////////////////////////////////////////////////////

 
	
%>


<!DOCTYPE html>
<html lang="ko">
<head>
 
   <title>수원 iTV</title> 

    <script src="/videoJs/jquery.min.js"></script>
<!--[if IE ]>
<style type="text/css">
	 * {padding:0; margin:0;}
	 .logo {position:absolute; top: 0px; right: 10px;}
	 .pPlayer { width: 100%;padding:0; display: block; text-align: center;}
	 #page {position:relative;padding-top:10px; z-index: 99; text-align: center; }
	 #player1 {position:relative; z-index: 8; text-align: center; }
	 #player1_wrapper {margin:0 auto;}
	</style>
	<script src="/jwplayer/js/jwplayer.js" type="text/javascript"></script>
<![endif]-->
</head>
<body>
 
<!--[if IE ]>
 
<div id="player1"></div>
<script type="text/javascript">  
	var playerInstance ;
		var $streamer ="rtmp://27.101.101.113:1935/newsuwon"; 
		var $file1 ; 
		var $file2 ; 
		var $file3 ="mp4:2015/6/20150624172056313/Encoded/2015-06-24_17-35-04_/20150624172056313.mp4"; 

	function loadPlayer() {

   $.getJSON("/2013/video/video_source2.jsp?ocode=<%=ocode%>",function(data){ 
 
		$.each(data,function(){ 
			$streamer = this.streamer;
				$file1 = this.media_src1;
				$file2 = this.media_src2;
				$file3 = this.media_src3;
 
		}); 
	});
 
	 
				playerInstance = jwplayer("player1");
				playerInstance.setup(
				{

						id: 'player1',
						width: '1024',
						height: '576',
						autostart: true,
						skin: "/jwplayer/skins/darkrv5.zip",
						image: "<%=imgTmpThumb %>",
						logo: {
									file: '/jwplayer/images/symbol.png', hide: true, position: "top-right"
								},
						plugins: {
						},
						type: "flash",
						src: "/jwplayer/swf/player.swf",
						provider: 'rtmp',
						streamer: $streamer,
						levels: [
							 
								{
								bitrate: 720,
								file: $file3,
								width: <%=size2%>
								} 
						]

				}
				);
	}	
    </script>
	
 
  <script type="text/javascript">  
 
 function pause(){
	playerInstance.pause(true); 
} 

function play(){ 
 
  	playerInstance.play(true); 
} 
 window.onload = function(){
 loadPlayer();
 }
 
</script>
 
		
<![endif]-->


<!--[if !(IE)]><!--> 
<link href="/videoJs/videojs5/video-js.min.css" rel="stylesheet">
  <script src="/videoJs/videojs5/ie8/videojs-ie8.min.js"></script>
<script src="/videoJs/videojs5/video.min.js"></script>

<video id="example_video_3" class="video-js vjs-default-skin" controls preload="auto"  <%=size%>
      poster="<%=imgTmpThumb %>"
      data-setup='{}'>
    <source src="" type='rtmp/mp4' />
     </video>
   <script>
    videojs.options.flash.swf = "/videoJs/videojs5/video-js.swf";
  </script>

<script type="text/javascript">  
var $vid_obj        = videojs("example_video_3");
var $target ; 
$.getJSON("/2013/video/video_source.jsp?ocode=<%=ocode%>",function(data){ 
 
		$.each(data,function(){ 
			//changeVideo(this.media_src);
			//$target = this.media_src;
			// $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
			"rtmp://27.101.101.113:1935/newsuwon/_definst_/&mp4:2018/11/20181123105805793/Encoded/20181123075243763_10_59_29.mp4";
		}); 
	});
  $vid_obj.ready(function() {
		  $("#div_video_html5_api").hide();
		  
		  $vid_obj.src([
			  { type: "rtmp/mp4", src: $target }
			]);
		  $vid_obj.load();
		  $("#div_video_html5_api").show();
		  $vid_obj.play();
	});
var myPlayer = videojs("example_video_3"); 
 
function changeVideo(media_src){ 
	  myPlayer.src({"type":"rtmp/mp4", "src":media_src}); 
	  myPlayer.play() 
	} 


  function pause(){ 
		myPlayer.pause();
	} 

	function play(){ 
		myPlayer.play();
	} 
 
    </script>  
 <!--<![endif]-->
 
 </body>
</html>
