<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="com.vodcaster.sqlbean.DirectoryNameManager,com.vodcaster.utils.TextUtil"%>
<jsp:useBean id="Ucc" class="com.vodcaster.sqlbean.UccSQLBean"/>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
    if(!chk_auth(vod_id, vod_level, "v_del")) {
	    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    	return;
    }else {
     
    	String ocode="";
    	String mcode="";
    	String code="";
        String posi_xy="";
        int iSuccess = 0;
 
        if(request.getParameter("ocode") != null)
        	ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
        if(request.getParameter("mcode") != null)
        	mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
        if(request.getParameter("posi_xy") != null)
        	posi_xy = request.getParameter("posi_xy").replaceAll("<","").replaceAll(">","");
 
       
        try {
            if(ocode != null && ocode.length() > 0 ) { 
                int iReuslt = -1;
                if(posi_xy != null && posi_xy.length() > 0  ){
	                    iReuslt = Ucc.posi_xy(request);
             
                		if (iReuslt  >= 0 ) {
                			iSuccess = 1;
                		} else {
                			iSuccess = 0;
                		}
                }
            }else{
            	out.println("<SCRIPT LANGUAGE='JavaScript'>");
     			out.println("alert('잘 못된 요청입니다. 이전 페이지로 이동합니다.')");
     			out.println("history.go(-1)");
     			out.println("</SCRIPT>");
     			return;
            }
        }catch(Exception e) {
            System.out.println(e.getMessage());
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다. 창을 닫습니다!')");
			out.println("self.close()");
			out.println("</SCRIPT>");
        }
		if(iSuccess == 1){
 			out.println("<script>alert('설정 되었습니다.');</script>");
//  			String backUrl = "frm_updateContent.jsp";
//  			backUrl = backUrl + "?ocode="+ocode+"&mcode="+mcode;
//  			out.println("<script>opener.location.href='"+backUrl+"';self.close();</script>");
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
 			out.println("self.close()");
			out.println("</SCRIPT>");
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.')");
			out.println("self.close()");
			out.println("</SCRIPT>");
		}


    }


%>
