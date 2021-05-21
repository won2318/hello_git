<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*,java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*, com.vodcaster.utils.*"%>
<%@ include file = "/vodman/include/auth_pop.jsp"%>
<jsp:useBean id="BoardListSQLBean" class="com.vodcaster.sqlbean.BoardListSQLBean"/>
<%
//	String image =  CharacterSet.toKorean( request.getParameter("image") );
	int board_id  = 0;
	int list_id  = 0;
	int img_num = 0;
	try{
		board_id  = Integer.parseInt(request.getParameter("board_id") );
	}catch(Exception e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			out.println("window.close();");
			out.println("</SCRIPT>");
		   return;
	}
	try{
		list_id  = Integer.parseInt(request.getParameter("list_id") );
	}catch(Exception e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			out.println("window.close();");
			out.println("</SCRIPT>");
		   return;
	}
	
	try{
		img_num  = Integer.parseInt(request.getParameter("img_num") );
	}catch(Exception e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			out.println("window.close();");
			out.println("</SCRIPT>");
		   return;
	}
	
	
	Vector v_bl = null;
	String title_4 = "";
	String content_5="";
	String html_15= "";
	String link_9 = "";
	String attach_7 = "";
	String img_8 = "";
	String email_6="";
	String name_3="";
	String open_22 = "";
	String img_desc_8_19 = "";
	String ip="";
	String list_date="";
	
	String img_17 = "";
	String img_desc_17_20 = "";
	String img_18 = "";
	String img_desc_18_21 = "";
	
	try{
		v_bl = BoardListSQLBean.getOnlyBoardList(board_id,list_id);
		if(v_bl != null && v_bl.size()>0)
		{
			title_4=String.valueOf(v_bl.elementAt(4));
			ip=String.valueOf(v_bl.elementAt(39));
			//name_3=String.valueOf(v_bl.elementAt(40));
			name_3=String.valueOf(v_bl.elementAt(3));
			email_6=String.valueOf(v_bl.elementAt(6));
			open_22=String.valueOf(v_bl.elementAt(22));
			content_5=String.valueOf(v_bl.elementAt(5));
			html_15=String.valueOf(v_bl.elementAt(15));
			link_9 = String.valueOf(v_bl.elementAt(9));
			attach_7 = String.valueOf(v_bl.elementAt(7));
			img_8 = String.valueOf(v_bl.elementAt(8));
			img_desc_8_19 =String.valueOf( v_bl.elementAt(19));
			list_date = String.valueOf( v_bl.elementAt(16)) ;
			if(list_date != null && list_date.length()>19){
				list_date = list_date.substring(0,19);
			}
			
			img_17 = String.valueOf(v_bl.elementAt(17));
			img_desc_17_20 =String.valueOf( v_bl.elementAt(20));
			
			img_18 = String.valueOf(v_bl.elementAt(18));
			img_desc_18_21 =String.valueOf( v_bl.elementAt(21));
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			out.println("window.close();");
			out.println("</SCRIPT>");
		}
		
	}catch(NullPointerException e){
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		out.println("window.close();");
		out.println("</SCRIPT>");
	}
	
	
		
	String imgFileName =  "";
	if(img_num == 0){
		imgFileName = img_8;
	}else if(img_num == 2){
		imgFileName = img_17;
	}else if(img_num == 3){
		imgFileName = img_18;
	}else{
		int icount = 3;
		int iOk = 0;
		if(v_bl != null && v_bl.size()>0){
			for(int i=25;i<25+8;i++)
			{
				icount++;
				if(v_bl != null && v_bl.size()>0 && String.valueOf( v_bl.elementAt(i)).indexOf(".") != -1)
				{
										String imgFileNameT = (String)v_bl.elementAt(i);
										imgFileNameT = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
										imgFileNameT = "/upload/board_list/"+imgFileNameT.replace("+","%20");
										 
										DirectoryNameManager Dmanager = new DirectoryNameManager();
										File file = new File(Dmanager.VODROOT + imgFileNameT);
										if(!file.exists()) {
											imgFileNameT = "/vodman/include/images/no_img01.gif";
											iOk = 0;
										}
										else{
											imgFileName = (String)v_bl.elementAt(i);
											iOk = 1;
										}
				}
				if(icount == img_num){
					break;
				}
			}
			if(iOk ==0){
				//이미지가 없음
			}else{
				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				out.println("alert('처리 중 오류가 발생하였습니다.')");
				out.println("window.close();");
				out.println("</SCRIPT>");
			}
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			out.println("window.close();");
			out.println("</SCRIPT>");
		}
	}

	imgFileName = java.net.URLEncoder.encode(imgFileName, "EUC-KR");
	 imgFileName = "/upload/board_list/"+imgFileName.replace("+","%20");
	 
	DirectoryNameManager Dmanager = new DirectoryNameManager();
	File file = new File(Dmanager.VODROOT + imgFileName);
	//out.println(Dmanager.VODROOT + imgFileName);
	if(!file.exists()) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		out.println("window.close();");
		out.println("</SCRIPT>");
	}
	
%>
<html>
<head>
<title>이미지보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<script language="javascript">
<!--

function resize_Window(obj)
{
	full_image = new Image();
    full_image["src"] = obj.src;
    img_width = full_image["width"];
	img_height = full_image["height"];

	if(img_width <= 800 && img_height <=600) {

		if( navigator.appName.indexOf("Microsoft") > -1 ) // IE
		{
		    if( navigator.appVersion.indexOf("MSIE 6") > -1) { // IE6 
		    	window.resizeTo(img_width+10,img_height+41);

		     } else {
		    	 window.resizeTo(img_width+10,img_height+81);
		    }
		} else {
			window.resizeTo(img_width+10,img_height+81);
		}
	}

}
-->
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" oncontextmenu="return false"
ondragstart="return false" on-selectstart="return false">
<title>이미지보기</title>
<a herf="#" onClick="window.close();"><img name='image' id="image" src="img_.jsp?list_id=<%=list_id%>" onload="javascript:resize_Window(this);" /></a>
</body>
</html>
