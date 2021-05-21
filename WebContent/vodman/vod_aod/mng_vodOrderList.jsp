<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat, com.hrlee.silver.OrderMediaInfoBean"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	//request.setCharacterEncoding("euc-kr");

if(!chk_auth(vod_id, vod_level, "v_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 이희락
	 *
	 * @description : 주문형 미디어 전체정보를 보여줌.
	 * date : 2012-01-16
	 */
   
    int pg = 0;
 
    String ccode = "";
	ccode = StringUtils.defaultString(request.getParameter("ccode"),"");
    if(request.getParameter("page")==null){
        pg = 1;
    }else{
        pg = Integer.parseInt(request.getParameter("page"));
    }

	String searchField = "";		//검색 필드
	String searchString = "";		//검색어
	String subcode = "";
	String order = "mk_date";		//정렬기준 필드 mk_date ( 촬영일) owdate(등록일)
	String direction = "desc";		//정렬 방향 asc, desc
	String sdate = "";
	String edate="";
	if (request.getParameter("order") != null ) {
	order = StringUtils.defaultString(request.getParameter("order"));
	} 
	if (request.getParameter("direction") != null ) {
	direction = StringUtils.defaultString(request.getParameter("direction"));
	}
	String mtype = "C"; 			//미디어 타입 VOD/AOD/CONTENT/PHOTO
	String mtitle = "VOD";
	int listCnt = 10;				//페이지 목록 갯수

	if(request.getParameter("searchField") != null)
		searchField = request.getParameter("searchField").replaceAll("<","").replaceAll(">","");
	
	if(request.getParameter("sdate") != null)
		sdate = request.getParameter("sdate").replaceAll("<","").replaceAll(">","");
	
	if(request.getParameter("edate") != null)
		edate = request.getParameter("edate").replaceAll("<","").replaceAll(">","");
	 

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0)
		searchString = CharacterSet.toKorean(request.getParameter("searchString").replaceAll("<","").replaceAll(">",""));
		//searchString = request.getParameter("searchString");
 
	

    Rss_search mgr = Rss_search.getInstance();
    Hashtable result_ht = null;

   // result_ht = mgr.getOMediaListAll(ccode,order, searchField, searchString, pg,listCnt, direction);
    
    result_ht = mgr.getOMediaListAll(ccode,order, searchField, searchString, pg,listCnt, direction, sdate, edate);
    

    /*
    if (Integer.parseInt(vod_level) > 8) {
    	  result_ht = mgr.getOMediaListAll(ccode,mtype,order, searchField, searchString, pg,listCnt, direction, vcode);
    } else {
    	  result_ht = mgr.getOMediaListAll_userid(ccode,mtype,order, searchField, searchString, pg,listCnt, direction, tmp_id, vcode);
    }
    */

    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
    if(!result_ht.isEmpty() ) {
        vt = (Vector)result_ht.get("LIST");
		if ( vt != null && vt.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
	        if(pageBean != null){
	        	pageBean.setPagePerBlock(10);
	        	pageBean.setPage(pg);
	        }
		}
    }
    
    OrderMediaInfoBean minfo = new OrderMediaInfoBean();
	CategoryManager cmgr = CategoryManager.getInstance();
 
	String strLink = "&ctype="+mtype;
	//strtmp = "searchField:<font color=red>" +searchField+ "</font>|searchString:<font color=red>" +searchString;
    strLink += "&searchField=" +searchField+ "&searchString=" +searchString+ "&ccode="+ccode+"&sdate="+sdate+"&edate="+edate;
 
    String menu_title = "영상목록";
    
    if (ccode != null && ccode.length() > 0) {
    	menu_title = cmgr.getCategoryName(ccode, "V");
    }
%>


 

<%@ include file="/vodman/include/top.jsp"%>

<%@page import="com.hrlee.silver.OrderMediaInfoBean"%><script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>



 
<script language="javascript">
<!--
<%
if(ccode != null && ccode.length()>0){
%>
 	window.onload = function() {
			refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
			refreshCategoryList_C('V', '', 'C', '<%=ccode%>');
	}
	function setCcode(form, val) {
			form.ccode.value = val;
		}
<%
}
%>
function checkInverse() {
	if (document.frmMedia.chkAll.checked){
		if(document.frmMedia.v_chk.length) 
		{  // 여러 개일 경우
			for(i=0;i<document.frmMedia.v_chk.length;i++) {
				document.frmMedia.v_chk[i].checked = true;
			}
		}
		else
		{
			 document.frmMedia.v_chk.checked = true;
		}
	}else{
		if(document.frmMedia.v_chk.length) {  // 여러 개일 경우
			for(i=0;i<document.frmMedia.v_chk.length;i++) {
				document.frmMedia.v_chk[i].checked = false;
			}
		}else{
			document.frmMedia.v_chk.checked = false;
		}
	}
}

function sel_del() {

	if ( confirm('정말 삭제하시겠습니까?') ) {
		if(document.frmMedia.v_chk.length) {  // 여러 개일 경우
			var num = document.frmMedia.v_chk.length;
		    for(var i = 0; i < num; i++) {
		        if(document.frmMedia.v_chk[i].checked == true) {
		            document.frmMedia.action = "proc_selectDel.jsp";
					document.frmMedia.submit();
		            break;
				}
			}
		    if(i == num) {
				alert('하나 이상의 영상을 선택하세요');
				return;
			}
		}else{
			if(document.frmMedia.v_chk.checked == true) {
	            document.frmMedia.action = "proc_selectDel.jsp";
				document.frmMedia.submit();
	           
			}else{
				alert(' 영상을 선택하세요');
				return;
			}
		}
	}
	
}

function sel_close() {

	if ( confirm('비공개 처리 하시겠습니까?') ) {
		if(document.frmMedia.v_chk.length) {  // 여러 개일 경우
			var num = document.frmMedia.v_chk.length;
		    for(var i = 0; i < num; i++) {
		        if(document.frmMedia.v_chk[i].checked == true) {
		            document.frmMedia.action = "proc_selectClose.jsp";
					document.frmMedia.submit();
		            break;
				}
			}
		    if(i == num) {
				alert('하나 이상의 영상을 선택하세요');
				return;
			}
		}else{
			if(document.frmMedia.v_chk.checked == true) {
	            document.frmMedia.action = "proc_selectClose.jsp";
				document.frmMedia.submit();
	           
			}else{
				alert(' 영상을 선택하세요');
				return;
			}
		}
	}
	
}

function pop_cate_move(flag) {
		var frm = document.frmMedia;
		if(frm.v_chk.length) {  // 여러 개일 경우

			
			var num = frm.v_chk.length;
			 for(var i = 0; i < num; i++) {
				if(frm.v_chk[i].checked == true) { 
					break;
				}
			 }
		    if(i == num) {
				alert('하나 이상의 영상을 선택하세요');
				return;
			} else {
				var win_open = window.open("about:blank", "cate_move");
			 
				frm.action = "pop_moveCate.jsp?mocde=<%=mcode%>&flag="+flag;


				frm.target="cate_move";
				frm.submit();
			}



		}else{
			if(frm.v_chk.checked == true) {
				var win_open = window.open("about:blank", "cate_move");
			 
				frm.action = "pop_moveCate.jsp?mocde=<%=mcode%>&flag="+flag;
				frm.target="cate_move";
				frm.submit();
	           
			}else{
				alert(' 영상을 선택하세요');
				return;
			}
		}


		 
}


  
function setSorder(order, direction) {
    var f = document.frmMedia;
    f.order.value = order;
    f.direction.value = direction;
    f.submit();
}   

 

function go_page(page_no){
	var f = document.frmMedia; 
	f.searchString.value = "<%=searchString%>";
    f.page.value = page_no;
    f.submit();
}


//////////////////////////////////////////////////////
//달력 open window event 
//////////////////////////////////////////////////////

var calendar=null;

/*날짜 hidden Type 요소*/
var dateField;

/*날짜 text Type 요소*/
var dateField2;

function openCalendarWindow(elem) 
{
	dateField = elem;
	dateField2 = elem;

	if (!calendar) {
		calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
	} else if (!calendar.closed) {
		calendar.focus();
	} else {
		calendar = window.open('/vodman/include/calendar/calendar.html','cal','WIDTH=200,HEIGHT=250,scrollbars=no,resizable=no');
	}
}


function do_search(){
	document.frmMedia.action="./mng_vodOrderList.jsp";
	document.frmMedia.page.value="1";
	document.frmMedia.submit();
}


function go_excel(){
		document.frmMedia.action="./mng_vodOrderList_excel.jsp";
	 	document.frmMedia.submit();
	}
	
//-->
</script>

<%@ include file="/vodman/vod_aod/vod_left.jsp"%>
<%
strLink += strLink + "&mcode="+mcode;
%>
		<div id="contents">
			<h3><%=menu_title %> </h3>
			 
			<div id="content">
				<!-- 내용 -->
				<form name="frmMedia" method="post" action="mng_vodOrderList.jsp">
				<input type="hidden" name="ccode" value="<%=ccode%>">

				<input type="hidden" name="page" value="<%=pg%>">
				<input type="hidden" name="url" value=""/>
				<input type="hidden" name="mcode" value="<%=mcode%>">
				<input type="hidden" name="ctype" value="<%=mtype%>">
				<input type="hidden" name="order" value="<%=order%>">
				<input type="hidden" name="direction" value="<%=direction%>">
				<table cellspacing="0" class="log_list" summary="콘텐츠 목록">
				<caption>콘텐츠 목록</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
<%
if(ccode != null && ccode.length()>0){
%>
				<tbody>
					<tr>
						<th class="bor_bottom01">분류 선택</th>
						<td class="bor_bottom01 pa_left">
							<select id="ccategory2" name="ccategory2" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);refreshCategoryList('V', this.value, 'C', 'ccategory3');">
								<option value="">--- 중분류 선택 ---</option>
							</select>
		 
							<select id="ccategory3" name="ccategory3" class="sec01" style="width:125px;" onchange="javascript:setCcode(document.frmMedia, this.value);">
								<option value="">--- 소분류 선택 ---</option>
							</select>
							<a href="javascript:document.frmMedia.submit();" title="검색"><img src="/vodman/include/images/but_search.gif" alt="검색"/></a>&nbsp;
						</td>
					</tr>
				</tbody>
<%
}
%>				
				</table>
				<br/>
				
				<p class="to_page">Total<b><%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>Page<b><%=vt != null && vt.size()>0?pageBean.getCurrentPage():0%>/<%=vt != null && vt.size()>0?pageBean.getTotalPage():0%></b>
				<a href="./frm_AddContent.jsp?mcode=<%=mcode %>&ccode=<%=ccode%>"><img src="/vodman/include/images/but_plus.gif" alt="영상등록"/></a>
				</p>
				
				<!--<a href="javascript:sel_del();" alte="선택 한 파일 삭제">선택 삭제</a>
				<a href="javascript:sel_cate_move();" alte="선택 한 파일 부서 이동">선택한 파일 부서 이동</a>-->
				<table cellspacing="0" class="board_list" summary="동영상 목록">
				<caption>동영상 목록</caption>
				<colgroup>
					<col width="6%"/>
					<col width="6%"/>
					<col/>
					 
					<col width="12%"/>
					<col width="7%"/>
					<col width="10%"/>
					<col width="17%"/>
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkAll" onclick="javascript:checkInverse();"></th>
						<th>연번</th>
						<th>제목 
						<% if ( order != null && order.equals("title")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="제목 역순 정렬"/></a> 
								<a href="javascript:setSorder('title', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="제목 정순 정렬"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="제목 역순 정렬"/></a> 
								<a href="javascript:setSorder('title', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="제목 정순 정렬"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('title', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="제목 역순 정렬"/></a> 
						<a href="javascript:setSorder('title', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="제목 정순 정렬"/></a> 
						<%} %>
						</th>
                    
						 
						<th>등록일
						<span class="sort">
						<% if ( order != null && order.equals("mk_date")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('mk_date', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="등록일 역순 정렬"/></a> 
								<a href="javascript:setSorder('mk_date', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="등록일 정순 정렬"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('mk_date', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="등록일 역순 정렬"/></a> 
								<a href="javascript:setSorder('mk_date', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="등록일 정순 정렬"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('mk_date', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="등록일 역순 정렬"/></a> 
						<a href="javascript:setSorder('mk_date', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="등록일 정순 정렬"/></a> 
						<%} %>
							</span>
						</th>
						
						 
						<th>공개/변환</th>
						<th>hit수
							<span class="sort">
						<% if ( order != null && order.equals("hitcount")) { 
							if (direction != null && direction.equals("desc")) {%>
								<a href="javascript:setSorder('hitcount', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom_red.gif" alt="hit수 역순 정렬"/></a> 
								<a href="javascript:setSorder('hitcount', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="hit수 정순 정렬"/></a> 
						   <%} else { %>
						   		<a href="javascript:setSorder('hitcount', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="hit수 역순 정렬"/></a> 
								<a href="javascript:setSorder('hitcount', 'asc');"><img src="/vodman/include/images/icon_arrow_top_red.gif" alt="hit수 정순 정렬"/></a> 
						   <%} 
						} else {%>
						<a href="javascript:setSorder('hitcount', 'desc');"><img src="/vodman/include/images/icon_arrow_bottom.gif" alt="hit수 역순 정렬"/></a> 
						<a href="javascript:setSorder('hitcount', 'asc');"><img src="/vodman/include/images/icon_arrow_top.gif" alt="hit수 정순 정렬"/></a> 
						<%} %>
							</span>
						</th>
						 
						<th>관리</th>
					</tr>
				</thead>
				<tbody>

				<%
				


				String sub_link = "";
				int list = 0;
				if ( vt != null && vt.size() > 0){

				for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
					//OrderMediaInfoBean oinfo = new OrderMediaInfoBean();
					com.yundara.beans.BeanUtils.fill(minfo, (Hashtable)vt.elementAt(list));
					//com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)ibt.elementAt(list));
 
					 
					String goView = "<a href='javascript:media_player("+minfo.getOcode()+");'>"+String.valueOf(minfo.getTitle().length()>30?minfo.getTitle().substring(0,30):minfo.getTitle())+"</a>";
					 String tmp_mcode = "0702";
						 if(minfo.getCcode() != null && minfo.getCcode().length()>=3){
							if (minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("001")) {
								tmp_mcode = "0702";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("002")) {
								tmp_mcode = "0703";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("004")) {

								tmp_mcode = "0704";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("005")) {

								tmp_mcode = "0705";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("006")) {

								tmp_mcode = "0706";
							} else if(minfo.getCcode() != null && minfo.getCcode().substring(0,3).equals("007")) {
 								tmp_mcode = "0707";
							} 
					 }
						 
					String temp_img = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+minfo.getSubfolder()+"/thumbnail/_small/"+minfo.getModelimage();
					 if (minfo.getThumbnail_file() != null && minfo.getThumbnail_file().indexOf(".") > 0) {
						 temp_img = "/upload/vod_file/"+minfo.getThumbnail_file();
					 }	 
					%>

					<tr class="height_25 font_127">
						<td class="bor_bottom01"><input name="v_chk" type="checkbox" value="<%=minfo.getOcode()%>"></td>
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="align_left bor_bottom01">
							<a href='frm_updateContent.jsp?ocode=<%=minfo.getOcode()%>&ccode=<%=minfo.getCcode()%>&mcode=<%=tmp_mcode%>&page=<%=pg%>'>
							<img src="<%=temp_img %>" alt="썸네일 이미지" class="img_style11" style="float:left;"/></a>
							<div class="vodCategory">
								<ul>
							 
								<li class="main_list_cate2"><%=minfo.getCtitle()%></li>
								<li><span class="main_list_title"><a href='frm_updateContent.jsp?ocode=<%=minfo.getOcode()%>&ccode=<%=minfo.getCcode()%>&mcode=<%=tmp_mcode%>&page=<%=pg%>' title='동영상 수정 및 확인 페이지로 이동'>
								<%=String.valueOf(minfo.getTitle().length()>30?minfo.getTitle().substring(0,30):minfo.getTitle())%></a></span></li>
								</ul>
							</div>
						</td>
						 
						<td class="bor_bottom01 font_117"><%=minfo.getMk_date()%></td>
						<td class="bor_bottom01"><%=(minfo.getOpenflag().equals("Y") ? "공개" : "비공개")%>/<%=(minfo.getIsended()==1 ? "완료" : "대기")%></td>
						<td class="bor_bottom01 font_117"><%=minfo.getHitcount()%></td>
						<td class="bor_bottom01"> 
							<a href="proc_ovodDel.jsp?page=<%=pg%>&ocode=<%=minfo.getOcode()%>&ccode=<%=ccode%><%=strLink%>" onClick="return confirm('정말 삭제하시겠습니까?')" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a>

						</td>
					</tr>
					 <%
									}
						}else {
					 %>
					 <tr class="height_25 font_127">
						 
						<td class="align_left bor_bottom01" colspan='7' align='center'> 등록된 정보가 없습니다.</td>
						 
					</tr>

					 <%	}	%>

					
					<tr>
						 
						<td class="bor_bottom01 pa_left" colspan="7">
  						<input type="text" name="sdate" value="<%=sdate%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.sdate);" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
  						~
						<input type="text" name="edate" value="<%=edate%>" class="input01" style="width:70px;"/>&nbsp;<a href="javascript:openCalendarWindow(document.frmMedia.edate);" title="찾아보기"><img src="/vodman/include/images/icon_calender.gif" alt="찾아보기"/></a>
 					
						<select name="searchField" class="sec01" style="width:100px;">
								<option value="title" selected="selected" <%=(searchField.equals("title"))?"selected":""%>>제목</option>
								<option value="content" <%=(searchField.equals("content"))?"selected":""%>>내용</option>
								<option value="all" <%=(searchField.equals("all"))?"selected":""%>>전체</option>
							</select>
						<input type="text" name="searchString" value="<%=searchString %>" class="input01" style="width:150px;"/>
						<a href="javascript:do_search();" title="검색"><img src="/vodman/include/images/but_search.gif" alt="검색"/></a>
						
						<a href="javascript:go_excel();"><img src="/vodman/include/images/but_excel.gif" alt="Excel받기" border="0"></a>
						</td>
					</tr>
					</form>
				</tbody>
			</table>
			
			<p class="but03">
				<span class="check">
				<a href="javascript:sel_del();"><img src="/vodman/include/images/btn_checkDel.gif" alt="선택삭제"/></a>
				<a href="javascript:sel_close();"><img src="/vodman/include/images/btn_checkClose.gif" alt="비공개"/></a>
				<a href="javascript:pop_cate_move('V');"><img src="/vodman/include/images/btn_category_go.gif" alt="카테고리이동"/></a>
				<a href="javascript:pop_cate_move('Y');"><img src="/vodman/include/images/btn_program_go.gif" alt="프로그램이동"/></a>
				</span>
			</p>
			<div class="paginate">
				<%if(vt != null && vt.size() > 0 && pageBean!= null){ 


 				%>
						<%@ include file="page_link.jsp" %>
				<%	}	%>
				</div>

				<br/><br/>
			</div>

		</div>
<%@ include file="/vodman/include/footer.jsp"%>	
