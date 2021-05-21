<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
 
<%
if(!chk_auth(vod_id, vod_level, "m_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 최 희 성
	 *
	 * @description : 회원정보생성을 위한 정보를 입력받아 처리하는 페이지
	 * date : 2005-01-10
	 */
	 request.setCharacterEncoding("EUC-KR");
	

Vector vt = null;
 
String event_seq = String.valueOf(request.getParameter("event_seq"));

MediaManager mgr = MediaManager.getInstance();
String ccode="007000000000";
String mtype="V";

String searchField = "";		//검색 필드
String searchString = "";		//검색어
 

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "ocode");
String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

int listCnt = 5;				//페이지 목록 갯수

if(request.getParameter("searchField") != null  && request.getParameter("searchField").length() > 0 )
	searchField = com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchField"));

if(request.getParameter("searchString") != null && request.getParameter("searchString").length() > 0 )
	searchString = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchString")));

vt = mgr.getOMediaListAll_admin_cateExcel(ccode,  mtype,   order, searchField,  searchString,  direction ,  event_seq);
%>
<textarea name="ucc_event_rank" id="ucc_event_rank" cols="150" rows="30"><%
try {
	 if (vt != null && vt.size() > 0) {
			for(int i = 0; i < vt.size() ; i++) {
%><%=((Vector)(vt.elementAt(i))).elementAt(0)%>위, 이름: <%=((Vector)(vt.elementAt(i))).elementAt(1)%> , 연락처: <%=com.security.SEEDUtil.getDecrypt(((Vector)(vt.elementAt(i))).elementAt(2).toString())%>, 이메일: <%=com.security.SEEDUtil.getDecrypt(((Vector)(vt.elementAt(i))).elementAt(3).toString())%>, 제목: <%=((Vector)(vt.elementAt(i))).elementAt(4)%>
<%} } else {%>
			 
		<%}  
} catch(Exception e) {}
	%></textarea>	
<script>
function rank_copy(){ 
	  
	var f=document.getElementById("ucc_event_rank");
 	f.select() ;
    therange=f.createTextRange() ;
    therange.execCommand("Copy");
	alert("복사 되었습니다. CTRL + V 로 붙여넣기 하시면 됩니다.");

}
</script>
<body onload="rank_copy();">
</body>