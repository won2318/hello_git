<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.yundara.util.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%> 
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.yundara.util.*"%>
 
    <%@ include file = "/include/chkLogin.jsp"%>
    <jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>

<%

//랜덤 값을 세션에 저장하고 사용자가 입력한 확인 문자열이 세션에 저장된 문자열과 같은지 체크한다.
int iRandomNum = 0;
java.util.Random r = new java.util.Random(); //난수 객체 선언 및 생성
iRandomNum = r.nextInt(999)+10000;
session.putValue("random_num", String.valueOf(iRandomNum));
 
	 String ccode="";
		int board_id  = 2;
	try
	{
		if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
		{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
			 
		} 
	}catch(Exception e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
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
	 //board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag,  
	 //board_user_flag, board_top_comments, board_footer_comments, board_priority, board_auth_list, 
	 //board_auth_read, board_auth_write, flag, view_comment, board_ccode , 
	 //board_security_flag 
	String board_title = "";
	String board_page_line = "";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	String flag = "";
	String board_security="";
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
		flag = String.valueOf(v_bi.elementAt(12));
		board_security = String.valueOf(v_bi.elementAt(15));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));

	}
 
	String list_open = "Y";
	int event_seq = NumberUtils.toInt(request.getParameter("event_seq"), 0);
	 
 
	//글 쓰는 페이지를 지나가는지 체크하는 세션 변수 저장
// 	session.putValue("write_check", "1");
	
