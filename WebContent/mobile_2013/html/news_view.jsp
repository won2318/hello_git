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
contact.setPage_cnn_cnt("M"); // ������ ���� ī��Ʈ ����
String menu_id = "0101" ;
String menu_title="�ֿ䴺��";
if(request.getParameter("menu_id") != null && request.getParameter("menu_id").length() > 0 && !request.getParameter("menu_id").equals("null") )
{
	menu_id =TextUtil.nvl(request.getParameter("menu_id"));
	 
} 
if (menu_id != null && menu_id.equals("0101") ) {
	menu_title="�ֿ䴺��";
} else if (menu_id != null && menu_id.equals("0102")) {
	menu_title="�ֽŴ���";
} else if (menu_id != null && menu_id.equals("0301")) {
	menu_title="�ùα���";
} else if (menu_id != null && menu_id.equals("0302")) {
	menu_title="��ȭ";
}else if (menu_id != null && menu_id.equals("0303")) {
	menu_title="Į��";
}
String idx = "";
if(request.getParameter("idx") != null && request.getParameter("idx").length() > 0 && !request.getParameter("idx").equals("null")){
	idx = request.getParameter("idx");
}else{
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
    out.println("alert('���ٰ�ΰ� �߸��Ǿ����ϴ�. �ٽ� �ѹ� Ȯ�� �Ͽ� �ֽñ� �ٶ��ϴ�.')");
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
	content = content.replaceAll("<p class=\\&quot;������\\&quot;>", "");

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
		
	<title>����iTV</title>
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

 
//URL ����
 function copy_select(){ 

   var txt = "<%=address%>";
   if ((navigator.appName).indexOf("Microsoft")!= -1) {

        if(window.clipboardData){
             var ret = null;
             ret = clipboardData.clearData();
             if(ret){
                  window.clipboardData.setData('Text', txt);
                  alert('Ŭ�����忡 �ּҰ� ����Ǿ����ϴ�.');
             }else{
                  alert("Ŭ������ �׼��� ����� ���ּ���.");
             }
        }
   }
   else {
       // alert("�ش� �������� Ŭ�����带 ����� �� �����ϴ�.\r\nURL�� [Ctrl+C]�� ����Ͽ� �����ϼ���.");
	   temp = prompt("�� ���� Ʈ���� �ּ��Դϴ�. Ctrl+C�� ���� Ŭ������� �����ϼ���", txt);
   }

 } 
 
 
	
	 function twitter_share() {

	var ranNum = Math.floor(Math.random()*10); // �۰��� ĳ�� ����

	var ShareUrl;     // ���� �ּ�
	var DocTitle;     // ���� ����

	//ShareUrl    = location.href; //���� ������ �Ǵ� �۰� �ּҸ� ����
	ShareUrl    = "<%=address%>"; //���� ������ �Ǵ� �۰� �ּҸ� ����
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
				<% } %><img src="../include/images/icon_close.png" width="23" height="23" alt="����ȭ��" /></a></div> 
		
			<ul>
				<li><span class="time"><%=date%> | <%=writer%></span></li>
				<li  >
					<%=content.replace("&quot;","\"")%>
				</li>
			</ul>
			<ul class="info">
				<li>
					<span class="link">�����ϱ�
					<strong>
						<a href="javascript:copy_select();"><img src="../include/images/icon_view_link.gif" alt="��ũ" width="29" height="29"/></a>  
 
						<a href="javascript:twitter_share();"><img src="../include/images/icon_view_twitter.gif" alt="Ʈ����" width="29" height="29"/></a>
						<a href="javascript:postToFeed();"><img src="../include/images/icon_view_facebook.gif" alt="���̽���" width="29" height="29"/></a>
						<a id="kakao-link-btn" href="javascript:;"><img src="../include/images/icon_view_cacao.gif" alt="īī����" width="29" height="29"/></a> 
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
    // // ����� ���� JavaScript Ű�� ������ �ּ���.
    Kakao.init('1b803593c306e6c6fcab67e42846b304');
    // // īī���� ��ũ ��ư�� �����մϴ�. ó�� �ѹ��� ȣ���ϸ� �˴ϴ�.
    Kakao.Link.createTalkLinkButton({
      container: '#kakao-link-btn',
      label: '<%=title%>',
      image: {
        src: '<%=img%>',
        width: '300',
        height: '200'
      },
      webLink : {
        text: '��������',  //����
        url: '<%=address%>' // �� ������ �� �÷����� ����� �������� URL�̾�� �մϴ�.
      }
    });
  //]]>
  

	 
</script> 
</body>
</html>