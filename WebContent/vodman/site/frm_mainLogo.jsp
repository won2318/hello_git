<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<jsp:useBean id="logoInfo" class="com.vodcaster.sqlbean.LogoSqlBean" scope="page" />
<%
	if(!chk_auth(vod_id, vod_level, "s_write")) {
	    out.println("<script language='javascript'>\n" +
	                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
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
	String top_logo_text = "수원시 인터넷방송";
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
		if(top_logo_text == null || top_logo_text.length()<=0 || top_logo_text.equals("null")) top_logo_text = "대전시청 인터넷방송"; 
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
			alert("100이하로 입력하시기 바랍니다.")
			fc.value="";
			fc.focus();
			return;
		}
		
		//alert(result);
		if(confirm("수정하시겠습니까?")) {
			var f = document.updateForm;
			f.action='proc_LogoImgUpdate.jsp';
			f.submit();
		}
	}
	
	
	

//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>로고</span>관리</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>로고관리</span></p>
			<div id="content">
			<form name='updateForm' method='post' enctype="multipart/form-data">
			<input type="hidden" name="mcode" value="<%=mcode%>" />
			<table cellspacing="0" class="board_view" summary="팝업관리">
				<caption>팝업관리</caption>
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="50%"/>
				</colgroup>
				<tbody class="bor_top03">

<!-- 					<tr> -->
<!-- 						<th class="bor_bottom01 back_f7"><strong>상단로고 </strong></th> -->
<!-- 						<td class="bor_bottom01 pa_left"><input type="file" id="top_logo" name="top_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/><br> 200*55크기까지 가능<br/> -->
<%-- 						<input name="_top_logo" type="hidden" value='<%=top_logo%>'> --%>
<%-- 						<% if (top_logo.indexOf(".") != -1) { %>삭제&nbsp;:&nbsp;<input type="checkbox" name='top_logo_del' value='Y' />&nbsp;<%=top_logo%> <% } %>  --%>
<!-- 						</td> -->
<%-- 						<td class="bor_bottom01 pa_left"><%if(vt.size()>0 && !top_logo.equals("")) {%><img src="/upload/logo/<%=top_logo%>" alt="이미지" class="img_style03"/><%} %></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th class="bor_bottom01 back_f7"><strong>상단로고 링크 </strong></th> -->
<%-- 						<td class="bor_bottom01 pa_left"><input name="top_logo_url" type="text" class="sec01" size="30" value='<%=top_logo_url%>'>  --%>
<!-- 						</td> -->
<!-- 						<td class="bor_bottom01 pa_left">생방송 시청화면 :  /2012/reserve/live_view_frame.jsp?muid=12&rcode=???&date=????-??-??<br/> 진행중인 이벤트 화면 : /2012/event/event_now.jsp?muid=11&id=???<br/> 평상시 메인화면 : / </td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th class="bor_bottom01 back_f7"><strong>상단로고 대체 텍스트 </strong></th> -->
<%-- 						<td class="bor_bottom01 pa_left"><input name="top_logo_text" type="text" class="sec01" size="40" value='<%=top_logo_text%>'>  --%>
<!-- 						<select name="top_logo_use" class="sec01" style="width:100px;"> -->
<%-- 								<option value="1" <%if(top_logo_use.equals("1")){out.println("selected='selected'");}%>>사용</option> --%>
<%-- 								<option value="0" <%if(top_logo_use.equals("0")){out.println("selected='selected'");}%>>사용안함</option> --%>
<!-- 							</select> -->
<!-- 						</td> -->
<!-- 						<td class="bor_bottom01 pa_left">&nbsp;대체 텍스트만 뿌리고자 하면 사용안함 선택</td> -->
<!-- 					</tr> -->
 <!--
					<tr>
						<th class="bor_bottom01 back_f7"><strong>하단로고</strong></th>
						<td class="bor_bottom01 pa_left" colspan="2">
						<%if(vt.size()>0 && !footer_logo.equals("")) {%><img src="/upload/logo/<%=footer_logo%>" alt="이미지" class="img_style04"/><%} %><br/>
						<input type="file" id="footer_logo" name="footer_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/>
						<input name="_footer_logo" type="hidden" value='<%=footer_logo%>'>
						<% if (footer_logo.indexOf(".") != -1) { %>삭제&nbsp;:&nbsp;<input type="checkbox" name='footer_logo_del' value='Y' />&nbsp;<%=footer_logo%> <% } %> 
						</td>
					</tr>
