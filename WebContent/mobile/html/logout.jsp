<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page session="true" %>

<%
	try{
 
		session.invalidate();
	 out.println("<script lagnuage='javascript'>window.top.frames.location.replace('/mobile/html/main.jsp');</script>");

		/*  out.println("<script lagnuage='javascript'>location.href:'/mobile2/html/main.jsp'</script>"); */

		/* out.println("<script type='text/javascript'>");
		out.println("alert('�α׾ƿ� �Ǿ����ϴ�.')");
		out.println("location.href:'/mobile2/html/main.jsp'");
		out.println("</script>"); */
		
	}
	catch(Exception e)
	{
		session.invalidate();
		out.println("<script language=javascript > alert('�α׾ƿ� ����');window.top.frames.location.replace('/');</script>");
	}
%>
