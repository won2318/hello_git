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
 LiveManager lMgr = LiveManager.getInstance();
 String play_btn = "";
 String live_popup = "";
 Vector v_onair = null;
 String rcode ="";
  try {
  // rcode, rtitle, rcontents, rbcst_time, ralias, 
  // rstart_time, rend_time, rflag, rstatus, rwdate, 
  // rhit, rlevel,rfilename, rid, rimagefile,
  // property_id, openflag,group_id, del_flag, ocode, 
  // otitle, mobile_sream, inoutflag, org_rfilename 
   	      v_onair =  lMgr.getLive();
 
 	  }catch(Exception e) {}
  if(v_onair != null && v_onair.size() > 0) {  
 	 rcode =  String.valueOf(v_onair.elementAt(0));
  }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/close.js"></script>
 
<script language="javascript">
$(document).ready( function(){
	 $.get('/2013/comment/chat_room.jsp', {'ocode' : '<%=rcode%>' }, function(data){
		  
		 $("#chatList").html(data);
		 $("#chatList").animate({ scrollTop: $("#chatList")[0].scrollHeight}, 1000);
 
    });
		return false;
	}
	);
 
 
$(function(){
	$('#comment_form').validate({
	    rules: {
	    	wnick_name: { required: true},
	        pwd: { required: true},
	     
	        comment: { required: true },
	        },
	      messages: {
	    	  wnick_name: { required: "<strong>닉네입을 입력하세요.</strong>" },
	          pwd: { required: "<strong>비밀번호를 입력하세요.</strong>" },
	       
	          comment: { required: "<strong>내용을 입력하세요.</strong>"},
	        },
	});
	 
});

function comment_action(){

     var bodyContent = $.ajax({
		    url: "/2013/comment/chat_room.jsp",  //<- 이동할 주소 
		    global: false, //<- 
		    type: "POST",  //<-  보낼때 타입 
		    data: $("#comment_form").serialize(),  //<-  보낼 파라메타 
		    dataType: "html",  //<-  받을때타입 
		    async:false,
		    success: function(data){  //<-  성공일때 
 
		    	 if (data != "") {
	                 $("li#chatList").detach();
	                 $("#chatList").html(data); 
	                 $("#chatList").animate({ scrollTop: $("#chatList")[0].scrollHeight}, 100);
	                 document.getElementById('comment').value="";
	                 //$.colorbox.resize(); 
	             } 
		    }
		 }
     
		);
	 
}
 
 
function deleteChk(muid) {
		var url = "../comment/pwd_check.jsp?ocode=<%=rcode%>&flag=L&muid="+muid;   
		 
		jQuery.colorbox({href:url, open:true});
}
 
var auto_refresh = setInterval(
function ()
{
 
$('#chatList').load(
		 $.get('/2013/comment/chat_room.jsp', {'ocode' : '<%=rcode%>' }, function(data){
			  
			 $("#chatList").html(data);
			 $("#chatList").animate({ scrollTop: $("#chatList")[0].scrollHeight}, 1000);
	 
	    })
).fadeIn("slow");
}, 3000); // 새로고침 시간 1000은 1초를 의미합니다.
 
</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
</noscript>
</head>
<body>
<%
if(v_onair != null && v_onair.size() > 0) {

%>
<div id="pWrap">
	<!-- container::메인컨텐츠 -->
	<div id="pLogo">
		<h2><a href="/"><img src="../include/images/view_logo.gif" alt="수원 iTV 홈페이지 바로가기"/></a></h2>
		<span class="close"><a href="javascript:this_close();"><img src="../include/images/btn_view_close.gif" alt="닫기"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
	
 	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle"><%=String.valueOf(v_onair.elementAt(1))%></h3>
			<span class="pTime">방송 시간 : <%=String.valueOf(v_onair.elementAt(5))%>&nbsp;&nbsp;~&nbsp;&nbsp;<%=String.valueOf(v_onair.elementAt(5))%></span>
			<div class="pSubject"><%=chb.getContent(String.valueOf(v_onair.elementAt(2)), "false")%></div>
			<div class="pPlayer">
				<div id="SilverlightControlHost" class="silverlightHost" >
					<iframe title="실버라이트 동영상 재생 창" id="bestVod" name="bestVod" src="http://tv.daejeon.go.kr/silverPlayer_main.jsp?isplay=false&width=579&height=362&ocode=" scrolling="no" width="579" height="362" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
				</div> 
			</div>
			
			<!-- comment::댓글 -->
			<div class="chatting"> 
				<div id="chattingFrame">
					<h4 class="cTitle">댓글</h4>
					<div class="chatList" id="chatList">
						
					</div>
					<div class="chatInput">
					<form id="comment_form" name="comment_form" method="post" action="javascript:comment_action()" >
						<input type="hidden" name="ocode" value="<%=rcode%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
				 
						<ul>
							<li><label for="wnick_name">닉네임</label></li>
							<li><input type="text" name="wnick_name" value="" id="wnick_name" title="닉네임"/></li>
							<li class="pl20"><label for="pwd">비밀번호</label></li>
							<li><input type="password" name="pwd" value=""  id="pwd" title="비밀번호"/></li>
							<li><input type="image" src="../include/images/btn_chat_nick_pw_ok.gif" alt="확인" class="img"/></li>
						</ul>
						<div class="input_wrap">
							<textarea id="comment" name="comment" wrap="hard" ></textarea>
							<input type="image" src="../include/images/btn_chat_ok.gif" alt="입력" class="img"/>
						</div>
					</form>
					</div> 
					
				</div>
			
			</div>
			<!-- //comment::댓글 -->
		</div>

		<div class="pAside">
			<div class="pInfo">
				<span class="pHit">플레이수 <%=String.valueOf(v_onair.elementAt(6))%><span> </span></span>
			</div>
			 
			<%@ include file = "../include/sub_topic.jsp"%>
			
		</div> 
	</div> 
</div>
<%} else {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('진행중인 생방송이 없습니다. 창을 닫습니다.')"); 
	out.println("parent.$.colorbox.close();");
	out.println("</SCRIPT>");
}  
	 %>


</body>
</html>