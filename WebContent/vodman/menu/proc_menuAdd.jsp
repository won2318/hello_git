<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*,  com.hrlee.sqlbean.*, com.yundara.util.*,java.text.SimpleDateFormat,java.io.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "cate_write")) {
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
	 * @description : 메뉴정보 입력
	 * date : 2009-10-20
	 */

	 request.setCharacterEncoding("EUC-KR");

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0201";
	}

	MenuManager mgr = MenuManager.getInstance();
	int result = mgr.createMenu(request);

	if(result >= 0){
			
		//out.println("<script language='javascript'>alert('메뉴가 등록되었습니다.');location.href='mng_menuList.jsp?mcode="+mcode+"';</script>");
		%>
		 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		 <html>
		 <head>
		<script language="javascript">
		<!--	 
				//var frag = document.createDocumentFragment();
				
				
				if ( window.addEventListener ) { // W3C DOM 지원 브라우저 
					window.addEventListener("load", start, false); 
				} else if ( window.attachEvent ) { // W3C DO M 지원 브라우저 외(ex:MSDOM 지원 브라우저 IE) 
					window.attachEvent("onload", start); 
				} else { 
					window.onload = start; 
				} 


				function start() 
				{ 
					alert('메뉴가 등록되었습니다.');
					var anchor = document.createElement("a");
					if (!anchor.click) { //Providing a logic for Non IE
						location.href = 'mng_menuList.jsp?mcode=<%=mcode%>';
					}
					anchor.setAttribute("href", 'mng_menuList.jsp?mcode=<%=mcode%>');
					anchor.style.display = "none";
					var aa = document.getElementById('aa');
					if( aa ){
						aa.appendChild(anchor);
						anchor.click();
					}			
				} 
				//-->
		</script>
		</head>
		<body>
		<div id="aa"></div>
		</body>
		</html>
		<%
	}
	else{
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리중 오류가 발생했습니다. 이전페이지로 이동합니다.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");
	}

%>