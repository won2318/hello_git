 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
 
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<%@ include file = "/include/chkLogin.jsp"%>
 <%
 request.setCharacterEncoding("EUC-KR");
String ccode ="";
 
int board_id = 0;  // �������� �Խ���
 
java.util.Date day = new java.util.Date();
SimpleDateFormat sdf;
sdf = new SimpleDateFormat("yyyyMMddHHss");

String temp_date = sdf.format(day);

int    yy    = Integer.parseInt(temp_date.substring(0,4));
int    mm    = Integer.parseInt(temp_date.substring(4,6));
int    dd    = Integer.parseInt(temp_date.substring(6,8));
int    check = (yy+mm+dd) * dd;

MediaManager mgr = MediaManager.getInstance();

%>

 <%@ include file = "../include/html_head.jsp"%>
   
<!-- 	<div id="snb"> -->
<!-- 		<div class="topmenu"> -->
<!-- 			<div class="major"> -->
<!-- 				<span class="m1"><a href="#" class="visible">��ü</a> -->
<!-- 					<div class="sub">����޴�����1<br/>����޴�����1<br/></div> -->
<!-- 				</span> -->
<!-- 				<span class="m2"><a href="#">�ֿ䴺��</a> -->
<!-- 					<div class="sub">����޴�����2</div> -->
<!-- 				</span> -->
<!-- 				<span class="m3"><a href="#">��Ŭ������</a> -->
<!-- 					<div class="sub">����޴�����3</div> -->
<!-- 				</span> -->
<!-- 				<span class="m4"><a href="#">�̴���HOT7</a> -->
<!-- 					<div class="sub">����޴�����4</div> -->
<!-- 				</span> -->
<!-- 				<span class="m5"><a href="#">��������ȸ</a> -->
<!-- 					<div class="sub">����޴�����5</div> -->
<!-- 				</span> -->
<!-- 				<span class="m6"><a href="#">��мӼ���</a> -->
<!-- 					<div class="sub">����޴�����6</div> -->
<!-- 				</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="subTitle">���ٱ����� ������//����޴�����1<br/>����޴�����1<br/></div> -->
<!-- 	</div> -->
	
	<!-- container::���������� --><!-- containerS::���������� -->
	<div id="containerS">
		<div id="content">
			<div class="sectionS"> 
			 <iframe title="���ǹ��" id="musiconair" name="musiconair" src="http://player.musiccodi.com/player/webplayer/hsb/player_sub.jsp?UID=su0001&CODE=<%=check%>" scrolling="no" width="690" height='1250'  marginwidth="0" frameborder="0" framespacing="0" allowTransparency="true"></iframe>
			</div>			
		</div>

		<%@ include file = "../include/right_menu.jsp"%>
		
	</div>
 <%@ include file = "../include/html_foot.jsp"%>
 