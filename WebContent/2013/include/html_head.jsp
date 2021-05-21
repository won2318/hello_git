<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>    
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<jsp:useBean id="contactLog" class="com.vodcaster.sqlbean.WebLogManager" />
 
 <%
 
 String muid ="";
 if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && (request.getRequestURI().indexOf("main.jsp")> -1  || request.getRequestURI().indexOf("main_link.jsp")> -1) ) {
	 muid = "main"; 
	 contact.setValue(request.getRemoteAddr(),"guest", "W");  //  ���� ī��Ʈ
 } else if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0) {
	 muid = request.getParameter("ccode") ;
 }else if(request.getParameter("board_id") != null && request.getParameter("board_id").length() > 0) {
	 muid = "B_"+request.getParameter("board_id") ;
 }  else {
	 muid = "etc";
 }
 
contactLog.setStatVisitInfo(request);

contactMenu.setValueMenu(request.getRemoteAddr(),"guest", "W", muid);  // ���������� �޴� ī��Ʈ
contact.setPage_cnn_cnt("W"); // ������ ���� ī��Ʈ ����
 
%>
<%
LiveManager lMgr = LiveManager.getInstance();
String channel = "";
String stream = "";
String live_title ="";
String live_rcontents ="";
String live_popup = "";
String live_rcode ="";
Vector live_v = null;
try {
 // rcode, rtitle, rcontents, rbcst_time, ralias, 
  // rstart_time, rend_time, rflag, rstatus, rwdate, 
  // rhit, rlevel,rfilename, rid, rimagefile,
  // property_id, openflag,group_id, del_flag, ocode, 
  // otitle, mobile_sream, inoutflag, org_rfilename 
  
    live_v = lMgr.getLive(); 


  if(live_v != null && live_v.size() > 0) {

		live_popup = "window.open('/2013/info/live_info.jsp','live_comment', 'width=400, height=300, scrollbars=no, toolbars=no');";
		live_rcode = String.valueOf(live_v.elementAt(0)); 
		live_title = String.valueOf(live_v.elementAt(1)); 
		live_rcontents  = String.valueOf(live_v.elementAt(2)); 
		String[] data= null;
		 
		data=String.valueOf(live_v.elementAt(4)).split("/");

		if(data.length > 2){
			channel = data[1];
			stream = data[2];
		}
		
  } 
}catch(Exception e) {}

 
 
String temp_reqURL=request.getRequestURL().toString();
String temp_queryString = request.getQueryString();

if(temp_queryString == null || temp_queryString.equals("") || temp_queryString.equals("null")) temp_queryString = "";
if (temp_reqURL != null && temp_reqURL.length() > 0 && temp_reqURL.contains("tv.suwon.ne.kr")) {
	temp_reqURL = temp_reqURL.replaceAll("tv.suwon.ne.kr","tv.suwon.go.kr");
	if (temp_queryString != null && temp_queryString.length() > 0) {
	
		temp_reqURL = temp_reqURL+"?"+temp_queryString;
	} 
	 
	out.println("<script>location.href = '"+temp_reqURL+"';</script>");
}
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="description" content="���� iTV, �޸ս�Ƽ ����, ����� �ݰ����ϴ�, ���ͳ� ���" />
	<meta name="keywords" content="���� iTV, ������, ���ͳݹ���, �޸ս�Ƽ ����, ����� �ݰ����ϴ�" />
	
	
	<title>���� iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/popup_2015.js" ></script>
	<% 	if (request.getRequestURI() != null && request.getRequestURI().length()  >0 && ( request.getRequestURI().indexOf("main.jsp")> -1 || request.getRequestURI().indexOf("main_link.jsp")> -1 ) ) {  %>	
	<script type="text/javascript" src="../include/js/popup.js"></script>
	
	<script type="text/javascript" src="../include/js/jquery.carouFredSel-6.2.0-packed.js"></script>
	<script type="text/javascript" src="../include/js/main.js"></script>
	<%}%>
	<script type="text/javascript" src="../include/js/tab.js"></script>
	
	<script type="text/javascript" src="../include/js/jquery.flexslider-min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../include/js/jquery.masonry.min.js"></script>
	<script type="text/javascript" src="../include/js/common.js"></script>  
