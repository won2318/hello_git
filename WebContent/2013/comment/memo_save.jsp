<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file="/include/chkLogin.jsp" %>
<%
    request.setCharacterEncoding("EUC-KR");
    
    String pg = StringUtils.defaultString(request.getParameter("page"), "1");
//    String code = request.getParameter("code");
//    String pageInfo = StringUtils.defaultString(request.getParameter("pageInfo"), "commu");
    String jaction = request.getParameter("jaction");
    String muid = request.getParameter("muid");
    String ocode = request.getParameter("ocode");
	String flag = request.getParameter("flag");
	String comment =request.getParameter("comment");
	String wnick_name =request.getParameter("wnick_name");
	String pwd =request.getParameter("pwd");
    
    String memoId = vod_id;
//    String memoPwd = vod_pwd;
    String memoName = vod_name;

	if (StringUtils.isEmpty(memoId)){ }

//out.println(jaction);    
//out.println(muid);   
    if (StringUtils.isEmpty(jaction) || StringUtils.isEmpty(ocode)  || !com.yundara.util.TextUtil.isNumeric(ocode)
        || !(StringUtils.equals(jaction,"save") || StringUtils.equals(jaction,"del")) 
        || StringUtils.equals(jaction, "del") && StringUtils.isEmpty(muid) && StringUtils.isEmpty(pwd)) {
%>
        <script type="text/javascript" language="javascript">
            alert("필수 파라미터가 맞지 않습니다.");
            history.go(-1);

        </script>
		<noscript>
		죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
		일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
		</noscript>
<%
    } else {
	com.vodcaster.sqlbean.MemoInfoBean memoBean = new com.vodcaster.sqlbean.MemoInfoBean();
	memoBean.setId(memoId);
	memoBean.setOcode(ocode);
	memoBean.setPwd(pwd);
	memoBean.setWname(memoName);
	memoBean.setIp(request.getRemoteAddr());
	memoBean.setComment(comment);
	memoBean.setFlag(flag);
	memoBean.setWnick_name(wnick_name);
	
	if( request.getParameter("muid") != null && request.getParameter("muid").length() > 0 && !request.getParameter("muid").equals("null"))
	{
		memoBean.setMuid(Integer.parseInt(muid));
	}
	
%>
<%    
    StringBuffer param = new StringBuffer("");
    param.append("page=").append(pg);
    param.append("&ocode=").append(ocode);
    param.append("&flag=").append(flag);
 
    MemoManager memoMgr = MemoManager.getInstance();
 
		 try {
				memoMgr.saveMemo(memoBean, jaction);
			} catch(Exception e) {
				System.err.println(e.toString());
			} finally {
			}

	 
 
			out.println("<script type=\"text/javascript\" language=\"javascript\">");
 			out.println("location.href=\"comment.jsp?" + param.toString()+"\";");
			out.println("</script>");   
    }
	%>

	
