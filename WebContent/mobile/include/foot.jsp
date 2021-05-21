<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
  
		<footer>
			<div class="mTop">
				<a href="javascript:topPage();">TOP</a>
			</div>
			<span class="link_view">
				<% if (vod_name != null && vod_name.length() > 0) { %>
				<a href="logout.jsp" class="foot_pa1">로그아웃</a> 
				<%} else{ %>
				<a href="login.jsp" class="foot_pa1">로그인</a> 
				<%} %>
				<a href="#top" class="foot_pa2">위로이동</a>
			</span>
			<p>&copy; SUWON CITY, ALL RIGHTS RESERVED.</p>
		</footer>  <!--//푸터:footer-->     
	</div><!--//wapper-->
	<script type="text/javascript">
		function topPage(){
			window.scrollTo(0, 1);
			}

	</script>	
</body>
</html>
