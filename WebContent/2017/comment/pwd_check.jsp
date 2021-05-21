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
 
String jaction = "";
if (request.getParameter("jaction") != null && request.getParameter("jaction").length() > 0 ) jaction = request.getParameter("jaction").replaceAll("<","").replaceAll(">","");
String muid = null;
if (request.getParameter("muid") != null && request.getParameter("muid").length() > 0) muid = 	request.getParameter("muid").replaceAll("<","").replaceAll(">","");
String ocode =null;
if (request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0) ocode =	request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
String flag =null;
 if (request.getParameter("flag") != null  && request.getParameter("flag").length() > 0) flag =	request.getParameter("flag").replaceAll("<","").replaceAll(">","");
String comment ="";
if (request.getParameter("comment") != null && request.getParameter("comment").length() > 0) comment =request.getParameter("comment").replaceAll("<","").replaceAll(">","");
String wnick_name ="";
if (request.getParameter("wnick_name") != null && request.getParameter("wnick_name").length() > 0) wnick_name =request.getParameter("wnick_name").replaceAll("<","").replaceAll(">","");
String pwd = null;
if (request.getParameter("pwd") != null && request.getParameter("pwd").length() > 0) pwd = request.getParameter("pwd").replaceAll("<","").replaceAll(">","");
String board_id ="";
if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) board_id =  request.getParameter("board_id").replaceAll("<","").replaceAll(">","");
  
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<link href="../include/css/content.css" rel="stylesheet" type="text/css" />
	<link href="../include/css/colorbox.css" rel="stylesheet" type="text/css" />
	
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
<div id="pWrapSmall">
	<div id="pContainerSmall">
		<div id="pContentSmall">
		<form name="memo_form" method="post" action="../comment/comment_list.jsp">
		<input type="hidden" name="ocode" value="<%=ocode%>" />
		<input type="hidden" name="jaction" value="del" />
		<input type="hidden" name="muid" value="<%=muid %>" />
		<input type="hidden" name="flag" value="<%=flag %>" />
		<input type="hidden" name="board_id" value="<%=board_id %>" />
		
			<h3 class="pTitle">비밀번호 확인</h3>
			<div class="pSubject">
			<div class="boardPw">
				<dl>
					<dt><label for="password">비밀번호</label></dt>
					<dd><input type="password" name="pwd" value="" id="password" size="30" title="비밀번호"/></dd>
				</dl>
			</div>
			<div class="btn1">
				<a href="javascript:memo_del();">확인</a>
 			</div>
			</div>
		</form>
		</div>
	</div>
</div>

</body>
</html>