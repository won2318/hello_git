<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String type  = requestReplace(request.getParameter("param_r1"), ""); //type
    String board_id  = requestReplace(request.getParameter("param_r2"), ""); // board_id
    String list_id  = requestReplace(request.getParameter("param_r3"), ""); // list_id

    String sSiteCode = "G0549";				   // NICE로부터 부여받은 사이트 코드
    String sSitePassword = "WO2WPZ6UULCU";			 // NICE로부터 부여받은 사이트  

    String sCipherTime = "";				 // 복호화한 시간
    String sRequestNumber = "";			 // 요청 번호
    String sResponseNumber = "";		 // 인증 고유번호
    String sAuthType = "";				   // 인증 수단
    String sName = "";							 // 성명
    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
    String sBirthDate = "";					 // 생일
    String sGender = "";						 // 성별
    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
    String sMessage = "";
    String sPlainData = "";
    
	String result_temp="tv.suwon.go.kr";
    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();
        
        // 데이타를 추출합니다.
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
	    // 휴대폰 번호 : MOBILE_NO => (String)mapresult.get("MOBILE_NO");
		// 이통사 정보 : MOBILE_CO => (String)mapresult.get("MOBILE_CO");
		// checkplus_success 페이지에서 결과값 null 일 경우, 관련 문의는 관리담당자에게 하시기 바랍니다.        
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
            sResponseNumber = "";
            sAuthType = "";
        }
    }
    else if( iReturn == -1)
    {
        sMessage = "복호화 시스템 에러입니다.";
    }    
    else if( iReturn == -4)
    {
        sMessage = "복호화 처리오류입니다.";
    }    
    else if( iReturn == -5)
    {
        sMessage = "복호화 해쉬 오류입니다.";
    }    
    else if( iReturn == -6)
    {
        sMessage = "복호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else if( iReturn == -12)
    {
        sMessage = "사이트 패스워드 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
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
					out.println("alert('확인 되었습니다!')");
					//out.println("parent.opener.top.name_check_conform('"+result_temp+"');"); //http 로 보낼경우 바로 이동
					out.println("window.top.location.href='https://tv.suwon.go.kr/include/check_name_return.html'");  // https 로 보낼경우 받아서 다시 이동
					//out.println("window.location.href='http://tv.suwon.go.kr/include/check_name_return.jsp';");  // https 로 보낼경우 받아서 다시 이동
					//out.println("opener.location.href='"+result_temp+"';");
					//out.println("parent.win_close();");
					out.println("</script>");
				
				
			} else {
				out.println("<script>");
				out.println("alert('확인 되었습니다.')");
				out.println("	window.open('"+result_temp+"','cyber_poll', 'width=630,height=650,scrollbars=yes')");
				out.println("parent.win_close();");
				out.println("</script>");
			} 
} else {

				out.println("<script>");
				out.println("alert('오류가 발생하엿습니다. 다시 시도해주세요')");
				
				out.println("parent.win_close();");
				out.println("</script>");
}
%>