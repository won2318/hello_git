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
			alert("���̵�  �Է��ϼ���.");
			form.id.focus();
            return false;
        }


		if(form.passwd.value == "") {
			alert("��ȣ�� �Է��ϼ���.");
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
		<legend>�α���</legend>
		<dl>
		<dt><label for="user_id">���̵�</label></dt>
		<dd class="uid"><input type="text" name="id" id="user_id" value="" class="input01" tabindex="1" title="���̵�"/></dd>
		<dt><label for="user_pw">��й�ȣ</label></dt>
		<dd class="upw"><input type="password" name="passwd" id="user_pw" value="" class="input01" tabindex="2" title="��й�ȣ" /></dd>
		</dl>
		<input name="image" type="image" src="/vodman/infold/images/but_login.gif" alt="�α���" tabindex="3" class="submit" />
	</fieldset>
	</form>   
</html>
