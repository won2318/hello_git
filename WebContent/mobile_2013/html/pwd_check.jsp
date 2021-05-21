<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.security.*" %>
<%@ include file = "/include/chkLogin.jsp"%> 
<%
 
String muid = request.getParameter("muid");
String ocode = request.getParameter("ocode");
String flag = request.getParameter("flag");
String board_id = request.getParameter("board_id");
 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />
	<title>����iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript">
function memo_del() {
 
	if (confirm("�޸� �����Ͻðڽ��ϱ�")) {
		if (document.getElementById('password').value=="") {
			alert('��й�ȣ�� �Է��ϼ���!');
		} else {
			document.memo_form.submit();
		}
 		
	}
}

</script>
</head>
<body>

		
<div id="container"> 
	<div class="major">
	
	<section>
		<form name="memo_form" method="post" action="./comment.jsp">
		<input type="hidden" name="ocode" value="<%=ocode%>" />
		<input type="hidden" name="jaction" value="del" />
		<input type="hidden" name="muid" value="<%=muid %>" />
		<input type="hidden" name="flag" value="<%=flag %>" />
		<input type="hidden" name="board_id" value="<%=board_id %>" />
			<div class="boardPw">
			<div class="topTitle"><h3>��й�ȣ Ȯ��</h3> <a href="javascript:self.close()" ><img src="../include/images/icon_close.gif" width="23" height="23" alt="����ȭ��" /></a></div>
			
				<dl>
					<dt><label for="password">��й�ȣ</label></dt>
					<dd><input type="password" name="pwd" value="" id="password" size="30" title="��й�ȣ"/></dd>
				</dl>
			</div>
			<div class="btn1">
				<a href="javascript:memo_del();">�����ϱ�</a>
 			</div>
		</form>
	</section> 
	</div>
</div>

</body>
</html>