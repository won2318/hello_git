<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.util.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@page import="com.yundara.util.TextUtil"%>
<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@page import="com.hrlee.sqlbean.MenuManager2"%>
<%@page import="com.vodcaster.sqlbean.DirectoryNameManager"%>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/> 

<%@ include file="/include/chkLogin.jsp"%>

<%
	request.setCharacterEncoding("EUC-KR");
contact.setPage_cnn_cnt("M"); // ������ ���� ī��Ʈ ����

	int pg = 1;
	String cpage = StringUtils.defaultIfEmpty(request.getParameter("page"), "1");
	if(cpage == null || cpage.length()<= 0 || cpage.equals("null")) {
	    pg = 1;
	}else {
		try{
			pg = Integer.parseInt(cpage);
		}catch(Exception ex){
			pg =1;
		}
	}
	
	String hValue = request.getHeader("user-agent");
	String protocal = "http://";
	if(hValue.indexOf("Android") != -1)
		//protocal = "rtsp://";
		protocal = "Android";
	else if(hValue.indexOf("iPhone") != -1)
		//protocal = "http://";
		protocal = "iPhone";
		
	String category = TextUtil.nvl(request.getParameter("category"));
	String ocode = TextUtil.nvl(request.getParameter("ocode"));
 
	String strLink = "?page="+pg + "&category="+category;
	
	String title = "";
	String playtime = "";
	String description = "";
	String simple ="";
	String filename = "";
	String modelimage = "";
	int hitcount = 0;
	int recomcount = 0;
	String subfolder = "";
	String download_flag = "";
	String mk_date = "";
	String imgurl ="../include/images/noimg.gif";
	String imgTmp = "";
	MediaManager mgr = MediaManager.getInstance();
	Vector vt_result = mgr.getOMediaInfo_cate(ocode);
	String media_url = "";
	if(vt_result != null && vt_result.size() > 0)
	{
		try {
			Enumeration e2 = vt_result.elements();
			com.yundara.beans.BeanUtils.fill(omiBean, (Hashtable) e2.nextElement());
			title = omiBean.getTitle();
			playtime = omiBean.getPlaytime();
			description = omiBean.getDescription();
			filename = omiBean.getFilename();
			modelimage = omiBean.getModelimage();
			simple = omiBean.getContent_simple();
			simple = simple.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
			imgTmp = SilverLightPath + "/Clientbin/Media/" + omiBean.getSubfolder()+"/thumbnail/"+omiBean.getModelimage();
			
			if(modelimage== null || modelimage.length() <=0 || modelimage.equals("null")) {
				imgTmp = imgurl;
			}
			if (omiBean.getThumbnail_file() != null && omiBean.getThumbnail_file().indexOf(".") > 0) {
				imgTmp = "http://tv.suwon.go.kr/upload/vod_file/"+omiBean.getThumbnail_file();
			}
			
			if (omiBean.getOcode() != "" && omiBean.getOcode().length() > 0) {
			hitcount = omiBean.getHitcount();
			recomcount = omiBean.getRecomcount();
			subfolder = omiBean.getSubfolder();
			//download_flag = TextUtil.nvl(String.valueOf(vt_result.elementAt(8)));
			mk_date = omiBean.getMk_date();
			if(deptcd == null) deptcd = "";
			if(gradecode == null) gradecode = "";
			com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, ocode, request.getRemoteAddr(),"H");
			String GB = "MV";
			int year=0, month=0, date=0;
			Calendar cal = Calendar.getInstance();
			year  = cal.get(Calendar.YEAR);
		    month = cal.get(Calendar.MONTH)+1;
		    date = cal.get(Calendar.DATE);
				
			MenuManager2 mgr2 = MenuManager2.getInstance();
			mgr2.insertHit(omiBean.getCcode(),year,month,date,GB);
			}
			
			media_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME + DirectoryNameManager.SILVERMEDIA + "/" + subfolder + "/Mobile/" + omiBean.getMobilefilename();
			
			if(protocal.equals("Android")){
				//media_url="rtsp://"+DirectoryNameManager.SV_LIVE_SERVER_IP + ":1935/newsuwon/_definst_/mp4:"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename();
				media_url="http://"+DirectoryNameManager.SV_LIVE_SERVER_IP+"/ClientBin/Media/"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename();
			 }else if(protocal.equals("iPhone")){ 
				media_url="http://"+DirectoryNameManager.SV_LIVE_SERVER_IP + ":1935/newsuwon/_definst_/mp4:"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename()+"/playlist.m3u8";
			} 
			
			 //out.println(media_url);
		 
			
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�1.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}
	}
	else
	{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�2.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
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
	<meta property="og:url"                content="<%=request.getRequestURL()+"?"+request.getQueryString()%>" />
	<meta property="og:type"               content="article" />
	<meta property="og:title"              content="<%=title%>" />
	<meta property="og:description"        content="<%=simple%>" />
	<meta property="og:image"              content="<%=imgTmp %>" />
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
    href: '<%=request.getRequestURL()+"?"+request.getQueryString()%>',
  }, function(response){});
}

function postToFeed() {
var url = "<%=request.getRequestURL()+"?"+request.getQueryString()%>";
var msg = "<%=title%>";

	var href="http://www.facebook.com/sharer.php?u="+encodeURIComponent(url)+"&t="+encodeURIComponent(msg);
		var pop=window.open(href, "shareFacebook", "");
		pop.focus();
		
		}
		
 
