<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>

<%
String board_id = request.getParameter("board_id");
String list_id = request.getParameter("list_id");
String type = request.getParameter("type"); 
if (request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 board_id = request.getParameter("board_id");
}
if (request.getParameter("list_id") != null && request.getParameter("list_id").length() > 0) {
	list_id = request.getParameter("list_id");
}
if (request.getParameter("type") != null && request.getParameter("type").length() > 0) {
	type = request.getParameter("type");
}

// out.println("type:"+type);
// out.println("board_id:"+board_id);
// out.println("list_id:"+list_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>���� iTV</title>
	<link href="/2013/include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/2013/include/js/jquery.min.js"></script>
	<script type="text/javascript" src="/2013/include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" >
	 function name_check(){
		  
		 window.open("/include/login_test.jsp?board_id=<%=board_id%>&list_id=<%=list_id%>&type=<%=type%>", "name_check", "width=800, height=700, toolbar=no,location=no,status=yes,menubar=no,scrollbars=no,resizable=no" );
	 }
	 
	 function gpin_check(){
		 
	 }
	</script>
</head>

<body>

<div id="pWrapSmall">
	<!-- container::���������� -->
	<div id="pLogoSmall">
<!-- 		<span class="close"><a href="javascript:$.colorbox.close();"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/></a></span> -->
	</div>
	<div id="pContainerSmall">
		<div id="pContentSmall">
			<h3 class="pTitle">���������</h3>
			<div class="pSubject">
				<span class="nameInfo">���� �����Ͻ� �޴��� �̿��� �Ǹ������� �ʿ��մϴ�.<br/>��ȸ�ϴ� ���������� �����ϰ� ��ȣ�Ǹ� �̸� ���� ���� ������ ����� ���� ������ �˷��帳�ϴ�.</span>				
				<ul class="namecheck">
				<li>
					<a href="javascript:name_check();">
					<strong>�Ǹ�����</strong>
					<span>
						�ѱ��ſ�������(��)���� �����ϴ� �Ǹ�Ȯ�μ��񽺸� �̿��ؼ� ���� �����ž� �մϴ�. 
					</span>
					</a>
				</li>
				<li>
					<a href="javascript:gpin_check();">
					<strong>����������</strong>
					<span>
						���� ������(I-PIN)�� ���������ο��� �ְ��ϴ� �ֹε�Ϲ�ȣ ��ü �������� ȸ������ �ֹε�Ϲ�ȣ ��� �ĺ� ���̵� ���������η� ���� �߱޹޾� ����Ȯ���� �ϴ� �����Դϴ�. 
					</span>
					</a>
				</li>
				</ul>
				
			</div>
		</div>
	</div>
	
	
</div>



</body>
</html>