<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.security.SEEDUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.yundara.util.CharacterSet" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<%
if(!chk_auth(vod_id, vod_level, "b_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}


%>

<%
	String paramOcode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
	paramOcode = StringUtils.defaultString(request.getParameter("ocode"),"");
	String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	if (flag == null || flag.length()<=0 || flag.equals("null")) {
		flag = "B";
	}
	int limit=10;
	int totalArticle =0; //�� ���ڵ� ����
	int totalPage = 0 ; //
	
	//�޸� �б�
	int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
	Hashtable memo_ht = new Hashtable();
	MemoManager memoMgr = MemoManager.getInstance();
	//if (paramOcode != null && paramOcode.length() > 0) {
	memo_ht = memoMgr.getMemoListLimitMan( paramOcode, mpg, limit, flag);
	//}
	
	Vector v_bl = (Vector)memo_ht.get("LIST");
	
	com.yundara.util.PageBean mPageBean = null;
	
	if(v_bl != null && v_bl.size()>0){
		mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
		if(mPageBean != null){
			mPageBean.setPagePerBlock(10);
	    	mPageBean.setPage(mpg);
	    	totalPage = mPageBean.getTotalPage();
	    	totalArticle = mPageBean.getTotalRecord();
		}
	}else{
		//������� ����.
		//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
	}
	String jspName="mng_boardListComment.jsp";
	
	int memo_size = 0;
	if (paramOcode != null && paramOcode.length() > 0) {
		memo_size = memoMgr.getMemoCount(paramOcode,flag);
	}

	
%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script src=../include/js/script.js></script>
<script language='javascript'>
	function searchI(){
		if (listForm.searchstring.value == ''){
			 alert("�˻�� �Է��ϼ���");
			 return;
		}
		else{
			listForm.action='mng_boardListComment.jsp';
			listForm.submit();
		}
		return
	}

	function sel_del() {

		if ( confirm('���� �����Ͻðڽ��ϱ�?') ) {
			if(document.listForm.v_chk.length) {  // ���� ���� ���
				var num = document.listForm.v_chk.length;
			    for(var i = 0; i < num; i++) {
			        if(document.listForm.v_chk[i].checked == true) {
			            document.listForm.action = "proc_boardCommentDelArray.jsp?mpage=<%=mpg%>&muid="+document.listForm.v_chk[i].value + "&mcode=<%=mcode%>&jaction=delete&flag=<%=flag%>";
						document.listForm.submit();
			            break;
					}
				}
			    if(i == num) {
					alert('�ϳ� �̻��� ����� �����ϼ���');
					return;
				}
			}else{
				if(document.listForm.v_chk.checked == true) {
		            document.listForm.action = "proc_boardCommentDel.jsp?mpage=<%=mpg%>&muid="+document.listForm.v_chk[i].value + "&mcode=<%=mcode%>&jaction=delete&flag=<%=flag%>";
					document.listForm.submit();
		           
				}else{
					alert(' ����� �����ϼ���');
					return;
				}
			}
		}
		
	}
		
	
	function checkInverse() {
		if (document.listForm.chkAll.checked){
			if(document.listForm.v_chk.length) 
			{  // ���� ���� ���
				for(i=0;i<document.listForm.v_chk.length;i++) {
					document.listForm.v_chk[i].checked = true;
				}
			}
			else
			{
				 document.listForm.v_chk.checked = true;
			}
		}else{
			if(document.listForm.v_chk.length) {  // ���� ���� ���
				for(i=0;i<document.listForm.v_chk.length;i++) {
					document.listForm.v_chk[i].checked = false;
				}
			}else{
				document.listForm.v_chk.checked = false;
			}
		}
	}	

</script>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�Խù� ��۰���</span></h3>
			<p class="location">������������ &gt; �Խ��ǰ��� &gt; �Խ��� ���� &gt; <span>�Խù� ���</span></p>
			<form name="listForm" method="post">
			<input type="hidden" name="mcode" value="<%=mcode%>">
			
			<div id="content">
				<!-- ���� -->
				
				<table cellspacing="0" class="border_search" summary="�Խ��� �˻�">
				<caption>�Խ��� �˻�</caption>
				<colgroup>
					<col width="50%"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<td><p class="to_page"><p class="to_page">Total<b><%=totalArticle%>�� <%=mpg %>/<%=totalPage%>Page</b></p></td>
						<td class="align_right">
							<select name="field" class="sec01" style="width:80px;">
													  <option value="1" selected>����</option>
													  <option value="2">����</option>
													  <option value="3">����+����</option>
													  <option value="4">�۾���</option>
													</select>
							<input type="text" name="searchstring" value="" class="input01" style="width:150px;"/>
							<a href="javascript:searchI();" title="�˻�"><img src="/vodman/include/images/but_search.gif" alt="�˻�" class="pa_bottom" /></a>
						</td>
					</tr>
				</tbody>
				</table>

				<table cellspacing="0" class="board_list" summary="�Խ��� ����">
				<caption>�Խ��� ����</caption>
				<colgroup>
				<col width="7%"/>
					<col width="7%"/>
					<col/>
					<col width="14%"/>
					<col width="9%"/>
					<col width="9%"/>
					
				</colgroup>
				<thead>
					<tr>
					<th><input type="checkbox" name="chkAll" onclick="javascript:checkInverse();"></th>
						<th>��ȣ</th>
						<th>����</th>
						<th>�۾���</th>
						<th>�ۼ���</th>
						<th>����</th>
					</tr>
				</thead>
				<tbody>
				 <!-- list start-->
                                        <%if(v_bl != null && v_bl.size() > 0){%>
                                        <%
											
		
		
											try
											{
												
												if(v_bl != null && v_bl.size() >0){
													String list_id ="";
													String list_title ="";
													String list_name ="";
													String ip="";
													String list_date ="";
													int list_count =0;
													String img_url = "";
													int re_level = 0;
													int list = 0;
													String ccode = "";
													int board_id = 0;
													MemoInfoBean binfo = new MemoInfoBean();
													for(int i = mPageBean.getStartRecord()-1; i < mPageBean.getEndRecord() && (list<v_bl.size()); i++, list++) {
														  com.yundara.beans.BeanUtils.fill(binfo, (Hashtable)v_bl.elementAt(list));
														  list_id = binfo.getOcode() ;
														  list_name =binfo.getWnick_name() ;
														  //list_name = SEEDUtil.getDecrypt(binfo.getWname());
														  list_title = StringUtils.replace(StringEscapeUtils.escapeHtml(binfo.getComment()), "\n", "<br>") ;					  
														  list_date = binfo.getWdate() ;
														  ccode = binfo.getCcode();
														  board_id = binfo.getBoard_id();
														  if(list_date != null && list_date.length()>10){
																list_date = list_date.substring(0,10);
															}
														 
														  ip = binfo.getIp();
													 

																			%>
					<tr class="height_25 font_127 bor_bottom01"  onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''">
					<td class="bor_bottom01"><input type="checkbox" name="v_chk" value="<%=binfo.getMuid()%>"/>&nbsp;</td>
						<td class="bor_bottom01"><%=mPageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01">
						<%
						if(flag != null && flag.equals("B")){
						%>
						<a href="/vodman/board/frm_boardListView.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>" title="�Խù� Ȯ��">
						<%}else if (flag != null && flag.equals("M")){ %>
						<a href="/vodman/vod_aod/frm_updateContent.jsp?ocode=<%=list_id%>&ccode=<%=ccode%>&mcode=0701" title="�Խù� Ȯ��">
						<%} %>
						<%=list_title%></a></td>
						<td class="bor_bottom01"><%=list_name%></td>
						<td class="bor_bottom01"><%=list_date%></td>
						<td class="bor_bottom01"><a href="proc_boardCommentDel.jsp?mpage=<%=mpg%>&muid=<%=binfo.getMuid()%>&mcode=<%=mcode%>&jaction=delete&flag=<%=flag%>" onClick="return confirm('���� �����Ͻðڽ��ϱ�?')" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
					</tr>
					 <%
												}
					%>
					 <tr  >
                           <td colspan="6" align="center"> <input type="button" onclick='javascript:sel_del();' value="���û���" /></td>
                  	</tr> 
					<%
											}
										  }catch(Exception e){
											  out.println("������ �߻� �Ͽ����ϴ�. �����ڿ��� ���� �ּ���");
										  
										  }
									%>
                                        <%}else{%>
                                        <tr class="height_25 font_127 bor_bottom01 back_f7">
                                          <td colspan="6" align="center">��ϵ� �Խù��̾����ϴ�.</td>
                                        </tr>
                                        <%}%>
										
				</tbody>
				</table>
				<div class="paginate">
				<%if(v_bl != null && v_bl.size() >0){ %>
				<%@ include file="page_link_memo2.jsp" %>
				<%} %>
				</div>
				
				
				<br/><br/>
			</div>
		</div>	
	 </form>


			<%@ include file="/vodman/include/footer.jsp"%>