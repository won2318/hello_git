<%@ page contentType="text/html; charset=euc-kr"%>

<%
	/**
	 * @author ����
	 *
	 * @description : ������ ���� �޴�
	 * date : 2005-01-28
	 */

%>
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

function channelAdd(){
	var id = "/vodman/media/live_channelAdd.jsp";
	var oio = window.open(id,"AddChannel","width=400,height=200");
	oio.focus();
}
//-->
</script>
<!--
<table width="150" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10"></td>
  </tr>
  <tr>
    <td height="35" align="center" background="/vodman/images/category_title_bg.gif"><strong>����� ����</strong></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
  <tr>
    <td height="23" background="/vodman/images/category_menu_bg_01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40"></td>
          <td><a href="/vodman/schedule/mng_vodRealList.jsp">����� ���</a></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="23" background="/vodman/images/category_menu_bg_01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40"></td>
          <td><a href="/vodman/schedule/frm_rvodAdd.jsp">����� ����</a></td>
        </tr>
      </table></td>
  </tr>
   <tr>
    <td height="23" background="/vodman/images/category_menu_bg_01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40"></td>
          <td><a href="/vodman/media/live_channelList.jsp">ä�� ���</a></td>
        </tr>
      </table></td>
  </tr>
   <tr>
    <td height="23" background="/vodman/images/category_menu_bg_01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40"></td>
          <td><a href="javascript:channelAdd();">ä�� ���� </a></td>
        </tr>
      </table></td>
  </tr>
   <tr>
    <td height="23" background="/vodman/images/category_menu_bg_01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40"></td>
          <td><a href="/vodman/media/live_channelMonitor.jsp">Live ����͸�   </a></td>
        </tr>
      </table></td>
  </tr>
  
</table>

-->


<table width="171"  border="0" cellspacing="0" cellpadding="0">
  <tr>
		<td width="154" height="10"></td>
		<td width="17" rowspan="5">&nbsp;</td>
  </tr>
  <tr>
		<td width="154" height="35" align="center" background="/vodman/image/category_title_bg.gif"><strong>����� ����</strong></td>
  </tr>
  <tr>
		<td width="154" height="10"></td>
  </tr>
  <tr>
	<td width="154"><table width="154"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td><img src="/vodman/image/category_border_top.gif" width="154" height="10"></td>
	  </tr>
	  <tr>
		<td background="/vodman/image/category_border_bg.gif"><div align="center">
			<table width="146" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td height="23" background="/vodman/image/category_menu_bg_01.gif"><table width="146" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="30" class="style2"></td>
					<td width="116" class="style2"><a href="/vodman/schedule/mng_vodRealList.jsp">����� ���</a></td>
				  </tr>
				</table></td>
			  </tr>
			  <tr>
				<td height="23" background="/vodman/image/category_menu_bg_01.gif"><table width="146" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="30" class="style2"></td>
					<td width="116" class="style2"><a href="/vodman/schedule/frm_rvodAdd.jsp">����� ����</a></td>
				  </tr>
				</table></td>
			  </tr>	
<!--
			  <tr>
				<td height="23" background="/vodman/image/category_menu_bg_01.gif"><table width="146" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="30" class="style2"></td>
					<td width="116" class="style2"><a href="/vodman/schedule2/mng_vodRealList.jsp">���� ���</a></td>
				  </tr>
				</table></td>
			  </tr>
			  <tr>
				<td height="23" background="/vodman/image/category_menu_bg_01.gif"><table width="146" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="30" class="style2"></td>
					<td width="116" class="style2"><a href="/vodman/schedule2/frm_rvodAdd.jsp">���� ����</a></td>
				  </tr>
				</table></td>
			  </tr> -->	
			  <tr>
				<td height="23" background="/vodman/image/category_menu_bg_01.gif"><table width="146" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="30" class="style2"></td>
					<td width="116" class="style2"><a href="/vodman/media/live_channelList.jsp">ä�� ���</a></td>
				  </tr>
				</table></td>
			  </tr>	
			  <tr>
				<td height="23" background="/vodman/image/category_menu_bg_01.gif"><table width="146" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="30" class="style2"></td>
					<td width="116" class="style2"><a href="javascript:channelAdd();">ä�� ���� </a></td>
				  </tr>
				</table></td>
			  </tr>	
			  <tr>
				<td height="23" background="/vodman/image/category_menu_bg_01.gif"><table width="146" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="30" class="style2"></td>
					<td width="116" class="style2"><a href="/vodman/media/live_channelMonitor.jsp">Live ����͸�   </a></td>
				  </tr>
				</table></td>
			  </tr>
			  

			</table>
		  </div>
			</td>
	  </tr>
	  <tr>
		<td><img src="/vodman/image/category_border_bot.gif" width="154" height="10"></td>
	  </tr>
	</table></td>
	</tr>
  <tr>
	<td width="154">&nbsp;</td>
  </tr>
</table>