<%
    /*
     * �α��� �õ�������, id, pw������ üũ�ϰ�, �ùٸ��ٸ� 
     * �̹� ������ ���̵����� üũ�Ѵ�. �̹� ������ ���̵���
     * ���� ������ �����Ұ�����, ���������� kill��Ű�� �α����Ұ������� 
     * Ȯ���Ѵ�.
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
<body align="center" valign="center">
<%
    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");
    
    //���̵� �н����� üũ
    if(loginManager.isValid(userId, userPw)){
        
        //������ ���̵� ���ǿ� ��´�.
        session.setAttribute("userId", userId);
        
        //�̹� ������ ���̵����� üũ�Ѵ�.
        //out.println(userId);
        //out.println(loginManager.isUsing(userId));
        loginManager.printloginUsers();
        if(loginManager.isUsing(userId)){
%>
            �̹� �������Դϴ�. ������ ������ �����Ͻðڽ��ϱ�?<P>
            <a href="disconnect.jsp">�� </a>
            <a href="login.jsp">�ƴϿ�</a>
<%
        }else{
            loginManager.setSession(session, userId);
            response.sendRedirect("login_ok.jsp");
        }
%>
<%
    }else{
%>
        <script>
            alert("�α����� �̿��� �ּ���.");
            location.href = "login.jsp";
        </script>
<% 
    }
%>
</body>
</html>

 