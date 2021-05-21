<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<div id="foot" class="foot" >
<footer role="contentinfo">
	<p class="foot_p">
	<a href="http://newsuwon.withustech.com/2013/main/main.jsp" class="foot_pa1">PC 화면</a> |
		<a href="main.jsp" class="foot_pa1">종합뉴스</a> |
		<% 	if(protocal.equals("Android")){ %>	
			<a href="market://details?id=com.LinkApp" class="bar">앱다운로드</a> |
		<% }else if(protocal.equals("apple")){ %>
			<a href="http://itunes.apple.com/kr/app/id414635460?mt=8" class="bar">앱다운로드</a>  |
		<% } %>
		
		<a href="#top" class="foot_pa2">위로이동</a>
	</p>
	<p class="foot_p2">ⓒ SUWON CITY. ALL RIGHTS RESERVED.</p>
</footer>
</div> 