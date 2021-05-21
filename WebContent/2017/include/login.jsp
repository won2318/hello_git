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
String type = request.getParameter("type");
if (request.getParameter("type") != null && request.getParameter("type").length() > 0) {
	type = com.vodcaster.utils.TextUtil.getValue(request.getParameter("type").replaceAll("<","").replaceAll(">","") );
} 
String board_id = request.getParameter("board_id");
if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id"))) {
    board_id = request.getParameter("board_id");
}
String list_id = request.getParameter("list_id");
if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0 && com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id"))) {
   list_id = request.getParameter("list_id");
}

String result_url = "board_id="+board_id+"::list_id="+list_id+"::type="+type;

LoginRsa handler = new LoginRsa( request );
handler.processRequest(request);
 
String publicKeyModulus = (String) request.getAttribute("publicKeyModulus");
String publicKeyExponent = (String) request.getAttribute("publicKeyExponent");
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>���� iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	 
	<link rel="stylesheet" type="text/css" href="../include/css/content.css">
	<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css">
	<script type="text/javascript" charset="utf-8" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" charset="utf-8" src="../include/js/script.js"></script> <!-- �����ǹ�ư -->
	
		        <%-- script �±׿��� �������� �ڹٽ�ũ��Ʈ ������ ������ �����ؾ��Ѵ�! ������ Ʋ����� �ڹٽ�ũ��Ʈ ������ �߻��Ѵ�. --%>
        <script type="text/javascript" src="/include/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="/include/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rng.js"></script>
        <script type="text/javascript" src="/include/js/login.js"></script>
        
	<script type="text/javascript" >
 
	<!--
		
			
		if ( window.addEventListener ) { // W3C DOM ���� ������ 
			window.addEventListener("load", start, false); 
		} else if ( window.attachEvent ) { // W3C DO M ���� ������ ��(ex:MSDOM ���� ������ IE) 
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
				alert("���ڿ��� Ư������(\", \', ����)�� �ֽ��ϴ�.");
				obj.value = "";
			} 
		}
		
		function go(){

			if(document.getElementById("username").value == "" ) {
				alert("��Ȯ�� ȸ�� ������ �Է��Ͻñ� �ٶ��ϴ�.");
				document.getElementById("username").focus();
	            return ;
	        }
			else if(document.getElementById("password").value == "") {
				alert("��Ȯ�� ȸ�� ������ �Է��Ͻñ� �ٶ��ϴ�.");
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

<div id="pWrapSmall">
	<!-- container::���������� -->
	<div id="pLogoSmall">
<!-- 		<span class="close"><a href="javascript:$.colorbox.close();"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a></span> -->
	</div>
	<div id="pContainerSmall">
		<div id="pContentSmall">
			<h3 class="pTitle">LOGIN</h3>
			<div class="pSubject">
				<span class="nameInfo">���� �����Ͻ� �޴��� <strong>�ùθ���ʹ� ����</strong>���� �α����� �ϼž� �̿��� �����մϴ�.</span>				
				<div class="memberLogin">
					<dl>
						<dt><label for="username">ID</label></dt>
						<dd><input type="text" name="username" value="" id="username" size="100" title="ID"/></dd>
					</dl>
					<dl>
						<dt><label for="password" class="subject">Password</label></dt>
						<dd><input type="password" name="password" value="" id="password" size="10" title="Password"/></dd>
					</dl>
					<div class="btn2">
						<a href="javascript:go();" id="loginbtn">LOGIN</a> 
<!-- 						<input type="submit" value="LOGIN" class="img" onclick="go();" id="loginbtn"/> -->
					</div>
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
	</div>
	
	
</div>



</body>
</html>