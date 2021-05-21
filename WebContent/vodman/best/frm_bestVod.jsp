<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.hrlee.silver.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "be_write")) {
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
	 * @description : 베스트 VOD정보 입력/vodPlayer.
	 * date : 2009-10-19
	 */
	 
	String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");

	if (flag != null && flag.length() > 0) {
		flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
	} else {
		flag = "A";
	}
 
	
	String mcode = request.getParameter("mcode");
	if(mcode != null && mcode.length() > 0 && !mcode.equals("null")) {
		mcode = request.getParameter("mcode").replaceAll("<","").replaceAll(">","");		
	} else {
		mcode = "0201";
	}
	
	BestWeekManager mgr = BestWeekManager.getInstance();
	Vector vt = mgr.getBestWeekInfo(flag);
   // BestWeekInfoBean info = new BestWeekInfoBean();
  // out.println(vt);
    com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
	if(vt != null && vt.size()>0){
		try {
			// infoBean에 수정할 데이타 대입
			Enumeration e = vt.elements();
			//com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
			com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)e.nextElement());
	
		} catch (Exception e) {
			System.out.println(e);
		}
	}
    String title = oinfo.getTitle();
    int strlen = 20;
    if(title.length() > strlen) {
        title = title.substring(0,strlen-2) + "...";
    }

	String ocode = request.getParameter("ocode");
	if(ocode == null || ocode.length() == 0 || ocode.equals("null")) {
		ocode = String.valueOf(oinfo.getOcode());
	}

//     Vector vo = com.hrlee.sqlbean.MediaManager.getInstance().getOMediaInfo(ocode);
//     com.hrlee.silver.OrderMediaInfoBean oinfo = new com.hrlee.silver.OrderMediaInfoBean();
//     if(vo != null && vo.size()>0){
// 	    try {
// 	        Enumeration e2 = vo.elements();
// 	        com.yundara.beans.BeanUtils.fill(oinfo, (Hashtable)e2.nextElement());
// 	    }catch(Exception e) {
// 	    	System.out.println(e);
// 	    }
//     }

	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<title>관리자페이지</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />

<script language="javascript">
<!--
	function chkForm(form) {
		if(form.title.value == "") {
			alert("제목을 입력해주세요.");
			form.title.focus();
			return;
		}
		if(form.ocode.value == "") {
			alert("내용을 선택해주세요.");
			form.ocode.focus();
			return;
		}
		if(confirm("저장하시겠습니까?")) {
			form.submit();
		}
	}
//-->
</script>
	</head>
<body style="background-image:none">
<form name='frmMedia' method='post' action="proc_bestweekAdd.jsp">
	<input type="hidden" name="filename" value="<%=oinfo.getFilename()%>" />
	<input type="hidden" name="mcode" value="<%=mcode%>" />
	<input type="hidden" name="ocode" value="<%=ocode%>" />
	<input type="hidden" name="flag" value="<%=flag%>" />
	<input type="hidden" name="isview" value="Y" />
	<table cellspacing="0" class="main_view" summary="추천VOD">
		<caption>추천VOD</caption>
		<colgroup>
			<col width="100px"/>
			<col/>
		</colgroup>
		<tbody class="bor_top03">
			<tr class="height_25">
				<th class="bor_bottom01 back_f7"><strong>제목</strong></th>
				<td class="bor_bottom01 pa_left">
				<input type="text" name="title" maxlength="30" value="<%=oinfo.getTitle()%>" class="input01" style="width:350px;" readOnly="false"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding: 10px;" id="player">
<%
	if(vt != null && vt.size()>0) {
%>
<%-- 					<iframe id="bestVod" name="bestVod" src="/silverPlayer_admin.jsp?ocode=<%=ocode%>&height=254&width=392" scrolling='no' width="430" height="370" marginwidth=0 frameborder=0 framespacing=0 ></iframe> --%>
						<iframe title="동영상 재생 창" id="bestVod" name="bestVod" src="/videoJs/jsPlayer_2017.jsp?ocode=<%=ocode%>&type=bestWeek" scrolling="no" width="392" height="254" marginwidth="0" frameborder="0" framespacing="0" allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true"></iframe>
					
<% } else { %>
					<img src="/vodman/include/images/main_player_bg.jpg" alt="메인화면관리"/>
<% } %>  
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="but01">
						<a href="javascript:chkForm(document.frmMedia);"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					</div>	
				</td>
			</tr>
		</tbody>
	</table>
</form>
</body>
</html>