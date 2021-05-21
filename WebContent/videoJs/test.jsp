<!DOCTYPE html>
<html lang="ko">
<head>
 <meta charset="utf-8" />
  <title>Video.js | HTML5 Video Player</title>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

</head>
<body>
<!--[if lt IE 9]>
<link href="./video-js.css" rel="stylesheet">
  <script src="./video.js"></script>


  <video id="example_video_1" class="video-js vjs-default-skin" controls preload="auto" width="640" height="264"
      poster="http://video-js.zencoder.com/oceans-clip.png"
      data-setup='{}'>
    <source src="rtmp://27.101.101.113/newsuwon/_definst_/&mp4:2015/6/20150624172056313/Mobile/2015-06-24_17-37-36_/20150624172056313.mp4" type='rtmp/mp4' />
   
    <p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
  </video>
  <script type="text/javascript">  
 function changeVideo(){ 
 
  var $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
  var $vid_obj        = _V_("example_video_1");
  $vid_obj.ready(function() {
  
		// hide the video UI
		  $("#div_video_html5_api").hide();
		  // and stop it from playing
		  //$vid_obj.pause();
		  $vid_obj.src([
			  { type: "rtmp/mp4", src: $target }
			]);
		  
		  //$("#div_video").removeClass("vjs-playing").addClass("vjs-paused");
		  // load the new sources
		  $vid_obj.load();
		  $("#div_video_html5_api").show();
		  $vid_obj.play();


	});
   
} 
 function pause(){ 
	var $vid_obj        = _V_("example_video_1");
	$vid_obj.ready(function() {
	// hide the video UI
		  $("#div_video_html5_api").hide();
		  // and stop it from playing
		  $vid_obj.pause();

	});
} 

function play(){ 
  var $vid_obj        = _V_("example_video_1");
  $vid_obj.ready(function() {
		  $vid_obj.play();
	});
} 
</script>
<![endif]-->
<!--[if gte IE 9]>
<link href="../videojs5/dist/video-js.min.css" rel="stylesheet">
  <script src="../videojs5/dist/ie8/videojs-ie8.min.js"></script>
<script src="../videojs5/dist/video.min.js"></script>
  

<video id="example_video_21" class="video-js vjs-default-skin" controls preload="none" width="640" height="264"
      poster="http://video-js.zencoder.com/oceans-clip.png"
      data-setup='{}' >
   <source src="" type='rtmp/mp4' />
    <p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
  </video>
  
<script type="text/javascript">  
	var $vid_obj        = videojs("example_video_21");
	var $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
 	var media_src = "rtmp://27.101.101.113/newsuwon/_definst_/&mp4:2015/6/20150624172056313/Mobile/2015-06-24_17-37-36_/20150624172056313.mp4";
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
alert('ie9?̻?');

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
<link href="../videojs5/dist/video-js.min.css" rel="stylesheet">
  <script src="../videojs5/dist/ie8/videojs-ie8.min.js"></script>
<script src="../videojs5/dist/video.min.js"></script>  

<video id="example_video_3" class="video-js vjs-default-skin" controls preload="auto" width="640" height="264"
      poster="http://video-js.zencoder.com/oceans-clip.png"
      data-setup='{}'>
    <source src="" type='rtmp/mp4' />
    
   
    <p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
  </video>
<!-- Unless using the CDN hosted version, update the URL to the Flash SWF -->
  <script>
    videojs.options.flash.swf = "../videojs5/dist/video-js.swf";
  </script>

<script type="text/javascript">  
var $vid_obj        = videojs("example_video_3");
	var $target          = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
 	var media_src = "rtmp://27.101.101.113/newsuwon/_definst_/&mp4:2015/6/20150624172056313/Mobile/2015-06-24_17-37-36_/20150624172056313.mp4";
  $vid_obj.ready(function() {
  
		// hide the video UI
		  $("#div_video_html5_api").hide();
		  
		  $vid_obj.src([
			  { type: "rtmp/mp4", src: $target }
			]);
		  
		  // load the new sources
		  $vid_obj.load();
		  $("#div_video_html5_api").show();
		  $vid_obj.play();
alert('No ie');

	});
var myPlayer = videojs("example_video_3");
 
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
 <!--<![endif]-->
<button onclick="changeVideo()">video</button>
<button onclick="pause()">pause</button>
<button onclick="play()">play</button>
 

 
 </body>
</html>
