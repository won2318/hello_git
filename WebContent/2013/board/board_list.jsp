 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 <%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.yundara.util.*"%>

<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<%@ include file = "/include/chkLogin.jsp"%>
 <%
 request.setCharacterEncoding("EUC-KR");
String ccode ="";
if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
	ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
}

int board_id = 10;  // �������� �Խ���

if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
{
	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
	 
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�.')");

	out.println("history.go(-1)");
	out.println("</SCRIPT>");
}

%>

 <%@ include file = "../include/html_head.jsp"%>
 
<%

MediaManager mgr = MediaManager.getInstance();
 	
 	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<script type='text/javascript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}

	String board_title = "";
	String board_page_line = "10";
	String board_image_flag = "";
	String board_file_flag = "";
	String board_link_flag = "";
	String board_security_flag = "";
	String board_user_flag = "";
	String board_top_comments = "";
	String board_footer_comments = "";
	String board_priority = "";
	String view_comment ="";
	String flag = "";
	String board_hidden_flag = "";
	int board_auth_list = 0;
	int board_auth_read = 0;
	int board_auth_write = 1;
 
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
		view_comment = String.valueOf(v_bi.elementAt(13));
		board_security_flag = String.valueOf(v_bi.elementAt(15));
		board_hidden_flag= String.valueOf(v_bi.elementAt(16));
		board_auth_list = Integer.parseInt(String.valueOf(v_bi.elementAt(9)));
		board_auth_read = Integer.parseInt(String.valueOf(v_bi.elementAt(10)));
		board_auth_write = Integer.parseInt(String.valueOf(v_bi.elementAt(11)));
		 
	}
 
	String searchField = TextUtil.nvl(request.getParameter("searchField"));
	if(searchField.equals("")){
		searchField = "1";
	}
	String searchstring = "";
	if (request.getParameter("searchstring") != null && request.getParameter("searchstring").length() > 0) {
		searchstring = TextUtil.nvl(request.getParameter("searchstring"));
	}
	 
	
	int pageSize = Integer.parseInt(board_page_line);
	int totalArticle =0; //�� ���ڵ� ����
	int totalPage =0;
	int pg = NumberUtils.toInt(request.getParameter("page"), 1);
 
	Hashtable result_ht = null;
	Vector vt_list = null;
	com.yundara.util.PageBean pageBean = null;
	try{
		result_ht = blsBean.getBoardList(board_id, searchField, searchstring,  pg, pageSize);
 
		if(!result_ht.isEmpty() ) {
			vt_list = (Vector)result_ht.get("LIST");
 
			if ( vt_list != null && vt_list.size() > 0){
		        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
		        if(pageBean != null){
		        	pageBean.setPage(pg);
		        	pageBean.setLinePerPage(5);
					pageBean.setPagePerBlock(4);	
					totalArticle = pageBean.getTotalRecord();
		        	totalPage = pageBean.getTotalPage();
		        }
			}
	    }
	}catch(NullPointerException e){
		out.println("<script type='text/javascript'>");
		out.println("alert('ó�� �� ������ �߻��߽��ϴ�. ����Ŀ� �ٽ� �õ��Ͽ� �ּ���.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	
	//����Ʈ�� ���� �ҷ�����

	Vector v_bt = null;
	try{
		v_bt = blsBean.getAllBoardList(board_id, "", "", "Y");
	}catch(NullPointerException e){
		out.println("<script type='text/javascript'>");
		out.println("alert('ó�� �� ������ �߻��Ͽ����ϴ�.')");

		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}
	
	if (board_auth_list ==9) {
		// ������  
		if (vod_level != "9") {
			vt_list = null;
		 	out.println("<script language='javascript'>\n" +
		              "alert('��� ������ �����ϴ�.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		}
	} else if (board_auth_list == 1) {
		// �Ǹ����� �����
		if(!chk_login(vod_id, vod_level )) {
			
			vt_list = null;
		   	out.println("<script language='javascript'>\n" +
		              "alert('�Ǹ����� �� �̿� �����մϴ�. ������������ �̵��մϴ�.');\n" +
		              "history.go(-1);\n" +
		              "</script>");
		return;
		}
	} else if (vod_level != null && Integer.parseInt(vod_level) < board_auth_list) {
		 
// 		   	out.println("<script language='javascript'>\n" +
// 		              "alert('���� ������ �����ϴ�. ������������ �̵��մϴ�.');\n" +
// 		              "history.go(-1);\n" +
// 		              "</script>");
		vt_list = null;
		 
	}else {
		// ��ȸ�� ���
		
	}
%>
 
<script type="text/javascript">
<!--
function goPage(page){
	var f = document.frm1;
	f.page.value = page;
	f.action = "board_list.jsp";
	f.submit();
}

function search_I(){
	var f = document.frm1;
	f.page.value = 1;
	f.action = "board_list.jsp";
	f.submit();
}

function name_check(){
//	var url = "/include/name_gpin.jsp?board_id=<%=board_id%>&type=write";    
	var url = "https://tv.suwon.go.kr/include/name_gpin.jsp?board_id=<%=board_id%>&type=write";    
	
	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
	 
}

function pwd_check(listId, boardId){ 
	var url = "./pwd_check.jsp?board_id="+boardId+"&list_id="+listId+"&type=view";   
 	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
}

function login(type){
    
	var url = "/2013/include/login.jsp?board_id=<%=board_id%>&type="+type;
	
	jQuery.colorbox({href:url, 
		 iframe:true,
		 innerWidth:420, 
		 innerHeight:430,
		 open:true});
	 
}

// -->
</script>
<noscript>
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 


</noscript>


	<div id="snb">
		 <%@ include file = "../include/top_sub_menu.jsp"%>
		 
	</div>
	
	<!-- container::���������� --><!-- containerS::���������� -->
	<div id="containerS">
		<div id="content">
			<div class="sectionS">
	 
		<%if(board_user_flag != null && board_user_flag.equals("t")){  } else{ %>
			<% if (board_auth_write == 0) { %>
				<a class="view_page" href="board_write.jsp?board_id=<%=board_id%>"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
			<%} else {
			  if (vod_name != null && vod_name.length() > 0) { %>
				<span class="btn1">
				<% if(board_id == 18){%>
					<a class="view_page" href="/2013/board/board_view.jsp?board_id=10&list_id=1747"><img src="../include/images/btn_info.gif" alt="���ƶ�~å���� UCC ������ ����ȳ�"></a>
				<%}%>
				<a class="view_page" href="board_write.jsp?board_id=<%=board_id%>"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
			<%} else { %>
				<span class="btn1">
				<% if(board_id == 18){%>
					<a class="view_page" href="/2013/board/board_view.jsp?board_id=10&list_id=1747"><img src="../include/images/btn_info.gif" alt="���ƶ�~å���� UCC ������ ����ȳ�"></a>
				<%}%>
				<% if (board_auth_write > 1) { %>
					<a href="javascript:login('write');"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
				<%} else { %>
					<a href="javascript:name_check();"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
				<%} %>
			<%} %>
			<%} %>
			
		<%} %>
<%
 		try{
			
  		if (flag != null && flag.equals("N")) { %>	
				<span class="boardPage">�� <strong><%=totalArticle%></strong>��&nbsp;&nbsp;&nbsp;&nbsp;������ <strong><%=pg%>/<%=totalPage%></strong></span>
				<table class="boardList" cellspacing="0" summary="�Խ��� ������� ��ȣ, ����,�ۼ���, �����, ÷������ ����">

					<caption>�Խ��� ���</caption>
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
						<col width="16%"/>
						<col width="5%"/>
						<col width="13%"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col" abbr="��ȣ">��ȣ</th>
						<th scope="col" abbr="����">����</th>
						<th scope="col" abbr="�ۼ���">�ۼ���</th>
						<th scope="col" abbr="÷��">÷��</th>
						<th scope="col" abbr="�����">�����</th>
					</tr>
					</thead>
					<tbody>
<%
			
				if(v_bt != null && v_bt.size()>0)
				{
					String list_id ="";
					String list_title ="";
					String list_name ="";
					String ip="";
					String list_date ="";
					String list_count ="";
					String img_url = "";
					String list_data_file = "";
					String list_open = "";
					int re_level = 0;
					for(int i = 0; i < v_bt.size(); i++) {
						list_id = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(0));
						list_name = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(3));
		 				
						list_title = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(4));
						list_data_file = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(7));
						re_level = Integer.parseInt(String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(11)));
						list_count = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(12));
						list_date = String.valueOf(((Vector)(v_bt.elementAt(i))).elementAt(16));
						if(list_date != null && list_date.length()>10){
							list_date = list_date.substring(0,10);
						}
%>					
					<tr>
						<td><img src="../include/images/icon_notice.gif" alt="����"/></td>
						<td class="td_left"><a class="view_page" href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%=list_title%></a></td>
						<td><%
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
						%></td>
						<td><% if (list_data_file != null && list_data_file.contains(".") ) { %><img src="../include/images/icon_file.gif" alt="÷������"/><%} %></td>
						<td><%=list_date%></td>
					</tr>
 <%
					}
				}
				if(vt_list != null && vt_list.size() >0){
					int list = 0;
					for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<vt_list.size()); i++, list++)
					{
 
								Hashtable ht_list = (Hashtable)vt_list.get(list);
							    String list_id = TextUtil.nvl(String.valueOf(ht_list.get("list_id")));
								String list_title = TextUtil.nvl(String.valueOf(ht_list.get("list_title")));
								String list_contents = TextUtil.nvl(String.valueOf(ht_list.get("list_contents")));
								String list_image_file = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file")));
								String thumb = "/upload/board_list/img_middle/" + list_image_file;
								String list_read_count = TextUtil.nvl(String.valueOf(ht_list.get("list_read_count")));
								String list_date = TextUtil.nvl(String.valueOf(ht_list.get("list_date")));
								if(list_date != null && list_date.length()>10){
									list_date = list_date.substring(0,10);
								}
								String list_name = TextUtil.nvl(String.valueOf(ht_list.get("list_name")));
								String list_data_file = TextUtil.nvl(String.valueOf(ht_list.get("list_data_file")));
								String list_security = TextUtil.nvl(String.valueOf(ht_list.get("list_security")));
								String memo_cnt =  TextUtil.nvl(String.valueOf(ht_list.get("memo_cnt")));
								int re_level = 0;
								if (ht_list.get("list_re_level") != null ) {
									re_level = Integer.parseInt(String.valueOf(ht_list.get("list_re_level")));
								}
								String list_pwd = TextUtil.nvl(String.valueOf(ht_list.get("list_passwd")));
					%>					
					<tr>
						<td><%=pageBean.getTotalRecord()-i %></td>
						<td class="td_left">
						<%
						if(board_hidden_flag != null && board_hidden_flag.equals("t")){  // ��б�(����) �Խ���
							if ( board_auth_write == 0){

								%>
								<a href="javascript:pwd_check(<%=list_id%>,<%=board_id%>);"><%
									if(re_level > 0) {
										for(int j=1; j < re_level; j++) {
								%>
										&nbsp;&nbsp;
								<%		} %>
										<img src="../include/images/icon_reply.gif" alt="���"/>
								<%	} %><%=list_title%></a>
								<%
								
								
							} else if(  vod_id != null && vod_name != null && user_key != null && user_key.equals(list_pwd) )
							{
							%>
							<a class="view_page" href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif"  alt="���"/>
							<%	} %>
							<%=list_title%></a>
						<%
							}else{
							%>
							<a href="javascript:alert('����� ���Դϴ�.');"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif" alt="���"/>
							<%	} %><%=list_title%></a>
							<%
							}
						}else if(board_security_flag != null && board_security_flag.equals("t")){ //��б� ��� 
							if ( board_auth_write == 0){
 
								if (list_name != null && list_name.trim().equals("����iTV")) {
								%>
									<a class="view_page" href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%
											if(re_level > 0) {
												for(int j=1; j < re_level; j++) {
										%>
												&nbsp;&nbsp;
										<%		} %>
												<img src="../include/images/icon_reply.gif"  alt="���"/>
										<%	} %>
										<%=list_title%></a>
								<%
								} else {
								%>
								<a href="javascript:pwd_check(<%=list_id%>,<%=board_id%>);"><%
									if(re_level > 0) {
										for(int j=1; j < re_level; j++) {
								%>
										&nbsp;&nbsp;
								<%		} %>
										<img src="../include/images/icon_reply.gif" alt="���"/>
								<%	} %><%=list_title%></a>
								<%
								}
								
							} else if( list_security == null 
								||  (list_security != null && list_security.equals("") ) 
								||  (list_security != null && list_security.equals("null") ) 
								||  (list_security != null && list_security.equals("N") )
								||  (vod_id != null && vod_name != null && user_key != null && user_key.equals(list_pwd) ) 
								)
							{
							%>
							<a class="view_page" href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif"  alt="���"/>
							<%	} %>
							<%=list_title%></a>
						<%
							}else{
							%>
							<a href="javascript:alert('����� ���Դϴ�.');"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif" alt="���"/>
							<%	} %><%=list_title%></a>
							<%
							}
						}else{
						%>
						<a class="view_page" href="board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply.gif" alt="���"/>
							<%	} %><%=list_title%></a>
						<%
						}
						%>
						 <%if(view_comment != null && view_comment.equals("t")){
							if(memo_cnt != null && !memo_cnt.equals("0")){
						 %>
						 <span class="commentBoard">(<%=memo_cnt %>)</span>
						 <%	} 
						}
						%></td>
						<td><%
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
						%></td>
						<td><% if (list_data_file != null && list_data_file.contains(".") ) { %><img src="../include/images/icon_file.gif" alt="÷������"/><%} %></td>
						<td><%=list_date %></td>
					</tr>
 <%
					}
	 				%>
			<%}else{%>
					<tr> 
						<td colspan="5">��ϵ� ������ �����ϴ�.</td> 

					</tr>
			<%}
		
					%>					
					 
					</tbody>	
				</table>
