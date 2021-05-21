<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page language="java" import="SafeNC.kisinfo.*,KISINFO.VNO.*;"%>
<%
request.setCharacterEncoding("euc-kr");
String result_url  = request.getParameter("result_url").trim();
String result_temp = ""; 

if (result_url != null && result_url.length() > 0) {
	result_temp = result_url.replaceAll("::","&");
	//out.println(result_url+"::"); 
}
 
if (result_url != null && result_url.contains("type=write")) {
	result_temp = "/2013/board/board_write.jsp?"+result_temp;
}else if (result_url != null && result_url.contains("type=update") ) {
	result_temp = "/2013/board/board_update.jsp?"+result_temp;
}else if ( result_url != null && result_url.contains("type=delete") ) {
	result_temp = "/2013/board/proc_boardListDelete.jsp?"+result_temp;
}else if (result_url != null && result_url.contains("type=2017_write")) {
	result_temp = "/2017/board/board_write.jsp?"+result_temp;
}else if (result_url != null && result_url.contains("type=2017_update") ) {
	result_temp = "/2017/board/board_update.jsp?"+result_temp;
}else if ( result_url != null && result_url.contains("type=2017_delete") ) {
	result_temp = "/2017/board/proc_boardListDelete.jsp?"+result_temp;
}else if (result_url != null && result_url.contains("type=mobile_write")) {
	result_temp = "/mobile/board_write.jsp?"+result_temp;
}else if (result_url != null && result_url.contains("type=mobile_update") ) {
	result_temp = "/mobile/board/board_update.jsp?"+result_temp;
}else if ( result_url != null && result_url.contains("type=mobile_delete") ) {
	result_temp = "/mobile/board/proc_boardListDelete.jsp?"+result_temp;
}
 
%>

<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<HEAD>
<TITLE> ������ ���ͳ� ��� </TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
 
</HEAD>

<body bgcolor="#f9faf9" topmargin="0" leftmargin="0"> 
 
<jsp:useBean id="safeNC" class="SafeNC.kisinfo.SafeNCCipher" scope="request" />
<%

//**********************************************************************************************
//�ѱ��ſ������� ��������� �ȽɽǸ�Ȯ�� ����
//�ۼ��� : 2006.10.23
//**********************************************************************************************

String enc_data = "";
String sMsg = "";

enc_data = request.getParameter("enc_data");		//��ȣȭ�� ����Ÿ

//out.println("���ϵ���Ÿ : " + enc_data + "<br><br><br>");

if (enc_data != "") {
  //  SafeNCCipher safeNC = new SafeNCCipher();
    
	//**********************************************************************************************
	// ReturnURL�κ��� ���ŵ� ��ȣȭ ������(AES_CBC_PAD, SHA256, BASE64 Encoded Data)	
	// �޼ҵ带 ȣ���Ͽ� ��ȣȭ�� ���� �����ɴϴ�.
	//**********************************************************************************************	    
  int iReturn = safeNC.response(enc_data);		
    
    if( iReturn > 0 ) {                      
		if (iReturn == 1) {		
			sMsg = "���θ���";

			   VNOInterop vnoInterop = new VNOInterop();
				int iReturn2 = vnoInterop.fnRequest("A887", "47703180",  safeNC.getSafeID(), "SID");
			if ( iReturn2 == 1 ) {
 
			   session.putValue("vod_id",  vnoInterop.getDupInfo());
			   session.putValue("vod_name", safeNC.getUserName());
			   session.putValue("birthDate", safeNC.getJuminDate());
			   session.putValue("user_key",  vnoInterop.getDupInfo());
			   session.putValue("vod_level", "1");
			   session.putValue("vod_target", "namecheck");
			   session.putValue("name_check_url", result_temp);
			   session.setMaxInactiveInterval(3600);
			}

 


			if (result_url != null && result_url.contains("type=")) {
			//response.sendRedirect("http://tv.suwon.go.kr/include/check_name_return.jsp");
				out.println("<script>");
				out.println("alert('Ȯ�� �Ǿ����ϴ�!')");
				//out.println("parent.opener.top.name_check_conform('"+result_temp+"');"); //http �� ������� �ٷ� �̵�
				out.println("window.top.location.href='https://tv.suwon.go.kr/include/check_name_return.html'");  // https �� ������� �޾Ƽ� �ٽ� �̵�
				//out.println("window.location.href='http://tv.suwon.go.kr/include/check_name_return.jsp';");  // https �� ������� �޾Ƽ� �ٽ� �̵�
				//out.println("opener.location.href='"+result_temp+"';");
				//out.println("parent.win_close();");
				out.println("</script>");
			} else if (result_url != null && result_url.contains("type=2017")) {  //2017 �ű� ������
			
				out.println("<script>");
				out.println("alert('Ȯ�� �Ǿ����ϴ�!')");
				out.println("parent.opener.top.name_check_conform('"+result_temp+"');"); //http �� ������� �ٷ� �̵�
				out.println("parent.win_close();");
				out.println("</script>");
			}else if (result_url != null && result_url.contains("type=mobile")) {  // ����� ������
			
				out.println("<script>");
				out.println("alert('Ȯ�� �Ǿ����ϴ�!')");
				out.println("parent.opener.top.name_check_conform('"+result_temp+"');"); //http �� ������� �ٷ� �̵�
				out.println("parent.win_close();");
				out.println("</script>");
			 
			} else {
				out.println("<script>");
				out.println("alert('Ȯ�� �Ǿ����ϴ�.')");
				out.println("	window.open('"+result_temp+"','cyber_poll', 'width=630,height=650,scrollbars=yes')");
				out.println("parent.win_close();");
				out.println("</script>");
			} 

		}else if (iReturn == 2){	
			sMsg = "���ξƴ�";
		}else if (iReturn == 3) {		
		   sMsg = "�ڷ����";      
		}else if (iReturn == 4) {	
		   sMsg = "�ý��ۿ���";      
		}else if (iReturn == 5) {		
		   sMsg = "üũ������";      
		}else if (iReturn == 10) {
		   sMsg = "����Ʈ�ڵ����";      
		}else if (iReturn == 11) {
		   sMsg = "�ߴܵȻ���Ʈ";      
		}else if (iReturn == 12) {	
		   sMsg = "��й�ȣ����";      
		}else{
			sMsg = "��Ÿ�����Դϴ�." ;     
		}

	}		    	    	
}else{
	out.println ("ó���� ����Ÿ�� �����ϴ�.");
}

%>
</BODY>
</HTML>