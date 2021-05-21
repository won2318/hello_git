<%@page import="com.yundara.util.TextUtil"%>
<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="com.vodcaster.sqlbean.DirectoryNameManager "%>
<%@page import="com.security.SEEDUtil"%>
 
<%@ include file="/include/chkLogin.jsp" %>
 
<%
// colorbox 에서 사용하는 페이지 패스워드 확인
  
 		if(request.getParameter("list_passwd") != null && request.getParameter("list_passwd").length() > 0) { 
	 
	        try { 
	        	session.putValue("list_passwd", SEEDUtil.getEncrypt(request.getParameter("list_passwd")));
	
	        }catch(Exception e) {
	            System.out.println(e.getMessage());
	        }
 		} else {
 			
 		} 


String ccode="";
int board_id = 10;
if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
{
	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
	} else {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");
	out.println("history.go(-1)");
	out.println("</SCRIPT>");

}

int list_id = 0;
if(request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id")))
{
	list_id = Integer.parseInt(TextUtil.nvl(request.getParameter("list_id")));
} else {
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println("alert('잘못된 접근 입니다. 이전 페이지로 돌아갑니다.')");
	out.println("history.go(-1)");
	out.println("</SCRIPT>");

}


%>
	<script type="text/javascript" >
 
	function formSubmit(type){

		
		if (type != null && type=="delete") {
			if (confirm("삭제하시겠습니까")) {
				var link="./proc_boardListDelete.jsp?board_id="+<%=board_id%>+"&list_id="+<%=list_id%>;
				top.location.href=link;
				//parent.parent.parent.top.name_check_conform(link);
			}
		} else if (type != null && type=="update") {
			var link="./board_update.jsp?board_id="+<%=board_id%>+"&list_id="+<%=list_id%>;
			top.location.href=link;
			//parent.parent.parent.top.name_check_conform(link);
			//parent.opener.top.name_check_conform(link);
		} else {
			var link="./board_view.jsp?board_id="+<%=board_id%>+"&list_id="+<%=list_id%>;
			top.location.href=link;
			//parent.parent.top.name_check_conform(link);
		}
	}
	
	window.onload=function() {
		formSubmit('<%=request.getParameter("type").replaceAll("<","").replaceAll(">","")%>')
	 
	}

	</script>
 