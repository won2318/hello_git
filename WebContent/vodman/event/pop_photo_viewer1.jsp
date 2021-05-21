<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*,com.security.SEEDUtil"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	/**
	 * @author Jong-Hyun Ho
	 *
	 * @description : 게시물들의 정보를 등록하는 페이지
	 * date : 2005-01-04
	 */

%>

<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%

	int board_id  = 0;
	int list_id  = 0;

	try{
		if(request.getParameter("board_id") == null || request.getParameter("board_id").length()<=0 || request.getParameter("board_id").equals("null")){
			out.println("<script language='javascript'>\n" +
		            "alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.');\n" +
		            "window.close();\n" +
		            "</script>");
		}else{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
		}
	}catch(Exception e){
		board_id  = 0;
		out.println("<script language='javascript'>\n" +
	            "alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.');\n" +
	            "window.close();\n" +
	            "</script>");
	 
	}
	Vector v_bi = null;
	try{
		v_bi = BoardInfoSQLBean.getOnlyBoardList(board_id);
	}catch(NullPointerException e){
		out.println("<script language='javascript'>\n" +
	            "alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.');\n" +
	            "window.close();\n" +
	            "</script>");
		 
	}
	try{
		if(request.getParameter("list_id")  != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null")){
			list_id  = Integer.parseInt(request.getParameter("list_id") );
		}else{
			out.println("<script language='javascript'>\n" +
		            "alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.');\n" +
		            "window.close();\n" +
		            "</script>");
		}
	}catch(Exception e){ 
			out.println("<script language='javascript'>\n" +
            "alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.');\n" +
            "window.close();\n" +
            "</script>");}

	
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
	String flag = "";
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
		flag = String.valueOf(v_bi.elementAt(12));
		view_comment = String.valueOf(v_bi.elementAt(13));
	}else{
		out.println("<script language='javascript'>\n" +
	            "alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.');\n" +
	            "window.close();\n" +
	            "</script>");
	}

	Vector v_bl = null;
	String title_4 = "";
	String content_5="";
	String html_15= "";
	String link_9 = "";
	String attach_7 = "";
	String img_8 = "";
	String email_6="";
	String name_3="";
	String open_22 = "";
	String img_desc_8_19 = "";
	String ip="";
	String list_date="";
	
	String img_17 = "";
	String img_desc_17_20 = "";
	String img_18 = "";
	String img_desc_18_21 = "";
	String id_40 = "";
	
	try{
		v_bl = BoardListSQLBean.getOnlyBoardList(board_id,list_id);
		//out.println(v_bl);
		if(v_bl != null && v_bl.size()>0)
		{
			title_4=String.valueOf(v_bl.elementAt(4));
			ip=String.valueOf(v_bl.elementAt(39));
			id_40=String.valueOf(v_bl.elementAt(40));
			name_3=String.valueOf(v_bl.elementAt(3));
			email_6=String.valueOf(v_bl.elementAt(6));
			open_22=String.valueOf(v_bl.elementAt(22));
			content_5=String.valueOf(v_bl.elementAt(5));
			html_15=String.valueOf(v_bl.elementAt(15));
			link_9 = String.valueOf(v_bl.elementAt(9));
			attach_7 = String.valueOf(v_bl.elementAt(7));
			img_8 = String.valueOf(v_bl.elementAt(8));
			img_desc_8_19 =String.valueOf( v_bl.elementAt(19));
			list_date = String.valueOf( v_bl.elementAt(16)) ;
			if(list_date != null && list_date.length()>19){
				list_date = list_date.substring(0,19);
			}
			
			img_17 = String.valueOf(v_bl.elementAt(17));
			img_desc_17_20 =String.valueOf( v_bl.elementAt(20));
			
			img_18 = String.valueOf(v_bl.elementAt(18));
			img_desc_18_21 =String.valueOf( v_bl.elementAt(21));
		}
		
	}catch(NullPointerException e){
		out.println("<script language='javascript'>\n" +
            "alert('처리 중 오류가 발생하였습니다. 창을 닫습니다.');\n" +
            "window.close();\n" +
            "</script>");}
	try{

		BoardListSQLBean.updateCount(board_id, list_id);
	}catch(Exception e) {
		System.out.println("update count error");
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<title>대전 인터넷방송 : PHOTO 미리보기</title>
		<link href="/vodman/vod_aod/css/base.css" rel="stylesheet" type="text/css" />
 	</head>
<body id="popup_bg" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language='javascript'>
  
	function openImage( img_num){
		
		
    	window.open("openImage.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&img_num="+img_num,'',"width=800,height=600,left=0,top=24,scrollbars=yes,resizable=yes");
	}

	function fileDown(){
		document.down.action="download.jsp"
		document.down.submit();
	}

	  
</SCRIPT>
<div id="popup_bg">
	<h3><img src="/vodman/vod_aod/images/vod_preview.gif" alt="영상 미리보기"/></h3>
	<div id="pop_top"></div>
	<div id="pop_cen">
	<table cellspacing="0" class="preview" summary="이벤트 PHOTO">
				 <form name='viewForm' method='post' >
                                        <input type="hidden" name="board_id" value="<%=board_id%>" />
                                        <input type="hidden" name="list_id" value="<%=list_id%>" />
				<tbody>
					<tr>
						<th  ><strong>제목</strong></th>
						<td  ><%=title_4%></td>
						<th  ><strong><%=SEEDUtil.getDecrypt(String.valueOf(id_40))%>(<%=name_3%>)</strong>
						<%if(String.valueOf(email_6).indexOf(".") != -1){%>
                                                  (<%=email_6%>)
						  <%}%></th>
						<td  >
						 
						</td>
					</tr>
					<tr>
						<th  ><strong>등록시간</strong></th>
						<td  ><%=list_date%></td>
						<th  ><strong>아이피</strong></th>
						<td  > <%=ip%></td>
					</tr>
				 
					<tr>
						<th  ><strong>내용</strong></th>
						<td  style="word-break:break-all;" colspan="3"><%=chb.getContent_2(String.valueOf(content_5),"true")%></td>
					</tr>
					 <%if(board_file_flag.equals("t")){
												  if(String.valueOf(attach_7).indexOf(".") != -1){
													  String attFileName = (String)attach_7;
													  attFileName = java.net.URLEncoder.encode(attFileName, "EUC-KR");

													  
													%>
					<tr>
						<th ><strong>첨부파일</strong></th>
						<td colspan="3">
						<a href="javascript:fileDown();"><%=attach_7%></a>
						</td>
					</tr>
					 <%}}%>
					<%
					if(board_image_flag.equals("t") && (flag == null || (flag != null && !flag.equals("V"))))
					{
					%>
						<%
							if(String.valueOf(img_8).indexOf(".") != -1){
													String imgFileName = (String)img_8;
													 imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
													 imgFileName = "/upload/board_list/img_middle/"+imgFileName.replace("+","%20");
													 
													DirectoryNameManager Dmanager = new DirectoryNameManager();
													File file = new File(Dmanager.VODROOT + imgFileName);
													if(!file.exists()) {
														imgFileName = "/vodman/include/images/no_img01.gif";
													}
						%>
							
						<tr>
							<th  ><strong>이미지1</strong></th>
							<td  colspan="3"><img src="<%=imgFileName%>" onclick="javascript:openImage('1');" alt="이미지" class="img_style09"/></td>
						</tr>
						<tr>
							<th  ><strong>&nbsp;</strong></th>
							<td  colspan="3"><%=img_desc_8_19%></td>
						</tr>
						 <%} %>
						
						<%
							if(v_bl != null && v_bl.size()>0 && String.valueOf( img_17).indexOf(".") != -1){
													String imgFileName = img_17;
													 imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
													 imgFileName = "/upload/board_list/img_middle/"+imgFileName.replace("+","%20");
													 
														DirectoryNameManager Dmanager = new DirectoryNameManager();
														File file = new File(Dmanager.VODROOT + imgFileName);
														if(!file.exists()) {
															imgFileName = "/vodman/include/images/no_img01.gif";
														}
						%>
							
						<tr>
							<th  ><strong>이미지2</strong></th>
							<td colspan="3"><img src="<%=imgFileName%>" onclick="javascript:openImage('2');" alt="이미지" class="img_style09"/></td>
						</tr>
						<tr>
							<th ><strong>&nbsp;</strong></th>
							<td colspan="3"><%=img_desc_17_20%></td>
						</tr>
						 <%} %>
						

						<%
							if(v_bl != null && v_bl.size()>0 && String.valueOf(img_18).indexOf(".") != -1){
													String imgFileName = img_18;
													 imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
													 imgFileName = "/upload/board_list/img_middle/"+imgFileName.replace("+","%20");
													 
														DirectoryNameManager Dmanager = new DirectoryNameManager();
														File file = new File(Dmanager.VODROOT + imgFileName);
														if(!file.exists()) {
															imgFileName = "/vodman/include/images/no_img01.gif";
														}
						%>
							
						<tr>
							<th ><strong>이미지3</strong></th>
							<td colspan="3"><img src="<%=imgFileName%>" onclick="javascript:openImage('3');" alt="이미지" class="img_style09"/></td>
						</tr>
						<tr>
							<th ><strong>&nbsp;</strong></th>
							<td colspan="3"><%=img_desc_18_21%></td>
						</tr>
						 <%} %>


						<%
						int icount = 3;
						if(v_bl != null && v_bl.size()>0){
							for(int i=25;i<25+8;i++)
							{
								icount++;
								if(v_bl != null && v_bl.size()>0 && String.valueOf( v_bl.elementAt(i)).indexOf(".") != -1)
								{
														String imgFileName = (String)v_bl.elementAt(i);
														 imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
														 imgFileName = "/upload/board_list/img_middle/"+imgFileName.replace("+","%20");
														 
															DirectoryNameManager Dmanager = new DirectoryNameManager();
															File file = new File(Dmanager.VODROOT + imgFileName);
															if(!file.exists()) {
																imgFileName = "/vodman/include/images/no_img01.gif";
															}
							%>
								
						<tr>
							<th ><strong>이미지<%=icount%></strong></th>
							<td colspan="3"><img src="<%=imgFileName%>" onclick="javascript:openImage('<%=icount%>');" alt="이미지" class="img_style09"/></td>
						</tr>
						<tr>
							<th ><strong>&nbsp;</strong></th>
							<td colspan="3"><%=v_bl.elementAt(i+7)%></td>
						</tr>
						 <%
								}
	//							else{
	//								break;
	//							}
							}
						}
						%>



					<%
					}
					%>
					
				</tbody>
				</form>
									 
				</table>
	</div>
	<div id="pop_bot"></div>
	<div class="but01">
		<a href="javascript:window.close();"><img src="/vodman/vod_aod/images/but_close.gif" alt="닫기"/></a>
	</div>		
</div>
</body>
</html>