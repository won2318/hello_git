<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.hrlee.sqlbean.*,  com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

<jsp:useBean id="questionSQLBean" class="com.vodcaster.sqlbean.QuestionSqlBean"/>

<%
    //String content = CharacterSet.toKorean(request.getParameter("content"));
    //String [] item_content = request.getParameterValues("item_content");

    //for( int i=0; item_content!=null && i < item_content.length ; i++ ) {
    //    System.out.println("proc_pollAdd 추가" +i);
    //    item_content [i] = CharacterSet.toKorean( item_content [i] );
    //}

	 request.setCharacterEncoding("EUC-KR");
	 
	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0104";
	}
		
    try{
        //questionSQLBean.insertQuestion(content, item_content);
    	questionSQLBean.createQuestion(request);
	}catch(Exception e){
		out.println("<script>alert('처리 중 오류가 발생하였습니다.');history.back();</script>");
	}


	//SHOP_QUESTION
	Vector shop_question = null;
	try{
		shop_question = questionSQLBean.getLastQuestion();
	}catch(Exception e){System.out.println(e);}
	if( shop_question == null )
		shop_question = new Vector();

	//SHOP_QUESITME
	Vector shop_quesitem = null;
	try{
		shop_quesitem = questionSQLBean.getQuestionItem( ((Integer)(shop_question.elementAt(0))).intValue() );
	}catch(Exception e){System.out.println(e);}
	if( shop_quesitem == null )
		shop_quesitem = new Vector();

	response.sendRedirect("mng_poll.jsp?mcode="+mcode);
%>