// 	//랜덤 값을 세션에 저장하고 사용자가 입력한 확인 문자열이 세션에 저장된 문자열과 같은지 체크한다.
// 	int iRandomNum = 0;
// 	java.util.Random r = new java.util.Random(); //난수 객체 선언 및 생성
// 	iRandomNum = r.nextInt(999)+10000;
// 	session.putValue("random_num", String.valueOf(iRandomNum));
 
	if (board_auth_write ==9) {
		// 관리자 글쓰기
		if (vod_level != "9") {
		 	out.println("<script language='javascript'>\n" +
		              "alert('등록 권한이 없습니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		 	return;
		}
	}else if (board_auth_write ==2) {
		if ( Integer.parseInt(vod_level) < board_auth_write){  // 모니터링단
		 	out.println("<script language='javascript'>\n" +
		              "alert('등록 권한이 없습니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		 	return;
		}
	} else if (board_auth_write == 1) {
		
		 if (!chk_login(vod_id, vod_level )) {  // 실명인증
		   	out.println("<script language='javascript'>\n" +
		              "alert('실명인증 후 이용 가능합니다. 이전페이지로 이동합니다.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		return;
		}
		
		
	} else {
		// 비회원 등록
		
	}
	if (Integer.parseInt(vod_level) >=  1) {
		board_auth_write = 2;
	}
	
%>

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
	
 <% if(board_id == 23) { %>
		if (document.getElementById('image_text9').value=='') {
			alert('개인정보 수집 내역을 선택하세요');
			 return
		}
		if (document.getElementById('image_text10').value=='') {
			alert('개인정보 제3자 제공내역을 선택하세요');
			 return
		} 
<%
}
%>
		if (f.list_title.value=="") {
		   alert ("제목을 입력하지 않으셨습니다.");
		   f.list_title.focus();
		   return
		}
		if(!CheckText(f.list_title)){
			return;
		}
		if(filterIng(f.list_title.value, f.list_title,"list_title") == false){
			return;
		}
		if (f.list_name.value=="") {
			   alert ("작성자를 입력하지 않으셨습니다.");
			   f.list_name.focus();
			   return
			}
		
		if (f.list_contents.value=="") {
		   alert ("내용을 입력하지 않으셨습니다.");
		   f.list_contents.focus();
		   return
		}
		if(filterIng(f.list_contents.value, f.list_contents,"list_contents") == false){
			return;
		}
		
		
		if(f.chk_word.value=="" || f.chk_word.value != <%=iRandomNum%>){
			alert("확인문자열을 확인하세요.");
			f.chk_word.value();
			   return
		}
		
		
<% if (board_auth_write == 0) { %>
		if (f.list_passwd.value =="") {
			   alert ("비밀번호를 입력하세요.");
			   f.list_passwd.focus();
	    		   return;
		}else if(!pwCheck(f.list_passwd.value)){
				f.list_passwd.focus();
				alert("영문+숫자+특수 문자를 적어도 하나 이상씩 조합한 8자 이상, 12자 이내로 입력하시기 바랍니다.");
				return;
		}
<%} %>
// 		var chk_word2 = "";
// 		chk_word2 = document.getElementById("chk_word2");
		
// 		if(chk_word2.value == ""){
// 			alert('확인 문자열을 입력하십시오.');
// 			f.chk_word.focus();
// 			return;
// 		}

		

		f.action="proc_boardListAdd.jsp?board_id=<%=board_id%>&searchField=<%=request.getParameter("searchField")%>&searchString=<%=request.getParameter("searchString")%>";
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

</script>

<script>

$(document).ready(function() {
	
	 $(document).on("keyup blur","#user_tel",function(e) {
	   jsPhoneAutoHyphen(this);
	   if (e.type == "focusout")
	   {
	    if ($(this).val().split("-").length < 3 && $(this).val().length < 9)
	    {
	     $(this).val("");
	     return false;
	    }
	   }
	  });
});
</script>

		<section id="body">
			<div id="container_out">
				<div id="container_inner">
					<div class="war">비방, 욕설, 광고 등은 사전협의 없이 삭제됩니다.</div>
<%if (board_id == 23) { %>						
					<div class="privacy">
						<p> 수원시는 수원iTV <strong>'본격 노동 버라이어티'로 돌아온 마르코&성준의 수원견문록 시즌2! 이벤트 진행</strong>을 위해
						 「개인정보보호법」제15조, 제17조, 제18조, 제22조, 제26조의 규정에 의거, 
							 아래와 같이 개인정보를 수집 및 이용하고자 합니다. 
							내용을 자세히 읽으신 후 동의 여부를 체크하여 주시기 바랍니다 
						</p>
						<div class="privacy_inner">
							<ul>
								<li><strong>개인정보 수집·이용 내역<span>(필수)</span></strong>
								<ul>
									<li>(1) 수집 및 이용 항목 : 성명, 전화번호 </li>
									<li>(2) 수집 및 이용 목적 : 이벤트 진행 및 당첨자에게 기프티콘 발송</li>
									<li>(3) 보유 기간 : 이벤트 종료 후 20일</li>
								</ul>
								</li>
								<li> <span style="color:#00a1e0;font-weight:600">* 14세 미만은 참가 불가능합니다.</span><br/>     * 위의 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있습니다. <br/>
									그러나 동의를 거부할 경우 이벤트상품 지급이 제한될 수 있습니다.
								</li>
							</ul>
							<p>위와 같이 개인정보를 수집 및 이용하는데 동의하십니까?<br/>
								<span>
									<input type="radio" title="동의" value="Y" name="aggr1" onclick="document.getElementById('image_text9').value='Y';"/><span><label for="yes1">동의</label></span>
									<input type="radio" title="비동의" value="N" name="aggr1" onclick="document.getElementById('image_text9').value='N';"/><label for="no1">비동의</label>
								 
								</span>
							</p>
						</div>
						<div class="privacy_inner">
							<ul>
								<li><strong>개인정보 제3자 제공 내역<span>(필수)</span></strong>
								<ul>
									<li>(1) 제공받는 자 : 도넛북</li>
									<li>(2) 제공목적 : 기프티콘 발송</li>
									<li>(3) 제공항목 : 성명, 전화번호</li>
									<li>(4) 보유기간 : 20일</li>
								</ul>
								</li>
								<li>     * 위의 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있습니다. <br/>
									그러나 동의를 거부할 경우 이벤트상품 지급이 제한될 수 있습니다.
								</li>
							</ul>
							<p>위와 같이 개인정보를 수집 및 이용하는데 동의하십니까?<br/>
								<span>
									<input type="radio" title="동의" value="Y" name="aggr2" onclick="document.getElementById('image_text10').value='Y';"/><span><label for="yes2">동의</label></span>
									<input type="radio" title="비동의" value="N" name="aggr2" onclick="document.getElementById('image_text10').value='N';"/><label for="no2">비동의</label>
									
								</span>
							</p>
						</div>
					</div><!--//privacy:개인정보동의-->
<%} %>						
					<div class="boardWrite">
					<form name='frmBoard' method='post' enctype='multipart/form-data'>
					<input type="hidden" name="board_id" value='<%=board_id%>' />
					<input type="hidden" name="list_open" value='<%=list_open%>' />
					<input type="hidden" name="event_seq" value='<%=event_seq%>' />
					<input type="hidden" name="user_key" id="user_key" value="" /><!-- 실명인증 키값 -->
					<input type="hidden" name="image_text9" id="image_text9" value="" />	 
					<input type="hidden" name="image_text10" id="image_text10" value="" />
			 
					
						<dl>
						
							<dt><label for="title">제목</label></dt>
							<dd><input type="text" name="list_title" value="" id="list_title" size="72" title="제목" class="wd100"/>
							
							 <% if (board_id == 22) { %>
							 <br/><span class="font_ora">※ 제목 작성시 <strong>[모니터링 종류] / [해당영상(기사) 게시일자] / [해당영상(기사) 제목]</strong> 으로 작성 바랍니다.</span>
							 <%} %>
							 </dd>
						</dl>
						
						<dl>
							<dt><label for="name">작성자</label></dt>
							<%if (board_id == 22 ) { %>
							<dd><%=vod_id %><input type="hidden" name="list_name" value="<%=vod_name %>" id="list_name" size="72" title="작성자" class="wd100"/> 
							</dd>
							<%} else { %>
							<dd><input type="text" name="list_name" value="<%=vod_name %>" id="list_name" size="72" title="작성자" class="wd100"/></dd>
							<%} %>
						</dl>
							
				<%if (board_id == 11 || board_id == 13 || board_id == 17  ) { %>
					<%if (board_id == 11 || board_id == 13  ) { %>
					<dl>
						<dt><label for="user_address">주소</label></dt>
						<dd><input type="text" name="user_address" value="" id="user_address" size="45" title="주소"/></dd>
					</dl>
					<%}%> 
					<dl>
						<dt><label for="user_tel">연락처</label></dt>
						<dd><input type="text" name="user_tel" value="" id="user_tel" size="16" maxlength="14" title="연락처"/>  
						</dd>
					</dl>
				<%}%> 
				 <%if(board_security != null && board_security.equals("t")){ %>
					<dl>
						<dt><label for="list_security">비밀글</label></dt>
						<dd><input type="checkbox" name="list_security" value="Y" title="비밀글"/> * 비밀글 작성시 관리자만 확인이 가능합니다!</dd>
					</dl>
					<%} %>
				<%if(board_link_flag.equals("t")){%>
				<dl>
					<dt><label for="list_link">주소링크</label></dt>
					<dd><input type="text" name="list_link" id="list_link" maxlength="200" value="" class="input01" style="width:300px;" onkeyup="checkLength(this,200)"/></dd>
				</dl>
				<% } %>
					
				 <% if (board_id == 22) { %>
				 <dl>
				 	<dt><label for="image_text8" class="image_text8">구분</label>
				 	</dt>
				 	<dd>
				 	 <input type="radio" name="image_text8" value="V" checked="checked"/>영상(수원iTV)
					&nbsp;<input type="radio" name="image_text8" value="N" />기사(e수원뉴스)
				 	</dd>
				 </dl> 
				 <%} %>
				
						<dl>
							<dt><label for="subject" class="subject">내용</label></dt>
							<dd><textarea name="list_contents" style="line-height: 170%;" cols="70" rows="20" id="list_contents" title="내용" class="wd100">
<%
					//시민모니터링단 게시판만 기본으로 제공
if (board_id == 22 ) { %>
1. 해당영상(기사) 제목 :
2. 해당영상(기사) 등록일 :
3. 해당영상(기사) 작성자 :
4. 모니터 내용 :


5. 의견 채택시 인센티브 방법 : 자원봉사시간 인정 / 보상금 지급 중 택1
		
<%} else if (board_id == 23) {%>
1. 이름 :  
2. 연락처 : 
3. 네이버TV '수원견문록 페이지 구독여부 : 
4. 수원견문록 ' 어린이집 보육교사' 편 속 수원이 등장하는 장면은? 

<%} %></textarea>
<%
					//시민모니터링단 게시판만 기본으로 제공
					if (board_id == 22 ) { %>

					<div style="display:block; padding-top:5px; float: left; width:100%;">
※인텐시브 인정기준
<TABLE style="WIDTH: 100%; HEIGHT: 94px; font-size: 13px;" border=1 cellSpacing=0 cellPadding=0>
<TBODY>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 153px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" colSpan=2>
<P align=center >구분</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 121px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>인정기준<br/>(영상 · 기사 1건당)</P></TD>

<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 64px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>상한(1일)</P></TD>
<TD valign="middle"  style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 64px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>상한(1월)</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 85px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P style="TEXT-ALIGN: center" align=center>비고</P></TD>
</TR>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 71px; HEIGHT: 47px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=2>
<P align=center>자원봉사<br/>활동시간</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>오류 · 오타</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>30분</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 64px; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=2>
<P align=center>2시간</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 64px; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=2>
<P align=center>&nbsp;20시간</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=4>
<P style="TEXT-ALIGN: center" align=center>&nbsp;의견 채택시에<br/>한함</P></TD>
</TR>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;제안 · 건의<br/>소재제보</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;1시간</P></TD>
</TR>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 71px; HEIGHT: 47px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=2>
<P align=center>&nbsp;보상금</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;오류 · 오타</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;2,500원</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 64px; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=2>
<P align=center>&nbsp; - </P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 64px; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=2>
<P align=center>&nbsp;100,000원</P></TD>
</TR>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;제안 · 건의<br/>소재제보</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;10,000원</P></TD>
</TR>
</TBODY>
</TABLE>
<P>&nbsp;</P>
<P style="padding-bottom:5px;">※ 보상금 지급<br/>&nbsp;- <strong>2017. 11월 이후</strong>의 영상 및 기사<br/>&nbsp;- 게시일로부터 <strong>일주일 이내</strong>의 영상 및 기사<br/>&nbsp;- <strong>타 매체</strong>(유튜브, 블로그 등)는 <strong>제외</strong><br/></P>
<P style="padding-bottom:5px;">※ 인정 기준<br/>&nbsp;- 의견 채택 시 주어지는 인센티브의 인정기준은 <strong>영상 또는 기사 1건당</strong>이므로, 동일한 영상 또는 기사에 대해 여러 건의 오류를 등록해도 1건으로 인정됨<BR></P>
<P>※ 인센티브 제공<br/>&nbsp;- 보상금은 <strong>예산의 범위 내</strong>에서 집행 / 예산 소진시에는 자원봉사활동시간으로 지급<BR></P></div>

					<%}%>							
							</dd>
						</dl>
						
						<%if(board_file_flag.equals("t")){%>
				<dl>
					<dt><label for="list_data_file">첨부</label></dt>
					<dd><input type="file" id="list_data_file" name="list_data_file" size="58" value="" title="첨부파일" onchange="javascript:limitFile(this)"/></dd>
					<p style="padding-top:10px; clear: both;font-size: 11px; text-align: center; letter-spacing: -1px; font-weight: bold;">첨부용량은 최대 <span style="color: #ef4a4a;">100MB</span> 이며 저장버튼을 누르신 후 <span style="color: #ef4a4a;">등록완료</span> 안내가 나올 시까지 기다려주시기 바랍니다.</p>
				</dl>
				 <%} %>
				 <%if(board_image_flag.equals("t")){%>
				 <dl>
					<dt><label for="list_image_file">이미지1</label></dt>
					<dd><input type="file" id="list_image_file" name="list_image_file" size="58" value="" title="첨부파일" onchange="javascript:limitFile(this)"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text">설명</label></dt>
					<dd><textarea name="image_text" id="image_text"  cols="70" rows="2"></textarea></dd>
				</dl>
				<dl>
					<dt><label for="list_image_file2">이미지2</label></dt>
					<dd><input type="file" id="list_image_file2" name="list_image_file2" size="58" value="" title="첨부파일" onchange="javascript:limitFile(this)"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text2">설명</label></dt>
					<dd><textarea name="image_text2" id="image_text2" cols="70" rows="2"></textarea></dd>
				</dl>
				<dl>
					<dt><label for="list_image_file3">이미지3</label></dt>
					<dd><input type="file" id="list_image_file3" name="list_image_file3" size="58" value="" title="첨부파일" onchange="javascript:limitFile(this)"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text3">설명</label></dt>
					<dd><textarea name="image_text3" id="image_text3" cols="70" rows="2"></textarea></dd>
				</dl>
				<%} %>
						
						<dl>
							<dt><label for="chk_word">확인문자열</label></dt>
							<dd><input type="text" name="chk_word" value="" id="chk_word" size="10" title="확인 문자열"  />
							<span class="checkText"><%=iRandomNum %></span>&nbsp;&nbsp;  * 좌측 숫자를 입력 하십시오.</dd>
						</dl>
				<% if (board_auth_write == 0) { %>
				<dl>
			
					<dt><label for="list_passwd">비밀번호</label></dt>
					<dd><input type="password" name="list_passwd" value="" id="list_passwd" size="12" title="비밀번호"/>*영문,숫자,특수문자 포함 8이상 12자리이하</dd>
				</dl>
				<%} else { %>
					<input type="hidden" name="list_passwd" value="" />
				<%} %>
				</form>
					</div>
					<div class="btn1">
						<!-- <a href="">목록</a>
						<a href="">수정</a>
						<a href="">삭제</a> -->
						
				<a href="javascript:insertListBoard();">저장</a>
				<a href="javascript:history.back();">취소</a>
						
					</div>
				</div><!--//container_inner-->
				<aside class="container_right">
					<div class="NewTab list5 list3">
						<ul>
						<%@ include file = "../include/right_new_video.jsp"%>   
						</ul>
					</div><!--//NewTab list3-->
					<%@ include file = "../include/right_best_video.jsp"%>   
				</aside><!--//container_right-->
			</div><!--//container_out-->
		</section><!--콘텐츠부분:section-->    
		<iframe id="fileFrame" name="fileFrame" title="fileFrame" src="#" width="0" height="0" cellpadding="0" cellspacing="0" border="0"></iframe>
		<%@ include file = "../include/html_foot.jsp"%>
		