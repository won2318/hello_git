<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*, javazoom.upload.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "r_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="DirectoryNameManager" class="com.vodcaster.sqlbean.DirectoryNameManager"/>

<%
	/**
	 * @author 최 희 성
	 *
	 * @description : 주문형 VOD정보 이미지 삭제처리
	 * date : 2005-01-20
	 */
	
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0601";
	}
		
	String rcode = "";
    String flag = "";

	if(request.getParameter("rcode") != null && request.getParameter("flag") != null) {

		rcode = request.getParameter("rcode");
        flag = request.getParameter("flag");

        LiveManager mngMedia = LiveManager.getInstance();

        int rtn = mngMedia.deletefile(rcode, flag);

		if(rtn >= 0){
            out.println("<script language='javascript'>\n" +
                        "alert(' 삭제되었습니다.')\n;" +
                        //"opener.location.href='frm_Live_Update.jsp?mcode="+mcode+"&rcode=" +rcode+ "';\n" +
						"opener.location.reload();\n" +
                        "window.close();\n" +
                        "</script>");
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다. 이전 페이지로 이동합니다.');");
			out.println("window.close();");
			out.println("</SCRIPT>");
		}

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('삭제할 정보가 없습니다. 다시 선택해주세요.');");
		out.println("window.close();");
		out.println("</SCRIPT>");

	}

%>