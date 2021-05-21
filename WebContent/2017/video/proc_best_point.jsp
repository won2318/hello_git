<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="com.vodcaster.sqlbean.DirectoryNameManager,com.vodcaster.utils.TextUtil"%>
<%@ include file="/include/chkLogin.jsp" %>
<%
        MediaManager mgr = MediaManager.getInstance();
        String ocode = "";
        String point = "1";  
// 		if(request.getParameter("point") != null && request.getParameter("point").length() > 0)
//             point = request.getParameter("point");	 
        try {
            if(request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0) {
                ocode = request.getParameter("ocode");
               	int result = mgr.insertBest_PointExt(ocode, Integer.parseInt(point));
               	if(result > 0) {  
               		int return_point = mgr.getOMediaPoint(ocode);
               		out.println(return_point);
               	}
            }
        }catch(Exception e) {
            System.out.println(e.getMessage());
        }
%>