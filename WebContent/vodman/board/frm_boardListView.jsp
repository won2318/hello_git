<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*,com.security.SEEDUtil"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	/**
	 * @author Jong-Hyun Ho
	 *
	 * @description : 게시물들의 정보를 등록하는 페이지
	 * date : 2005-01-04
	 */

%>
<%
if(!chk_auth(vod_id, vod_level, "b_content")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%
	String field = request.getParameter("field").replaceAll("<","").replaceAll(">","");
	String searchstring = request.getParameter("searchstring").replaceAll("<","").replaceAll(">","");
	String pg = request.getParameter("page").replaceAll("<","").replaceAll(">","");
	

	int board_id  = 0;
	int list_id  = 0;

	try{
		if(request.getParameter("board_id") == null || request.getParameter("board_id").length()<=0 || request.getParameter("board_id").equals("null")){
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String mcode = request.getParameter("mcode");
			if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
				mcode = "0901";
			}
			String REF_URL="mng_boardList.jsp?mcode="+mcode ;
					%>
					<%@ include file = "/vodman/include/REF_URL.jsp"%>
					<%
					return;
		}else{
			board_id  = Integer.parseInt(request.getParameter("board_id") );
		}
	}catch(Exception e){
		board_id  = 0;
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode = request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0901";
		}
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
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode = request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0901";
		}
		String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	try{
		if(request.getParameter("list_id")  != null && request.getParameter("list_id").length() > 0 && !request.getParameter("list_id").equals("null")){
			list_id  = Integer.parseInt(request.getParameter("list_id") );
		}else{
			String mcode= request.getParameter("mcode");
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_boardListList.jsp?board_id=" + board_id+"&field="+field+"&page="+pg+"&searchstring="+searchstring+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
		}
	}catch(Exception e){
		list_id  =  0;
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode = request.getParameter("mcode");
		
		String REF_URL="mng_boardListList.jsp?board_id=" + board_id+"&field="+field+"&page="+pg+"&searchstring="+searchstring+"&mcode="+mcode ;
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
	String flag = "";
	String view_comment = "";
	String board_security = "";
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
		board_security = String.valueOf(v_bi.elementAt(15));
	}else{
		String mcode = request.getParameter("mcode");
		if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
			mcode = "0901";
		}
		String REF_URL="mng_boardList.jsp?mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
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
	String list_security = "";
	String org_attach_name  = "";
	
	
	String user_address1="";
	String user_address2="";
	String user_tel="";
	
	String image_text8= "";
	String image_text9= "";
	String image_text10= "";
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
			list_security=String.valueOf( v_bl.elementAt(42));
			org_attach_name=String.valueOf( v_bl.elementAt(43));
			user_address1 =String.valueOf( v_bl.elementAt(46));
			user_address2 =String.valueOf( v_bl.elementAt(47));
			user_tel =String.valueOf( v_bl.elementAt(49));
			image_text8 =String.valueOf( v_bl.elementAt(36));
			image_text9 =String.valueOf( v_bl.elementAt(37));
			image_text10 =String.valueOf( v_bl.elementAt(38));
		}
		
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String mcode = request.getParameter("mcode");
		String REF_URL="mng_boardListList.jsp?board_id=" + board_id+"&field="+field+"&page="+pg+"&searchstring="+searchstring+"&mcode="+mcode ;
				%>
				<%@ include file = "/vodman/include/REF_URL.jsp"%>
				<%
				return;
	}
	try{

		BoardListSQLBean.updateCount(board_id, list_id);
	}catch(Exception e) {
		System.out.println("update count error");
	}

%>

