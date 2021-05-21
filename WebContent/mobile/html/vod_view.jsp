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
 

<%@ include file = "../include/head.jsp"%>

<%
	request.setCharacterEncoding("EUC-KR");
//contact.setPage_cnn_cnt("M"); // ������ ���� ī��Ʈ ����

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
	
// 	String hValue = request.getHeader("user-agent");
// 	String protocal = "http://";
// 	if(hValue.indexOf("Android") != -1)
// 		//protocal = "rtsp://";
// 		protocal = "Android";
// 	else if(hValue.indexOf("iPhone") != -1)
// 		//protocal = "http://";
// 		protocal = "iPhone";
		
	String category = TextUtil.nvl(request.getParameter("category"));
	 
	String menu_title = "��ü����";




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
	
	Vector news = null;
	
	MediaNewsInfoBean newsInfoBean = new com.hrlee.sqlbean.MediaNewsInfoBean();
	MediaNewsManager mnm = MediaNewsManager.getInstance();
	
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
			imgTmp = SilverLightPath + "/" + omiBean.getSubfolder()+"/thumbnail/_medium/"+omiBean.getModelimage();
			
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
			
			news = mnm.getNews_ListAll(ocode);
			
			}
			
			media_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME + DirectoryNameManager.SILVERMEDIA + "/" + subfolder + "/Mobile/" + omiBean.getMobilefilename();
			
			if(protocal.equals("Android")){
				//media_url="rtsp://"+DirectoryNameManager.SV_LIVE_SERVER_IP + ":1935/newsuwon/_definst_/mp4:"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename();
				media_url="http://"+DirectoryNameManager.SV_LIVE_SERVER_IP+"/ClientBin/Media/"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename();
			 }else if(protocal.equals("iPhone")){ 
				media_url="http://"+DirectoryNameManager.SV_LIVE_SERVER_IP + ":1935/newsuwon/_definst_/mp4:"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename()+"/playlist.m3u8";
			} 
			
			 //out.println(media_url);
			 
			category = omiBean.getCcode();
		 
			
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
 
	if (category != null && category.length() > 0) {		 
		menu_title= CategoryManager.getInstance().getCategoryOneName_like(category, "V");
	}
	