<%	
		} else{   // ���� ���� �Խ���

%>
				<div class="vodList">
<% 				
				if(vt_list != null && vt_list.size() >0){
						int list = 0;
						for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord() && (list<vt_list.size()); i++, list++)
						{
 
								Hashtable ht_list = (Hashtable)vt_list.get(list);
							    String list_id = TextUtil.nvl(String.valueOf(ht_list.get("list_id")));
								String list_title = TextUtil.nvl(String.valueOf(ht_list.get("list_title")));
								String list_contents = TextUtil.nvl(String.valueOf(ht_list.get("list_contents")));
								String list_image_file = TextUtil.nvl(String.valueOf(ht_list.get("list_image_file")));
								String thumb = DirectoryNameManager.UPLOAD+"/board_list/img_middle/" + list_image_file;
								String list_read_count = TextUtil.nvl(String.valueOf(ht_list.get("list_read_count")));
								String list_date = TextUtil.nvl(String.valueOf(ht_list.get("list_date")));
								if(list_date != null && list_date.length()>10){
									list_date = list_date.substring(0,10);
								}
								String list_name = TextUtil.nvl(String.valueOf(ht_list.get("list_name")));
								String list_data_file = TextUtil.nvl(String.valueOf(ht_list.get("list_data_file")));
								String list_security = TextUtil.nvl(String.valueOf(ht_list.get("list_security")));
								String memo_cnt =  TextUtil.nvl(String.valueOf(ht_list.get("memo_cnt")));
 					%>					
  
				   <div class="pin">
					<%if ( i < 2) { %>
						<span class="new"><img src="../include/images/icon_new.png" alt="NEW"/></span>
					<%} %>
				 
						<span class="img"><a class="view_page" href="board_view.jsp?list_id=<%=list_id%>&board_id=<%=board_id %>"><img src="img_2.jsp?list_id=<%=list_id%>" alt="<%=list_title %>"/></a></span>
						<span class="total"> 
							<span class="title"><a class="view_page" href="board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%=list_title%></a></span>
<%-- 							<span class="subject"><%=list_title %></span> --%>
						</span>
						<span class="info">
						    <span class="time"><%=list_date %></span>
<%-- 							<span class="view"><%=list_read_count%></span> --%>
							<span class="reply"><%=memo_cnt %></span>
						</span>
					</div>
					
 <%
						}
 					}else{
 %>
					 <div>
					 <span>��ϵ� ������ �����ϴ�.</span>

					 </div>	
<%					} 
%>
 				</div>	
 <% 
			}


	 }catch(Exception e){
	  System.err.println(e);
	  //out.println(e);
	 
	 } 
					 %>	
 
			  
				<!--  page -->			
				<%if(vt_list != null && vt_list.size() > 0 && pageBean != null && pageBean.getEndRecord() > 0){%>
				    <%if(board_user_flag != null && board_user_flag.equals("t")){ } else{ %>
				    <% if (board_auth_write == 0) { %>
							<span class="btn2"><a class="view_page" href="board_write.jsp?board_id=<%=board_id%>"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
					<%} else {
						  if (vod_name != null && vod_name.length() > 0) { %>
							<span class="btn2">
							<% if(board_id == 18){%>
								<a class="view_page" href="/2013/board/board_view.jsp?board_id=10&list_id=1747"><img src="../include/images/btn_info.gif" alt="���ƶ�~å���� UCC ������ ����ȳ�"></a>
							<%}%>
							<a class="view_page" href="board_write.jsp?board_id=<%=board_id%>"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
						<%} else { %>
							<span class="btn2">
							<% if(board_id == 18){%>
								<a class="view_page" href="/2013/board/board_view.jsp?board_id=10&list_id=1747"><img src="../include/images/btn_info.gif" alt="���ƶ�~å���� UCC ������ ����ȳ�"></a>
							<%}%>
							<% if (board_auth_write > 1) { %>
								<a href="javascript:login();"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
							<%} else { %>
								<a href="javascript:name_check();"><img src="../include/images/btn_register.gif" alt="����ϱ�"></a></span>
							<%} %>
						<%} %>
						<%} %>
					<%} %>
	 						<%@ include file="page_link.jsp" %>
				<%}%>
				
				<div class="pageSearch">
 
					<form name="frm1" action="board_list.jsp" method="post">
					<input type="hidden" name="page" value="<%=pg%>" />
					<input type="hidden" name="board_id" value="<%=board_id%>" />
				 
					<fieldset>
						<legend>�Խ��ǰ˻�</legend>
						<select name="searchField">
							<option value="1" <%if (searchField != null && searchField.equals("1")){out.println("selected"); }%>>����</option>
							<option value="2" <%if (searchField != null && searchField.equals("2")){out.println("selected"); }%>>����</option>
							<option value="3" <%if (searchField != null && searchField.equals("3")){out.println("selected"); }%>>����+����</option>
						</select>
						<input type="text" title="�˻���" name="searchstring" value="<%=searchstring %>" class="input_text"/> 
						<input type="image" src="../include/images/btn_search.gif" alt="�˻�" onclick="search_I();"/>
						</fieldset>
					</form>
					
				</div>
			
			</div>			
		</div>

		<%@ include file = "../include/right_menu.jsp"%>
		
	</div>
<%if (vod_name != null && vod_name.length() > 0) { } else{%>
<% if (board_auth_write > 1) { %>
<script type="text/javascript">
<!--

if ( window.addEventListener ) { // W3C DOM ���� ������ 
	window.addEventListener("load", start, false); 
} else if ( window.attachEvent ) { // W3C DO M ���� ������ ��(ex:MSDOM ���� ������ IE) 
	window.attachEvent("onload", start); 
} else { 
	window.onload = start; 
} 

function start() 
{ 
	if (confirm("�ùθ���ʹ� �α��� �Ͻðڽ��ϱ�?") == true){    //Ȯ��
	    login('list');
	}else{   //���
	    return true;
	}
}  

// window.onload = function(){
// 	if (confirm("�ùθ���ʹ� �α��� �Ͻðڽ��ϱ�?") == true){    //Ȯ��
// 	    login('list');
// 	}else{   //���
// 	    return true;
// 	}
// }
//-->
</script>	
<%} %>
<%} %>
 <%@ include file = "../include/html_foot.jsp"%>
 