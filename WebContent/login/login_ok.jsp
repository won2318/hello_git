<%
    /*
     * ���������� �α��εǾ������ ȣ��
     * ������ ���̵� �����ְ� ���� �������� ��� ����ڸ� �ѷ��ش�.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.util.*, com.login.LoginManager"%>

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
    //jsp���尴ü session�� �̿��Ͽ� ������ ���̵� ���´�.
    String userId = (String)session.getAttribute("userId");

    if(userId != null){
%>
        <%=userId%>�� ȯ���մϴ�.
        <a href="logout.jsp">�α׾ƿ�</a>
        <p>
        ���� ������ : <br>
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
            alert("�α����� �̿��� �ּ���.");
            location.href = "login.jsp";
        </script>
<% 
    }
%>
</body>
</html>
 