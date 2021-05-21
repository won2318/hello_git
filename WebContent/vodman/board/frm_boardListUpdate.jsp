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
		if(request.getParameter("board_id")  != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null")){
			board_id  = Integer.parseInt(request.getParameter("board_id") );
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
			
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}
	}catch(Exception e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0901";
		}
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
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0901";
		}
		String REF_URL="mng_boardList.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	
	try{
		if(request.getParameter("list_id")  != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null")){
			list_id  = Integer.parseInt(request.getParameter("list_id") );
		}else{
			String mcode= request.getParameter("mcode");
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode;
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
		String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode;
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
	String view_comment = "";
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
		board_security = String.valueOf(v_bi.elementAt(15));
		view_comment = String.valueOf(v_bi.elementAt(13));
	}else{
		String mcode= request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0901";
		}
		String REF_URL="mng_boardList.jsp?mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

 
	String title_4 = "";
	String content_5="";
	String html_15= "";
	String link_9 = "";
	String attach_7 = "";
	String img_8 = "";
	String img_17 = "";
	String img_desc_17_20 = "";
	String img_18 = "";
	String img_desc_18_21 = "";
	String email_6="";
	String name_3="";
	String open_22 = "";
	String open_space_23 = "";
	String img_desc_8_19 = "";
 
	String list_date="";
	String list_security = "";	
	String list_pwd = "";
	String org_attach_name  = "";
 	
	String rsdate ="";
	String redate = "";
	Vector vt_result = BoardListSQLBean.getBoardList_admin(list_id+"");
	
	String image_text8 = "";
	if(vt_result != null && vt_result.size() > 0)
	{
		Hashtable ht_list = (Hashtable)vt_result.get(0);
		
		title_4 = (String.valueOf(ht_list.get("list_title")));
		content_5 = (String.valueOf(ht_list.get("list_contents")));
		link_9 = (String.valueOf(ht_list.get("list_link")));
		name_3 = (String.valueOf(ht_list.get("list_name")));
		list_date = (String.valueOf(ht_list.get("list_date")));
		attach_7 = (String.valueOf(ht_list.get("list_data_file")));
		
		
		img_8 = (String.valueOf(ht_list.get("list_image_file")));
		img_desc_8_19  = (String.valueOf(ht_list.get("image_text")));
		img_17 = (String.valueOf(ht_list.get("list_image_file2")));
		img_desc_17_20 = (String.valueOf(ht_list.get("image_text2")));
		img_18 = (String.valueOf(ht_list.get("list_image_file3")));
		img_desc_18_21 = (String.valueOf(ht_list.get("image_text3")));
		
		
		email_6 = (String.valueOf(ht_list.get("email")));
		open_22 = (String.valueOf(ht_list.get("list_open")));
		open_space_23 = (String.valueOf(ht_list.get("open_space")));
		
		try{
			list_date = list_date.substring(0, 10);
		}catch(Exception e){list_date = "";}
		 
		list_security = String.valueOf(ht_list.get("list_security"));
		list_pwd = (String.valueOf(ht_list.get("list_passwd")));
		org_attach_name = (String.valueOf(ht_list.get("org_attach_name")));
 
		rsdate =(String.valueOf(ht_list.get("rsdate")));
		redate = (String.valueOf(ht_list.get("redate")));
		image_text8 = (String.valueOf(ht_list.get("image_text8")));
	}
	else
	{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}

%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script type="text/javascript" src="/vodman/editer_2/js/HuskyEZCreator.js" charset="utf-8"></script>

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
var splitFilter = new Array("시팔","씨팔","쌍놈","쌍년","개년","개놈","개새끼","니미럴","개같은년","개같은놈","니기미","존나","좃나","십새끼","script" );
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
	for (var ii = 0 ;ii < splitFilter.length; ii++ )
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


	function updateListBoard(){
		var f = document.updateForm;

		
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
 


		f.action='proc_boardListUpdate.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>';
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
	
	function list_open_function(cObject) {
		if(confirm('공개여부를 변경하시겠습니까?')) {
			var flag = cObject.options[cObject.selectedIndex].value;
			 document.getElementById("list_open").value=flag;		
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
		location.href="mng_boardListList.jsp?board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>";
	}
		
	
</script>
	
		<!-- 컨텐츠 -->
		<div id="contents" >
			<h3><span><%=board_title%></span></h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; 게시판 정보 &gt; <span><%=board_title%></span></p>
			<div id="content">
				<!-- 내용 -->
				<form name='updateForm' method='post' enctype="multipart/form-data" >
				<input type="hidden" name="dumy" value=''>
				<input type="hidden" name="board_id" value='<%=board_id%>'>
				<input type="hidden" name="list_id" value="<%=list_id%>">
				<input type="hidden" id="list_open" name="list_open" value='<%=open_22%>'>
				
				<div class="boardWrite">
				<dl>
					<dt><label for="list_name2">작성자</label></dt>
					<dd><%=name_3%><input name="list_name" type="hidden"  id="list_name2" value='<%=name_3%>' class="input01" style="width:150px;" readonly="readonly" /></dd>
				</dl>
				<dl>
					<dt><label for="list_title2">제목</label></dt>
					<dd><input name="list_title" type="text" maxlength="200" id="list_title2" value='<%=title_4%>' class="input01" style="width:300px;" onkeyup="checkLength(this,200)" /></dd>
				</dl>
				<dl>
					<dt><label for="list_email">이메일주소</label></dt>
					<dd><input type="text" name="list_email" id="list_email" maxlength="50" value="" class="input01" style="width:300px;ime-mode:disabled;"/></dd>
				</dl>
				<dl>
					<dt><label for="list_security">공개구분 </label></dt>
					<dd><select name="f_level" class="sec01" style="width:80px;"  onChange="return list_open_function(this)">
								<option value="">공개구분</option>
								<option value="Y"  <%=(open_22 != null && open_22.length()>0 && open_22.equals("Y")) ? "selected" : ""%>>- 공개</option>
								<option value="N"  <%=(open_22 != null && open_22.length()>0 && open_22.equals("N")) ? "selected" : ""%>>- 비공개</option>
							</select></dd>
				</dl>
				<%
				if(board_security != null && board_security.equals("t")){
				%>
				<dl>
					<dt><label for="list_security">비밀글 여부 </label></dt>
					<dd><select name="list_security" class="sec01" style="width:80px;" >
								<option value="">비밀글 여부</option>
								<option value="Y"  <%=(list_security != null && list_security.equals("Y")) ? "selected" : ""%>>- 비밀글</option>
								<option value="N"  <%=(list_security != null && list_security.equals("N")) ? "selected" : ""%>>- 공개글</option>
							</select></dd>
				</dl>
				<%}else{ %>
				<input type="hidden" name="list_security" value='N' >
				<%} %>
				<%if(board_link_flag.equals("t")){%>
				<dl>
					<dt><label for="list_link2">주소링크</label></dt>
					<dd><input name="list_link" type="text" id="list_link2" maxlength="200" value='<%=link_9%>' class="input01" style="width:300px;" onkeyup="checkLength(this,200)"/></dd>
				</dl>
				<% } %>
				
				 <% if (board_id == 22) { %>
				 <dl>
				 	<dt><label for="image_text8" class="image_text8">구분</label>
				 	</dt>
				 	<dd><input type="radio" name="image_text8" value="V" <% if (image_text8 != null && image_text8.equals("V")) out.print("checked='checked'"); %> />영상(수원iTV)
							&nbsp;<input type="radio" name="image_text8" value="N" <% if (image_text8 != null && image_text8.equals("N")) out.print("checked='checked'"); %> />기사(e수원뉴스)
				 	</dd>
				 </dl> 
				 <%} %>
				<dl>
					<dt><label for="list_contents">내용</label></dt>
					<dd><input name="list_html_use" type="hidden"  value="t" /> 
					<input name="open_space" type="checkbox" id="open_space" value="Y" <%=String.valueOf(open_space_23).equals("Y")?"checked":""%> />&nbsp;공지사항 등록시 체크하세요!  &nbsp;&nbsp;
				<strong>공지기간</strong>
				시작일: <input type="text" name="rsdate" value="<%=rsdate %>" class="input01" style="width:80px;"   maxlength="10" readonly="readonly" /></input>
				<a href="javascript:openCalendarWindow(document.updateForm.rsdate)" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>&nbsp;~&nbsp;
				종료일:<input type="text" name="redate" value="<%=redate %>" class="input01" style="width:80px;"   maxlength="10"  readonly="readonly" />
				<a href="javascript:openCalendarWindow(document.updateForm.redate)" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
			<br/>
							<textarea name="list_contents"  id="list_contents" class="input01" style="width:570px;height:220px;" cols="100" rows="100" onkeyup="checkLength(this,2000)" ><%=content_5%></textarea>
 
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
	
					</dd>
				</dl>
				<%if(board_file_flag.equals("t")){%>
				<dl>
					<dt><label for="list_data_file2">첨부파일</label></dt>
					<dd><input type="file" name="list_data_file" id="list_data_file2"  class="input03" size="30" value="" onchange="javascript:limitFile('list_data_file')" />
						<input name="_list_data_file" type="hidden" value='<%=attach_7%>'>
                                            <%if(String.valueOf(attach_7).indexOf(".") != -1){%> &nbsp;&nbsp;&nbsp;삭제 <input type="checkbox" id='list_data_del' name='list_data_del' value='Y'/><%if (org_attach_name != null && org_attach_name.length() > 0) {out.println(org_attach_name);} else {out.println(attach_7);}%> <br/> <%}%>
					</dd>
				</dl>
				<% } %>
<%
	if(board_image_flag.equals("t")){

%>
				<dl id="imageList">
					<dt><label for="list_image_file">이미지파일1</label></dt>
					<dd>
						<input type="file" name="list_image_file" id="list_image_file" class="input03" size="30" value="" onchange="javascript:limitFile('list_image_file')"  onkeyup="checkLength(this,2000)" /><input name="_list_image_file" type="hidden" value='<%=String.valueOf(img_8)%>'>
						<%if(String.valueOf(img_8).indexOf(".") != -1){%> 
						&nbsp;&nbsp;&nbsp;삭제 <input type='checkbox' id='list_image_del' name='list_image_del' value='Y' /><%=String.valueOf(img_8)%> <br/><%}%>
						
						<textarea id="image_text" name="image_text" class="input02" style="width:570px;height:30px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"><%=String.valueOf(img_desc_8_19)%></textarea>
						<span id="imageBtn"><a href="javascript:addImage(1);" title="추가"><img src="/vodman/include/images/but_plus.gif" alt="추가" class="pa_bottom"/></a></span>
						
					</dd>
				</dl>
				<dl id="imageList_2" style="<%if(String.valueOf(img_17).indexOf(".") != -1){%>display:block;<%} else {%>display:none;<%}%>">
					<dt><label for="list_image_file2">이미지파일2</label></dt>
					<dd>
						<input type="file" name="list_image_file2" id="list_image_file2" class="input03" size="30" value="" onchange="javascript:limitFile('list_image_file2')" /><input name="_list_image_file2" type="hidden" value='<%=String.valueOf(img_17)%>'>
						<%if(String.valueOf(img_17).indexOf(".") != -1){%> 
						&nbsp;&nbsp;&nbsp;삭제 <input type='checkbox' id='list_image_del2' name='list_image_del2' value='Y' /><%=String.valueOf(img_17)%> <br/><%}%>
						
						<textarea id="image_text2" name="image_text2" class="input02" style="width:570px;height:30px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"><%=String.valueOf(img_desc_17_20)%></textarea>
						<span id="imageBtn2"><a href="javascript:addImage(2);" title="추가"><img src="/vodman/include/images/but_plus.gif" alt="추가" class="pa_bottom"/></a></span>
						<a href="javascript:dropImage('imageList_2',2);"><img src="/vodman/include/images/but_del.gif"  class="pa_bottom" /></a>
						
					</dd>
				</dl>
				<dl id="imageList_3" style="<%if(String.valueOf(img_18).indexOf(".") != -1){%>display:block;<%} else {%>display:none;<%}%>">
					<dt><label for="list_image_file3">이미지파일3</label></dt>
					<dd>
						<input type="file" name="list_image_file3" id="list_image_file3" class="input03" size="30" value="" onchange="javascript:limitFile('list_image_file3')" /><input name="_list_image_file3" type="hidden" value='<%=String.valueOf(img_18)%>'><%if(String.valueOf(img_18).indexOf(".") != -1){%> 
						&nbsp;&nbsp;&nbsp;삭제 <input type='checkbox' id='list_image_del3' name='list_image_del3' value='Y' /><%=String.valueOf(img_18)%> <br/><%}%>
						
						<textarea id="image_text3" name="image_text3" class="input02" style="width:570px;height:30px;" cols="100" rows="100" onkeyup="checkLength(this,2000)"><%=String.valueOf(img_desc_18_21)%></textarea>
		 
						<a href="javascript:dropImage('imageList_3',3);"><img src="/vodman/include/images/but_del.gif"  class="pa_bottom" /></a>
							
					</dd>
				</dl>
 


<%}%>
				<dl>
					<dt><label for="list_passwd">비밀번호</label></dt>
					<dd><input type="password" name="list_passwd" id="list_passwd" maxlength="12" value="" class="input01" style="width:150px;"/></dd>
				</dl>
				</div>
				</form>
				
				<div class="but01">
					<a href="#" onclick="go_list(); return false; " title="목록"><img src="/vodman/include/images/but_list.gif" alt="목록"/></a>
					<a href="#" onclick="updateListBoard(); return false;" title="저장"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="#" onclick="go_list(); return false;" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>	
			<%@ include file="/vodman/include/footer.jsp"%>