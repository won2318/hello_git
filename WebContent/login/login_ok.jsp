<%
    /*
     * 정상적으로 로그인되었을경우 호출
     * 접속자 아이디를 보여주고 현재 접속중인 모든 사용자를 뿌려준다.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.util.*, com.login.LoginManager"%>

<%!
    //싱글톤 패턴을 사용하였기 때문에 생생되어있는 인스턴스를 얻어온다.
    LoginManager loginManager = LoginManager.getInstance(); 

%>
<html>
<head>
    <title>로그인 중복방지 Test</title>
</head>
<body align="center" valign="center">
<%
    //jsp내장객체 session을 이용하여 접속자 아이디를 얻어온다.
    String userId = (String)session.getAttribute("userId");

    if(userId != null){
%>
        <%=userId%>님 환영합니다.
        <a href="logout.jsp">로그아웃</a>
        <p>
        현재 접속자 : <br>
<%
        Collection collection = loginManager.getUsers();
        Iterator iterator = collection.iterator();
        int i=0;
        while(iterator.hasNext()){
            out.print((++i)+". "+iterator.next()+"<br>");
        }
    }else{
%>
        <script>
            alert("로그인후 이용해 주세요.");
            location.href = "login.jsp";
        </script>
<% 
    }
%>
</body>
</html>
 