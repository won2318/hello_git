<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%
 
out.println(return_value_main(request.getQueryString())); // 특수문자 SQL 삽입 공격 체크
String temp_reqURL=request.getRequestURL().toString();
String temp_queryString = request.getQueryString();
 
if (temp_reqURL != null && temp_reqURL.length() > 0 && temp_reqURL.contains("tv.suwon.ne.kr")) {
	 temp_reqURL = temp_reqURL.replaceAll("tv.suwon.ne.kr","tv.suwon.go.kr");
	if (temp_queryString != null && temp_queryString.length() > 0) {
	
		temp_reqURL = temp_reqURL+"?"+temp_queryString;
	} 
	 
	out.println("<script>location.href = '"+temp_reqURL+"';</script>");
}
%>
<%!

public String return_value_main ( String para_value){
	
	 if( para_value !=null && para_value.length() > 0) {
	    	String temp_par_value=para_value;
	    	temp_par_value = temp_par_value.replaceAll("\"","").replaceAll(";","").replaceAll("'","&#39;");
	    	if (para_value.equals(temp_par_value)) {
	    		return "";
	    	} else{
	    		 String temp_return_string="<script>"+
	    		"alert( ' NOT USE!!    RETURN TO MAIN! '); "+
	    		"location.href='/';"+
	    		"</script>"+
				"<noscript>"+
				"죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> "+
				"일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> "+
				"<a href='/2013/main/main.jsp'>메인화면으로 이동</a>"+
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
<title>수원 iTv - 사람이 반갑습니다</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta NAME="title" content="수원 iTv">
<meta NAME="description" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원">
<meta NAME="Keywords" content="수원 iTv, 사람이 반갑습니다, 휴먼시티 수원">
</head>
<% 
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
	  
	 		//out.println("<script>location.href = '/2013/main/main.jsp';</script>");
	 
	}else {
		out.println("<script>location.href = 'http://mnews.suwon.go.kr/mobile/html/main.jsp';</script>");
	} 

%> 
<meta http-equiv="Refresh" content="1; URL=http://tv.suwon.go.kr/2013/main/main.jsp">
		
		
</html>
