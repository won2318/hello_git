<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	/**
	 * @author Jong-Hyun Ho
	 *
	 * @description : �Խù����� ������ ����ϴ� ������
	 * date : 2005-01-04
	 */

%>
<%
if(!chk_auth(vod_id, vod_level, "b_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>

<%
	String field = request.getParameter("field").replaceAll("<","").replaceAll(">","");
	String searchstring = request.getParameter("searchstring").replaceAll("<","").replaceAll(">","");
	String pg = request.getParameter("page").replaceAll("<","").replaceAll(">","");
	
	
	int board_id  = -1;
	int list_id  = -1;
	
	
	if(request.getParameter("board_id")  != null && request.getParameter("board_id") .length()>0 && !request.getParameter("board_id") .equals("null")
		&& request.getParameter("list_id")  != null && request.getParameter("list_id") .length()>0 && !request.getParameter("list_id") .equals("null")){
		try{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
		}catch(Exception ex){
			String mcode= request.getParameter("mcode");
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('�� ���� ��û�Դϴ�. �Խ��� ���� �������� �̵��մϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardList.jsp?mcode="+mcode ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}
		
		try{
			list_id  = Integer.parseInt(request.getParameter("list_id") );
		}catch(Exception ex){
			String mcode= request.getParameter("mcode");
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardListList.jsp?board_id="+board_id+"&field="+field+"&searchstring="+searchstring+"&page="+pg+"&mcode="+mcode ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}
	}else{
		String mcode= request.getParameter("mcode");
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardList.jsp?mcode="+mcode ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
	}
	
	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	//board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag, board_user_flag, board_top_comments, board_footer_comments, board_priority
	String board_title = "";
	String board_page_line = "";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	String board_security = "";
	String view_comment = "";
	if(v_bi != null && v_bi.size() >0){
		board_title = String.valueOf(v_bi.elementAt(0));
		board_page_line = String.valueOf(v_bi.elementAt(1));
		board_image_flag = String.valueOf(v_bi.elementAt(2));
		board_file_flag = String.valueOf(v_bi.elementAt(3));
		board_link_flag = String.valueOf(v_bi.elementAt(4));
		board_user_flag = String.valueOf(v_bi.elementAt(5));
		board_top_comments = String.valueOf(v_bi.elementAt(6));
		board_footer_comments = String.valueOf(v_bi.elementAt(7));
		board_priority = String.valueOf(v_bi.elementAt(8));
		board_security = String.valueOf(v_bi.elementAt(15));
		view_comment = String.valueOf(v_bi.elementAt(13));
	}else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode= request.getParameter("mcode");
		String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script language="javascript" src="/vodman/include/js/script.js"></script>
<script type="text/javascript" src="/vodman/editer/js/HuskyEZCreator.js" charset="utf-8"></script>
<script language='javascript'>

	function limitFile(object) {
		var file_flag = object.name;
		var file_name = object.value;
	
		document.getElementById('fileFrame').src = "file_check.jsp?file_flag="+file_flag+"&file_name=" + file_name;
	}
	
	function clearFile(file_flag) {
		document.getElementById(file_flag).outerHTML = document.getElementById(file_flag).outerHTML;
	}


	<%
	FucksInfoManager mgr = FucksInfoManager.getInstance();
	Hashtable result_ht = null;
	result_ht = mgr.getAllFucks_admin("");
	Vector vt = null;
	com.yundara.util.PageBean pageBean = null;
	int totalArticle =0; //�� ���ڵ� ����
	int totalPage = 0 ; //
	if(!result_ht.isEmpty() ) {
	    vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(1);
				totalArticle = pageBean.getTotalRecord();
		        totalPage = pageBean.getTotalPage();
	        }
		}
	}
	%>
	var rgExp;
	<%
	if(totalPage >0 ){
	%>
	var splitFilter = new Array("script",<%=totalPage%>);
	<%
	}else{%>
	var splitFilter = new Array("����","����","�ֳ�","�ֳ�","����","����","������","�Ϲ̷�","��������","��������","�ϱ��","����","����","�ʻ���","script" );
	<%
	}
	%>
	<%
	if(vt != null && vt.size()>0){
		int list = 0;
		FuckInfoBean linfo = new FuckInfoBean();
		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
			  com.yundara.beans.BeanUtils.fill(linfo, (Hashtable)vt.elementAt(list));
			  %>
			  splitFilter[<%=i%>] = '<%=linfo.getFucks()%>';
			  <%
		}
	}
	%>
	function filterIng(str , element , id){  
		for (var ii = 0 ;ii < splitFilter.length; ii++ )
		{
			rgExp = splitFilter[ii];
			if (str.match(rgExp))
			{
				alert(rgExp + "��(��) �ҷ��ܾ�� �Է��ϽǼ� �����ϴ�");
				var range = document.getElementsByName(id)[0].createTextRange();
				range.findText(rgExp);
				range.select();
				return false;
			}
		}
	}
	
	function insertListBoard(){
		var f = document.insertForm;

		if (f.list_name.value=="") {
		   alert ("�̸��� �Է����� �����̽��ϴ�.")
		   f.list_name.focus();
		   return
		}
		if (f.list_title.value=="") {
		   alert ("������ �Է����� �����̽��ϴ�.")
		   f.list_title.focus();
		   return
		}
		//oEditors.getById["list_contents"].exec("UPDATE_IR_FIELD", []);
		oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);
		
		// �������� ���뿡 ���� �� ������ �̰����� document.getElementById("list_contents").value�� �̿��ؼ� ó���ϸ� �˴ϴ�.
		if (f.list_contents.value=="") {
		   alert ("������ �Է����� �����̽��ϴ�.")
		   f.list_contents.focus();
		   return
		}
// 		if(filterIng(f.list_contents.value, f.list_contents,"list_contents") == false){
// 			return;
// 		}
		if (f.list_passwd.value=="") {
		   alert ("��й�ȣ�� �Է����� �����̽��ϴ�.")
		   f.list_passwd.focus();
		   return
		}

		if (f.list_passwd.value.length < 4 || f.list_passwd.value.length > 12) {
		   alert ("��й�ȣ�� 4�� �̻� 12�� ���Ϸ� �Է��Ͽ��ּ���.")
		   f.list_passwd.focus();
		   return
		}


		f.action='proc_boardListReplayAdd.jsp?board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>';
		f.submit();

	}


	function isNumber ()
	{
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert("���ڸ� �����մϴ� �ٽ� �Է��ϼ���!");
			event.returnValue=false;
		}
	}

	function addImage(num){
		var addnum = num+1;
		document.getElementById("imageList_"+addnum).style.display = "";
		if(num == 1) {
			document.getElementById("imageBtn").style.visibility = "hidden";
		} else {
			document.getElementById("imageBtn"+num).style.visibility = "hidden";
		}
	}

	function dropImage(objName, num){
		document.getElementById('list_image_file'+num).outerHTML = document.getElementById('list_image_file'+num).outerHTML;;
		document.getElementById('image_text'+num).text = "";
		document.getElementById(objName).style.display = "none";

		num = num -1;
		if(num == 1) {
			document.getElementById("imageBtn").style.visibility = "visible";
		} else {
			document.getElementById("imageBtn"+num).style.visibility = "visible";
		}
	}

