<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="com.vodcaster.sqlbean.DirectoryNameManager,com.vodcaster.utils.TextUtil"%>
<jsp:useBean id="Ucc" class="com.vodcaster.sqlbean.VODInfoBean"/>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
    if(!chk_auth(vod_id, vod_level, "v_del")) {
	    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    	return;
    }else {
     
        String ccode="";
        String mcode="";
        String pageNum = "";
        String[] v_chk = null;

        String flag ="";
        int iSuccess = 0;
 
        if(request.getParameter("ccode") != null)
        	ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");
        if(request.getParameter("mcode") != null)
        	mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
 
        pageNum = request.getParameter("page");
        if(pageNum == null || pageNum.length()<=0){
        	pageNum = "1";
        }
        try {
            if(request.getParameterValues("v_chk") != null ) {
                v_chk = request.getParameterValues("v_chk");
                int iReuslt = -1;
                if(v_chk != null && v_chk.length > 0 && !v_chk[0].equals("")){
	                    iReuslt = Ucc.move_cate_admin(request);
             
                		if (iReuslt  >= 0 ) {
                			iSuccess = 1;
                		} else {
                			iSuccess = 0;
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
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�. â�� �ݽ��ϴ�!')");
			out.println("self.close()");
			out.println("</SCRIPT>");
        }
		if(iSuccess == 1){
 			out.println("<script>alert('���������� �̵� �Ǿ����ϴ�.');</script>");
 			String backUrl = "mng_vodOrderList.jsp";
 			backUrl = backUrl + "?ccode="+ccode+"&mcode="+mcode+"&page="+pageNum;
 			out.println("<script>opener.location.href='"+backUrl+"';self.close();</script>");
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�. â�� �ݽ��ϴ�.')");
			out.println("self.close()");
			out.println("</SCRIPT>");
		}


    }


%>
