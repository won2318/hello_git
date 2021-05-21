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
if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id"))) {
    board_id = request.getParameter("board_id");
}
String list_id = request.getParameter("list_id");
if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0 && com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id"))) {
   list_id = request.getParameter("list_id");
} 
String type = com.vodcaster.utils.TextUtil.getValue(request.getParameter("type"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>�������ͳݹ��</title>
	<link rel="stylesheet" type="text/css" href="../include/css/default.css">
	<link rel="stylesheet" type="text/css" href="../include/css/content.css">
	<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css">
	
	<script type="text/javascript" src="/2017/include/js/jquery.min.js"></script>
	<script type="text/javascript" src="/2017/include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="/2017/include/js/script.js"></script>
	<script type="text/javascript" >
 	
	
	
	
	
	function formSubmit(type){ 
 
		if (type != null && type=="delete") {		
				if (confirm("�����Ͻðڽ��ϱ�")) {
					top.location.href="./proc_boardListDelete.jsp?board_id="+<%=board_id%>+"&list_id="+<%=list_id%>+"&list_passwd="+document.getElementById("list_passwd").value;
					//name_check_conform(link);
				 
				}
		} else if (type != null && type=="update") {
			top.location.href="./board_update.jsp?board_id="+<%=board_id%>+"&list_id="+<%=list_id%>+"&list_passwd="+document.getElementById("list_passwd").value;
			//name_check_conform(link);
			 
		} else {
			top.location.href="./board_view.jsp?board_id="+<%=board_id%>+"&list_id="+<%=list_id%>+"&list_passwd="+document.getElementById("list_passwd").value;
			//name_check_conform(link);
		}
	}

	</script>


</head>
<body>

<div id="pWrapSmall">
	<!-- container::���������� -->
	<div id="pLogoSmall">
		<span class="close"><a href="/"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a></span>
	</div>
	<div id="pContainerSmall">
		<div id="pContentSmall">
		 <form method='post' name="pwdForm" action="./board_pwd.jsp">
				 <input type="hidden" name="type" value="<%=type%>"/>
				 <input type="hidden" name="board_id" value="<%=board_id%>"/>
				 <input type="hidden" name="list_id" value="<%=list_id%>"/>
			<h3 class="pTitle">��й�ȣ Ȯ��</h3>
			<div class="pSubject">
				<span class="nameInfo">��й�ȣ�� �Է��ϼž� ������ �����մϴ�.</span>				
				<div class="boardPw">
					<dl>
						<dt><label for="password">��й�ȣ</label></dt>
						<dd><input type="password" name="list_passwd" value="" id="list_passwd" size="30" title="��й�ȣ"/></dd>
					</dl>
				</div>
				<div class="btn1">
					 <a href="javascript:formSubmit('<%=type%>');">Ȯ��</a>
				</div>
			
			</div>
			</form>
		</div>
	</div>
	
	
</div>



</body>
</html>