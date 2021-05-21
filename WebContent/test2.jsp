<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.net.URLDecoder"%>
<%
 
String tmp_id = "" ;
 
	String vod_id ="";
	String vod_level = "0";
	String vod_name ="";
	String admin_buseo ="";
    String cookie = request.getHeader("Cookie"); //쿠키를 받아온다. 
    out.println(cookie);
    if(cookie != null)
    {
    	out.println("cccccccccc:"+request.getCookies());
        Cookie [] cookies = request.getCookies(); //받아온 쿠키를 배열에 담는다.
        out.println("eeeeeeeeee:"+cookies[0].getName());
        out.println("fffffffff:"+cookies[1].getName());
        out.println("fffffffff:"+cookies[2].getName());
        for(int i=0; i<cookies.length; i++    )
        {
			if (cookies[i].getName().equals("admin_id")) {
				tmp_id = cookies[i].getValue();
		 
			} else if (cookies[i].getName().equals("admin_buseo")) {
				admin_buseo = cookies[i].getValue();
			} else if (cookies[i].getName().equals("vod_id")) {
				vod_id = cookies[i].getValue();
			} else if (cookies[i].getName().equals("vod_name")) {
				vod_name = URLDecoder.decode(cookies[i].getValue(), "utf-8");
			} else if (cookies[i].getName().equals("vod_level")) {
				vod_level = cookies[i].getValue();
			}
        }
    }

    out.println(tmp_id);
    out.println(admin_buseo);
    out.println(vod_id);
    out.println(vod_name);
    out.println(vod_level);
%>  