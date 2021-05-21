<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.security.*" %>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ include file = "/include/chkLogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>���� iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
		<script type="text/javascript" src="../include/js/close.js"></script>
</head>

<%
contact.setPage_cnn_cnt("W"); // ������ ���� ī��Ʈ ����
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
	if(request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null"))
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
 
	String view_comment = "";
 //board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag,  
 //board_user_flag, board_top_comments, board_footer_comments, board_priority, board_auth_list, 
 //board_auth_read, board_auth_write, flag, view_comment, board_ccode , 
 //board_security_flag 

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
	
	String list_pwd = "";
	String org_attach_name = "";
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
		
		list_pwd = TextUtil.nvl(String.valueOf(ht_list.get("list_passwd")));
		
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
	}
 
	
	int pg = 1;
	
	String cpage = TextUtil.nvl(request.getParameter("page"));
	if(cpage.equals("")) {
	    pg = 1;
	}else {
		try{
			pg = Integer.parseInt(cpage);
		}catch(Exception ex){
		}
	}
	
	
	
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
 

//�� ���� �������� ���������� üũ�ϴ� ���� ���� ����
session.putValue("write_check", "1");

//���� ���� ���ǿ� �����ϰ� ����ڰ� �Է��� Ȯ�� ���ڿ��� ���ǿ� ����� ���ڿ��� ������ üũ�Ѵ�.
int iRandomNum = 0;
java.util.Random r = new java.util.Random(); //���� ��ü ���� �� ����
iRandomNum = r.nextInt(999)+10000;
session.putValue("random_num", String.valueOf(iRandomNum));

%> 
<script language="javascript">
 
$(document).ready( function(){
	 $.get('/2013/comment/comment_list.jsp', {'ocode' : '<%=list_id%>', 'page' : '1','flag':'B'}, function(data){
		 $("#commentList").html(data);
    });
		return false;
	}
	);
 
 
	
// $(function(){
// 	$('#comment_form').validate({
// 	    rules: {
// 	    	wnick_name: { required: true},
// 	        pwd: { required: true},
// 	        chk_word: { required: true}, 
// 	        comment_write: { required: true },
// 	        },
// 	      messages: {
// 	    	  wnick_name: { required: "<strong>�г����� �Է��ϼ���.</strong>" },
// 	          pwd: { required: "<strong>��й�ȣ�� �Է��ϼ���.</strong>" },
// 	          chk_word: { required: "<strong>Ȯ�ι��ڸ� �Է��ϼ���.</strong>" },
// 	          comment: { required: "<strong>������ �Է��ϼ���.</strong>"},
// 	        },
// 	});
	 
// });

function comment_action(){
	if(filterIng(document.getElementById('comment').value, "comment") == false){
		return;
	}else {
	if (document.getElementById('wnick_name').value == '') {
		alert("�г����� �Է��ϼ���!");
	} else if (document.getElementById('pwd').value == '') {
		alert("��й�ȣ�� �Է��ϼ���!");
	} else if (document.getElementById('chk_word').value == '') {
		alert("Ȯ�ι��ڸ� �Է��ϼ���!");
	} else if (document.getElementById('comment').value == '') {
		alert("������ �Է��ϼ���!");
	} else {
     var bodyContent = $.ajax({
		    url: "/2013/comment/comment_list.jsp",  //<- �̵��� �ּ� 
		    global: false, //<- 
		    type: "POST",  //<-  ������ Ÿ�� 
		    data: $("#comment_form").serialize(),  //<-  ���� �Ķ��Ÿ 
		    dataType: "html",  //<-  ������Ÿ�� 
		    async:false,
		    success: function(data){  //<-  �����϶� 
		    	 if (data != "") {
	                 $("dl#commentList").detach();
	                 $("#commentList").html(data); 
	                 document.getElementById('chk_word').value="";
	                 document.getElementById('comment_write').value="";
	                 
	             } 
		    }
		 }
		);
	}
	}
}

var pageno = 1 ;
var getTotalPage = 1;
function page_go(val){ 
	
 
		if (pageno > 1 && val =='pre') {
			pageno = pageno - 1;
		} else if (val =='next' && pageno < getTotalPage) {
			pageno = pageno + 1;
		} else {
			 pageno = 1 ;
		}
  
	$.get('/2013/comment/comment_list.jsp', {'ocode' : '<%=list_id%>', 'page' : pageno,'flag':'B'}, function(data){
		 
		 if (data != "") {
		 $("dl#commentList").detach();
		 $("#commentList").html(data);
	 
		 }
		
   }); 
}

function deleteChk(muid) { 
	 
  		var url = "../comment/pwd_check.jsp?ocode=<%=list_id%>&flag=<%=flag %>&board_id=<%=board_id%>&muid="+muid;   
 
		jQuery.colorbox({href:url, open:true});
 
}


function fileDown(){
	document.file_down.action="download.jsp"
	document.file_down.submit();
}
 
 function board_del(){ 
	if (confirm("�����Ͻðڽ��ϱ�")) {
		name_check('delete');
	} 
 }
 function board_delete(){
	 if (confirm("�����Ͻðڽ��ϱ�")) {
			top.location.href="proc_boardListDelete.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>"; 
			
		}
 }
 
