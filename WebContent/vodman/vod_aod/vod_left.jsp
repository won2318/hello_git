<%@ page contentType="text/html; charset=euc-kr"%>
	<script language = "JavaScript">
	<!--
	function M_over(src,cleerOver) {
		if (!src.contains(event.fromElement)) {
			src.style.cursor = 'hand'; src.bgColor = cleerOver;
		}
	}
	
	
	function M_out(src,cleerin) {
		if (!src.contains(event.toElement)) {
			src.style.cursor = 'default'; src.bgColor = cleerin;
		}
	}
	
	//-->
	</script>

		<div id="menu">
			<h2><img src="/vodman/include/images/a_menu04_title.gif" alt="영상관리"/></h2>
			<ul class="s_menu_bg">
			<li><a href="/vodman/vod_aod/mng_vodOrderList.jsp?mcode=0701" title="영상 목록" <%if(mcode.equals("0701")) {out.println("class='visible'");}%>>영상 목록</a></li>
			<%
			int left_cnt = 2;
			String tmpMcode = "";
			
			CategoryManager left_cmgr = CategoryManager.getInstance();
			Vector vt_left = left_cmgr.getCategoryListALL3("V","A");
			if(vt_left != null && vt_left.size()>0)
			{
				CategoryInfoBean left_info = new CategoryInfoBean();
				
				for(Enumeration e = vt_left.elements(); e.hasMoreElements();) {
					tmpMcode = "07" +( left_cnt>9?""+left_cnt:"0"+left_cnt );
					com.yundara.beans.BeanUtils.fill(left_info, (Hashtable)e.nextElement());
										
					%>
					<li><a href="/vodman/vod_aod/mng_vodOrderList.jsp?mcode=<%=tmpMcode%>&ccode=<%=left_info.getCcode()%>" title="<%=left_info.getCtitle() %>" 
					<%
					if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 3  && left_info.getCcode().substring(0,3).equals(request.getParameter("ccode").substring(0,3)) )
					{ out.println("class='visible'"); } else if(request.getParameter("ccode") == null && mcode.equals(tmpMcode)) {out.println("class='visible'");}%>><font color="blue"> - <%=left_info.getCtitle() %></font></a></li>
					<%
					left_cnt ++;
				}
			}
			%>
			<% 
			tmpMcode = "07" +( left_cnt>9?""+left_cnt:"0"+left_cnt );
			%>
			<li><a href="/vodman/vod_aod/frm_AddContent.jsp?mcode=<%=tmpMcode%>" title="영상 생성" <%if(mcode.equals(tmpMcode)) {out.println("class='visible'");}%>>영상 생성</a></li>
			<%
			left_cnt++;
			tmpMcode = "07" +( left_cnt>9?""+left_cnt:"0"+left_cnt );
			%>
			<li><a href="/vodman/vod_aod/mng_boardListComment.jsp?mcode=<%=tmpMcode%>&flag=M" title="댓글관리" <%if(mcode.equals(tmpMcode)) {out.println("class='visible'");}%>>영상 댓글관리</a></li>
			
			</ul>
			<p class="menu_bottom"></p>
		</div>