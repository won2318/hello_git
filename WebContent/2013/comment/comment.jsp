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

//  �޸� �б�

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
    	//������� ����.
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
	int totalArticle =0; //�� ���ڵ� ����
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
	var splitFilter = new Array("����","����","�ֳ�","�ֳ�","����","����","������","�Ϲ̷�","��������","��������","�ϱ��","����","����","�ʻ���","script");
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
				alert(rgExp + "��(��) �ҷ��ܾ�� �Է��ϽǼ� �����ϴ�");
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
		alert("�޸� ������ �Է��ϼ���");
		return;
	} else if (f.comment.length > 100){
		alert(" ���ڸ� �ʰ� �Է��Ҽ� �����ϴ�. \n �ʰ��� ������ �ڵ����� ���� �˴ϴ�.");		
		return;
	}

	if(filterIng(f.comment.value, f.comment,"comment") == false){
			return;
	}

	f.submit();

}
function deleteChk(muid) {
	var f = document.comment_del

	if (confirm("�޸� �����Ͻðڽ��ϱ�")) {
		if (muid != "") {
			f.muid.value=muid;
			f.submit();
		}
	}
}

function fc_chk_byte(memo) 
{ 

	var ls_str = memo.value; // �̺�Ʈ�� �Ͼ ��Ʈ���� value �� 
	var li_str_len = ls_str.length; // ��ü���� 

	// �����ʱ�ȭ 
	var li_max = 400; // ������ ���ڼ� ũ�� 
	var i = 0; // for���� ��� 
	var li_byte = 0; // �ѱ��ϰ��� 2 �׹ܿ��� 1�� ���� 
	var li_len = 0; // substring�ϱ� ���ؼ� ��� 
	var ls_one_char = ""; // �ѱ��ھ� �˻��Ѵ� 
	var ls_str2 = ""; // ���ڼ��� �ʰ��ϸ� �����Ҽ� ������������ �����ش�. 

	for(i=0; i< li_str_len; i++) 
	{ 
	// �ѱ������� 
	ls_one_char = ls_str.charAt(i); 

	// �ѱ��̸� 2�� ���Ѵ�. 
	if (escape(ls_one_char).length > 4) 
	{ 
	li_byte += 2; 
	} 
	// �׹��� ���� 1�� ���Ѵ�. 
	else 
	{ 
	li_byte++; 
	} 

	// ��ü ũ�Ⱑ li_max�� ���������� 
	if(li_byte <= li_max) 
	{ 
	li_len = i + 1; 
	} 
	} 

	// ��ü���̸� �ʰ��ϸ� 
	if(li_byte > li_max) 
	{ 
		alert( li_max + " ���ڸ� �ʰ� �Է��Ҽ� �����ϴ�. \n �ʰ��� ������ �ڵ����� ���� �˴ϴ�. "); 
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
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 
</noscript>
 
 <body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 
 <div class="comment">
				<div id="commentFrame">
					<h4 class="cTitle">�����ǰ�(<span><%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%></span>)��</h4>
					<div class="commentInput">
					<form name="form1" method="post" action="memo_save.jsp" >
						<input type="hidden" name="ocode" value="<%=paramOcode%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
						<input type="hidden" name="flag" value="<%=flag %>" />
<%-- 						<input type="hidden" name="wname" value="<%=comment_name %>" /> --%>
<%-- 						<input type="hidden" name="pwd" value="<%=comment_pwd %>" /> --%>
						<span class="warning">�ǰ��ۼ�<span>&nbsp;&nbsp;|&nbsp;&nbsp;���, �弳, ���� ���� �������� ���� �����˴ϴ�.</span></span>
						<ul>
							<li><label for="wnick_name">�г���</label></li>
							<li><input type="text" name="wnick_name" value="" id="wnick_name" title="�г���"/></li>
							<li class="pl20"><label for="pwd">��й�ȣ</label></li>
							<li><input type="password" name="pwd" value=""  id="pwd" title="��й�ȣ"/></li>
						</ul>
						<div class="input_wrap">
							<textarea name="comment" wrap="hard" ></textarea>
							<input type="image" src="../include/images/btn_reply_ok.gif" alt="Ȯ��" class="img"/>
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
				<dt class="name"><%=SEEDUtil.getDecrypt(memoBean.getWname())%><span class="day"><%=memoBean.getWdate() %></span><% if(user_key != null && memoBean.getPwd().equals(user_key)){%><span class="del"><a href="javascript:deleteChk('<%=memoBean.getMuid()%>');" title="��ۻ���"><img src="../include/images/btn_reply_del.gif" alt="delete"/></a></span><%}%></dt>
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
							<span class="noComment"> ù �ǰ��� �����ּ���. </span>
						<%} %>
				</div>
			</div>
			
 
</body>
</html>