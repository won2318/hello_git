<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page language="java" import="java.util.*, com.vodcaster.sqlbean.*, java.net.URLEncoder" %>
<%
	response.setDateHeader("Expires", 0); 
	response.setHeader("Pragma", "no-cache"); 

	if(request.getProtocol().equals("HTTP/1.1")) { 
		response.setHeader("Cache-Control", "no-cache"); 
	} 
%>

<script language="JavaScript">
<!--
	function go(form){

		if(form.id.value == "") {
			alert("아이디를  입력하세요.");
			form.id.focus();
            return false;
        }


		if(form.passwd.value == "") {
			alert("암호를 입력하세요.");
			form.passwd.focus();
            return false;
        }

		return true;
	}
	function window::onload(){
	  		document.user.id.focus();
  		}
-->
</script>

<html>
<div id="login_back">
	<div class="login">
		<form name="user" method="post" action="test1.jsp" onSubmit="return go(document.user);">
		<fieldset>
		<legend>로그인</legend>
		<dl>
		<dt><label for="user_id">아이디</label></dt>
		<dd class="uid"><input type="text" name="id" id="user_id" value="" class="input01" tabindex="1" title="아이디"/></dd>
		<dt><label for="user_pw">비밀번호</label></dt>
		<dd class="upw"><input type="password" name="passwd" id="user_pw" value="" class="input01" tabindex="2" title="비밀번호" /></dd>
		</dl>
		<input name="image" type="image" src="/vodman/infold/images/but_login.gif" alt="로그인" tabindex="3" class="submit" />
	</fieldset>
	</form>   
</html>
