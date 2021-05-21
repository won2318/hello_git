	<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<%
	if(session.getAttribute("vod_id")==null)
	{
		contact.setValue(request.getRemoteAddr(),"guest", "W");
	}
	else
	{
		contact.setValue(request.getRemoteAddr(),(String)session.getAttribute("vod_id"), "W");
	}
%>