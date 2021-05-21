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
			} else if (session.getValue("list_passwd") != null && session.getValue("list_passwd").toString().equals(SEEDUtil.getDecrypt(list_pwd))) { 
				// 비인증 회원 비밀번호 확인
			} else if (user_key != null && user_key.equals(list_pwd)) {  
				// 인증회원 세션 키 확인 
			} else {
				if(
						(list_security != null && list_security.equals("Y")) 
					 
						|| (board_hidden_flag != null && board_hidden_flag.equals("t"))
				){
					//비공개 글입니다.
					out.println("<SCRIPT LANGUAGE='JavaScript'>");
			
					out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");
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
 
 	
<script language="javascript">
<%if(view_comment != null && view_comment.equals("t")){ %>
$(document).ready( function(){
	
	 $.get('./comment.jsp', {'ocode' : '<%=list_id%>', 'page' : '1','flag':'B'}, function(data){
		 //alert(data);
		 $("#comment_link").html(data);
 
    });
		return false;
	}
	);
 <%}%>
	
// $(function(){
// 	$('#comment_form').validate({
// 	    rules: {
// 	    	wnick_name: { required: true},
// 	        pwd: { required: true},
// 	        chk_word: { required: true}, 
// 	        comment: { required: true },
// 	        },
// 	      messages: {
// 	    	  wnick_name: { required: "<strong>닉네입을 입력하세요.</strong>" },
// 	          pwd: { required: "<strong>비밀번호를 입력하세요.</strong>" },
// 	          chk_word: { required: "<strong>확인문자를 입력하세요.</strong>" },
// 	          comment: { required: "<strong>내용을 입력하세요.</strong>"},
// 	        },
// 	});
	 
// });

function comment_action(){

     var bodyContent = $.ajax({
    	   url: "./comment.jsp?ocode=<%=list_id%>&flag=B",  //<- 이동할 주소 
		    global: false, //<- 
		    type: "POST",  //<-  보낼때 타입 
		    data: $("#comment_form").serialize(),  //<-  보낼 파라메타 
		    dataType: "html",  //<-  받을때타입 
		    async:false,
		    success: function(data){  //<-  성공일때 
 
		    	 if (data != "") {
	                 $("dl#comment_link").detach();  //하위 요서 데이터 제거
	                 $("#comment_link").html(data); 
	                 document.getElementById('chk_word').value="";
	                 document.getElementById('comment').value="";
	                 //$.colorbox.resize(); 
	             } 
		    }
		 }
     
		);
	 
}
 
function page_go(val){  
	$.get('./comment.jsp', {'ocode' : '<%=list_id%>', 'page' : val, 'flag':'B'}, function(data){
		 
		 if (data != "") {
		 $("div#comment_link").detach();
		 $("#comment_link").html(data);
		 }
		
   }); 
}
 

</script>

</head>
<body>

<div id="container"  > 
	<div class="major"  >
	
	<section>
		<div class="vodView">
		 
			<div class="topTitle"><h3><%=list_title%></h3> <a href="javascript:history.back();" data-rel="back" data-role="button" ><img src="../include/images/icon_close.png" width="23" height="23" alt="이전화면" /></a></div>
			
			<ul>
				<li><span class="time"><%=list_date %> | <% out.println(list_name); %></span></li>
				<li  >
					<%=chb.getContent_2(String.valueOf(list_contents),"true")%>  
				</li>
				
			<li>
			<% if (list_image_file  != null && list_image_file.length() > 0) { %>
		 		<p>
			 		<img src="img_.jsp?list_id=<%=list_id%>"   alt="이미지1" style="max-width:100%; "/> 
			 		<br/><%=chb.getContent_2(String.valueOf(image_text),"true")%>
		 		</p> 
		 	<%} %>
		 		<% if (list_image_file2  != null && list_image_file2.length() > 0 ){%>
		 		<p>
			 		<img src="img_.jsp?no=2&list_id=<%=list_id%>"  alt="이미지2" style="max-width:100%; "/> 
			 		<br/><%=chb.getContent_2(String.valueOf(image_text2),"true")%>
		 		</p> 
		 		<%} %>
		 		<%if (list_image_file3  != null && list_image_file3.length() > 0 ) {%>
		 		<p>
			 		<img src="img_.jsp?no=3&list_id=<%=list_id%>"  alt="이미지3" style="max-width:100%; "/> 
			 		<br/><%=chb.getContent_2(String.valueOf(image_text3),"true")%>
		 		</p> 
		 		<%} %> 
			</li>
			
			
			</ul>
			<%if (vod_name != null && vod_name.length() > 0) { %>
			<div class="btn5">
				<a href="board_update.jsp?list_id=<%=list_id%>&board_id=<%=board_id%>" >수정</a>
				
			</div>
			<%} %>
<!-- 			<ul class="info"> -->
<!-- 				<li> -->
<!-- 					<span class="link">공유하기 -->
<!-- 					<strong> -->
<!-- 						<a href="/"><img src="../include/images/icon_view_link.gif" alt="링크" width="29" height="29"/></a>   -->
<!-- 						<a href="/"><img src="../include/images/icon_view_twitter.gif" alt="트위터" width="29" height="29"/></a>  -->
<!-- 						<a href="/"><img src="../include/images/icon_view_facebook.gif" alt="페이스북" width="29" height="29"/></a> -->
<!-- 					</strong> -->
<!-- 					</span> -->
<!-- 				</li> -->
<!-- 			</ul> -->
			<!-- comment::댓글 -->
			 <%if(view_comment != null && view_comment.equals("t")){ %>
				<div class="comment" id="comment_link">
				</div>
			<%}%>
				<!-- //comment::댓글 --> 
		</div>
	</section> 
	</div>
</div>



</body>
</html>