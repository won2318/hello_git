<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,  com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "v_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 박종성
	 *
	 * @description : 금주의영상 입력
	 * date : 2009-10-20
	 */
	request.setCharacterEncoding("EUC-KR");

	String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	if(flag == null || flag.length() <= 0 || flag.equals("null")) {
		flag = "A";
	}
	
	String mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "02";
	}
	
	BestWeekManager mgr = BestWeekManager.getInstance();
	int result = mgr.insertBestWeek(request);

	if(result >= 0){
		
		//out.println("<script language='javascript'>alert('저장되었습니다.');parent.location.href='frm_bestweekAdd.jsp?mcode="+mcode+"&flag="+flag+"';</script>");
		out.println("<script language='javascript'>alert('저장되었습니다.');</script>");
		 String REF_URL="frm_bestVod.jsp?mcode="+mcode+"&flag="+flag ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생했습니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}

%>