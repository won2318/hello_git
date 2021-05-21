<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.security.*" %>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>

<%@ include file="/include/chkLogin.jsp"%>
<%
   request.setCharacterEncoding("EUC-KR");
contact.setPage_cnn_cnt("M"); // 페이지 접속 카운트 증가
	String ccode="";
	int board_id = 10;
	if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
	{
		 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
 	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.1')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
		return;
	}
	
	int list_id = 0;
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0  && !request.getParameter("list_id").equals("null") &&  com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id")))
	{
		list_id = Integer.parseInt(TextUtil.nvl(request.getParameter("list_id")));
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.2')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
		return;
	}
	
	

	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
		return;
	}

	String board_title = "";
	String board_page_line = "10";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	//String flag = "";
	String board_security ="";
 
	String veiw_comment = "";
 //board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag,  
 //board_user_flag, board_top_comments, board_footer_comments, board_priority, board_auth_list, 
 //board_auth_read, board_auth_write, flag, view_comment, board_ccode , 
 //board_security_flag 
int board_auth_write = 0;
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
		//flag = String.valueOf(v_bi.elementAt(12));
	 
		veiw_comment = String.valueOf(v_bi.elementAt(13));
		board_security = String.valueOf(v_bi.elementAt(15));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));
		
	}
 
	String list_title = "";
	String list_contents = "";
	String list_name = "";
	String list_date = "";
	String list_link = "";
	String list_read_count="";
	
	String list_image_file = "";
	String list_image_file2 = "";
	String list_image_file3 = "";
	String list_image_file4 = "";
	String list_image_file5 = "";
	String list_image_file6 = "";
	String list_image_file7 = "";
	String list_image_file8 = "";
	String list_image_file9 = "";
	String list_image_file10 = "";
	
	String image_text = "";
	String image_text2 = "";
	String image_text3 = "";
	String image_text4 = "";
	String image_text5 = "";
	String image_text6 = "";
	String image_text7 = "";
	String image_text8 = "";
	String image_text9 = "";
	String image_text10 = "";
	String list_security = "";  
	String list_open="";
	String list_data_file = "";
	
	String list_pwd = "";
	String org_attach_name = "";
	//String thumb = "/upload/board_list/img_middle/";
	String thumb = "/upload/board_list/";
	Vector vt_result = blsBean.getBoardList_view(list_id+"");
	if(vt_result != null && vt_result.size() > 0)
	{
		Hashtable ht_list = (Hashtable)vt_result.get(0);
		
		list_title = TextUtil.nvl(String.valueOf(ht_list.get("list_title")));
		list_contents = TextUtil.nvl(String.valueOf(ht_list.get("list_contents")));
		list_link = TextUtil.nvl(String.valueOf(ht_list.get("list_link")));
		list_name = TextUtil.nvl(String.valueOf(ht_list.get("list_name")));
		list_date = TextUtil.nvl(String.valueOf(ht_list.get("list_date")));
		list_data_file = TextUtil.nvl(String.valueOf(ht_list.get("list_data_file")));
		try{
			list_date = list_date.substring(0, 10);
		}catch(Exception e){list_date = "";}
		list_read_count =  TextUtil.nvl(String.valueOf(ht_list.get("list_read_count")));
		list_image_file = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file")));
		list_image_file = java.net.URLEncoder.encode(list_image_file, "EUC-KR");
		list_image_file = list_image_file.replace("+","%20");
		list_image_file2 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file2")));
		list_image_file2 = java.net.URLEncoder.encode(list_image_file2, "EUC-KR");
		list_image_file2 = list_image_file2.replace("+","%20");
		list_image_file3 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file3")));
		list_image_file3 = java.net.URLEncoder.encode(list_image_file3, "EUC-KR");
		list_image_file3 = list_image_file3.replace("+","%20");
		list_image_file4 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file4")));
		list_image_file4 = java.net.URLEncoder.encode(list_image_file4, "EUC-KR");
		list_image_file4 = list_image_file4.replace("+","%20");
		list_image_file5 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file5")));
		list_image_file5 = java.net.URLEncoder.encode(list_image_file5, "EUC-KR");
		list_image_file5 = list_image_file5.replace("+","%20");
		list_image_file6 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file6")));
		list_image_file6 = java.net.URLEncoder.encode(list_image_file6, "EUC-KR");
		list_image_file6 = list_image_file6.replace("+","%20");
		list_image_file7 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file7")));
		list_image_file7 = java.net.URLEncoder.encode(list_image_file7, "EUC-KR");
		list_image_file7 = list_image_file7.replace("+","%20");
		list_image_file8 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file8")));
		list_image_file8 = java.net.URLEncoder.encode(list_image_file8, "EUC-KR");
		list_image_file8 = list_image_file8.replace("+","%20");
		list_image_file9 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file9")));
		list_image_file9 = java.net.URLEncoder.encode(list_image_file9, "EUC-KR");
		list_image_file9 = list_image_file9.replace("+","%20");
		list_image_file10 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file10")));
		list_image_file10 = java.net.URLEncoder.encode(list_image_file10, "EUC-KR");
		list_image_file10 = list_image_file10.replace("+","%20");
		
		image_text = TextUtil.nvl(String.valueOf(ht_list.get("image_text")));
		image_text2 = TextUtil.nvl(String.valueOf(ht_list.get("image_text2")));
		image_text3 = TextUtil.nvl(String.valueOf(ht_list.get("image_text3")));
		image_text4 = TextUtil.nvl(String.valueOf(ht_list.get("image_text4")));
		image_text5 = TextUtil.nvl(String.valueOf(ht_list.get("image_text5")));
		image_text6 = TextUtil.nvl(String.valueOf(ht_list.get("image_text6")));
		image_text7 = TextUtil.nvl(String.valueOf(ht_list.get("image_text7")));
		image_text8 = TextUtil.nvl(String.valueOf(ht_list.get("image_text8")));
		image_text9 = TextUtil.nvl(String.valueOf(ht_list.get("image_text9")));
		image_text10 = TextUtil.nvl(String.valueOf(ht_list.get("image_text10")));
		list_security = TextUtil.nvl(String.valueOf(ht_list.get("list_security")));
		list_open = TextUtil.nvl(String.valueOf(ht_list.get("list_open")));
		list_pwd = TextUtil.nvl(String.valueOf(ht_list.get("list_passwd"))).trim();
		
		org_attach_name = TextUtil.nvl(String.valueOf(ht_list.get("org_attach_name")));
		
		try{
			blsBean.updateCount(board_id, list_id);
		}catch(Exception e) {
			System.out.println("update count error");
		}
	}
	else
	{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
 
	int pg = NumberUtils.toInt(request.getParameter("page"), 1); 
	int event_seq = NumberUtils.toInt(request.getParameter("event_seq"), 0);
	 
 	if (session.getValue("list_passwd") != null && session.getValue("list_passwd").toString().equals(list_pwd)) {
	} else if (user_key != null && user_key.equals(list_pwd)) {
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('정보가 일치 하지 않습니다. 이전 페이지로 돌아갑니다2.')"); 
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
%> 

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0. user-scalable=no," />
	<title>수원iTV</title>
	<link rel="stylesheet" type="text/css" href="../include/css/default.css">
	<script type="text/javascript" src="../include/js/script2.js"></script>
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
 
 
<script language='javascript'>
 
function limitFile(object) {
		var file_flag = object.name;
		var file_name = object.value;
	
		document.getElementById('fileFrame').src = "file_check.jsp?file_flag="+file_flag+"&file_name=" + file_name;
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

 
	
	function clearFile(file_flag) {
		document.getElementById(file_flag).outerHTML = document.getElementById(file_flag).outerHTML;
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
	var splitFilter = new Array(<%=totalPage%>);
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
		if(!CheckText(f.list_title)){
			return;
		}
		if(filterIng(f.list_title.value, f.list_title,"list_title") == false){
			return;
		}
		if (f.list_contents.value=="") {
		   alert ("내용을 입력하지 않으셨습니다.")
		   f.list_contents.focus();
		   return
		}
		if(filterIng(f.list_contents.value, f.list_contents,"list_contents") == false){
			return;
		}

<% if (board_auth_write == 0) { %>
		if (f.list_passwd.value =="") {
			   alert ("비밀번호를 입력하세요.")
			   f.list_passwd.focus();
	    		   return;
		}else if(!pwCheck(f.list_passwd.value)){
				f.list_passwd.focus();
				alert("영문+숫자+특수 문자를 적어도 하나 이상씩 조합한 8자 이상, 12자 이내로 입력하시기 바랍니다.");
				return;
		}
		f.action="proc_boardListUpdate.jsp?board_id=<%=board_id%>&page=<%=pg%>&list_id=<%=list_id%>&list_passwd="+document.getElementById("list_passwd").value;
<%} else {%>
		f.action="proc_boardListUpdate.jsp?board_id=<%=board_id%>&page=<%=pg%>&list_id=<%=list_id%>";
<%} %>
// 		var chk_word2 = "";
// 		chk_word2 = document.getElementById("chk_word2");
		
// 		if(chk_word2.value == ""){
// 			alert('확인 문자열을 입력하십시오.');
// 			f.chk_word.focus();
// 			return;
// 		}

		
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

function chk_word_func(){
 		document.getElementById("chk_word2").value = document.getElementById("chk_word").value;
	}

function board_delete(){

	 if (confirm("삭제하시겠습니까")) {
			top.location.href="proc_boardListDelete.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>"; 
			
		}
}
</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
</noscript>
</head>
<body>


<div id="container"  > 
	<div class="major"  > 
	
	<section>
		<div class="vodView">
		 <form name='frmBoard' method='post' enctype='multipart/form-data'>
				<input type="hidden" name="list_id" value='<%=list_id%>' />
				<input type="hidden" name="board_id" value='<%=board_id%>' />
				<input type="hidden" name="list_open" value='<%=list_open%>' />
			 	<input type="hidden" name="event_seq" value='<%=event_seq%>' />
				
			<div class="topTitle"><h3>글쓰기</h3> <a href="javascript:history.back();" data-rel="back" data-role="button" ><img src="../include/images/icon_close.png" width="23" height="23" alt="이전화면" /></a></div>
			<div class="boardWrite">
				<dl>
					<dt><label for="list_title">제목</label></dt>
					<dd><input type="text" name="list_title" value="<%=list_title %>" id="list_title"  title="제목"/></dd>
				</dl>
				<dl>
					<dt><label for="list_name">작성자</label></dt>
					<dd><input type="text" name="list_name" value="<%=list_name %>" id="list_name" title="작성자"/></dd>
				</dl>
				 <%if(board_security != null && board_security.equals("t")){ %>
					<dl>
						<dt><label for="list_security">비밀글</label></dt>
						<dd><input type="checkbox" name="list_security" value="Y" <%if (list_security != null && list_security.equals("Y")) {out.println("checked");} %>title="비밀글"/> * 비밀글 작성시 관리자만 확인이 가능합니다!</dd>
					</dl>
				<%} %>
				<dl>
					<dt><label for="list_contents" class="detail">내용</label></dt>
					<dd><textarea name="list_contents" rows="15" id="list_contents" title="내용"><%=list_contents %></textarea></dd>
				</dl>
				<%if(board_file_flag.equals("t")){%>
				<dl>
					<dt><label for="list_data_file">첨부</label></dt>
					<dd><input type="file" id="list_data_file" name="list_data_file" size="75" value="" title="첨부파일"/>
					<input name="_list_data_file" type="hidden" value='<%=list_data_file%>' />
                        <%if(String.valueOf(list_data_file).indexOf(".") != -1){%> &nbsp;&nbsp;&nbsp;삭제 <input type="checkbox" id='list_data_del' name='list_data_del' value='Y'/><%if (org_attach_name != null && org_attach_name.length() > 0) {out.println(org_attach_name);} else {out.println(list_data_file);}%> <br/> <%}%>
					</dd>
				</dl>
				 <%} %>
				  <%if(board_image_flag.equals("t")){%>
				 <dl>
					<dt><label for="list_image_file">이미지1</label></dt>
					<dd><input type="file" id="list_image_file" name="list_image_file" size="75" value="" title="첨부파일" onchange="javascript:limitFile(this)"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text">설명</label></dt>
					<dd><textarea name="image_text" id="image_text"  rows="3"><%=image_text %></textarea></dd>
				</dl>
				<dl>
					<dt><label for="list_image_file2">이미지2</label></dt>
					<dd><input type="file" id="list_image_file2" name="list_image_file2" size="75" value="" title="첨부파일" onchange="javascript:limitFile(this)"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text2">설명</label></dt>
					<dd><textarea name="image_text2" id="image_text2" rows="3"><%=image_text2 %></textarea></dd>
				</dl>
				<dl>
					<dt><label for="list_image_file3">이미지3</label></dt>
					<dd><input type="file" id="list_image_file3" name="list_image_file3" size="75" value="" title="첨부파일" onchange="javascript:limitFile(this)"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text3">설명</label></dt>
					<dd><textarea name="image_text3" id="image_text3" rows="3"><%=image_text3 %></textarea></dd>
				</dl>
				<%} %>
 
			</div>
			<div class="btn5">
				<a href="javascript:insertListBoard();" class="btn_gray">수정</a>
			    <a href="javascript:board_delete();" >삭제</a>
				<a href="javascript:history.back();" class="btn_gray">취소</a>
			</div>
			
		</div>
	</section> 
	</div>
</div>






</body>
</html>