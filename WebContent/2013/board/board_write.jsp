<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.yundara.util.*"%>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%> 
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ include file = "/include/chkLogin.jsp"%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>���� iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/close.js"></script>
	<script type="text/javascript" src="/include/js/script.js"></script>

</head>

<%
contact.setPage_cnn_cnt("W"); // ������ ���� ī��Ʈ ����
 
	 String ccode="";
		int board_id  = 2;
	try
	{
		if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
		{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
			 
		} 
	}catch(Exception e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	
	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	 //board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag,  
	 //board_user_flag, board_top_comments, board_footer_comments, board_priority, board_auth_list, 
	 //board_auth_read, board_auth_write, flag, view_comment, board_ccode , 
	 //board_security_flag 
	String board_title = "";
	String board_page_line = "";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	String flag = "";
	String board_security="";
	int board_auth_write = 0;
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
		flag = String.valueOf(v_bi.elementAt(12));
		board_security = String.valueOf(v_bi.elementAt(15));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));

	}
 
	String list_open = "Y";
	int event_seq = NumberUtils.toInt(request.getParameter("event_seq"), 0);
	 
 
	//�� ���� �������� ���������� üũ�ϴ� ���� ���� ����
// 	session.putValue("write_check", "1");
	
// 	//���� ���� ���ǿ� �����ϰ� ����ڰ� �Է��� Ȯ�� ���ڿ��� ���ǿ� ����� ���ڿ��� ������ üũ�Ѵ�.
// 	int iRandomNum = 0;
// 	java.util.Random r = new java.util.Random(); //���� ��ü ���� �� ����
// 	iRandomNum = r.nextInt(999)+10000;
// 	session.putValue("random_num", String.valueOf(iRandomNum));
 
	if (board_auth_write ==9) {
		// ������ �۾���
		if (vod_level != "9") {
		 	out.println("<script language='javascript'>\n" +
		              "alert('��� ������ �����ϴ�.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		 	return;
		}
	}else if (board_auth_write ==2) {
		if ( Integer.parseInt(vod_level) < board_auth_write){  // ����͸���
		 	out.println("<script language='javascript'>\n" +
		              "alert('��� ������ �����ϴ�.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		 	return;
		}
	} else if (board_auth_write == 1) {
		
		 if (!chk_login(vod_id, vod_level )) {  // �Ǹ�����
		   	out.println("<script language='javascript'>\n" +
		              "alert('�Ǹ����� �� �̿� �����մϴ�. ������������ �̵��մϴ�.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		return;
		}
		
		
	} else {
		// ��ȸ�� ���
		
	}
	
%>

<script language='javascript'>
 
function limitFile(object) {
		var file_flag = object.name;
		var file_name = object.value;
	
		document.getElementById('fileFrame').src = "file_check.jsp?file_flag="+file_flag+"&file_name=" + file_name;
	}

	
	function img_Load()
	{
	    var imgSrc, imgFileSize;
	    var maxFileSize;


		var img = new Image();
		img.src = document.frmBoard.list_data_file.value;
		imgFileSize =img.fileSize;

	    maxFileSize = 1048576;

	    if (imgFileSize > maxFileSize)
	    {
	        alert('�����Ͻ� ������ ��� �ִ�ũ���� ' + maxFileSize/1024 + ' KB �� �ʰ��Ͽ����ϴ�.');
			document.frmBoard.list_data_file.outerHTML = document.frmBoard.list_data_file.outerHTML;
	        return;
	    }

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
	var splitFilter = new Array(<%=totalPage%>);
	<%
	}else{%>
	var splitFilter = new Array("����","����","�ֳ�","�ֳ�","����","����","������","�Ϲ̷�","��������","��������","�ϱ��","����","����","�ʻ���","script");
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
		for (var ii = 0 ;ii < splitFilter.length ; ii++ )
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
		
		var f = document.frmBoard;

	  
		
		if (f.list_title.value=="") {
		   alert ("������ �Է����� �����̽��ϴ�.");
		   f.list_title.focus();
		   return
		}
		if(!CheckText(f.list_title)){
			return;
		}
		if(filterIng(f.list_title.value, f.list_title,"list_title") == false){
			return;
		}
		if (f.list_name.value=="") {
			   alert ("�ۼ��ڸ� �Է����� �����̽��ϴ�.");
			   f.list_name.focus();
			   return
			}
		
		if (f.list_contents.value=="") {
		   alert ("������ �Է����� �����̽��ϴ�.");
		   f.list_contents.focus();
		   return
		}
		if(filterIng(f.list_contents.value, f.list_contents,"list_contents") == false){
			return;
		}
<% if (board_auth_write == 0) { %>
		if (f.list_passwd.value =="") {
			   alert ("��й�ȣ�� �Է��ϼ���.");
			   f.list_passwd.focus();
	    		   return;
		}else if(!pwCheck(f.list_passwd.value)){
				f.list_passwd.focus();
				alert("����+����+Ư�� ���ڸ� ��� �ϳ� �̻� ������ 8�� �̻�, 12�� �̳��� �Է��Ͻñ� �ٶ��ϴ�.");
				return;
		}
<%} %>
// 		var chk_word2 = "";
// 		chk_word2 = document.getElementById("chk_word2");
		
// 		if(chk_word2.value == ""){
// 			alert('Ȯ�� ���ڿ��� �Է��Ͻʽÿ�.');
// 			f.chk_word.focus();
// 			return;
// 		}

		f.action="proc_boardListAdd.jsp?board_id=<%=board_id%>&searchField=<%=request.getParameter("searchField")%>&searchString=<%=request.getParameter("searchString")%>";
		f.submit();

	}

	function CheckText(str) {
		strarr = new Array(str.value.length);
		schar = new Array("'");

		for (i=0; i<str.value.length; i++)
		{
			for (j=0; j<schar.length; j++)
			{
				if (schar[j] ==str.value.charAt(i))
				{
					alert("(')Ư�����ڴ� �Ұ����մϴ�");
					str.focus();
					return false;
				}
				else
					continue;
			}

		}
		return true;
	}

function chk_word_func(){
 		document.getElementById("chk_word2").value = document.getElementById("chk_word").value;
	}

</script>
<noscript>
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 
</noscript>

<body>

<div id="pWrap">
	<!-- container::���������� -->
	<div id="pLogo">
		<h2><a href="javascript:go_home();"><img src="../include/images/view_logo.gif" alt="���� iTV Ȩ������ �ٷΰ���"/></a></h2>
			<span class="close"><a href="javascript:this_close();"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> 
		</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle">�۵��</h3>
			<div class="boardWrite">
			<form name='frmBoard' method='post' enctype='multipart/form-data'>
				 
				<input type="hidden" name="board_id" value='<%=board_id%>' />
				<input type="hidden" name="list_open" value='<%=list_open%>' />
			 	<input type="hidden" name="event_seq" value='<%=event_seq%>' />
			 	
				<input type="hidden" name="user_key" id="user_key" value="" /><!-- �Ǹ����� Ű�� -->
				<dl>
					<dt><label for="list_title">����</label></dt>
					<dd><input type="text" name="list_title" value="" id="list_title" size="72" title="����"/></dd>
				</dl>
				<dl>
					<dt><label for="list_name">�ۼ���</label></dt>
					<dd><input type="text" name="list_name" value="<%=vod_name %>" id="list_name" size="72" title="�ۼ���"/></dd>
				</dl>
				<%if (board_id == 11 || board_id == 13  ) { %>
					<dl>
						<dt><label for="user_address">�ּ�</label></dt>
						<dd><input type="text" name="user_address" value="" id="user_address" size="45" title="�ּ�"/></dd>
					</dl>
					<dl>
						<dt><label for="user_tel">����ó</label></dt>
						<dd><input type="text" name="user_tel" value="" id="user_tel" size="45" title="����ó"/></dd>
					</dl>
  
				<%}%> 
<!-- 				<dl> -->
<!-- 					<dt><label for="zip1">�ּ�</label></dt> -->
<!-- 					<dd> -->
<!-- 						<p class="zip"> -->
<!-- 							<input type="text" name="zip" value="" id="zip" size="7" maxlength="7" title="�����ȣ "/>  -->
<!-- 							<a style='cursor:hand' onClick="javascript:find_zip();"><img src="../include/images/btn_zip.gif" alt="�ּ�ã��"></a> -->
<!-- 							<input type="text" name="address1" value="" id="address1" size="72" title="�����ּ�"/> -->
<!-- 							<input type="text" name="address2" value="" id="address2" size="72" title="���ּ�"/> -->
<!-- 						</p> -->
<!-- 					</dd> -->
<!-- 				</dl> -->
				 <%if(board_security != null && board_security.equals("t")){ %>
					<dl>
						<dt><label for="list_security">��б�</label></dt>
						<dd><input type="checkbox" name="list_security" value="Y" title="��б�"/> * ��б� �ۼ��� �����ڸ� Ȯ���� �����մϴ�!</dd>
					</dl>
					<%} %>
					
					<%if(board_link_flag.equals("t")){%>
				<dl>
					<dt><label for="list_link">�ּҸ�ũ</label></dt>
					<dd><input type="text" name="list_link" id="list_link" maxlength="200" value="" class="input01" style="width:300px;" onkeyup="checkLength(this,200)"/></dd>
				</dl>
				<% } %>
				
				<dl>
					<dt><label for="list_contents" class="subject">����</label></dt>
					<dd><textarea name="list_contents" cols="70" rows="20" id="list_contents" title="����">
					<%
					//�ùθ���͸��� �Խ��Ǹ� �⺻���� ����
					if (board_id == 22 ) { %>
1. �̸� : 
2. ���� : ���� / ���
3. �ش翵��(���) ���� :
4. �ش翵��(���) ����� :
5. �ش翵��(���) �ۼ��� :
6. ����� ���� :


7. �ǰ� ä�ý� �μ�Ƽ�� ��� : �ڿ�����ð� ���� / ����� ���� �� ��1

					<%}%>
					</textarea>
					<%
					//�ùθ���͸��� �Խ��Ǹ� �⺻���� ����
					if (board_id == 22 ) { %>
					
					<P>&nbsp;</P>
					<div style="display:block; padding-top:5px; float: left; width:100%;">
���ڿ����� ��������
<TABLE style="WIDTH: 445px; HEIGHT: 94px" border=1 cellSpacing=0 cellPadding=0>
<TBODY>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 153px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" colSpan=2>
<P align=center >&nbsp;����</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 81px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;��������</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 64px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>1�� ���� </P></TD>
<TD valign="middle"  style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 64px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>1�� ����</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #f1e2ea; WIDTH: 125px; HEIGHT: 18px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P style="TEXT-ALIGN: center" align=center>&nbsp;���</P></TD></TR>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 71px; HEIGHT: 47px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=2>
<P align=center>&nbsp;����͸�</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;���� �� ����</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;1�Ǵ� 10��</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 64px; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=3>
<P align=center>&nbsp;2�ð�</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 64px; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=3>
<P align=center>&nbsp;20�ð�</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 125px; HEIGHT: 72px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" rowSpan=3>
<P style="TEXT-ALIGN: center" align=center>&nbsp;ä�� �� �ǿ� ����<BR>(����� ���ް� ����)</P></TD></TR>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;�ǰ� �� ����</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 23px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P align=center>&nbsp;1�Ǵ� 30��</P></TD></TR>
<TR>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 153px; HEIGHT: 24px; BORDER-TOP: 0px; BORDER-RIGHT: 0px" colSpan=2>
<P align=center>&nbsp;����(����) �� ���̵��</P></TD>
<TD valign="middle" style="BORDER-LEFT: #cccccc 1px solid; BACKGROUND-COLOR: #ffffff; WIDTH: 81px; HEIGHT: 24px; BORDER-TOP: 0px; BORDER-RIGHT: 0px">
<P style="TEXT-ALIGN: center" align=center>&nbsp;1�Ǵ� 1�ð�</P></TD></TR></TBODY></TABLE>
<P>&nbsp;</P>
<P>�� ����� ����<BR>&nbsp;- ����(����)�����̵�� �� ä�ý� �Ǵ� 10,000�� / �� �ִ� 50,000��(5��)<BR></P></div>
					<%}%>
</dd>
				</dl>
				<%if(board_file_flag.equals("t")){%>
				<dl>
					<dt><label for="list_data_file">÷��</label></dt>
					<dd><input type="file" id="list_data_file" name="list_data_file" size="58" value="" title="÷������"/></dd>
					<p style="padding-top:10px; clear: both;font-size: 11px; text-align: center; letter-spacing: -1px; font-weight: bold;">÷�ο뷮�� �ִ� <span style="color: #ef4a4a;">100MB</span> �̸� �����ư�� ������ �� <span style="color: #ef4a4a;">��ϿϷ�</span> �ȳ��� ���� �ñ��� ��ٷ��ֽñ� �ٶ��ϴ�.</p>
				</dl>
				 <%} %>
				 <%if(board_image_flag.equals("t")){%>
				 <dl>
					<dt><label for="list_image_file">�̹���1</label></dt>
					<dd><input type="file" id="list_image_file" name="list_image_file" size="58" value="" title="÷������"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text">����</label></dt>
					<dd><textarea name="image_text" id="image_text"  cols="70" rows="2"></textarea></dd>
				</dl>
				<dl>
					<dt><label for="list_image_file2">�̹���2</label></dt>
					<dd><input type="file" id="list_image_file2" name="list_image_file2" size="58" value="" title="÷������"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text2">����</label></dt>
					<dd><textarea name="image_text2" id="image_text2" cols="70" rows="2"></textarea></dd>
				</dl>
				<dl>
					<dt><label for="list_image_file3">�̹���3</label></dt>
					<dd><input type="file" id="list_image_file3" name="list_image_file3" size="58" value="" title="÷������"/></dd>
				</dl>
				<dl>
					<dt><label for="image_text3">����</label></dt>
					<dd><textarea name="image_text3" id="image_text3" cols="70" rows="2"></textarea></dd>
				</dl>
				<%} %>

				<% if (board_auth_write == 0) { %>
				<dl>
					<dt><label for="list_passwd">��й�ȣ</label></dt>
					<dd><input type="password" name="list_passwd" value="" id="list_passwd" size="12" title="��й�ȣ"/>*����,����,Ư������ ���� 8�̻� 12�ڸ�����</dd>
				</dl>
				<%} %>
				</form>
			</div>
			
			<div class="btn3">
				<a href="javascript:insertListBoard();"><img src="../include/images/btn_save.gif" alt="����"></a>
				<a href="javascript:parent.$.colorbox.close();"><img src="../include/images/btn_cancel.gif" alt="���"></a>
			</div>

		</div>

		<div class="pAside">
			 <%@ include file = "../include/sub_topic.jsp"%>
		</div> 
	</div> 
</div> 
</body>
</html>