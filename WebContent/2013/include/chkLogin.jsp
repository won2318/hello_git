<%@page import="java.util.Enumeration"%>
<%
 if(return_value_main(request.getQueryString()) != null && !return_value_main(request.getQueryString()).equals("")) {
	out.println(return_value_main(request.getQueryString())); 
	return;
 }
//

%>

<%!

public String return_value_main ( String para_value){
	
	 if( para_value !=null && para_value.length() > 0) {
	    	String temp_par_value=para_value;
	    	temp_par_value = temp_par_value.replaceAll("\"","").replaceAll(";","").replaceAll("'","&#39;");
	    	if (para_value.equals(temp_par_value)) {
	    		return "";
	    	} else{
	    		 String temp_return_string="<script  type='text/javascript'>"+
	    		"alert( ' NOT USE!!    RETURN TO MAIN! '); "+
	    		"location.href='/';"+
	    		"</script>";
	    		return temp_return_string;
	    	}
	    } else {
	    	return "";
	    }
}

    public boolean chk_login(String vod_id, String vod_level) {

        if(vod_id==null || vod_level==null) {
            return false;
        }

        if(vod_id.equals("") || vod_level.equals("")) {
            return false;
        }
        return true;
    }


    public boolean chk_auth(String vod_id, String vod_level, String area) {
        if(vod_level==null || vod_level.equals("")) {
            vod_level = "0";
        }
        int auth_v = com.vodcaster.sqlbean.AuthManager.getInstance().getAuthLevel(area);
        if(Integer.parseInt(vod_level) >= auth_v) {
            return true;
        }else{
            return false;
        }
    }
%>

<%
	
	String vod_id = "";
	if (session.getValue("vod_id") != null && session.getValue("vod_id").toString().length() > 0) {
		vod_id = (String)session.getValue("vod_id");
	}
	String vod_pwd = (String)session.getValue("vod_pwd");
	String vod_name = "";
	if (session.getValue("vod_name") != null && session.getValue("vod_name").toString().length() > 0) {
		vod_name = (String)session.getValue("vod_name");
	}	
    String deptcd = (String)session.getValue("deptcd");
	String gradecode = (String)session.getValue("gradecode");
	String user_key = "";
	if (session.getValue("user_key") != null && session.getValue("user_key").toString().length() > 0) {
		user_key = (String)session.getValue("user_key"); 
	}
	String vod_level = "0";
	if (session.getValue("vod_level") != null && session.getValue("vod_level").toString().length() > 0) {
		vod_level = (String)session.getValue("vod_level");
	}
	 out.println(vod_name+"::"+vod_id);
    java.util.Vector vod_mylist = (java.util.Vector)session.getValue("vod_mylist");
  
    
    if (chk_login(vod_id, vod_level)) {
        pageContext.setAttribute("vod_id", vod_id);
        pageContext.setAttribute("vod_name", vod_name);
    }
    
 
    String SilverLightServer =DirectoryNameManager.SILVERLIGHT_SERVERNAME;
    String SilverLightPath = SilverLightServer + "/ClientBin/Media";
    String WowzaServer =DirectoryNameManager.WOWZA_SERVER_IP;
%>