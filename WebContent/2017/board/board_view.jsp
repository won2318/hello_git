  <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.Hashtable"%>
<%@page import="com.yundara.util.TextUtil"%>
<%@ page import="com.security.*" %>

<%@ include file = "/include/chkLogin.jsp"%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>

<%
request.setCharacterEncoding("EUC-KR");
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

}

int list_id = 0;
if(request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id")))
{
	list_id = Integer.parseInt(TextUtil.nvl(request.getParameter("list_id")));
} else {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.2')");
	out.println("history.go(-1)");
	out.println("</SCRIPT>");

}

%>

 <%@ include file = "../include/html_head.jsp"%>      
 
<% 
	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
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
	String board_security_flag ="";
	String board_hidden_flag = "";
	String view_comment = "";
 //board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag,  
 //board_user_flag, board_top_comments, board_footer_comments, board_priority, board_auth_list, 
 //board_auth_read, board_auth_write, flag, view_comment, board_ccode , 
 //board_security_flag 
 	int board_auth_read = 0;
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
	 
		view_comment = String.valueOf(v_bi.elementAt(13));
		board_security_flag = String.valueOf(v_bi.elementAt(15));
		board_auth_read = Integer.parseInt(String.valueOf(v_bi.elementAt(10)));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));
		board_hidden_flag= String.valueOf(v_bi.elementAt(16));
	}
 
 
	if (board_auth_read ==9) {
		// 관리자 글쓰기
		if (vod_level != "9") {
		 	out.println("<script language='javascript'>\n" +
		              "alert('등록 권한이 없습니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		}
	} else if (board_auth_read == 1) {
		// 실명인증 사용자
		if(!chk_login(vod_id, vod_level )) {
		   	out.println("<script language='javascript'>\n" +
		              "alert('실명인증 후 이용 가능합니다. 이전페이지로 이동합니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		return;
		}
	} else if (vod_level != null && Integer.parseInt(vod_level) < board_auth_read) {
		 
		   	out.println("<script language='javascript'>\n" +
		              "alert('접근 권한이 없습니다. 이전페이지로 이동합니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		 
	}else {
		// 비회원 등록
		
	}
	if (Integer.parseInt(vod_level) >=  1) {
		board_auth_write = 2;
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
	String list_data_file = "";
int re_level = 0;
	
	String list_pwd = "";
	String org_attach_name = "";
String open_space = "";
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
		open_space = TextUtil.nvl(String.valueOf(ht_list.get("open_space")));
		list_pwd = TextUtil.nvl(String.valueOf(ht_list.get("list_passwd")));
		
		String list_security = TextUtil.nvl(String.valueOf(ht_list.get("list_security")));
try{
			if (ht_list.get("list_re_level") != null ) {
				re_level = Integer.parseInt(String.valueOf(ht_list.get("list_re_level")));
			} 
		}catch(Exception ex){
		} 
			if ((open_space != null && open_space.equals("Y")) ) {
				// 공지글
			} else if ( request.getParameter("list_passwd") != null  && request.getParameter("list_passwd").toString().equals(SEEDUtil.getDecrypt(list_pwd))  ) {
				// 비인증 회원 비밀번호 확인
 			}  else if (user_key != null && user_key.equals(list_pwd)) {  
				// 인증회원 세션 키 확인 
			} else {
				if(
						(list_security != null && list_security.equals("Y"))  // 비밀글
						|| (board_hidden_flag != null && board_hidden_flag.equals("t"))  // 비밀글 게시판
					 
				){
					//비공개 글입니다.
					out.println("<SCRIPT LANGUAGE='JavaScript'>");
					out.println("alert('정보가 올바르지 않습니다. 이전 페이지로 돌아갑니다.')");
					out.println("history.go(-1)");
					out.println("</SCRIPT>");
					return;
				} 
			}
	 
 
	
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
		return;
	}
 
	
	
	int pg = NumberUtils.toInt(request.getParameter("page"), 1);
  	
String flag = request.getParameter("flag");
if (flag == null) {
	flag = "B";
}


//메모 읽기
int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
Hashtable memo_ht = new Hashtable();
MemoManager memoMgr = MemoManager.getInstance();
if (list_id > 0) {
 memo_ht = memoMgr.getMemoListLimit(list_id+"", mpg, 3, flag);
 
}

Vector memoVt = (Vector)memo_ht.get("LIST");
com.yundara.util.PageBean mPageBean = null;

if(memoVt != null && memoVt.size()>0){
mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
}
if(memoVt == null || (memoVt != null && memoVt.size() <= 0)){

	//결과값이 없다.

	//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
}
else{
	if(mPageBean != null){
		mPageBean.setPagePerBlock(4);
    	mPageBean.setPage(mpg);
	}
}

int memo_size = 0;
if (list_id > 0) {
	memo_size = memoMgr.getMemoCount( list_id+"" ,flag);
}

//글 쓰는 페이지를 지나가는지 체크하는 세션 변수 저장
session.putValue("write_check", "1");

//랜덤 값을 세션에 저장하고 사용자가 입력한 확인 문자열이 세션에 저장된 문자열과 같은지 체크한다.
int iRandomNum = 0;
java.util.Random r = new java.util.Random(); //난수 객체 선언 및 생성
iRandomNum = r.nextInt(999)+10000;
session.putValue("random_num", String.valueOf(iRandomNum));

%> 




       <script language="javascript">
 		
$(document).ready( function(){
	 $.get('/2017/comment/comment_list.jsp', {'ocode' : '<%=list_id%>', 'page' : '1','flag':'B'}, function(data){
		 $("#commentList").html(data);
    });
		return false;
	}
	);
 
 
 

function comment_action(){
	
	if(filterIng(document.getElementById('comment').value, "comment") == false){
		return;
		
	}else {
	if (document.getElementById('wnick_name').value == '') {

		alert("닉네임을 입력하세요!");
	} else if (document.getElementById('pwd').value == '') {

		alert("비밀번호을 입력하세요!");
	} else if (document.getElementById('chk_word').value == '') {

		alert("확인문자를 입력하세요!");
	} else if (document.getElementById('comment').value == '') {

		alert("내용을 입력하세요!");
	} else {
     var bodyContent = $.ajax({
		    url: "/2017/comment/comment_list.jsp",  //<- 이동할 주소 
		    global: false, //<- 
		    type: "POST",  //<-  보낼때 타입 
		    data: $("#comment_form").serialize(),  //<-  보낼 파라메타 
		    dataType: "html",  //<-  받을때타입 
		    async:false,
		    success: function(data){  //<-  성공일때 
		    	 if (data != "") {
	                 $("dl#commentList").detach();
	                 $("#commentList").html(data); 
	                 document.getElementById('chk_word').value="";
	                 document.getElementById('comment').value="";
	                 
	             } 
		    }
		 }
		);
	}
	}
}

var pageno = 1 ;
var getTotalPage = 1;


<%-- function page_go(val){  
	$.get('/2017/comment/comment_list.jsp', {'ocode' : '<%=list_id%>', 'page' : val}, function(data){
		 
		 if (data != "") {
		 $("dl#commentList").detach();
		 $("#commentList").html(data);
		 }
		
   }); 
} --%>

function page_go(val){ 
 
		if (pageno > 1 && val =='pre') {
			pageno = pageno - 1;
		} else if (val =='next' && pageno < getTotalPage) {
			pageno = pageno + 1;
		} else {
			 pageno = 1 ;
		}
  
	$.get('/2017/comment/comment_list.jsp', {'ocode' : '<%=list_id%>', 'page' : val,'flag':'B'}, function(data){
		 
		 if (data != "") {
		 $("dl#commentList").detach();
		 $("#commentList").html(data);
	 
		 }
		
   }); 
}

function deleteChk(muid) { 	 
  		var url = "../comment/pwd_check.jsp?ocode=<%=list_id%>&flag=<%=flag %>&board_id=<%=board_id%>&muid="+muid;   
		jQuery.colorbox({href:url, open:true});
 
}


function fileDown(){
	document.file_down.action="download.jsp"
	document.file_down.submit();
}
 
 function board_del(){ 

	if (confirm("삭제하시겠습니까")) {
		name_check('2017_delete');
	} 
 }
 function board_delete(){
	 if (confirm("삭제하시겠습니까")) {
			top.location.href="proc_boardListDelete.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>"; 
			
		}
 }
 
function name_check(link){ 
	var url = "/include/name_gpin.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type="+link;   
 	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
	 
}


function pwd_check(link){ 
	 var url = "./pwd_check.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type="+link; 

 	 jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true}); 
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
function filterIng(str , id){

	for (var ii = 0 ; ii < splitFilter.length ; ii++ )
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


//URL 복사
function copy_select(){ 

  var txt = "http://tv.suwon.go.kr/index_link.jsp?list_id=<%=list_id%>&board_id=<%=board_id%>";
  if ((navigator.appName).indexOf("Microsoft")!= -1) {

       if(window.clipboardData){
            var ret = null;
            ret = clipboardData.clearData();
            if(ret){
                 window.clipboardData.setData('Text', txt);

                 alert('클립보드에 주소가 복사되었습니다.');
            }else{

                 alert("클립보드 액세스 허용을 해주세요.");
            }
       }
  }
  else { 
       //alert("해당 브라우저는 클립보드를 사용할 수 없습니다.\r\nURL을 [Ctrl+C]를 사용하여 복사하세요.");
	  temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", txt);
  }

}   

</script>


       
		<section id="body">
			<div id="container_out">
				<div id="container_inner">
					<div class="vodView boardView">
						<div class="data">
						
						
							<h4 class="entry-title clearfix"><%=list_title %></h4>
							<div class="info">
								<dl>
								<dt>등록일</dt>
								<dd><%=list_date %></dd>
								<dt>작성자</dt>
								<dd><%=list_name%></dd>
								</dl>
								<i class="i_reply">
								
								 <%if(view_comment != null && view_comment.equals("t")){ %> 
								<a href="#comment_inner">
								<%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%>
								</a>
										 <% } %>  
								</i>
							</div>
						</div>
						<div class="data2">
							<dl>
								<dt>첨부파일</dt>
								<dd><a href="javascript:fileDown();"><%if (org_attach_name != null && org_attach_name.length() > 0) {out.println(org_attach_name);} %></a></dd>
									<form name="file_down" method="post" action="download.jsp">
									<input type="hidden" name="board_id" value="<%=board_id %>" />
									<input type="hidden" name="list_id" value="<%=list_id %>" />
								</form>
							</dl>
							<%if(board_link_flag.equals("t")){%>
							<dl>
								<dt>Link</dt>
								<dd><a href="<%=list_link%>" target="_blank"><%=list_link%></a></dd>
							</dl>
							<%}%>
						  <% if (board_id == 22) { %>
						 <dl>
						 	<dt>구분</dt>
						 	<dd><% if (image_text8 != null && image_text8.equals("V")) out.print("영상(수원iTV)"); %>
						 	<% if (image_text8 != null && image_text8.equals("N")) out.print("기사(e수원뉴스)"); %> 
						 	</dd>
						 </dl> 
						 <%} %>
							 
							
							<span class="subj clearfix">
				<% if (list_image_file  != null && list_image_file.length() > 0) { %>
		 		<p>
			 		<img src="img_.jsp?list_id=<%=list_id%>"   alt="이미지1" style="max-width:100%; *width:570px;"/> 
			 		<br/><%=chb.getContent_2(String.valueOf(image_text),"true")%>
		 		</p> 
		 		<%} %>
		 		<% if (list_image_file2  != null && list_image_file2.length() > 0 ){%>
		 		<p>
			 		<img src="img_.jsp?no=2&list_id=<%=list_id%>"  alt="이미지2" style="max-width:100%; *width:570px;"/> 
			 		<br/><%=chb.getContent_2(String.valueOf(image_text2),"true")%>
		 		</p> 
		 		<%} %>
		 		<%if (list_image_file3  != null && list_image_file3.length() > 0 ) {%>
		 		<p>
			 		<img src="img_.jsp?no=3&list_id=<%=list_id%>"  alt="이미지3" style="max-width:100%; *width:570px;"/> 
			 		<br/><%=chb.getContent_2(String.valueOf(image_text3),"true")%>
		 		</p> 
		 		<%} %> 
							<dd><%=chb.getContent_2(String.valueOf(list_contents),"true")%></dd>
							</span>
						</div>
						<!--//data-->
						<div class="btn1">
							<a href="board_list.jsp?board_id=<%=board_id%>">목록</a>
			<%if(board_user_flag != null && board_user_flag.equals("t")){ } else{
			  %>
			<% if (board_auth_write == 0) { %>
					<a href="javascript:pwd_check('update');">수정</a>
					<a href="javascript:pwd_check('delete');">삭제</a>
			<%} else { %>

				<% if (vod_name != null && vod_name.length() > 0) { %>
					 
				<a href="board_update.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>">수정</a>
					<a  href="javascript:board_delete();">삭제</a>
				<%} else { %>
				 
					<a href="javascript:name_check('2017_update');">수정</a>
					<a href="javascript:board_del();">삭제</a>
				<%} %>

			 <%} %>
			<%} %>
							
							
						</div>
				 	<%if(view_comment != null && view_comment.equals("t")){ %> 
						<div id="comment_inner">
							<div id="commentFrame">
								<h5>댓글 <strong>(<%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%>)</strong><span>비방, 욕설, 광고 등은 사전협의 없이 삭제됩니다.</span></h5>
								<div class="input_wrap">
									<form id="comment_form" name="comment_form" method="post" action="javascript:comment_action()" >
									<dl>
						<input type="hidden" name="ocode" value="<%=list_id%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
						<input type="hidden" name="flag" value="<%=flag %>" />
									<dt><label for="wnick_name">닉네임</label></dt>
									<dd><input type="text" name="wnick_name" value="" id="wnick_name" title="닉네임"/></dd>
									</dl>
									<dl>
									<dt><label for="pwd">비밀번호</label></dt>
									<dd><input type="password" name="pwd" value=""  id="pwd" title="비밀번호"/></dd>
									</dl>
									<dl>
									<dt><label for="chk_word">확인문자열</label></dt>
									<dd><input type="text" name="chk_word" value="" id="chk_word" size="10" title="확인 문자열"  />
										<span class="chk1"><%=iRandomNum %></span> * 좌측 숫자를 입력하십시오.
									</dd>
									</dl>
									<textarea id="comment" name="comment" wrap="hard"  required="required" ></textarea>
									<input type="submit" alt="확인" class="img" value="확인"/>
									</form>
								</div>
								<div class="commentList" id="commentList">
									
									
								</div>
								
								<form name="comment_del" method="post" action="../comment/pwd_check.jsp" >
								<input type="hidden" name="ocode" value="<%=list_id%>" />
								<input type="hidden" name="jaction" value="del" />
								<input type="hidden" name="muid" value="" />
								<input type="hidden" name="pwd" value="<%=user_key %>" />
								<input type="hidden" name="flag" value="<%=flag %>" />
								</form>
								
							</div>
							</div>
							<%} %>
							<!-- //comment::댓글 -->
						
					</div>
					<!--//vodView-->
					
				</div><!--//container_inner-->
				<aside class="container_right">
					<div class="NewTab list5 list3">
						<ul >
						<%@ include file = "../include/right_new_video.jsp"%>   
							
						</ul>
					</div><!--//NewTab list3-->
						<%@ include file = "../include/right_best_video.jsp"%>   

				</aside><!--//container_right-->
			</div><!--//container_out-->
		</section><!--콘텐츠부분:section-->    
		
		<%@ include file = "../include/html_foot.jsp"%>
		
	