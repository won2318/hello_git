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

		GrayManager Gmgr = GrayManager.getInstance();
		GrayInfoBean g_info = new GrayInfoBean();
		Vector g_vt = Gmgr.getGray_ListAll();

 
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
</head>
<script language="javascript">
	function f_code(){
		pcd = document.frmName.grade.value;

		if(pcd != "") {
			parent.document.frmMedia.grade.value = pcd;
		}
	}

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#e0ebfb">
<table width="200" height="21" border="0" cellpadding="0" cellspacing="0" >
<tr>
    <td><form name="frmName">

<select name="grade" class="inputG" style="width:200px"  onchange="f_code();">

<OPTION VALUE=""> == 직급 선택 ==  </option>

<%
 

	try 
	{
		if ( g_vt != null && g_vt.size() > 0){
 
			for(int j = 0;j<g_vt.size(); j++ ){
        		com.yundara.beans.BeanUtils.fill(g_info, (Hashtable)g_vt.elementAt(j));
        	    
        	    	out.println("<OPTION VALUE="+g_info.getGray_code()+">"+g_info.getGray_name()+"</option>");
 
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