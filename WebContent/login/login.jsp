<%
    /*
     * �α��� ������, �α����� ���� �α��ε� �̿��ڼ��� ����Ѵ�.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.login.LoginManager"%>
<%!
    //�̱��� ������ ����Ͽ��� ������ �����Ǿ��ִ� �ν��Ͻ��� ���´�.
    LoginManager loginManager = LoginManager.getInstance(); 
%>
<%
    //login_try���� �α����� ���� ������� ���ǿ� �����ִ� userId�� �����Ѵ�.
    session.removeAttribute("userId");
%>
<html>
<head>
    <title>�α��� �ߺ����� Test</title>
</head>
<body>
    <h3 align="center">���� ������ �� : <%=loginManager.getUserCount() %>��</h3>
    <form action="login_try.jsp" name="login">
        <div align="center">
            ���̵�  :   <input type="text" name="userId"><br>
            ��й�ȣ    :   <input type="passward" name="userPw"><br>
            <input type="submit" value="�α���">
        </div>
    </form>
</body>
</html> 