function name_check(link){ 
	var url = "/include/name_gpin.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type="+link;   
 	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
	 
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
function filterIng(str , id){
//	alert(str);
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


//URL ����
function copy_select(){ 

  var txt = "http://tv.suwon.go.kr/index_link.jsp?list_id=<%=list_id%>&board_id=<%=board_id%>";
  if ((navigator.appName).indexOf("Microsoft")!= -1) {

       if(window.clipboardData){
            var ret = null;
            ret = clipboardData.clearData();
            if(ret){
                 window.clipboardData.setData('Text', txt);
                 alert('Ŭ�����忡 �ּҰ� ����Ǿ����ϴ�.');
            }else{
                 alert("Ŭ������ �׼��� ����� ���ּ���.");
            }
       }
  }
  else {
       alert("�ش� �������� Ŭ�����带 ����� �� �����ϴ�.\r\nURL�� [Ctrl+C]�� ����Ͽ� �����ϼ���.");
  }

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
			<h3 class="pTitle"><%=list_title %></h3>
			<span class="pTime">����� : <%=list_date %>&nbsp;&nbsp;|&nbsp;&nbsp;
				�ۼ��� :  <%

						 String temp_writer = list_name;
						 /*
						if (list_name != null && list_name.length() >= 3) {
							
// 							 temp_writer = list_name.substring(0,1);
						 
// 		                 	for (int c =0 ; c < list_name.length() -2 ; c++) {
// 		                 		temp_writer += "*";
		      
// 		                 	}
// 		                 	temp_writer += list_name.substring(list_name.length()-1, list_name.length());
							
						} else {
							temp_writer =(list_name);
						}
						*/
						out.println(temp_writer);
						%></span>
			<span class="pFile">÷������ : <a href="javascript:fileDown();"><%if (org_attach_name != null && org_attach_name.length() > 0) {out.println(org_attach_name);} %></a></span>
			<form name="file_down" method="post" action="download.jsp">
				<input type="hidden" name="board_id" value="<%=board_id %>" />
				<input type="hidden" name="list_id" value="<%=list_id %>" />
			</form>
			<div class="pSubject"><%=chb.getContent_2(String.valueOf(list_contents),"true")%></div>
			<!-- comment::��� -->
		 <%if(view_comment != null && view_comment.equals("t")){ %>
			
			<div class="comment">
				<div id="commentFrame">
					<h4 class="cTitle">�����ǰ�(<span><%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%></span>)��</h4>
					<div class="commentInput">
					<form id="comment_form" name="comment_form" method="post" action="javascript:comment_action()" >
						<input type="hidden" name="ocode" value="<%=list_id%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
						<input type="hidden" name="flag" value="<%=flag %>" />
<%-- 						<input type="hidden" name="wname" value="<%=comment_name %>" /> --%>
<%-- 						<input type="hidden" name="pwd" value="<%=comment_pwd %>" /> --%>
						<span class="warning">�ǰ��ۼ�<span>&nbsp;&nbsp;|&nbsp;&nbsp;���, �弳, ���� ���� �������� ���� �����˴ϴ�.</span></span>
						<ul>
							<li><label for="wnick_name">�г���</label></li>
							<li><input type="text" name="wnick_name" value="" id="wnick_name" title="�г���"/></li>
							<li class="pl20"><label for="pwd">��й�ȣ</label></li>
							<li><input type="password" name="pwd" value=""  id="pwd" title="��й�ȣ"/></li>
						</ul>
						<ul class="checkText">
							<li><label for="chk_word">Ȯ�ι��ڿ�</label></li>
							<li><input type="text" name="chk_word" value="" id="chk_word" size="10" title="Ȯ�� ���ڿ�"  />
							<span class="checkText1"><%=iRandomNum %></span>&nbsp;&nbsp;<span class="checkText2"> * ���� ���ڸ� �Է� �Ͻʽÿ�.</span></li>
						</ul>
						<div class="input_wrap">
							<textarea id="comment_write" name="comment" wrap="hard"  required="required" ></textarea>
							<input type="image" src="../include/images/btn_reply_ok.gif" alt="Ȯ��" class="img"/>
						</div>
						</form>
					</div>
					<div class="commentList" id="commentList"> 
					<!-- ��� ��� �ҷ� ���� -->

					</div>
  
				</div>
			</div>
			<%} %>
			<!-- //comment::��� -->
			  <%if(board_user_flag != null && board_user_flag.equals("t")){ } else{ %>
			<div class="btn5">
			<% if (vod_name != null && vod_name.length() > 0) { %>
				 
				<a class="view_page" href="board_update.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>"><img src="../include/images/btn_edit.gif" alt="����" class="img"/></a>
				<a  href="javascript:board_delete();"><img src="../include/images/btn_del.gif" alt="����" class="img"/></a>
			<%} else { %>
			 
				<a href="javascript:name_check('update');"><img src="../include/images/btn_edit.gif" alt="����" class="img"/></a>
				<a href="javascript:board_del();"><img src="../include/images/btn_del.gif" alt="����" class="img"/></a>
			<%} %>
			 
			</div>
			<%} %>
		</div>

		<div class="pAside">
			<div class="pInfo">
				<span class="pHit">Hit��<span><%=list_read_count %></span></span>
			</div>
			<div class="pLink">
				<span>�����ϱ� <a href="javascript:copy_select();"><img src="../include/images/icon_view_link.gif" alt="��ũ"/></a> </span>
			</div>
			<%@ include file = "../include/sub_topic.jsp"%>
			
		</div>
		
	</div>
	
	
</div>



</body>
</html>