<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>

<%
String result_url = "http://tv.suwon.go.kr";
if (request.getParameter("result_url") != null){
	result_url = request.getParameter("result_url");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="http://tv.suwon.go.kr/2013/include/css/default.css" rel="stylesheet" type="text/css" />
	
	<script language='JavaScript' type='text/javascript'>
function check_form() {
	var f = document.form1;

	if (f.name.value == "") {
		alert("이름을 입력하세요");
		return;
	} 
	if ( f.jumin1.value == ""){
		alert("주민등록번호를 입력하세요");
		return;
	}
	if ( f.jumin2.value == ""){
		alert("주민등록번호를 입력하세요");
		return;
	}
	f.submit();
}

</script> 

</head>
<body>

<div id="pWrapSmall">
	<!-- container::메인컨텐츠 -->
	<div id="pLogoSmall">
		<span class="close"><a href="javascript:self.close();"><img src="/2013/include/images/btn_view_close.gif" alt="닫기"/></a></span>
	</div>
	<div id="pContainerSmall">
		<div id="pContentSmall">
		<form name="form1" action="https://name.siren24.com/servlet/name_check" method="post">
			<input type=hidden name=id value="KGT002" />
			<input type=hidden name=ok_url value="http://tv.suwon.go.kr/include/check_name_ok.jsp?result_url=<%=result_url%>" />
			<h3 class="pTitle">사용자 인증</h3>
			<div class="pSubject">
				<div class="zipSearchList">
					 
					<ul>
					<li><label for="name">이름 입력</label></li>
					<li><input type="text" name="name" id="name"  size="10" value="" title="이름 입력" /></li>
					</ul>
					<ul>
					<li><label for="zipLast">주민번호 입력</label></li>
					<li><input type="text" class="input" size="6" name="jumin1" /> - <input type="password" class="input" size="7" name="jumin2" />
					</ul>
					<ul>
					<li><input type="image" src="/2013/include/images/btn_ok.gif" alt="확인"/></li></li>
					</ul>
				</div>
			</div>
			</form>
		</div>
	</div>
	
	
</div>



</body>
</html>