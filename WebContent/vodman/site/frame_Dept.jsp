<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*,com.vodcaster.utils.TextUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>
<%
if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 최희성
	 *
	 * description : vod 전체정보를 보여줌.
	 * date : 2005-01-25
	 */
	 
	 request.setCharacterEncoding("EUC-KR");

	BuseoManager Bmgr = BuseoManager.getInstance();
	BuseoInfoBean b_info = new BuseoInfoBean();        
	Vector b_vt = Bmgr.getBuseo_ListAll();

 

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
</head>
<script language="javascript">
	function f_code(){
		pcd = document.frmName.dept.value;

		if(pcd != "") {
			parent.document.frmMedia.dept.value = pcd;
		}
	}

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#e0ebfb">
<table width="200" height="21" border="0" cellpadding="0" cellspacing="0" >
<tr>
    <td><form name="frmName">

<select name="dept" class="inputG" style="width:200px" onchange="f_code();">
<OPTION VALUE=""> == 부서 선택 == </option>

<%

	try 
	{
		if (b_vt.size() > 0 ) {
			for(int k = 0;k<b_vt.size(); k++ ){
        		com.yundara.beans.BeanUtils.fill(b_info, (Hashtable)b_vt.elementAt(k));
			 				out.println("<OPTION VALUE="+b_info.getBuseo_code()+">"+b_info.getBuseo_name()+"</option>");
			 			 }	
		}
		 
 
	} catch(Exception e){
 		out.println(e.getMessage());
 	}
 
%>
</SELECT>
</form>
</td>
</tr>
</table>

</body>
</html>