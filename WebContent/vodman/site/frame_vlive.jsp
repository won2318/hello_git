<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*,com.yundara.util.*,com.vodcaster.utils.TextUtil"%>
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
	MediaManager mgr = MediaManager.getInstance();

	Vector vt = mgr.getRMediaListAll();


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
<script language="javascript">
	function f_code(){
		pcd = document.frmName.ocode.value;

		if(pcd != "") {
			parent.document.frmMedia.ocode.value = pcd;
		}
	}

</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#e0ebfb">
<table width="300" height="21" border="0" cellpadding="0" cellspacing="0" >
<tr>
    <td><form name=frmName>

        <select name=ocode onchange="javascript:f_code();" class="inputG" style="width:300px">
          <option value='none'>--- 미디어 선택 ---</option>

				<%
					
					LiveInfoBean rinfo = new LiveInfoBean();

                    if(vt.size() > 0){

                        try{
                            for(int i = 0; i < vt.size(); i++) {

								com.yundara.beans.BeanUtils.fill(rinfo, (Hashtable)vt.elementAt(i));

                                String otitle = String.valueOf(rinfo.getRtitle());
                                int str_l = 25;
                                if(otitle.length() > str_l) {
                                    otitle = otitle.substring(0,str_l-1) + "...";
                                }
				%>
					  <option value="<%=rinfo.getRcode()%>"><%=otitle%></option>
                      

				<%
					        }
                        }catch(Exception e) {}
                    }


				%>
				</select>
</form>
</td>
</tr>
</table>

</body>
</html>