<%
    /*
     * �α��� �õ�������, id, pw������ üũ�ϰ�, �ùٸ��ٸ� 
     * �̹� ������ ���̵����� üũ�Ѵ�. �̹� ������ ���̵���
     * ���� ������ �����Ұ�����, ���������� kill��Ű�� �α����Ұ������� 
     * Ȯ���Ѵ�.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.login.LoginManager, java.util.*"%>
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
    if(loginManager.isValid(userId, userPw )){
        
        //������ ���̵� ���ǿ� ��´�.
        session.setAttribute("userId", userId);
        com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
        Vector vt_member = mgr.getMemberInfo(userId);
        System.out.println("vt_member::"+vt_member); 						   
			if(vt_member != null && vt_member.size()> 0){
				com.vodcaster.sqlbean.MemberInfoBeanRsa info_member = new com.vodcaster.sqlbean.MemberInfoBeanRsa();
					try {
	
						Enumeration e = vt_member.elements();
						com.yundara.beans.BeanUtils.fill(info_member, (Hashtable)e.nextElement());
									
						   session.setAttribute("admin_id", userId);
						   session.setAttribute("vod_id", userId);
						   session.setAttribute("vod_name", info_member.getName());
						   session.setAttribute("vod_level",  String.valueOf(info_member.getLevel()));
						   session.setAttribute("vod_buseo",  String.valueOf(info_member.getBuseo()));
						   session.setAttribute("user_key", userId+"_withustech");  // �Ǹ����� Ű ���Ƿ� ����
						   
						   session.setMaxInactiveInterval(3600);
			
				} catch (Exception e) {
					System.out.println("�α��� ���� ����_error:"+e);
					// �α��� ���� �α� ����
			 		 
			  	//ȸ�� ������ �α��� ���� ī��Ʈ ����
				}
			}
	   
        
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

 