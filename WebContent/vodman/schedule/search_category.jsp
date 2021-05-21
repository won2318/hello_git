<%@page import="com.hrlee.sqlbean.CategoryManager"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*,com.hrlee.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
/**
* @author 최희성
*
* @description : 회원의 전체정보를 보여줌.
* date : 2005-01-07
*/

	String ctype = "";
	String strTitle = "";
	int num = 1;
	
	if(request.getParameter("ctype") != null) {
		ctype = String.valueOf(request.getParameter("ctype"));
	}else
		ctype = "V";
	
	
	CategoryManager mgr = CategoryManager.getInstance();
	Vector vt = mgr.getCategoryListALL2(ctype,"V"); 

%>

<html>

<head>
	<title>Destroydrop &raquo; Javascripts &raquo; Tree</title>

	<link rel="StyleSheet" href="dtree.css" type="text/css" />
	<script type="text/javascript" src="dtree.js"></script>

<script language="javascript">
<!--
	function give_cate(ccode) {
		top.search_media.document.frmMedia.ccode.value = ccode;
		top.search_media.document.frmMedia.submit();
	}
//-->
</script>


</head>

<body bgcolor="#f9f9f9" style="overflow-x: hidden;" width="200">


<div class="dtree">
	<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>
	<script type="text/javascript">
		<!--

		d = new dTree('d');

		d.add(0,-1,'전체카테고리','javascript:give_cate(\'\');');
<%
	int list = 1;
	CategoryInfoBean info = new CategoryInfoBean();
	for(Enumeration e = vt.elements(); e.hasMoreElements(); list++) {
		com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
		if(String.valueOf( info.getCinfo() ).equals("A")) {
%>
		d.add(<%=info.getCcode()%>,0,'<%=info.getCtitle()%>','javascript:give_cate(\'<%=info.getCcode()%>\');');
<%
		} else if(String.valueOf( info.getCinfo() ).equals("B")) {
%>
		d.add(<%=info.getCcode()%>,<%=info.getCparent_code()%>,'<%=info.getCtitle()%>','javascript:give_cate(\'<%=info.getCcode()%>\');');
<%
		} else if(String.valueOf( info.getCinfo() ).equals("C")) {
%>
		d.add(<%=info.getCcode()%>,<%=info.getCparent_code()%>,'<%=info.getCtitle()%>','javascript:give_cate(\'<%=info.getCcode()%>\');');
<%
		}
	}
%>

		
		document.write(d);

		//-->
	</script>

</div>
</body>

</html>