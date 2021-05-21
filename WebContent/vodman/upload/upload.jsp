<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="euc-kr" %>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file="/vodman/include/chkLogin.jsp" %>

<%
  
String ccode = StringUtils.defaultString(request.getParameter("ccode"));
String ocode = StringUtils.defaultString(request.getParameter("ocode"));

if(ccode == null ){
	out.println("<script lanauage='javascript'>alert('카테고리 코드가 없습니다. 다시 선택해주세요.'); self.close(); </script>");
}
if(ocode == null ){
	out.println("<script lanauage='javascript'>alert('필수 코드가 없습니다. 다시 선택해주세요.'); self.close(); </script>");
}

%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>File Upload</title>
<script src="./js/jquery-1.11.0.min.js"></script>

<script src="./js/vendor/jquery.ui.widget.js"></script>
<script src="./js/jquery.iframe-transport.js"></script>
<script src="./js/jquery.fileupload.js"></script>

<!-- bootstrap just to have good looking page -->
<script src="./bootstrap/js/bootstrap.min.js"></script>
 
 
<!-- we code these -->

<link href="css/dropzone.css" type="text/css" rel="stylesheet" />
<script src="./js/fileupload.js"></script>

 <style type="text/css">

	 *, *:before, *:after {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;}
body {background:none; font-size: 12px; padding:0; margin:0;}
	 li {list-style:none;}
	 input {font-size: 12px;}
 /* Progress Bar */
 .pro_bar {margin:0 auto; width: 100%;border-top: 1px dotted #d4d4d4; margin-top: 10px;}
	.progress { margin:0 auto; width: 90%; background:#fafafa;box-shadow:inset 1px 1px 4px #eaeaea; border-radius: 1.5625em; height: 1.5625em;  border: 1px solid #e8e8e8; margin-bottom: 0.625em; margin-top:0.625em;}
	.progress .meter { font-weight: bold; background: #ff7805;padding-bottom:1px; color:#ffffff;font-family: tohoma; border-radius: 1.5625em;padding-top: 0.3em; height: 1.2625em;display: block; 
	background: gradient(linear, 0% 0%, 50% 100%, from(#ffac54), to(#ff7805));
	background: -o-gradient(linear, 0% 0%, 50% 100%, from(#ffac54), to(#ff7805));
	background: -ms-gradient(linear, 0% 0%, 50% 100%, from(#ffac54), to(#ff7805));
	background: -moz-gradient(linear, 0% 0%, 50% 100%, from(#ffac54), to(#ff7805));
	background: -webkit-gradient(linear, 0% 0%, 50% 100%, from(#ffac54), to(#ff7805));	}  
  .progress.secondary .meter {
    background: #e9e9e9;
    height: 100%;
    display: block; }
  .progress.success .meter {
    background: #5da423;
    height: 100%;
    display: block; }
  .progress.alert .meter {
    background: #c60f13;
    height: 100%;
    display: block; }
  .progress.radius {
    -webkit-border-radius: 3px;
    border-radius: 3px; }
    .progress.radius .meter {
      -webkit-border-radius: 2px;
      border-radius: 2px; }
  .progress.round {
    -webkit-border-radius: 1000px;
    border-radius: 1000px; }
    .progress.round .meter {
      -webkit-border-radius: 999px;
      border-radius: 999px; }
   input,label {vertical-align: middle!important;}
   label {color: #7b7b7b;}
   .upload_inner {background:#ffffff; width: 100%; border-radius:5px; border:1px solid #e9e9e9; font-family: Dotum;box-shadow:0px 2px 1px #efefef}
	.upload_top { background:#298bdf; padding: 8px;  border-top-left-radius:5px; border-top-right-radius:4px;text-align:center; color:#ffffff; font-size: 14px; font-weight: bold;}
	.upload_con { width: 100%; margin: 0 auto;text-align: center;padding: 10px; padding-bottom: 5px;}
	.upload_con input { border:1px solid #dcdcdc;  }
	.upload_con label{ border:1px solid #e9e9e9; font-size: 11px; padding: 4px 5px 1px 5px; background:#f3f3f3;}
	.upload_foo { background:#f3f3f3; padding: 8px;text-align: center; font-size:11px; }
	.upload_foo strong { color:#298bdf; }
	@media screen and (-webkit-min-device-pixel-ratio:0) {
	   .progress .meter {padding-top: 0px; height: 1.5625em;}
	   .upload_con label { padding: 6px;}
	}
	 </style>
</head>

<body> 

		 <div style="display:none;">
			 <ul> 
			 <li>
			 <input type="hidden" id="ocode" name="ocode" value="<%=ocode%>" />
			 <input type="hidden" id="ccode" name="ccode" value="<%=ccode%>" /> 
			 <input type="hidden" id="img_title" name="img_title" style="width: 70%" class="input01" invalue="" />
			 </li>
			 </ul>
		 </div>
		 <div class="upload_inner">
		 <div class="upload_top">동영상 파일 업로드</div>
		<div class="upload_con">
<!-- 		<label for="fileupload">동영상 파일 업로드</label>&nbsp;&nbsp;&nbsp;<input id="fileupload" type="file" name="files[]" class="input01" data-url="/html/master" multiple> -->
			 <label for="fileupload">동영상 파일 선택</label>&nbsp;<input id="fileupload" type="file" name="files" class="input01" data-url="/html/master" >
		
			<div class="pro_bar"><div class="progress"><div class="meter" style="width: 0%;"></div></div></div>
		</div>	 
		<div class="upload_foo">* <strong>mp4, wmv, avi</strong> 파일만 가능합니다. (<strong>1G Byte</strong> 이하)</div>
		
		</div>
	
</body> 
</html>
