<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
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
 
String event_seq = String.valueOf(request.getParameter("event_seq"));

MediaManager mgr = MediaManager.getInstance();
String ccode="007000000000";
String mtype="V";

String searchField = "";		//�˻� �ʵ�
String searchString = "";		//�˻���
 

String order = StringUtils.defaultIfEmpty(request.getParameter("order"), "ocode");
String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

int listCnt = 5;				//������ ��� ����

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