<!--[if lte IE 7]> 
	<script type="text/javascript" src="../include/js/script2.js"></script>
 <![endif]-->   
<!--[if (gte IE 8)|!(IE)]><!-->  
	<script type="text/javascript" src="../include/js/script.js"></script>
<!--<![endif]-->	

<script type="text/javascript">
<!--
 
function AddFavorite(obj){
 
  var browser = navigator.userAgent.toLowerCase();
  //Mozilla, FireFox, Netscape
  if(window.sidebar) {
   		window.sidebar.addPanel('http://tv.suwon.go.kr','����iTV_������ ���ͳ� ���','');
  }else if(window.external){
	    if(browser.indexOf('chrome') == -1){   //IE
	     window.external.AddFavorite('http://tv.suwon.go.kr','����iTV_������ ���ͳ� ���');
	    }else{
	    alert('ctrl + D �Ǵ� command + D�� ���� ���ã�� �߰��ϼ��� ');  //chrome
	    }
   }else if(window.opera && window.print){    //opera
   		return true;
   }else  if(browser.indexOf('konqueror') != -1){  //konqueror
   		 alert('ctrl + B�� ���� ���ã�� �߰��ϼ��� ');
   }else  if(browser.indexOf('webkit') != -1){  //safari
      		alert('ctrl + B�� ���� ���ã�� �߰��ϼ��� ');
   }else{
    		alert('���� ������ ���ã�� �����ȵ� ');
   }
} 

setTimeout('live_check_timer()',10000);  // ����� äũ

function live_check_timer(){
	 
	 $.get("/2013/live/live_check_timer.jsp",  function(data) {
			 if (data != "") {
				 $("#live_check_img").html(data); 
			 } 
		 },   "text" ); 
}

function live_open(){
	window.open('/2013/live/live_player_pop.jsp','live_player', 'width=650, height=900, scrollbars=yes, toolbars=no');
	
} 

//-->

</script>   
	
</head>

<body>
<!-- accessibility::skip -->
<div id="accessibility">
	<ul>
	<li><a href="#lnb" accesskey="1">���θ޴��ٷΰ���</a></li>
	<li><a href="#body" accesskey="2">�������ٷΰ���</a></li>
	</ul>
