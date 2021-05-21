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
		String size=" width=\"690\" height=\"388\" ";
	if (type != null && type.equals("sub")) {
		size=" width=\"690\" height=\"388\" ";
	}else if (type != null && type.equals("vodman")) {
		size=" width=\"690\" height=\"388\" ";
	}else if (type != null && type.equals("popup")) {
		size=" width=\"440\" height=\"248\" ";
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
		vo = mgr.getOMediaInfo_admin(ocode);

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
	int user_level = NumberUtils.toInt(vod_level, 0);
	 

	String ofilename = "";
	if (StringUtils.isNotEmpty(omiBean.getFilename())) {
		ofilename = omiBean.getFilename();
 
	} else {
		//미디어 아이디가 없는 경우 
 
	}
 
	
%>


<!DOCTYPE html>
<html lang="ko">
<head>
 
   <title>수원 iTV</title> 
	<style>
		* {padding:0; margin:0;}
	</style>
    <script src="/videoJs/jquery.min.js"></script>

</head>
<body>
 
<!--[if lt IE 9]>
<link href="/videoJs/video-js.css" rel="stylesheet">
<script src="/videoJs/video.js"></script>


  <video id="example_video_1" class="video-js vjs-default-skin" controls preload="auto"  <%=size%>
      poster="<%=imgTmpThumb %>"
      data-setup='{}'>
    <source src="#" type='rtmp/mp4' />
   </video>
  <script type="text/javascript">  
 function changeVideo(){ 

  var $target ; 
	 $.getJSON("/2017/video/video_source.jsp?ocode=<%=ocode%>&type=vodman",function(data){ 
			$.each(data,function(){  
				 $target = this.media_src;
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
<link href="/videoJs/videojs5/video-js.min.css" rel="stylesheet">
<script src="/videoJs/videojs5/ie8/videojs-ie8.min.js"></script>
<script src="/videoJs/videojs5/video.min.js"></script>

   <video id="example_video_21" class="video-js vjs-default-skin" controls preload="none"   <%=size%>
      poster="<%=imgTmpThumb %>"
      data-setup='{}' >
   <source src="" type='rtmp/mp4' />
  </video>
  
<script type="text/javascript">  
	var $vid_obj        = videojs("example_video_21");
	var $target ; 
	 $.getJSON("/2017/video/video_source.jsp?ocode=<%=ocode%>&type=vodman",function(data){ 
			$.each(data,function(){ 
				//changeVideo(this.media_src);
				$target = this.media_src;
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

 function changeVideo(){ 
  
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
$.getJSON("/2017/video/video_source.jsp?ocode=<%=ocode%>&type=vodman",function(data){ 
 
		$.each(data,function(){ 
			//changeVideo(this.media_src);
			$target = this.media_src;
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
