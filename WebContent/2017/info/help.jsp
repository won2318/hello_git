<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.hrlee.sqlbean.MediaManager"%>
<%@ page import="com.security.*" %>

<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
 <%@ include file = "/include/chkLogin.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>���� iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/close.js"></script>

</head>
<body>

<div id="pWrap">
	<!-- container::���������� -->
	<div id="pLogo">
		<h2><a href="/"><img src="../include/images/view_logo.gif" alt="���� iTV Ȩ������ �ٷΰ���"/></a></h2>
		<span class="close"><a href="javascript:this_close();"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
 	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle">SilverLight ��ġ�ȳ�</h3>
			<div class="pSubject">
				<div class="help">
					<p><img src="../include/images/help1.gif" alt="���� Ŭ���ϸ� ��ġ��ư�� �����մϴ�."/><br/>'���� Ŭ���ϸ� ��ġ' ��ư�� �����մϴ�.</p>
					<p><img src="../include/images/help2.gif" alt="Silverlight.exe�� �����ϰų� �����մϴ�."/><br/>Silverlight.exe�� �����ϰų� �����մϴ�.</p>
					<p><img src="../include/images/help3.gif" alt="Silverlright ��ġâ�� �߸� ���� ��ġ�� ���� �����մϴ�."/><br/>Silverlright ��ġâ�� �߸� ���� ��ġ�� ���� �����մϴ�.</p>
					<p><img src="../include/images/help4.gif" alt="��ġ�� �Ϸ�˴ϴ�."/><br/>��ġ�� �Ϸ�˴ϴ�.</p>
					<p><img src="../include/images/help5.gif" alt="��ġ�� �Ϸ�� �� ������ �÷����Ͻ� �� �ֽ��ϴ�."/><br/>��ġ�� �Ϸ�� �� ������ �÷����Ͻ� �� �ֽ��ϴ�.</p>
				</div>
			</div>
		
		</div>

		<div class="pAside">
  
			<%@ include file = "../include/sub_topic.jsp"%>
			
		</div>
		
	</div>
	
	
</div>



</body>
</html>