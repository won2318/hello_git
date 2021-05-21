<%@ page contentType="text/html; charset=euc-kr"%>
<%
	
	//==============================================================================
	// 캐시 차단하기 위한 처리 
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "no-cache");
	if(request.getProtocol().equals("HTTP/1.1")){
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<%
	String tmp_id = (String)session.getValue("admin_id");
 
	String vod_id = (String)session.getValue("admin_id");
	String vod_level = (String)session.getValue("vod_level");
	String vod_name = (String)session.getValue("vod_name");
	//==============================================================================
	//로그아웃 버튼 누른 사용자에게는 세션 만료, 접근 권한 메세지 안보여주기 위한 처리
	String LOGOUT = (String)session.getValue("LOGOUT");
	//로그아웃 버튼 안누른 사용자 
	if(LOGOUT == null || LOGOUT.length()<=0 || LOGOUT.equals("null")){
		//로그인 안된 사용자 
		if(tmp_id == null || vod_name == null || tmp_id.length()<=0 || tmp_id.equals("null")){
			
				session.invalidate();
				%>
				<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
				<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
					<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
					<title>수원 iTV</title>
					<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
					<script>alert('세션이 만료되었거나, 접근 권한이 없습니다. \\관리자 로그인 이후 이용해 주시기 바람니다.');location.href='/vodman/mancheck.jsp';</script>
				</head>
				<body></body>
				</html>
				<%
				return;
			
		}
	}else if(LOGOUT.equals("Y")){
			//로그아웃 버튼 누른 사용자 
			session.invalidate();
			%>
							
				<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
				<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
					<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
					<title>수원 iTV</title>
					<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
					<script>alert('메인화면으로 이동합니다.');location.href='/';</script>
				</head>
				<body></body>
				</html>
				<%
			return;
	}
		

    String SilverLightServer = DirectoryNameManager.SILVERLIGHT_SERVERNAME;
	String SilverLightPath = SilverLightServer + "/ClientBin/Media";
	
%>
<%!
   
    public boolean chk_auth(String vod_id, String vod_level, String area) {
        if(vod_level==null || vod_level.equals("")) {
            vod_level = "0";
        }
        int auth_v = com.vodcaster.sqlbean.AuthManagerBean.getInstance().getAuthLevel(area);
        if(Integer.parseInt(vod_level) >= auth_v) {
            return true;
        }else{
            return false;
        }
    }
%>