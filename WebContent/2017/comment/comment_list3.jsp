<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ include file="/include/chkLogin.jsp" %>
<%
    request.setCharacterEncoding("EUC-KR");
    
    String pg = StringUtils.defaultString(request.getParameter("page"), "1");
 
    String jaction = "";
    if (request.getParameter("jaction") != null && request.getParameter("jaction").length() > 0 ) jaction = request.getParameter("jaction").replaceAll("<","").replaceAll(">","");
    String muid = null;
    if (request.getParameter("muid") != null && request.getParameter("muid").length() > 0) muid = 	request.getParameter("muid").replaceAll("<","").replaceAll(">","");
    String ocode =null;
    if (request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0) ocode =	request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
    String flag =null;
     if (request.getParameter("flag") != null  && request.getParameter("flag").length() > 0) flag =	request.getParameter("flag").replaceAll("<","").replaceAll(">","");
    String comment ="";
    if (request.getParameter("comment") != null && request.getParameter("comment").length() > 0) comment =request.getParameter("comment").replaceAll("<","").replaceAll(">","");
    String wnick_name ="";
    if (request.getParameter("wnick_name") != null && request.getParameter("wnick_name").length() > 0) wnick_name =request.getParameter("wnick_name").replaceAll("<","").replaceAll(">","");
    String pwd = null;
    if (request.getParameter("pwd") != null && request.getParameter("pwd").length() > 0) pwd = request.getParameter("pwd").replaceAll("<","").replaceAll(">","");
    String board_id ="";
    if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) board_id =  request.getParameter("board_id").replaceAll("<","").replaceAll(">","");
     
	int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
    String memoId = vod_id;
 
    String memoName = vod_name;
   
    if (StringUtils.isEmpty(jaction) || StringUtils.isEmpty(ocode) 
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
					<h4 class="cTitle">�����ǰ�(<span><%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%></span>)��</h4>
					<div class="commentInput">
					<form id="comment_form" name="comment_form" method="post" action="javascript:page_go()" >
						<input type="hidden" name="ocode" value="<%=ocode%>" />
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
					<div class="commentList" id="commentList">
					
					
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
	}
%> 

					</div>
					<form name="comment_del" method="post" action="../comment/pwd_check.jsp" >
					<input type="hidden" name="ocode" value="<%=ocode%>" />
					<input type="hidden" name="jaction" value="del" />
					<input type="hidden" name="muid" value="" />
					<input type="hidden" name="pwd" value="<%=user_key %>" />
					<input type="hidden" name="flag" value="<%=flag %>" />
					</form>
						<%if(memoVt != null && memoVt.size()>0){ %>	
					 
					
					 
						<%} else { %>
							<span class="noComment"> ù �ǰ��� �����ּ���. </span>
						<%} %>
				</div>
 