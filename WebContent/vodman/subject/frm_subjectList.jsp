<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	request.setCharacterEncoding("euc-kr");
 %>
 
 <%@ include file="/vodman/include/top.jsp"%>
 
 <script language="JavaScript" type="text/JavaScript">
<!--
 
	function sub_question(){
		var f = document.subjectList;
		 
		f.action = "/vodman/subject/frm_subjectAdd.jsp";
		f.submit();
	}

	function sub_question_update(sub_idx){
		var f = document.subjectList;
		f.action = "/vodman/subject/frm_subjectUpdate.jsp?sub_idx="+sub_idx+"";
		f.submit();

	}

	function sub_question_delete(sub_idx){
		var f = document.subjectList;
		if(confirm("삭제하시겠습니까?")) {
            f.action = "/vodman/subject/proc_subjectDelete.jsp?sub_idx="+sub_idx+"";
			f.submit();
        }
		
	}

//-->
</script> 

<%

int pg = 0;

if(request.getParameter("page")==null){
    pg = 1;
}else{
	try{
    pg = Integer.parseInt(request.getParameter("page"));
    }catch(Exception ex){
    	out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
    }
}

int listCnt = 15;				//페이지 목록 갯수 
 
SubjectManager mgr = SubjectManager.getInstance();
Hashtable result_ht = null;
Vector vt = null;
com.yundara.util.PageBean pageBean = null;
int iTotalCount = 0;
int iTotalPage = 0;
String sub_flag = "S";

if (request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length() > 0 && !request.getParameter("sub_flag").equals("null") ) {
	sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
}
try{
    result_ht = mgr.getSubjectList( pg,listCnt, sub_flag );

    
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(pg);
	        	iTotalCount = pageBean.getTotalRecord();
	        	iTotalPage = pageBean.getTotalPage();
	        }
		}
    }
}catch(Exception ex)
{
	out.println("오류가 발생 하였습니다. 관리자에게 문의 주세요");
}
 
String strLink = "&page=" +pg+ "&sub_flag="+sub_flag;
 
%>
<%@ include file="/vodman/subject/subject_left.jsp"%> 

		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>설문</span> 목록</h3>
			<p class="location">관리자페이지 &gt; 설문 관리 &gt; <span>설문 목록</span></p>
			<div id="content">
 
				<br/>
				<p class="to_page">Total<b>총 <%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%>건</b>Page<b><%=pg %>/<%=iTotalPage%></b></p>
				<form name="subjectList" method="post">
				<table cellspacing="0" class="board_list" summary="설문 목록">
				<caption>설문 목록</caption>
				<colgroup>
					<col width="6%"/>
					<col/>
					<col width="18%"/>
					<col width="10%"/>
					 
					<col width="10%"/>
				 
				</colgroup>
				<thead>
					<tr>
						<th>번호 	</th>
						<th>제목 	</th>
						<th>설문조사 일자</th>
						<th>설문인원</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
	<%
     SubjectInfoBean Sin = new SubjectInfoBean();
	int count =1;
	String sub_link = "";
    int list = 0;
	if ( vt != null && vt.size() > 0){
 
	for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
                                com.yundara.beans.BeanUtils.fill(Sin, (Hashtable)vt.elementAt(list));

		%>															
							
							<tr  class="height_25 font_127">
								<td class="bor_bottom01"><%=count++ %></td>
								<td class="bor_bottom01">
									<a href="/vodman/subject/frm_subjectQuestionList.jsp?sub_idx=<%=Sin.getSub_idx()%>&sub_flag=<%=Sin.getSub_flag() %>"><%=Sin.getSub_title() %></a>
								</td>
								<td class="bor_bottom01"><%=Sin.getSub_start().substring(0,10) %> ~ <%=Sin.getSub_end().substring(0,10) %></td>
								<td class="bor_bottom01"><%=Sin.getSub_person() %></td>
								<td class="bor_bottom01">
									<a href="javascript:sub_question_update(<%=Sin.getSub_idx() %>);">
									<img src="/vodman/include/images/but_edit.gif" border="0">
									</a> 
									<a href="javascript:sub_question_delete(<%=Sin.getSub_idx() %>);">
									<img src="/vodman/include/images/but_del.gif" border="0"></a> 
								</td>
							</tr>
 
		<%
				}
			}else {
		 %>
							<tr>
								<td colspan="5" class="bor_bottom01">입력된 내용이 없습니다.</td>
							</tr>
							
		<% } %>
							 
							<tr>
						 
							<td class="bor_bottom01" colspan=5>
							 <%
								String jspName = "frm_subjectList.jsp"; 
								if(vt != null && vt.size() > 0 && pageBean!= null){ 
							  %>
							  <%@ include file="page_link.jsp" %>
							  <%	}	%>
							</td>
						</tr>
							<tr>
								<td colspan="5" >
								<a href="frm_subjectAdd.jsp?sub_flag=<%=sub_flag%>"><img src="/vodman/include/images/but_addi2.gif" border="0"></a>
							    </td>
							</tr>
					</tbody>
					</table>
					</form>
 
				</div>
				
				<br/><br/>
			</div>
		 
		
<%@ include file="/vodman/include/footer.jsp"%>