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
 
	
	//<!-- 영상사이즈 690X388 -->
	String size=" width=\"690\" height=\"388\" ";
	String size2 = "690";
	if (type != null && type.equals("sub")) {
		size=" width=\"690\" height=\"388\" ";
		size2 = "690";
	}else if (type != null && type.equals("vodman")) {
		size=" width=\"750\" height=\"550\" ";
		size2 = "750";
	}else if (type != null && type.equals("bestWeek")) {
		size=" width=\"392\" height=\"254\" ";
		size2 = "392";
	}else if (type != null && type.equals("main")) {
		size=" width=\"525\" height=\"295\" ";
		size2 = "500";
	}
	
	
	String auto_p = "True";
	if(request.getParameter("auto_p") != null && request.getParameter("auto_p").length()>0 && !request.getParameter("auto_p").equals("null") && request.getParameter("auto_p").equals("True") ) {
		auto_p = "True";
	} else{
		auto_p = "False";
	}
 
 
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
			if (omiBean.getThumbnail_file() != null && omiBean.getThumbnail_file().indexOf(".") > 0) {
				imgTmpThumb = "/upload/vod_file/"+omiBean.getThumbnail_file();
			}
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
	String media_src = "";
	if (StringUtils.isNotEmpty(omiBean.getFilename())) {
		ofilename = omiBean.getFilename(); 
		//media_src = "//27.101.101.113/ClientBin/Media/2018/11/20181123105805793/Encoded/20181123075243763_10_59_29.mp4";
		//media_src = com.vodcaster.sqlbean.DirectoryNameManager.MMS_SERVER+ "/ClientBin/Media/"+omiBean.getSubfolder()+"/Encoded/"+omiBean.getEncodedfilename();
 
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
	<style>
		* {padding:0; margin:0;}
	</style>
  
</head>
<body> 
		
<script src="/videoJs/jquery.min.js"></script>
<link href="/videoJs_2019/js/video-js.min.css" rel="stylesheet">
<script src="/videoJs_2019/js/video.min.js"></script>
<script>
window.HELP_IMPROVE_VIDEOJS = false;
</script>


<video
    id="my-player"
    class="video-js vjs-default-skin"
    <%=size%>
    loop="true"
    controls
    autoplay="<%=auto_p %>"
    preload="auto"
    poster="<%=imgTmpThumb %>"
    data-setup='{}'>
  <source src="<%=media_src %>" type="video/mp4"></source> 
  
</video>

<script>
var player = videojs('my-player');
 
$.getJSON("/2017/video/video_source_2019.jsp?ocode=<%=ocode%>",function(data){ 
	 
	$.each(data,function(){
		player.src([
			{type:"video/mp4", src:this.media_src}  // wowza http
			//{type:"video/mp4", src:"//192.168.42.128:3003/media/test3.mp4"}  // nginx http
			
			
		]); 

	}); 
});	

var options = {};

var player = videojs('my-player', options, function onPlayerReady() {
  videojs.log('Your player is ready!'); 
 
  // In this context, `this` is the player that was created by Video.js.
  this.play();

  // How about an event listener?
  this.on('ended', function() {
    videojs.log('Awww...over so soon?!');
  });
});

	
function changeVideo(){ 
	$.getJSON("/2017/video/video_source_2019.jsp?ocode=<%=ocode%>",function(data){ 
		 
		$.each(data,function(){
			player.src([
				{type:"video/mp4", src:this.media_src}
			]); 
			//changeVideo(this.media_src);
			//$target = this.media_src; 
			// $target = "rtmp://27.101.101.113:1935/newsuwon/_definst_/&mp4:2018/11/20181123105805793/Encoded/20181123075243763_10_59_29.mp4";
		}); 
	});	
	 
	player.play() 
} 
	
function pause(){ 
	player.pause();
} 

function play(){ 
	player.play();
} 

</script>
  
 
 </body>
</html>
