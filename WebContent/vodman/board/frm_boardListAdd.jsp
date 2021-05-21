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
	try{
		if(request.getParameter("board_id")  != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null")){
			board_id  = Integer.parseInt(request.getParameter("board_id") );
		}else{
			String mcode= request.getParameter("mcode");
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardList.jsp?mcode="+mcode;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}
	}catch(Exception e){
		String mcode= request.getParameter("mcode");
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardList.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	
	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		String mcode= request.getParameter("mcode");
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
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
	String board_security = "";
	String flag = "";
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
		flag = String.valueOf(v_bi.elementAt(12));
		board_security = String.valueOf(v_bi.elementAt(15));

	}else{
		String mcode= request.getParameter("mcode");
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		 String REF_URL="mng_boardList.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}


	String list_open = "Y";
	if (flag != null && flag.equals("V")) {
		list_open = "N";
	} else {
		list_open = "Y";
	}

%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script type="text/javascript" src="/vodman/editer_2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script language='javascript'>

function limitFile_WMV()
{
	 var file = null;

		  file = document.frmBoard.list_data_file.value;

	  extArray = new Array(".wmv",".avi",".mpeg",".asf");
	  allowSubmit = true;

	  while (file.indexOf("\\") != -1) {
	   file = file.slice(file.indexOf("\\") + 1);
	   ext = file.slice(file.lastIndexOf(".")).toLowerCase();

		   for (var i = 0; i < extArray.length; i++) {
				if (extArray[i] == ext) {
				 allowSubmit = false;
				 break;
				}
		   }
	  }

	  if (allowSubmit){

	   alert("입력하신 파일은 업로드 될 수 없습니다!");
			document.frmBoard.list_data_file.outerHTML = document.frmBoard.list_data_file.outerHTML;
	   return;
	  }

	  if (file != null) {
//		    java.io.File ff = new java.io.File(document.frmBoard.list_data_file.value);

//		img_Load(file);  // 파일사이즈 체크
	  }
}




	function img_Load()
	{
	    var imgSrc, imgFileSize;
	    var maxFileSize;


		var img = new Image();
		img.src = document.frmBoard.list_data_file.value;
		imgFileSize =img.fileSize;

	    maxFileSize = 1048576;

	    if (imgFileSize > maxFileSize)
	    {
	        alert('선택하신 파일은 허용 최대크기인 ' + maxFileSize/1024 + ' KB 를 초과하였습니다.');
			document.frmBoard.list_data_file.outerHTML = document.frmBoard.list_data_file.outerHTML;
	        return;
	    }

	}

	 


	function limitFile(object) {
		var file_flag = object.name;
		var file_name = object.value;
	
		document.getElementById('fileFrame').src = "file_check.jsp?file_flag="+file_flag+"&file_name=" + file_name;
	}
	
	function clearFile(file_flag) {
		var file_ = document.getElementById(file_flag);
		var file_new = document.getElementById(file_flag);
		if(file_ && file_new){
			file_.outerHTML = file_new.outerHTML;
		}
	}
	<%
	FucksInfoManager mgr = FucksInfoManager.getInstance();
    Hashtable result_ht = null;
    result_ht = mgr.getAllFucks_admin("");
    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
	int totalArticle =0; //총 레코드 갯수
	int totalPage = 0 ; //
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(1);
				totalArticle = pageBean.getTotalRecord();
		        totalPage = pageBean.getTotalPage();
	        }
		}
    }
	%>
	var rgExp;
	<%
	if(totalPage >0 ){
	%>
	var splitFilter = new Array("script",<%=totalPage%>);
	<%
	}else{%>
	var splitFilter = new Array("시팔","씨팔","쌍놈","쌍년","개년","개놈","개새끼","니미럴","개같은년","개같은놈","니기미","존나","좃나","십새끼","script");
	<%
	}
	%>
	<%
	if(vt != null && vt.size()>0){
		int list = 0;
		FuckInfoBean linfo = new FuckInfoBean();
		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
			  com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)vt.elementAt(list));
			  %>
			  splitFilter[<%=i%>] = '<%=linfo.getFucks()%>';
			  <%
		}
	}
	%>
	function filterIng(str , element , id){  
		for (var ii = 0 ;ii < splitFilter.length ; ii++ )
		{
			rgExp = splitFilter[ii];
			if (str.match(rgExp))
			{
				alert(rgExp + "은(는) 불량단어로 입력하실수 없습니다");
				var range = document.getElementsByName(id)[0].createTextRange();
				range.findText(rgExp);
				range.select();
				return false;
			}
		}
	}


	 
	function insertListBoard(){
		
		var f = document.frmBoard;

				
		if (f.list_title.value=="") {
		   alert ("제목을 입력하지 않으셨습니다.")
		   f.list_title.focus();
		   return
		}
		
// 		if(filterIng(f.list_title.value, f.list_title,"list_title") == false){
// 			return;
// 		}
		//oEditors.getById["list_contents"].exec("UPDATE_IR_FIELD", []);
		oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("list_contents").value를 이용해서 처리하면 됩니다.
		if (f.list_contents.value=="") {
		   alert ("내용을 입력하지 않으셨습니다.")
		   f.list_contents.focus();
		   return
		}
// 		if(filterIng(f.list_contents.value, f.list_contents,"list_contents") == false){
// 			return;
// 		}
		if (f.list_passwd.value =="") {
			   alert ("비밀번호를 입력하지 않으셨습니다.")
			   f.list_passwd.focus();
			   return;
		}else if(!pwCheck(f.list_passwd.value)){
				f.list_passwd.focus();
				alert("영문+숫자를 최소 한자 이상씩 조합한 4자 이상 12자 이내로 입력하시기 바랍니다.");
				return;
		}
		

		f.action="proc_boardListAdd.jsp?board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>";
		f.submit();

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
		document.getElementById('list_image_file'+num).outerHTML = document.getElementById('list_image_file'+num).outerHTML;;
		document.getElementById('image_text'+num).text = "";
		document.getElementById(objName).style.display = "none";

		num = num -1;
		if(num == 1) {
			document.getElementById("imageBtn").style.visibility = "visible";
		} else {
			document.getElementById("imageBtn"+num).style.visibility = "visible";
		}
	}

