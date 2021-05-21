<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,com.vodcaster.utils.TextUtil"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="com.hrlee.silver.*"%>
<%@ include file = "/vodman/include/auth_pop.jsp"%>
 
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
 
	String[] v_chk = request.getParameterValues("v_chk");
	 
	String flag = "V";
	if (request.getParameter("flag") != null) {
		flag=request.getParameter("flag").replaceAll("<","").replaceAll(">","");
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
        num = request.getParameter("num");

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

	
    String strtmp = "";

	
   
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<title>관리자페이지</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="/vodman/include/js/ajax_category_select2.js"></script>
 
<script language="javascript">
<!--
	window.onload = function() {
	
		refreshCategoryList_A('<%=flag%>', '', 'A', '');
	}

	//대분류 카테고리 불러오기 (ajax_category_select.js)
	function setCcode( val) {
 
		form.ccode.value = val;
	}
 

	function go_submit(){ 
		document.form.submit();
		
	}

//-->
</script>

	</head>
<body>
<div id="popup_bg">
	<div id="popup_bg_top"></div>
	<div id="popup_bg_cen">
		<table cellspacing="0" class="log_list" summary="동영상검색">
		<form name="form" method="post" action="proc_move_cate.jsp">
		<input name="ccode" type="hidden" value=""/>
		<input name="flag" type="hidden" value="<%=flag%>"/>
		<% if (v_chk != null && v_chk.length > 0) { 
			for (int i = 0; i < v_chk.length; i ++ ) { 
		%>
		<input name="v_chk" type="hidden" value="<%=v_chk[i]%>"/>
		<%} }%>

			<caption>동영상검색</caption>
			<colgroup>
				<col width='15%'  class="back_f7"/> 
				<col/> 
			</colgroup>
				<tbody>
				<tr><td class="bor_bottom01" colspan="2" align="center"><% if (flag != null && flag.equals("V")) {out.println("카테고리 이동"); } else {out.println("프로그램 이동");} %></td></tr>
				<tr>
					<th class="bor_bottom01"><strong>분류</strong></th>
					<td class="bor_bottom01 pa_left"  >
						<select id="ccategory1" name="ccategory1" class="sec01" style="width:120px;" onchange="javascript:setCcode( this.value); refreshCategoryList('<%=flag %>', this.value, 'B', 'ccategory2');">
						<option value="">--- 대분류 선택 ---</option>
					</select>

					<select id="ccategory2" name="ccategory2" class="sec01" style="width:120px;" onchange="javascript:setCcode( this.value);refreshCategoryList('<%=flag %>', this.value, 'C', 'ccategory3');">
						<option value="">--- 중분류 선택 ---</option>
					</select>
 
					<select id="ccategory3" name="ccategory3" class="sec01" style="width:120px;" onchange="javascript:setCcode( this.value);">
						<option value="">--- 소분류 선택 ---</option>
					</select>
 
				<a href="javascript:document.form.submit();" title="이동"><img src="/vodman/include/images/but_save.gif" alt="이동"/></a>
					</td>
				</tr>
			</tbody>
			</table>
			<br/>
			
		</form>
		</table>
		</div>
	<div id="popup_bg_bot"></div>
	</div>
</body>
</html>