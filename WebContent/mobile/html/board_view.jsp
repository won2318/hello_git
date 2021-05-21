<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.security.*" %>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
 
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>


<%@ include file = "../include/head.jsp"%>

<%
   request.setCharacterEncoding("EUC-KR");
	 
	String ccode="";
	int board_id = 10;
	if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
	{
		 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
 	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�.1')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	
	int list_id = 0;
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("list_id")))
	{
		list_id = Integer.parseInt(TextUtil.nvl(request.getParameter("list_id")));
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�.2')");

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

	String board_title = "";
	String board_page_line = "10";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	//String flag = "";
	String board_security_flag ="";
	String board_hidden_flag = "";
	String view_comment = "";
 //board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag,  
 //board_user_flag, board_top_comments, board_footer_comments, board_priority, board_auth_list, 
 //board_auth_read, board_auth_write, flag, view_comment, board_ccode , 
 //board_security_flag 
 	int board_auth_read = 0;
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
		//flag = String.valueOf(v_bi.elementAt(12));
	 
		view_comment = String.valueOf(v_bi.elementAt(13));
		board_security_flag = String.valueOf(v_bi.elementAt(15));
		board_auth_read = Integer.parseInt(String.valueOf(v_bi.elementAt(10)));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));
		board_hidden_flag= String.valueOf(v_bi.elementAt(16));
	}
 
 
	if (board_auth_read ==9) {
		// ������ �۾���
		if (vod_level != "9") {
		 	out.println("<script language='javascript'>\n" +
		              "alert('��� ������ �����ϴ�.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		}
	} else if (board_auth_read == 1) {
		// �Ǹ����� �����
		if(!chk_login(vod_id, vod_level )) {
		   	out.println("<script language='javascript'>\n" +
		              "alert('�Ǹ����� �� �̿� �����մϴ�. ������������ �̵��մϴ�.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		return;
		}
	} else if (vod_level != null && Integer.parseInt(vod_level) < board_auth_read) {
		 
	   	out.println("<script language='javascript'>\n" +
	              "alert('���� ������ �����ϴ�. ������������ �̵��մϴ�.');\n" +
	              "history.go(-1);\n" +
	              "</script>");
	 
	}else {
		// ��ȸ�� ���
		
	}
	
	
	String list_title = "";
	String list_contents = "";
	String list_name = "";
	String list_date = "";
	String list_link = "";
	String list_read_count="";
	 
	String list_image_file = "";
	String list_image_file2 = "";
	String list_image_file3 = "";
	String list_image_file4 = "";
	String list_image_file5 = "";
	String list_image_file6 = "";
	String list_image_file7 = "";
	String list_image_file8 = "";
	String list_image_file9 = "";
	String list_image_file10 = "";
	
	String image_text = "";
	String image_text2 = "";
	String image_text3 = "";
	String image_text4 = "";
	String image_text5 = "";
	String image_text6 = "";
	String image_text7 = "";
	String image_text8 = "";
	String image_text9 = "";
	String image_text10 = "";
	String list_data_file = "";
int re_level = 0;
	
	String list_pwd = "";
	String org_attach_name = "";
	String open_space = "";
	//String thumb = "/upload/board_list/img_middle/";
	String thumb = "/upload/board_list/";
	Vector vt_result = blsBean.getBoardList_view(list_id+"");
	if(vt_result != null && vt_result.size() > 0)
	{
		Hashtable ht_list = (Hashtable)vt_result.get(0);
		
		list_title = TextUtil.nvl(String.valueOf(ht_list.get("list_title")));
		list_contents = TextUtil.nvl(String.valueOf(ht_list.get("list_contents")));
		list_link = TextUtil.nvl(String.valueOf(ht_list.get("list_link")));
		list_name = TextUtil.nvl(String.valueOf(ht_list.get("list_name")));
		list_date = TextUtil.nvl(String.valueOf(ht_list.get("list_date")));
		open_space = TextUtil.nvl(String.valueOf(ht_list.get("open_space")));
		list_pwd = TextUtil.nvl(String.valueOf(ht_list.get("list_passwd")));
		String list_security = TextUtil.nvl(String.valueOf(ht_list.get("list_security")));
try{
			if (ht_list.get("list_re_level") != null ) {
				re_level = Integer.parseInt(String.valueOf(ht_list.get("list_re_level")));
			} 
		}catch(Exception ex){
		}

		if ((open_space != null && open_space.equals("Y")) ) {
			// ������
		}
		else if ( request.getParameter("pwd") != null  && request.getParameter("pwd").toString().equals(SEEDUtil.getDecrypt(list_pwd))  ) {
			// ������ ȸ�� ��й�ȣ Ȯ��
			} 
		else if (user_key != null && user_key.equals(list_pwd)) {  
			// ����ȸ�� ���� Ű Ȯ�� 
		} else {
			if(
					(list_security != null && list_security.equals("Y"))  
					|| (board_hidden_flag != null && board_hidden_flag.equals("t")) 
					//|| (board_security_flag != null && board_security_flag.equals("t")) 
			){
				//����� ���Դϴ�.
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
		
				out.println("alert('������ �ùٸ��� �ʽ��ϴ�. ')");
				out.println("history.go(-1)");
				out.println("</SCRIPT>");
				return;
			} 
		}
 
	
		list_data_file = TextUtil.nvl(String.valueOf(ht_list.get("list_data_file")));
		try{
			list_date = list_date.substring(0, 10);
		}catch(Exception e){list_date = "";}
		list_read_count =  TextUtil.nvl(String.valueOf(ht_list.get("list_read_count")));
		list_image_file = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file")));
		list_image_file = java.net.URLEncoder.encode(list_image_file, "EUC-KR");
		list_image_file = list_image_file.replace("+","%20");
		list_image_file2 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file2")));
		list_image_file2 = java.net.URLEncoder.encode(list_image_file2, "EUC-KR");
		list_image_file2 = list_image_file2.replace("+","%20");
		list_image_file3 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file3")));
		list_image_file3 = java.net.URLEncoder.encode(list_image_file3, "EUC-KR");
		list_image_file3 = list_image_file3.replace("+","%20");
		list_image_file4 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file4")));
		list_image_file4 = java.net.URLEncoder.encode(list_image_file4, "EUC-KR");
		list_image_file4 = list_image_file4.replace("+","%20");
		list_image_file5 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file5")));
		list_image_file5 = java.net.URLEncoder.encode(list_image_file5, "EUC-KR");
		list_image_file5 = list_image_file5.replace("+","%20");
		list_image_file6 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file6")));
		list_image_file6 = java.net.URLEncoder.encode(list_image_file6, "EUC-KR");
		list_image_file6 = list_image_file6.replace("+","%20");
		list_image_file7 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file7")));
		list_image_file7 = java.net.URLEncoder.encode(list_image_file7, "EUC-KR");
		list_image_file7 = list_image_file7.replace("+","%20");
		list_image_file8 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file8")));
		list_image_file8 = java.net.URLEncoder.encode(list_image_file8, "EUC-KR");
		list_image_file8 = list_image_file8.replace("+","%20");
		list_image_file9 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file9")));
		list_image_file9 = java.net.URLEncoder.encode(list_image_file9, "EUC-KR");
		list_image_file9 = list_image_file9.replace("+","%20");
		list_image_file10 = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file10")));
		list_image_file10 = java.net.URLEncoder.encode(list_image_file10, "EUC-KR");
		list_image_file10 = list_image_file10.replace("+","%20");
		
		image_text = TextUtil.nvl(String.valueOf(ht_list.get("image_text")));
		image_text2 = TextUtil.nvl(String.valueOf(ht_list.get("image_text2")));
		image_text3 = TextUtil.nvl(String.valueOf(ht_list.get("image_text3")));
		image_text4 = TextUtil.nvl(String.valueOf(ht_list.get("image_text4")));
		image_text5 = TextUtil.nvl(String.valueOf(ht_list.get("image_text5")));
		image_text6 = TextUtil.nvl(String.valueOf(ht_list.get("image_text6")));
		image_text7 = TextUtil.nvl(String.valueOf(ht_list.get("image_text7")));
		image_text8 = TextUtil.nvl(String.valueOf(ht_list.get("image_text8")));
		image_text9 = TextUtil.nvl(String.valueOf(ht_list.get("image_text9")));
		image_text10 = TextUtil.nvl(String.valueOf(ht_list.get("image_text10")));
		
		org_attach_name = TextUtil.nvl(String.valueOf(ht_list.get("org_attach_name"))); 
		
		
		try{
			blsBean.updateCount(board_id, list_id);
		}catch(Exception e) {
			System.out.println("update count error");
		}
	}
	else
	{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");

		out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
		return;
	}
 
 
	int pg = NumberUtils.toInt(request.getParameter("page"), 1); 
String flag = request.getParameter("flag");
if (flag == null) {
	flag = "B";
}

//�޸� �б�


int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
Hashtable memo_ht = new Hashtable();
MemoManager memoMgr = MemoManager.getInstance();
if (list_id > 0) {
 memo_ht = memoMgr.getMemoListLimit(list_id+"", mpg, 3, flag);
 
}

Vector memoVt = (Vector)memo_ht.get("LIST");
com.yundara.util.PageBean mPageBean = null;

if(memoVt != null && memoVt.size()>0){
mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
}
if(memoVt == null || (memoVt != null && memoVt.size() <= 0)){
	//������� ����.

	//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
}
else{
	if(mPageBean != null){
		mPageBean.setPagePerBlock(4);
    	mPageBean.setPage(mpg);
	}
}

int memo_size = 0;
if (list_id > 0) {
	memo_size = memoMgr.getMemoCount( list_id+"" ,flag);
} 
 
%> 

<script language="javascript">
<%if(view_comment != null && view_comment.equals("t")){ %>
$(document).ready( function(){

	 $.get('./comment.jsp', {'ocode' : '<%=list_id%>', 'page' : '1','flag':'B'}, function(data){
		 //alert(data);
		 $("#comment_link").html(data);
 
    });
		return false;
	}
	); 
 <%}%>
	

function comment_action(){
 if ( document.getElementById('wnick_name').value=="") {
	 alert('�г����� �Է��ϼ���');
 } else if ( document.getElementById('pwd').value=="") {
	 alert('��й�ȣ�� �Է��ϼ���');
 } else if ( document.getElementById('comment_write').value=="") {
	 alert('������ �Է��ϼ���');
 } else {
 
     var bodyContent = $.ajax({
		    url: "./comment.jsp?ocode=<%=list_id%>&flag=B",  //<- �̵��� �ּ� 
		    global: false, //<- 
		    type: "POST",  //<-  ������ Ÿ�� 
		    data: $("#comment_form").serialize(),  //<-  ���� �Ķ��Ÿ 
		    dataType: "html",  //<-  ������Ÿ�� 
		    async:false,
		    success: function(data){  //<-  �����϶� 
 //alert(data);
		    	 if (data != "") {
	                 $("dl#comment_link").detach();  //���� �伭 ������ ����
	                 $("#comment_link").html(data); 
	                 document.getElementById('pwd').value="";
	                 document.getElementById('comment_write').value="";
	                 //$.colorbox.resize(); 
	             } 
		    }
		 }
     
		);
 }
	 
}

function deleteChk(memoid) {  // ��� ����

	var url = "./pwd_check.jsp?ocode=<%=list_id%>&flag=B&memoid="+memoid;   
	//jQuery.colorbox({href:url, open:true});
	//location.href=url;
	window.open(url,"pwd_check", "width=100%,height=100%,scrollbars=yes,resizeable=no"); 
} 


 
 
function page_go(val){  
	$.get('./comment.jsp', {'ocode' : '<%=list_id%>', 'page' : val, 'flag':'B'}, function(data){
		 
		 if (data != "") {
		 $("dl#comment_link").detach();
		 $("#comment_link").html(data);
		 }
		
   }); 
}
 
function fileDown(){
	document.file_down.action="download.jsp"
	document.file_down.submit();
}



function board_del(){ 

	if (confirm("�����Ͻðڽ��ϱ�")) {
		name_check('mobile_delete');
	} 
}
function board_delete(){

	 if (confirm("�����Ͻðڽ��ϱ�")) {
			top.location.href="proc_boardListDelete.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>"; 
			
		}
}

function name_check(link){ 
	var url = "/mobile/include/name_gpin.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type="+link;
	location.href=url;   
	//window.open(url, "name_check", "width=400, height=300, toolbar=no,location=no,status=yes,menubar=no,scrollbars=no,resizable=no" );
// 	jQuery.colorbox({href:url, 
// 		 iframe:true,
// 		 innerWidth:420, 
// 		 innerHeight:430,
// 		 open:true});
	 
}


function pwd_check(type){   
	var url = "./pwd_check.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type="+type;
	 //var url = "./pwd_check.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type="+link;
	 location.href=url; 
	  
// 	 jQuery.colorbox({href:url, 
// 		 iframe:true,
// 		 innerWidth:420, 
// 		 innerHeight:430,
// 		 open:true}); 
}


</script>

		<section>
			<div id="container">
				<div class="snb_head">
					<h2><%=board_title %></h2>
					<div class="snb_back"><a href="javascript:history.back();"><span class="hide_txt">�ڷ�</span></a></div><!--������������ �̵�-->
<!-- 					<div class="snb_write"><a href=""><span class="hide_txt">�۾���</span></a></div>�۾��Ⱑ �������� ���� -->
				</div>
<!-- 				<div class="mLive"> -->
<!-- 					<a href=""><span class="onair">ON-AIR</span><span class="live_time">07:50~</span><strong>2017�� 4���� ����������������������������������������������������������������������������������������������������������������</strong></a> -->
<!-- 				</div>//����۾ȳ�(������� �������� ǥ��:mLive -->
				<div class="vodView">
					<h3><%=list_title %></h3>
					<div class="data1"><span>
					<%
 
						out.println(list_name);
						%>
					</span>|<span><%=list_date %></span></div>
					
					<div class="data2">
					<% if (org_attach_name != null && org_attach_name.length() > 0) { %>
						<dl>
							<dt>÷��</dt>
							<dd><a href="javascript:fileDown();"><%if (org_attach_name != null && org_attach_name.length() > 0) {out.println(org_attach_name);} %></a></dd>
							 <form name="file_down" method="post" action="download.jsp">
								<input type="hidden" name="board_id" value="<%=board_id %>" />
								<input type="hidden" name="list_id" value="<%=list_id %>" />
							</form>
						</dl>
						<%} %>
						<% if (list_link != null && list_link.length()  > 10) { %>
						<dl>
							<dt>Link</dt>
							<dd><a href="list_link" target="_blank"><%=list_link %></a></dd>
						</dl>
						<%} %>
						<% if (board_id == 22) { %>
						 <dl>
						 	<dt>����</dt>
						 	<dd><% if (image_text8 != null && image_text8.equals("V")) out.print("����(����iTV)"); %>
						 	<% if (image_text8 != null && image_text8.equals("N")) out.print("���(e��������)"); %> 
						 	</dd>
						 </dl> 
						 <%} %>
						<% if (list_image_file  != null && list_image_file.length() > 0) { %>
				 		<p>
					 		<img src="img_.jsp?list_id=<%=list_id%>"   alt="�̹���1" style="max-width:100%; "/> 
					 		<br/><%=chb.getContent_2(String.valueOf(image_text),"true")%>
				 		</p> 
				 		<%} %>
				 		<% if (list_image_file2  != null && list_image_file2.length() > 0 ){%>
				 		<p>
					 		<img src="img_.jsp?no=2&list_id=<%=list_id%>"  alt="�̹���2" style="max-width:100%; "/> 
					 		<br/><%=chb.getContent_2(String.valueOf(image_text2),"true")%>
				 		</p> 
				 		<%} %>
				 		<%if (list_image_file3  != null && list_image_file3.length() > 0 ) {%>
				 		<p>
					 		<img src="img_.jsp?no=3&list_id=<%=list_id%>"  alt="�̹���3" style="max-width:100%; "/> 
					 		<br/><%=chb.getContent_2(String.valueOf(image_text3),"true")%>
				 		</p> 
				 		<%} %> 
				 		
						<span class="subj2 clearfix"><%=chb.getContent_2(String.valueOf(list_contents),"true")%>  </span>
					</div>
					<div class="btn1 btn-03">
					
					<a href="board_list.jsp?board_id=<%=board_id%>">���</a>
					<%if(board_user_flag != null && board_user_flag.equals("t")){//�۾��� ���� üũ 
					} else{
					%>
					<% if (board_auth_write == 0) { //��ȸ�� �۾��� üũ %>
							<a href="javascript:pwd_check('update');">����</a>
							<a href="javascript:pwd_check('delete');">����</a>
					<%} else { %>		
						<% if (vod_name != null && vod_name.length() > 0) { // �α��� ó�� �Ϸ� %>							 
							<a href="board_update.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>">����</a>
							<a  href="javascript:board_delete();">����</a>
						<%} else {  // �Ǹ����� üũ  %>						 
							<a href="javascript:name_check('mobile_update');">����</a>
							<a href="javascript:board_del();">����</a>
						<%} %> 
					 <%} %>
					<%} %>
					 
					</div>
					<%if(view_comment != null && view_comment.equals("t")){ %>
					<div id="comment_inner">
					 <!-- comment::��� -->
					<div class="comment" id="comment_link">
					</div>
					<!-- //comment::��� -->
					</div>
					<%}%>
				
					 
				</div>
			</div>
<!-- 			<div class="mNotice"> -->
<!-- 				<h3>����</h3> -->
<!-- 				<a href="">2017�� 2�� ������ ��� �ȳ��Դϴپȳ��Դϴپȳ��Դϴپȳ��Դϴ�.</a> -->
<!-- 			</div>//��������:mNotice -->
		</section><!--//�������κ�:section-->    
		
  <%@ include file = "../include/foot.jsp"%>