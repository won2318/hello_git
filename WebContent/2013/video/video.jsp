<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%
// 기존 URL 복사 퍼가기 기능 유기를 위한 페이지 입니다.

out.println(return_value_main(request.getQueryString())); // 특수문자 SQL 삽입 공격 체크
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
				"<a href='/2012/main/main.jsp'>메인화면으로 이동</a>"+
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
String ocode = "";

if ( request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0  && com.yundara.util.TextUtil.isNumeric(request.getParameter("ocode"))) {
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
	   
		out.println("<script>location.href = '/2013/main/main_link.jsp?link_ocode="+ocode+"';</script>");
	 
	}else {
		out.println("<script>location.href = 'http://mnews.suwon.go.kr/mobile/html/vod_view.jsp?ocode="+ocode+"';</script>");
	} 

%>  
		
</html>
