<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, javazoom.upload.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="DirectoryNameManager" class="com.vodcaster.sqlbean.DirectoryNameManager"/>

<%
	/**
	 * @author 최 희 성
	 *
	 * @description : 팝업정보 이미지 삭제처리
	 * date : 2007-12-17
	 */

	String seq = "";
	String gubun = "";

	if(request.getParameter("seq") != null 
			&& request.getParameter("seq").length()>0 
			&& request.getParameter("gubun") != null 
			&& request.getParameter("gubun").length()>0 ) {

		seq = request.getParameter("seq").trim();
		gubun = request.getParameter("gubun").replaceAll("<","").replaceAll(">","").trim();

        PopupManager mngMedia = PopupManager.getInstance();
        int rtn = mngMedia.deletePopupImage(seq, gubun);

		if(rtn >= 0){
            out.println("<script language='javascript'>\n" +
                        "alert('이미지가 삭제되었습니다.')\n;" +
                        "opener.location.href='frm_popUpdate.jsp?seq=" +seq+ "';\n" +
                        "window.close();\n" +
                        "</script>");
            
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('접속자수가 너무 많습니다. 잠시후에 다시 시도하여 주세요.');");
			out.println("window.close();");
			out.println("</SCRIPT>");
		}

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('삭제할 미디어정보가 없습니다. 다시 선택해주세요.');");
		out.println("window.close();");
		out.println("</SCRIPT>");

	}

	request.setAttribute("seq",seq);

%>