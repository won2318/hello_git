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
    	String ocode = "";
 
        String ccode="";
        String[] v_chk = null;
        int iSuccess = 0;
 
        if(request.getParameter("ccode") != null)
        	ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");
        
        try {
            if(request.getParameterValues("v_chk") != null) {
                v_chk = request.getParameterValues("v_chk");
                int iReuslt = -1;
                if(v_chk != null && v_chk.length > 0){
	                for(int i=0; i < v_chk.length;i++){
	                    if( v_chk[i] !=null && !v_chk[i].equals("") ) {
	        
	 	                    iReuslt = Ucc.open_close(v_chk[i]);
	              
	                 		if (iReuslt  >= 0 ) {
  			
// 								out.println("<script>alert('성공적으로 삭제되었습니다.');</script>");
// 								String backUrl = "mng_vodOrderList.jsp";
// 								backUrl = backUrl + "?ctype=V";
// 								response.sendRedirect(backUrl);
	                 			iSuccess = 1;
	                 		} else {
	                 			iSuccess = 0;
	                 			out.println("<SCRIPT LANGUAGE='JavaScript'>");
	                 			out.println("alert('수정에 실패 하였습니다..')");
	                 			out.println("history.go(-1)");
	                 			out.println("</SCRIPT>");
	                 			
	                 			break;
	                 		}
// 	                 		out.println("<SCRIPT LANGUAGE='JavaScript'>");
//                  			out.println("alert('"+v_chk[i]+"::"+i+"::"+iSuccess+"')");
//                  			out.println("</SCRIPT>");
	                    }
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
			out.println("alert('처리 중 오류가 발생하였습니다. 이전 페이지로 이동합니다.2')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
        }
		if(iSuccess == 1){
 			out.println("<script>alert('성공적으로 수정 되었습니다.');</script>");
 			String backUrl = "mng_vodOrderList.jsp";
 			backUrl = backUrl + "?ccode="+ccode;
 			out.println("<script>location.href='"+backUrl+"';</script>");
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다. 이전 페이지로 이동합니다.1')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}


    }


%>
