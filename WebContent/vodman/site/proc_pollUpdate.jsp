<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.hrlee.sqlbean.*,  com.vodcaster.sqlbean.*, com.yundara.util.*"%>

<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

<jsp:useBean id="questionSQLBean" class="com.vodcaster.sqlbean.QuestionSqlBean"/>

<%
	request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0) {
		mcode = "0104";
	}
	int quest_id = Integer.parseInt(request.getParameter("quest_id"));

    try{
        int i = questionSQLBean.deleteQuestion(quest_id);
    }catch(Exception e){
        out.println("<script>alert('ó�� �� ������ �߻��Ͽ����ϴ�.');history.back();</script>");
    }

    //String content = CharacterSet.toKorean(request.getParameter("content"));
    //String [] item_content = request.getParameterValues("item_content");

    //for( int i =0 ; item_content != null && i < item_content.length ; i++ )
    //    item_content [i] = CharacterSet.toKorean( item_content [i] );


    try{
		//int i = questionSQLBean.insertQuestion(content, item_content);
    	int i = questionSQLBean.createQuestion(request);
	}catch(Exception e){
		out.println("<script>alert('ó�� �� ������ �߻��Ͽ����ϴ�.');history.back();</script>");
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