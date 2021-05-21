<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="com.hrlee.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.yundara.util.CharacterSet" %>
<%@ page import="com.security.*" %>
 
<%@ include file="/include/chkLogin.jsp" %>

<%
    request.setCharacterEncoding("EUC-KR");

	String paramOcode = request.getParameter("ocode");
	String paramCcode = request.getParameter("ccode");
	String paramMuid = request.getParameter("muid");
	
	String flag = request.getParameter("flag");
	if (flag == null) {
		flag = "M";
	}

//  메모 읽기

    int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
    Hashtable memo_ht = new Hashtable();
    MemoManager memoMgr = MemoManager.getInstance();
	if (paramOcode != null && paramOcode.length() > 0) {
	 memo_ht = memoMgr.getMemoListLimit(paramOcode, mpg, 3, flag);
	 
	}

    Vector memoVt = (Vector)memo_ht.get("LIST");
	com.yundara.util.PageBean mPageBean = null;

	if(memoVt != null && memoVt.size()>0){
    mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
	}
   if(memoVt == null || (memoVt != null && memoVt.size() <= 0)){
    	//결과값이 없다.
    	//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
    }
    else{
    	if(mPageBean != null){
    		mPageBean.setPagePerBlock(4);
	    	mPageBean.setPage(mpg);
    	}
    }

	int memo_size = 0;
	if (paramOcode != null && paramOcode.length() > 0) {
		memo_size = memoMgr.getMemoCount( paramOcode ,flag);
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head>
<title>memo_frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="../include/css/default.css" rel="stylesheet" type="text/css" />

</head>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<script type="text/javascript" language="javascript">
<%
	FucksInfoManager mgr = FucksInfoManager.getInstance();
    Hashtable result_ht = null;
    result_ht = mgr.getAllFucks_admin("");
    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
	int totalArticle =0; //총 레코드 갯수
	int totalPage = 0 ; //
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(1);
				totalArticle = pageBean.getTotalRecord();
		        totalPage = pageBean.getTotalPage();
	        }
		}
    }
	%>
	var rgExp;
	<%
	if(totalPage >0 ){
	%>
	var splitFilter = new Array(<%=totalPage%>,"script");
	<%
	}else{%>
	var splitFilter = new Array("시팔","씨팔","쌍놈","쌍년","개년","개놈","개새끼","니미럴","개같은년","개같은놈","니기미","존나","좃나","십새끼","script");
	<%
	}
	%>
	<%
	if(vt != null && vt.size()>0){
		int list = 0;
		FuckInfoBean linfo = new FuckInfoBean();
		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
			  com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)vt.elementAt(list));
			  %>
			  splitFilter[<%=i%>] = '<%=linfo.getFucks()%>';
			  <%
		}
	}
	%>
	function filterIng(str , element , id){  
		for (var ii = 0 ;ii < splitFilter.length ; ii++ )
		{
			rgExp = splitFilter[ii];
			if (str.match(rgExp))
			{
				alert(rgExp + "은(는) 불량단어로 입력하실수 없습니다");
				var range = document.getElementsByName(id)[0].createTextRange();
				range.findText(rgExp);
				range.select();
				return false;
			}
		}
	}





function isEmpty(data){
	if (data.value == null || data.value.replace(/ /gi, "") == "") {
		return true;
	}
		return false;
	}
function saveChk() {
	
	var f = document.form1;

	if (isEmpty(f.comment)) {
		alert("메모 내용을 입력하세요");
		return;
	} else if (f.comment.length > 100){
		alert(" 글자를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다.");		
		return;
	}

	if(filterIng(f.comment.value, f.comment,"comment") == false){
			return;
	}

	f.submit();

}
function deleteChk(muid) {
	var f = document.comment_del

	if (confirm("메모를 삭제하시겠습니까")) {
		if (muid != "") {
			f.muid.value=muid;
			f.submit();
		}
	}
}

