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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
</head>
<body>
<script>
function memo_del() {
	
	if (confirm("메모를 삭제하시겠습니까")) {
 		document.memo_form.submit();
	}
}

</script>
		<div id="pContent">
		<form name="memo_form" method="post" action="../comment/comment_list.jsp">
		<input type="hidden" name="ocode" value="<%=ocode%>" />
		<input type="hidden" name="jaction" value="del" />
		<input type="hidden" name="muid" value="<%=muid %>" />
		<input type="hidden" name="flag" value="<%=flag %>" />
		<input type="hidden" name="board_id" value="<%=board_id %>" />
		
			<h3 class="pTitle">비밀번호 확인</h3>
			<div class="boardPw">
				<dl>
					<dt><label for="password">비밀번호</label></dt>
					<dd><input type="password" name="pwd" value="" id="password" size="30" title="비밀번호"/></dd>
				</dl>
			</div>
			<div class="btn3">
				<a href="javascript:memo_del();"><img src="../include/images/btn_save.gif" alt="저장"></a>
 			</div>
		</form>
		</div>

</body>
</html>