<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script language='javascript'>

	function memo_comment(ocode) {
		window.open("/vodman/comment/comment.jsp?ocode="+ocode+"&flag=B","admin_commnet","width=540,height=250,scrolling=none");
	}
	function listDelete() {
		ans=confirm("삭제하시겠습니까? \n\n댓글도 삭제 됩니다.")
		if (ans==true){
			viewForm.action='proc_boardListDelete.jsp?list_id=<%=list_id%>&board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>';
			viewForm.submit()
		}
		return
	}

	function listUpdate() {
		<% if (flag != null && flag.equals("V"))  { %>
		viewForm.action='frm_boardListUpdate_vod.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>';
		<%} else { %>
		viewForm.action='frm_boardListUpdate.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>';
		<%}%>
		viewForm.submit()
		return
	}

	function openImage( img_num){
		
		
    	window.open("openImage.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&img_num="+img_num,'',"width=800,height=600,left=0,top=24,scrollbars=yes,resizable=yes");
	}

	function fileDown(){
		document.down.action="download.jsp"
		document.down.submit();
	}

	function resize_img(name) {
		var img_name
		if (name  == 1)
		{
			img_name =eval("document.img_file.src");
		}
		if (name  == 2)
		{
			img_name =eval("document.img_file2.src");
		}
		if (name  == 3)
		{
			img_name =eval("document.img_file3.src");
		}

			full_image = new Image();
			full_image["src"] = img_name;
		img_width = full_image["width"];
		img_height = full_image["height"];

		var maxDim = 580;

		var scale = parseFloat(maxDim)/ parseFloat(img_height);
		if (img_width > img_height)
			scale = parseFloat(maxDim)/ parseFloat(img_width);
		if (maxDim > img_height && maxDim > img_width)
			scale = 1;

		if (scale !=1) {
			var scaleW = scale * img_width;
			var scaleH = scale * img_height;

			if (name  == 1)
			{
				document.img_file.height = scaleH;
				document.img_file.width = scaleW;
			}
			if (name  == 2)
			{
				document.img_file2.height = scaleH;
				document.img_file2.width = scaleW;
			}
			if (name  == 3)
			{
				document.img_file3.height = scaleH;
				document.img_file3.width = scaleW;
			}

		}

	}


	function list_open(cObject) {
		if(confirm('공개여부를 변경하시겠습니까?')) {
			var flag = cObject.options[cObject.selectedIndex].value;
			var url = "./proc_listOpen_update.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&page=<%=pg%>&searchstring=<%=searchstring%>&flag="+flag +"&mcode=<%=mcode%>";
			//location.href = url;
			var anchor = document.createElement("a");
			if (!anchor.click) { //Providing a logic for Non IE
				location.href = url;
			 
			}
			anchor.setAttribute("href", url);
			anchor.style.display = "none";
			var aa = document.getElementById('content');
			if( aa ){
				aa.appendChild(anchor);
				anchor.click();
			}		
		}
	}
