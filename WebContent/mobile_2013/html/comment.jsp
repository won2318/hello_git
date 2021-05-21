<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ include file="/include/chkLogin.jsp" %>
<%
    //request.setCharacterEncoding("EUC-KR");
     
//    String code = request.getParameter("code");
//    String pageInfo = StringUtils.defaultString(request.getParameter("pageInfo"), "commu");
    String jaction = request.getParameter("jaction");
    String muid = request.getParameter("muid");
    String ocode = request.getParameter("ocode");
	String flag = request.getParameter("flag");
	String comment =request.getParameter("comment");
	String wnick_name =request.getParameter("wnick_name");
	String pwd =request.getParameter("pwd");
	String board_id =request.getParameter("board_id");
	int mpg = NumberUtils.toInt(request.getParameter("page"), 1);
    String memoId = vod_id;
//    String memoPwd = vod_pwd;
    String memoName = vod_name;
    String session_random_num = "";
	if (StringUtils.isEmpty(memoId)){ }
   
    if (StringUtils.isEmpty(jaction) || StringUtils.isEmpty(ocode) || !com.yundara.util.TextUtil.isNumeric(ocode)
        || !(StringUtils.equals(jaction,"save") || StringUtils.equals(jaction,"del")) 
        || StringUtils.equals(jaction, "del") && StringUtils.isEmpty(muid) && StringUtils.isEmpty(pwd)) {
 
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
   
    MemoManager memoMgr = MemoManager.getInstance();
    if(StringUtils.equals(jaction,"del")){

		if (!memoMgr.getPwd(muid).equals(request.getParameter("pwd"))) { //�н����� ����
			
			out.println("<script type=\"text/javascript\" language=\"javascript\">");
		 
			out.println("alert(\"�н����尡 ���� �ʽ��ϴ�!\");"); 
			out.println("history.back();"); 
			out.println("</script>");     
			return;
		}
	} else if (StringUtils.equals(jaction,"save")) {
		
// 		 session_random_num =	(String)session.getValue("random_num");
 
// 		if (request.getParameter("chk_word") != null && session_random_num.length()> 0 && !request.getParameter("chk_word").equals(session_random_num)) {
// 			out.println("<script type=\"text/javascript\" language=\"javascript\">");
// 			out.println("alert(\"Ȯ�ι��ڰ� ���� �ʽ��ϴ�!\");"); 
// 			out.println("page_go(1);"); 
// 			out.println("</script>");     
// 			return;
// 		}
	}
		 try {
				memoMgr.saveMemo(memoBean, jaction);
				session.putValue("random_num", "");
			} catch(Exception e) {
				System.err.println(e.toString());
				session.putValue("random_num", "");
				session_random_num = "";
			} finally {
				session.putValue("random_num", "");
			}
   }
    
    if ( StringUtils.equals(jaction,"del")) { // ���� �Ѱ�� ������ �̵� ó��
    	out.println("<script>");
		out.println("alert('���� �Ǿ����ϴ�.')");
		out.println("parent.opener.page_go(1);self.close();"); 
		//	out.println("top.location.href='vod_view.jsp?ocode="+ocode+"';");
		 
	 
		out.println("</script>");
    }
 //////////////////////////////////////
 // ��� ��� ����
  
	if (flag == null) {
		flag = "M";
	}

//  �޸� �б�
   
    Hashtable memo_ht = new Hashtable();
    MemoManager memoMgr = MemoManager.getInstance();
	if (ocode != null && ocode.length() > 0) {
	 memo_ht = memoMgr.getMemoListLimit(ocode, mpg, 3, flag);
	 
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
	if (ocode != null && ocode.length() > 0) {
		memo_size = memoMgr.getMemoCount( ocode ,flag);
	}
	%>
	<div id="commentFrame">
	<h4 class="cTitle">���:<%=memo_size %></h4>
	<div class="commentInput">
	<form id="comment_form" name="comment_form" method="post" action="javascript:comment_action()" > 
	 
	<input type="hidden" name="jaction" value="save" />
	<input type="hidden" name="muid" value="" />
	 
		<ul>
			<li class="pr7"><input type="text" name="wnick_name" value="" id="wnick_name" title="�г���" onclick="javascript:document.getElementById('wnick_name').value='';"/></li>
			<li><input type="password" name="pwd" value="" id="pwd" onclick="javascript:document.getElementById('pwd').value='';" title="��й�ȣ"/></li>
		</ul>
		<div class="input_wrap">
			<textarea name="comment" id="comment_write" wrap="hard" title="���"></textarea>
			<img src="../include/images/btn_reply_ok.gif" alt="Ȯ��" width="51" height="28" class="img" onclick="comment_action()"/>
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
			 
%>
 
			<dl>
				<dt class="name"><%=memoBean.getWnick_name()%><span class="day"><%=memoBean.getWdate() %></span><span class="del"><a href="javascript:deleteChk('<%=memoBean.getMuid()%>');" title="��ۻ���"><img src="../include/images/btn_reply_del.gif" alt="delete"/></a></span></dt>
				<dd class="subject"><%=chb.getContent_2(memoBean.getComment(),"true")%></dd>
			</dl>
			
<%
		}
 
 %>
 </div>	
 <% 
	      if (mPageBean.getTotalRecord() > mPageBean.getLinePerPage()) {
	 %>

	<div class="paginate">
	 

		<% if (mPageBean.getCurrentBlock() != 1) { %>
		<a href="javascript:page_go(<%=((mPageBean.getCurrentBlock()-2)*mPageBean.getPagePerBlock()+1)%>)" class="pre" title="����������"></a>
		<%
			} // the end of if statement
		%>

		<%
				for (int b=mPageBean.getStartPage(); b<=mPageBean.getEndPage(); b++) {
					if (b != mPageBean.getCurrentPage()){
		%>
					<a href="javascript:page_go(<%= b %>);"><%=b%></a>
		<%
					}else{
		%>
					<strong><%=b%></strong>
		<%
					} // the end of else statement
				} // the end of for statement
		%>
		<%
				if ( (mPageBean.getCurrentBlock()/(mPageBean.getPagePerBlock()+0.0)) < (mPageBean.getTotalBlock()/(mPageBean.getPagePerBlock()+0.0)) ) {
		%>
					<a href="javascript:page_go(<%= mPageBean.getCurrentBlock()*mPageBean.getPagePerBlock()+ 1%>)" class="next" title="����������"></a>
		<%
				}
		%>

	 </div>
	<%
		} 
		
	} else {
		out.println("</div>		<span class=\"noComment\"> ù �ǰ��� �����ּ���. </span>");
	}
%>     				
			
			</div>			
 
		
 