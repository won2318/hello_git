<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "cate_del")) {
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
	 * @description : 메뉴삭제
	 * date : 2009-10-20
	 */

	String muid = "";

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0201";
	}   

	if(request.getParameter("muid") != null) {

		muid = request.getParameter("muid").trim();

		MenuManager mgr = MenuManager.getInstance();

       

		Vector vr = null;

		vr = mgr.deleteMenu(muid);

		if(vr != null && vr.size() >= 0){
			//out.println("<SCRIPT LANGUAGE='JavaScript'>");
			//out.println("alert('메뉴가 삭제되었습니다.');");
			//out.println("location.href='mng_menuList.jsp?mcode="+mcode+"';");
			//out.println("</SCRIPT>");
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
					alert('메뉴가 삭제되었습니다.');
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
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('하위분류가 있을경우 삭제할 수 없습니다. 하위분류부터 삭제해주세요.')");
			out.println("history.go(-1)");
			out.println("</SCRIPT>");
		}
	
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('메뉴 정보가 없습니다. 다시 선택해주세요.')");
		out.println("history.go(-1)");
		out.println("</SCRIPT>");

	}

%>