%>
	<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />
	<meta name="Author" content="tv.suwon.go.kr">
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
 
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
  <script type="text/javascript" src="//developers.band.us/js/share/band-button.js?v=07092016"></script>

 
  <script>
  window.fbAsyncInit = function() {
    FB.init({
      //appId      : '1239082459488508',
      appId      : '655179644496462',
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

function deleteChk(memoid) {

		var url = "./pwd_check.jsp?ocode=<%=ocode%>&flag=M&memoid="+memoid;   
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


 function naverBand(){
		window.open("http://band.us/plugin/share?body=<%=title.replaceAll("&#39;","").replaceAll("'"," ").replaceAll("[\r\n]", " ")%>&route=http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>", "share_band", "width=410, height=540, resizable=no");
	 
		
}


	
</script>
	
		<section>
			<div id="container">
				<div class="snb_head">
					<h2><%=menu_title %></h2>
					<div class="snb_back"><a href="javascript:history.back();"><span class="hide_txt">�ڷ�</span></a></div><!--������������ �̵�-->
<!-- 					<div class="snb_write"><a href=""><span class="hide_txt">�۾���</span></a></div>�۾��Ⱑ �������� ���� -->
				</div>
 
				<div class="vodView">
					<h3><%=title%></h3>
					<div class="data1"><span><%=mk_date %></span>|<span>��� �ð� : <%=playtime %></span>|<span>�÷��̼� : <%=hitcount %></span></div>
					<div class="embed-container">
							<div class="videoWrapper">
								<div>
									<!-- ��������� 90% -->
<!-- 								  <iframe src="https://www.youtube.com/embed/hpazy0BHzxY" frameborder="0" allowfullscreen></iframe> -->
									<!--
									<video poster="../include/images/sample2.jpg" controls>
									<source src="../include/images/test.mp4" type="video/mp4">
									</video>
									-->
						 
									<video width="98%" controls="controls" src="<%=media_url%>"  poster="<%=imgTmp%>" playsinline ></video>
<%-- 									<a href="<%=media_url%>"><span class="playBig"></span><img src="<%=imgTmp%>" alt="<%=title%>" width="100%"/></a> --%>
								</div>
							</div>
						</div>
					<div class="data2">
						<span class="subj clearfix"><%=chb.getContent_2(description,"true")%></span>
						<div class="like_boom">
							<a href="javascript:point_go('<%=ocode%>');"><strong id="recomcount"><%=recomcount %></strong></a>
						</div>
					</div>
					<!--//data-->
					
					<% if (news != null && news.size() > 0) { %>
					<div class="news_relate">
						<h5>���ñ��</h5>
						<ul>
						<%
							 for ( int i = 0; i < news.size() ; i++) {
						 	com.yundara.beans.BeanUtils.fill(newsInfoBean, (Hashtable)news.get(i));
						 	%>
							<li><a href="<%=newsInfoBean.getLink()%>" target="_blank" title="��â���� ����">[<%=newsInfoBean.getWdate() %>] <%=newsInfoBean.getTitle()%></a></li>
							<%}%> 
						</ul>
					</div>
							<%} %>
					
					<span class="sns">
						<h4>�۰���</h4>
						<a href="javascript:copy_select();"><img src="../include/images/sns_url.gif" alt="url"/></a>
						<a href="javascript:postToFeed();"><img src="../include/images/sns_facebook.gif" alt="facebook"/></a>
						<a href="javascript:twitter_share();"><img src="../include/images/sns_twitter.gif" alt="twitter"/></a>
						<a href="javascript:sendLink();"><img src="../include/images/sns_cacaotalk.gif" alt="cacao talk"/></a>
						<a href="javascript:shareStory();"><img src="../include/images/sns_cacaostory.gif" alt="cacao story"/></a> 
						<a href="javascript:naverBand();"><img src="../include/images/sns_band.gif" alt="naver band"/></a>
					</span>
					 
					<div id="comment_inner">
					 <!-- comment::��� -->
					<div class="comment" id="comment_link">
					</div>
					<!-- //comment::��� -->
					</div>
				</div>
			</div>
<!-- 			<div class="mNotice"> -->
<!-- 				<h3>����</h3> -->
<!-- 				<a href="">2017�� 2�� ������ ��� �ȳ��Դϴپȳ��Դϴپȳ��Դϴپȳ��Դϴ�.</a> -->
<!-- 			</div>//��������:mNotice -->
		</section><!--//�������κ�:section-->  
		  
<script type='text/javascript'>
  //<![CDATA[
    // // ����� ���� JavaScript Ű�� ������ �ּ���.
    //Kakao.init('0bd092c4a3aadf17452f919aee1a6fa7');  //localhost
    Kakao.init('1b803593c306e6c6fcab67e42846b304');  //tv.suwon.go.kr
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

    // ����� ���� JavaScript Ű�� ������ �ּ���.
   function shareStory() {
      Kakao.Story.open({
    	  url: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>',
          text: '<%=title.replaceAll("&#39;","").replaceAll("'"," ").replaceAll("[\r\n]", " ")%>'
      });
    }
    
// // īī����ũ ��ư�� �����մϴ�. ó�� �ѹ��� ȣ���ϸ� �˴ϴ�.
    function sendLink() {
	 
      Kakao.Link.sendDefault({
        objectType: 'feed',
        content: {
          title: '<%=title.replaceAll("&#39;","").replaceAll("'"," ").replaceAll("[\r\n]", " ")%>',
          description: '<%=simple.replaceAll("&#39;","").replaceAll("'"," ").replaceAll("[\r\n]", " ")%>',
          imageUrl: '<%=imgTmp %>',
          link: {
            mobileWebUrl: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>',
            webUrl: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>'
          }
        },
        
        buttons: [
          {
            title: '������ ����',
            link: {
            	mobileWebUrl: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>',
                webUrl: 'http://tv.suwon.go.kr/index_link.jsp?ocode=<%=ocode%>'
            }
          } 
        ]
      });
    }
    
 
    
  //]]>
  

	 
</script>
		
<%@ include file = "../include/foot.jsp"%>