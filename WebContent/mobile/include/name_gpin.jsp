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
    
    String sSiteCode = "G0549";				// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = "WO2WPZ6UULCU";		// NICE�κ��� �ο����� ����Ʈ  
    
    String sRequestNumber = "REQ0000000001";        	// ��û ��ȣ, �̴� ����/�����Ŀ� ���� ������ �ǵ����ְ� �ǹǷ� 
                                                    	// ��ü���� �����ϰ� �����Ͽ� ���ų�, �Ʒ��� ���� �����Ѵ�.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// ��ŷ���� ������ ���Ͽ� ������ ���ٸ�, ���ǿ� ��û��ȣ�� �ִ´�.
  	
   	String sAuthType = "M";      	// ������ �⺻ ����ȭ��, M: �ڵ���, C: �ſ�ī��, X: ����������
   	
   	String popgubun 	= "N";		//Y : ��ҹ�ư ���� / N : ��ҹ�ư ����
		String customize 	= "";			//������ �⺻ �������� / Mobile : �����������
		
    // CheckPlus(��������) ó�� ��, ��� ����Ÿ�� ���� �ޱ����� ���������� ���� http���� �Է��մϴ�.
    String sReturnUrl = "http://tv.suwon.go.kr/include/vname/checkplus_ok2.jsp";      // ������ �̵��� URL
    String sErrorUrl = "http://tv.suwon.go.kr/include/vname/checkplus_fail.jsp";          // ���н� �̵��� URL

    // �Էµ� plain ����Ÿ�� �����.
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
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }    
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, initial-scale=1.0">
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>���� iTV</title>
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
	<!-- container::���������� -->
	<div id="pLogoSmall">
<!-- 		<span class="close"><a href="javascript:$.colorbox.close();"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a></span> -->
	</div>
	<div id="pContainerSmall">
		<div id="pContentSmall">
			<h3 class="pTitle">��������</h3>
			<div class="pSubject">
				<span class="nameInfo">���� �����Ͻ� �޴��� �̿��� ���������� �ʿ��մϴ�.<br/>��ȸ�ϴ� ���������� �����ϰ� ��ȣ�Ǹ� �̸� ���� ���� ������ ����� ���� ������ �˷��帳�ϴ�.</span>				
				<br/>
				<ul class="namecheck">
				<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusSerivce">						<!-- �ʼ� ����Ÿ��, �����Ͻø� �ȵ˴ϴ�. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- ������ ��ü������ ��ȣȭ �� ����Ÿ�Դϴ�. -->
	    
	    <!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�.
	    	 �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->
		<input type="hidden" name="param_r1" value="<%=type%>">
		<input type="hidden" name="param_r2" value="<%=board_id%>">
		<input type="hidden" name="param_r3" value="<%=list_id%>"> 
	 
				<li>
					<a href="javascript:fnPopup();">
					<strong>��������</strong>
					<span>
						NICE�� �������� �����ϴ� �Ƚɺ��������� ����մϴ�. 
					</span>
					</a>
				</li>
				</form>
				 
				<li>
					<a href="javascript:gpin_check();">
					<strong>����������</strong>
					<span>
						���� ������(I-PIN)�� ������ġ�ο��� �ְ��ϴ� �ֹε�Ϲ�ȣ ��ü �������� ȸ������ �ֹε�Ϲ�ȣ ��� �ĺ� ���̵� ������ġ�η� ���� �߱޹޾� ����Ȯ���� �ϴ� �����Դϴ�. 
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