<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page language="java" import="java.util.*, com.vodcaster.sqlbean.*, java.net.URLEncoder" %>
<%
	response.setDateHeader("Expires", 0); 
	response.setHeader("Pragma", "no-cache"); 

	if(request.getProtocol().equals("HTTP/1.1")) { 
		response.setHeader("Cache-Control", "no-cache"); 
	} 
%>
<%
String id = request.getParameter("id");
MemberManager mgr = MemberManager.getInstance();
out.println("test");
if(mgr.getMemberInfo(id ) != null) { 
	
	 Vector vt = mgr.getMemberInfo(id);
     MemberInfoBean info = new MemberInfoBean();
     out.println(vt.toString());
	 try {
        Enumeration e = vt.elements();
        com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
    } catch (Exception e) {
    	System.out.println(e);
    	 out.println("<script language='javascript'>");
         out.println("alert('������ ������ ������ ���� ����ڰ� �ƴմϴ�.');");
         out.println("location.href='intovod.jsp'");
         out.println("</script>");
    }
	 out.println(info.getId());
  
			Cookie cookie_admin = new Cookie("admin_id",String.valueOf(info.getId())); //��Ű �̸��� ���� �����Ѵ�.
			//cookie_admin.setDomain("localhost");
			cookie_admin.setMaxAge(60*60); //c.setMacAge(�� ������ ��Ű ��ȿ�ð� ��);
			cookie_admin.setPath("/"); //��Ű�� ��ȿ�� ���丮 ���� ���� cookie.setPath("��ȿ ���丮");, "/"�ϰ�� �ش� �����ο� ��� ���������� ��ȿ
			response.addCookie(cookie_admin); //Cookie ��ü�� response ��ü�� addCookie() �ż���� �߰�
			
			Cookie cookie_id = new Cookie("vod_id",String.valueOf(info.getId())); //��Ű �̸��� ���� �����Ѵ�.
			//cookie_id.setDomain("localhost");
			cookie_id.setMaxAge(60*60); //c.setMacAge(�� ������ ��Ű ��ȿ�ð� ��);
			cookie_id.setPath("/"); //��Ű�� ��ȿ�� ���丮 ���� ���� cookie.setPath("��ȿ ���丮");, "/"�ϰ�� �ش� �����ο� ��� ���������� ��ȿ
			response.addCookie(cookie_id); //Cookie ��ü�� response ��ü�� addCookie() �ż���� �߰�
			
// 			Cookie cookie_level = new Cookie("vod_level",String.valueOf(info.getLevels())); //��Ű �̸��� ���� �����Ѵ�.
// 			cookie_level.setDomain("videos.seoul.go.kr");
// 			cookie_level.setMaxAge(60*60); //c.setMacAge(�� ������ ��Ű ��ȿ�ð� ��);
// 			cookie_level.setPath("/"); //��Ű�� ��ȿ�� ���丮 ���� ���� cookie.setPath("��ȿ ���丮");, "/"�ϰ�� �ش� �����ο� ��� ���������� ��ȿ
// 			response.addCookie(cookie_level); //Cookie ��ü�� response ��ü�� addCookie() �ż���� �߰�
			
			Cookie cookie_name = new Cookie("vod_name",String.valueOf(info.getName())); //��Ű �̸��� ���� �����Ѵ�.
			//cookie_name.setDomain("localhost");
			cookie_name.setMaxAge(60*60); //c.setMacAge(�� ������ ��Ű ��ȿ�ð� ��);
			cookie_name.setPath("/"); //��Ű�� ��ȿ�� ���丮 ���� ���� cookie.setPath("��ȿ ���丮");, "/"�ϰ�� �ش� �����ο� ��� ���������� ��ȿ
			response.addCookie(cookie_name); //Cookie ��ü�� response ��ü�� addCookie() �ż���� �߰�

}


%>   