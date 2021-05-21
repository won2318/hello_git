<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>

<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>

<!DOCTYPE html>
<html lang="ko"> 

<%
	String sub_flag = "S"; // S - ���� ,  E - �̺�Ʈ
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag");
	}
	SubjectManager mgr = SubjectManager.getInstance();
	
	Vector Vt = mgr.getSubjectListDate(sub_flag);

	String sub_idx = "";
	String sub_title = "";
	String sub_start = "";
	String sub_end = "";
	String sub_person = "";
	String sub_name = "";
	String sub_mf = "";
	String sub_tel = "";
	String sub_email = "";
	String sub_etc = "";
//	String sub_flag = "S";
	String sub_user_on = "N";
	
	if (Vt != null && Vt.size() > 0) {
		sub_idx = String.valueOf(Vt.elementAt(0));
		sub_title = String.valueOf(Vt.elementAt(1));
		sub_start = String.valueOf(Vt.elementAt(2));
		sub_end = String.valueOf(Vt.elementAt(3));
		sub_person = String.valueOf(Vt.elementAt(4));
		sub_name = String.valueOf(Vt.elementAt(5));
		sub_mf = String.valueOf(Vt.elementAt(6));
		sub_tel = String.valueOf(Vt.elementAt(7));
		sub_email = String.valueOf(Vt.elementAt(8));
		sub_etc = String.valueOf(Vt.elementAt(9));
		sub_flag = String.valueOf(Vt.elementAt(10));
		sub_user_on = String.valueOf(Vt.elementAt(11));
	}
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>���� iTV</title>
	
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<link href="../include/css/content.css" rel="stylesheet" type="text/css" />
	
<script language="javascript">
	function go_cyberPoll(){
	  var width = 630;
      var height = 650;

	  var top = (screen.availHeight - height) / 2;
      var left = (screen.availWidth - width) / 2;
<%if (sub_user_on.equals("N") || (session.getValue("vod_name") != null && session.getValue("vod_name").toString().length() > 0) ) { %>
	  window.open("/2017/research/research.jsp?sub_flag=<%=sub_flag%>", "<%=sub_flag%>_Poll" , "width=630,height=650,scrollbars=yes,top=50,left=200");
	  self.close();
<%} else { %>
	// �Ǹ�����
	alert("�Ǹ����� �� ���� �����մϴ�!");
	window.open('/include/name_gpin.jsp', 'CbaWindow', 'width=390, height=400, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	self.close();
<%}%>
	}


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

	
	function check_window(flag) {

		var cookie_name = "event";
		if (flag == 'E') {
			cookie_name = "event";
		} else if (flag == 'S') {
			cookie_name = "subject";
		} else if (flag == 'H') {
			cookie_name = "hot7";
		}
 	
		var exp = new Date();
		var oneYearFromNow = exp.getTime() + (24 * 60 * 60 * 1000);
		exp.setTime(oneYearFromNow);
		if (document.getElementById("todayclose").checked==true){
			var sc = setCookie(cookie_name,"true",exp,"/","",0);
		}if (document.getElementById("todayclose").checked==false && document.cookie.indexOf(cookie_name+"=true")>-1){
			var sc = setCookie(cookie_name,"false",exp,"/","",0);
		}
 
	}
	
</script>

</head>
<body>

<div id="pWrapNormal">
	<!-- container::���������� -->

	<div id="pContainerNormal">
		<div id="pContentNormal">
			<h3 class="pTitle"><%=chb.getContent(sub_title)%></h3>
			<div class="pSubject">
				 
				<%=chb.getContent(sub_etc)%>
				<p class="btn3">
				 
					<input type="image" src="../include/images/btn_research.gif" alt="�����ϱ�" onclick="go_cyberPoll();"/>
 
				</p>
			</div>
		</div>
	</div>
	<p class="btn4">
		<input type="checkbox" id="todayclose" onClick="check_window('<%=sub_flag%>')"/> 
		<label for="todayclose">�����Ϸ� ���� ����</label>
		<a class="clse" href="javascript:self.close();">X  �ݱ�</a>
	</p>
	
</div>

</body>
</html>