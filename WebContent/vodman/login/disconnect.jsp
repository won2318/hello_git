<%
    /*
     * login_try.jsp���� �α��� �ߺ��� �����ϰ� �α����Ұ�� ȣ��.
     * ������ session�� ���� hashTable�� ������ login_ok.jsp�� ȣ��.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.login.LoginManager"%>
<%!
    //�̱��� ������ ����Ͽ��� ������ �����Ǿ��ִ� �ν��Ͻ��� ���´�.
    LoginManager loginManager = LoginManager.getInstance(); 
%>
<html>
<head>
    <title>�α��� �ߺ����� Test</title>
</head>
<body>
<%
    String userId = (String)session.getAttribute("userId");
    if(userId != null){
        //������ ����(����)�� ���´�.
        loginManager.removeSession(userId);
        
        //���ο� ������ ����Ѵ�. setSession�Լ��� �����ϸ� valueBound()�Լ��� ȣ��ȴ�.
        loginManager.setSession(session, userId);
        response.sendRedirect("/login/login_ok.jsp");
    }
%>
</body>
</html>
 