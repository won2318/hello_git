<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="com.hrlee.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.yundara.util.CharacterSet" %>
<%@ page import="com.security.*" %>
<%-- jstl --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file = "/vodman/include/auth_pop.jsp"%>
<%
    request.setCharacterEncoding("EUC-KR");

	String paramOcode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
	String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	if (flag == null) {
		flag = "M";
	}



//  메모 읽기
    int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
    Hashtable memo_ht = new Hashtable();
    MemoManager memoMgr = MemoManager.getInstance();
	if (paramOcode != null && paramOcode.length() > 0) {
	 memo_ht = memoMgr.getMemoListLimit( paramOcode, mpg, 5, flag);
	}

    Vector memoVt = (Vector)memo_ht.get("LIST");
	com.yundara.util.PageBean mPageBean = null;

	if(memoVt != null && memoVt.size()>0){
		mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
		if(mPageBean != null){
    		mPageBean.setPagePerBlock(10);
	    	mPageBean.setPage(mpg);
    	}
	}else{
    	//결과값이 없다.
    	//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
    }
    

	int memo_size = 0;
	if (paramOcode != null && paramOcode.length() > 0) {
		memo_size = memoMgr.getMemoCount(paramOcode,flag);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<title>관리자페이지</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
		<script language=JavaScript src="/vodman/include/js/resizewin.js"></script>
		<script language="javascript" src="/vodman/include/js/script.js"></script>

<script language="JavaScript">
<!-- 
	function resizeFrame(iframeObj){
	  var innerBody = iframeObj.document.body;
	  
	  var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
	  var innerWidth = innerBody.scrollWidth + (innerBody.offsetWidth - innerBody.clientWidth);
	  
//	alert(innerHeight);
//	alert(innerWidth);
	  restage = new resizeWin(innerWidth+5,innerHeight+30);
	  restage.onResize();

	}
//-->
</script>
		<script type="text/javascript" language="javascript">
			function isEmpty(data){
				if (data.value == null || data.value.replace(/ /gi, "") == "") {
					return true;
				}
					return false;
				}
			function saveChk() {
				var f = document.form1;
				
				
				
				var comm = document.getElementById("comment").value;
				if(comm.length < 1){

					comm.focus();
					return;
				}
				if(comm.length > 100){
					alert(" 댓글은 한글 50자, 영문 100자를 초과 입력할수 없습니다.");
					
					return;
				}

				f.submit();

			}
			
			function deleteChk(muid) {
				var f = document.form1
				if (confirm("메모를 삭제하시겠습니까?")) {
					if (muid != "") {
						f.jaction.value="delete";
						f.muid.value=muid;
						f.submit();
					}
				}
			}

			

			function fc_chk2() 
			{ 
				if(event.keyCode == 13) 
					event.returnValue=false; 
			} 
			</script>
	</head>
<body onload="resizeFrame(this)">
<div id="research">
	<h3><img src="/vodman/include/images/a_reply_title.gif" alt="댓글관리"/></h3>
	<div id="research_top"></div>
	<form name="form1" method="post" action="memo_save.jsp">
	<input type="hidden" name="ocode" value="<%=paramOcode%>">
	<input type="hidden" name="field" value="${param.field}">
	<input type="hidden" name="searchstring" value="${param.searchstring}">
	<input type="hidden" name="sorder" value="${param.sorder}">
	<input type="hidden" name="code" value="${param.code}">
	<input type="hidden" name="jaction" value="save">
	<input type="hidden" name="muid" value="">
	<input type="hidden" name="flag" value="<%=flag%>">

	<div id="research_cen">
		<table cellspacing="0" class="reply" summary="댓글관리">
			<caption>댓글관리</caption>
			<colgroup>
				<col/>
				<col/>
			</colgroup>
			<tbody class="font_127">
				<tr>
					<td class="title_dot03">댓글달기 <a href="proc_comment_execl.jsp?ocode=<%=paramOcode%>&flag=<%=flag%>">[엑셀 받기]</a></td>
					<td></td>
				</tr>
				<tr>
					<td class="pa_left"><textarea name="comment" id="comment" class="input01" style="width:420px;height:35px;" cols="100" rows="100" onkeyup="fc_chk_byte(this,100);" onkeypress="fc_chk2()"></textarea></td>
					<td class="pa_right"><a href="javascript:saveChk();" title="확인"><img src="/vodman/include/images/but_ok2.gif" alt="확인"/></a></td>
				</tr>
			</tbody>
		</table>
		<p class="to_page bor_bottom01 height_15 pa_top">Total<b>
		<%if(memoVt != null && memoVt.size()>0){
					%>
					<%=mPageBean.getTotalRecord()%></b>Page<b><%=mPageBean.getCurrentPage()%> / <%=mPageBean.getTotalPage()%></b>
					<%}else{%>
					0 </b>Page<b>1/1</b><%}%></b></p>
		<table cellspacing="0" class="reply" summary="댓글목록">
			<caption>댓글목록</caption>
			<colgroup>
				<col/>
				<col width="10%"/>
				<col width="8%"/>
			</colgroup>
			<tbody class="font_117">
<!-- 댓글 리스트 -->
<%
boolean isAdmin = false;
String adminId = (String)session.getValue("admin_id");
if(adminId == null){
	out.println("window.close();");
	return;
}
if (StringUtils.isNotEmpty(adminId) || StringUtils.equals(vod_id, "admin")) {
	isAdmin = true;
}
if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)	&& mPageBean != null ) {
	
		int list = 0;
			for(int i = mPageBean.getStartRecord()-1 ; (i<mPageBean.getEndRecord()) && (list<memoVt.size()) ; i++, list++)
			{
				MemoInfoBean memoBean = new MemoInfoBean();
				com.yundara.beans.BeanUtils.fill(memoBean, (Hashtable)memoVt.elementAt(list));

				String prnName = memoBean.getId();
				if (StringUtils.isNotEmpty(memoBean.getWnick_name())) {
					prnName = memoBean.getWnick_name();
				} else if (StringUtils.isNotEmpty(memoBean.getWname())) {
					prnName = memoBean.getWname();
				}
				prnName = memoBean.getId();
%>
				<tr class="pa_all">
					<td class="pa_left pa_all bor_bottom01" style="word-break:break-all;"><%=StringUtils.replace(StringEscapeUtils.escapeHtml(memoBean.getComment()), "\n", "<br>")%><br/>[<%=memoBean.getWdate() != null && memoBean.getWdate().length()>10?memoBean.getWdate().substring(0,10):memoBean.getWdate()%>]</td>
					<td class="pa_right bor_bottom01"><%=memoBean.getWnick_name()%></td>
					<td class="bor_bottom01"><a href="javascript:deleteChk(<%=memoBean.getMuid()%>);" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
				</tr>
<%
			}
	}
%>

				
			</tbody>
		</table>
		<%if(memoVt != null && memoVt.size()>0){ %>
			<%@ include file="page_link_memo2.jsp" %>
		 <%} %>
		
	</div>
	<div id="research_bot"></div>
	<div class="but01">
		<a href="javascript:self.close();;"><img src="/vodman/include/images/but_close.gif" alt="닫기"/></a>
	</div>		
	</form>
</div>
</body>
</html>