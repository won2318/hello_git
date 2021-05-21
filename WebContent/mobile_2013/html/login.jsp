<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page language="java" import="
java.sql.*,
java.util.*,
java.text.*,
java.io.*,
java.net.*,
com.rsa.*,
com.vodcaster.utils.*
"
%>
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
String result_url = "board_id="+board_id+"::list_id="+list_id+"::type="+type;

LoginRsa handler = new LoginRsa( request );
handler.processRequest(request);
 
String publicKeyModulus = (String) request.getAttribute("publicKeyModulus");
String publicKeyExponent = (String) request.getAttribute("publicKeyExponent");
 
%>

<!DOCTYPE html>

<html lang="ko">

<head>

	<meta charset="EUC-KR">

	<meta http-equiv="X-UA-Compatible" content="IE=9">

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />

	<title>수원iTV</title>

	<link rel="stylesheet" type="text/css" href="../include/css/default.css">

	<script type="text/javascript" src="../include/js/script2.js"></script>

	<script type="text/javascript" src="../include/js/jquery.min.js"></script>

	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>

	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>

     <%-- script 태그에서 가져오는 자바스크립트 파일의 순서에 주의해야한다! 순서가 틀릴경우 자바스크립트 오류가 발생한다. --%>
        <script type="text/javascript" src="/include/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="/include/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rng.js"></script>
        <script type="text/javascript" src="/include/js/login.js"></script>
        
        
	<script type="text/javascript" >
 
	<!--
		
			
		if ( window.addEventListener ) { // W3C DOM 지원 브라우저 
			window.addEventListener("load", start, false); 
		} else if ( window.attachEvent ) { // W3C DO M 지원 브라우저 외(ex:MSDOM 지원 브라우저 IE) 
			window.attachEvent("onload", start); 
		} else { 
			window.onload = start; 
		} 


		function start() 
		{ 
			document.getElementById("username").focus();
		} 

		function checkText(obj) {
			if (obj.value.search(/\"|\'|\s/g) > -1) {
				alert("문자열에 특수문자(\", \', 공백)가 있습니다.");
				obj.value = "";
			} 
		}
		
		function go(){

			if(document.getElementById("username").value == "" ) {
				alert("정확한 회원 정보를 입력하시기 바람니다.");
				document.getElementById("username").focus();
	            return ;
	        }
			else if(document.getElementById("password").value == "") {
				alert("정확한 회원 정보를 입력하시기 바람니다.");
				document.getElementById("password").focus();
	            return false;
	        }
			else{
				validateEncryptedForm();
			} 
			
		}
		
	-->
 
	</script> 


</head>

<body>





<div id="container"  > 

	<div class="major"  >

	

	<section>

		<div class="vodView">

		 

			<div class="topTitle"><h3>로그인</h3> <a href="javascript:history.back();" data-rel="back" data-role="button" ><img src="../include/images/icon_close.png" width="23" height="23" alt="이전화면" /></a></div>

			<span class="nameInfo">지금 선택하신 메뉴는 <strong>시민모니터단 전용</strong>으로 로그인을 하셔야 이용이 가능합니다.</span>				

				<div class="memberLogin">

					<dl>

						<dt><label for="username">ID</label></dt>

						<dd><input type="text" name="username" value="" id="username" size="100" title="ID"/></dd>

					</dl>

					<dl>

						<dt><label for="password">Password</label></dt>

						<dd><input type="password" name="password" value="" id="password" size="10" title="Password"/></dd>

					</dl>

					<div class="btn6">

						<!-- <a href="javascript:;" id="loginbtn">LOGIN</a>  -->

						<input type="submit" value="LOGIN" class="img" id="loginbtn" onclick="go();"/>

					</div>
					<input type="hidden" id="rsaPublicKeyModulus" value="<%=publicKeyModulus%>" />
					<input type="hidden" id="rsaPublicKeyExponent" value="<%=publicKeyExponent%>" />
            	 <form id="securedLoginForm" name="securedLoginForm" action="logincheckok.jsp" method="post" style="display: none;">
			            <input type="hidden" name="securedUsername" id="securedUsername" value="" />
			            <input type="hidden" name="securedPassword" id="securedPassword" value="" />
			            <input type="hidden" name="result_url" id="result_url" value="<%=result_url %>" />
			    </form>

				</div>

			

		</div>

	</section> 

	</div>

</div>
 


</body>

</html>