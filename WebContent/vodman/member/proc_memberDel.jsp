<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,  com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_del")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author �� �� ��
	 *
	 * @description : ȸ�����̵� �޾Ƽ� ����
	 * date : 2005-01-10
	 */
	 request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "1001";
	}
	String id = "";

    // ��ũ����
    int pg = 0;
	String sex = "";
    String level = "";
	String useMailling = "";
	String joinDate1 = "";
	String joinDate2 = "";
	String searchField = "";
	String searchString = "";

    if(request.getParameter("page")==null){
        pg = 1;
    }else{
        try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception e){
			pg = 1;
		}
    }

	if(request.getParameter("ssex") != null && request.getParameter("ssex").length()>0 && !request.getParameter("ssex").equals("null"))
		sex = request.getParameter("ssex");

	if(request.getParameter("slevel") != null && request.getParameter("slevel").length()>0 && !request.getParameter("slevel").equals("null"))
		level = request.getParameter("slevel");

	if(request.getParameter("useMailling") != null && request.getParameter("useMailling").length()>0 && !request.getParameter("useMailling").equals("null"))
		useMailling = request.getParameter("useMailling");

	if(request.getParameter("joinDate1") != null && request.getParameter("joinDate1").length()>0 && !request.getParameter("joinDate1").equals("null"))
		joinDate1 = request.getParameter("joinDate1");

	if(request.getParameter("joinDate2") != null && request.getParameter("joinDate2").length()>0 && !request.getParameter("joinDate2").equals("null"))
		joinDate2 = request.getParameter("joinDate2");

	if(request.getParameter("searchField") != null && request.getParameter("searchField").length()>0 && !request.getParameter("searchField").equals("null"))
		searchField = request.getParameter("searchField");

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0 && !request.getParameter("searchString").equals("null"))
		searchString = CharacterSet.toKorean(request.getParameter("searchString"));

    String strLink = "&page=" +pg+ "&ssex=" +sex+ "&slevel=" +level+ "&useMailling=" +useMailling+ "&joinDate1=" +joinDate1+ "&joinDate2=" +joinDate2+ "&searchField=" +searchField+ "&searchString=" +searchString;
    // ��ũ����




	if(request.getParameter("id") != null && request.getParameter("id").length()>=0 && !request.getParameter("id").equals("null")) {

		id = request.getParameter("id").trim();

		MemberManager mngMember = MemberManager.getInstance();
		int result = mngMember.deleteMember(id, request.getParameter("user_name"), request.getRemoteAddr(),  vod_id);

		if(result >= 0){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('�����Ǿ����ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			//response.sendRedirect("mng_memberList.jsp?mcode="+mcode + strLink);
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			
		}

	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('���̵� �����ϴ�. �ٽ� �������ּ���.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
String REF_URL="mng_memberList.jsp?mcode="+mcode + strLink ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
%>