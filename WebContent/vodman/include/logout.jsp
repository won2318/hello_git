<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page session="true" %>

<%
	try{
		
		
		//session.putValue("LOGOUT", String.valueOf("Y"));
		session.invalidate();
		out.println("<script lagnuage='javascript'>window.top.frames.location.replace('/');</script>");
	}
	catch(Exception e)
	{
		session.invalidate();
		out.println("<script language=javascript > alert('�α׾ƿ� ����');window.top.frames.location.replace('/');</script>");
	}
%>
