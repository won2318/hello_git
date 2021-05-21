<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.yundara.util.*, com.vodcaster.sqlbean.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "p_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author ����
	 *
	 * @description : ���� ��� ����.
	 * date : 2009-10-19
	 */

	 int pg = 0;
  

    if(request.getParameter("page")==null || request.getParameter("page").length()<=0 || request.getParameter("page").equals("null")){
        pg = 1;
    }else{
    	try{
        pg = Integer.parseInt(request.getParameter("page"));
    	}catch(Exception ex){
    		pg =1;
    	}
    }

	String searchField = "";		//�˻� �ʵ� 
	String searchString = "";		//�˻���
	 
	String order = "seq";		//���ı��� �ʵ� owdate
	String direction = "desc";		//���� ���� asc, desc
	String event_type = ""; 			//�̵�� Ÿ�� V, P, A

	int listCnt = 10;				//������ ��� ���� 

	
	if(request.getParameter("searchField") != null)
		searchField = request.getParameter("searchField");

	if(request.getParameter("searchString") != null)
	//	searchString = request.getParameter("searchString");
		searchString = CharacterSet.toKorean(request.getParameter("searchString")); 
	

    EventManager mgr = EventManager.getInstance();
    Hashtable result_ht = null;
    result_ht = mgr.getEventList( searchField, searchString, event_type, pg, listCnt);

	int iTotalRecord = 0;
	int iTotalPage = 1;
    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(pg);
	        	iTotalRecord = pageBean.getTotalRecord();
	        	iTotalPage = pageBean.getTotalPage();
	        }
		}
    }

 
	String strLink = "";
    strLink += "&searchField=" +searchField+ "&searchString=" +searchString;
    
%>
<%@ include file="/vodman/include/top.jsp"%>
 
 

<%@ include file="/vodman/event/event_left.jsp"%>

		<!-- ������ -->
		<div id="contents">
			<h3><span>�̺�Ʈ</span> ���</h3>
			<p class="location">������������ &gt; �̺�Ʈ ���� &gt; <span>�̺�Ʈ ���</span></p>
			<div id="content">
			 <form name="frmMedia" method="post" action="mng_eventList.jsp">
			 
			 <input type="hidden" id="seq" name="seq" value="" />
			  
				<table cellspacing="0" class="log_list" summary="�̺�Ʈ ���">
				<caption>�̺�Ʈ ���</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
 					<tr>
						<th class="bor_bottom01"><strong>�˻�</strong></th>
						<td class="bor_bottom01 pa_left"><select name="searchField" class="sec01" style="width:80px;">
								<option value="title" selected="selected" <%=(searchField.equals("title"))?"selected":""%>>����</option>
								<option value="content" <%=(searchField.equals("content"))?"selected":""%>>����</option>
								<option value="all" <%=(searchField.equals("all"))?"selected":""%>>��ü</option>

							</select><input type="text" name="searchString" value="<%=searchString%>" class="input01" style="width:150px;"/>
						<a href="javascript:document.frmMedia.submit();" title="�˻�"><img src="/vodman/include/images/but_search.gif" alt="�˻�"/></a>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
				<br/>
				<p class="to_page">Total<b><%=iTotalRecord%></b>Page<b><%=pg %>/<%=iTotalPage%></b></p>
				<table cellspacing="0" class="board_list" summary="�̺�Ʈ ���">
				<caption>�̺�Ʈ ���</caption>
				<colgroup>
					<col width="6%"/>
					<col/>
					<col width="10%"/>
					<col width="10%"/>
					 
					<col width="20%"/>
					<col width="6%"/>
				</colgroup>
				<thead>
					<tr>
						<th>��ȣ</th>
						<th>����</th>
						<th>��÷��</th>
						<th>��������</th>
						<th>�̺�Ʈ ����</th>
						<th>����</th>
					</tr>
				</thead>
				<tbody>

				<%
				EventInfoBean einfo = new EventInfoBean();
				 
				String sub_link = "";
				int list = 0;
				if ( vt != null && vt.size() > 0){

					for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
						com.yundara.beans.BeanUtils.fill(einfo, (Hashtable)vt.elementAt(list));
						String imageURL = "/vodman/include/images/no_img02.gif";
						if(einfo.getEvent_img() != null && einfo.getEvent_img().length() > 0 && einfo.getEvent_img().indexOf(".") > -1) {
							imageURL = "/upload/event/small/" + einfo.getEvent_img();
						}
 						 
						File file = new File(DirectoryNameManager.VODROOT + imageURL);
						if(!file.exists()) {
							imageURL = "/vodman/include/images/no_img02.gif";
						}
	
					 
						String content =einfo.getContent();
						if (content!= null && content.length() > 30) {
							content = content.substring(0,28)+"..";
						
						}
						String goView = "<a href='frm_event_SubUpdate.jsp?mcode=" +mcode+ "&page=" +pg+ "&seq=" + einfo.getSeq()+strLink+ "'>"+String.valueOf(einfo.getTitle())+"</a>";
				%>


					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01">
							<table cellspacing="0">
								<tr>
									<td rowspan="2"><a href='frm_event_SubUpdate.jsp?mcode=<%=mcode%>&page=<%=pg%>&seq=<%=einfo.getSeq()%><%=strLink%>'><img src="<%=imageURL%>" alt="�̹���" class="img_style07"/></a></td>
									<td class="main_list_cate" valign="middle"><%=einfo.getTitle()%></td>
								</tr>
								<tr>
									<td class="main_list_title" valign="top"><%=goView%></td>
								</tr>
							</table>
						</td>
						<td class="bor_bottom01"><%=einfo.getPubdate()%></td>
						  
						<td class="bor_bottom01"><%=(einfo.getOpen_flag().equals("Y") ? "����" : "�����")%></td>
						<td class="bor_bottom01"><% if (einfo.getEvent_type().equals("A")){ out.println("<a href='ucc_list.jsp?event_seq="+einfo.getSeq()+"'><img src='/vodman/include/images/btn_ucc.gif' alt='UCC'/></a> &nbsp; <a href='photo_list.jsp?event_seq="+einfo.getSeq()+"'><img src='/vodman/include/images/btn_photo.gif' alt='PHOTO'/></a>");} else if (einfo.getEvent_type().equals("U")){ out.println("<a href='ucc_list.jsp?event_seq="+einfo.getSeq()+"'><img src='/vodman/include/images/btn_ucc.gif' alt='UCC'/></a>");} else if (einfo.getEvent_type().equals("P")){ out.println("<a href='photo_list.jsp?event_seq="+einfo.getSeq()+"'><img src='/vodman/include/images/btn_photo.gif' alt='PHOTO'/></a>");} %></td>
						<td class="bor_bottom01"><a href="proc_event_delete.jsp?mcode=<%=mcode%>&seq=<%=einfo.getSeq()%>" title="����" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
					</tr>

					 <%
							}
						}else {
					 %>


					<tr class="height_25 font_127 back_f7">
						<td class="bor_bottom01" colspan="6">��ϵ� ������ �����ϴ�.</td>
					
					</tr>

					<%	}	%>
				</tbody>
			</table>
			<div class="paginate">
					 <%
						String jspName = "mng_eventList.jsp";
					 	strLink += "&mcode=" + mcode;
						if(vt != null && vt.size() > 0 && pageBean!= null){ 
					  %>
					  <%@ include file="page_link.jsp" %>
					  <%	}	%>
				</div>
				<br/><br/>
			</div>
		</div>	

<%@ include file="/vodman/include/footer.jsp"%>