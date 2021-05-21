<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}

%>
<%
	/**
	 * @author lee hee rak
	 *
	 * @description : 욕설	 정보 수정.
	 * date : 2012-5-4
	 */

%>

<%

	String fuck_id = "";
	if(request.getParameter("fuck_id") == null) {
		out.println("<script lanauage='javascript'>alert('정보가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
	} else
		fuck_id = request.getParameter("fuck_id");
	int pg = 0;
    if(request.getParameter("page")==null || (request.getParameter("page") != null && request.getParameter("page").length()<=0)){
        pg = 1;
    }else{
        
		try{
			pg = Integer.parseInt(request.getParameter("page"));
		}catch(Exception e){
			pg = 0;
		}
    }
	com.vodcaster.sqlbean.FucksInfoManager mgr = com.vodcaster.sqlbean.FucksInfoManager.getInstance();
	Vector vt = mgr.getFuck(fuck_id);
    com.vodcaster.sqlbean.FuckInfoBean info = new com.vodcaster.sqlbean.FuckInfoBean();

	try {
		Enumeration e = vt.elements();
        Hashtable ht = (Hashtable)e.nextElement();

        com.yundara.beans.BeanUtils.fill(info, ht);


	} catch (Exception e) {}
%>

<%@ include file="/vodman/include/top.jsp"%>


<script language="javascript">
<!--
	function chkForm(form) {
		

		if(form.fucks.value == "") {
			alert("욕설을 입력해주세요.");
			form.fucks.focus();
			return ;
		}
		if(confirm("저장하시겠습니까?")) {
			form.submit();
		}
	}

	
//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>욕설</span> 수정</h3>
			<p class="location">관리자페이지 &gt; 회원관리 &gt; <span>욕설 수정</span></p>
			<div id="content">
			 <form name='frmMe' method='post' action="proc_fuck_update.jsp" >
			 <input type="hidden" name="fuck_id" value="<%=info.getFuck_id()%>" >
			 <input type="hidden" name="mcode" value="<%=mcode%>" />
				<table cellspacing="0" class="board_view" summary="욕설 수정">
				<caption>욕설 수정</caption>
				<colgroup>
					<col width="17%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="bor_top03">
					<tr>
						<th class="bor_bottom01"><strong>욕설</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="fucks" value="<%=info.getFucks() %>" class="input01" style="width:150px;" maxlength="20" /> (20자리)</td>
					</tr>
					
				</tbody>
				</table>
				
				<div class="but01">
					<a href="javascript:chkForm(document.frmMe);" title="저장"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="mng_fuckList.jsp?mcode=<%=mcode%>" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				
				<br/><br/>
				</form>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>