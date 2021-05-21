<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>
<jsp:useBean id="questionSQLBean" class="com.vodcaster.sqlbean.QuestionSqlBean"/>

<%
	 /**
	 * @author ������
	 *
	 * @description : �������� ���
	 * date : 2009-10-15
	 */

	int del_quest_id = 0;
	try{
		del_quest_id = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("quest_id")));
	}catch(Exception e){
		del_quest_id = 0;
	}

	/*-------------------------
	 *��ǥ����
	 *-------------------------*/
	if( del_quest_id != 0 ){
				if(!chk_auth(vod_id, vod_level, "s_del")) {
						out.println("<script language='javascript'>\n" +
												"alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
												"history.go(-1);\n" +
												"</script>");
						return;
				}
        try{
            questionSQLBean.deleteQuestion( del_quest_id );
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

        //SHOP_ENV.put( "SHOP_QUESTION", shop_question );

        //SHOP_QUESITME
        Vector shop_quesitem = null;
        try{
            //System.out.println( "SHOP_QUESITME loading..." );
            shop_quesitem = questionSQLBean.getQuestionItem( ((Integer)(shop_question.elementAt(0))).intValue() );
        }catch(Exception e){System.out.println(e);}

        if( shop_quesitem == null )
            shop_quesitem = new Vector();

        //SHOP_ENV.put( "SHOP_QUESITME", shop_quesitem );
        //application.setAttribute( "SHOP_ENV", SHOP_ENV );
	}


    Vector v_question = null;
    Vector v_question_column = null;

    try{
        v_question = questionSQLBean.getAllQuestion();
	}catch(Exception e){
		out.println("<script>alert('ó�� �� ������ �߻��Ͽ����ϴ�.');history.back();</script>");
	}

	//--------------------------------
	//paging...........
	//--------------------------------
	int totalArticle =0; //�� ���ڵ� ����
	int pg = 1;

	if(v_question !=null && v_question.size() >0){

		totalArticle= v_question.size(); // �� �Խù� ��

		
		try{
			pg=Integer.parseInt((request.getParameter("page")==null)?"1":request.getParameter("page"));
		}catch(Exception e){
			pg = 1;
		}
		if(pg < 1)	pg=1;

		try{
			pageBean.setTotalRecord(totalArticle);
			pageBean.setLinePerPage(10);
			pageBean.setPagePerBlock(4);
			pageBean.setPage(pg);
		}catch(Exception e){
			System.out.println("PAGEEXCEPTION = "+e);
		}
		if(pg > pageBean.getTotalPage())	pg=1;
	}
	
	

%>
<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
<!--
    function question_view(idx){
        /////////////////////////////
        size = "width=406,height=325, scrollbars=auto";
        /////////////////////////////
        window.open("","newWin",size);
        form2.method="post";
        form2.action = "question_result.jsp?proc=&quest_id=" +idx;
        form2.target = "newWin";
        form2.submit();
    }

    function deleteQuestion(idx){
        if(confirm("�����Ͻðڽ��ϱ�?")){
            form2.method = "post";
            form2.action = "mng_poll.jsp?mcode=<%=mcode%>&proc=delete&quest_id=" +idx;
            form2.target = "_self";
            form2.submit();
        }
    }

//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

<div id="contents">
	<h3><span>����</span>����</h3>
	<p class="location">������������ &gt; ����Ʈ���� &gt; <span>��������</span></p>
	<p class="line"></line>
	<div id="content">
		<!-- ���� -->
		<p class="to_page">Total<b><%if (v_question != null && v_question.size() > 0) {out.println(pageBean.getTotalRecord());} else {out.println("0");}%></b>
		Page<b><%if (v_question != null && v_question.size() > 0) {out.println(pg);} else {out.println("0");}%>/<%if (v_question != null && v_question.size() > 0) {out.println(pageBean.getTotalPage());} else {out.println("0");}%></b></h4>
		<form name="form2">
		<table cellspacing="0" class="board_list" summary="��������">
		<caption>��������</caption>
		<colgroup>
			<col width="8%"/>
			<col/>
			<col width="10%"/>
			<col width="12%"/>
		</colgroup>
		<thead>
			<tr>
				<th>��ȣ</th>
				<th>����</th>
				<th>�����</th>
				<th>����</th>
			</tr>
		</thead>
		<tbody>
<%

	for(int i = 0; v_question !=null && i < v_question.size(); i++ ){
		v_question_column = (Vector)(v_question.elementAt(i));
		String quest_id = String.valueOf(v_question_column.elementAt(0));
		String content = String.valueOf(v_question_column.elementAt(1));
		String day = String.valueOf(v_question_column.elementAt(2)).substring(0,10);

%>
			<tr class="height_25 font_127">
				<td class="bor_bottom01"><%=i+1%></td>
				<td class="align_left bor_bottom01" style="word-break:break-all;"><a href="javascript:question_view(<%=quest_id%>);" title="<%=content%>"><%=content%></a></td>
				<td class="bor_bottom01"><%=day%></td>
				<td class="bor_bottom01"><a href="frm_pollUpdate.jsp?mcode=<%=mcode%>&quest_id=<%=quest_id%>" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;<a href="javascript:deleteQuestion(<%=quest_id%>);" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
			</tr>
<%
	}
%>
		</tbody>
		</table>
		</form>
<%
	if (v_question != null && v_question.size() > 0 && pageBean != null) {
		String jspName = "mng_poll.jsp";
		String strLink = "&mcode=" + mcode;
%>
		<%@ include file="pop_page_link.jsp" %>
<%}%>
		<div class="but01">
			<a href="frm_pollAdd.jsp?mcode=<%=mcode%>"><img src="/vodman/include/images/but_addi.gif" alt="�߰�"/></a>
		</div>
		<br/><br/>
	</div>
</div>
<%@ include file="/vodman/include/footer.jsp"%>

