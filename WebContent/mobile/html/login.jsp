  <%@page import="com.rsa.LoginRsa"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="org.apache.commons.lang.StringUtils" %>
  
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@page import="com.yundara.util.TextUtil"%>
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
<head>
 <script type="text/javascript" src="/include/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="/include/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rng.js"></script>
        <script type="text/javascript" src="/include/js/login.js"></script>
<script type="text/javascript" >
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
</script>
</head>

<%@ include file = "../include/head.jsp"%>
    
		<section>
			<div id="container">
				<div class="snb_head">
					<h2>LOGIN</h2>
					<div class="snb_back"><a href="javascript:history.back();"><span class="hide_txt">�ڷ�</span></a></div><!--������������ �̵�-->
				</div>
<!-- 				<div class="mLive"> -->
<!-- 					<a href=""><span class="onair">ON-AIR</span><span class="live_time">07:50~</span><strong>2017�� 4���� ����������������������������������������������������������������������������������������������������������������</strong></a> -->
<!-- 				</div>//����۾ȳ�(������� �������� ǥ��:mLive -->
				<div class="content_inner">
					<div class="memberLogin">
					<h3 class="inner_title">LOGIN</h3>
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
						<input type="hidden" id="rsaPublicKeyModulus" value="<%=publicKeyModulus%>" />
					<input type="hidden" id="rsaPublicKeyExponent" value="<%=publicKeyExponent%>" />
					 <form id="securedLoginForm" name="securedLoginForm" action="logincheckok.jsp" method="post" style="display: none;">
			            <input type="hidden" name="securedUsername" id="securedUsername" value="" />
			            <input type="hidden" name="securedPassword" id="securedPassword" value="" />
			            <input type="hidden" name="result_url" id="result_url" value="<%=result_url %>" />
			    </form>
			           <%--  <input type="hidden" name="result_url" id="result_url" value="<%=result_url %>" /> --%>
			    </form>
					</div>
				</div>					
			</div>
<!-- 			<div class="mNotice"> -->
<!-- 				<h3>����</h3> -->
<!-- 				<a href="">2017�� 2�� ������ ��� �ȳ��Դϴپȳ��Դϴپȳ��Դϴپȳ��Դϴ�.</a> -->
<!-- 			</div>//��������:mNotice -->
		</section><!--//�������κ�:section-->    
		
<%@ include file = "../include/foot.jsp"%>	 		 