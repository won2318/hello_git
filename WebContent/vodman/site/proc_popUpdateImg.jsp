<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	 /**
	 * @author ������
	 *
	 * @description : �˾� �̹��� �߰�.
	 * date : 2009-10-19
	 */
	 int seq = 0;
	String gubun = "1";
	//int seq = Integer.parseInt((String)(request.getParameter("seq")));
	if (request.getParameter("seq") == null || request.equals("")) {
		out.println("<script lanauage='javascript'>alert('�˾��ڵ尡 �����ϴ�. �ٽ� �������ּ���.'); window.close(); </script>");
	} else {
		if(TextUtil.isNumeric(request.getParameter("seq")) == true){
			try{
				seq = Integer.parseInt((String) (request.getParameter("seq")));
			}catch(Exception e){
				seq = 0;
				out.println("<script lanauage='javascript'>alert('�˾��ڵ尡 �߸��Ǿ����ϴ�. �ٽ� �������ּ���.'); window.close(); </script>");
				return;
			}
			
		}else{
			out.println("<script lanauage='javascript'>alert('�˾��ڵ尡 �߸��Ǿ����ϴ�. �ٽ� �������ּ���.'); window.close(); </script>");
			return;
		}
		if(TextUtil.isNumeric(request.getParameter("gubun")) == true){
			gubun = request.getParameter("gubun");
		}
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<title>�˾����� / �̹����߰�</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
	</head>

<script language="javascript">
<!--
	function limitFile(object) {
		var file_flag = object.name;
		var file_name = object.value;
		
		document.getElementById('fileFrame').src = "file_check.jsp?file_flag="+file_flag+"&file_name=" + file_name;
	}
	
	function clearFile(file_flag) {
		document.getElementById(file_flag).outerHTML = document.getElementById(file_flag).outerHTML;
	}

	function chkForm(form) {
	
		if(form.img_name.value == "") {
			alert("�̹����� �������ּ���.");
			form.img_name.focus();
			return;
		}
	
		form.submit();
	}


//-->
</script>
<body>
<div id="research">
	<h3><img src="/vodman/include/images/a_img_title.gif" alt="�˾����� / �̹����߰�"/></h3>
	<div id="research_top"></div>
	<div id="research_cen">
		<div id="img_con">
			<form name='frmImage' method='post' action="proc_popAddImg.jsp?seq=<%=seq%>" enctype="multipart/form-data">
			<input type="hidden" name="seq" value="<%=seq %>">
			<input type="hidden" name="gubun" value="<%=gubun %>">
			<table cellspacing="0" class="reserch" summary="�˾����� / �̹����߰�">
				<caption>�˾����� / �̹����߰�</caption>
				<colgroup>
					<col width="20%"/>
					<col/>
				</colgroup>
				<tbody class="font_117">
					<th><strong>�̹���</strong></th>
					<td class="pa_left"><input type="file" id="img_name" name="img_name" class="sec01" size="30" value="" onchange="javascript:limitFile(this);" /></td></td>
				</tbody>
			</table>
			</form>
		</div>
	</div>
	<div id="research_bot"></div>
	<div class="but01">
		<a href="javascript:chkForm(document.frmImage);"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
		<a href="javascript:window.close();"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
	</div>		
</div>
<iframe id="fileFrame" name="fileFrame" src="#" width="0" height="0" cellpadding="0" cellspacing="0" border="0"></iframe>
</body>
</html>
