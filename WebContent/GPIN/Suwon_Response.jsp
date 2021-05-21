<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%!
    String getSession(HttpSession session, String attrName)
    {
        return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>

<%!
public static String requestReplace (String paramValue, String gubun) {
        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
%> 

 
<%
    String type  = requestReplace(request.getParameter("type"), ""); //type
    String board_id  = requestReplace(request.getParameter("board_id"), ""); // board_id
    String list_id  = requestReplace(request.getParameter("list_id"), ""); // list_id
	String result_temp  = "tv.suwon.go.kr";
	if (type != null && type.length() > 0 && type.equals("write")) {
		result_temp = "/2013/board/board_write.jsp?board_id="+board_id;	 
	}else if ( type != null && type.length() > 0 && type.equals("update") ) {
		result_temp = "/2013/board/board_update.jsp?board_id="+board_id+"&list_id="+list_id;
	}else if ( type != null && type.length() > 0 && type.equals("delete") ) {
		result_temp = "/2013/board/proc_boardListDelete.jsp?board_id="+board_id+"&list_id="+list_id;
	
	}else if (type != null && type.length() > 0 && type.equals("2017_write")) {
		result_temp = "/2017/board/board_write.jsp?board_id="+board_id;	 
	}else if ( type != null && type.length() > 0 && type.equals("2017_update") ) {
		result_temp = "/2017/board/board_update.jsp?board_id="+board_id+"&list_id="+list_id;
	}else if ( type != null && type.length() > 0 && type.equals("2017_delete") ) {
		result_temp = "/2017/board/proc_boardListDelete.jsp?board_id="+board_id+"&list_id="+list_id;
		
	}else if (type != null && type.length() > 0 && type.equals("mobile_write")) {
		result_temp = "/mobile/html/board_write.jsp?board_id="+board_id;	 
	}else if ( type != null && type.length() > 0 && type.equals("mobile_update") ) {
		result_temp = "/mobile/html/board_update.jsp?board_id="+board_id+"&list_id="+list_id;
	}else if ( type != null && type.length() > 0 && type.equals("mobile_delete") ) {
		result_temp = "/mobile/html/proc_boardListDelete.jsp?board_id="+board_id+"&list_id="+list_id;
		
	} else if ( type != null && type.length() > 0 && type.equals("event")){
		result_temp = "/2013/research/research.jsp?sub_flag="+board_id;
	}
 

    /**
     * Sample-AuthRequest �� ���� ��������� �Ϸ��� session�� ����� ����������� �������� �������Դϴ�.
     * Sample-AuthRequest���� ������������ ������ ���־�� ����Ǹ� �������� �׸��� ���� ������ ���̵带�����Ͻñ�ٶ��ϴ�.
     */
    // ���� ���Ž� ��ûó�� ������ ��ġ������ session�� ������ ��û�� IP�� ���մϴ�.
	if (request.getRemoteAddr().equals(session.getAttribute("gpinUserIP")))
	{
			   session.putValue("vod_id",  getSession(session, "dupInfo") );
			   session.putValue("vod_name", getSession(session, "realName") );
			   session.putValue("birthDate", getSession(session, "birthDate") );
			   session.putValue("user_key",  getSession(session, "dupInfo") );
			   session.putValue("vod_level", "1");
			   session.putValue("vod_target", "namecheck");
			   session.putValue("name_check_url", result_temp);
			   session.setMaxInactiveInterval(3600);

			   if (type != null && type.length() > 0 && !type.equals("event")) {
			
				if (type.contains("2017") || type.contains("mobile")) {
					out.println("<script>");
					out.println("top.location.href='"+result_temp+"';");
					out.println("parent.win_close();");
					out.println("</script>");
				} else {  //���� ������ ��ũ
					//response.sendRedirect("http://tv.suwon.go.kr/include/check_name_return.jsp");
					out.println("<script>");
					//out.println("alert('Ȯ�� �Ǿ����ϴ�!')");
					out.println("top.name_check_conform('"+result_temp+"');"); //http �� ������� �ٷ� �̵�
					//out.println("location.href='"+result_temp+"';");
					//out.println("parent.win_close();");
					out.println("</script>");
				}
			} else {
				out.println("<script>");
				out.println("alert('Ȯ�� �Ǿ����ϴ�.')");
				out.println("	window.open('"+result_temp+"','cyber_poll', 'width=630,height=650,scrollbars=yes')");
				out.println("self.close();");
				out.println("</script>");
			} 
	}
	else
	{
 			    out.println("<script>");
				out.println("alert('������ �߻��Ͽ����ϴ�. �ٽ� �õ����ּ���!')");
				out.println("self.close();");
				out.println("</script>");
	}
	%>

 