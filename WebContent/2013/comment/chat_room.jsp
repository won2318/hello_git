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
	flag = "L";
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
		
		 session_random_num =	(String)session.getValue("random_num");
 
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
		 
			out.println("top.name_check_conform('/2013/live/live_player.jsp?rcode="+ocode+"');");
		 
		out.println("</script>");
    }
 //////////////////////////////////////
 // ��� ��� ����
 
//  �޸� �б�
   
   Vector memo_vt =  null;
    MemoManager memoMgr = MemoManager.getInstance();
	if (ocode != null && ocode.length() > 0) { 
		//muid, ocode, id, pwd, wdate,
		//comment, wname, wnick_name, ip, flag,
		//rtitle, rwdate
	  memo_vt = memoMgr.getMemoListAll(ocode, flag, "asc");
	}
   
if(memo_vt != null && !memo_vt.isEmpty() && memo_vt.size() > 0  ) {
	out.println("<ul>");
	int list = 0;
		for(int i =0 ; i < memo_vt.size()  ; i++)
		{ 
			if (wnick_name != null && wnick_name.equals(String.valueOf(((Vector) (memo_vt.elementAt(i))).elementAt(7)))) {
				out.print("<li class=\"me\">"); 
				} else {
				out.print("<li class=\"you\"> <span class=\"name\">"+String.valueOf(((Vector) (memo_vt.elementAt(i))).elementAt(7))+"</span>");
				} %>
			 
				<div class="chattingSub">
					<div class="subject_center">
						<span class="center_left"><span class="top_left"></span> <span class="top_right"></span></span></span>
						<span class="center_center">
							<span class="top"></span><%=chb.getContent_2(String.valueOf(((Vector) (memo_vt.elementAt(i))).elementAt(5)),"true")%><span class="bottom"></span>
						</span>
						<span class="center_right"><span class="bottom_left"></span> <span class="bottom_right"></span></span></span>
						</span>
						<span class="date"><%=String.valueOf(((Vector) (memo_vt.elementAt(i))).elementAt(4)).substring(10) %></span>
						<%if (wnick_name != null && wnick_name.equals(String.valueOf(((Vector) (memo_vt.elementAt(i))).elementAt(7)))) { %>
<!-- 						<span class="del"> -->
<!-- 						<a href="#" title="�ۻ���"><img src="../include/images/btn_reply_del.gif" alt="delete"/></a> -->
<!-- 						</span> -->
						<%} %>
					</div>
				</div>
			</li>
			<li class="clear"></li> 
			
<%
		} 
		out.println("</ul>");
		
	}
%> 