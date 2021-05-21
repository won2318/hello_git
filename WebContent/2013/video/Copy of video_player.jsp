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
			
			if (omiBean.getThumbnail_file() != null && omiBean.getThumbnail_file().indexOf(".") > 0) {
				imgTmpThumb = "/upload/vod_file/"+omiBean.getThumbnail_file();
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

	String flag = request.getParameter("flag");
	if (flag == null) {
		flag = "M";
	}

//  메모 읽기

    int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
    Hashtable memo_ht = new Hashtable();
    MemoManager memoMgr = MemoManager.getInstance();
	if (ocode != null && ocode.length() > 0) {
	 memo_ht = memoMgr.getMemoListLimit(ocode, mpg, 3, flag);
	 
	}

    Vector memoVt = (Vector)memo_ht.get("LIST");
	com.yundara.util.PageBean mPageBean = null;

	if(memoVt != null && memoVt.size()>0){
    mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
	}
   if(memoVt == null || (memoVt != null && memoVt.size() <= 0)){
    	//결과값이 없다.
    	//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
    }
    else{
    	if(mPageBean != null){
    		mPageBean.setPagePerBlock(4);
	    	mPageBean.setPage(mpg);
    	}
    }

	int memo_size = 0;
	if (ocode != null && ocode.length() > 0) {
		memo_size = memoMgr.getMemoCount( ocode ,flag);
	}
	
	//관련 컨텐츠, 관련 프로그램, 화재의 영상
	Vector new_list12 = mgr.getMediaList_Xcode(omiBean.getXcode(), ocode, "ocode", 2); //  프로그램 (ycode)
	Vector new_list11 = mgr.getMediaList_Ycode( omiBean.getYcode(), ocode, "ocode", 2); // 분야 (xcode)

	//글 쓰는 페이지를 지나가는지 체크하는 세션 변수 저장
	session.putValue("write_check", "1");

	//랜덤 값을 세션에 저장하고 사용자가 입력한 확인 문자열이 세션에 저장된 문자열과 같은지 체크한다.
	int iRandomNum = 0;
	java.util.Random r = new java.util.Random(); //난수 객체 선언 및 생성
	iRandomNum = r.nextInt(999)+10000;
	session.putValue("random_num", String.valueOf(iRandomNum));

	

	String userAgent = request.getHeader("user-agent");
	
	String windows[] = {"MSIE 8", "MSIE 7"};
 	
	Boolean app = true;

	for(int i=0; i<windows.length; i++){
		if(StringUtils.indexOf(userAgent, windows[i]) > 0){
			app = false;
			break; 
		}else{
			app = true;
		}
	}

	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta NAME="title" content="수원 iTv">
	<meta NAME="description" content="수원 iTv, <%=otitle%>">
	<meta NAME="Keywords" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원">
	
	<meta property="fb:app_id" content="655179644496462" />
	<meta property="og:title" content="<%=otitle.replaceAll("&#39;","").replaceAll("'"," ").replaceAll("[\r\n]", " ") %>" />
	<meta property="og:description" content="<%=simple%>" />
	<meta property="og:url" content="<%=request.getRequestURL()+"?"+request.getQueryString()%>" />
	<meta property="og:image" content="<%=imgTmpThumb %>" />
	<meta property="og:site_name" content="tv.suwon.go.kr" />
	<meta property="og:type" content="website" />
	<link rel="image_src" href="<%=imgTmpThumb %>" />

	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
 
 
 	<script type="text/javascript" src="/Silverlight.js"></script>
 
	<script type="text/javascript" src="../include/js/jquery.masonry.min.js"></script>
	<script type="text/javascript" src="../include/js/script.js"></script>
	<script type="text/javascript" src="../include/js/close.js"></script>
	<script src="http://connect.facebook.net/ko_KR/all.js"></script>
 
 
   <link href="/videoJs/video-js.css" rel="stylesheet" type="text/css">
  <!-- video.js must be in the <head> for older IEs to work. -->
  <script src="/videoJs/video.js"></script>
 
  <script>
    videojs.options.flash.swf = "/videoJs/video-js.swf";
  </script>
<script src="/videoJs/lang/ko.js"></script>


 <script type="text/javascript">
 $(document).ready(function(){
 $('#share_button').click(function(e){
 e.preventDefault();
 FB.ui(
 {
 method: 'feed',
 name: 'tv.suwon.go.kr',
 link: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>',
 picture: '<%=imgTmpThumb%>',
 caption: '<%=otitle.replaceAll("&#39;","").replaceAll("'"," ").replaceAll("[\r\n]", " ")%>',
 description: '<%=simple%>',
 message: ''
 });
 });
 });
 </script>
<script> 
      FB.init({appId: "655179644496462", status: true, cookie: true});

      function postToFeed() {

        // calling the API ...
        var obj = {
          method: 'feed',
          redirect_uri: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>',
          link: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>',
          picture: '<%=imgTmpThumb%>',
          name: '<%=request.getServerName()%>',
          caption: '<%=otitle.replaceAll("&#39;","").replaceAll("'"," ").replaceAll("[\r\n]", " ")%>',
          description: '<%=simple%>'
        };

        function callback(response) {
          //document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
        }

        FB.ui(obj, callback);
      }
    
    </script>
	
</head>
<body>

<script language="javascript">

$(document).ready( function(){
	 $.get('/2013/comment/comment_list.jsp', {'ocode' : '<%=ocode%>', 'page' : '1'}, function(data){
		 $("#commentList").html(data);
 
    });
		return false;
	}
	);
 
 function point_go(){
 
	 $.get("proc_best_point.jsp", { ocode: "<%=ocode%>" },  function(data) { 
		 $("#recomcount").html(data); 
		alert('추천 되었습니다!');
		 },   "text" ); 
 
 }
	
// $(function(){
// 	$('#comment_form').validate({
// 	    rules: {
// 	    	wnick_name: { required: true},
// 	        pwd: { required: true},
// 	        chk_word: { required: true}, 
// 	        comment: { required: true },
// 	        },
// 	      messages: {
// 	    	  wnick_name: { required: "<strong>닉네입을 입력하세요.</strong>" },
// 	          pwd: { required: "<strong>비밀번호를 입력하세요.</strong>" },
// 	          chk_word: { required: "<strong>확인문자를 입력하세요.</strong>" },
// 	          comment: { required: "<strong>내용을 입력하세요.</strong>"},
// 	        },
// 	});
	 
// });

function comment_action(){
	if(filterIng(document.getElementById('comment').value, "comment") == false){
		return;
	}else {
	if (document.getElementById('wnick_name').value == '') {
		alert("닉네임을 입력하세요!");
	} else if (document.getElementById('pwd').value == '') {
		alert("비밀번호을 입력하세요!");
	} else if (document.getElementById('chk_word').value == '') {
		alert("확인문자를 입력하세요!");
	} else if (document.getElementById('comment').value == '') {
		alert("내용을 입력하세요!");
	} else {
     var bodyContent = $.ajax({
		    url: "/2013/comment/comment_list.jsp",  //<- 이동할 주소 
		    global: false, //<- 
		    type: "POST",  //<-  보낼때 타입 
		    data: $("#comment_form").serialize(),  //<-  보낼 파라메타 
		    dataType: "html",  //<-  받을때타입 
		    async:false,
		    success: function(data){  //<-  성공일때 
 
		    	 if (data != "") {
	                 $("dl#commentList").detach();  //하위 요서 데이터 제거
	                 $("#commentList").html(data); 
	                 document.getElementById('chk_word').value="";
	                 document.getElementById('comment').value="";
	                 //$.colorbox.resize(); 
	             } 
		    }
		 }
     
		);
	}
	}
}
 
function page_go(val){  
	$.get('/2013/comment/comment_list.jsp', {'ocode' : '<%=ocode%>', 'page' : val}, function(data){
		 
		 if (data != "") {
		 $("dl#commentList").detach();
		 $("#commentList").html(data);
		 }
		
   }); 
}

function deleteChk(muid) {
		var url = "../comment/pwd_check.jsp?ocode=<%=ocode%>&flag=<%=flag %>&muid="+muid;   
		 
		jQuery.colorbox({href:url, open:true});
}


 
//URL 복사
function copy_select(){ 

    var txt = "http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>";
    if ((navigator.appName).indexOf("Microsoft")!= -1) {
 
         if(window.clipboardData){
              var ret = null;
              ret = clipboardData.clearData();
              if(ret){
                   window.clipboardData.setData('Text', txt);
                   alert('클립보드에 주소가 복사되었습니다.');
              }else{
                   alert("클립보드 액세스 허용을 해주세요.");
              }
         }
    }
    else {
         //alert("해당 브라우저는 클립보드를 사용할 수 없습니다.\r\nURL을 [Ctrl+C]를 사용하여 복사하세요.");
         temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", txt);
    }

} 

 function facebook_share() {

	var ShareUrl;     // 공유 주소
	var DocTitle;     // 공유 제목
	var DocSummary;   // 공유 내용 간략 설명
	var DocImage;     // 공유 썸네일 ( 80x80 사이즈 추천 )

	//ShareUrl    = location.href; //현재 페이지 또는 퍼갈 주소를 설정
	ShareUrl    = "http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>"; //현재 페이지 또는 퍼갈 주소를 설정
	DocTitle    = '<%=otitle.replaceAll("\n","")%>';
	DocSummary  = '<%=simple%>';
	DocImage    = '<%=imgTmpThumb%>';  
			
			
	newwindow = window.open('http://www.facebook.com/sharer.php?s=100&p[url]='+encodeURIComponent(ShareUrl)+'&p[title]='+encodeURIComponent(DocTitle)+"&p[summary]="+encodeURIComponent(DocSummary)+"&p[images][0]="+encodeURIComponent(DocImage),'facebookpopup', 'toolbar=0, status=0, width=626, height=436');
 
	if (window.focus) {newwindow.focus();}

  }
   function twitter_share() {

	var ranNum = Math.floor(Math.random()*10); // 퍼가기 캐싱 방지

	var ShareUrl;     // 공유 주소
	var DocTitle;     // 공유 제목

	//ShareUrl    = location.href; //현재 페이지 또는 퍼갈 주소를 설정
	ShareUrl    = "http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>"; //현재 페이지 또는 퍼갈 주소를 설정
	DocTitle    = '<%=otitle.replaceAll("\n","")%>';

	newwindow = window.open('http://twitter.com/share?url='+encodeURIComponent(ShareUrl)+'&text='+encodeURIComponent(DocTitle)+"&nocache="+ranNum,'sharer', 'toolbar=0, status=0, width=626, height=436');
 
	if (window.focus) {
		newwindow.focus();
	}

}


   <%
   FucksInfoManager fmgr = FucksInfoManager.getInstance();
   Hashtable fresult_ht = null;
   fresult_ht = fmgr.getAllFucks_admin("");
   Vector vt = null;
   com.yundara.util.PageBean pageBean = null;
   int totalArticle =0; //총 레코드 갯수
   int totalPage = 0 ; //
   if(!fresult_ht.isEmpty() ) {
       vt = (Vector)fresult_ht.get("LIST");

   	if ( vt != null && vt.size() > 0){
           pageBean = (com.yundara.util.PageBean)fresult_ht.get("PAGE");
           if(pageBean != null){
           	pageBean.setPagePerBlock(10);
           	pageBean.setPage(1);
   			totalArticle = pageBean.getTotalRecord();
   	        totalPage = pageBean.getTotalPage();
           }
   	}
   }
   %>
   var rgExp;
   <%
   if(totalPage >0 ){
   %>
   var splitFilter = new Array("script",<%=totalPage%>);
   <%
   }else{%>
   var splitFilter = new Array("시팔","씨팔","쌍놈","쌍년","개년","개놈","개새끼","니미럴","개같은년","개같은놈","니기미","존나","좃나","십새끼","script");
   <%
   }
   %>
   <%
   if(vt != null && vt.size()>0){
   	int list = 0;
   	FuckInfoBean linfo = new FuckInfoBean();
   	for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
   		  com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)vt.elementAt(list));
   		  %>
   		  splitFilter[<%=i%>] = '<%=linfo.getFucks()%>';
   		  <%
   	}
   }
   %>
   function filterIng(str , id){
//   	alert(str);
   	for (var ii = 0 ;ii < splitFilter.length ; ii++ )
   	{

   		rgExp = splitFilter[ii];
   		if (str.match(rgExp))
   		{
   			alert(rgExp + "은(는) 불량단어로 입력하실수 없습니다");
   			var range = document.getElementsByName(id)[0].createTextRange();
   			range.findText(rgExp);
   			range.select();
   			return false;
   		}
   	}
   }
