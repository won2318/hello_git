<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
	<%  if(live_v != null && live_v.size() > 0) {
		String mobile_stream = String.valueOf(live_v.elementAt(21));
		
		String tmpIP = DirectoryNameManager.SV_LIVE_SERVER_IP ;
		 
		if(protocal.equals("Android")){
			live_url="rtsp://"+tmpIP+ ":1935"+mobile_stream;
		 }else if(protocal.equals("iPhone")){ 
			 live_url="http://"+tmpIP + ":1935/"+mobile_stream +"/playlist.m3u8";
		} 
	%>
	
		<div class="mLive" id="live_check_img">
			<a href="<%=live_url%>" onclick="live_log('<%=live_v.elementAt(0)%>');"><span class="onair">ON-AIR</span><strong>����� ��û�ϱ�</strong></a>
		</div><!--//����۾ȳ�(������� �������� ǥ��:mLive-->

	<%} else { %>
		<%
		 if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && request.getRequestURI().indexOf("iNews_list.jsp")> -1 ) {
		%>
<%--		<div class="newsHome"><a href="http://news.suwon.go.kr">e-�������� PC����</a></div> --%>
		<%
		}else{
		%>
		<div class="mLive live_no" id="live_check_img">
			<a href="LiveSchedule.jsp"><span class="onair_no">OFF</span><strong>����� �ȳ�</strong></a>
		</div><!--//����۾ȳ�(������� �������� ǥ��:mLive-->
		<%
		}
		%>
	<% }%>