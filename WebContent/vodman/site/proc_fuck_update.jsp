<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	/**
	 * @author ����� 
	 *
	 * @description : �弳 ���� ���� 
	 * date : 2012-05-04
	 */
	 
//request.setCharacterEncoding("EUC-KR");
if(!chk_auth(vod_id, vod_level, "v_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>

<%
	FucksInfoManager Buseo = FucksInfoManager.getInstance();

	String mcode = request.getParameter("mcode");
	if(mcode == null || mcode.length() <= 0 || mcode.equals("null")) {
		mcode = "0109";
	}

    try {

	int result = Buseo.updateFuckInfo(request);

	if(result >= 0){

			//out.println("<script>");
			//out.println("location.href='mng_fuckList.jsp?mcode="+mcode+"';");
			//out.println("</script>");
			%>
			 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
			 <html>
			 <head>
			<script language="javascript">
			<!--	 
					//var frag = document.createDocumentFragment();
					
					
					if ( window.addEventListener ) { // W3C DOM ���� ������ 
						window.addEventListener("load", start, false); 
					} else if ( window.attachEvent ) { // W3C DO M ���� ������ ��(ex:MSDOM ���� ������ IE) 
						window.attachEvent("onload", start); 
					} else { 
						window.onload = start; 
					} 


					function start() 
					{ 
						alert('�����Ǿ����ϴ�.');
						var anchor = document.createElement("a");
						if (!anchor.click) { //Providing a logic for Non IE
							location.href = 'mng_fuckList.jsp?mcode=<%=mcode%>';
						 
						}
						anchor.setAttribute("href", 'mng_fuckList.jsp?mcode=<%=mcode%>');
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
            out.println("alert('���� ���� �� ������ �߻��߽��ϴ�.')");
            out.println("history.go(-1)");
            out.println("</SCRIPT>");
        }

    } catch(Exception e){
        System.out.println(e);
    }
%>
