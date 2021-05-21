<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
 
<%@ include file = "/vodman/include/auth.jsp"%>
 
<%
if(!chk_auth(vod_id, vod_level, "m_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author �� �� ��
	 *
	 * @description : ȸ������������ ���� ������ �Է¹޾� ó���ϴ� ������
	 * date : 2005-01-10
	 */
	 request.setCharacterEncoding("EUC-KR");
	

Vector vt = null;

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "list_id");
	String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

String field = com.vodcaster.utils.TextUtil.getValue(request.getParameter("field"));
String searchstring = "";
try{
	searchstring = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchstring")));
}catch(Exception ex){
	searchstring = "";
}
if(field == null) field = "";
if(searchstring == null) searchstring = "";

int pg = 1;
if(request.getParameter("page") != null && com.yundara.util.TextUtil.isNumeric(request.getParameter("page"))){
	try{
		Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("page")));
	}catch(Exception ex){
		pg =1;
	}
}
String event_seq = "";
if (request.getParameter("event_seq") != null && request.getParameter("event_seq").length() > 0  && !request.getParameter("event_seq").equals("null")) {
	event_seq = com.vodcaster.utils.TextUtil.getValue(request.getParameter("event_seq"));
}

int board_id = 2; // �̺�Ʈ PHOTO

vt = BoardListSQLBean.getAllBoardList_admin_eventExcel(board_id, field, searchstring, "", event_seq, order, direction );

%>
<textarea name="ucc_event_rank" id="ucc_event_rank" cols="150" rows="30"><%
try {
	 if (vt != null && vt.size() > 0) {
			for(int i = 0; i < vt.size() ; i++) {
%><%=((Vector)(vt.elementAt(i))).elementAt(0)%>��, �̸�: <%=((Vector)(vt.elementAt(i))).elementAt(1)%> , ����ó: <%=com.security.SEEDUtil.getDecrypt(((Vector)(vt.elementAt(i))).elementAt(2).toString())%>, �̸���: <%=com.security.SEEDUtil.getDecrypt(((Vector)(vt.elementAt(i))).elementAt(3).toString())%>, ����: <%=((Vector)(vt.elementAt(i))).elementAt(4)%>
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
	alert("���� �Ǿ����ϴ�. CTRL + V �� �ٿ��ֱ� �Ͻø� �˴ϴ�.");

}
</script>
<body onload="rank_copy();">
</body>