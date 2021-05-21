<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,org.apache.commons.lang.StringUtils,com.vodcaster.utils.TextUtil"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "be_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

<%
 
	String menu_title="편성표 링크";
 
	BestMediaManager mgr = BestMediaManager.getInstance();
	Vector links =mgr.getList_link();
	
	String title = "";
	String list_link = "";
 
if(links != null && links.size() >0){
 		
	title = String.valueOf(links.elementAt(1));
	list_link = String.valueOf(links.elementAt(2));
}
  
%>

<%@ include file="/vodman/include/top.jsp"%>
<%
mcode = "0205";
if (request.getParameter("mcode") != null && request.getParameter("mcode").length() > 0 ) {
	mcode = request.getParameter("mcode") ;
}
%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
 
<script language="javascript">
    function chkForm(form) {
 
        return confirm("<%=menu_title%> 관리를 저장하시겠습니까");
        
    }

     
</script>

<%@ include file="/vodman/best/best_left.jsp"%>
		<div id="contents">
			<h3><span><%=menu_title%> </span> </h3>
			<p class="location">관리자페이지 &gt; 메인화면관리 &gt; <span><%=menu_title%></span></p>			
			<div id="content">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="recom_vod" summary="추천 VOD" >
				<caption>추천 VOD</caption>
                                      <form name='frmMedia' method='post' action="proc_Link_Save.jsp" onSubmit="return chkForm(document.frmMedia);">
                                        <tr>
                                            <td class="bor_bottom01"  height="28" align="left">
                                            * 메인화면 편성표 링크 URL 을 입력 하시면 됩니다.<br>
                           				 </td>
                                      </tr>

                                      <tr>
                                          <td class="bor_bottom01" align="left">
                                               <input type="text" name="link" value="<%=list_link%>" size="80"/>
                                          </td>
                                      </tr>															
									  <tr>
                                               <td><input type="image" src="/vodman/include/images/but_ok3.gif"  border="0"></td>
                                        </tr>
                                     
                                      </form>
                                    </table>		
			
			
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>