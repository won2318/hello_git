<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%
 
out.println(return_value_main(request.getQueryString())); // Ư������ SQL ���� ���� üũ
%>
<%!

public String return_value_main ( String para_value){
	
	 if( para_value !=null && para_value.length() > 0) {
	    	String temp_par_value=para_value;
	    	temp_par_value = temp_par_value.replaceAll("\"","").replaceAll(";","").replaceAll("'","&#39;").replaceAll("<","").replaceAll(">","");
	    	if (para_value.equals(temp_par_value)) {
	    		return "";
	    	} else{
	    		 String temp_return_string="<script>"+
	    		"alert( ' NOT USE!!    RETURN TO MAIN! '); "+
	    		"location.href='/';"+
	    		"</script>"+
				"<noscript>"+
				"�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> "+
				"�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> "+
				"<a href='/2017/main/main.jsp'>����ȭ������ �̵�</a>"+
				"</noscript>";
	    		return temp_return_string;
	    	}
	    } else {
	    	return "";
	    }
}

  
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<html lang="ko"> 
<head>
<title>���� iTv - ����� �ݰ����ϴ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta NAME="title" content="���� iTv">
<meta NAME="description" content="���� iTv, ����� �ݰ����ϴ�, �޸ս�Ƽ ����">
<meta NAME="Keywords" content="���� iTv, ����� �ݰ����ϴ�, �޸ս�Ƽ ����">
 	
</head>
<% 
String ocode = "";

if ( request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0 ) {
	ocode = request.getParameter("ocode");
	if (ocode.length() < 16  ) {
	       ocode = MediaManager.getInstance().getReturn_ocode(ocode);
		} 
}
String userAgent = request.getHeader("user-agent");
	
	String apple[] = {"iPhone", "iPop", "iPad"};
	String android = "Android";
	
	String app = "";
	
	for(int i=0; i<apple.length; i++){
		if(StringUtils.indexOf(userAgent, apple[i]) > 0){
			app = "apple";
			break;
		}else if(StringUtils.indexOf(userAgent, android) > 0){
			app = "android";
		}else{
			app = "web";
		}
	}

	if(app.equals("web")){
		
		if (ocode != null && ocode.length() > 0) { 
			out.println("<script>location.href = '/2017/video/video_list.jsp?ocode="+ocode+"';</script>");
		} else if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0) {
			out.println("<script>location.href = '/2017/board_view.jsp?board_id="+request.getParameter("board_id")+"&list_id="+request.getParameter("list_id")+"';</script>");
		} else {
			out.println("<script>location.href = '/2017/main/main.jsp';</script>");
		}
	 
	}else {
		
		if (ocode != null && ocode.length() > 0) { 
			out.println("<script>location.href = '/mobile/html/vod_view.jsp?ocode="+ocode+"';</script>");
		} else if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0) {
			out.println("<script>location.href = '/mobile/html/board_view.jsp?board_id="+request.getParameter("board_id")+"&list_id="+request.getParameter("list_id")+"';</script>");
		} else {
			out.println("<script>location.href = '/mobile/html/main.jsp';</script>");
		}
		
	} 

%>  
		
</html>