</script>

		<!-- ������ -->
		<div id="contents">
			<h3><span>����</span>����</h3>
			<p class="location">������������ &gt; �Խ��ǰ��� &gt; �Խ��� ���� &gt; <span><%=board_title%></span></p>
			<div id="content">
				<!-- ���� -->
				<table cellspacing="0" class="board_view" summary="�Խù� ����">
				<caption><%=board_title%> ����</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				 <form name='insertForm' method='post' enctype='multipart/form-data'>
                                        <input type=hidden name="board_id" value='<%=board_id%>'>
                                        <input type=hidden name="list_id" value='<%=list_id%>'>
				<tbody class="font_127">
					<tr>
						<th class="bor_bottom01"><strong>�ۼ���</strong></th>
						<td class="bor_bottom01 pa_left"><%=vod_name%><input type="hidden" name="list_name" class="input01" style="width:150px;" value="<%=vod_name%>" readonly /></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="list_title" value="" maxlength="30" class="input01" style="width:300px;"/></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�̸����ּ�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="list_email" value="" maxlength="50" class="input01" style="width:300px;ime-mode:disabled;"/></td>
					</tr>
					<%
				if(board_security != null && board_security.equals("t")){
				%>
					<tr>
						<th class="bor_bottom01"><strong>��б�</strong></th>
						<td class="bor_bottom01 pa_left">
						<select name="list_security" class="sec01" style="width:80px;" >
								<option value="">��б� ����</option>
								<option value="Y" >- ��б�</option>
								<option value="N" selected>- ������</option>
						</select></td>
					</tr>
				 
				<%}else{ %>
				<input type="hidden" name="list_security" value='N' >
				<%} %>

					<%if(board_link_flag.equals("t")){%>
					<tr>
						<th class="bor_bottom01"><strong>�ּҸ�ũ</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="list_link" value="" maxlength="100" class="input01" style="width:300px;"/></td>
					</tr>
					<% } %>
			<%if(board_id == 22){%>
				<tr>
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left">
						 <input type="radio" name="image_text8" id="image_text81" value="V" checked="checked"/><label for="image_text81">����(����iTV)</label>
					&nbsp;&nbsp;<input type="radio" name="image_text8"  id="image_text82" value="N" /><label for="image_text82">���(e��������)</label>
					
					</td>
				</tr>
	 
				<%} %>
				
					<tr>
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left">
							<input name="list_html_use" type="hidden" value="t" />
							<input name="open_space" type="checkbox" id="open_space" value="Y"/>&nbsp;�������� ��Ͻ� üũ�ϼ���! <br/>
							<textarea name="list_contents" id="list_contents" class="input01" style="width:600px;height:220px;" cols="100" rows="100"></textarea>
	<script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "list_contents",
		    sSkinURI: "/vodman/editer/SmartEditor2Skin.html",
		    fCreator: "createSEditor2"
		});
 
		function insertIMG(qnacontent,filename){ 
	        var sHTML = "<img src=/vodman/editer/popup/upload/"+filename+">"; 
	        oEditors.getById["list_contents"].exec("PASTE_HTML", [sHTML]); 
		} 
	</script>	</td>
					</tr>
					<%if(board_file_flag.equals("t")){
							%>
						<tr >
						  <th class="bor_bottom01"><strong>÷������</strong></th>
						  <td class="bor_bottom01 pa_left"> <input name="list_data_file" type="file" class="input03" size="30" value=""  onchange="javascript:limitFile(this)"></td>
						</tr>
						<%
						}%>

