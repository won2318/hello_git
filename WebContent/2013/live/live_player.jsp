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
 contact.setPage_cnn_cnt("W"); // ������ ���� ī��Ʈ ����
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
	<title>���� iTV</title>
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
	    	  wnick_name: { required: "<strong>�г����� �Է��ϼ���.</strong>" },
	          pwd: { required: "<strong>��й�ȣ�� �Է��ϼ���.</strong>" },
	       
	          comment: { required: "<strong>������ �Է��ϼ���.</strong>"},
	        },
	});
	 
});

function comment_action(){

     var bodyContent = $.ajax({
		    url: "/2013/comment/chat_room.jsp",  //<- �̵��� �ּ� 
		    global: false, //<- 
		    type: "POST",  //<-  ������ Ÿ�� 
		    data: $("#comment_form").serialize(),  //<-  ���� �Ķ��Ÿ 
		    dataType: "html",  //<-  ������Ÿ�� 
		    async:false,
		    success: function(data){  //<-  �����϶� 
 
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
}, 3000); // ���ΰ�ħ �ð� 1000�� 1�ʸ� �ǹ��մϴ�.
 
</script>
<noscript>
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 
</noscript>
</head>
<body>
<%
if(v_onair != null && v_onair.size() > 0) {

%>
<div id="pWrap">
	<!-- container::���������� -->
	<div id="pLogo">
		<h2><a href="/"><img src="../include/images/view_logo.gif" alt="���� iTV Ȩ������ �ٷΰ���"/></a></h2>
		<span class="close"><a href="javascript:this_close();"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
	
 	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle"><%=String.valueOf(v_onair.elementAt(1))%></h3>
			<span class="pTime">��� �ð� : <%=String.valueOf(v_onair.elementAt(5))%>&nbsp;&nbsp;~&nbsp;&nbsp;<%=String.valueOf(v_onair.elementAt(5))%></span>
			<div class="pSubject"><%=chb.getContent(String.valueOf(v_onair.elementAt(2)), "false")%></div>
			<div class="pPlayer">
				<div id="SilverlightControlHost" class="silverlightHost" >
					<iframe title="�ǹ�����Ʈ ������ ��� â" id="bestVod" name="bestVod" src="http://tv.daejeon.go.kr/silverPlayer_main.jsp?isplay=false&width=579&height=362&ocode=" scrolling="no" width="579" height="362" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
				</div> 
			</div>
			
			<!-- comment::��� -->
			<div class="chatting"> 
				<div id="chattingFrame">
					<h4 class="cTitle">���</h4>
					<div class="chatList" id="chatList">
						
					</div>
					<div class="chatInput">
					<form id="comment_form" name="comment_form" method="post" action="javascript:comment_action()" >
						<input type="hidden" name="ocode" value="<%=rcode%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
				 
						<ul>
							<li><label for="wnick_name">�г���</label></li>
							<li><input type="text" name="wnick_name" value="" id="wnick_name" title="�г���"/></li>
							<li class="pl20"><label for="pwd">��й�ȣ</label></li>
							<li><input type="password" name="pwd" value=""  id="pwd" title="��й�ȣ"/></li>
							<li><input type="image" src="../include/images/btn_chat_nick_pw_ok.gif" alt="Ȯ��" class="img"/></li>
						</ul>
						<div class="input_wrap">
							<textarea id="comment" name="comment" wrap="hard" ></textarea>
							<input type="image" src="../include/images/btn_chat_ok.gif" alt="�Է�" class="img"/>
						</div>
					</form>
					</div> 
					
				</div>
			
			</div>
			<!-- //comment::��� -->
		</div>

		<div class="pAside">
			<div class="pInfo">
				<span class="pHit">�÷��̼� <%=String.valueOf(v_onair.elementAt(6))%><span> </span></span>
			</div>
			 
			<%@ include file = "../include/sub_topic.jsp"%>
			
		</div> 
	</div> 
</div>
<%} else {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('�������� ������� �����ϴ�. â�� �ݽ��ϴ�.')"); 
	out.println("parent.$.colorbox.close();");
	out.println("</SCRIPT>");
}  
	 %>


</body>
</html>