<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>

<%
if(!chk_auth(vod_id, vod_level, "s_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%

	String ctype = "";
	String strTitle = "";
	int num = 1;

	if(request.getParameter("ctype") != null) {
		ctype = String.valueOf(request.getParameter("ctype").replaceAll("<","").replaceAll(">",""));
	}else
		ctype = "V";


	if(ctype.equals("V"))
		strTitle = "동영상(VOD)";
	
 
	
	String ccategory1 = null;
	if (request.getParameter("ccategory1") != null) {
		ccategory1=request.getParameter("ccategory1").replaceAll("<","").replaceAll(">","");
	}
	String ccategory2 = null;
	if (request.getParameter("ccategory2") != null) {
		ccategory2 =request.getParameter("ccategory2").replaceAll("<","").replaceAll(">","");
	}
	String ccategory3 = null;
	if (request.getParameter("ccategory3") != null) {
		ccategory3 =request.getParameter("ccategory3").replaceAll("<","").replaceAll(">","");
	}
	String ccategory4 = null;
	if (request.getParameter("ccategory4") != null) {
		ccategory4 =request.getParameter("ccategory4").replaceAll("<","").replaceAll(">","");
	}
	String ccode = "";
	String ocode = "";
	String user_id = "";

	

	if(request.getParameter("ccategory1")!=null && !request.getParameter("ccategory1").equals("") && !request.getParameter("ccategory1").equals("null")) {
        if(request.getParameter("ccategory2")!=null && !request.getParameter("ccategory2").equals("") && !request.getParameter("ccategory2").equals("null")) {
            if(request.getParameter("ccategory3")!=null && !request.getParameter("ccategory3").equals("") && !request.getParameter("ccategory3").equals("null")) {
            	if(request.getParameter("ccategory4")!=null && !request.getParameter("ccategory4").equals("") && !request.getParameter("ccategory4").equals("null")) {
                	ccode = request.getParameter("ccategory4").trim();
            	}else{
            		ccode = request.getParameter("ccategory3").trim().substring(0,9);
            	}
            }else{
                ccode = request.getParameter("ccategory2").trim().substring(0,6);
            }
        }else{
            ccode = request.getParameter("ccategory1").substring(0,3);
        }
    }
    else{
		if(request.getParameter("ccode") != null) {ccode = request.getParameter("ccode").replaceAll("<","").replaceAll(">","");}
    	ccategory1 = "";
    	ccategory2 = "";
    	ccategory3 = "";
    	ccategory4 = "";
    }


			Calendar cal = Calendar.getInstance();
			int year  = cal.get(Calendar.YEAR),
		    month = cal.get(Calendar.MONTH)+1,
		    date = cal.get(Calendar.DATE);

    		
		    String rstime = "";

	        String retime = "";
	        String dept = "";
	        String grade = "";
	        
	        if(request.getParameter("rstime") !=null && request.getParameter("rstime").length()>0)
	            rstime = request.getParameter("rstime").replaceAll("<","").replaceAll(">","");
	       
	        if(request.getParameter("retime") !=null && request.getParameter("retime").length()>0)
	            retime = request.getParameter("retime").replaceAll("<","").replaceAll(">","");

			if(request.getParameter("ocode") !=null && request.getParameter("ocode").length()>0)
				ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
		    if(request.getParameter("user_id") !=null && request.getParameter("user_id").length()>0)
				user_id = request.getParameter("user_id").replaceAll("<","").replaceAll(">","");
		    
		    if(request.getParameter("dept") !=null && request.getParameter("dept").length()>0)
		    	dept = request.getParameter("dept").replaceAll("<","").replaceAll(">","");
		    if(request.getParameter("grade") !=null && request.getParameter("grade").length()>0)
		    	grade = request.getParameter("grade").replaceAll("<","").replaceAll(">","");


				
	
	        
	        
	String strtmp = "";


	MediaManager mgr = MediaManager.getInstance();
	Vector vt =  null;
	if (request.getParameter("search_true")!= null &&  request.getParameter("search_true").equals("Y")){
		vt = mgr.getOVODMemberList3_group( rstime, retime, ocode, user_id, ccode, ctype, dept, grade);
	}


	/******************************************************************************
	PAGEBEAN 설정
	******************************************************************************/
	int totalArticle =0; //총 레코드 갯수
	int todayArticle = 0 ; //오늘 등록 레코드 수
	int pg = 0;
    String cpage = request.getParameter("page");

    if(cpage == null || cpage.equals("")) {
        pg = 1;
    }else {
		try{
			pg = Integer.parseInt(cpage);
		}catch(Exception e){
			pg = 0;
		}
        
    }

	String jspName = "";

	if(vt != null && vt.size() >0){
		totalArticle= vt.size(); // 총 게시물 수

		jspName="mng_view_stat.jsp";

		try{
			pageBean.setTotalRecord(totalArticle);
			pageBean.setLinePerPage(Integer.parseInt("20"));
			pageBean.setPagePerBlock(10);
			pageBean.setPage(pg);
		}catch(Exception e){
			System.out.println("PAGEEXCEPTION = "+e);

		}
	}

    String strLink = "dept="+dept+"&grade="+grade+"&rstime=" +rstime+ "&retime=" +retime+ "&ctype="+ctype+"&ocode="+ocode+"&user_id="+user_id+"&ccode="+ccode+"&search_true=Y";
%>

<%@ include file="/vodman/include/top.jsp"%>
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
 
<script language="javascript">
<!--

	window.onload = function() {
<%-- 		refreshCategoryList_A('V', '', 'A', '<%=ccode%>', 'ccategory1'); --%>
<%-- 		refreshCategoryList_B('V', '', 'B', '<%=ccode%>', 'ccategory2'); --%>

		refreshCategoryList_A('V', '', 'A', '<%=ccode%>');
		refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
		
	}

	//대분류 카테고리 불러오기 (ajax_category_select.js)
	function setCcode(form, val) {
		form.ccode.value = val;
	}
	
	function search() {
	    document.frmMedia.action = "mng_view_stat.jsp";
			document.frmMedia.target="";
	    document.frmMedia.submit();
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
	
	
	
	
	function go_vlist(){
	
		document.frmMedia.action="./frame_vlist.jsp";
		document.frmMedia.target="vlist";
		document.frmMedia.submit();
	}

//-->
</script>

<%@ include file="/vodman/site/site_left.jsp"%>

		<div id="contents">
			<h3><span>시청로그</span> 보기</h3>
			<p class="location">관리자페이지 &gt; 사이트관리 &gt; <span>시청로그 보기</span></p>
			<div id="content">
				<!-- 내용 -->
				<div id="tab01">
					<ul class="s_tab01_bg">
					<li ><a href="mng_view_stat.jsp?mcode=<%=mcode%>&ctype=V" title="VOD" <%if(ctype.equals("V")){out.println("class='visible'");}%>>PC VOD</a></li>
					<li ><a href="mng_view_stat.jsp?mcode=<%=mcode%>&ctype=H" title="Mobile VOD" <%if(ctype.equals("H")){out.println("class='visible'");}%>>Mobile VOD</a></li>
					<li ><a href="mng_view_stat_live.jsp?mcode=<%=mcode%>&ctype=R" title="PC LIVE" >PC LIVE</a></li>
					<li ><a href="mng_view_stat_live.jsp?mcode=<%=mcode%>&ctype=L" title="MOBILE LIVE" >Mobile LIVE</a></li>
					</ul>

				</div>
				<form name="frmMedia" method="post">
					<input type="hidden" name="mcode" value="<%=mcode%>">
					<input type="hidden" name="ccode" value="<%=ccode%>">
					<input type="hidden" name="ocode" value="<%=ocode%>">
					<input type="hidden" name="ccategory3" value="">
					<input type="hidden" name="ccategory4" value="">
					<input type="hidden" name="search_true" value="Y">
					<input type="hidden" name="dept" value="<%=dept%>">
					<input type="hidden" name="grade" value="<%=grade%>">
					<input type="hidden" name="ctype" value="<%=ctype%>">
				<table cellspacing="0" class="log_list" summary="시청로그 보기">
				<caption>시청로그 보기</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th class="bor_bottom01"><strong>카테고리</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<select id="ccategory1" name="ccategory1" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.frmMedia, this.value);refreshCategoryList('V', this.value, 'B', 'ccategory2');">
								<option value="">--- 대분류 선택 ---</option>
							</select>

							<select id="ccategory2" name="ccategory2" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.frmMedia, this.value);">
								<option value="">--- 중분류 선택 ---</option> 
							</select>
<!-- 
							<select id="ccategory3" name="ccategory3" class="sec01" style="width:120px;" onchange="javascript:refreshCategoryList('V', this.value, 'D', 'ccategory4');">
								<option value="">--- 소분류 선택 ---</option>
							</select>

							<select id="ccategory4" name="ccategory4" class="sec01" style="width:120px;">
								<option value="">--- 세분류 선택 ---</option>
							</select>
 -->
							<a href="javascript:go_vlist();" title="영상검색"><img src="/vodman/include/images/but_vodsearch.gif" alt="영상검색"/></a>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>영상제목</strong></th>
						<td class="bor_bottom01 pa_left">
							<iframe name="vlist" src="" scrolling="no" width="300" height="21" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
						</td>
						<th class="bor_bottom01"><strong>회원ID</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="user_id" value="<%=user_id%>" class="input01" style="width:150px;" maxlength="15" /></td>
					</tr>
<!-- 
					<tr>
						<th class="bor_bottom01"><strong>부서</strong></th>
						<td class="bor_bottom01 pa_left">
							<iframe name="vlist" src="./frame_Dept.jsp" scrolling="no" width="200" height="21" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
						</td>
						<th class="bor_bottom01"><strong>직위</strong></th>
						<td class="bor_bottom01 pa_left">
							<iframe name="vlist" src="./frame_Grade.jsp" scrolling="no" width="200" height="21" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
						</td>
					</tr>
-->
					<tr>
						<th class="bor_bottom01"><strong>기간</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
						<input type="text" name="rstime" value="<%=rstime%>" class="input01" style="width:80px;" onkeypress="onlyNumber();" readonly />
						<a href="javascript:openCalendarWindow(document.frmMedia.rstime)" title="찾아보기"><img src="/vodman/include/images/but_seek.gif" alt="찾아보기"/></a>&nbsp;~&nbsp;
						<input type="text" name="retime" value="<%=retime%>" class="input01" style="width:80px;" onkeypress="onlyNumber();" readonly />
						<a href="javascript:openCalendarWindow(document.frmMedia.retime)" title="찾아보기"><img src="/vodman/include/images/but_seek.gif" alt="찾아보기"/></a>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:search();" title="검색"><img src="/vodman/include/images/but_search2.gif" alt="검색"/></a>
				</div>
				<br/><br/>
				<div class="to_but">
					<p class="to_page">Total<b><%if(vt!=null && vt.size()>0){out.println(vt.size());}else{out.println("0");}%></b>
					Page<b><%if (vt != null && vt.size() > 0) {out.println(pg);} else {out.println("0");}%>/<%if (vt != null && vt.size() > 0) {out.println(pageBean.getTotalPage());} else {out.println("0");}%></b></p>
					<p class="align_right02 height_25"><a href="mng_view_stat_excels.jsp?<%=strLink%>" title="엑셀받기"><img src="/vodman/include/images/but_excel.gif" alt="엑셀받기"/></a></p>
				</div>
				<table cellspacing="0" class="board_list" summary="동영상 시청로그">
				<caption>동영상 시청로그</caption>
				<colgroup>
					<col width="6%"/>
					<col width="12%"/>
					<col/>
					<col width="10%"/>
					<col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>영상제목</th>
						<th>시청일</th>
						<th>아이피</th>
					</tr>
				</thead>
				<tbody>
<%
	String sub_link = "";

	if(vt != null && vt.size() > 0){

		String list_id = "";
		String list_name = "";
		String list_date = "";
		String list_time = "";
		String list_ip = "";
		String list_title = "";

		try{
			for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord(); i++) {
			
				list_ip = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(1));
				list_id = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(2));
				list_name = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(3));
				list_date  = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(5));
				list_title = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(6));
%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<%--<td class="bor_bottom01"><%=list_name%>(<%=list_id%>)</td> --%>
						<td class="bor_bottom01"><%=list_id%></td>
						<td class="align_left bor_bottom01"><%=list_title%></td>
						<td class="bor_bottom01"><%=list_date.length() > 10 ? list_date.substring(0,10):list_date%></td>
						<td class="bor_bottom01"><%=list_ip%></td>
					</tr>
<%
			}
		}catch(Exception e) {}
	}
%>
				</tbody>
			</table>
			<% strLink = strLink + "&mcode="+mcode;%>
			<%@ include file="pop_page_link.jsp" %>
			<br/><br/>
			</div>
			<!-- 내용 끝 -->
		</div>	
		<!-- 컨텐츠 끝 -->
<%@ include file="/vodman/include/footer.jsp"%>