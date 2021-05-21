<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.vodcaster.utils.TextUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="com.hrlee.silver.*"%>
<%@ include file = "/vodman/include/auth_pop.jsp"%>
<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>
<%
if(!chk_auth(vod_id, vod_level, "be_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 박종성
	 *
	 * @description : 베스트 VOD리스트.
	 * date : 2009-10-19
	 */
	 
//	request.setCharacterEncoding("EUC-KR");
String flag = "A";
if (request.getParameter("flag") != null) {
	flag=request.getParameter("flag").replaceAll("<","").replaceAll(">","");
}

String ocode = null;
if (request.getParameter("ocode") != null) {
	ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
}
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
    String num = "";
     if(request.getParameter("num") != null)
        num = request.getParameter("num").replaceAll("<","").replaceAll(">","");

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
		if(request.getParameter("ccode") != null) {ccode = request.getParameter("ccode");}
    	ccategory1 = "";
    	ccategory2 = "";
    	ccategory3 = "";
    	ccategory4 = "";
    }

	String field = "";
	String searchString = "";

	String sorder = StringUtils.defaultIfEmpty(request.getParameter("sorder"), "mk_date");
    String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

	if(request.getParameter("field") != null)
		field = request.getParameter("field");

	if(CharacterSet.toKorean(request.getParameter("searchString")) != null)
		searchString = CharacterSet.toKorean(request.getParameter("searchString").replaceAll("<","").replaceAll(">",""));

    String strtmp = "";

	MediaManager mgr = MediaManager.getInstance();
	Vector vt = mgr.getOMediaListAll2_cate( field, searchString, sorder, direction,ccode);



	/******************************************************************************
	PAGEBEAN 설정
	******************************************************************************/
    String jspName = "pop_best_topList.jsp";
	int totalArticle =0; //총 레코드 갯수
	int todayArticle = 0 ; //오늘 등록 레코드 수
	int pg = 0;

	if(vt != null && vt.size() >0){
		totalArticle= vt.size(); // 총 게시물 수
		try{
			pg=Integer.parseInt((request.getParameter("page")==null)?"1":request.getParameter("page"));
		}catch(Exception e){
			pg = 0;
		}
		try{
			pageBean.setTotalRecord(totalArticle);
			pageBean.setLinePerPage(Integer.parseInt("6"));
			pageBean.setPagePerBlock(5);
			pageBean.setPage(pg);
		}catch(Exception e){
			System.out.println("PAGEEXCEPTION = "+e);

		}
	}


	//************** 게시판관련 정보 끝 *********************//

    String argument = "&field=" + field
        + "&searchString=" + searchString
        + "&sorder=" + sorder
		+ "&ccode=" + ccode
        + "&ocode=" + ocode
		+ "&flag=" + flag
		+ "&num=" + num
    	+ "&direction=" + direction;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<title>관리자페이지</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
<script language="javascript">

	function set_ocode(ocode, otitle) {		
			var of = opener.document.frmMedia;
			var cnt = of.bts_ocode.length;			
			if(cnt!=undefined){
				of.bts_ocode[<%= Integer.parseInt(num)-1 %>].value = ocode;			
				of.bts_title[<%= Integer.parseInt(num)-1 %>].value = otitle;
			}else{
				of.bts_ocode.value = ocode;			
				of.bts_title.value = otitle;
			}			
			window.close();
		}
</script>
<script language="javascript">
<!--
	window.onload = function() {
		refreshCategoryList_A('V', '', 'A', '<%=ccode%>');
		refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
		refreshCategoryList_C('V', '', 'C', '<%=ccode%>');
<%-- 		refreshCategoryList_D('V', '', 'D', '<%=ccode%>'); --%>
		checkBoxChecked(<%=ocode%>);
	}

	//대분류 카테고리 불러오기 (ajax_category_select.js)
	function setCcode(form, val) {
 
		form.ccode.value = val;
	}

	function checkBoxChecked(ocode) {
		for(var i=0; i < document.all.length; i++) {
			if(document.all(i).tagName.toUpperCase() == "INPUT") {
				if(document.all(i).type.toUpperCase() == "CHECKBOX") {
					if(document.all(i).value == ocode) {
						document.all(i).checked = true;
					} else {
						document.all(i).checked = false;
					}
				}
			}
		}
	}


//-->
</script>

	</head>
<body>
<div id="popup_bg">
	<div id="popup_bg_top"></div>
	<div id="popup_bg_cen">
		<table cellspacing="0" class="log_list" summary="동영상검색">
<form name="search" method="post" action="pop_best_topList.jsp">
	<input type="hidden" name="ccode" value="" />
	<input type="hidden" name="sorder" value="<%= sorder %>" />
	<input type="hidden" name="direction" value="<%= direction %>" />
	
	<input type="hidden" name="num" value="<%=num %>" />

			<caption>동영상검색</caption>
			<colgroup>
				<col width="15%" class="back_f7"/>
				<col/>
			</colgroup>
				<tbody>
				<tr>
					<th class="bor_bottom01"><strong>분류</strong></th>
					<td class="bor_bottom01 pa_left" colspan="3">
						<select id="ccategory1" name="ccategory1" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value); refreshCategoryList('V', this.value, 'B', 'ccategory2');">
						<option value="">--- 대분류 선택 ---</option>
					</select>

					<select id="ccategory2" name="ccategory2" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value);refreshCategoryList('V', this.value, 'C', 'ccategory3');">
						<option value="">--- 중분류 선택 ---</option>
					</select>
 
					<select id="ccategory3" name="ccategory3" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value);">
						<option value="">--- 소분류 선택 ---</option>
					</select>
