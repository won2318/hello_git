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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/close.js"></script>

</head>
<body>

<div id="pWrap">
	<!-- container::메인컨텐츠 -->
	<div id="pLogo">
		<h2><a href="/"><img src="../include/images/view_logo.gif" alt="수원 iTV 홈페이지 바로가기"/></a></h2>
		<span class="close"><a href="javascript:this_close();"><img src="../include/images/btn_view_close.gif" alt="닫기"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
 	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle">SilverLight 설치안내</h3>
			<div class="pSubject">
				<div class="help">
					<p><img src="../include/images/help1.gif" alt="지금 클릭하면 설치버튼을 선택합니다."/><br/>'지금 클릭하면 설치' 버튼을 선택합니다.</p>
					<p><img src="../include/images/help2.gif" alt="Silverlight.exe를 실행하거나 저장합니다."/><br/>Silverlight.exe를 실행하거나 저장합니다.</p>
					<p><img src="../include/images/help3.gif" alt="Silverlright 설치창이 뜨면 지금 설치를 눌러 실행합니다."/><br/>Silverlright 설치창이 뜨면 지금 설치를 눌러 실행합니다.</p>
					<p><img src="../include/images/help4.gif" alt="설치가 완료됩니다."/><br/>설치가 완료됩니다.</p>
					<p><img src="../include/images/help5.gif" alt="설치가 완료된 후 영상을 플레이하실 수 있습니다."/><br/>설치가 완료된 후 영상을 플레이하실 수 있습니다.</p>
				</div>
			</div>
		
		</div>

		<div class="pAside">
  
			<%@ include file = "../include/sub_topic.jsp"%>
			
		</div>
		
	</div>
	
	
</div>



</body>
</html>