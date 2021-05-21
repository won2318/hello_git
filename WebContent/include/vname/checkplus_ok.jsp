<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String type  = requestReplace(request.getParameter("param_r1"), ""); //type
    String board_id  = requestReplace(request.getParameter("param_r2"), ""); // board_id
    String list_id  = requestReplace(request.getParameter("param_r3"), ""); // list_id

    String sSiteCode = "G0549";				   // NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = "WO2WPZ6UULCU";			 // NICE�κ��� �ο����� ����Ʈ  

    String sCipherTime = "";				 // ��ȣȭ�� �ð�
    String sRequestNumber = "";			 // ��û ��ȣ
    String sResponseNumber = "";		 // ���� ������ȣ
    String sAuthType = "";				   // ���� ����
    String sName = "";							 // ����
    String sDupInfo = "";						 // �ߺ����� Ȯ�ΰ� (DI_64 byte)
    String sConnInfo = "";					 // �������� Ȯ�ΰ� (CI_88 byte)
    String sBirthDate = "";					 // ����
    String sGender = "";						 // ����
    String sNationalInfo = "";       // ��/�ܱ������� (���߰��̵� ����)
    String sMessage = "";
    String sPlainData = "";
    
	String result_temp="tv.suwon.go.kr";
    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();
        
        // ����Ÿ�� �����մϴ�.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
        
        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sResponseNumber = (String)mapresult.get("RES_SEQ");
        sAuthType 			= (String)mapresult.get("AUTH_TYPE");
        sName 					= (String)mapresult.get("NAME");
        sBirthDate 			= (String)mapresult.get("BIRTHDATE");
        sGender 				= (String)mapresult.get("GENDER");
        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
        sDupInfo 				= (String)mapresult.get("DI");
        sConnInfo 			= (String)mapresult.get("CI");
	    // �޴��� ��ȣ : MOBILE_NO => (String)mapresult.get("MOBILE_NO");
		// ����� ���� : MOBILE_CO => (String)mapresult.get("MOBILE_CO");
		// checkplus_success ���������� ����� null �� ���, ���� ���Ǵ� ��������ڿ��� �Ͻñ� �ٶ��ϴ�.        
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "���ǰ��� �ٸ��ϴ�. �ùٸ� ��η� �����Ͻñ� �ٶ��ϴ�.";
            sResponseNumber = "";
            sAuthType = "";
        }
    }
    else if( iReturn == -1)
    {
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }    
    else if( iReturn == -4)
    {
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }    
    else if( iReturn == -5)
    {
        sMessage = "��ȣȭ �ؽ� �����Դϴ�.";
    }    
    else if( iReturn == -6)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }    
    else if( iReturn == -12)
    {
        sMessage = "����Ʈ �н����� �����Դϴ�.";
    }    
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
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
if ( iReturn == 0 ) {

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
		
			} else if ( type != null && type.length() > 0 && type.equals("event")) {
				result_temp = "/2013/research/research.jsp?sub_flag="+board_id;
			}

  

			   session.putValue("vod_id",  sDupInfo);
			   session.putValue("vod_name", sName);
			   session.putValue("birthDate", sBirthDate);
			   session.putValue("user_key",  sDupInfo);
			   session.putValue("vod_level", "1");
			   session.putValue("vod_target", "namecheck");
			   session.putValue("name_check_url", result_temp);
			   session.setMaxInactiveInterval(3600);
		
 

			if (type != null && type.length() > 0 && !type.equals("event")) {
				
					//response.sendRedirect("http://tv.suwon.go.kr/include/check_name_return.jsp");
					out.println("<script>");
					out.println("alert('Ȯ�� �Ǿ����ϴ�!')");
					//out.println("parent.opener.top.name_check_conform('"+result_temp+"');"); //http �� ������� �ٷ� �̵�
					out.println("window.top.location.href='https://tv.suwon.go.kr/include/check_name_return.html'");  // https �� ������� �޾Ƽ� �ٽ� �̵�
					//out.println("window.location.href='http://tv.suwon.go.kr/include/check_name_return.jsp';");  // https �� ������� �޾Ƽ� �ٽ� �̵�
					//out.println("opener.location.href='"+result_temp+"';");
					//out.println("parent.win_close();");
					out.println("</script>");
				
				
			} else {
				out.println("<script>");
				out.println("alert('Ȯ�� �Ǿ����ϴ�.')");
				out.println("	window.open('"+result_temp+"','cyber_poll', 'width=630,height=650,scrollbars=yes')");
				out.println("parent.win_close();");
				out.println("</script>");
			} 
} else {

				out.println("<script>");
				out.println("alert('������ �߻��Ͽ����ϴ�. �ٽ� �õ����ּ���')");
				
				out.println("parent.win_close();");
				out.println("</script>");
}
%>