</div> 
<!-- //accessibility::skip -->
<div id="body-wrap">
	<div id="head">
		<div id="header">
			<div id="top-nav"> 
				<h1><a href="/"><img src="../include/images/main/logo.png" alt="����iTV"/></a></h1>
				<div class="gnb_area">
					<ul>
					<li><a href="/">Ȩ</a></li>
					<li><a href="javascript:AddFavorite(this);">���ã��</a></li>
					<li><a href="/2013/info/search.jsp">��ü���α׷�</a></li>
					<% if (vod_name != null && vod_name.length() > 0) { %><li><a href="/include/logout.jsp">�α׾ƿ�</a></li><%} %>
					<li class="search">
						<div class="gnb_search">
							<form name="head_search" method="post" action="/2013/info/search.jsp">
							<fieldset>
							<legend>�˻�</legend>
							<span class="gnb_search_in">
							<input type="hidden" name="search_ccode" value="" />
							<input type="hidden" name="searchField" value="title" />
							<input type="text" title="�˻���" name="searchString" id="head_searchstring" value="������� ������ �ִٸ�?" class="input_text" onclick="javascript:document.getElementById('head_searchstring').value=''; "/> 
							</span><input type="image" src="../include/images/main/btn_top_search.gif" alt="�˻�" class="img"/>
							</fieldset>
							</form>
						</div><!-- //gnb_search -->
					</li>
					<li class="sns">
						<a href="https://twitter.com/suwonitv" target="_blank" title="��â���� ����"><img src="../include/images/main/twitter.png" alt="Ʈ����"/></a>
						<a href="http://www.youtube.com/user/suwonloves" target="_blank" title="��â���� ����"><img src="../include/images/main/youtube.png" alt="������"/></a>
						<a href="http://blog.naver.com/suwonitv/" target="_blank" title="��â���� ����"><img src="../include/images/main/blog.png" alt="���̹� ��α�"/></a>
					</li>
					</ul>
				</div><!-- //gnb_area -->

				<nav id="lnb">
					<div class="lnb_wrap">
						<!-- menu::���ø޴� -->
						<div class="gnb" id="">			
							<ul>
							<li class="s1 ">
							<a href="/2013/video/video_list.jsp?ccode=001000000000" class="<%=ccode != null && ccode.startsWith("001") && !ccode.startsWith("001004")?"visible":""%>">Hot �̽�<%if (contactMenu.menu_content("001000000000") > 0) out.print("<span class='new1'>new</span>");%></a>
								<ul>
								<li><a href="/2013/video/video_list.jsp?ccode=001001000000">NEWS<%if (contactMenu.menu_content("001001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								 
								<li><a href="/2013/video/video_list.jsp?ccode=001003000000">�ùΰ��� Best5<%if (contactMenu.menu_content("001003000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<!--<li><a href="/2013/video/video_list.jsp?ccode=001006000000">�۷ι�����</a></li> -->
								<li><a href="/2013/video/video_list.jsp?ccode=001005000000">��мӼ���<%if (contactMenu.menu_content("001005000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<!--<li><a href="/2013/video/video_list.jsp?ccode=001007000000">�޸������ÿ���</a></li>-->
								<li><a href="/2013/video/video_list.jsp?ccode=001008000000">���ܿ���<%if (contactMenu.menu_content("001008000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								</ul>
							</li>
							<li class="s2 ">
							<a href="/2013/video/video_list.jsp?ccode=002000000000" class="<%=ccode != null && ccode.startsWith("002")?"visible":""%>">�����̾�Ƽ<%if (contactMenu.menu_content("002000000000") > 0) out.print("<span class='new1'>new</span>");%></a>
								<ul>
								
								<li><a href="/2013/video/video_list.jsp?ccode=002006000000">��ȹ���α׷�<%if (contactMenu.menu_content("002006000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=002002000000">�ݰ��� ���<%if (contactMenu.menu_content("002002000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=002003000000">Ÿ�Ӹӽ�<%if (contactMenu.menu_content("002003000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=002005000000">������<%if (contactMenu.menu_content("002005000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								</ul>
							</li>
							<li class="s3 ">
							<a href="/2013/video/video_list.jsp?ccode=003000000000" class="<%=ccode != null && ccode.startsWith("003")?"visible":""%>">������<%if (contactMenu.menu_content("003000000000") > 0) out.print("<span class='new1'>new</span>");%></a>
								<ul>
								<li><a href="/2013/video/video_list.jsp?ccode=003001000000">����&#183;����<%if (contactMenu.menu_content("003001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=003002000000">��Ȱ&#183;����<%if (contactMenu.menu_content("003002000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=003003000000">����&#183;�ǰ�<%if (contactMenu.menu_content("003003000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=003004000000">����&#183;��ȭ<%if (contactMenu.menu_content("003004000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=003005000000">��ﰭ��<%if (contactMenu.menu_content("003005000000") > 0) out.print("<span class='new'>new</span>");%></a></li>					
								</ul>
							</li>
							<li class="s4 ">
							<a href="/2013/video/video_list.jsp?ccode=004001000000" class="
							<%=
							ccode != null && ccode.startsWith("004") 
							|| temp_queryString.indexOf("board_id=16")> -1
							|| temp_queryString.indexOf("board_id=12")> -1
							|| temp_queryString.indexOf("board_id=10")> -1
							|| temp_queryString.indexOf("board_id=17")> -1
							|| temp_queryString.indexOf("board_id=18")> -1
							|| temp_queryString.indexOf("board_id=19")> -1 
							|| temp_queryString.indexOf("board_id=11")> -1
							|| temp_queryString.indexOf("board_id=13")> -1 
							|| temp_queryString.indexOf("board_id=21")> -1 
							|| temp_queryString.indexOf("board_id=22")> -1 
							
							?"visible":""
							%>">��������<%if (contactMenu.menu_content("004001000000") > 0 ||contactMenu.menu_content_board2() > 0 ) out.print("<span class='new1'>new</span>");%></a>
								<ul>
								<li><a href="/2013/video/video_list.jsp?ccode=004001000000">����PD<%if (contactMenu.menu_content("004001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>				
								<li><a href="/2013/board/board_list.jsp?board_id=16">��������<%if (contactMenu.menu_content_board(16) > 0) out.print("<span class='new'>new</span>");%></a></li>						
								 
								<li><a href="/2013/board/board_list.jsp?board_id=10">��������<%if (contactMenu.menu_content_board(10) > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/board/board_list.jsp?board_id=23">�̺�Ʈ ����<%if (contactMenu.menu_content_board(23) > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/board/board_list.jsp?board_id=17">�޸ս��丮<%if (contactMenu.menu_content_board(17) > 0) out.print("<span class='new'>new</span>");%></a></li>
								<!--<li><a href="/2013/video/video_list.jsp?ccode=004003000000">�޸��� �������޽���</a></li>
								<li><a href="/2013/board/board_list.jsp?board_id=21">����� ���̵�� ������</a></li>-->
								<li><a href="/2013/board/board_list.jsp?board_id=22">�ùθ���ʹ�<%if (contactMenu.menu_content_board(22) > 0) out.print("<span class='new'>new</span>");%></a></li>
								</ul>
							</li>
							<li class="s5 ">
							<a href="/2013/video/video_list.jsp?ccode=005000000000" class="<%=(ccode != null && ccode.startsWith("005")) ?"visible":""%>">ȫ������<%if (contactMenu.menu_content("005000000000") > 0) out.print("<span class='new1'>new</span>");%></a>
								<ul>
								<li><a href="/2013/video/video_list.jsp?ccode=005001000000">ȫ������<%if (contactMenu.menu_content("005001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=005002000000">��������ȸ<%if (contactMenu.menu_content("005002000000") > 0) out.print("<span class='new'>new</span>");%></a></li>

								</ul>
							</li>
							<li class="s6">
							<a href="/2013/video/video_list.jsp?ccode=006001000000" class="<%=ccode != null && ccode.startsWith("006")
							|| request.getRequestURI().indexOf("live_list.jsp")> -1 
							?"visible":""%>">����� �ٽú���<%if (contactMenu.menu_content("006000000000") > 0) out.print("<span class='new1'>new</span>");%></a>
								<ul>
								<li><a href="/2013/live/live_list.jsp">����� ���</a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=006001000000">�����<%if (contactMenu.menu_content("006001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
<!-- 								<li><a href="/2013/info/search.jsp">��ü���α׷�</a></li> -->
								</ul>
							</li>	
							<li class="s7 last">
							<a href="/2013/video/video_list.jsp?ccode=009000000000" class="<%=ccode != null && ccode.startsWith("009")?"visible":""%>">About Suwon<%if (contactMenu.menu_content("009000000000") > 0) out.print("<span class='new1'>new</span>");%></a>
								<ul>
								<li><a href="/2013/video/video_list.jsp?ccode=009001000000">I��m in Suwon<%if (contactMenu.menu_content("009001000000") > 0) out.print("<span class='new'>new</span>");%></a></li>
								<li><a href="/2013/video/video_list.jsp?ccode=009002000000">Promotional Video<%if (contactMenu.menu_content("009002000000") > 0) out.print("<span class='new'>new</span>");%></a></li>

								</ul>
							</li>
										
							</ul>

						</div><!-- //menu::���ø޴� -->
						<!-- menuFull -->
						<div class="menuFull">
							<a href="#menuFull" onclick="showHide('menuFull');return false;" class="menu_view">�޴���ü����</a>
							<div id="menuFull" style="display:none;">
								<div class="menuFull_in" >
									<ul class="menuView">			
									<li class="s1 ">
										<a href="/2013/video/video_list.jsp?ccode=001000000000" class="">Hot �̽�</a>
										<ul>
										<li><a href="/2013/video/video_list.jsp?ccode=001001000000">NEWS</a></li>
										 
										<li><a href="/2013/video/video_list.jsp?ccode=001003000000">�ùΰ���Best5</a></li>
										<!--<li><a href="/2013/video/video_list.jsp?ccode=001006000000">�۷ι�����</a></li>-->
										<li><a href="/2013/video/video_list.jsp?ccode=001005000000">��мӼ���</a></li>
										<!--<li><a href="/2013/video/video_list.jsp?ccode=001007000000">�޸������ÿ���</a></li>-->
										<li><a href="/2013/video/video_list.jsp?ccode=001008000000">���ܿ���</a></li>

										</ul>
									</li>
									<li class="s2 ">
										<a href="/2013/video/video_list.jsp?ccode=002000000000" class="">�����̾�Ƽ</a>
										<ul>
										<li><a href="/2013/video/video_list.jsp?ccode=002001000000">�޸��� ī�޶�</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=002006000000">��ȹ���α׷�</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=002002000000">�ݰ��� ���</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=002003000000">Ÿ�Ӹӽ�</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=002005000000">������</a></li>
										</ul>
									</li>
									<li class="s3 ">
										<a href="/2013/video/video_list.jsp?ccode=003000000000" class="">������</a>
										<ul>
										<li><a href="/2013/video/video_list.jsp?ccode=003001000000">����&#183;����</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=003002000000">��Ȱ&#183;����</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=003003000000">����&#183;�ǰ�</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=003004000000">����&#183;��ȭ</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=003005000000">��ﰭ��</a></li>					
										</ul>
									</li>
									<li class="s4 ">
										<a href="/2013/video/video_list.jsp?ccode=004001000000" class="">��������</a>
										<ul>
										<li><a href="/2013/video/video_list.jsp?ccode=004001000000">����PD</a></li>		
										<li><a href="/2013/board/board_list.jsp?board_id=16">��������</a></li>							
										 
										<li><a href="/2013/board/board_list.jsp?board_id=10">��������</a></li>
										<li><a href="/2013/board/board_list.jsp?board_id=23">�̺�Ʈ ����</a></li>
										<li><a href="/2013/board/board_list.jsp?board_id=17">�޸ս��丮</a></li>
										<!--<li><a href="/2013/video/video_list.jsp?ccode=004003000000">�޸��� �������޽���</a></li>
										<li><a href="/2013/board/board_list.jsp?board_id=21">����� ���̵�� ������</a></li>-->
										<li><a href="/2013/board/board_list.jsp?board_id=22">�ùθ���ʹ�</a></li>
										</ul>
									</li>
									<li class="s5 ">
										<a href="/2013/video/video_list.jsp?ccode=005000000000" class="">ȫ������</a>
										<ul>
										<li><a href="/2013/video/video_list.jsp?ccode=005001000000">ȫ������</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=005002000000">��������ȸ</a></li>
										</ul>
									</li>
									<li class="s6 last">
										<a href="/2013/video/video_list.jsp?ccode=006001000000" class="">����� �ٽú���</a>
										<ul>
										<li><a href="/2013/live/live_list.jsp">����� ���</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=006001000000">�����</a></li>
<!-- 										<li><a href="/2013/info/search.jsp">��ü���α׷�</a></li> -->
										</ul>
									</li>	
									<li class="s7 last">
										<a href="/2013/video/video_list.jsp?ccode=009000000000" class="">About Suwon</a>
										<ul>
										<li><a href="/2013/video/video_list.jsp?ccode=009001000000">I��m in Suwon</a></li>
										<li><a href="/2013/video/video_list.jsp?ccode=009002000000">Promotional Video</a></li>
										</ul>
									</li>										
									</ul>
								</div>		
								<a href="#menuFull" onclick="showHide('menuFull');return false;" class="menu_close2">�޴���ü�ݱ�</a>
							</div>
						</div>
						<!-- //menuFull -->
					</div><!-- //lnb_wrap -->
				</nav>
		</div>
	</div><!-- //head -->
