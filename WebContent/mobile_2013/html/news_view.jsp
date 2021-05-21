 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.news.*"%> 
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
 <jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<%@ include file="/include/chkLogin.jsp" %> 
<%
 request.setCharacterEncoding("EUC-KR");
contact.setPage_cnn_cnt("M"); // 페이지 접속 카운트 증가
String menu_id = "0101" ;
String menu_title="주요뉴스";
if(request.getParameter("menu_id") != null && request.getParameter("menu_id").length() > 0 && !request.getParameter("menu_id").equals("null") )
{
	menu_id =TextUtil.nvl(request.getParameter("menu_id"));
	 
} 
if (menu_id != null && menu_id.equals("0101") ) {
	menu_title="주요뉴스";
} else if (menu_id != null && menu_id.equals("0102")) {
	menu_title="최신뉴스";
} else if (menu_id != null && menu_id.equals("0301")) {
	menu_title="시민기자";
} else if (menu_id != null && menu_id.equals("0302")) {
	menu_title="만화";
}else if (menu_id != null && menu_id.equals("0303")) {
	menu_title="칼럼";
}
String idx = "";
if(request.getParameter("idx") != null && request.getParameter("idx").length() > 0 && !request.getParameter("idx").equals("null")){
	idx = request.getParameter("idx");
}else{
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
    out.println("alert('접근경로가 잘못되었습니다. 다시 한번 확인 하여 주시기 바랍니다.')");
    out.println("history.go(-1)");
    out.println("</SCRIPT>");
}

ArticleManager mgr = ArticleManager.getInstance();
Vector vt =	mgr.getArticle_user(idx);

String title = "";
String content = "";
String writer = "";
String img = "";

String imgZoom = "";
String date = "";
//String server = request.getServerName();

String address = "http://mnews.suwon.go.kr/mobile/html/news_view.jsp?idx="+idx+"&menu_id="+menu_id;

Hashtable ht = new Hashtable();
if(vt != null && vt.size() > 0){
	ht = (Hashtable)vt.get(0);
	
	title = String.valueOf(ht.get("title")).replace("\\","");
	date = String.valueOf(ht.get("date")); 
	writer = String.valueOf(ht.get("name")); 
	content = String.valueOf(ht.get("content")).replace("\\","");
	content = content.replaceAll("<p>", "");
	content = content.replaceAll("</p>", "");
	content = content.replaceAll("<p class=\\&quot;바탕글\\&quot;>", "");

	for(int i=1; i<=4; i++){
		String temp_img = String.valueOf(ht.get("img_file"+i));
	
		if(temp_img != null && temp_img.length() > 0 && temp_img.lastIndexOf(".") > 0){
		if (img == null || img.length() <= 0 ) {
			img = "http://news.suwon.ne.kr/upload"+String.valueOf(ht.get("img_file"+i));
		}
			temp_img = "http://news.suwon.ne.kr/upload"+String.valueOf(ht.get("img_file"+i));
 			
			imgZoom = "<img src='"+temp_img+"' title='"+title+"' width='100%' class='pti'/>";
			
			content = content.replace("{img"+i+"}", imgZoom);
		}
	}
  
}
 
