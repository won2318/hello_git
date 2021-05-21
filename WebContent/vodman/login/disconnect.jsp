<%
    /*
     * login_try.jsp에서 로그인 중복시 무시하고 로그인할경우 호출.
     * 기존의 session을 끊고 hashTable에 저장후 login_ok.jsp를 호출.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.login.LoginManager"%>
<%!
    //싱글톤 패턴을 사용하였기 때문에 생생되어있는 인스턴스를 얻어온다.
    LoginManager loginManager = LoginManager.getInstance(); 
%>
<html>
<head>
    <title>로그인 중복방지 Test</title>
</head>
<body>
<%
    String userId = (String)session.getAttribute("userId");
    if(userId != null){
        //기존의 접속(세션)을 끊는다.
        loginManager.removeSession(userId);
        
        //새로운 세션을 등록한다. setSession함수를 수행하면 valueBound()함수가 호출된다.
        loginManager.setSession(session, userId);
        response.sendRedirect("/login/login_ok.jsp");
    }
%>
</body>
</html>
 