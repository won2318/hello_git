<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<jsp:useBean id="logoInfo" class="com.vodcaster.sqlbean.LogoSqlBean" scope="page" />
<%
	if(!chk_auth(vod_id, vod_level, "s_write")) {
	    out.println("<script language='javascript'>\n" +
	                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
	                "history.go(-1);\n" +
	                "</script>");
	    return;
	}
%>
<%
	request.setCharacterEncoding("EUC-KR");
	
	Vector vt = null;
	vt = logoInfo.getLogo();
	
	String top_logo = "";
	String footer_logo = "";
	String media_logo = "";
	String play_logo = "";
	String play_pos = "";
	String opacity = "100";
	String top_logo_url = "/";
	String top_logo_text = "������ ���ͳݹ��";
	String top_logo_use="1";

	if(vt != null && vt.size() > 0) {
		
		top_logo = String.valueOf(vt.elementAt(1));
		footer_logo = String.valueOf(vt.elementAt(2));
		media_logo = String.valueOf(vt.elementAt(4));
		play_logo = String.valueOf(vt.elementAt(5));
		play_pos = String.valueOf(vt.elementAt(6));
		opacity = String.valueOf(vt.elementAt(7));
		top_logo_url = String.valueOf(vt.elementAt(8));
		top_logo_text = String.valueOf(vt.elementAt(9));
		top_logo_use= String.valueOf(vt.elementAt(10));
		if(top_logo_text == null || top_logo_text.length()<=0 || top_logo_text.equals("null")) top_logo_text = "������û ���ͳݹ��"; 
	} else {
		out.println("<script>alert('err : -999');</script>");
	}	
		com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();
		File file1 = new File(DirectoryNameManager.VODROOT+"/upload/logo/"+ top_logo);
		if(!file1.exists()) {
			top_logo="";
		}
		
		
		File file2 = new File(DirectoryNameManager.VODROOT+"/upload/logo/"+ footer_logo);
		
		if(!file2.exists()) {
			footer_logo="";
		}
		
		File file3 = new File(DirectoryNameManager.VODROOT+"/upload/logo/"+ media_logo);
		if(!file3.exists()) {
			media_logo="";
		}
		
		File file4 = new File(DirectoryNameManager.VODROOT+"/upload/logo/"+ play_logo);
		if(!file4.exists()) {
			play_logo="";
		}
		

%>

<%@ include file="/vodman/include/top.jsp"%>


<script language="javascript">
<!--
	function limitFile(object) {
		var file_flag = object.name;
		var file_name = object.value;
		
		document.getElementById('fileFrame').src = "file_check.jsp?file_flag="+file_flag+"&file_name=" + file_name;
	}
	
	function clearFile(file_flag) {
		document.getElementById(file_flag).outerHTML = document.getElementById(file_flag).outerHTML;
	}

	function updateListBoard(){
		var result = document.updateForm.opacity.value;	
		var fc = document.updateForm.opacity;
		
		if(result > 100 ) {
			alert("100���Ϸ� �Է��Ͻñ� �ٶ��ϴ�.")
			fc.value="";
			fc.focus();
			return;
		}
		
		//alert(result);
		if(confirm("�����Ͻðڽ��ϱ�?")) {
			var f = document.updateForm;
			f.action='proc_LogoImgUpdate.jsp';
			f.submit();
		}
	}
	
	
	

//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<!-- ������ -->
		<div id="contents">
			<h3><span>�ΰ�</span>����</h3>
			<p class="location">������������ &gt; ����Ʈ���� &gt; <span>�ΰ����</span></p>
			<div id="content">
			<form name='updateForm' method='post' enctype="multipart/form-data">
			<input type="hidden" name="mcode" value="<%=mcode%>" />
			<table cellspacing="0" class="board_view" summary="�˾�����">
				<caption>�˾�����</caption>
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="50%"/>
				</colgroup>
				<tbody class="bor_top03">

