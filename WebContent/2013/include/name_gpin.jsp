<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>

<%
String board_id = request.getParameter("board_id");
String list_id = request.getParameter("list_id");
String type = request.getParameter("type"); 
if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 board_id = request.getParameter("board_id");
}
if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0) {
	list_id = request.getParameter("list_id");
}
if (request.getParameter("type") != null && request.getParameter("type").length() > 0) {
	type = request.getParameter("type");
}

// out.println("type:"+type);
// out.println("board_id:"+board_id);
// out.println("list_id:"+list_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="/2013/include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/2013/include/js/jquery.min.js"></script>
	<script type="text/javascript" src="/2013/include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" >
	 function name_check(){
		  
		 window.open("/include/login_test.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type=<%=type%>", "name_check", "width=800, height=700, toolbar=no,location=no,status=yes,menubar=no,scrollbars=no,resizable=no" );
	 }
	 
	 function gpin_check(){
		 
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
			<h3 class="pTitle">사용자인증</h3>
			<div class="pSubject">
				<span class="nameInfo">지금 선택하신 메뉴의 이용은 실명인증이 필요합니다.<br/>조회하는 개인정보는 안전하게 보호되며 이름 외의 개인 정보는 사용이 되지 않음을 알려드립니다.</span>				
				<ul class="namecheck">
				<li>
					<a href="javascript:name_check();">
					<strong>실명인증</strong>
					<span>
						한국신용평가정부(주)에서 제공하는 실명확인서비스를 이용해서 인증 받으셔야 합니다. 
					</span>
					</a>
				</li>
				<li>
					<a href="javascript:gpin_check();">
					<strong>공공아이핀</strong>
					<span>
						공공 아이핀(I-PIN)은 행정안전부에서 주관하는 주민등록번호 대체 수단으로 회원님의 주민등록번호 대신 식별 아이디를 행정안전부로 부터 발급받아 본인확인을 하는 서비스입니다. 
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