<!-- 					<select id="ccategory4" name="ccategory4" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value);"> -->
<!-- 						<option value="">--- 세분류 선택 ---</option> -->
<!-- 					</select> -->
					</td>
				</tr>
				<input type="hidden" name="field" value="title">
				<tr>
					<th class="bor_bottom01"><strong>검색</strong></th>
					<td class="bor_bottom01 pa_left"><input type="text" name="searchString" value="<%=searchString%>" class="input01" style="width:150px;"/>
					<a href="javascript:document.search.submit();" title="검색"><img src="/vodman/include/images/but_search.gif" alt="검색"/></a>
					</td>
				</tr>
			</tbody>
			</table>
			<br/>
			<p class="to_page">Total<b><%=totalArticle%></b>Page<b><%=pg%>/<%if(vt != null && vt.size() >0 && pageBean.getTotalPage() > 0){out.println(pageBean.getTotalPage());}else{out.println("0");}%></b></p>
			<table cellspacing="0" class="board_list" summary="동영상 목록" width="500">
			<caption>동영상 목록</caption>
			<colgroup>
				<col width="6%"/>
				<col width="15%"/>
				<col/>
				<col width="15%"/>
			</colgroup>
			<tbody>
					<tr>
						<td class="pa_all_510 main_list_cc" colspan="4">
							<table cellspacing="0">
<%
	com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	MediaInfoBean minfo = new MediaInfoBean();
	//CategoryManager cmgr = CategoryManager.getInstance();

	String sub_link = "";

	if(vt != null && vt.size() > 0){

		try{
			for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord(); i++) {

				com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)vt.elementAt(i));

				String ctitle = oinfo.getCtitle();
				String otitle = String.valueOf(oinfo.getTitle());
				int str_l = 30;
				if(otitle.length() > str_l) {
					otitle = otitle.substring(0,str_l-1) + "...";
				}

				String outTitle = oinfo.getTitle();
				 
				outTitle =outTitle.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
				
				String listImage = "/vodman/include/images/no_img02.gif";
				
//				DirectoryNameManager Dmanager = new DirectoryNameManager();
				
				//listImage =SilverLightPath + "/"+oinfo.getSubfolder()+"/"+oinfo.getOcode()+"/thumbnail/"+oinfo.getModelimage();
				listImage =SilverLightPath + "/"+oinfo.getSubfolder() +"/thumbnail/"+oinfo.getModelimage();
//				File file = new File(Dmanager.VODROOT + listImage);
//				if(!file.exists()) {
//					listImage = "/vodman/include/images/no_img02.gif";
//				}
 
 					if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
 						listImage = "/upload/vod_file/"+oinfo.getThumbnail_file();
					}
  
%>  
						<tr>
							<td rowspan="2" class="pa_left"><input type="checkbox" id="check_<%=String.valueOf(oinfo.getOcode())%>" name="check_<%=String.valueOf(oinfo.getOcode())%>" value="<%=String.valueOf(oinfo.getOcode())%>"  onclick="set_ocode('<%=oinfo.getOcode()%>','<%= outTitle %>');" /></td>
							<td rowspan="2"><a href="javascript:set_ocode('<%=oinfo.getOcode()%>','<%= outTitle %>');" title="<%=outTitle%>"><img src="<%=listImage%>" alt="이미지" class="img_style02"/></a></td>
							<td class="main_list_cate"><%=ctitle%> &nbsp;&nbsp;/ &nbsp;<%=oinfo.getMk_date()%></td>
						</tr>
						<tr>
							<td class="main_list_title"><a href="javascript:set_ocode('<%=oinfo.getOcode()%>','<%= outTitle %>')" title="<%=outTitle%>"><%=otitle%></a></td>
						</tr>
					

<%
			}
		}catch(Exception e) {
			System.err.println(e);
		}
	}
%>						
							</table>
						</td>
					</tr>
<%
			if(vt != null && vt.size() > 0){
			%>
					<tr>
						<td colspan="4">
							<div class="paginate">
							  <%@ include file="page_link.jsp" %>
							</div>
						</td>
					</tr>
			<%} %>
				</tbody>
				</form>
			</table>
		</div>
	<div id="popup_bg_bot"></div>
	</div>
</body>
</html>