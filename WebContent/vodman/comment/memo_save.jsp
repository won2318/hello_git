<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth_pop.jsp"%>
<%
    request.setCharacterEncoding("EUC-KR");
    
    String pg = StringUtils.defaultString(request.getParameter("page"), "1");
//    String code = request.getParameter("code");
    String jaction = request.getParameter("jaction").replaceAll("<","").replaceAll(">","");
    String muid = request.getParameter("muid").replaceAll("<","").replaceAll(">","");
    String ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
	String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	String comment =request.getParameter("comment").replaceAll("<","").replaceAll(">","");
    
    String memoId = vod_id;
 
    String memoName = vod_name;

    
    if (StringUtils.isEmpty(jaction) 
        || !(StringUtils.equals(jaction,"save") || StringUtils.equals(jaction,"delete")) 
        || StringUtils.equals(jaction, "delete") && StringUtils.isEmpty(muid)) {
		
%>
        <script type="text/javascript" language="javascript">
            alert("필수 파라미터가 맞지 않습니다.");
            history.go(-1);
        </script>
<%
    }
	com.vodcaster.sqlbean.MemoInfoBean memoBean = new com.vodcaster.sqlbean.MemoInfoBean();
	memoBean.setId(memoId);
	memoBean.setOcode(ocode);
 
	memoBean.setWname(memoName);
	memoBean.setIp(request.getRemoteAddr());
	memoBean.setComment(comment);
	memoBean.setFlag(flag);
	if( request.getParameter("muid") != null && request.getParameter("muid").length() > 0 && !request.getParameter("muid").equals("null"))
	{
		try{
			memoBean.setMuid(Integer.parseInt(muid));
		}catch(Exception ex){
%>
        <script type="text/javascript" language="javascript">
            alert("필수 파라미터가 맞지 않습니다.");
            history.go(-1);
        </script>
<%		
		}
	}
	
%>
<%    
    StringBuffer param = new StringBuffer("");
    param.append("page=").append(pg);
    param.append("&ocode=").append(ocode);
    param.append("&flag=").append(flag);
    MemoManager memoMgr = MemoManager.getInstance();
    if(jaction.equals("delete") && vod_id == null){
		 try {
			memoMgr.saveMemo(memoBean, jaction);
		} catch(Exception e) {
			System.err.println(e.toString());
		} finally {
		}

	} else {

		    try {
				memoMgr.saveMemo(memoBean, jaction);
			} catch(Exception e) {
				System.err.println(e.toString());
			} finally {
			}

	}
	  
	


	out.println("<script type=\"text/javascript\" language=\"javascript\">");
	if (StringUtils.isEmpty(vod_id)){  // 방문자
		if (jaction.equals("delete")) {
			out.println("opener.location.reload();self.close();");
		} else {
//					out.println("alert('"+comment+"')");
			out.println("location.href='comment.jsp?"+param.toString()+"';");
		}
		out.println("window.close();");
	} else {
//				out.println("alert('"+comment+"')");
		out.println("location.href='comment.jsp?" + param.toString()+"';");
	}
	out.println("</script>");     
	%>

	
