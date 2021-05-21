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

<%
LiveManager lMgr = LiveManager.getInstance();
String play_btn = "";
String live_popup = "";
Vector v_onair = null;
 try {
 // rcode, rtitle, rcontents, rbcst_time, ralias, 
 // rstart_time, rend_time, rflag, rstatus, rwdate, 
 // rhit, rlevel,rfilename, rid, rimagefile,
 // property_id, openflag,group_id, del_flag, ocode, 
 // otitle, mobile_sream, inoutflag, org_rfilename 
  	      v_onair =  lMgr.getLive();
 
 	      if(v_onair != null && v_onair.size() > 0) {
				play_btn = "live_view('"+String.valueOf(v_onair.elementAt(4))+"&rcode=" +String.valueOf(v_onair.elementAt(0))+"');";
 	      }  else {
 	    		out.println("<script type='text/javascript'>");
 	    		out.println("alert('정보가 올바르지 않습니다. 창을 닫습니다.')");
 	    		out.println("self.close();");
 	    		out.println("</SCRIPT>");
 	      }
	  }catch(Exception e) {}
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	
	<script language="JavaScript" type="text/JavaScript">
		<!--
 
		function live_open(){
			window.open('/2017/live/live_player_pop.jsp','live_player', 'width=650, height=900, scrollbars=yes, toolbars=no');
			self.close();
		}
			
			
		function closeWnd()
		{
			window.opener = "nothing";
			window.open('', '_parent', '');
			window.close();

		}
		//-->
	</script>
		
		
</head>
<body>

<div id="pWrapNormal">
	<!-- container::메인컨텐츠 -->
 
	<div id="pContainerNormal">
		<div id="pContentNormal">
		<% if(v_onair != null && v_onair.size() > 0) { %>
			<h3 class="pTitle"><%=String.valueOf(v_onair.elementAt(1))%></h3>
			<div class="pSubject">
				<%=chb.getContent(String.valueOf(v_onair.elementAt(2)), "false")%>
				<p class="btn3"> 
					<a href="javascript:live_open();">
					<img src="../include/images/btn_live_view.gif" alt="시청하기" border="0"/>
				</a> 	 
				</p>
			</div>
		<%} %>
		</div>
	</div>
	<p class="btn4">
		<a class="clse" href="javascript:self.close();">X  닫기</a>
	</p>
	
</div>

</body>
</html>