%> 

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />
	<meta name="Author" content="mnews.suwon.go.kr">
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="pragma" content="no-cache">
 	<meta property="fb:app_id"              content="1239082459488508" />
	<meta property="og:url"                content="<%=address%>" />
	<meta property="og:type"               content="article" />
	<meta property="og:title"              content="<%=title%>" />
	<meta property="og:description"        content="<%=title%>" />
	<meta property="og:image"              content="<%=img %>"> 
	<meta property="og:image:width"      content="400">
	<meta property="og:locale"              content="ko_KR" />
		
	<title>수원iTV</title>
	<link rel="stylesheet" type="text/css" href="../include/css/default.css">
	<script type="text/javascript" src="../include/js/script2.js"></script>
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
 
   <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
 <script type="text/javascript" src="//developers.band.us/js/share/band-button.js?v=07092016"></script>
  <script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1239082459488508',
      xfbml      : true,
      version    : 'v2.7'
    });
  };
   (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/ko_KR/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>
 	
<script>

function postToFeed2(){
  FB.ui({
    method: 'share',
    display: 'popup',
    href: '<%=address%>',
  }, function(response){});
  
  }
  
  function postToFeed() {
var url = "<%=address%>";
var msg = "<%=title%>";

	var href="http://www.facebook.com/sharer.php?u="+encodeURIComponent(url)+"&t="+encodeURIComponent(msg);
		var pop=window.open(href, "shareFacebook", "");
		pop.focus();
		
		}
		
</script>
    
<script type="text/javascript">
 function Resize_Box(){
 
     var x = $('body').width();
     var y = $('body').height();
     parent.$.fn.colorbox.resize({
         innerWidth: x,
         innerHeight: y
     });
 }

 $(document).ready(function(){
     Resize_Box();
 
 });

 
//URL 복사
 function copy_select(){ 

   var txt = "<%=address%>";
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
       // alert("해당 브라우저는 클립보드를 사용할 수 없습니다.\r\nURL을 [Ctrl+C]를 사용하여 복사하세요.");
	   temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", txt);
   }

 } 
 
 
	
	 function twitter_share() {

	var ranNum = Math.floor(Math.random()*10); // 퍼가기 캐싱 방지

	var ShareUrl;     // 공유 주소
	var DocTitle;     // 공유 제목

	//ShareUrl    = location.href; //현재 페이지 또는 퍼갈 주소를 설정
	ShareUrl    = "<%=address%>"; //현재 페이지 또는 퍼갈 주소를 설정
	DocTitle    = "<%=title%>";

	newwindow = window.open('http://twitter.com/share?url='+encodeURIComponent(ShareUrl)+'&text='+encodeURIComponent(DocTitle)+"&nocache="+ranNum,'sharer', 'toolbar=0, status=0, width=626, height=436');

	if (window.focus) {
		newwindow.focus();
	}

}

	   
 </script>
 

 
</head>
<body>
 
<div id="container"  > 
	<div class="major"  >
	
	<section>
		<div class="vodView">
	 		<div class="topTitle"><h3><%=title%></h3> 
	 		<%if (request.getHeader("referer") != null && request.getHeader("referer").contains("mnews.suwon.go.kr") ) { %>
					<a href="javascript:history.back();" data-rel="back" data-role="button" >
				<% } else {%>
					<a href="/" >
				<% } %><img src="../include/images/icon_close.png" width="23" height="23" alt="이전화면" /></a></div> 
		
			<ul>
				<li><span class="time"><%=date%> | <%=writer%></span></li>
				<li  >
					<%=content.replace("&quot;","\"")%>
				</li>
			</ul>
			<ul class="info">
				<li>
					<span class="link">공유하기
					<strong>
						<a href="javascript:copy_select();"><img src="../include/images/icon_view_link.gif" alt="링크" width="29" height="29"/></a>  
 
						<a href="javascript:twitter_share();"><img src="../include/images/icon_view_twitter.gif" alt="트위터" width="29" height="29"/></a>
						<a href="javascript:postToFeed();"><img src="../include/images/icon_view_facebook.gif" alt="페이스북" width="29" height="29"/></a>
						<a id="kakao-link-btn" href="javascript:;"><img src="../include/images/icon_view_cacao.gif" alt="카카오톡" width="29" height="29"/></a> 
							<script type="text/javascript">
								new ShareBand.makeButton({"lang":"ko-KR","type":"d","text":"mnews.suwon.go.kr","withUrl":true});
							</script>
							
					 
					</strong>
					</span>
				</li>
			</ul>
			 
		</div>
	</section> 
	</div>
</div>
  <script type='text/javascript'>
  //<![CDATA[
    // // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('1b803593c306e6c6fcab67e42846b304');
    // // 카카오톡 링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
    Kakao.Link.createTalkLinkButton({
      container: '#kakao-link-btn',
      label: '<%=title%>',
      image: {
        src: '<%=img%>',
        width: '300',
        height: '200'
      },
      webLink : {
        text: '수원뉴스',  //제목
        url: '<%=address%>' // 앱 설정의 웹 플랫폼에 등록한 도메인의 URL이어야 합니다.
      }
    });
  //]]>
  

	 
</script> 
</body>
</html>