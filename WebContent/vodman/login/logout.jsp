<%
    /*
     * 로그아웃을 클릭했을때 호출된다.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%
//session을 확~~~끊어 버린다. 이시점에 LoginManager의 valueUnbound()가 호출된다.
session.invalidate();
response.sendRedirect("login.jsp");
%>
 