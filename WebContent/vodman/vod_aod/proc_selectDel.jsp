<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="com.vodcaster.sqlbean.DirectoryNameManager,com.vodcaster.utils.TextUtil"%>
<jsp:useBean id="Ucc" class="com.vodcaster.sqlbean.UccSQLBean"/>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
    if(!chk_auth(vod_id, vod_level, "v_del")) {
	    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
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
	        
	 	                    iReuslt = Ucc.delete_admin(v_chk[i]);
	              
	                 		if (iReuslt  >= 0 ) {
%>
  	<div id="silverlightControlHost">
		<object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="10" height="10">
		<param name="source" value="<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME %>/ClientBin/DeleteMediaFolder.xap"/>
		<param name="initParams" value="ocode=<%=v_chk[i]%>"/> 
		<param name="onerror" value="onSilverlightError" />
		<param name="background" value="white" />
		<param name="minRuntimeVersion" value="3.0.40624.0" />
		<param name="autoUpgrade" value="true" />
		<a href="http://go.microsoft.com/fwlink/?LinkID=141205" style="text-decoration: none;">
		<img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none"/>
		</a>
		</object>
		<iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe>
	</div>
<%	                 			
	                 			//out.println("<script>alert('���������� �����Ǿ����ϴ�.');</script>");
	                 			//String backUrl = "mng_vodOrderList.jsp";
	                 			//backUrl = backUrl + "?ctype=V";
	                 			//response.sendRedirect(backUrl);
	                 			iSuccess = 1;
	                 		} else {
	                 			iSuccess = 0;
	                 			out.println("<SCRIPT LANGUAGE='JavaScript'>");
	                 			out.println("alert('���� ���� �Ͽ����ϴ�..')");
	                 			//out.println("history.go(-1)");
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
     			out.println("alert('�� ���� ��û�Դϴ�. ���� �������� �̵��մϴ�.')");
     			out.println("history.go(-1)");
     			out.println("</SCRIPT>");
     			return;
            }
        }catch(Exception e) {
            System.out.println(e.getMessage());
            out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�. ���� �������� �̵��մϴ�.2')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
        }
		if(iSuccess == 1){
 			out.println("<script>alert('���������� �����Ǿ����ϴ�.');</script>");
 			String backUrl = "mng_vodOrderList.jsp";
 			backUrl = backUrl + "?ccode="+ccode;
 			out.println("<script>location.href='"+backUrl+"';</script>");
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�. ���� �������� �̵��մϴ�.1')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}


    }


%>
