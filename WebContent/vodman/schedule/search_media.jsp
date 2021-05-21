<%@page import="com.hrlee.sqlbean.*"%>
<%@page import="com.hrlee.silver.*"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
 
<%@ include file = "/vodman/include/auth.jsp"%>
 
<%
if(!chk_auth(vod_id, vod_level, "v_content")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 최희성
	 *
	 * @description : 주문형 미디어 전체정보를 보여줌.
	 * date : 2005-01-07
	 */

    int currentPage = 0;

    String ccode = StringUtils.defaultString(request.getParameter("ccode"));
    String mcode = StringUtils.defaultString(request.getParameter("mcode"));
	String ctype = request.getParameter("ctype"); // A = aod, V = vidString ctype = request.getParameter("ctype");
		if(ctype == null)
		ctype = "V";
    if(mcode == null ){
    	out.println("<script lanauage='javascript'>alert('미디어코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
    }
    if(ccode == null ){
    	out.println("<script lanauage='javascript'>alert('카테고리 코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
    }

//    int totalMember = 520;

    
    if(request.getParameter("Opage")==null){
    	currentPage = 1;
    }else{
    	currentPage = Integer.parseInt(request.getParameter("Opage"));
    }
	
	String searchField = "";
	String searchString = "";
 
	searchString = StringUtils.defaultString(request.getParameter("searchString"));
	searchField = StringUtils.defaultString(request.getParameter("searchField"));
	
    MediaManager mgr = MediaManager.getInstance();
   	int tableRow = 9;
   
       int pg = 0;
	//if(request.getParameter("page")==null){
		
if(request.getParameter("page") == null || (request.getParameter("page") != null && request.getParameter("page").equals("null")) ||  (request.getParameter("page") != null && request.getParameter("page").length()<=0)){
        pg = 1;
    }else{
        pg = Integer.parseInt(request.getParameter("page"));
    }
	String order = "owdate";		//정렬기준 필드 owdate
	String direction = "desc";		//정렬 방향 asc, desc
	int listCnt = 10;				//페이지 목록 갯수 
	
    Hashtable result_ht = null;

    result_ht = mgr.getOMedia_search(ccode, "V", "", searchField, searchString, pg, listCnt);

	Vector vt2 = null;
    com.yundara.util.PageBean pageBean = null;
    if(!result_ht.isEmpty() ) {
        vt2 = (Vector)result_ht.get("LIST");
		if ( vt2 != null && vt2.size() > 0){
	        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
				if(pageBean != null){
					pageBean.setPagePerBlock(10);
					pageBean.setPage(pg);
			}
		}
    }


    String strLink = "&mcode="+mcode+"&ctype="+ctype+"&searchField=" +searchField+ "&searchString=" +searchString+ "&ccode="+ccode;
	//strtmp = "searchField:<font color=red>" +searchField+ "</font>|searchString:<font color=red>" +searchString;

    //String strLink = "&searchField=" +searchField+ "&searchString=" +searchString+ "&ccategory1=" +ccategory1+ "&ccategory2=" +ccategory2+ "&ccategory3=" +ccategory3;
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">
<link rel="stylesheet" href="schedule.css" type="text/css">

<script language="javascript">
<!--
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

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="7" border="0" width="240">
<form name="frmMedia" method="post" action="search_media.jsp">
	<tr>
		<td colspan="3">
			<select name="searchField" class="inputG">
				<option value="title" selected <%=(searchField.equals("title"))?"selected":""%>>제목</option>
				<option value="content" <%=(searchField.equals("content"))?"selected":""%>>내용</option>
				<option value="all" <%=(searchField.equals("all"))?"selected":""%>>전체</option>
			</select>
			<input type="text" name="searchString" style="width:90px" class="inputG" value="<%=searchString%>">
			&nbsp;<input type="image" src="images/bu_search.gif" border="0" align="absmiddle">
		</td>
	</tr>
<input type="hidden" name="mcode" value="<%=mcode%>">
<input type="hidden" name="ccode" value="<%=ccode%>">
</form>
	<tr>
		<td colspan="3" bgcolor="#dbe2ed" height="1"></td>
	</tr>
<form name="frmMedia2" method="post" action="search_media.jsp">
	<tr>
		<td colspan="3" >
			
			<span ><input type="checkbox" name="check_all" id="AllDel" title="전체선택" onclick="pageCheck();"/><label for="AllDel">전체</label> <a href='javascript:select_add();'>[선택추가]</a>&nbsp;&nbsp;
			<b><%if(vt2 != null && vt2.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%></b>
			(<b><%if(vt2 != null && vt2.size()>0){%><%=pageBean.getCurrentPage()%>/<%=pageBean.getTotalPage()%><%} else{%>0/0<%}%></b>)<span>
		</td>
	</tr>
	<tr>
		<td colspan="3" bgcolor="#dbe2ed" height="1"></td>
	</tr>
<%
	OrderMediaInfoBean oinfo2 = new OrderMediaInfoBean();
	CategoryManager Cmgr = CategoryManager.getInstance();
	int list = 0;
	if ( vt2 != null && vt2.size() > 0){
	
		for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt2.size()) ; i++, list++){
			com.yundara.beans.BeanUtils.fill(oinfo2, (Hashtable)vt2.elementAt(list));
			
			String imgurl ="images/sch_player.gif";
			if((oinfo2.getOimagefile1() != null) && (oinfo2.getOimagefile1().length()>=4 ) && 
					(oinfo2.getOimagefile1().substring(oinfo2.getOimagefile1().length()-4,oinfo2.getOimagefile1().length()).toUpperCase().equals(".GIF") ||     
							oinfo2.getOimagefile1().substring(oinfo2.getOimagefile1().length()-4,oinfo2.getOimagefile1().length()).toUpperCase().equals(".JPG") ||     
							oinfo2.getOimagefile1().substring(oinfo2.getOimagefile1().length()-4,oinfo2.getOimagefile1().length()).toUpperCase().equals(".JPEG"))
					){imgurl=oinfo2.getOimagefile1();}else{imgurl ="images/sch_player.gif";}
			
			String cate_title = Cmgr.getCategoryName(oinfo2.getCcode(),"V");
			
			
			long runningtime = 0;
			String play_time =  oinfo2.getOplay_time();
 
			String rhour = StringUtils.leftPad(
	                String.valueOf(
	                    NumberUtils.toInt(
	                        String.valueOf(runningtime / 3600))),2, "0");
			String rmin = StringUtils.leftPad(
		                String.valueOf(
		                    NumberUtils.toInt(
		                        String.valueOf(
	                                    (runningtime % 3600) / 60))), 2, "0");
			String rsec = StringUtils.leftPad(
	                String.valueOf(runningtime % 60), 2, "0");
			
			if(oinfo2.getOfilename() != null && oinfo2.getOfilename().trim().length() > 0) {
				play_time = rhour + ":" + rmin + ":" + rsec;
			}
			
			String title = oinfo2.getOtitle();
%>
	<tr>
		<!-- <td width="65"><p class="play_view" id="view_<%=oinfo2.getOcode()%>" style="display:none"  onmouseover="playControl('view_<%=oinfo2.getOcode()%>','block');"><a href="javascript:play_media(<%=oinfo2.getOcode()%>);" title="play_view"><img src="images/but_play_view.gif" alt="Play" /></a></p>
			<img src="<%=imgurl%>" alt="<%=oinfo2.getOtitle()%>" class="img_style01" onmouseover="playControl('view_<%=oinfo2.getOcode()%>','block');" onmouseout="playControl('view_<%=oinfo2.getOcode()%>','none');" /></td>
			-->
		<td width="15"><input type='checkbox' name='select_ocode' value='<%=oinfo2.getOcode()%>'><input type='hidden' name='select_ccode' value='<%=oinfo2.getCcode()%>'></td>
		<td width="195" ><span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis; width:165px;"><%=oinfo2.getOtitle()%></span>
		<span class="sch_time2"><%= play_time %>&nbsp;[<%=oinfo2.getOwdate()%>]</span></td>
		<td width="30"><a href="javascript:checkMedia('<%=oinfo2.getCcode()%>','<%=oinfo2.getOcode()%>')" title="선택"><img src="images/bu_check.gif" alt="선택"/></a></td>
	</tr>
	<tr><td colspan='3' height='1' bgcolor='#dbe2ed'></td></tr>
<%
		}
	}
%>
</form>
	<tr>
		<td colspan="3" align="center">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr align="center">
					<td class="small">
						<!-- 페이징 시작 -->
						<%if(vt2 != null && vt2.size() > 0 && pageBean!= null){
							String jspName = "search_media.jsp";
						%>
							<%@ include file="page_move.jsp" %>
						<%	}	%>
						<!-- 페이징 끝 -->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>