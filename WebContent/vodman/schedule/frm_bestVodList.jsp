<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.vodcaster.utils.TextUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="com.hrlee.silver.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
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

    if(request.getParameter("ccategory1")!=null && !request.getParameter("ccategory1").equals("") && !request.getParameter("ccategory1").equals("null")) {
        if(request.getParameter("ccategory2")!=null && !request.getParameter("ccategory2").equals("") && !request.getParameter("ccategory2").equals("null")) {
            if(request.getParameter("ccategory4")!=null && !request.getParameter("ccategory3").equals("") && !request.getParameter("ccategory3").equals("null")) {
            	if(request.getParameter("ccategory3")!=null && !request.getParameter("ccategory4").equals("") && !request.getParameter("ccategory4").equals("null")) {
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

	String field = "";
	String searchString = "";

	String sorder = StringUtils.defaultIfEmpty(request.getParameter("sorder"), "ocode");
    String direction = StringUtils.defaultIfEmpty(request.getParameter("direction"), "desc");

	if(request.getParameter("field") != null)
		field = request.getParameter("field").replaceAll("<","").replaceAll(">","");

	if(CharacterSet.toKorean(request.getParameter("searchString")) != null)
		searchString = CharacterSet.toKorean(request.getParameter("searchString").replaceAll("<","").replaceAll(">",""));

    String strtmp = "";

	MediaManager mgr = MediaManager.getInstance();
	Vector vt = mgr.getOMediaListAll2_cate( field, searchString, sorder, direction,ccode);



	/******************************************************************************
	PAGEBEAN 설정
	******************************************************************************/
    String jspName = "frm_bestVodList.jsp";
	int totalArticle =0; //총 레코드 갯수
	int todayArticle = 0 ; //오늘 등록 레코드 수
	int pg = 0;

	if(vt != null && vt.size() >0){
		totalArticle= vt.size(); // 총 게시물 수
		try{
			pg = Integer.parseInt((request.getParameter("page")==null)?"1":request.getParameter("page"));
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
    	+ "&direction=" + direction;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<title>관리자페이지</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>


<script language="javascript">
function set_ocode( ocode, otitle,filename) {

		opener.document.frmMedia.ocode.value = ocode;
		opener.document.frmMedia.title.value = otitle;
		opener.document.frmMedia.filename.value = filename;
        window.close();
}
</script>
<script language="javascript">
<!--
	window.onload = function() {
		refreshCategoryList_A('V', '', 'A', '<%=ccode%>');
		refreshCategoryList_B('V', '', 'B', '<%=ccode%>');
<%-- 		refreshCategoryList_C('V', '', 'C', '<%=ccode%>'); --%>
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

	function set_ocode(ocode) {
		checkBoxChecked(ocode);
<%-- 		parent.document.all.bestVod.src = "/vodman/best/frm_bestVod.jsp?flag=<%=flag%>&ocode="+ocode; --%>
		parent.document.all.bestVod.src = "/silverPlayer_admin.jsp?ocode="+ocode+"&height=185&width=210";
	}

	
	function play_media(ocode) {
		top.mediaPlayer.document.location.href="mediaPlayer.jsp?ocode="+ocode;
		
	}

	function checkMedia(ccode, ocode) {
	 
		top.schedule_list.document.listForm.action = "schedule_list.jsp?ccode="+ccode+"&ocode=" + ocode+"#end";
		top.schedule_list.document.listForm.submit();
	}

	function playControl(objName, flag) {
		document.getElementById(objName).style.display = flag;
	}

	function pageCheck(){
		var f = document.frmMedia2;

		if( f.select_ocode == undefined ){
			//
		}else if( f.select_ocode.length == undefined   ){
			f.select_ocode.checked = f.AllDel.checked;
		}else{
			for( i = 0 ; i < f.select_ocode.length; i++ ){
				f.select_ocode[i].checked = f.AllDel.checked;
			}
		}
	}

	function select_add()
	{
		var tempArray1 = new Array();
		var tempArray2 = new Array();
		var f = document.frmMedia2;

		if( f.select_ocode == undefined ){
			//
		}else if( f.select_ocode.length == undefined   ){
		 
		}else{
 
			
			
			for( i = 0 ; i < f.select_ocode.length; i++ ){
				if (f.select_ocode[i].checked) {
 					//checkMedia(f.select_ccode[i].value, f.select_ocode[i].value);
		 			tempArray1[i] = f.select_ccode[i].value;
		 			tempArray2[i] = f.select_ocode[i].value;
				}
			}
 			top.schedule_list.document.listForm.action = "schedule_list.jsp?ccode_group="+tempArray1+"&ocode_group=" +tempArray2+"#end";
			top.schedule_list.document.listForm.submit();
		}
		
	}
		
	

//-->
</script>

	</head>
<body style="background-image:none">

	<table cellspacing="0" class="main_list" summary="VOD리스트">
		<caption>VOD리스트</caption>
		<colgroup>
			<col width="60px"/>
			<col/>
			<col/>
		</colgroup>
		<tbody>
		<form name="search" method="post" action="frm_bestVodList.jsp">
			<input type="hidden" name="ccode" value="" />
			<input type="hidden" name="sorder" value="<%= sorder %>" />
			<input type="hidden" name="direction" value="<%= direction %>" />
			
			<input type="hidden" name="flag" value="<%=flag %>" />
			<tr class="height_30">
				<th class="bor_bottom01"><strong>분류선택</strong></th>
				<td class="bor_bottom01 pa_all_510" colspan="2">
					<select id="ccategory1" name="ccategory1" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value); refreshCategoryList('V', this.value, 'B', 'ccategory2');">
						<option value="">--- 대분류 선택 ---</option>
					</select>

					<select id="ccategory2" name="ccategory2" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value);">
						<option value="">--- 중분류 선택 ---</option>
					</select>
 
<!-- 					<select id="ccategory3" name="ccategory3" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value);refreshCategoryList('V', this.value, 'D', 'ccategory4');"> -->
<!-- 						<option value="">--- 소분류 선택 ---</option> -->
<!-- 					</select> -->
<!-- 					<select id="ccategory4" name="ccategory4" class="sec01" style="width:120px;" onchange="javascript:setCcode(document.search, this.value);"> -->
<!-- 						<option value="">--- 세분류 선택 ---</option> -->
<!-- 					</select> -->
				</td>
			</tr>
			<tr>
				<th class="bor_bottom01" valign="top">
					<select name="field" class="sec01" style="width:60px;">
						<option value="all" <%=field.equals("all") ? "selected" : ""%>>전체</option> 
						<option value="title" <%=field.equals("title") ? "selected" : ""%>>제목</option>
						<option value="tag" <%=field.equals("tag") ? "selected" : ""%>>태그</option> 
					</select>
				</th>
				<td valign="top">&nbsp;<input type="text" name="searchString" value="<%=searchString%>" class="input02" style="width:200px;"/></td>
				<td valign="top" class="pa_right"><a href="javascript:document.search.submit();" title="검색"><img src="/vodman/include/images/but_search.gif" alt="검색"/></a></td>
			</tr>
			</form>
			<form name="frmMedia2" method="post" action="frm_bestVodList.jsp">
			<tr>
				<td colspan="4" class="bor_top04 bor_bottom02 height_25" align="center">
				<span ><input type="checkbox" name="check_all" id="AllDel" title="전체선택" onclick="pageCheck();"/><label for="AllDel">전체</label> <a href='javascript:select_add();'>[선택추가]</a>&nbsp;&nbsp;<span>
				<p class="to_page">Total<b><%=totalArticle%></b>Page<b><%=pg%>/<%if(vt != null && vt.size() >0 && pageBean.getTotalPage() > 0){out.println(pageBean.getTotalPage());}else{out.println("0");}%></b></p></td>
			</tr>
			<tr>
				<td class="pa_all_510 main_list_cc" colspan="4">
<%
	com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	MediaInfoBean minfo = new MediaInfoBean();
	CategoryManager cmgr = CategoryManager.getInstance();

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

				String outTitle = TextUtil.replace(oinfo.getTitle(), "'", "\\'");
				outTitle = TextUtil.replace(outTitle, "\"", "");
				
				String listImage = "/vodman/include/images/no_img02.gif";
				
//				DirectoryNameManager Dmanager = new DirectoryNameManager();
				
				//listImage =SilverLightPath + "/"+oinfo.getSubfolder()+"/"+oinfo.getOcode()+"/thumbnail/"+oinfo.getModelimage();
				listImage =SilverLightPath + "/"+oinfo.getSubfolder()+"/thumbnail/"+oinfo.getModelimage();
//				File file = new File(Dmanager.VODROOT + listImage);
//				if(!file.exists()) {
//					listImage = "/vodman/include/images/no_img02.gif";
//				}
				

%>
					<table cellspacing="0">
						<tr>
							<td rowspan="2" class="pa_left">
							<input type='checkbox' name='select_ocode' value='<%=oinfo.getOcode()%>' /><input type='hidden' name='select_ccode' value='<%=oinfo.getCcode()%>' /></td>
							<td rowspan="2"><a href="javascript:set_ocode('<%=String.valueOf(oinfo.getOcode())%>');" title="<%=otitle%>"><img src="<%=listImage%>" alt="이미지" class="img_style02"/></a></td>
							<td class="main_list_cate" valign="middle"><%=ctitle%> (<%=oinfo.getPlaytime() %>)</td>
							<td ><a href="javascript:checkMedia('<%=oinfo.getCcode()%>','<%=oinfo.getOcode()%>')" title="선택"><img src="images/bu_check.gif" alt="선택"/></a></td>
							
						</tr>
						<tr>
							<td class="main_list_title"><a href="javascript:set_ocode('<%=String.valueOf(oinfo.getOcode())%>')" title="<%=otitle%>"><%=otitle%></a></td>
						</tr>
					</table>
<%
			}
		}catch(Exception e) {
			System.err.println(e);
		}
	}
%>

				</td>
			</tr>
			<tr>
				<td colspan="4"><%@ include file="page_link2.jsp" %>
					
				</td>
			</tr>
		</tbody>
	</table>
</form>
</body>
</html>