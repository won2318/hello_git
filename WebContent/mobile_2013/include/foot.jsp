<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<div id="foot" class="foot" >
<footer role="contentinfo">
	<p class="foot_p">
	<%
 
	if (request.getRequestURL().toString().indexOf("iNews") > 0) { %>
		<a href="http://news.suwon.go.kr" class="foot_pa1">PC ȭ��</a> |
	<%} %>
		<a href="main.jsp" class="foot_pa1">���մ���</a> |
		<% 	if(protocal.equals("Android")){ %>	
			<a href="market://details?id=com.LinkApp" class="bar">�۴ٿ�ε�</a> |
		<% }else if(protocal.equals("apple")){ %>
			<a href="http://itunes.apple.com/kr/app/id414635460?mt=8" class="bar">�۴ٿ�ε�</a>  |
		<% } %>
		<% if (vod_name != null && vod_name.length() > 0) { %>
		<a href="logout.jsp" class="foot_pa1">�α׾ƿ�</a>  |
		<%} %>
		<a href="#top" class="foot_pa2">�����̵�</a>
	</p>
	<p class="foot_p2">�� SUWON CITY. ALL RIGHTS RESERVED.</p>
</footer>
</div> 