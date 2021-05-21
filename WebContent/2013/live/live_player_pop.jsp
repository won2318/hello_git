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
 <%@ include file = "/include/chkLogin.jsp"%>
 <%
 
 LiveManager lMgr = LiveManager.getInstance();
 String play_btn = "";
 String live_popup = "";
 Vector v_onair = null;
 
	String channel = "";
	String stream = "";
	String live_title ="";
	String live_rcontents ="";
	
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
 	 
 	live_title = String.valueOf(v_onair.elementAt(1)); 
	live_rcontents  = String.valueOf(v_onair.elementAt(2)); 
	String[] data= null;
	 
	data=String.valueOf(v_onair.elementAt(4)).split("/");

	if(data.length > 2){
		channel = data[1];
		stream = data[2];
	}
 
//////////////////////////////////////////////////////////////
	//ȸ������ �α�ȭ�Ͽ� ����
	if (rcode != "" && rcode.length() > 0) {
	if(deptcd == null) deptcd = "";
	if(gradecode == null) gradecode = "";
	com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, rcode, request.getRemoteAddr(),"R" );
	
	String GB = "WL";
	int year=0, month=0, date=0;
	Calendar cal = Calendar.getInstance();
	year  = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH)+1;
    date = cal.get(Calendar.DATE);
	
	MenuManager2 mgr2 = MenuManager2.getInstance();
	mgr2.insertHit(rcode,year,month,date,GB);	// ��û ��� �α�
	}
//////////////////////////////////////////////////////////////
	
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
	
 <script language="javascript">AC_FL_RunContent = 0;</script>
<script src="../include/js/AC_RunActiveContent.js" language="javascript"></script>
<script language="javascript">
$(document).ready( function(){
	 $.get('/2013/comment/chat_room.jsp', {'ocode' : '<%=rcode%>' }, function(data){
		  
		 $("#chatList").html(data);
		 $("#chatList").animate({ scrollTop: $("#chatList")[0].scrollHeight}, 1000);
 
    });
		return false;
	}
	);
 
 
// $(function(){
// 	$('#comment_form').validate({
// 	    rules: {
// 	    	wnick_name: { required: true},
// 	        pwd: { required: true},
	     
// 	        comment: { required: true },
// 	        },
// 	      messages: {
// 	    	  wnick_name: { required: "<strong>�г����� �Է��ϼ���.</strong>" },
// 	          pwd: { required: "<strong>��й�ȣ�� �Է��ϼ���.</strong>" },
	       
// 	          comment: { required: "<strong>������ �Է��ϼ���.</strong>"},
// 	        },
// 	});
	 
// });

