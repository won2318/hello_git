<%@ page contentType="text/html; charset=euc-kr"%>
<%
	
	//==============================================================================
	// ĳ�� �����ϱ� ���� ó�� 
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
	//�α׾ƿ� ��ư ���� ����ڿ��Դ� ���� ����, ���� ���� �޼��� �Ⱥ����ֱ� ���� ó��
	String LOGOUT = (String)session.getValue("LOGOUT");
	//�α׾ƿ� ��ư �ȴ��� ����� 
	if(LOGOUT == null || LOGOUT.length()<=0 || LOGOUT.equals("null")){
		//�α��� �ȵ� ����� 
		if(tmp_id == null || vod_name == null || tmp_id.length()<=0 || tmp_id.equals("null")){
			
				session.invalidate();
				%>
				<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
				<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
					<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
					<title>���� iTV</title>
					<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
					<script>alert('������ ����Ǿ��ų�, ���� ������ �����ϴ�. \\������ �α��� ���� �̿��� �ֽñ� �ٶ��ϴ�.');location.href='/vodman/mancheck.jsp';</script>
				</head>
				<body></body>
				</html>
				<%
				return;
			
		}
	}else if(LOGOUT.equals("Y")){
			//�α׾ƿ� ��ư ���� ����� 
			session.invalidate();
			%>
							
				<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
				<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
					<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
					<title>���� iTV</title>
					<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
					<script>alert('����ȭ������ �̵��մϴ�.');location.href='/';</script>
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