<%
	if(board_image_flag.equals("t")){
		for(int i=1; i <=5; i++) {
			if(i == 1) {
%>
					<tr id="imageList" style="display:">
						<th class="bor_bottom01"><strong>�̹�������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="file" name="list_image_file" class="input03" size="30" value="" onchange="javascript:limitFile(this)"/>&nbsp;&nbsp;&nbsp;</br>
						<textarea name="image_text" class="input02" style="width:570px;height:30px;" cols="100" rows="100"></textarea>
						<span id="imageBtn"><a href="javascript:addImage(1);" title="�߰�"><img src="/vodman/include/images/but_plus.gif" alt="�߰�" class="pa_bottom"/></a></span>
						</td>
					</tr>
<%
			} else {
%>
					<tr id="imageList_<%=i%>" style="display:none">
						<th class="bor_bottom01"><strong>�̹�������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="file" name="list_image_file<%=i%>" class="input03" size="30" value="" onchange="javascript:limitFile(this)"/>&nbsp;&nbsp;&nbsp;<br/>
						<textarea name="image_text<%=i%>" class="input02" style="width:570px;height:30px;" cols="100" rows="100"></textarea>
						<%if(i < 10) {%><span id="imageBtn<%=i%>"><a href="javascript:addImage(<%=i%>);" title="�߰�"><img src="/vodman/include/images/but_plus.gif" alt="�߰�" class="pa_bottom"/></a></span><%}%>
						<a href="javascript:dropImage('imageList_<%=i%>',<%=i%>);" title="����"><img src="/vodman/include/images/but_del.gif" alt="����" class="pa_bottom"/></a>
						</td>
					</tr>
<%
			}
		}
	}
%>

					<tr>
						<th class="bor_bottom01"><strong>��й�ȣ</strong></th>
						<td class="bor_bottom01 pa_left"><input type="password" name="list_passwd" maxlength="12" value="" class="input01" style="width:150px;"/></td>
					</tr>
				</tbody>
				</form>
				</table>
				<div class="but01">
				<a href="mng_boardListList.jsp?board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>" title="���"><img src="/vodman/include/images/but_list.gif" alt="���"/></a>
					<a href="javascript:insertListBoard();" title="����"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
					<a href="javascript:history.go(-1);" title="���"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>	

<IFRAME name="hiddenFrame" src="#" height="0" width="0" frameborder="0"></IFRAME>
<iframe id="fileFrame" name="fileFrame" src="#" width="0" height="0" cellpadding="0" cellspacing="0" border="0"></iframe>

<%@ include file="/vodman/include/footer.jsp"%>