</script>
	
<script type="text/javascript">
$(document).ready( function(){
	
	 $.get('./comment.jsp', {'ocode' : '<%=ocode%>', 'page' : '1','flag':'M'}, function(data){
		 //alert(data);
		 $("#comment_link").html(data);
 
    });
		return false;
	}
	);
 
 
 function point_go(){

	 $.get("./proc_best_point.jsp", { ocode: "<%=ocode%>" },  function(data) {
	 
		 $("#recomcount").html(data); 
		alert('��õ �Ǿ����ϴ�!');
		 },   "text" ); 
 
 }
 
 

function comment_action(){
 if ( document.getElementById('wnick_name').value=="") {
	 alert('�г����� �Է��ϼ���');
 } else if ( document.getElementById('pwd').value=="") {
	 alert('��й�ȣ�� �Է��ϼ���');
 } else if ( document.getElementById('comment_write').value=="") {
	 alert('������ �Է��ϼ���');
 } else {
     var bodyContent = $.ajax({
		    url: "./comment.jsp?ocode=<%=ocode%>&flag=M",  //<- �̵��� �ּ� 
		    global: false, //<- 
		    type: "POST",  //<-  ������ Ÿ�� 
		    data: $("#comment_form").serialize(),  //<-  ���� �Ķ��Ÿ 
		    dataType: "html",  //<-  ������Ÿ�� 
		    async:false,
		    success: function(data){  //<-  �����϶� 
 //alert(data);
		    	 if (data != "") {
	                 $("dl#comment_link").detach();  //���� �伭 ������ ����
	                 $("#comment_link").html(data); 
	                 document.getElementById('pwd').value="";
	                 document.getElementById('comment_write').value="";
	                 //$.colorbox.resize(); 
	             } 
		    }
		 }
     
		);
 }
	 
}
 
function page_go(val){  
	$.get('./comment.jsp', {'ocode' : '<%=ocode%>', 'page' : val, 'flag':'M'}, function(data){
		 
		 if (data != "") {
		//	 alert(data);
		 $("dl#comment_link").detach();
		 $("#comment_link").html(data);
		 }
		
   }); 
}

function deleteChk(muid) {

		var url = "./pwd_check.jsp?ocode=<%=ocode%>&flag=M&muid="+muid;   
		//jQuery.colorbox({href:url, open:true});
		//location.href=url;
		window.open(url,"pwd_check", "width=100%,height=100%,scrollbars=yes,resizeable=no"); 
} 
 

//URL ����
function copy_select(){ 

  var txt = "http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>";
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
	ShareUrl    = "http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>"; //���� ������ �Ǵ� �۰� �ּҸ� ����
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
			<div class="vodView" >
				<div class="topTitle"><h3><%=title%></h3>
				<%if (request.getHeader("referer") != null && request.getHeader("referer").contains("mnews.suwon.go.kr") ) { %>
					<a href="javascript:history.back();" data-rel="back" data-role="button" >
				<% } else {%>
					<a href="/" >
				<% } %><img src="../include/images/icon_close.png" width="23" height="23" alt="����ȭ��" /></a></div>
				
				<ul>
					<li><span class="time"><%=mk_date %> / ��۽ð� : <%=playtime %></span></li>
					<li><a href="<%=media_url%>"><span class="playBig"></span><img src="<%=imgTmp%>" alt="<%=title%>" width="100%"/></a></li>
					<li><%=chb.getContent_2(description,"true")%></li>
					<li><span class="pRecomIcon"><a href="javascript:point_go('<%=ocode%>');"><img src="../include/images/btn_like.gif" alt="���ƿ� Like!" width="61" height="62"/></a></span></li>
				</ul>
				<ul class="info">
					<li>
						<span class="playhit">�÷��� ��:<strong><%=hitcount %></strong></span>
						<span class="recom">��õ��:<strong id="recomcount"><%=recomcount %></strong></span>
					</li>
					<li>
						<span class="link">�����ϱ�
						<strong>

							<a href="javascript:copy_select();"><img src="../include/images/icon_view_link.gif" alt="��ũ" width="29" height="29"/></a>  
							<a href="javascript:twitter_share();"><img src="../include/images/icon_view_twitter.gif" alt="Ʈ����" width="29" height="29"/></a> 
							<a href="javascript:postToFeed();" id="shareBtn"><img src="../include/images/icon_view_facebook.gif" alt="���̽���" width="29" height="29"/></a>
							<a id="kakao-link-btn" href="javascript:;"><img src="../include/images/icon_view_cacao.gif" alt="īī����" width="29" height="29"/></a> 
							<script type="text/javascript">
								new ShareBand.makeButton({"lang":"ko-KR","type":"d","text":"mnews.suwon.go.kr","withUrl":true});
							</script>
							
						</strong>
						</span>
					</li>
				</ul>
				<!-- comment::��� -->
					<div class="comment" id="comment_link">
					</div>
				<!-- //comment::��� -->
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
        src: '<%=imgTmp%>',
        width: '300',
        height: '200'
      },
      webLink : {
        text: '��������',  //����
        url: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>' // �� ������ �� �÷����� ����� �������� URL�̾�� �մϴ�.
      }
    });
  //]]>
  

	 
</script>

</body>
</html>