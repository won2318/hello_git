<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>

<%
 
String board_id = request.getParameter("board_id");
String list_id = request.getParameter("list_id");
String type = request.getParameter("type"); 

 

if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 board_id = request.getParameter("board_id").replaceAll("<","").replaceAll(">","");
}
if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0) {
	list_id = request.getParameter("list_id").replaceAll("<","").replaceAll(">","");
}
if (request.getParameter("type") != null && request.getParameter("type").length() > 0) {
	type = request.getParameter("type").replaceAll("<","").replaceAll(">","");
}
String param = "board_id="+board_id+"&list_id="+list_id+"&type="+type;
 
%>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G0549";				// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "WO2WPZ6UULCU";		// NICE로부터 부여받은 사이트  
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = "http://tv.suwon.go.kr/include/vname/checkplus_ok2.jsp";      // 성공시 이동될 URL
    String sErrorUrl = "http://tv.suwon.go.kr/include/vname/checkplus_fail.jsp";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 )
    {
        sEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, initial-scale=1.0">
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="/2013/include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/2013/include/js/jquery.min.js"></script>
	<script type="text/javascript" src="/2013/include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" >
 	window.name ="Parent_window";
	
	function fnPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
	 
	 function gpin_check(){
		 
		wWidth = 360;
	    wHight = 120;

	    wX = (window.screen.width - wWidth) / 2;
	    wY = (window.screen.height - wHight) / 2;

	    var w = window.open("/GPIN/Suwon_Request.jsp?<%=param%>", "gPinLoginWin", "directories=no,toolbar=no,left="+wX+",top="+wY+",width="+wWidth+",height="+wHight);

 
} 
 

	</script>
</head>

<body>

<div id="pWrapSmall">
	<!-- container::메인컨텐츠 -->
	<div id="pLogoSmall">
<!-- 		<span class="close"><a href="javascript:$.colorbox.close();"><img src="../include/images/btn_view_close.gif" alt="닫기"/></a></span> -->
	</div>
	<div id="pContainerSmall">
		<div id="pContentSmall">
			<h3 class="pTitle">본인인증</h3>
			<div class="pSubject">
				<span class="nameInfo">지금 선택하신 메뉴의 이용은 본인인증이 필요합니다.<br/>조회하는 개인정보는 안전하게 보호되며 이름 외의 개인 정보는 사용이 되지 않음을 알려드립니다.</span>				
				<br/>
				<ul class="namecheck">
				<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    
	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	    	 해당 파라미터는 추가하실 수 없습니다. -->
		<input type="hidden" name="param_r1" value="<%=type%>">
		<input type="hidden" name="param_r2" value="<%=board_id%>">
		<input type="hidden" name="param_r3" value="<%=list_id%>"> 
	 
				<li>
					<a href="javascript:fnPopup();">
					<strong>본인인증</strong>
					<span>
						NICE평가 정보에서 제공하는 안심본인인증을 사용합니다. 
					</span>
					</a>
				</li>
				</form>
				 
				<li>
					<a href="javascript:gpin_check();">
					<strong>공공아이핀</strong>
					<span>
						공공 아이핀(I-PIN)은 행정자치부에서 주관하는 주민등록번호 대체 수단으로 회원님의 주민등록번호 대신 식별 아이디를 행정자치부로 부터 발급받아 본인확인을 하는 서비스입니다. 
					</span>
					</a>
				</li>
				 
				</ul>
				
			</div>
		</div>
	</div>
	
	
</div>



</body>
</html>