//////////////////////////////////////////////////////
	//달력 open window event 
	//////////////////////////////////////////////////////
	
	var calendar=null;
	
	/*날짜 hidden Type 요소*/
	var dateField;
	
	/*날짜 text Type 요소*/
	var dateField2;
	
	function openCalendarWindow(elem) 
	{
		dateField = elem;
		dateField2 = elem;
	
		if (!calendar) {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		} else if (!calendar.closed) {
			calendar.focus();
		} else {
			calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
		}
	}
		
	function go_list(){
		 location.href="mng_boardListList.jsp?board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>"
	}

</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span><%=board_title%></span></h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; 게시판 정보 &gt; <span><%=board_title%></span></p>
			<div id="content">
				<!-- 내용 -->
				 <form name='frmBoard' method='post' enctype='multipart/form-data'>
                                        <input type=hidden name=dumy value=''>
                                        <input type=hidden name=board_id value='<%=board_id%>'>
										<input type=hidden name=list_open value='<%=list_open%>'>
				<div class="boardWrite">
				<dl>
					<dt><label for="list_name">작성자</label></dt>
					<dd><%=vod_name%><input type="hidden" name="list_name" id="list_name" class="input01" style="width:150px;" value="<%=vod_name%>" readonly="readonly" /></dd>
				</dl>
				<dl>
					<dt><label for="list_title">제목</label></dt>
					<dd><input type="text" name="list_title" id="list_title" maxlength="200" value="" class="input01" style="width:300px;"  onkeyup="checkLength(this,200)" /></dd>
				</dl>
				<dl>
					<dt><label for="list_email">이메일주소</label></dt>
					<dd><input type="text" name="list_email" id="list_email" maxlength="50" value="" class="input01" style="width:300px;ime-mode:disabled;"/></dd>
				</dl>
				<%
				if(board_security != null && board_security.equals("t")){
				%>
				<dl>
					<dt><label for="list_security">비밀글 여부 </label></dt>
					<dd><select name="list_security" class="sec01" style="width:80px;" >
								<option value="Y"> 비밀글</option>
								<option value="N" selected="selected"> 공개글</option>
							</select></dd>
				</dl>
				<%
				}else{
				%>
				<input type="hidden" name="list_security" value='N' >
				<%} %>
				<%if(board_link_flag.equals("t")){%>
				<dl>
					<dt><label for="list_link">주소링크</label></dt>
					<dd><input type="text" name="list_link" id="list_link" maxlength="200" value="" class="input01" style="width:300px;" onkeyup="checkLength(this,200)"/></dd>
				</dl>
				<% } %>
				<dl>
					<dt><label for="list_contents">내용</label></dt>
					<dd><input name="list_html_use" id="list_html_use" type="hidden" value="t" checked="checked" />
					<input name="open_space" type="checkbox" id="open_space" value="Y" />&nbsp;공지사항 등록시 체크하세요!  &nbsp;&nbsp;
					<strong>공지기간</strong>
				시작일: <input type="text" name="rsdate" value="" class="input01" style="width:80px;"   maxlength="10" readonly="readonly" /></input>
				<a href="javascript:openCalendarWindow(document.frmBoard.rsdate)" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>&nbsp;~&nbsp;
				종료일:<input type="text" name="redate" value="" class="input01" style="width:80px;"   maxlength="10"  readonly="readonly" />
				<a href="javascript:openCalendarWindow(document.frmBoard.redate)" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
						<% if (flag != null && flag.equals("V")) { %>&nbsp;&nbsp;&nbsp;※ 관리자는 25M 이하만 등록 가능합니다!<% }%>
						<br/>
						<textarea id="list_contents" name="list_contents" class="input01" style="width:630px;height:220px;" cols="100" rows="100" onkeyup="checkLength(this,2000)" ></textarea>
	<script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "list_contents",
		    sSkinURI: "/vodman/editer_2/SmartEditor2Skin.html",
		    fCreator: "createSEditor2"
		});
 
		function insertIMG(qnacontent,filename){ 
	       var sHTML = "<img src='"+qnacontent+"/"+filename+"' alt='"+filename+"' />"; 
	        oEditors.getById["list_contents"].exec("PASTE_HTML", [sHTML]); 
		} 
	</script>					
		<!-- editer/popup/quick_photo/ FileUploader_html5.php, QuickPhotoPopup.js, FileUploader.jsp 경로 수정 -->	
					</dd>
				</dl>
				<%if(board_file_flag.equals("t")){
					if (flag != null && flag.equals("V")) { // 영상파일 WMV
				%>
				<dl>
					<dt><label for="list_data_file">동영상파일</label></dt>
					<dd><input name="list_data_file" id="list_data_file" type="file" class="input03" size="30" value=""  onchange="javascript:limitFile_WMV();"></dd>
				</dl>
				<% } else { %>
				<dl>
					<dt><label for="list_data_file2">첨부파일</label></dt>
					<dd><input name="list_data_file" id="list_data_file2" type="file" class="input03" size="30" value=""  onchange="javascript:limitFile(this)"></dd>
				</dl>
				<%}
						}%>
					<%
					if(board_image_flag.equals("t")){
						for(int i=1; i <=10; i++) {
							if(i == 1) {
				%>
				<dl id="imageList" style="display:block">
					<dt><label for="list_image_file<%=i%>">이미지파일</label></dt>
					<dd>
						<input type="file" name="list_image_file" id="list_image_file" class="input03" size="30" value="" onchange="javascript:limitFile(this)"/>&nbsp;&nbsp;&nbsp;
						<% if (flag != null && !flag.equals("V")) { // 영상파일 WMV %>
						</br>  

						<textarea name="image_text" id="image_text" class="input02" style="width:570px;height:30px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"></textarea>
						<span id="imageBtn"><a href="javascript:addImage(1);" title="추가"><img src="/vodman/include/images/but_plus.gif" alt="추가" class="pa_bottom"/></a></span>
						<% }%>
					</dd>
				</dl>
				<%
				} else {
					 if (flag != null && !flag.equals("V")) { // 영상파일 WMV %>
				<dl id="imageList_<%=i%>" style="display:none">
					<dt><label for="list_image_file<%=i%>">이미지파일</label></dt>
					<dd>
						<input type="file" name="list_image_file<%=i%>" id="list_image_file<%=i%>" class="input03" size="30" value="" onchange="javascript:limitFile(this)"/>&nbsp;&nbsp;&nbsp;
						
						</br>
						<textarea name="image_text<%=i%>" id="image_text<%=i%>" class="input02" style="width:570px;height:30px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"></textarea>
						<%if(i < 10) {%><span id="imageBtn<%=i%>"><a href="javascript:addImage(<%=i%>);" title="추가"><img src="/vodman/include/images/but_plus.gif" alt="추가" class="pa_bottom"/></a></span><%}%>
						<a href="javascript:dropImage('imageList_<%=i%>',<%=i%>);" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제" class="pa_bottom"/></a>
						
					</dd>
				</dl>
				<%
					}
			}
		}
	}
%>		
				<dl>
					<dt><label for="list_passwd">비밀번호</label></dt>
					<dd><input type="password" name="list_passwd" id="list_passwd" maxlength="12" value="" class="input01" style="width:150px;"/></dd>
				</dl>
				</div>
				</form>
				
				<div class="but01">
					<a href="#" onclick="go_list(); return false; " title="목록"><img src="/vodman/include/images/but_list.gif" alt="목록"/></a>
					<a href="#" onclick="insertListBoard(); return false;" title="저장"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="#" onclick="go_list(); return false;" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>	
<IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0"></IFRAME>
<iframe id="fileFrame" name="fileFrame" src="#" width="0" height="0" cellpadding="0" cellspacing="0" border="0"></iframe>

<%@ include file="/vodman/include/footer.jsp"%>
