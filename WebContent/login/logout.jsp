<%
    /*
     * �α׾ƿ��� Ŭ�������� ȣ��ȴ�.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%
//session�� Ȯ~~~���� ������. �̽����� LoginManager�� valueUnbound()�� ȣ��ȴ�.
session.invalidate();
response.sendRedirect("login.jsp");
%>
 