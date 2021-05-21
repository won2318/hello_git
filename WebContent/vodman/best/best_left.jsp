<%@ page contentType="text/html; charset=euc-kr"%>
		<div id="menu">
			<h2><img src="/vodman/include/images/a_menu02_title.gif" alt="메인화면관리"/></h2>
			<ul class="s_menu_bg">
<%-- 	20190304		<li><a href="/vodman/best/frm_bestweekAdd.jsp?mcode=0201" title="메인 VOD" <%if(mcode.equals("0201")) {out.println("class='visible'");}%>>메인화면 영상</a></li> --%>
			<li><a href="/vodman/best/mng_best_topView.jsp?mcode=0207&flag=A" title="인기영상" <%if(mcode.equals("0207")){out.println("class='visible'");}%>>오늘의 주요 영상</a></li>
<%-- 			<li><a href="/vodman/best/mng_best_topView.jsp?mcode=0202&flag=B" title="인기영상" <%if(mcode.equals("0202")){out.println("class='visible'");}%>>화제의 영상</a></li>  --%>
<%-- 			<li><a href="/vodman/best/mng_best_topView.jsp?mcode=0203&flag=C" title="인기영상" <%if(mcode.equals("0203")){out.println("class='visible'");}%>>명예의 전당</a></li>  --%>
<%-- 			<li><a href="/vodman/best/mng_best_topView.jsp?mcode=0204&flag=D" title="인기영상" <%if(mcode.equals("0204")){out.println("class='visible'");}%>>HOT 뉴스</a></li>  --%>
<%-- 			<li><a href="/vodman/best/mng_list_link.jsp?mcode=0205&flag=E" title="인기영상" <%if(mcode.equals("0205")){out.println("class='visible'");}%>>편성표 링크</a></li>  --%>
			<li><a href="/vodman/site/youtube_link.jsp?mcode=0208&flag=G" title="유튜브 링크" <%if(mcode.equals("0208")){out.println("class='visible'");}%>>유튜브 링크</a></li> 
			<li><a href="/vodman/site/frm_popList.jsp?mcode=0206&flag=F" title="팝업관리" <%if(mcode.equals("0206")){out.println("class='visible'");}%>>팝업관리</a></li> 
			
			</ul>
			<p class="menu_bottom"></p>
		</div>
