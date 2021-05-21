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
	//회원정보 로그화일에 저장
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
	mgr2.insertHit(rcode,year,month,date,GB);	// 시청 통계 로그
	}
//////////////////////////////////////////////////////////////
	
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
	
	
 <script language="javascript">AC_FL_RunContent = 0;</script>
<script src="../include/js/AC_RunActiveContent.js" language="javascript"></script>
<script language="javascript">
  


</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
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
	<!-- container::메인컨텐츠 -->
	<div id="pLogo">
		<span class="close"><a href="javascript:self.close();"><img src="../include/images/btn_view_close.gif" alt="닫기"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
 	</div>
	<div id="pContainerMiddle">
		<div id="pContentNormal">
			<h3 class="pTitle"><%=String.valueOf(v_onair.elementAt(1))%></h3>
			<span class="pTime">방송 시간 : <%=String.valueOf(v_onair.elementAt(5))%>&nbsp;&nbsp;~&nbsp;&nbsp;<%=String.valueOf(v_onair.elementAt(6))%></span>
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
									'movie', '/2017/live/live_wide',
									'FlashVars', 'userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>',
									'salign', ''
									);  
						 
							}
						</script>
							
							<noscript>
							<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="579px" height="370px" id="live" align="middle">
							<param name="allowScriptAccess" value="sameDomain" />
							<param name="allowFullScreen" value="true" />
							<param name="movie" value="/2013/live/live_wide.swf" />
							<param name="quality" value="high" />
							<param name="bgcolor" value="#000000" />
							 
							<embed src="/2017/live/live_wide.swf" quality="high" bgcolor="#000000" width="579px" height="370px" name="live_wide" align="middle" 
								allowScriptAccess="sameDomain" allowFullScreen="true" type="application/x-shockwave-flash" 
								FlashVars="userName=rtmp://<%=temp_server_name%>/<%=channel%>&userId=<%=stream%>" 
								pluginspage="http://www.macromedia.com/go/getflashplayer" />
 
							</object>		
						</noscript>
				</div> 
			</div>
			
			<!-- comment::댓글 -->
			 
			<!-- //comment::댓글 -->
		</div>

		 
	</div> 
</div>
<%} else {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('진행중인 생방송이 없습니다. 창을 닫습니다.')"); 
	out.println("self.close();");
	out.println("</SCRIPT>");
}  
	 %>


</body>
</html>