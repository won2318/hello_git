<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
	<!-- //�Ǹ������� ������ �̵� -->
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="description" content="���� iTV, �޸ս�Ƽ ����, ����� �ݰ����ϴ�, ���ͳ� ���" />
	<meta name="keywords" content="���� iTV, ������, ���ͳݹ���, �޸ս�Ƽ ����, ����� �ݰ����ϴ�" />

	<title>���� iTV</title>
  <script>
  //alert('return:<%=session.getValue("name_check_url")%>');
  <%

  String return_value = "";
  
  return_value = session.getValue("name_check_url").toString();
 if (return_value.contains("2017") || return_value.contains("mobile")) { %>
	  parent.opener.top.location.href='<%=session.getValue("name_check_url")%>'; // 2017 ����
  <%} else {%>
	  parent.opener.top.name_check_conform('<%=session.getValue("name_check_url")%>');  // 2013 ����
  <%} %>

    window.close();
 
  </script>
</head>
<body>
</body>
</html>