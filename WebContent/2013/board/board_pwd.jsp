<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="com.vodcaster.sqlbean.DirectoryNameManager,com.vodcaster.utils.TextUtil"%>
<%@page import="com.security.SEEDUtil"%>
<%@ include file="/include/chkLogin.jsp" %>
 
<%
  
 		if(request.getParameter("list_passwd") != null && request.getParameter("list_passwd").length() > 0) { 
	 
	        try { 
	        	session.putValue("list_passwd", SEEDUtil.getEncrypt(request.getParameter("list_passwd")));
	
	        }catch(Exception e) {
	            System.out.println(e.getMessage());
	        }
 		} else {
 			
 		}
 
//out.println(request.getParameter("list_passwd")+"dddddd");
%>
	<script type="text/javascript" >
 
	function formSubmit(type){

		
		if (type != null && type=="delete") {
			if (confirm("삭제하시겠습니까")) {
				var link="./proc_boardListDelete.jsp?board_id="+<%=request.getParameter("board_id")%>+"&list_id="+<%=request.getParameter("list_id")%>;
				
				parent.parent.parent.top.name_check_conform(link);
			}
		} else if (type != null && type=="update") {
			var link="./board_update.jsp?board_id="+<%=request.getParameter("board_id")%>+"&list_id="+<%=request.getParameter("list_id")%>;
			parent.parent.parent.top.name_check_conform(link);
			//parent.opener.top.name_check_conform(link);
		} else {
			var link="./board_view.jsp?board_id="+<%=request.getParameter("board_id")%>+"&list_id="+<%=request.getParameter("list_id")%>;
			parent.parent.top.name_check_conform(link);
		}
	}
	
	window.onload=function() {
		formSubmit('<%=request.getParameter("type") %>')
	}

	</script>
 