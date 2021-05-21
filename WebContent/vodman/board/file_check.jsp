<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*"%>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
<%
request.setCharacterEncoding("euc-kr");
	
	boolean flag = false;
	String file_name = request.getParameter("file_name").replaceAll("<","").replaceAll(">","");
	String file_flag = request.getParameter("file_flag").replaceAll("<","").replaceAll(">","");
	String file_type = "";
	
	if(file_flag.equals("list_data_file")) {
		file_type = "ATTACH";
	} else {
		file_type = "IMG";
	}

	
	String extension = BoardListSQLBean.getExtension(file_name);
 	
	flag = com.vodcaster.utils.TextUtil.getEnableExtension(extension, file_type);
	
	if(!flag) {
%>
		<script language="javascript">
			alert("입력하신 파일은 업로드 될 수 없습니다!");
			parent.clearFile('<%=file_flag%>');
		</script>
<%
	}
%>