<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
 
<%@ include file="/vodman/include/top.jsp"%>
 
<%
	request.setCharacterEncoding("euc-kr");
	
	String sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">",""); 
	if(sub_idx == null){
		out.println("<script lanauage='javascript'>alert('�̵�� �ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); history.go(-1); </script>");
	}
	String sub_flag = "S"; // S - ���� ,  E - �̺�Ʈ
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
    int pg = 0;

    if(request.getParameter("page")==null){
        pg = 1;
    }else{
        pg = Integer.parseInt(request.getParameter("page"));
    }
 
	int listCnt = 15;				//������ ��� ���� 

    SubjectManager mgr = SubjectManager.getInstance();

    Vector Vt_sub = mgr.getSubject(sub_idx);
	String sub_title = "";
	if (Vt_sub != null && Vt_sub.size() > 0) {
		sub_title =  String.valueOf(Vt_sub.elementAt(1));
	}

    Hashtable result_ht = null;
    result_ht = mgr.getSubject_QuestionList(sub_idx, pg,listCnt );

    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(pg);
	        }
		}
    }
    
    

//	String strLink = "&sub_flag="+sub_flag;
	String strLink = "&page=" +pg+ "&sub_flag="+sub_flag+"&sub_idx="+sub_idx;
	
 %>
 <script language="JavaScript" type="text/JavaScript">
<!--
   // �����߰�
	function questionAdd(sub_idx){
		window.open("/vodman/subject/frm_subjectQuestionAdd.jsp?sub_idx="+sub_idx+"&sub_flag=<%=sub_flag%>" , "subject" , "width=630,height=500,scrollbars=yes");
	}

	// ���� ����
	function ansUpdate(sub_idx,question_idx){
		window.open("/vodman/subject/frm_subjectAnsUpdate.jsp?sub_idx="+sub_idx+"&question_idx="+question_idx+"&sub_flag=<%=sub_flag%>" , "subject" , "width=630,height=500,scrollbars=yes");
	}
	//�߰�
	function sub_question_update(sub_idx,question_idx){
//		var f = document.subjectList;
//		f.action = "/vodman/subject/frm_subjectQuestionUpdate.jsp?sub_idx="+sub_idx+"&question_idx="+question_idx;
//		f.submit();
		window.open("/vodman/subject/frm_subjectQuestionUpdate.jsp?sub_idx="+sub_idx+"&question_idx="+question_idx+"&sub_flag=<%=sub_flag%>", "subject" , "width=630,height=500,scrollbars=yes");

	}

	function sub_question_delete(sub_idx,question_idx){
		var f = document.subject;
		if(confirm("�����Ͻðڽ��ϱ�?")) {
			//alert("bbb"+sub_idx+"sss"+question_idx);
            f.action = "/vodman/subject/proc_subjectQuestionDelete.jsp?sub_idx="+sub_idx+"&question_idx="+question_idx+"&sub_flag=<%=sub_flag%>";
			f.submit();
        }
		
	}
	function open_view(){
		window.open("/vodman/subject/subject_user_admin.jsp?sub_idx=<%=sub_idx%>&sub_flag=<%=sub_flag%>", "open_view" , "width=630,height=700,scrollbars=yes");
	}

//-->
</script> 
 
 
<%@ include file="/vodman/subject/subject_left.jsp"%> 

		<!-- ������ -->
		<div id="contents">
			<h3><span>����</span> ���</h3>
			<p class="location">������������ &gt; ���� ���� &gt; <span>���� ���� </span></p>
			<div id="content">
 
				<br/>
				<p class="to_page">Total<b>�� <%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%>��</b></p>
				<form name="subject" method="post">
					<input type='hidden' name='sub_idx' value='<%=sub_idx%>'>
					<table  cellspacing="0" class="board_list" summary="���� ���� ���">
					<colgroup>
					<col width="6%"/>
					<col/>
		 			<col width="10%"/>
				 
				</colgroup>
				
				
				<thead>
				<tr bgcolor="#dbe2ed">
					<td  colspan="2">&nbsp;&nbsp;��&nbsp;<%=sub_title%></td><td><a href='frm_subject_count.jsp?sub_idx=<%=sub_idx%>&sub_flag=<%=sub_flag%>'>[���Ȯ��]</a>&nbsp;<% if (sub_flag != null && sub_flag.equals("E")) { %><a href='frm_subject_event.jsp?sub_idx=<%=sub_idx%>&sub_flag=<%=sub_flag%>'> [��÷��] </a><%	} %></td>
					<td></td>
				</tr>
					<tr>
						<th>��ȣ 	</th>
					 
						<th>���� ����</th>
						 
						<th>����</th>
					</tr>
				</thead>
				 
						  <%
                              SubjectInfoBean Sin = new SubjectInfoBean();
							int count =1;
							String sub_link = "";
                            int list = 0;
							if ( vt != null && vt.size() > 0){

							for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
                                com.yundara.beans.BeanUtils.fill(Sin, (Hashtable)vt.elementAt(list));
						
								%>	
													
								<tr class="height_25 font_127">
									<td class="bor_bottom01"><%=Sin.getQuestion_num()%></td>
									<td class="bor_bottom01">
									<a href="javascript:ansUpdate(<%=Sin.getSub_idx()%>,<%=Sin.getQuestion_idx()%>);"><%=Sin.getQuestion_content() %></a>
									</td>
									
									<td class="bor_bottom01">
									<a href="javascript:sub_question_update(<%=Sin.getSub_idx()%>,<%=Sin.getQuestion_idx() %>);">
									<img src="/vodman/include/images/but_edit.gif" border="0"></a>
									<a href="javascript:sub_question_delete(<%=Sin.getSub_idx()%>,<%=Sin.getQuestion_idx() %>);">
									<img src="/vodman/include/images/but_del.gif" border="0"></a>
									</td>
								</tr>
 
													
								<%
										}
									}else {
								 %>					
									<tr>
										<td colspan="3" class="bor_bottom01">�Էµ� ������ �����ϴ�.</td>
									</tr>
													
								<% } %>	
						<tr>
						 
							<td class="bor_bottom01" colspan=3>
							 <%
								String jspName = "frm_subjectQuestionList.jsp"; 
								if(vt != null && vt.size() > 0 && pageBean!= null){ 
							  %>
							  <%@ include file="page_link.jsp" %>
							  <%	}	%>
							</td>
						</tr>

						<tr>
							<td colspan=3 align=center>
                               <a href="javascript:open_view();">
								<img src="/vodman/include/images/but_view2.gif" border="0">
								</a>
								&nbsp;&nbsp;
								<a href="javascript:questionAdd(<%=sub_idx%>);">
								<img src="/vodman/include/images/but_addi2.gif" border="0">
								</a>
							<td>
						</tr>
					</table>
					</form>
				</div>
				
				<br/><br/>
			</div>
		 
		
<%@ include file="/vodman/include/footer.jsp"%>