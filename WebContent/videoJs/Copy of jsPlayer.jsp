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
	
	String auto_p = "True";

// 	if(request.getParameter("auto_p") != null && request.getParameter("auto_p").length()>0 && !request.getParameter("auto_p").equals("null") && request.getParameter("auto_p").equals("True") ) {
// 		auto_p = "True";
// 	} else{
// 		auto_p = "False";
// 	}
	String def_q = "M";

 	if(request.getParameter("default_q") != null && request.getParameter("default_q").length()>0 && !request.getParameter("default_q").equals("null")  ) {
 		def_q = request.getParameter("default_q");
 	}
	
	boolean isView = true;
	boolean bOmibean = false;
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
			bOmibean = true;
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
			
			if(omiBean.getMediumfilename() == null || omiBean.getMediumfilename().length()<=0 || omiBean.getMediumfilename().equals("null")){
				def_q = "H";
			}
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
			isView = false;
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
		isView = true;
	} else {
		//미디어 아이디가 없는 경우 
		isView = false;
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

</head>
<body>
<!--[if lt IE 9]>
<link href="video-js.css" rel="stylesheet">
  <script src="video.js"></script>
  <video id="example_video_1" class="video-js vjs-default-skin" controls preload="auto"  width="1024" height="576"
      poster="<%=imgTmpThumb %>"
      data-setup='{}'>
    <source src="#" type='rtmp/mp4' />
  </video>
  <script type="text/javascript">  
 function changeVideo(){ 
 
 //var $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
  var $target ; 
	 $.getJSON("/2013/video/video_source.jsp?ocode=<%=ocode%>",function(data){ 
			$.each(data,function(){ 
				//changeVideo(this.media_src);
				//$target = this.media_src;
				 $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
			}); 
		});
		
  
  var $vid_obj        = _V_("example_video_1");
  $vid_obj.ready(function() {
 
		  $("#div_video_html5_api").hide(); 
		  $vid_obj.src([
			  { type: "rtmp/mp4", src: $target }
			]);
		  
 
		  $vid_obj.load();
		  $("#div_video_html5_api").show();
		  $vid_obj.play();

	});
   
} 
 function pause(){ 
	var $vid_obj        = _V_("example_video_1");
	$vid_obj.ready(function() {
 
		  $("#div_video_html5_api").hide(); 
		  $vid_obj.pause();

	});
} 

function play(){ 
  var $vid_obj        = _V_("example_video_1");
  $vid_obj.ready(function() {
		  $vid_obj.play();
	});
} 

 window.onload = function(){
 changeVideo();
 }
 
</script>
<![endif]-->
<!--[if gte IE 9]>
 

<video id="example_video_21" class="video-js vjs-default-skin" controls preload="auto" width="1024" height="576"
      poster="<%=imgTmpThumb %>"
      data-setup='{}' >
   <source src="" type='rtmp/mp4' />
    <p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
  </video>
  
<script type="text/javascript">  
	var $vid_obj        = videojs("example_video_21");
	var $target ; 
	 $.getJSON("/2013/video/video_source.jsp?ocode=<%=ocode%>",function(data){ 
			$.each(data,function(){ 
				//changeVideo(this.media_src);
				//$target = this.media_src;
				 $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
			}); 
		}); 
		
  $vid_obj.ready(function() {
  
		// hide the video UI
		  $("#div_video_html5_api").hide();
		  // and stop it from playing
		  $vid_obj.src([
			  { type: "rtmp/mp4", src: $target }
			]);
		  
		  // load the new sources
		  $vid_obj.load();
		  $("#div_video_html5_api").show();
		  $vid_obj.play();
 

	});
var myPlayer = videojs("example_video_21");

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
<![endif]-->

<!--[if !(IE)]><!--> 
<link href="/videoJs/gte9/video-js.min.css" rel="stylesheet">
  <script src="/videoJs/gte9/videojs-ie8.min.js"></script>
<script src="/videoJs/gte9/video.min.js"></script>

   <video id="example_video_3" class="video-js vjs-default-skin" controls preload="auto" width="1024" height="576"
      poster="<%=imgTmpThumb %>"
      data-setup='{}'>
    <source src="" type='rtmp/mp4' />
   </video>
<!-- Unless using the CDN hosted version, update the URL to the Flash SWF -->
  <script>
    videojs.options.flash.swf = "/videoJs/video-js.swf";
  </script>

<script type="text/javascript">  
	var $vid_obj        = videojs("example_video_3");
 	var $target ; 
	 $.getJSON("/2013/video/video_source.jsp?ocode=<%=ocode%>",function(data){ 
			$.each(data,function(){ 
				//changeVideo(this.media_src);
				//$target = this.media_src;
				 $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
			}); 
		});
  $vid_obj.ready(function() { 
 
		// hide the video UI
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
<!-- <button onclick="changeVideo()">video</button> -->
<!-- <button onclick="pause()">pause</button> -->
<!-- <button onclick="play()">play</button> -->
 

 
 </body>
</html>