function top_link(url){ 
	 top.location.href=url;
}

function print_(){ 
 
	$('body').innerHTML = colorbox.innerHTML;
	window.print();
 
	}

 
function down_(){
	document.hidden_form.target="hiddenFrame";
	document.hidden_form.action="download.jsp?ocode=<%=ocode%>";
	document.hidden_form.submit();
}
 
</script>


<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
</noscript>


<div id="pWrap">
	<!-- container::메인컨텐츠 -->
	<div id="pLogo">
		<h2><a href="javascript:go_home();"><img src="../include/images/view_logo.gif" alt="수원 iTV 홈페이지 바로가기"/></a></h2>
 		<span class="close"><a href="javascript:this_close();"><img src="../include/images/btn_view_close.gif" alt="닫기"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle"><%=otitle%></h3>
			<span class="pTime">등록일 : <%=mk_date%>&nbsp;&nbsp;|&nbsp;&nbsp;방송시간 : <%=oPlay_time%> <span><% if (omiBean.getAttach_file() != null && omiBean.getAttach_file().indexOf(".") > 0) { %><a href="javascript:down_()"><img src="../include/images/file_down.gif" alt="첨부파일"/></a><%} %> <a href="javascript:print_()"><img src="../include/images/icon_print.gif" alt="인쇄"/></a></span></span>
			<div class="pPlayer">
				<div id="SilverlightControlHost" class="silverlightHost" >
