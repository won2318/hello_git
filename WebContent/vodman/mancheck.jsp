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
<%@ page import="com.login.LoginManager"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%
if (request.getRequestURL() != null && request.getRequestURL().toString().startsWith("http://") ){
%>
<!-- 	<meta http-equiv="REFRESH" content="0; URL=https://tv.suwon.go.kr/vodman/mancheck.jsp" /> -->
<%	
} 
 
			LoginManager handler = new LoginManager( request );
			handler.processRequest(request);
			 
            String publicKeyModulus = (String) request.getAttribute("publicKeyModulus");
            String publicKeyExponent = (String) request.getAttribute("publicKeyExponent");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<title>������������</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />

        <%-- script �±׿��� �������� �ڹٽ�ũ��Ʈ ������ ������ �����ؾ��Ѵ�! ������ Ʋ����� �ڹٽ�ũ��Ʈ ������ �߻��Ѵ�. --%>
        <script type="text/javascript" src="/include/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="/include/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rng.js"></script>
        <script type="text/javascript" src="/include/js/login.js"></script>
 
    </head>
    
<script language="JavaScript">
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
 
<body>
<%

String localIP = request.getRemoteAddr();

// if (localIP.startsWith("211.114.22.71") ||  localIP.startsWith("27.101.101.")||  localIP.startsWith("211.114.22.131") ) {

// } else {
// response.sendRedirect("/");

// }
%>
<div id="login_back">
	<div id="login">
		<table cellspacing="0" class="login">
			<tr>
				<td>
				<table cellspacing="0" class="login1" summary="�α���">
					<caption>�α���</caption>
					<colgroup>
						<col width="185px"/>
						<col width="80px"/>
						<col width="60px"/>
						<col/>
					</colgroup>
					<tbody class="font_117">
					
 						<tr>
							<td></td>
							<th>���̵�</th>
							<td><input type="text" name="username"  id="username"  value="" class="input01" style="width:150px;" tabindex='1' maxlength="14" onkeyup="checkText(this)"/></td>
							<td rowspan="2" class="pa_left"><INPUT name="image" type='image' onclick="go();" src="/vodman/include/images/but_login.gif" alt="�α���" tabindex='3' /></td>
						</tr>
						<tr>
							<td></td>
							<th><strong>��й�ȣ</strong></th>
							<td><input type="password" name="password" id="password" value="" class="input01" style="width:150px;" tabindex='2' maxlength="12" /></td>
						</tr>
						<input type="hidden" id="rsaPublicKeyModulus" value="<%=publicKeyModulus%>" />
            			<input type="hidden" id="rsaPublicKeyExponent" value="<%=publicKeyExponent%>" />
					</tbody>
					 <form id="securedLoginForm" name="securedLoginForm" action="mancheckok.jsp" method="post" style="display: none;">
			            <input type="hidden" name="securedUsername" id="securedUsername" value="" />
			            <input type="hidden" name="securedPassword" id="securedPassword" value="" />
			        </form>
				</table>
				 
				</td>
			</tr>
		</table>
	</div>
</div>

</body>
</html>