-->
					<tr>
						<th class="bor_bottom01 back_f7"><strong>영상 대기이미지</strong></th>
						<td class="bor_bottom01 pa_left"><input type="file" id="media_logo" name="media_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/>
						<input name="_media_logo" type="hidden" value='<%=media_logo%>'>
						<% if (media_logo.indexOf(".") != -1) { %>삭제&nbsp;:&nbsp;<input type="checkbox" name='media_logo_del' value='Y' />&nbsp;<%=media_logo%> <% } %> 
						</td>
						<td class="bor_bottom01 pa_left"><%if(vt.size()>0 && !media_logo.equals("")) {%><img src="/upload/logo/<%=media_logo%>" alt="이미지" class="img_style05"/><%} %></td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>재생화면 로고</strong></th>
						<td class="bor_bottom01 pa_left"  ><input type="file" id="play_logo" name="play_logo" class="sec01" size="30" value="" onchange="javascript:limitFile(this)" /><br/>
						<input name="_play_logo" type="hidden" value='<%=play_logo%>'>
						<% if (play_logo.indexOf(".") != -1) { %>삭제&nbsp;:&nbsp;<input type="checkbox" name='play_logo_del' value='Y' />&nbsp;<%=play_logo%> <% } %> 
						</td>
						<td class="bor_bottom01 pa_left" rowspan='2'>&nbsp;<%if(vt.size()>0 && !play_logo.equals("")) {%><img src="/upload/logo/<%=play_logo%>" alt="이미지" class="img_style05"/><%} %></td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>로고 투명도</strong></th>
						<td class="bor_bottom01 pa_left" ><input type="text" id="opacity" name="opacity" class="sec01" size="3" maxlength="3" value="<%=opacity%>"  onkeypress="onlyNumber(this);" />&nbsp;% 
						<br> 0 에 가까울수록 투명 합니다.
						</td>
						
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>재생화면 로고위치</strong></th>
						<td class="bor_bottom01 pa_left" colspan="2">
							<select name="play_pos" class="sec01" style="width:100px;">
								<option value="9" <%if(play_pos.equals("9")){out.println("selected='selected'");}%>>로고 없음</option>
								<option value="0" <%if(play_pos.equals("0")){out.println("selected='selected'");}%>>1:상단좌측</option>
								<option value="1" <%if(play_pos.equals("1")){out.println("selected='selected'");}%>>2:상단중앙</option>
								<option value="2" <%if(play_pos.equals("2")){out.println("selected='selected'");}%>>3:상단우측</option>
								<option value="3" <%if(play_pos.equals("3")){out.println("selected='selected'");}%>>4:중앙좌측</option>
								<option value="4" <%if(play_pos.equals("4")){out.println("selected='selected'");}%>>5:중앙중앙</option>
								<option value="5" <%if(play_pos.equals("5")){out.println("selected='selected'");}%>>6:중앙우측</option>
								<option value="6" <%if(play_pos.equals("6")){out.println("selected='selected'");}%>>7:하단좌측</option>
								<option value="7" <%if(play_pos.equals("7")){out.println("selected='selected'");}%>>8:하단중앙</option>
								<option value="8" <%if(play_pos.equals("8")){out.println("selected='selected'");}%>>9:하단우측</option>
							</select>
							<img src="/vodman/include/images/logo_xy.gif" alt="이미지"/>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:updateListBoard();"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<%-- <a href="javascript:history.go(-1);"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a> --%>
				</div>	
				<br/><br/>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<iframe id="fileFrame" name="fileFrame" src="#" width="0" height="0" cellpadding="0" cellspacing="0" border="0"></iframe>
<%@ include file="/vodman/include/footer.jsp"%>