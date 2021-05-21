<%@ page language="java" pageEncoding="EUC-KR" %>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	/**
	 * @author Jong-Hyun Ho
	 *
	 * @description : 게시물들의 정보를 등록하는 페이지
	 * date : 2005-01-04
	 */

%>
<%
if(!chk_auth(vod_id, vod_level, "b_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%
	String field = request.getParameter("field").replaceAll("<","").replaceAll(">","");
	String searchstring = request.getParameter("searchstring").replaceAll("<","").replaceAll(">","");
	String pg = request.getParameter("page").replaceAll("<","").replaceAll(">","");

	int board_id  = 0;
	int list_id  = 0;

	try{
		if(request.getParameter("board_id") == null || request.getParameter("board_id").length()<=0 || request.getParameter("board_id").equals("null")){
		}else{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
		}
	}catch(Exception e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode = request.getParameter("mcode");
			if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
				mcode = "0901";
			}
			String REF_URL="mng_boardList.jsp?mcode="+mcode ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
	}
	
	if(request.getParameter("list_id")  != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null")){
		list_id  = Integer.parseInt(request.getParameter("list_id") );
	}else{
		String mcode= request.getParameter("mcode");
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_boardListList.jsp?board_id=" + board_id+"&field="+field+"&page="+pg+"&searchstring="+searchstring+"&mcode="+mcode ;
			%>
			<%@ include file = "/vodman/include/REF_URL.jsp"%>
			<%
			return;
	}

	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode = request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
				mcode = "0901";
			}
		String REF_URL="mng_boardList.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	
	//board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag, board_user_flag, board_top_comments, board_footer_comments, board_priority
	String board_title = "";
	String board_page_line = "";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	if(v_bi != null && v_bi.size() >0){
		board_title = String.valueOf(v_bi.elementAt(0));
		board_page_line = String.valueOf(v_bi.elementAt(1));
		board_image_flag = String.valueOf(v_bi.elementAt(2));
		board_file_flag = String.valueOf(v_bi.elementAt(3));
		board_link_flag = String.valueOf(v_bi.elementAt(4));
		board_user_flag = String.valueOf(v_bi.elementAt(5));
		board_top_comments = String.valueOf(v_bi.elementAt(6));
		board_footer_comments = String.valueOf(v_bi.elementAt(7));
		board_priority = String.valueOf(v_bi.elementAt(8));
	}else{
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0901";
		}
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_boardList.jsp?mcode="+mcode;
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
				mcode = "0901";
			}
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

	Vector v_bl = null;
	try{
		v_bl = BoardListSQLBean.getOnlyBoardList(board_id,list_id);
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode = request.getParameter("mcode");
		
		String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>

<script language='javascript'>
window.onload=function()
{
	imageSetting();
}
function limitFile(file_flag)
 {
	 var file = null;

	 if (file_flag == "list_data_file")
	 {
		  file = document.updateForm.list_data_file.value;
	 } else if (file_flag == "list_image_file")
	 {
		  file = document.updateForm.list_image_file.value;
	 } else if (file_flag == "list_image_file2")
	 {
		  file = document.updateForm.list_image_file2.value;
	 } else if (file_flag == "list_image_file3")
	 {
		  file = document.updateForm.list_image_file3.value;
	 }

	  extArray = new Array(".jsp", ".cgi", ".php", ".asp", ".aspx", ".exe", ".com", ".js", ".pl", ".php3",".html",".htm");
	  allowSubmit = false;

	  while (file.indexOf("\\") != -1) {
	   file = file.slice(file.indexOf("\\") + 1);
	   ext = file.slice(file.indexOf(".")).toLowerCase();

		   for (var i = 0; i < extArray.length; i++) {
				if (extArray[i] == ext) {
				 allowSubmit = true;
				 break;
				}
		   }
	  }

	  if (allowSubmit){

	   alert("입력하신 파일은 업로드 될 수 없습니다!");
	    if (file_flag == "list_data_file")
		 {
			   document.updateForm.list_data_file.outerHTML = document.updateForm.list_data_file.outerHTML;
		 } else if (file_flag == "list_image_file")
		 {
			   document.updateForm.list_image_file.outerHTML = document.updateForm.list_image_file.outerHTML;
		 } else if (file_flag == "list_image_file2")
		 {
			   document.updateForm.list_image_file2.outerHTML = document.updateForm.list_image_file2.outerHTML;
		 } else if (file_flag == "list_image_file3")
		 {
			  document.updateForm.list_image_file3.outerHTML = document.updateForm.list_image_file3.outerHTML;
		 }




	   return;
	  }
 }


	function updateListBoard(){
		var f = document.updateForm;

		if (f.list_name.value=="") {
		   alert ("작성자를 입력하지 않으셨습니다.")
		   f.list_name.focus();
		   return
		}
		if (f.list_title.value=="") {
		   alert ("제목을 입력하지 않으셨습니다.")
		   f.list_title.focus();
		   return
		}
		if(!CheckText(f.list_title)){
			return;
		}
		if (f.list_contents.value=="") {
		   alert ("내용을 입력하지 않으셨습니다.")
		   f.list_contents.focus();
		   return
		}
		if(!pwCheck(f.list_passwd.value)){
				f.list_passwd.focus();
				alert("영문+숫자+특수 문자를 최소 한자 이상씩 조합한 8자 이상, 12자 이내로 입력하시기 바랍니다.");
				return;
		}
		


		f.action='proc_boardListUpdate.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>';
		f.submit();

	}

	function CheckText(str) {
		strarr = new Array(str.value.length);
		schar = new Array("'");

		for (i=0; i<str.value.length; i++)
		{
			for (j=0; j<schar.length; j++)
			{
				if (schar[j] ==str.value.charAt(i))
				{
					alert("(')특수문자는 불가능합니다");
					str.focus();
					return false;
				}
				else
					continue;
			}

		}
		return true;
	}

	function addImage(num){
		var addnum = num+1;
		document.getElementById("imageList_"+addnum).style.display = "block";
		if(num == 1) {
			document.getElementById("imageBtn").style.visibility = "hidden";
		} else {
			document.getElementById("imageBtn"+num).style.visibility = "hidden";
		}
	}

	function dropImage(objName, num){
		document.getElementById('list_image_file'+num).outerHTML = document.getElementById('list_image_file'+num).outerHTML;
		document.getElementById('image_text'+num).value = "";
		if(searchCheckBox(objName)) {
			document.getElementById('list_image_del'+num).checked =true;
		}
		document.getElementById(objName).style.display = "none";

		num = num -1;
		if(num == 1) {
			document.getElementById("imageBtn").style.visibility = "visible";
		} else {
			document.getElementById("imageBtn"+num).style.visibility = "visible";
		}
	}
		
	function imageSetting() {

		var num = 0;
		for(var i=0; i < document.all.length; i++) {
			if(document.all(i).id.indexOf("imageList") > -1) {
				num = num + 1;
				nextNum = num + 1;

//				alert("imageList_" + nextNum + "/" +document.getElementById("imageList_" + nextNum).style.display);
				if(nextNum <= 10 && document.getElementById("imageList_" + nextNum).style.display == "block") {
					if(num == 1) {
						document.getElementById("imageBtn").style.visibility = "hidden";
					} else {
						document.getElementById("imageBtn"+num).style.visibility = "hidden";
					}
				}
			}
		}
	}

	function searchCheckBox(objLayer) {
		var flag = false;
		var obj = document.getElementById(objLayer);
		for(var i=0; i < obj.all.length; i++) {
			if(obj.all(i).tagName.toUpperCase() == "INPUT") {
				if(obj.all(i).type.toUpperCase() == "CHECKBOX") {
					flag = true;
					break;
				}
			}
		}
		return flag;
	}

</script>
	
		<!-- 컨텐츠 -->
		<div id="contents" onload="imageSetting();">
			<h3><span>공지</span>사항</h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; 게시판 정보 &gt; <span><%=board_title%></span></p>
			<div id="content">
				<!-- 내용 -->
				<table cellspacing="0" class="board_view" summary="<%=board_title%> 수정">
				<caption><%=board_title%> 수정</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<form name='frmBoard' method='post' enctype='multipart/form-data'>
				
				<input type="hidden" name="board_id" value="<%=board_id%>">
				<input type="hidden" name="list_id" value="<%=list_id%>">
				<input type="hidden" name="page" value="<%=pg%>">
				<input type="hidden" name="field" value="<%=field%>">
				<input type="hidden" name="searchstring" value="<%=searchstring%>">
				<input type="hidden" name="main" value="<%=v_bl.elementAt(22)%>">

				<input type="hidden" name="ccode" value="<%=String.valueOf(v_bi.elementAt(14))%>">
				
				<tbody class="font_127">
					<tr>
						<th class="bor_bottom01"><strong>작성자</strong></th>
						<td class="bor_bottom01 pa_left"><%=v_bl.elementAt(3)%><input name="list_name" type="hidden"  id="list_name2" value='<%=v_bl.elementAt(3)%>' class="input01" style="width:150px;" readonly /></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>제목</strong></th>
						<td class="bor_bottom01 pa_left"><input name="list_title" type="text" maxlength="30" id="list_title2" value='<%=v_bl.elementAt(4)%>' class="input01" style="width:300px;"/></td>
					</tr>
				 
					<tr>
						<th class="bor_bottom01"><strong>동영상 </strong></th>
						<td class="bor_bottom01 pa_left">
						<div class="silver2" id="movie"><textarea id='mplayer2' style="display:none;" rows="0" cols="0">

							<object id="SilverPlayer" data="data:application/x-silverlight-2" type="application/x-silverlight-2" width="385px" height="300px">
							<param name="source" value="<%=SilverLightServer%>/ClientBin/BoardPlayer.xap"/>
							<param name="background" value="white" />
							<param name="initParams" value="mediaSource=http://<%=request.getServerName()%>/upload/board_list/<%=String.valueOf(v_bl.elementAt(7)).trim()%>" />
							<param name="enablehtmlaccess" value="true"/>
							<a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;">
							<img src="http://go2.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none"/> </a>
							</object>
							</textarea>
						<script type="text/javascript" language="javascript">
							mplayer('mplayer2');  // embed 테두리 제거 ( textarea 로 감싼후 인클루드한 스크립터 파일에서 getElementById()를 한다.
						</script></div>
						</td>
					</tr>
                    
					<tr>
						<th class="bor_bottom01"><strong>내용</strong></th>
						<td class="bor_bottom01 pa_left">
							<textarea name="list_contents"  id="list_contents" class="input01" style="width:570px;height:100px;" cols="100" rows="100"><%=v_bl.elementAt(5)%></textarea></td>
					</tr>
					 
					<tr>
						<th class="bor_bottom01"><strong>비밀번호</strong></th>
						<td class="bor_bottom01 pa_left"><input type="password" name="list_passwd" maxlength="12" value="" class="input01" style="width:150px;"/></td>
					</tr>
				</tbody>
				</form>
				</table>
				<div class="but01">
				<a href="mng_boardListList.jsp?board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>" title="목록"><img src="/vodman/include/images/but_list.gif" alt="목록"/></a>
					<a href="javascript:updateListBoard();" title="저장"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="javascript:updateForm.reset();" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>	
			<%@ include file="/vodman/include/footer.jsp"%>