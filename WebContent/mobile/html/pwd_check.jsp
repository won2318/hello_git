<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.security.*" %>
 


<%@ include file = "../include/head.jsp"%>

<%
  
String ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
String board_id = request.getParameter("board_id").replaceAll("<","").replaceAll(">","");
String list_id = request.getParameter("list_id").replaceAll("<","").replaceAll(">","");
String memoid = request.getParameter("memoid").replaceAll("<","").replaceAll(">","");
 
String type = request.getParameter("type").replaceAll("<","").replaceAll(">","");
String action_function = "memo_del()";
if (type != null && type.equals("update")) {
	action_function = "board_update()";
} else if (type != null && type.equals("delete")) {
	action_function = "board_delete()";
} else if (type != null && type.equals("view")) {
	action_function = "board_view()";
} else {
	action_function = "memo_del()";
}
%>


<script type="text/javascript">
function memo_del() {
 
	if (confirm("메모를 삭제하시겠습니까?")) {
		if (document.getElementById('password').value=="") {
			alert('비밀번호를 입력하세요!');
		} else {
			document.memo_form.action="./comment.jsp";
			document.memo_form.submit();
		}
 		
	}
}

function board_view() { 
	if (document.getElementById('password').value=="") {
		alert('비밀번호를 입력하세요!');
	} else {
		document.memo_form.action="./board_view.jsp";
		document.memo_form.submit();
	} 
}

function board_update() { 
		if (document.getElementById('password').value=="") {
			alert('비밀번호를 입력하세요!');
		} else {
			document.memo_form.action="./board_update.jsp";
			document.memo_form.submit();
		} 
}
function board_delete() { 
	if (confirm("삭제하시겠습니까?")) {
		if (document.getElementById('password').value=="") {
			alert('비밀번호를 입력하세요!');
		} else {
			document.memo_form.action="./proc_boardListDelete.jsp";
			document.memo_form.submit();
		} 
	}
}


</script>
	
 
		<section>
			<div id="container">
			<div class="snb_head">
					<h2>비밀번호 확인</h2>
					<div class="snb_back"><a href="javascript:history.back();"><span class="hide_txt">뒤로</span></a></div><!--이전페이지로 이동-->
				</div>
			<form name="memo_form" method="post" action="./comment.jsp"  onsubmit="return false;">
			<input type="hidden" name="ocode" value="<%=ocode%>" />
			<input type="hidden" name="jaction" value="del" />
			<input type="hidden" name="muid" value="<%=memoid %>" />
			<input type="hidden" name="flag" value="<%=flag %>" />
			<input type="hidden" name="board_id" value="<%=board_id %>" />
			<input type="hidden" name="list_id" value="<%=list_id %>" />
 
			 
				<div class="content_inner">
					<div class="boardPw">
						<span class="nameInfo">비밀번호를 입력하셔야 진행이 가능합니다.</span>				
						<dl>
							<dt><label for="password">비밀번호</label></dt>
							<dd><input type="password" name="pwd" value="" id="password" size="30" title="비밀번호"/></dd>
						</dl>
					</div>
					<div class="btn1 btn-03">
						<a href="javascript:<%=action_function%>">확인</a> 
					</div>
				</div>		
				</form>			
			</div>
			 
		</section><!--//콘텐츠부분:section-->    
	<%@ include file = "../include/foot.jsp"%>	
	 