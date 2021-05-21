 <%@page import="com.vodcaster.utils.TextUtil"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%> 

<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>

<%
	PopupInfoBean qinfo = new PopupInfoBean();

	int seq = 0;
	//int seq = Integer.parseInt((String)(request.getParameter("seq")));
	if (request.getParameter("seq") == null || request.getParameter("seq").length() <1) {
		out.println("<script lanauage='javascript'>alert('팝업코드가 없습니다. 다시 선택해주세요.'); window.close(); </script>");
		return;
	} else {
		if (com.yundara.util.TextUtil.isNumeric(request.getParameter("seq")) == true) {
			seq = Integer.parseInt(request.getParameter("seq"));
		} else {
			out.println("<script lanauage='javascript'>alert('팝업코드가 잘못되었습니다. 다시 선택해주세요.'); window.close(); </script>");
			return;
		}
	}
	String title = "";
	String width = "400";
	String height = "500";
	String content = "";
	String pop_link = "";
	String is_visible = "";
	String img_name = "";
	
	PopupManager mgr = PopupManager.getInstance();
	
	Vector vt = mgr.getPop(seq);
	
	// getPopup()에서 값을 가져와 뿌려주는 메소드
	if (vt != null && vt.size() > 0) {
		
//		seq = Integer.valueOf(seq); // 팝업 순서
		title = String.valueOf(vt.elementAt(1)); // 팝업창 제목
		img_name = String.valueOf(vt.elementAt(9)); // 팝업창 이미지
		if (img_name != null && img_name.length() > 0) {
			img_name = "/upload/popup/"+img_name;
			
		}
//		System.out.println("image ::: "+qinfo.setImg_name(img_name));
//		qinfo.getImg_name(img_name);
		width = String.valueOf(vt.elementAt(4)); // 팝업창 길이
		height = String.valueOf(vt.elementAt(5)); // 팝업창 높이
		content = String.valueOf(vt.elementAt(3)); // 팝업글
		content = chb.getContent(content);
		pop_link = String.valueOf(vt.elementAt(8)); // 팝업 링크
		pop_link = pop_link.replaceAll("&amp;","&");
		is_visible = String.valueOf(vt.elementAt(6));//화면출력
	} else {
		out.println("<script lanauage='javascript'>alert('팝업코드에 해당하는 정보가 없습니다. 다시 선택해주세요.'); window.close(); </script>");
		return;
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	
	<SCRIPT LANGUAGE="JAVASCRIPT">
			var caution = false;

			function setCookie(name, value, expires, path, domain, secure) {
				var curCookie = name + "=" + escape(value) + ((expires) ? "; expires=" + expires.toGMTString() : "") +
				((path) ? "; path=" + path : "") + 	((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "")
				if (!caution || (name + "=" + escape(value)).length <= 4000){
					document.cookie = curCookie
				}else{
					if (confirm("Cookie exceeds 4KB and will be cut!")){
						document.cookie = curCookie
					}
				}
				return true;
			}

			function check_window() {
				
			<%
				if(vt != null && vt.size()>0){
			%>	
					var exp = new Date();
					var oneYearFromNow = exp.getTime() + (24 * 60 * 60 * 1000);
					exp.setTime(oneYearFromNow);
					if (document.getElementById("todayclose").checked==true){
						var sc = setCookie("vodcaster_<%=seq%>","true",exp,"/","",0);
					}if (document.getElementById("todayclose").checked==false && document.cookie.indexOf("vodcaster_<%=seq%>=true")>-1){
						var sc = setCookie("vodcaster_<%=seq%>","false",exp,"/","",0);
					}
					
			<%
				}
			%>
			}
<%if (pop_link != null && pop_link.length()> 0) { %>
			function dolink(){
				window.open("<%=pop_link%>","link","");
			}
			function dolink1(){
				 
					opener.pop_link("<%=pop_link.replaceAll("&amp;", "&")  %>"); 
 
			}
<%}%>			 
			</SCRIPT>
			
</head>
<body>

<div id="pWrapNormal">
	<!-- container::메인컨텐츠 -->
	 
	<div id="pContainerNormal">
		<div id="pContentNormal"
		<%if (pop_link != null && pop_link.startsWith("http") ) { out.println("onclick='dolink();'"); } 
		else {out.println("onclick='dolink1();'");
		}%>>
<%-- 			<h3 class="pTitle"><%=title %></h3> --%>
			<div class="pSubject" style="margin-bottom:5px;width:<%=width%>px; height: <%=height%>px;background:url(<%=img_name %>) no-repeat left top;">
				<div >
				<%=content %>
				</div>
			</div>
		</div>
	</div>
	<p class="btn4">
		<input type="checkbox" id="todayclose" name="todayclose" onClick="check_window()"/> 
		<label for="todayclose" >오늘하루 열지 않음</label>
		<a class="clse" href="javascript:self.close();">X  닫기</a>
	</p>
	
</div>

</body>
</html>