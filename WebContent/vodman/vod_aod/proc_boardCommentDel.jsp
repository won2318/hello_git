<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth_pop.jsp"%>
<%
   // request.setCharacterEncoding("EUC-KR");
    
    String pg = StringUtils.defaultString(request.getParameter("mpage"), "1");
    String mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");
    String jaction = request.getParameter("jaction").replaceAll("<","").replaceAll(">","");
    String muid = request.getParameter("muid").replaceAll("<","").replaceAll(">","");
    
	String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
    
    String memoId = vod_id;
 
    String memoName = vod_name;

    out.println("jaction = " + jaction);
    out.println("muid = " + muid);
    if (StringUtils.isEmpty(jaction) 
        || !StringUtils.equals(jaction,"delete")) 
        {
		
%>
        <script type="text/javascript" language="javascript">
            alert("필수 파라미터가 맞지 않습니다.");
            history.go(-1);
        </script>
<%
    }
	
	
%>
<%    
	com.vodcaster.sqlbean.MemoInfoBean memoBean = new com.vodcaster.sqlbean.MemoInfoBean();
	
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
	
	
    StringBuffer param = new StringBuffer("");
    param.append("mpage=").append(pg);
    param.append("&flag=").append(flag);
    param.append("&mcode=").append(mcode);
    MemoManager memoMgr = MemoManager.getInstance();

    out.println("flag = " + flag);
    try {
		memoMgr.saveMemo(memoBean, jaction);
	} catch(Exception e) {
		System.err.println(e.toString());
	} finally {
	}

	
	  
	


	out.println("<script type=\"text/javascript\" language=\"javascript\">");
	if (flag != null && flag.equals("B")){  // 방문자
		out.println("location.href='/vodman/board/mng_boardListComment.jsp?"+param.toString()+"';");
	} else {
		out.println("location.href='/vodman/vod_aod/mng_boardListComment.jsp?" + param.toString()+"';");
	}
	out.println("</script>");     
	%>

	