function comment_action(){

	if(filterIng(document.getElementById('comment').value, "comment") == false){
		return;
	}else {
		if (document.getElementById('wnick_name').value == '') {
			alert("�г����� �Է��ϼ���!");
		} else if (document.getElementById('pwd').value == '') {
			alert("��й�ȣ�� �Է��ϼ���!");
	 
		} else if (document.getElementById('comment').value == '') {
			alert("������ �Է��ϼ���!");
		} else {
			
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
	} 
}
 
 
function deleteChk(muid) {
		var url = "../comment/pwd_check.jsp?ocode=<%=rcode%>&flag=L&muid="+muid;   
		 
		jQuery.colorbox({href:url, open:true});
}
 
var auto_refresh = setInterval(
function ()
{
 
$('#chatList').load(
		 $.post('/2013/comment/chat_room.jsp', {'ocode' : '<%=rcode%>','wnick_name':document.getElementById('wnick_name').value }, function(data){
			  
			 $("#chatList").html(data);
			 $("#chatList").animate({ scrollTop: $("#chatList")[0].scrollHeight}, 1000);
	 
	    })
).fadeIn("slow");
}, 3000); // ���ΰ�ħ �ð� 1000�� 1�ʸ� �ǹ��մϴ�.
 

<%
FucksInfoManager mgr = FucksInfoManager.getInstance();
Hashtable result_ht = null;
result_ht = mgr.getAllFucks_admin("");
Vector vt = null;
com.yundara.util.PageBean pageBean = null;
int totalArticle =0; //�� ���ڵ� ����
int totalPage = 0 ; //
if(!result_ht.isEmpty() ) {
    vt = (Vector)result_ht.get("LIST");

	if ( vt != null && vt.size() > 0){
        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
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
var splitFilter = new Array("����","����","�ֳ�","�ֳ�","����","����","������","�Ϲ̷�","��������","��������","�ϱ��","����","����","�ʻ���","script");
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
//	alert(str);
	for (var ii = 0 ;ii < splitFilter.length ; ii++ )
	{

		rgExp = splitFilter[ii];
		if (str.match(rgExp))
		{
			alert(rgExp + "��(��) �ҷ��ܾ�� �Է��ϽǼ� �����ϴ�");
			var range = document.getElementsByName(id)[0].createTextRange();
			range.findText(rgExp);
			range.select();
			return false;
		}
	}
}



</script>
<noscript>
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 
</noscript>
</head>
<body>
<%
if(v_onair != null && v_onair.size() > 0) {
	String temp_server_name = DirectoryNameManager.SV_LIVE_SERVER_IP;
	 if (stream.startsWith("suwon01r") ) {
		 temp_server_name = "livetv.suwon.go.kr"; 
	 }
%>

<div id="pWrapNormal">
	<!-- container::���������� -->
	<div id="pLogo">
		<span class="close"><a href="javascript:self.close();"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
 	</div>
	<div id="pContainerMiddle">
		<div id="pContentNormal">
			<h3 class="pTitle"><%=String.valueOf(v_onair.elementAt(1))%></h3>
			<span class="pTime">��� �ð� : <%=String.valueOf(v_onair.elementAt(5))%>&nbsp;&nbsp;~&nbsp;&nbsp;<%=String.valueOf(v_onair.elementAt(6))%></span>
			<div class="pSubject"><%=chb.getContent(String.valueOf(v_onair.elementAt(2)), "false")%></div>
			<div class="pPlayer">
				<div id="SilverlightControlHost" class="silverlightHost" >
					 <script language="javascript">
							if (AC_FL_RunContent == 0) {
								alert("This page requires AC_RunActiveContent.js.");
							} else {
						 
								AC_FL_RunContent(
									'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
									'width', '579',
									'height', '370',
									'src', 'live_wide',
									'quality', 'high',
									'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
									'align', 'middle',
									'play', 'true',
									'loop', 'true',
									'scale', 'showall',
									'wmode', 'opaque',
									'devicefont', 'false',
									'id', 'live',
									'bgcolor', '#FFFFFF',
									'name', 'live_wide',
									'menu', 'true',
									'allowFullScreen', 'true',
									'allowScriptAccess','sameDomain',
									'movie', '/2013/live/live_wide',
									'FlashVars', 'userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>',
									'salign', ''
									); //end AC code
						 
							}
						</script>
							
							<noscript>
							<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="579px" height="370px" id="live" align="middle">
							<param name="allowScriptAccess" value="sameDomain" />
							<param name="allowFullScreen" value="true" />
							<param name="movie" value="/2013/live/live_wide.swf" />
							<param name="quality" value="high" />
							<param name="bgcolor" value="#000000" />
							 
							<embed src="/2013/live/live_wide.swf" quality="high" bgcolor="#000000" width="579px" height="370px" name="live_wide" align="middle" 
								allowScriptAccess="sameDomain" allowFullScreen="true" type="application/x-shockwave-flash" 
								FlashVars="userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>" 
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
 
							</object>		
						</noscript>
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
<!-- 							<li><input type="image" src="../include/images/btn_chat_nick_pw_ok.gif" alt="Ȯ��" class="img"/></li> -->
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

		 
	</div> 
</div>
<%} else {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('�������� ������� �����ϴ�. â�� �ݽ��ϴ�.')"); 
	out.println("self.close();");
	out.println("</SCRIPT>");
}  
	 %>


</body>
</html>