<%-- 					<iframe title="실버라이트 동영상 재생 창" id="silver_player" name="silver_player" src="/silverPlayer.jsp?ocode=<%=ocode%>&width=579&height=370&auto_p=<%=auto_p%>" scrolling="no" width="579" height="370" marginwidth="0" frameborder="0" framespacing="0" ></iframe> --%>
 
 <%if (app) { %>
  <video id="video_player" class="video-js vjs-default-skin" controls preload="none" width="579" height="370"
      poster="<%=imgTmpThumb %>"
      data-setup='{"techOrder":["flash"]}'>
    <source id="video_source" src="#" type='rtmp/mp4' />
  </video>
 <%} else { %>
  <video id="video_player" class="video-js vjs-default-skin" autoplay controls preload="none" width="579" height="370"
		   poster="<%=imgTmpThumb %>"
		      data-setup='{}'>
		    <source src="#" type='video/mp4' />
   </video>
 <%} %>
 
   
   
				</div> 
			</div>
			<div class="pSubject"><%=chb.getContent_2(odesc,"true")%></div>
			<span class="pRecomIcon"><a href="javascript:point_go();"><img src="../include/images/btn_like.gif" alt="좋아요 Like!"/></a></span>
			<!-- comment::댓글 -->
			<div class="comment">
				<div id="commentFrame">
					<h4 class="cTitle">리뷰의견(<span><%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%></span>)건</h4>
					<div class="commentInput">
					<form id="comment_form" name="comment_form" method="post" action="javascript:comment_action()" >
						<input type="hidden" name="ocode" value="<%=ocode%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
						<input type="hidden" name="flag" value="<%=flag %>" />
 
						<span class="warning">의견작성<span>&nbsp;&nbsp;|&nbsp;&nbsp;비방, 욕설, 광고 등은 사전협의 없이 삭제됩니다.</span></span>
						<ul>
							<li><label for="wnick_name">닉네임</label></li>
							<li><input type="text" name="wnick_name" value="" id="wnick_name" title="닉네임"/></li>
							<li class="pl20"><label for="pwd">비밀번호</label></li>
							<li><input type="password" name="pwd" value=""  id="pwd" title="비밀번호"/></li>
						</ul>
						<ul class="checkText">
							<li><label for="chk_word">확인문자열</label></li>
							<li><input type="text" name="chk_word" value="" id="chk_word" size="10" title="확인 문자열"  />
							<span class="checkText1"><%=iRandomNum %></span> <span class="checkText2">* 좌측 숫자를 입력 하십시오.</span></li>
						</ul>
						<div class="input_wrap">
							<textarea id="comment" name="comment" wrap="hard"  required="required" ></textarea>
							<input type="image" src="../include/images/btn_reply_ok.gif" alt="확인" class="img"/>
						</div>
						</form>
					</div>
					<div class="commentList" id="commentList"> 
					<!-- 댓글 목록 불러 오기 -->
					</div>
					<form name="comment_del" method="post" action="../comment/pwd_check.jsp" >
					<input type="hidden" name="ocode" value="<%=ocode%>" />
					<input type="hidden" name="jaction" value="del" />
					<input type="hidden" name="muid" value="" />
					<input type="hidden" name="pwd" value="<%=user_key %>" />
					<input type="hidden" name="flag" value="<%=flag %>" />
					</form>
						 
				</div>
			</div>
			<!-- //comment::댓글 -->
		</div>

		<div class="pAside">
			<div class="pInfo">
				<span class="pHit">플레이수<span><%=oHit_count%></span></span>
				<span class="pRecom">추천수<span id="recomcount"><%=recomcount%></span></span>
			</div>
			<div class="pLink">
				<span>공유하기 <a href="javascript:copy_select();"><img src="../include/images/icon_view_link.gif" alt="링크"/></a>  <a href="javascript:twitter_share();"><img src="../include/images/icon_view_twitter.gif" alt="트위터"/></a> <a href="javascript:postToFeed();"><img src="../include/images/icon_view_facebook.gif" alt="페이스북"/></a></span>
			</div>
			<div class="conContent">
				<h4>관련 콘텐츠</h4>
				<ul class="pList">
				<% 
					if (new_list12 != null && new_list12.size() > 0) {
 							try {
								int i = 1;
						for (Enumeration e = new_list12.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(omiBean,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/" + omiBean.getSubfolder() +  "/thumbnail/" + omiBean.getModelimage();

									if (omiBean.getModelimage() == null || omiBean.getModelimage().length() <= 0 || omiBean.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (omiBean.getThumbnail_file() != null && omiBean.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+omiBean.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(omiBean.getTitle(),false);
									title = title.replaceAll("&#39;", "");
									
									%>
							<li>
								<span class="img"><a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><span class="playPop"></span><img src="<%=imgTmp %>" alt="<%=title%>"/></a></span>
								<span class="total">
									<span class="cate"><a href="javascript:top_link('/2013/video/video_list.jsp?ccode=<%=omiBean.getCcode()%>');"><%=omiBean.getCtitle()%></a></span>
									<a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><%=omiBean.getTitle()%></a>
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
			</div>
			<div class="conProgram">
				<h4>관련 프로그램</h4>
				<ul class="pList">
				
				
				<% 
					if (new_list11 != null && new_list11.size() > 0) {
 							try {
								int i = 1;
						for (Enumeration e = new_list11.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(omiBean,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/noimg_small.gif";
									String imgTmp = SilverLightPath + "/"+omiBean.getSubfolder()+"/thumbnail/" + omiBean.getModelimage();

									if (omiBean.getModelimage() == null || omiBean.getModelimage().length() <= 0 || omiBean.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									if (omiBean.getThumbnail_file() != null && omiBean.getThumbnail_file().indexOf(".") > 0) {
										imgTmp = "/upload/vod_file/"+omiBean.getThumbnail_file();
									}
									String title=com.vodcaster.utils.TextUtil.text_replace(omiBean.getTitle(),false);
									title = title.replaceAll("&#39;", "");
									%>
							<li>
								<span class="img"><a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><span class="playPop"></span><img src="<%=imgTmp %>" alt="<%=title%>"/></a></span>
								<span class="total">
									<span class="cate"><a href="javascript:top_link('/2013/video/video_list.jsp?ccode=<%=omiBean.getCcode()%>');"><%=omiBean.getCtitle()%></a></span>
									<a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><%=omiBean.getTitle()%></a>
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
			</div> 
			<%@ include file = "../include/sub_topic.jsp"%> 
		</div>
		<form name="hidden_form" method="post" >
			<IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0" style="display: none;"></IFRAME>
			</form>
	</div>
</div>
 
<script type="text/javascript">  

var myPlayer = videojs("video_player");
 
function changeVideo(media_src){ 
  //var media_src = "rtmp://115.84.164.18/seoul/_definst_/&mp4:2012/3/20120308180326061/Encoded/2012-03-08_18.04.04_/20120308180326061.mp4";
  <%if (app) { %> 
  	myPlayer.src({"type":"rtmp/mp4", "src":media_src}); 
  <%} else { %>
  	myPlayer.src({"type":"video/mp4", "src":media_src}); 
  <%} %>
  myPlayer.play();
} 

window.onload = function(){
 
	//changeVideo();
	$.getJSON("video_source.jsp?ocode=<%=ocode%>",function(data){
		$.each(data,function(){
 
			changeVideo(this.media_src);
		})
	});
}



   </script>  
</body>
</html>