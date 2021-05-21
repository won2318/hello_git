<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ page import="com.hrlee.sqlbean.MediaManager"%>
 
 
<%--
<%
if(!chk_auth(vod_id, vod_level, "v_content")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다.');\n" +
                "window.close();\n" +
                "</script>");
    return;
}
%>
--%>
<%
String ocode = "";
if(request.getParameter("ocode") == null || request.getParameter("ocode").length()<=0 || request.getParameter("ocode").equals("null")) {
	out.println("<script lanauage='javascript'>alert('미디어코드가 없습니다. 다시 선택해주세요.'); history.go(-1); </script>");
	return;
} else
	ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");

String value = "";
if (request.getParameter("value") != null && request.getParameter("value").length() > 0) {
	value = request.getParameter("value").replaceAll("<","").replaceAll(">","");
}

String xy_value = "48";

com.hrlee.sqlbean.MediaManager mgr = com.hrlee.sqlbean.MediaManager.getInstance();
Vector vt = mgr.getOMediaInfo(ocode);			// 주문형미디어 서브정보
com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();

if(vt != null && vt.size()>0){
	try {
		Enumeration e = vt.elements();
		com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
		xy_value = info.getPosi_xy();
		} catch (Exception e) {
		out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.'); history.go(-1); </script>");
		return;
	}
}else{
	out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.'); history.go(-1); </script>");
	return;
}

String img_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/thumbnail/"+ value;  // 이미지파일
 
if (info.getThumbnail_file() != null && info.getThumbnail_file().indexOf(".") > 0) {
	img_url = "/upload/vod_file/"+info.getThumbnail_file(); 
} else {
	img_url = DirectoryNameManager.SILVERLIGHT_SERVERNAME+"/ClientBin/Media/"+info.getSubfolder()+"/thumbnail/"+ value;  // 이미지파일
}
 



%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
	<head>
		<title>관리자페이지</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
		<style style="text/css">
			body { background:#fff;}
		</style>
		
		<script type="text/javascript">
		function do_save(){
			var f = document.frmMedia;
			if (document.getElementById('posi_xy').value == "") {
				alert('위치값을 입력해주세요!');
				return ;
			} else {
				f.submit();	
				parent.$('#lean_overlay').trigger('click');
				//$('#pWrap').load('pop_img_position.jsp');
				//$("#pWrap").html(returnedHtml);
				//$( "#img_position" ).reload(window.location.href + " #img_position" );
				//parent.document.getElementById("img_position").innerHTML.reload;
				document.location.reload();
				//parent.$('#img_position').load(self);
				//parent.close_modal('#img_position');
			} 
		}
		
		function img_view(){
			document.getElementById('img_view').style="margin-left:-"+document.getElementById('posi_xy').value+"%;"
//			alert(document.getElementById('posi_xy').value);
		}
		</script>
	</head>
<body>
	
<div class="pWrap">
<h1>메인화면 영상 대표이미지 설정</h1>
<div class="pContent">
	<div class="img_posi_inner">
		<div class="img_posi">
			<div class="boxF">
				<div class="boxS">
					<div class="boxT">
						<img src="<%=img_url %>" id="img_view"   style="margin-left:-<%=xy_value%>%"/>
					</div>
				</div>
			</div>
			<!--<div id="posi_top"></div>
			<img src="../include/images/5.png" id="posi_bottom" style="margin-left:-49%">-->
		</div>
		<div class="img_posi_text">
			<form name='frmMedia' method='post'  action="proc_img_posion.jsp">
			<input type="hidden" name="ocode" value="<%=ocode %>" />
			<dl>
				<dt><label for="posi_xy">위치값 입력</label></dt>
				<dd><input type="number" size="2" id="posi_xy" name="posi_xy" value="<%=xy_value%>"> % <br/> <strong>0 ~ 95</strong> 사이의 숫자 입력 / 미입력시 <strong>48%(중앙)</strong> 고정 <br/>
				좌측은 0부터 시작이며 95에 가까워질수록 우측 방향으로 이미지 이동
				<div class="but_posi"> 
					<a href="javascript:img_view();">미리<br/>보기</a>
					<a href="javascript:do_save();">저장</a>
				</div>
				</dd>
			</dl>
			<dl>
				<dt>이미지사이즈</dt>
				<dd>현재 사용 중인 썸네일 사이즈와 동일한 비율의 이미지 사이즈인 <br/> <strong>가로 1024px X 세로 576px</strong>로 올려야 이미지가 최적화 됩니다. </dd>
			</dl>
			</form>
		</div>
	</div>
</div>


</div>

</body>
</html>