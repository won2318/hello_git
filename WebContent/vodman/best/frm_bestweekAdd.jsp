<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.hrlee.silver.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "be_write")) {
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
	 * @description : 베스트 VOD정보 입력.
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
		subTitle1 = "<span>메인</span> VOD";
		subTitle2 = "메인 VOD";
	} else if(flag.equals("E")) {
		subTitle1 = "<span>VOD</span> 대기영상";
		subTitle2 = "VOD 대기영상";
	}
	*/
	subTitle1 = "<span>메인</span> VOD";
	subTitle2 = "메인 VOD";
	
	BestWeekManager mgr = BestWeekManager.getInstance();
	Vector vt = mgr.getBestWeekInfo(flag);
    BestWeekInfoBean info = new BestWeekInfoBean();
	if(vt != null && vt.size()>0){
		try {
			// infoBean에 수정할 데이타 대입
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
			<p class="location">관리자페이지 &gt; 메인화면관리 &gt; <span><%=subTitle2%></span></p>
			<div id="content">
			
			<iframe id="bestVod" name="bestVod" src="frm_bestVod.jsp?flag=<%=flag%>" scrolling=no width="450" height="490" marginwidth=0 frameborder=0 framespacing=0 ></iframe>
			<iframe id="bestVodList" name="bestVodList" src="frm_bestVodList.jsp?flag=<%=flag%>&ocode=<%=info.getOcode()%>" scrolling=no width="340" height="490" marginwidth=0 frameborder=0 framespacing=0 ></iframe>
			
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>