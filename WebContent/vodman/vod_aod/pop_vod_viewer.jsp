<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ page import="com.hrlee.sqlbean.MediaManager"%>
 <jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
 
<%--
<%
if(!chk_auth(vod_id, vod_level, "v_content")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다.');\n" +
                "window.close();\n" +
                "</script>");
    return;
}
%>
--%>
<%
request.setCharacterEncoding("euc-kr");
	CategoryManager cmgr = CategoryManager.getInstance();
	MediaManager mgr = MediaManager.getInstance();
	Hashtable result_ht = null;
	String strMenuName = "";

 

	String ocode ="";
	if (request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0  && !request.getParameter("ocode").equals("null")) {
		ocode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ocode"));
	}

 
	
	boolean isView = true;
	boolean bOmibean = false;
	
	Vector vo = null;
	if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
		vo = mgr.getOMediaInfo_admin(ocode);

	} 
	int auth_v = 0;
	if (vo != null && vo.size() > 0) {
		try {
			Enumeration e2 = vo.elements();
			com.yundara.beans.BeanUtils.fill(omiBean, (Hashtable) e2.nextElement());
			bOmibean = true;
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
			isView = false;
		}
	} else {
		out.println("<script language='javascript'>\n" +
                "alert('요청하신 동영상 정보는 존재하지 않습니다. 창을 닫습니다.');\n" +
                "window.close();\n" +
                "</script>");
	}

	auth_v = omiBean.getOlevel();
	 
/*	
	if(auth_v > user_level) {
		 out.println("<script language='javascript'>\n" +
	                "alert('회원레벨에 제한이 있습니다.');\n" +
	                "window.close();\n" +
	                "</script>");
	}
*/
	String ofilename = "";
	if (StringUtils.isNotEmpty(omiBean.getFilename())) {
		ofilename = omiBean.getFilename();
		isView = true;
	} else {
		//미디어 아이디가 없는 경우 
		isView = false;
	}

 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<title>대전 인터넷방송 : 영상미리보기</title>
		<link href="/vodman/vod_aod/css/base.css" rel="stylesheet" type="text/css" />
 	</head>
<body id="popup_bg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<div id="preview_pop">
	<h3><img src="/vodman/vod_aod/images/vod_preview.gif" alt="영상 미리보기"/></h3>
	<div id="pop_top"></div>
	<div id="pop_cen">
		<div>
<%-- 		<iframe id="bestVod" name="bestVod" src="/silverPlayer_admin.jsp?ocode=<%=ocode%>&width=440&height=248&Server=<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME%>" scrolling='no' width="440" height="248" marginwidth='0' frameborder='0' framespacing='0' ></iframe> --%>
		<iframe id="bestVod" name="bestVod" src="/videoJs/vodmanjsPlayer_2017.jsp?ocode=<%=ocode%>&type=popup" scrolling='no' width="440" height="248" marginwidth='0' frameborder='0' framespacing='0' allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true"></iframe>
		</div>
		<table cellspacing="0" class="preview" summary="동영상 정보">
		
			<caption>동영상 정보</caption>
			<colgroup>
				<col width="65"/>
				<col width="225"/>
				<col width="60"/>
				<col width="50"/>
			</colgroup>
			<thead>
				<tr>
					<td class="font_140" colspan="2"><%=omiBean.getTitle()%></td>
				</tr>
			</thead>
			<tbody>
				<tr class="">
					<th>카테고리</th>
					 
					<td>
					 <%= cmgr.getCategoryName(omiBean.getCcode(), "V")%>
					</td>
				</tr>
				<tr>
					
					<th>조회</th>
					<td><b><%=omiBean.getHitcount()%></b></td>
				</tr>
				<tr class="">
					<td colspan="2"><textarea name="subject" class="area01" style="width:425px;height:40px;" cols="100" rows="100"><%=omiBean.getDescription()%></textarea></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="pop_bot"></div>
	<div class="but01">
		<a href="javascript:window.close();"><img src="/vodman/vod_aod/images/but_close.gif" alt="닫기"/></a>
	</div>		
</div>

</body>
</html>