<%
    /*
     * 로그인 페이지, 로그인전 현재 로그인된 이용자수를 출력한다.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.login.LoginManager"%>
<%!
    //싱글톤 패턴을 사용하였기 때문에 생생되어있는 인스턴스를 얻어온다.
    LoginManager loginManager = LoginManager.getInstance(); 
%>
<%
    //login_try에서 로그인을 하지 않을경우 세션에 남아있는 userId를 제거한다.
    session.removeAttribute("userId");
%>
<html>
<head>
    <title>로그인 중복방지 Test</title>
</head>
<body>
    <h3 align="center">현재 접속자 수 : <%=loginManager.getUserCount() %>명</h3>
    <form action="login_try.jsp" name="login">
        <div align="center">
            아이디  :   <input type="text" name="userId"><br>
            비밀번호    :   <input type="passward" name="userPw"><br>
            <input type="submit" value="로그인">
        </div>
    </form>
</body>
</html> 