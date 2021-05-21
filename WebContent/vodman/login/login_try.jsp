<%
    /*
     * 로그인 시도페이지, id, pw유무를 체크하고, 올바르다면 
     * 이미 접속한 아이디인지 체크한다. 이미 접속한 아이디라면
     * 기존 접속을 유지할것인지, 기존접속을 kill시키고 로그인할것인지를 
     * 확인한다.
     */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.login.LoginManager, java.util.*"%>
<%!
    //싱글톤 패턴을 사용하였기 때문에 생생되어있는 인스턴스를 얻어온다.
    LoginManager loginManager = LoginManager.getInstance(); 
%>
<html>
<head>
    <title>로그인 중복방지 Test</title>
</head>
<body align="center" valign="center">
<%
    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");
    
    //아이디 패스워드 체크
    if(loginManager.isValid(userId, userPw )){
        
        //접속자 아이디를 세션에 담는다.
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
						   session.setAttribute("user_key", userId+"_withustech");  // 실명인증 키 임의로 생성
						   
						   session.setMaxInactiveInterval(3600);
			
				} catch (Exception e) {
					System.out.println("로그인 세션 생성_error:"+e);
					// 로그인 실패 로그 남김
			 		 
			  	//회원 정보에 로그인 실패 카운트 증가
				}
			}
	   
        
        //이미 접속한 아이디인지 체크한다.
        //out.println(userId);
        //out.println(loginManager.isUsing(userId));
        loginManager.printloginUsers();
        if(loginManager.isUsing(userId)){
%>
            이미 접속중입니다. 기존의 접속을 종료하시겠습니까?<P>
            <a href="disconnect.jsp">예 </a>
            <a href="login.jsp">아니오</a>
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
            alert("로그인후 이용해 주세요.");
            location.href = "login.jsp";
        </script>
<% 
    }
%>
</body>
</html>

 