function fc_chk_byte(memo) 
{ 

	var ls_str = memo.value; // 이벤트가 일어난 컨트롤의 value 값 
	var li_str_len = ls_str.length; // 전체길이 

	// 변수초기화 
	var li_max = 400; // 제한할 글자수 크기 
	var i = 0; // for문에 사용 
	var li_byte = 0; // 한글일경우는 2 그밗에는 1을 더함 
	var li_len = 0; // substring하기 위해서 사용 
	var ls_one_char = ""; // 한글자씩 검사한다 
	var ls_str2 = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다. 

	for(i=0; i< li_str_len; i++) 
	{ 
	// 한글자추출 
	ls_one_char = ls_str.charAt(i); 

	// 한글이면 2를 더한다. 
	if (escape(ls_one_char).length > 4) 
	{ 
	li_byte += 2; 
	} 
	// 그밗의 경우는 1을 더한다. 
	else 
	{ 
	li_byte++; 
	} 

	// 전체 크기가 li_max를 넘지않으면 
	if(li_byte <= li_max) 
	{ 
	li_len = i + 1; 
	} 
	} 

	// 전체길이를 초과하면 
	if(li_byte > li_max) 
	{ 
		alert( li_max + " 글자를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. "); 
		ls_str2 = ls_str.substr(0, li_len); 
		memo.value = ls_str2; 

	} 
	memo.focus(); 
} 

function fc_chk2() 
{ 
	if(event.keyCode == 13) 
		event.returnValue=false; 
} 
</script>
<script language="JavaScript">
<!--
function name_check(temp_url){
 
	temp_url =  temp_url.replace(/&/gi, '||');
//	alert(temp_url);
	window.open('/new3/user/popup/name_check.jsp?result_url='+temp_url, 'popup','width=410, height=460, left=300, top=200');
}
// -->
</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
</noscript>
 
 <body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 
 <div class="comment">
				<div id="commentFrame">
					<h4 class="cTitle">리뷰의견(<span><%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%></span>)건</h4>
					<div class="commentInput">
					<form name="form1" method="post" action="memo_save.jsp" >
						<input type="hidden" name="ocode" value="<%=paramOcode%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
						<input type="hidden" name="flag" value="<%=flag %>" />
<%-- 						<input type="hidden" name="wname" value="<%=comment_name %>" /> --%>
<%-- 						<input type="hidden" name="pwd" value="<%=comment_pwd %>" /> --%>
						<span class="warning">의견작성<span>&nbsp;&nbsp;|&nbsp;&nbsp;비방, 욕설, 광고 등은 사전협의 없이 삭제됩니다.</span></span>
						<ul>
							<li><label for="wnick_name">닉네임</label></li>
							<li><input type="text" name="wnick_name" value="" id="wnick_name" title="닉네임"/></li>
							<li class="pl20"><label for="pwd">비밀번호</label></li>
							<li><input type="password" name="pwd" value=""  id="pwd" title="비밀번호"/></li>
						</ul>
						<div class="input_wrap">
							<textarea name="comment" wrap="hard" ></textarea>
							<input type="image" src="../include/images/btn_reply_ok.gif" alt="확인" class="img"/>
						</div>
						</form>
					</div>
					<div class="commentList">
					
<%
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
 
			<dl>
				<dt class="name"><%=SEEDUtil.getDecrypt(memoBean.getWname())%><span class="day"><%=memoBean.getWdate() %></span><% if(user_key != null && memoBean.getPwd().equals(user_key)){%><span class="del"><a href="javascript:deleteChk('<%=memoBean.getMuid()%>');" title="댓글삭제"><img src="../include/images/btn_reply_del.gif" alt="delete"/></a></span><%}%></dt>
				<dd class="subject"><%=StringUtils.replace(StringEscapeUtils.escapeHtml(memoBean.getComment()), "\n", "<br/>")%></dd>
			</dl>
			
<%
		}
	}
%>
					</div>
					<form name="comment_del" method="post" action="memo_save.jsp" >
					<input type="hidden" name="ocode" value="<%=paramOcode%>" />
					<input type="hidden" name="jaction" value="del" />
					<input type="hidden" name="muid" value="" />
					<input type="hidden" name="pwd" value="<%=user_key %>" />
					<input type="hidden" name="flag" value="<%=flag %>" />
					</form>
						<%if(memoVt != null && memoVt.size()>0){ %>	
					 
						 <%@ include file="page_link_memo2.jsp"%>
					 
						<%} else { %>
							<span class="noComment"> 첫 의견을 남겨주세요. </span>
						<%} %>
				</div>
			</div>
			
 
</body>
</html>