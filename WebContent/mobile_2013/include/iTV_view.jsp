<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.util.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@page import="com.yundara.util.TextUtil"%>
<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@page import="com.hrlee.sqlbean.MenuManager2"%>
<%@page import="com.vodcaster.sqlbean.DirectoryNameManager"%>

<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<%@ include file="/include/chkLogin.jsp"%>

<%
	request.setCharacterEncoding("EUC-KR");
 
int pg = NumberUtils.toInt(request.getParameter("page"), 1);
 	
	String hValue = request.getHeader("user-agent");
	String protocal = "http://";
	if(hValue.indexOf("Android") != -1)
		//protocal = "rtsp://";
		protocal = "Android";
	else if(hValue.indexOf("iPhone") != -1)
		//protocal = "http://";
		protocal = "iPhone";
		
	String category = TextUtil.nvl(request.getParameter("category"));
	 
	String ocode ="";
	if (request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0  && !request.getParameter("ocode").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("ocode"))) {
		ocode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ocode"));
	}
	
 
	String strLink = "?page="+pg + "&category="+category;
	
	String title = "";
	String playtime = "";
	String description = "";
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
			
			imgTmp = SilverLightPath + "/"+omiBean.getSubfolder()+"/thumbnail/_small/"+omiBean.getModelimage();
			
			if(modelimage== null || modelimage.length() <=0 || modelimage.equals("null")) {
				imgTmp = imgurl;
			}
			
	
			hitcount = omiBean.getHitcount();
			recomcount = omiBean.getRecomcount();
			subfolder = omiBean.getSubfolder();
			//download_flag = TextUtil.nvl(String.valueOf(vt_result.elementAt(8)));
			mk_date = omiBean.getMk_date();
			if(deptcd == null) deptcd = "";
			if(gradecode == null) gradecode = "";
			com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, ocode, request.getRemoteAddr(),"H");
					media_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME + DirectoryNameManager.SILVERMEDIA + "/" + subfolder + "/Mobile/" + omiBean.getMobilefilename();
			
			if(protocal.equals("Android")){
				media_url="rtsp://"+DirectoryNameManager.SV_LIVE_SERVER_IP + ":1935/new-daejeon/_definst_/mp4:"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename();
			 }else if(protocal.equals("iPhone")){ 
				media_url="http://"+DirectoryNameManager.SV_LIVE_SERVER_IP + ":1935/new-daejeon/_definst_/mp4:"+ subfolder +  "/Mobile/" + omiBean.getMobilefilename()+"/playlist.m3u8";
			} 
			
			
			if(modelimage== null || modelimage.length() <=0 || modelimage.equals("null")) {
				imgTmp = imgurl;
			}
			
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
	
	
// 	String GB = "MV";
// 	int year=0, month=0, date=0;
// 	Calendar cal = Calendar.getInstance();
// 	year  = cal.get(Calendar.YEAR);
//     month = cal.get(Calendar.MONTH)+1;
//     date = cal.get(Calendar.DATE);
		
// 	MenuManager2 mgr2 = MenuManager2.getInstance();
// 	mgr2.insertHit(category,year,month,date,GB);
	
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />
	<title>����iTV</title>
	<link rel="stylesheet" type="text/css" href="../include/css/default.css">
	<script type="text/javascript" src="../include/js/script2.js"></script>
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
 
 	
<script language="javascript">
$(document).ready( function(){
	
	 $.get('./comment.jsp', {'ocode' : '<%=ocode%>', 'page' : '1','flag':'M'}, function(data){
		 //alert(data);
		 $("#comment_link").html(data);
 
    });
		return false;
	}
	);
 
 function point_go(){
 
	 $.get("proc_best_point.jsp", { ocode: "<%=ocode%>" },  function(data) {
	 
		 $("#recomcount").html(data); 
		alert('��õ �Ǿ����ϴ�!');
		 },   "text" ); 
 
 }
	
$(function(){
	$('#comment_form').validate({
	    rules: {
	    	wnick_name: { required: true},
	        pwd: { required: true},
// 	        chk_word: { required: true}, 
	        comment: { required: true },
	        },
	      messages: {
	    	  wnick_name: { required: "<strong>�г����� �Է��ϼ���.</strong>" },
	          pwd: { required: "<strong>��й�ȣ�� �Է��ϼ���.</strong>" },
// 	          chk_word: { required: "<strong>Ȯ�ι��ڸ� �Է��ϼ���.</strong>" },
	          comment: { required: "<strong>������ �Է��ϼ���.</strong>"},
	        },
	});
	 
});

function comment_action(){

     var bodyContent = $.ajax({
		    url: "./comment.jsp?ocode=<%=ocode%>&flag=M",  //<- �̵��� �ּ� 
		    global: false, //<- 
		    type: "POST",  //<-  ������ Ÿ�� 
		    data: $("#comment_form").serialize(),  //<-  ���� �Ķ��Ÿ 
		    dataType: "html",  //<-  ������Ÿ�� 
		    async:false,
		    success: function(data){  //<-  �����϶� 
 
		    	 if (data != "") {
	                 $("dl#comment_link").detach();  //���� �伭 ������ ����
	                 $("#comment_link").html(data); 
	                 document.getElementById('chk_word').value="";
	                 document.getElementById('comment').value="";
	                 //$.colorbox.resize(); 
	             } 
		    }
		 }
     
		);
	 
}
 
function page_go(val){  
	$.get('./comment.jsp', {'ocode' : '<%=ocode%>', 'page' : val, 'flag':'M'}, function(data){
		 
		 if (data != "") {
		 $("div#comment_link").detach();
		 $("#comment_link").html(data);
		 }
		
   }); 
}

function deleteChk(muid) {
		var url = "../comment/pwd_check.jsp?ocode=<%=ocode%>&flag=M";   
		 
		jQuery.colorbox({href:url, open:true});
} 
 
 
</script>

</head>
<body>

<div id="container"  > 
	<div class="major"  >
		<section>
			<div class="vodView" >
				<div class="topTitle"><h3><%=title%></h3> </div>
				<ul>
					<li><span class="time"><%=mk_date %> / ��۽ð� : <%=playtime %></span></li>
					<li><a href=""<%=media_url%>"><span class="playBig"></span><img src="<%=imgTmp%>" alt="<%=title%>" width="100%"/></a></li>
					<li><%=chb.getContent_2(String.valueOf(description),"true") %></li>
					<li><span class="pRecomIcon"><a href="/"><img src="../include/images/btn_like.gif" alt="���ƿ� Like!" width="61" height="62"/></a></span></li>
				</ul>
				<ul class="info">
					<li>
						<span class="playhit">�÷��� ��:<strong><%=hitcount %></strong></span>
						<span class="recom">��õ��:<strong id="recomcount"><%=recomcount %></strong></span>
					</li>
					<li>
						<span class="link">�����ϱ�
						<strong>
							<a href="/"><img src="../include/images/icon_view_link.gif" alt="��ũ" width="29" height="29"/></a>  
							<a href="/"><img src="../include/images/icon_view_twitter.gif" alt="Ʈ����" width="29" height="29"/></a> 
							<a href="/"><img src="../include/images/icon_view_facebook.gif" alt="���̽���" width="29" height="29"/></a>
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



</body>
</html>