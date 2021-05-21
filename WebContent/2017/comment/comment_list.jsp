<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vodcaster.sqlbean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ include file="/include/chkLogin.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  
	<title>수원인터넷방송</title> 
</head>
<body>
<%
    //request.setCharacterEncoding("EUC-KR");
 
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
 
	int mpg = NumberUtils.toInt(request.getParameter("page"), 1);
    String memoId = vod_id;
 
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

		if (!memoMgr.getPwd(muid).equals(request.getParameter("pwd"))) { 
			out.println("<script type=\"text/javascript\" language=\"javascript\">");
			out.println("alert(\"패스워드가 맞지 않습니다!\");"); 
			out.println("location.href='/2017/board/board_view.jsp?board_id="+board_id+"&list_id="+ocode+"';");
			out.println("</script>");     
			return;
		}
	} else if (StringUtils.equals(jaction,"save")) {
		
		 session_random_num =	(String)session.getValue("random_num");
 
		if (request.getParameter("chk_word") != null && session_random_num.length()> 0 && !request.getParameter("chk_word").equals(session_random_num)) {
			out.println("<script type=\"text/javascript\" language=\"javascript\">");
			out.println("alert(\"확인문자가 맞지 않습니다!\");"); 
			out.println("page_go(1);"); 
			out.println("</script>");     
			return;
		}
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
    
    if ( StringUtils.equals(jaction,"del")) { // 삭제 한경우 페이지 이동 처리
    	out.println("<script>");
		out.println("alert('삭제 되었습니다.')");
		if (flag.equals("B")) {
			//out.println("link_open('/2017/board/board_view.jsp?board_id="+board_id+"&list_id="+ocode+"');");
			out.println("location.href='/2017/board/board_view.jsp?board_id="+board_id+"&list_id="+ocode+"';");
		} else {
			out.println("location.href='/2017/video/video_player.jsp?ocode="+ocode+"';");
		}
	 
		out.println("</script>");
    }
 //////////////////////////////////////
 // 댓글 목록 생성
  
	if (flag == null) {
		flag = "M";
	}

//  메모 읽기
   
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
	if (ocode != null && ocode.length() > 0) {
		memo_size = memoMgr.getMemoCount( ocode ,flag);
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
			 
%> 
			<dl>
				<dt class="name"><%=memoBean.getWnick_name()%><span class="day"><%=memoBean.getWdate() %></span><span class="del"><a   href="javascript:deleteChk('<%=memoBean.getMuid()%>');" title="댓글삭제">Del</a></span></dt>
				<dd class="subject"><%=chb.getContent_2(memoBean.getComment(),"true")%></dd>
			</dl> 
<%
		} 
 
	      if (mPageBean.getTotalRecord() > mPageBean.getLinePerPage()) {
	 %>

	<div class="paginate">
	 

		<% if (mPageBean.getCurrentBlock() != 1) { %>
		<a href="javascript:page_go(<%=((mPageBean.getCurrentBlock()-2)*mPageBean.getPagePerBlock()+1)%>)" class="pre" title="이전페이지"><img src="../include/images/icon_back1.gif" alt="이전페이지"></a>
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
					<a href="javascript:page_go(<%= mPageBean.getCurrentBlock()*mPageBean.getPagePerBlock()+ 1%>)" class="next" title="다음페이지"><img src="../include/images/icon_next1.gif" alt="다음페이지"></a>
		<%
				}
		%>

	 </div>
	<%
		} 
	}
%> 
</body>
</html>