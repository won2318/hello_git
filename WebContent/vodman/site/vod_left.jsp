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
			<h2><img src="/vodman/include/images/a_menu04_title.gif" alt="�������"/></h2>
			<ul class="s_menu_bg">
			<li><a href="/vodman/vod_aod/mng_vodOrderList.jsp?mcode=0701" title="���� ���" <%if(mcode.equals("0701")) {out.println("class='visible'");}%>>���� ���</a></li>
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
					<li><a href="/vodman/vod_aod/mng_vodOrderList.jsp?mcode=<%=tmpMcode%>&ccode=<%=left_info.getCcode()%>" title="<%=left_info.getCtitle() %>" <%if(mcode.equals(tmpMcode)) {out.println("class='visible'");}%>><font color="blue"> - <%=left_info.getCtitle() %></font></a></li>
					<%
					left_cnt ++;
				}
			}
			%>
			<%
			left_cnt++;
			tmpMcode = "07" +( left_cnt>9?""+left_cnt:"0"+left_cnt );
			 
			%>
			<li><a href="/vodman/vod_aod/frm_AddContent.jsp?mcode=<%=tmpMcode%>" title="���� ����" <%if(mcode.equals(tmpMcode)) {out.println("class='visible'");}%>>���� ����</a></li>
			<%
			left_cnt++;
			tmpMcode = "07" +( left_cnt>9?""+left_cnt:"0"+left_cnt );
			%>
			<li><a href="/vodman/vod_aod/option.jsp?mcode=<%=tmpMcode%>"  title="���� �ɼǰ���" <%if(mcode.equals(tmpMcode)) {out.println("class='visible'");}%>>���ڵ� �ɼ� ����</a></li>
			<%
			left_cnt++;
			tmpMcode = "07" +( left_cnt>9?""+left_cnt:"0"+left_cnt );
			%>
			<li><a href="/vodman/vod_aod/file_manager.jsp?mcode=<%=tmpMcode%>" title="���ϰ���" <%if(mcode.equals(tmpMcode)) {out.println("class='visible'");}%>>���� ���ϰ���</a></li>
			<%
			left_cnt++;
			tmpMcode = "07" +( left_cnt>9?""+left_cnt:"0"+left_cnt );
			%>
			<li><a href="/vodman/vod_aod/mng_boardListComment.jsp?mcode=<%=tmpMcode%>&flag=M" title="��۰���" <%if(mcode.equals(tmpMcode)) {out.println("class='visible'");}%>>���� ��۰���</a></li>
			
			</ul>
			<p class="menu_bottom"></p>
		</div>