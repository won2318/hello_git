<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.hrlee.silver.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "be_write")) {
   out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author ������
	 *
	 * @description : ����Ʈ VOD���� �Է�.
	 * date : 2009-10-19
	 */
	 
	String flag = request.getParameter("flag");
	if (flag != null && flag.length() > 0) {
		flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	}
	if(flag == null || flag.length() == 0 || flag.equals("null")) {
		flag = "A";
	}
	
	String subTitle1 = "";
	String subTitle2 = "";
	/*
	if(flag.equals("A")) {
		subTitle1 = "<span>����</span> VOD";
		subTitle2 = "���� VOD";
	} else if(flag.equals("E")) {
		subTitle1 = "<span>VOD</span> ��⿵��";
		subTitle2 = "VOD ��⿵��";
	}
	*/
	subTitle1 = "<span>����</span> VOD";
	subTitle2 = "���� VOD";
	
	BestWeekManager mgr = BestWeekManager.getInstance();
	Vector vt = mgr.getBestWeekInfo(flag);
    BestWeekInfoBean info = new BestWeekInfoBean();
	if(vt != null && vt.size()>0){
		try {
			// infoBean�� ������ ����Ÿ ����
			Enumeration e = vt.elements();
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
	
		} catch (Exception e) {
			System.out.println(e);
		}
	}
    String title = info.getTitle();
    int strlen = 20;
    if(title.length() > strlen) {
        title = info.getTitle().substring(0,strlen-2) + "...";
    }
    
%>

<%@ include file="/vodman/include/top.jsp"%>
<%@ include file="/vodman/best/best_left.jsp"%>
		<div id="contents">
			<h3><%=subTitle1%></h3>
			<p class="location">������������ &gt; ����ȭ����� &gt; <span><%=subTitle2%></span></p>
			<div id="content">
			
			<iframe id="bestVod" name="bestVod" src="frm_bestVod.jsp?flag=<%=flag%>" scrolling=no width="450" height="490" marginwidth=0 frameborder=0 framespacing=0 ></iframe>
			<iframe id="bestVodList" name="bestVodList" src="frm_bestVodList.jsp?flag=<%=flag%>&ocode=<%=info.getOcode()%>" scrolling=no width="340" height="490" marginwidth=0 frameborder=0 framespacing=0 ></iframe>
			
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>