<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*, java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*,com.vodcaster.utils.TextUtil"%>
<%-- jstl --%>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean" />
<%
	/**
	 * @author 박종성
	 *
	 * @description : 팝업 미리 보기.
	 * date : 2009-10-19
	 */
	 
	PopupInfoBean qinfo = new PopupInfoBean();

	int seq = 0;
	//int seq = Integer.parseInt((String)(request.getParameter("seq")));
	if (request.getParameter("seq") == null || request.equals("")) {
		out.println("<script lanauage='javascript'>alert('팝업코드가 없습니다. 다시 선택해주세요.'); window.close(); </script>");
	} else {
		if (com.yundara.util.TextUtil.isNumeric(request.getParameter("seq")) == true) {
			try{
				seq = Integer.parseInt(request.getParameter("seq"));
			}catch(Exception e){
				seq = 0;
			}
			
		} else {
			out.println("<script lanauage='javascript'>alert('팝업코드가 잘못되었습니다. 다시 선택해주세요.'); window.close(); </script>");
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
//		System.out.println("image ::: "+qinfo.setImg_name(img_name));
//		qinfo.getImg_name(img_name);
		if (String.valueOf(vt.elementAt(4)) != null && String.valueOf(vt.elementAt(4)).length() > 0) {
		width = String.valueOf(vt.elementAt(4)); // 팝업창 길이
		}
		if (String.valueOf(vt.elementAt(5)) != null && String.valueOf(vt.elementAt(5)).length() > 0) {
		height = String.valueOf(vt.elementAt(5)); // 팝업창 높이
		}
		content = String.valueOf(vt.elementAt(3)); // 팝업글
		content = chb.getContent(content);
		pop_link = String.valueOf(vt.elementAt(8)); // 팝업 링크
		is_visible = String.valueOf(vt.elementAt(6));//화면출력
	} else {
		out.println("<script lanauage='javascript'>alert('팝업코드에 해당하는 정보가 없습니다. 다시 선택해주세요.'); window.close(); </script>");
	}
	com.vodcaster.sqlbean.DirectoryNameManager DirectoryNameManager = new com.vodcaster.sqlbean.DirectoryNameManager();
	img_name = "/upload/popup/"+img_name;
	File file = new File(DirectoryNameManager.VODROOT+img_name);
	if(!file.exists()) {
		img_name = "";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<title><%=title%></title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
	<script language="javascript">
	<!--
		function go_link(){
			window.open('<%=pop_link%>','','');
		}
	//-->
	</script>
	</head>
<body id="popup_view_bg">
<table cellspacing="0" class="popup_view" summary="팝업창"  height="<%=Integer.parseInt(height)-45%>">
		<caption>팝업창</caption>
		<colgroup>
			<col/>
			<col/>
		</colgroup>
		<tbody class="font_127">
			<tr <%if(pop_link != null && pop_link.length() > 0){%> style="cursor:pointer" onclick="go_link();"<%}%>>
				<td colspan="2">
					<div id="popup_view">
					<%if(img_name != null && img_name.length() > 0 && img_name.indexOf(".") > -1) {%>
						<img src="<%=img_name%>" width="<%=Integer.parseInt(width)-30%>" height="<%=Integer.parseInt(height)-45%>" alt="이미지배경"/>
					<%}%>
						<div class="popup_con" style="width:<%=Integer.parseInt(width)-50%>px;height:<%=Integer.parseInt(height)-70%>px;overflow-x:hidden;overflow:scroll;"><%=content%></div>
					</div>	
				</td>
			</tr>
			<tr valign="bottom">
				<th>&nbsp;</th>
				<td align="right"><a href="javascript:window.close();" title="닫기"><img src="/vodman/include/images/but_close2.gif" alt="닫기"/></a></td>
			</tr>
		</tbody>
	</table>
</body>
</html>