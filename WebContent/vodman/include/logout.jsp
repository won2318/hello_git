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
		out.println("<script language=javascript > alert('로그아웃 에러');window.top.frames.location.replace('/');</script>");
	}
%>