</SCRIPT>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span><%=board_title%></span></h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; 게시판 정보 &gt; <span><%=board_title%></span></p>
			<div id="content">
				<!-- 내용 -->
				<table cellspacing="0" class="board_view" summary="><%=board_title%>">
				<caption>><%=board_title%></caption>
				<colgroup>
					<col width="15%"/>
					<col/>
					<col width="15%"/>
					<col width="15%"/>
				</colgroup>
				 <form name='viewForm' method='post' >
                                        <input type="hidden" name="board_id" value="<%=board_id%>">
                                        <input type="hidden" name="list_id" value="<%=list_id%>">
                                        <input type="hidden" name="page" value="<%=pg%>">
                                        <input type="hidden" name="field" value="<%=field%>">
                                        <input type="hidden" name="searchstring" value="<%=searchstring%>">
				<tbody>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>제목</strong></th>
						<td class="bor_bottom01 pa_left"><%=title_4%></td>
						<th class="bor_bottom01 back_f7"><strong><%=name_3%></strong>
						<%if(String.valueOf(email_6).indexOf(".") != -1){%>
                                                  (<%=email_6%>)
						  <%}%></th>
						<td class="bor_bottom01 pa_left">
							<select name="f_level" class="sec01" style="width:80px;"  onChange="return list_open(this)">
								<option value="">공개구분</option>
								<option value="Y"  <%=(open_22 != null && open_22.equals("Y")) ? "selected" : ""%>>- 공개</option>
								<option value="N"  <%=(open_22 != null && open_22.equals("N")) ? "selected" : ""%>>- 비공개</option>
							</select>
							<%
				if(board_security != null && board_security.equals("t")){
				%>
							<select name="list_security" class="sec01" style="width:80px;" >
								<option value="">비밀글 여부</option>
								<option value="Y"  <%=(list_security != null && list_security.equals("Y")) ? "selected" : ""%>>- 비밀글</option>
								<option value="N"  <%=(list_security != null && list_security.equals("N")) ? "selected" : ""%>>- 공개글</option>
							</select>
				<%
				}else{
					%><input type="hidden" name="list_security" value='N' >
					<%
				}%>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>등록시간</strong></th>
						<td class="bor_bottom01 pa_left"><%=list_date%></td>
						<th class="bor_bottom01 back_f7"><strong>아이피</strong></th>
						<td class="bor_bottom01 pa_left"> <%=ip%></td>
					</tr>
					
					<%if (board_id == 23  ) { %> <!--  이벤트 게시판 -->
					<tr>
						<th class="bor_bottom01 pa_left"  colspan="4"><strong>개인정보 수집/이용 내역 동의 여부</strong> (<%=image_text9%>)</th>
					 
					</tr>
					<tr>
						<th class="bor_bottom01 pa_left"  colspan="4"><strong>개인정보 제3자 제공 내역 동의 여부</strong> (<%=image_text10%>)</th>
						
					</tr>
					<%} %>
					
					<%if (board_id == 11 || board_id == 13  ) { %>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>주소</strong></th>
						<td class="bor_bottom01 pa_left"> <%=SEEDUtil.getDecrypt(user_address1)%> <%=SEEDUtil.getDecrypt(user_address2)%></td>
						<th class="bor_bottom01 back_f7"><strong>연락처</strong></th>
						<td class="bor_bottom01 pa_left">  <%=SEEDUtil.getDecrypt(user_tel)%></td>
					</tr>
					<%} %>
					 <%if(board_link_flag.equals("t")){
												   if(String.valueOf(link_9).indexOf(".") != -1){
											   %>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>주소링크</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3"><a href="<%=link_9%>" target="_blank"><%=link_9%></a></td>
					</tr>
					<%								}
					}%>
					
					<% if (board_id == 22) { %>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>구분</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<% if (image_text8 != null && image_text8.equals("V")) out.print("영상(수원iTV)"); %>
						 	<% if (image_text8 != null && image_text8.equals("N")) out.print("기사(e수원뉴스)"); %>
						</td>
					</tr>
						 
					<%} %>
						 
					<tr>
						<th class="bor_bottom01 back_f7"><strong>내용</strong></th>
						<td class="bor_bottom01 pa_left" style="word-break:break-all;" colspan="3"><%=chb.getContent_2(String.valueOf(content_5),"true")%></td>
					</tr>
					 <%if(board_file_flag.equals("t")){
												  if(String.valueOf(attach_7).indexOf(".") != -1){
													  String attFileName = (String)attach_7;
													  attFileName = java.net.URLEncoder.encode(attFileName, "EUC-KR");

													  if (flag != null && flag.equals("V")) { // 영상파일 WMV
													 %>
					<tr>
						<th class="back_f7"><strong>동영상</strong></th>
						<td class="pa_left" colspan="3">
							<div id="silverlightControlHost">

								<object id="SilverPlayer" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="550px" height="450px">
								<param name="source" value="<%=SilverLightServer%>/ClientBin/BoardPlayer.xap"/>
								<param name="background" value="white" />
								<param name="initParams" value="mediaSource=<%=SilverLightServer%>/<%=attach_7.trim()%>" />
								<param name="enablehtmlaccess" value="true"/>
								<a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;">
								<img src="http://go2.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none"/> </a>
								</object>

						    </div>
						</td>
					</tr>
					 <%
													  } else {
													%>
					<tr>
						<th class="bor_bottom01 back_f7"><strong>첨부파일</strong></th>
						<td class="bor_bottom01 file_dot" colspan="3">
						<a href="javascript:fileDown();"><%if (org_attach_name != null && org_attach_name.length() > 0) {out.println(org_attach_name);} else {out.println(attach_7);}%></a>
						</td>
					</tr>
					 <%}}}%>
					<%
					if(board_image_flag.equals("t") && (flag == null || (flag != null && !flag.equals("V"))))
					{
					%>
						<%
							if(String.valueOf(img_8).indexOf(".") != -1){
// 													String imgFileName = (String)img_8;
// 													String img_org = imgFileName;
// 													// imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
// 													 imgFileName = "/upload/board_list/img_middle/"+img_org;
													 
// 													DirectoryNameManager Dmanager = new DirectoryNameManager();
// 													File file = new File(Dmanager.VODROOT + imgFileName);
// 													if(!file.exists()) {
// 														imgFileName = "/vodman/include/images/no_img01.gif";
// 													}else{
// 															imgFileName = java.net.URLEncoder.encode(img_org, "EUC-KR");
// 															imgFileName = imgFileName.replace("+","%20");
// 															imgFileName = "/upload/board_list/" +imgFileName;
// 														}
						%>
							
						<tr>
							<th class="back_f7"><strong>이미지1</strong></th>
							<td class="pa_left" colspan="3"><img src="img_.jsp?list_id=<%=list_id%>" onclick="javascript:openImage('0');" alt="이미지" class="img_style09" width="600"/></td>
						</tr>
						<tr>
							<th class="bor_bottom01 back_f7"><strong>&nbsp;</strong></th>
							<td class="bor_bottom01 pa_left" colspan="3"><%=img_desc_8_19%></td>
						</tr>
						 <%} %>
						
						<%
							if(v_bl != null && v_bl.size()>0 && String.valueOf( img_17).indexOf(".") != -1){
// 													String imgFileName = img_17;
// 													String img_org = img_17;
// 													// imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
// 													 imgFileName = "/upload/board_list/img_middle/"+img_org;
													 
// 														DirectoryNameManager Dmanager = new DirectoryNameManager();
// 														File file = new File(Dmanager.VODROOT + imgFileName);
// 														if(!file.exists()) {
// 															imgFileName = "/vodman/include/images/no_img01.gif";
// 														}else{
// 															imgFileName = java.net.URLEncoder.encode(img_org, "EUC-KR");
// 															imgFileName = imgFileName.replace("+","%20");
// 															imgFileName = "/upload/board_list/" +imgFileName;
// 														}
						%>
							
						<tr>
							<th class="back_f7"><strong>이미지2</strong></th>
							<td class="pa_left" colspan="3"><img src="img_.jsp?no=2&list_id=<%=list_id%>" onclick="javascript:openImage('2');" alt="이미지" class="img_style09" width="600"/></td>
						</tr>
						<tr>
							<th class="bor_bottom01 back_f7"><strong>&nbsp;</strong></th>
							<td class="bor_bottom01 pa_left" colspan="3"><%=img_desc_17_20%></td>
						</tr>
						 <%} %>
						

						<%
							if(v_bl != null && v_bl.size()>0 && String.valueOf(img_18).indexOf(".") != -1){
													 
						%>
							
						<tr>
							<th class="back_f7"><strong>이미지3</strong></th>
							<td class="pa_left" colspan="3"><img src="img_.jsp?no=2&list_id=<%=list_id%>" onclick="javascript:openImage('3');" alt="이미지" class="img_style09"  width="600"/></td>
						</tr>
						<tr>
							<th class="bor_bottom01 back_f7"><strong>&nbsp;</strong></th>
							<td class="bor_bottom01 pa_left" colspan="3"><%=img_desc_18_21%></td>
						</tr>
						 <%} %>


						<%
						int icount = 3;
						if(v_bl != null && v_bl.size()>0){
							String img_org = "";
							for(int i=25;i<25+8;i++)
							{
								icount++;
								if(v_bl != null && v_bl.size()>0 && String.valueOf( v_bl.elementAt(i)).indexOf(".") != -1)
								{
														String imgFileName = (String)v_bl.elementAt(i);
// 														img_org = imgFileName;
// 														// imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
// 														 imgFileName = "/upload/board_list/img_middle/"+img_org;
														 
// 															DirectoryNameManager Dmanager = new DirectoryNameManager();
// 															File file = new File(Dmanager.VODROOT + imgFileName);
// 															if(!file.exists()) {
// 																imgFileName = "/vodman/include/images/no_img01.gif";
// 															}else{
// 																imgFileName = java.net.URLEncoder.encode(img_org, "EUC-KR");
// 																imgFileName = imgFileName.replace("+","%20");
// 																imgFileName = "/upload/board_list/" +imgFileName;
// 														}
							%>
								
						<tr>
							<th class="back_f7"><strong>이미지<%=icount%></strong></th>
							<td class="pa_left" colspan="3"><img src="img_.jsp?no=<%=icount%>&list_id=<%=list_id%>" onclick="javascript:openImage('<%=icount%>');" alt="이미지" class="img_style09"/></td>
						</tr>
						<tr>
							<th class="bor_bottom01 back_f7"><strong>&nbsp;</strong></th>
							<td class="bor_bottom01 pa_left" colspan="3"><%=v_bl.elementAt(i+7)%></td>
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
									   <form name="down" method="post" >
										<input type="hidden" name = "board_id" value="<%=board_id%>" >
										<input type="hidden" name = "list_id" value="<%=list_id%>" >
									  </form>
				</table>
				<div class="but01">
					<%if(view_comment.equals("t")) { %>
                    <a href="javascript:memo_comment(<%=list_id%>);"><img src="/vodman/include/images/but_reply.gif" border="0"></a>
					<%}%>
					<a href="mng_boardListList.jsp?board_id=<%=board_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>" title="목록"><img src="/vodman/include/images/but_list.gif" alt="목록"/></a>
					<%if(board_user_flag.equals("f") && !flag.equals("P")) { %>
                                  <a href="mng_boardListReply.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&field=<%=field%>&searchstring=<%=searchstring%>&page=<%=pg%>&mcode=<%=mcode%>"><img src="/vodman/include/images/but_reply_2.gif"  border="0"></a>
					<%}%>
					<a href="javascript:listUpdate();" title="수정"><img src="/vodman/include/images/but_edit2.gif" alt="수정"/></a>
					<a href="javascript:listDelete();" title="삭제"><img src="/vodman/include/images/but_del2.gif" alt="삭제"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>	
			<%@ include file="/vodman/include/footer.jsp"%>