<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>

<%
String board_id = request.getParameter("board_id");
String list_id = request.getParameter("list_id");
String type = request.getParameter("type"); 
if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id"))) {
	 board_id = request.getParameter("board_id");
}
if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0 && com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id"))) {
	list_id = request.getParameter("list_id");
}
if (request.getParameter("type") != null && request.getParameter("type").length() > 0) {
	type = request.getParameter("type");
}
String result_url = "board_id::"+board_id+"list_id::"+list_id+"type::"+type;
// out.println("type:"+type);
// out.println("board_id:"+board_id);
// out.println("list_id:"+list_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="/2013/include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/2013/include/js/jquery.min.js"></script>
	<script type="text/javascript" src="/2013/include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" >
 
	function formSubmit(type){

		
		if (type != null && type=="delete") {
			if (confirm("삭제하시겠습니까")) {
				var link="./proc_boardListDelete.jsp?board_id="+<%=request.getParameter("board_id")%>+"&list_id="+<%=request.getParameter("list_id")%>+"&list_passwd="+document.getElementById("list_passwd").value;
				
				parent.parent.top.name_check_conform(link);
			}
		} else if (type != null && type=="update") {
			var link="./board_update.jsp?board_id="+<%=request.getParameter("board_id")%>+"&list_id="+<%=request.getParameter("list_id")%>+"&list_passwd="+document.getElementById("list_passwd").value;
			parent.parent.top.name_check_conform(link);
			//parent.opener.top.name_check_conform(link);
		} else {
			var link="./board_view.jsp?board_id="+<%=request.getParameter("board_id")%>+"&list_id="+<%=request.getParameter("list_id")%>+"&list_passwd="+document.getElementById("list_passwd").value;
			parent.top.name_check_conform(link);
		}
	}

	</script>
</head>

<body>

<div id="pWrapSmall">
	<!-- container::메인컨텐츠 -->
	<div id="pLogoSmall">
<!-- 		<span class="close"><a href="javascript:$.colorbox.close();"><img src="../include/images/btn_view_close.gif" alt="닫기"/></a></span> -->
	</div>
	<div id="pContainerSmall">
		<div id="pContentSmall">
			<h3 class="pTitle">비밀번호 확인</h3>
			<div class="pSubject">
				 <form method='post' name="pwdForm" action="./board_pwd.jsp">
				 <input type="hidden" name="type" value="<%=request.getParameter("type")%>"/>
				 <input type="hidden" name="board_id" value="<%=request.getParameter("board_id")%>"/>
				 <input type="hidden" name="list_id" value="<%=request.getParameter("list_id")%>"/>
				<div class="boardPw">
					<dl>
						<dt><label for="password">비밀번호</label></dt>
						<dd><input type="password" name="list_passwd" id="list_passwd" /></dd>
					</dl>
				</div>
				<div class="btn3">
					<a href="javascript:document.pwdForm.submit();"><img src="../include/images/btn_chat_nick_pw_ok.gif" alt="확인"></a>
				</div>
				</form>
				<!--<ul class="namecheck">
				 
				<li><strong>비밀번호를 입력하세요</strong></li>
				<li><input type="password" name="list_passwd" id="list_passwd" /></li>
				<li><a href="javascript:document.pwdForm.submit();">[확인]</a></li>
				<li><a href="javascript:formSubmit('<%=request.getParameter("type")%>');">[확인]</a></li>
				</ul> -->
				
			</div>
		</div>
	</div>
	
	
</div>



</body>
</html>