<!-- 					<tr> -->
<!-- 						<th class="bor_bottom01 back_f7"><strong>��ܷΰ� </strong></th> -->
<!-- 						<td class="bor_bottom01 pa_left"><input type="file" id="top_logo" name="top_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/><br> 200*55ũ����� ����<br/> -->
<%-- 						<input name="_top_logo" type="hidden" value='<%=top_logo%>'> --%>
<%-- 						<% if (top_logo.indexOf(".") != -1) { %>����&nbsp;:&nbsp;<input type="checkbox" name='top_logo_del' value='Y' />&nbsp;<%=top_logo%> <% } %>  --%>
<!-- 						</td> -->
<%-- 						<td class="bor_bottom01 pa_left"><%if(vt.size()>0 && !top_logo.equals("")) {%><img src="/upload/logo/<%=top_logo%>" alt="�̹���" class="img_style03"/><%} %></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th class="bor_bottom01 back_f7"><strong>��ܷΰ� ��ũ </strong></th> -->
<%-- 						<td class="bor_bottom01 pa_left"><input name="top_logo_url" type="text" class="sec01" size="30" value='<%=top_logo_url%>'>  --%>
<!-- 						</td> -->
<!-- 						<td class="bor_bottom01 pa_left">����� ��ûȭ�� :  /2012/reserve/live_view_frame.jsp?muid=12&rcode=???&date=????-??-??<br/> �������� �̺�Ʈ ȭ�� : /2012/event/event_now.jsp?muid=11&id=???<br/> ���� ����ȭ�� : / </td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th class="bor_bottom01 back_f7"><strong>��ܷΰ� ��ü �ؽ�Ʈ </strong></th> -->
<%-- 						<td class="bor_bottom01 pa_left"><input name="top_logo_text" type="text" class="sec01" size="40" value='<%=top_logo_text%>'>  --%>
<!-- 						<select name="top_logo_use" class="sec01" style="width:100px;"> -->
<%-- 								<option value="1" <%if(top_logo_use.equals("1")){out.println("selected='selected'");}%>>���</option> --%>
<%-- 								<option value="0" <%if(top_logo_use.equals("0")){out.println("selected='selected'");}%>>������</option> --%>
<!-- 							</select> -->
<!-- 						</td> -->
<!-- 						<td class="bor_bottom01 pa_left">&nbsp;��ü �ؽ�Ʈ�� �Ѹ����� �ϸ� ������ ����</td> -->
<!-- 					</tr> -->
 <!--
					<tr>
						<th class="bor_bottom01 back_f7"><strong>�ϴܷΰ�</strong></th>
						<td class="bor_bottom01 pa_left" colspan="2">
						<%if(vt.size()>0 && !footer_logo.equals("")) {%><img src="/upload/logo/<%=footer_logo%>" alt="�̹���" class="img_style04"/><%} %><br/>
						<input type="file" id="footer_logo" name="footer_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/>
						<input name="_footer_logo" type="hidden" value='<%=footer_logo%>'>
						<% if (footer_logo.indexOf(".") != -1) { %>����&nbsp;:&nbsp;<input type="checkbox" name='footer_logo_del' value='Y' />&nbsp;<%=footer_logo%> <% } %> 
						</td>
					</tr>
-->
					<tr>
						<th class="bor_bottom01 back_f7"><strong>���� ����̹���</strong></th>
						<td class="bor_bottom01 pa_left"><input type="file" id="media_logo" name="media_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/>
						<input name="_media_logo" type="hidden" value='<%=media_logo%>'>
						<% if (media_logo.indexOf(".") != -1) { %>����&nbsp;:&nbsp;<input type="checkbox" name='media_logo_del' value='Y' />&nbsp;<%=media_logo%> <% } %> 
						</td>
						<td class="bor_bottom01 pa_left"><%if(vt.size()>0 && !media_logo.equals("")) {%><img src="/upload/logo/<%=media_logo%>" alt="�̹���" class="img_style05"/><%} %></td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>���ȭ�� �ΰ�</strong></th>
						<td class="bor_bottom01 pa_left"  ><input type="file" id="play_logo" name="play_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/>
						<input name="_play_logo" type="hidden" value='<%=play_logo%>'>
						<% if (play_logo.indexOf(".") != -1) { %>����&nbsp;:&nbsp;<input type="checkbox" name='play_logo_del' value='Y' />&nbsp;<%=play_logo%> <% } %> 
						</td>
						<td class="bor_bottom01 pa_left" rowspan='2'>&nbsp;<%if(vt.size()>0 && !play_logo.equals("")) {%><img src="/upload/logo/<%=play_logo%>" alt="�̹���" class="img_style05"/><%} %></td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>�ΰ� ����</strong></th>
						<td class="bor_bottom01 pa_left" ><input type="text" id="opacity" name="opacity" class="sec01" size="3" maxlength="3" value="<%=opacity%>"  onkeypress="onlyNumber(this);" />&nbsp;% 
						<br> 0 �� �������� ���� �մϴ�.
						</td>
						
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>���ȭ�� �ΰ���ġ</strong></th>
						<td class="bor_bottom01 pa_left" colspan="2">
							<select name="play_pos" class="sec01" style="width:100px;">
								<option value="9" <%if(play_pos.equals("9")){out.println("selected='selected'");}%>>�ΰ� ����</option>
								<option value="0" <%if(play_pos.equals("0")){out.println("selected='selected'");}%>>1:�������</option>
								<option value="1" <%if(play_pos.equals("1")){out.println("selected='selected'");}%>>2:����߾�</option>
								<option value="2" <%if(play_pos.equals("2")){out.println("selected='selected'");}%>>3:��ܿ���</option>
								<option value="3" <%if(play_pos.equals("3")){out.println("selected='selected'");}%>>4:�߾�����</option>
								<option value="4" <%if(play_pos.equals("4")){out.println("selected='selected'");}%>>5:�߾��߾�</option>
								<option value="5" <%if(play_pos.equals("5")){out.println("selected='selected'");}%>>6:�߾ӿ���</option>
								<option value="6" <%if(play_pos.equals("6")){out.println("selected='selected'");}%>>7:�ϴ�����</option>
								<option value="7" <%if(play_pos.equals("7")){out.println("selected='selected'");}%>>8:�ϴ��߾�</option>
								<option value="8" <%if(play_pos.equals("8")){out.println("selected='selected'");}%>>9:�ϴܿ���</option>
							</select>
							<img src="/vodman/include/images/logo_xy.gif" alt="�̹���"/>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:updateListBoard();"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
					<%-- <a href="javascript:history.go(-1);"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a> --%>
				</div>	
				<br/><br/>
			</div>
			<!-- ���� �� -->
		</div>	
		<!-- ������ �� -->
<iframe id="fileFrame" name="fileFrame" src="#" width="0" height="0" cellpadding="0" cellspacing="0" border="0"></iframe>
<%@ include file="/vodman/include/footer.jsp"%>