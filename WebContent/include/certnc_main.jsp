<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page language="java" import="SafeNC.kisinfo.*"%>
<%

String result_url = "http://tv.suwon.go.kr";

if (request.getParameter("result_url") != null){
	result_url = request.getParameter("result_url");

}

%>
<%
	//**********************************************************************************************	
	//한국신용평가정보 공공기관용 안심실명확인 서비스
	//사이트코드,사이트패스워드,return_url ,요청 seq 값 암호화한다.
	//작성일 : 2006.10.23
    //**********************************************************************************************	
    	
	String pSite_flag 	= "J102";				// 사이트 id 
	String pSite_pwd  	= "26656746";				//  
	String pSeqid	   	= "1234567890";				// 고객사 요청 Sequence
	String pReturn_url	= "https://tv.suwon.go.kr/include/check_name_ok.jsp?result_url="+result_url;		// 결과값을 리턴 받으실 URL(업체에서 결과값을 받으실 URL입니다.)
	String pReserved1	= "test1";					// 기타 Reserved data1
	String pReserved2	= "test2";					// 기타 Reserved data2
	String pReserved3	= "test3";					// 기타 Reserved data3
	String enc_data		= "";
	
	// 데이타를 암호화,복호화 하는 모듈입니다.
	SafeNCCipher safeNC = new SafeNCCipher();
	
	//**********************************************************************************************
	// 데이타를 암호화 합니다. 
	//**********************************************************************************************	
	if( safeNC.request(pSite_flag,pSite_pwd,pSeqid,pReturn_url,pReserved1,pReserved2,pReserved3) == 0 ) {
		enc_data = safeNC.getEncParam();		
	}else {
		enc_data = "";
	}               
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="Content-Style-Type" content="text/css"/>
<title>수원시 인터넷 방송</title>
<meta name="robots" content="noindex, nofollow"/>
<meta name="keywords" content="수원시 인터넷 방송"/>
<meta name="description" content="수원시 인터넷 방송"/>
<script type="text/javascript" src="/2013/include/js/jquery.min.js"></script>
<script type="text/javascript" src="/2013/include/js/tab.js"></script>
<script type="text/javascript" src="/2013/include/js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="/2013/include/js/jquery.colorbox.js"></script>
<script type="text/javascript" src="/2013/include/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/2013/include/js/common.js"></script>  
<style type="text/css">
body{
	margin:0px;
	padding:0px;
	background:#FFFFFF
}
ul{
	margin:0px;
	padding:0px;
	list-style:none;
	float:none;
	position: relative;
}

</style>	

	<script Language="JavaScript">
	   function fnPopup(){
	   	   //한국신용평가정보 안심 실명확인 팝업페이지를 띄웁니다.	 
		   window.open('', 'popup','width=410, height=590');
		   document.form.target = "popup";
		   document.form.action = "https://cert.namecheck.co.kr/certnc_input.asp"
		   document.form.submit();
	   }

function win_close(){
	//opener.window.close();

	window.close();
}


function main_page(url) { 
alert(url);
	opener.top.location.href="http://tv.suwon.go.kr/include/check_name_return.jsp?url="+url;
alert('main_return');
}

	  
	</script> 

</head>		
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
<form method="post" name="form">
 	<div cellpadding="0" cellspacing="0">
	<ul><li><iframe  src="https://cert.namecheck.co.kr/certnc_input.asp?enc_data=<%=enc_data%>" id="iframe_name_check" frameborder="0" scrolling="no" width="410" height="560"></iframe></li></ul>
	</div>
</form>
</body>
</html>	