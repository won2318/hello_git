 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
 <%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
 
<%@ include file="/include/chkLogin.jsp" %> 
<%
 request.setCharacterEncoding("EUC-KR");
 
int board_id = 16;  //��������

if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0 && !request.getParameter("board_id").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("board_id")))
{
	 board_id = Integer.parseInt(TextUtil.nvl(request.getParameter("board_id")));
	 
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('�߸��� ���� �Դϴ�. ���� �������� ���ư��ϴ�.')");

	//out.println("history.go(-1)");
	out.println("</SCRIPT>");
}

%>
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
	String board_page_line = "12";
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
	String searchString = TextUtil.nvl(request.getParameter("searchString"));
	
	int pageSize = Integer.parseInt(board_page_line);
	int totalArticle =0; //�� ���ڵ� ����
	int totalPage =0;
 
	int pg = NumberUtils.toInt(request.getParameter("page"), 1);
	 
	
	Hashtable result_ht = null;
	Vector vt_list = null;
	com.yundara.util.PageBean pageBean = null;
	try{
		result_ht = blsBean.getBoardList(board_id, searchField, searchString,  pg, pageSize);
 
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
	//����Ʈ�� ���� �ҷ�����
 
 if (flag != null && flag.equals("P")) {  // ���� �Խ��� ���
 
 		if(vt_list != null && vt_list.size() > 0 && pageBean != null && pageBean.getEndRecord() > 0)
		{
 			
 			try{

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
		
 		
			<li class="pin">	
						<a href="<%if ( list_security != null && list_security.equals("Y")  && ( list_name == null || vod_name == null ||  !vod_name.equals(list_name)) ) {%>javascript:alert('����� ���Դϴ�.');<%}else{ %>./board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %><%} %>">
<!-- 							<span class="new_icon">NEW</span> -->
							<img src="img_.jsp?list_id=<%=list_id%>" alt="<%=list_title %>"/>
							<span class="data">
								<h3><%=list_title %></h3>
								
								<span >[<%=list_name%>]</span>
								<span class="day"><%=list_date%></span>
							</span>
						</a>
			</li>
			
		
<%
			}  
			}catch(Exception e){}
	 
%>
			<%
			}else{
			%>
			 
			 		<li class="pin">	
						<a href="">
<!-- 							<span class="new_icon">NEW</span> -->
							<img src="../include/images/noimg.gif"/>
							<span class="data">
								<h3>��ϵ� ������ �����ϴ�.</h3>
								<span class="play_time"> </span>
								<span class="day"> </span>
							</span>
						</a>
					</li>
					 
			
			<%}
 } else { 
	 ///////////////////////
	 // �Ϲ� �Խ��� ���  	 ///
	 ///////////////////////
 
	 if(vt_list != null && vt_list.size() > 0 && pageBean != null && pageBean.getEndRecord() > 0)
		{
 			
 			try{

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
					int re_level = 0;
					if (ht_list.get("list_re_level") != null ) {
						re_level = Integer.parseInt(String.valueOf(ht_list.get("list_re_level")));
					}
					String list_pwd = TextUtil.nvl(String.valueOf(ht_list.get("list_passwd")));
					String image_text8 = TextUtil.nvl(String.valueOf(ht_list.get("image_text8")));
					String list_link =  TextUtil.nvl(String.valueOf(ht_list.get("list_link"))); 
			%>	
			<li>
			
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
										<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
								<%	} %><%=list_title%><span class="secret"><img src="../include/images/icon_secret.png" alt="���"/></span>
								<span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
								<%
								
								
							} else if(  vod_id != null && vod_name != null && user_key != null && user_key.equals(list_pwd) )
							{
							%>
							<a  href="./board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
							<%	} %>
							<%=list_title%><span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
						<%
							}else{
							%>
							<a href="javascript:alert('����� ���Դϴ�.');"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
							<%	} %><%=list_title%><span class="secret"><img src="../include/images/icon_secret.png" alt="���"/></span>
							<span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
							<%
							}
						}else if(board_security_flag != null && board_security_flag.equals("t")){ //��б� ��� �Խ���
							if ( board_auth_write == 0){
 
								if (list_name != null && list_name.trim().equals("����iTV")) {  //������ ���
								%>
									<a  href="./board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%
											if(re_level > 0) {
												for(int j=1; j < re_level; j++) {
										%>
												&nbsp;&nbsp;
										<%		} %>
												<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
										<%	} %>
										<%=list_title%><span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
								<%
								} else if(list_security != null && list_security.equals("Y")) {  // ��б� üũ�� �Խù� 
								%>
								<a href="javascript:pwd_check(<%=list_id%>,<%=board_id%>);"><%
									if(re_level > 0) {
										for(int j=1; j < re_level; j++) {
								%>
										&nbsp;&nbsp;
								<%		} %>
										<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
								<%	} %><%=list_title%><span class="secret"><img src="../include/images/icon_secret.png" alt="���"/></span>
								<span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
								<%
								} else {
									%>
									<a  href="./board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%
											if(re_level > 0) {
												for(int j=1; j < re_level; j++) {
										%>
												&nbsp;&nbsp;
										<%		} %>
												<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
										<%	} %>
										<%=list_title%><span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
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
							<a href="./board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
							<%	} %>
							<%=list_title%><span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
						<%
							}else{
							%>
							<a href="javascript:alert('����� ���Դϴ�.');"><%
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
							<%	} %><%=list_title%><span class="secret"><img src="../include/images/icon_secret.png" alt="���"/></span>
							<span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
							<%
							}
						}else{
						
							if (board_id == 24)  { %>
							<a href="<%=list_link %>" target="_blank"> 
							<% }else { %>
							<a href="./board_view.jsp?list_id=<%=list_id%>&amp;board_id=<%=board_id %>"><%
							} 
								if(re_level > 0) {
									for(int j=1; j < re_level; j++) {
							%>
									&nbsp;&nbsp;
							<%		} %>
									<img src="../include/images/icon_reply_title.gif" width="39" height="18" alt="���"/>
							<%	} %>
							<%if (board_id == 22 && image_text8 != null && image_text8.equals("V") ) {out.print("����(����iTV) ");} %>
							<%=list_title%><span class="update"><strong><%=list_name %></strong><%=list_date %></span></a>
						<%
						}
						%> 
						</li> 
	 <%
			}  
			}catch(Exception e){}
 			
		}else{
		%>
			<li>��ϵ� ������ �����ϴ�.</li>
		<% }
	 
 } %>
  
 