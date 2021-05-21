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
         out.println("alert('관리자 페이지 접근이 허용된 사용자가 아닙니다.');");
         out.println("location.href='intovod.jsp'");
         out.println("</script>");
    }
	 out.println(info.getId());
  
			Cookie cookie_admin = new Cookie("admin_id",String.valueOf(info.getId())); //쿠키 이름과 값을 설정한다.
			//cookie_admin.setDomain("localhost");
			cookie_admin.setMaxAge(60*60); //c.setMacAge(초 단위으 쿠키 유효시간 값);
			cookie_admin.setPath("/"); //쿠키가 유효한 디렉토리 정보 설정 cookie.setPath("유효 디렉토리");, "/"일경우 해당 도메인에 모든 페이지에서 유효
			response.addCookie(cookie_admin); //Cookie 객체를 response 객체에 addCookie() 매서드로 추가
			
			Cookie cookie_id = new Cookie("vod_id",String.valueOf(info.getId())); //쿠키 이름과 값을 설정한다.
			//cookie_id.setDomain("localhost");
			cookie_id.setMaxAge(60*60); //c.setMacAge(초 단위으 쿠키 유효시간 값);
			cookie_id.setPath("/"); //쿠키가 유효한 디렉토리 정보 설정 cookie.setPath("유효 디렉토리");, "/"일경우 해당 도메인에 모든 페이지에서 유효
			response.addCookie(cookie_id); //Cookie 객체를 response 객체에 addCookie() 매서드로 추가
			
// 			Cookie cookie_level = new Cookie("vod_level",String.valueOf(info.getLevels())); //쿠키 이름과 값을 설정한다.
// 			cookie_level.setDomain("videos.seoul.go.kr");
// 			cookie_level.setMaxAge(60*60); //c.setMacAge(초 단위으 쿠키 유효시간 값);
// 			cookie_level.setPath("/"); //쿠키가 유효한 디렉토리 정보 설정 cookie.setPath("유효 디렉토리");, "/"일경우 해당 도메인에 모든 페이지에서 유효
// 			response.addCookie(cookie_level); //Cookie 객체를 response 객체에 addCookie() 매서드로 추가
			
			Cookie cookie_name = new Cookie("vod_name",String.valueOf(info.getName())); //쿠키 이름과 값을 설정한다.
			//cookie_name.setDomain("localhost");
			cookie_name.setMaxAge(60*60); //c.setMacAge(초 단위으 쿠키 유효시간 값);
			cookie_name.setPath("/"); //쿠키가 유효한 디렉토리 정보 설정 cookie.setPath("유효 디렉토리");, "/"일경우 해당 도메인에 모든 페이지에서 유효
			response.addCookie(cookie_name); //Cookie 객체를 response 객체에 addCookie() 매서드로 추가

}


%>   