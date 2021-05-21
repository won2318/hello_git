<%@page import="com.yundara.beans.BeanUtils"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>  
 <%@ page import="org.apache.commons.lang.math.NumberUtils" %> 
<%@ page import="com.yundara.util.*,com.vodcaster.sqlbean.*,com.hrlee.sqlbean.*"%> 
 
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<jsp:useBean id="blsBean" class="com.vodcaster.sqlbean.BoardListSQLBean" scope="page" /> 
<jsp:useBean id="bliBean" class="com.vodcaster.sqlbean.BoardListInfoBean" scope="page" />
<jsp:useBean id="oinfo" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="pop"   class="com.vodcaster.sqlbean.PopupInfoBean"/>

<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<jsp:useBean id="contactMenu" class="com.hrlee.sqlbean.MenuSqlBean"/>
<jsp:useBean id="contactLog" class="com.vodcaster.sqlbean.WebLogManager" />

<%@ include file = "/include/chkLogin.jsp"%>
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

LiveManager lMgr = LiveManager.getInstance();
String channel = "";
String stream = "";
String live_title ="";
String live_rcontents ="";
String live_popup = "";
String live_rcode ="";
String live_img ="";
Vector live_v = null;
try {
 // rcode, rtitle, rcontents, rbcst_time, ralias, 
  // rstart_time, rend_time, rflag, rstatus, rwdate, 
  // rhit, rlevel,rfilename, rid, rimagefile,
  // property_id, openflag,group_id, del_flag, ocode, 
  // otitle, mobile_sream, inoutflag, org_rfilename 
  
    live_v = lMgr.getLive(); 


if(live_v != null && live_v.size() > 0) {
 
		live_popup = "window.open('/2017/info/live_info.jsp','live_comment', 'width=400, height=300, scrollbars=no, toolbars=no');";
		live_rcode = String.valueOf(live_v.elementAt(0)); 
		live_title = String.valueOf(live_v.elementAt(1)); 
		live_rcontents  = String.valueOf(live_v.elementAt(2)); 
		live_img  = String.valueOf(live_v.elementAt(14)); 
 
		String[] data= null;
		 
		data=String.valueOf(live_v.elementAt(4)).split("/");

		if(data.length > 2){
			channel = data[1];
			stream = data[2];
		}
		
} 
}catch(Exception e) {}


//��������
Vector noticeVt1 = blsBean.getMain_board_notice(10, 6); // ���� (board_id, limit)

//������ �ֿ� ����
//MediaManager mMgr = MediaManager.getInstance();
BestMediaManager Best_mgr = BestMediaManager.getInstance();
	
Vector vtBts_1 = new Vector();
vtBts_1 = Best_mgr.getBestTopSubList_order(1, 7); // ������ �ֿ� ����  bti_id = 1, limit = 7
 
Vector main_list1 =new Vector();
Vector main_list2 =new Vector();
Vector main_list3 =new Vector();
Vector main_list4 =new Vector();
Vector main_list5 =new Vector();
Vector main_list6 =new Vector();
Vector main_list7 =new Vector();

//=====================================
//�˾����� ��������

String[] pop_seq = null;
	String seq = null;
	String pos_x = "";
	String pos_y = "";
	String p_width = "";
	String p_height = "";
	
	String[] pop_script = null;
	String[] pop_scriptM = null;
	PopupManager pMgr = new PopupManager();
	Vector popv_P = pMgr.getVisible_dateflag("P");  // flag = P  popup , M main, C �̽�
		
	Vector popv_M = pMgr.getVisible_dateflag("M");  // flag = P  popup , M main, C �̽�
	
	if(popv_P != null && popv_P.size() > 0) {
		pop_script = new String[popv_P.size()];
		pop_seq = new String[popv_P.size()];
		for(int i=0;i<popv_P.size();i++){
			seq = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(0));
			pos_x = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(10));
			pos_y = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(11));
			p_width = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(4));
			p_height = String.valueOf(((Vector)(popv_P.elementAt(i))).elementAt(5));

			int pop_height = 160;
			if (p_height != null && p_height.length() > 0) {
				//pop_height = Integer.parseInt(p_height)+150;		
				pop_height = Integer.parseInt(p_height)+80;		
			}
			int pop_width = 160;
			if (p_width != null && p_width.length() > 0) {
				pop_width = Integer.parseInt(p_width);		
			}	
				pop_script[i] = "window.open('/2017/info/popup_dd.jsp?seq="+seq+"', 'vodcaster_"+seq+"', 'left="+pos_x+", top="+pos_y+", width="+pop_width+", height="+pop_height+", scrollbars=no, toolbars=no');";

			pop_seq[i] = seq;
		}
	}
	
	 
	//==========================================================
	// ���� ���� �������� 

	SubjectManager smgr = SubjectManager.getInstance();
	Vector subject = null;
	String subject_script = "";
	subject = smgr.getSubjectListDate("S");  // ����

	if( subject != null && subject.size() >= 4 && Integer.parseInt( String.valueOf(subject.elementAt(4))) >=  Integer.parseInt( String.valueOf(subject.elementAt(12))) ) {
	        subject_script = "if ( getCookie( \"subject\" ) != \"true\" ) { \n" +
	                "noticeWindow2  =  window.open(\"/2017/info/event_info.jsp?sub_flag=S\", \"subject\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=300\");\n" +
	                "if(noticeWindow2){noticeWindow2.opener = self;} \n" +
	                "} ";
	  }

	Vector event = null;
	String event_script ="";
	event = smgr.getSubjectListDate("E") ; //�̺�Ʈ
	if( event != null && event.size() >= 4 && Integer.parseInt( String.valueOf(event.elementAt(4))) >=  Integer.parseInt( String.valueOf(event.elementAt(12))) ) {
	        event_script = "if ( getCookie( \"event\" ) != \"true\" ) { \n" +
	                "noticeWindow3  =  window.open(\"/2017/info/event_info.jsp?sub_flag=E\", \"event\", \"status=no,scrollbars=no,width=400,height=300,top=120,left=500\");\n" +
	                "if(noticeWindow3){noticeWindow3.opener = self;} \n" +
	                "} ";
	  }

	Vector hot7 = null;
	String hot7_script ="";
	hot7 = smgr.getSubjectListDate("H") ; //�ּ���
	 
	try{
		  if( hot7 != null && hot7.size() >= 4 
				&& Integer.parseInt( String.valueOf(hot7.elementAt(4))) >=  Integer.parseInt( String.valueOf(hot7.elementAt(12))) ) {
			  hot7_script = "if ( getCookie( \"hot7\" ) != \"true\" ) { \n" +
						  "noticeWindow4  =  window.open(\"/2017/info/event_info.jsp?sub_flag=H\", \"hot7\", \"status=no,scrollbars=no,width=400,height=300,top=60,left=700\");\n" +
						  "noticeWindow4.opener = self; \n" +
						  "} ";
			}
		}catch(Exception ex){
	 
		}
	 
int memo_size = 0;  // ���ο��� ��� ���� 
if (vtBts_1 != null && vtBts_1.size() > 0) {
	int cnt = 1;
	for (Enumeration e = vtBts_1.elements(); e.hasMoreElements(); cnt++) {
		com.yundara.beans.BeanUtils.fill(oinfo,(Hashtable) e.nextElement());
		 			String imgTmp = "/2017/include/images/noimg_small.gif";
					 
					if (oinfo.getModelimage() != null && oinfo.getModelimage().length() > 0 && oinfo.getModelimage().indexOf(".") > 0) {
						imgTmp = SilverLightPath + "/" + oinfo.getSubfolder() + "/thumbnail/" + oinfo.getModelimage();
					}  
					if (oinfo.getThumbnail_file() != null && oinfo.getThumbnail_file().indexOf(".") > 0) {
						imgTmp = "/upload/vod_file/"+oinfo.getThumbnail_file();
					}
					String strTitle = oinfo.getTitle();
					//strTitle = strTitle.length()>32?strTitle.substring(0,32)+"...":strTitle;
					
					String strContent = oinfo.getDescription();
					strContent = strContent.length()>20?strContent.substring(0,20)+"...":strContent;
					
					if (cnt==1 ) {
					    main_list1.add(strTitle);
					    main_list1.add( imgTmp);

					    main_list1.add("/videoJs/jsPlayer_2017.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode()+"&type=main");
					   //main_list1.add(" /videoJs_2019/jsPlayer.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode()+"&type=main");
					     
					    main_list1.add(oinfo.getMk_date());
					    main_list1.add(oinfo.getPlaytime());
					    main_list1.add(oinfo.getContent_simple());
					    main_list1.add(oinfo.getHitcount());
					    main_list1.add(oinfo.getRecomcount()); 
					    main_list1.add(oinfo.getOcode()); 
					    main_list1.add(oinfo.getCcode()); 
 
					    MemoManager memoMgr = MemoManager.getInstance(); 						 
						memo_size = memoMgr.getMemoCount( oinfo.getOcode() ,"M");	 
					  
					} else if (cnt==2) {
						main_list2.add(strTitle);
					    main_list2.add( imgTmp);
					    main_list2.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					   
					}else if (cnt==3) {
						main_list3.add(strTitle);
					    main_list3.add( imgTmp);
					    main_list3.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					   
					}else if (cnt==4) {
						main_list4.add(strTitle);
					    main_list4.add( imgTmp);
					    main_list4.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					    
					}else if (cnt==5) {
						main_list5.add(strTitle);
					    main_list5.add( imgTmp);
					    main_list5.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					   
					}else if (cnt==6) {
						main_list6.add(strTitle);
					    main_list6.add( imgTmp);
					    main_list6.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					   
					}else if (cnt==7) {
						main_list7.add(strTitle);
					    main_list7.add( imgTmp);
					    main_list7.add("/2017/video/video_list.jsp?ocode="+oinfo.getOcode()+"&ccode="+oinfo.getCcode());
					  
					}
	}
} 
 
%>
 

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 
<meta NAME="title" content="���� iTv" />
<meta NAME="description" content="���� iTv, ����� �ݰ����ϴ�, �޸ս�Ƽ ����" />
<meta NAME="Keywords" content="���� iTv, ����� �ݰ����ϴ�, �޸ս�Ƽ ����" />

<title>�������ͳݹ��</title>
<link rel="stylesheet" type="text/css" href="../include/css/default.css">
<link rel="stylesheet" type="text/css" href="../include/css/main.css">
<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css">
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.min.js"></script><!-- �⺻ -->
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.flexslider-min.js"></script> <!-- ��ܸ޴� -->
<script type="text/javascript" charset="utf-8" src="../include/js/common.js"></script> <!-- ��ܸ޴� -->
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.leanModal.min.js"></script> <!-- ���θ޴���� -->
<script type="text/javascript" charset="utf-8" src="../include/js/jquery.colorbox.js"></script> <!-- ���̾��˾� -->
<script type="text/javascript" charset="utf-8" src="../include/js/main.js"></script> <!-- ����ȫ������� -->
<script type="text/javascript" charset="utf-8" src="../include/js/script.js"></script> <!-- ���̾��÷��ڽ����� -->
<script type="text/javascript">
<!--
	//<![CDATA[
	$(document).ready(function(){
		 $('.popup').PopupZone({
			prevBtn : '#pzPrev', 
			nextBtn : '#pzNext',
			playBtn : '#pzPlay',
			waitingTime : '5000'
		});  //����ȫ�������Ʈ��
	}); 
	//]]> 

	function getCookie(Name){
		var search = Name + "=";
		if(document.cookie.length > 0 ){
			offset = document.cookie.indexOf(search);
			if( offset != -1){
				offset += search.length;
				end = document.cookie.indexOf(";",offset);
				if( end == -1){
					end = document.cookie.length;
				}
				return unescape(document.cookie.substring(offset, end));
				
			}
		}
	}
	 

	function isPopupView(seq) {

		if(!(getCookie("vodcaster_"+seq) == "true")) { 
			return true;
		}
	}

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

	 function point_go(ocode){
		 
		 $.get("/2017/video/proc_best_point.jsp", { ocode: ocode },  function(data) { 
			 $("#recomcount").html(data); 
				alert('��õ �Ǿ����ϴ�!');
			 },   "text" ); 
	 
	 }
	 
	
	//-->
</script>
	
	 
<style>
	
</style>
</head>
<body>
	<div id="wapper"> 
		<header> 
			<div class="head_inner">
				<div id="accessibility">
					<ul>
					<li><a href="#lnb" accesskey="1">���θ޴��ٷΰ���</a></li>
					<li><a href="#body" accesskey="2">�������ٷΰ���</a></li>
					</ul>
				</div> <!-- //accessibility::skip -->
				<div class="top-nav"> 
					<h1><a href="/"><img src="../include/images/logo.png" alt="SUWON TV"/></a></h1>
					<div class="gnb_area">
						<ul>
						<li><a href="/">Ȩ</a></li>
						<li><a href="javascript:AddFavorite(this);">���ã��</a></li>
						<li><a href="/2017/info/search.jsp">��ü���α׷�</a></li>
						<% if (vod_name != null && vod_name.length() > 0) { %><li><a href="/include/logout.jsp">�α׾ƿ�</a></li><%} %>
						</ul>
						<div class="gnb_search">
							<form name="head_search" method="post" action="/2017/info/search.jsp">
							<fieldset>
								<legend>�˻�</legend>
								<span class="gnb_search_in">
									<input type="hidden" name="search_ccode" value="" />
									<input type="hidden" name="searchField" value="title" />
									<input type="text" title="�˻���" name="searchString" id="head_searchstring" value="������� ������ �ִٸ�?" class="input_text" onclick="javascript:document.getElementById('head_searchstring').value=''; "/> 
								</span><input type="image" src="../include/images/icon_search_2.png" alt="�˻�" class="img"/>
								</fieldset>
							</form>
						</div>
					</div>
					<!--<div class="sns">
						<a href="http://www.youtube.com/user/suwonloves" target="_blank" title="��â���� ����"><img src="../include/images/sns_youtube.png" alt="������"/></a>
						<a href="http://blog.naver.com/suwonitv/" target="_blank" title="��â���� ����"><img src="../include/images/sns_blog.png" alt="���̹� ��α�"/></a>
						<a href="https://tv.kakao.com/channel/2711566/cliplink/303361751?metaObjectType=Channel" target="_blank" title="��â���� ����"><img src="../include/images/sns_cacaotv.png" alt="īī��TV"/></a>
						<a href="https://twitter.com/suwonitv" target="_blank" title="��â���� ����"><img src="../include/images/sns_twitter.png" alt="Ʈ����"/></a>
						<a href="http://tv.naver.com/suwonitv" target="_blank" title="��â���� ����"><img src="../include/images/sns_navertv.png" alt="���̹�TV"/></a>
					</div>-->
				</div><!--//top-nav-->
			</div><!--//head_inner-->
		</header> <!--���:header-->    
		<%
		String ccode ="";
		int board_id = NumberUtils.toInt(request.getParameter("board_id"), 0);
		%>              
		<nav id="lnb">     
			<!-- menu::���ø޴� -->
			<div class="lnb_wrap">
			<div class="gnb" id="">			
				<ul>
							<li class="s1 ">
							<a href="/2017/video/video_list.jsp?ccode=001000000000" class="<%=ccode != null && ccode.startsWith("001") && !ccode.startsWith("001004")?"visible":""%>">������ ����!<%if (contactMenu.menu_content("001000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=001001000000">����  iTV ����<%if (contactMenu.menu_content("001001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=001008000000">��ȹ����<%if (contactMenu.menu_content("001008000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=001009000000">������ ȫ������<%if (contactMenu.menu_content("001009000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=001003000000">�������α׷�<%if (contactMenu.menu_content("001003000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								
								</ul>
							</li>
							<li class="s2 ">
							<a href="/2017/video/video_list.jsp?ccode=002007000000" class="<%=
							ccode != null && ccode.startsWith("002") ?"visible":""
							%>">��۽�ũ��<%if (contactMenu.menu_content("002007000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
 								<li><a href="/2017/video/video_list.jsp?ccode=002007000000">��ۿ���<%if (contactMenu.menu_content("002007000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
							    <li><a href="/2017/board/board_list.jsp?board_id=24">��۸���<%if (contactMenu.menu_content_board(24) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								
								</ul>
							</li>
							<li class="s3 ">
							<a href="/2017/video/video_list.jsp?ccode=003000000000" class="<%=ccode != null && ccode.startsWith("003")?"visible":""%>">����&#183;����<%if (contactMenu.menu_content("003000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=003001000000">������<%if (contactMenu.menu_content("003001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=003006000000">ȫ������<%if (contactMenu.menu_content("003006000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>					
								<li><a href="/2017/video/video_list.jsp?ccode=003007000000">Ÿ�Ӹӽ�<%if (contactMenu.menu_content("003007000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>					
								</ul>
							</li>
							<li class="s4 ">
							<a href="/2017/video/video_list.jsp?ccode=004001000000" class="
							<%=
							ccode != null && ccode.startsWith("004") 
							 
							
							?"visible":""
							%>">��������<%if (contactMenu.menu_content("004001000000") > 0 ||contactMenu.menu_content_board2() > 0 ) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=004001000000">����PD<%if (contactMenu.menu_content("004001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>				
 								<li><a href="/2017/board/board_list.jsp?board_id=10">��������<%if (contactMenu.menu_content_board(10) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/board/board_list.jsp?board_id=17">�޸ս��丮<%if (contactMenu.menu_content_board(17) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
 								<li><a href="/2017/board/board_list.jsp?board_id=22">�ùθ���ʹ�<%if (contactMenu.menu_content_board(22) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								</ul>
							</li>
							<li class="s5 ">
							<a href="/2017/video/video_list.jsp?ccode=005002000000" class="<%=(ccode != null && ccode.startsWith("005")) ?"visible":""%>">��������ȸ<%if (contactMenu.menu_content("005002000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
  								<li><a href="/2017/video/video_list.jsp?ccode=005002000000">��������ȸ<%if (contactMenu.menu_content("005002000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li> 
								<li><a href="/2017/board/board_list.jsp?board_id=25">��۸���<%if (contactMenu.menu_content_board(25) > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>

								</ul>
							</li>
							<li class="s6">
							<a href="/2017/video/video_list.jsp?ccode=006001000000" class="<%=ccode != null && ccode.startsWith("006")
							|| request.getRequestURI().indexOf("live_list.jsp")> -1 
							?"visible":""%>">����� �ٽú���
							<% if(live_v != null && live_v.size() > 0) { %><span class="new onair">ON-AIR</span><%} %>
							<%if (contactMenu.menu_content("006000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
<!-- 								<li><a href="/2017/live/live_list.jsp">����� ���</a></li>  -->

									<% if(live_v != null && live_v.size() > 0) { %><li><a href="/2017/live/live_player.jsp?ccode=006001000000">ON-AIR <span class='new bubb1'>N</span></a></li><%} %>
									<li><a href="/2017/video/video_list.jsp?ccode=006001000000">����� �ٽú���<%if (contactMenu.menu_content("006001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
 
 
								</ul>
							</li>	
							<li class="s7 last">
							<a href="/2017/video/video_list.jsp?ccode=009000000000" class="<%=ccode != null && ccode.startsWith("009")?"visible":""%>">About Suwon<%if (contactMenu.menu_content("009000000000") > 0) out.print("<span class='new'>new</span>");%></a>
								<ul>
								<li><a href="/2017/video/video_list.jsp?ccode=009002000000">Promotional Video<%if (contactMenu.menu_content("009002000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>
								<li><a href="/2017/video/video_list.jsp?ccode=009001000000">Global Suwon (End program)<%if (contactMenu.menu_content("009001000000") > 0) out.print("<span class='new bubb1'>N</span>");%></a></li>


								</ul>
							</li>
										
						</ul>

			</div><!-- //menu::���ø޴� -->

			<a href="#menuFull" class="flatbtn" id="modaltrigger"><img src="../include/images/icon_menu_yellow.png" alt="�޴�"/></a>
			
			</div><!--//lnb_wrap-->
			
		</nav> <!--�׺���̼�:nav-->                
	
		<section id="body">
			<div class="container_out">
				<div class="container_inner">
					<div class="main_vod">
					<% if (main_list1 != null && main_list1.size() >0) { %> 
					
						<div class="embed-container">
							<div class="videoWrapper">
								<div>
									<!-- ��������� 525X295 -->
<!-- 								  <iframe src="https://www.youtube.com/embed/qVsz-htpDB0" frameborder="0" allowfullscreen></iframe> -->
<%-- 								  <iframe title="������ ��� â" id="bestVod" name="bestVod" src="/videoJs_2019/jsPlayer.jsp?ocode=<%=main_ocode%>&type=main" scrolling="no" width="252" height="295" marginwidth="0" frameborder="0" framespacing="0" allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true"></iframe> --%>
									<iframe id="video" src="<%=main_list1.get(2).toString()%>" width="525" height="295" frameborder="0" scrolling="no" marginwidth="0" framespacing="0" allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" oallowfullscreen="true" msallowfullscreen="true"></iframe>
								</div>
								
							</div>
						</div>
						<div class="data">
							<h3 class="entry-title clearfix"><%=main_list1.get(0).toString()%></h3>
							<div class="info">
								<dl>
								<dt>�����</dt>
								<dd><%=main_list1.get(3).toString()%></dd>
								<dt>����ð�</dt>
								<dd><%=main_list1.get(4).toString()%></dd>
								</dl> 
								<i class="i_play"><%=main_list1.get(6).toString() %></i>
								<i class="i_reply"><a href="/2017/video/video_list.jsp?ocode=<%=main_list1.get(8)%>&ccode=<%=main_list1.get(9)%>#footer"><%=memo_size%></a></i>
								<i class="i_like"><a href="javascript:point_go('<%=main_list1.get(8)%>');"><strong id="recomcount"><%=main_list1.get(7).toString()%></strong></a></i>
 
								
							</div>
							<span class="subj clearfix"><%=chb.getContent_2(main_list1.get(5).toString(),"true")%></span>
						</div><!--//data-->
						<%} %>
					</div>
				</div> <!--//container_inner-->
				<div class="new_vod">
					<ul>
					<li>
					<% if (main_list2 != null && main_list2.size() >0) { %>
						<a href="<%=main_list2.get(2).toString()%>">
							<span class="img"><img src="<%=main_list2.get(1).toString()%>" alt="<%=main_list2.get(0).toString()%>"/></span>
							<h3><%=main_list2.get(0).toString()%></h3>
						</a>
					<%} %>
					</li>
					
					<li>
					<% if (main_list3 != null && main_list3.size() >0) { %>
						<a href="<%=main_list3.get(2).toString()%>">
							<span class="img"><img src="<%=main_list3.get(1).toString()%>" alt="<%=main_list3.get(0).toString()%>"/></span>
							<h3><%=main_list3.get(0).toString()%></h3>
						</a>
					<%} %> 
					</li>
					<li>
						<% if (main_list4 != null && main_list4.size() >0) { %>
						<a href="<%=main_list4.get(2).toString()%>">
							<span class="img"><img src="<%=main_list4.get(1).toString()%>" alt="<%=main_list4.get(0).toString()%>"/></span>
							<h3><%=main_list1.get(0).toString()%></h3>
						</a>
					<%} %>
					</li>
					<li>
						<% if (main_list5 != null && main_list5.size() >0) { %>
						<a href="<%=main_list5.get(2).toString()%>">
							<span class="img"><img src="<%=main_list5.get(1).toString()%>" alt="<%=main_list5.get(0).toString()%>"/></span>
							<h3><%=main_list5.get(0).toString()%></h3>
						</a>
					<%} %>
					</li>
					</ul>
				</div>
				<aside class="pop_noti_out">
					<div class="pop_noti_inner">
						<div class="popup_si">
							<div id="popupzone">
								<h3>�˾���</h3>
								<div class="popup">
								<span class="count">
									<a href="#popupzone" id="pzPlay"><img src="../include/images/btn_stop.png" alt="����" /></a>
									<a href="#popupzone" id="pzPrev"><img src="../include/images/btn_back.png" alt="����" /></a>
									<% if(popv_M != null && popv_M.size() >0){ %> 
									<span><strong class="currentCount">1</strong> / <strong class=""><%=popv_M.size() %></strong></span>
									<%} else { %>
									<span><strong class="">0</strong> / <strong class="">0</strong></span>
									<%} %>
									<a href="#popupzone" id="pzNext"><img src="../include/images/btn_next.png" alt="����" /></a>
								</span>
								<ul>
								 <% 
									  if(popv_M != null && popv_M.size() >0){
										  for(int i=0; i<popv_M.size(); i++){										 
								 %> 
 
								<li><a href="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(8))%>"><img src="/upload/popup/<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(9))%>" alt="<%=String.valueOf(((Vector)(popv_M.elementAt(i))).elementAt(1))%>"/></a></li>
											
								<%
											  }
									  }
								%> 
								
								</ul>
								</div>
							</div><!-- //popupzone::����Ʈ�̹��� -->
							
						</div>
						<div class="m_notice">
							<h3>��������</h3>
							<ul>
							<%
							if (noticeVt1 != null && noticeVt1.size() > 0) {
			 						String list_title = "";
			 						String list_date = "";
			 						String list_contents = "";
			 						int cnt_notice = 0;
			 						try {
			 							for (Enumeration e = noticeVt1.elements(); e.hasMoreElements();) {
			 								com.yundara.beans.BeanUtils.fill(bliBean, (Hashtable) e.nextElement());
			 								cnt_notice ++;
			  					 %>  

										<li><a href="../board/board_view.jsp?board_id=<%=bliBean.getBoard_id() %>&amp;list_id=<%=bliBean.getList_id()%>"><span class="title"><%=bliBean.getList_title() %></span><span class="day"><%=bliBean.getList_date().substring(0,10) %></span></a></li>
								<% 
			  							}
			 						} 
			 						catch (Exception e) {
			 						}
			 					}   else {
			 						%>
			 						<li>��ϵ� ������ �����ϴ�.</li>
			 						<%
			 					}
						 
			 				%> 
							</ul>
							<p class="more"><a href="/2017/board/board_list.jsp?board_id=10">������<span>+</span></a></p>
						</div>
					</div><!--//pop_noti_inner-->
				</aside> 
			</div><!--//container_out-->
		</section><!--�������κ�:section-->    
	<%
	if(popv_P != null && popv_P.size() > 0) {
		for (int i = 0; i < pop_seq.length; i++) {
			// IE�϶� ��Ű�˻� �� �˾�

				out.println("<SCRIPT LANGUAGE='JavaScript'>");
				//out.println("var isPop = isPopupView(\'"+pop_seq[i]+"\');");
				//out.println("if (isPop) {");
				out.println("if (getCookie( \"vodcaster_"+pop_seq[i]+"\" ) != \"true\" ) {");
				out.println(pop_script[i]);
				out.println("}</SCRIPT>");
		} 
	} 
	
	//���̺� �˾� �ȳ�â�� �ٿ��.
 
	out.println("<SCRIPT LANGUAGE='JavaScript'>");
	out.println(subject_script);
	out.println(event_script);
	out.println(hot7_script);
//	out.println(live_popup);
	out.println("</SCRIPT>");
	
%>	 	
		<!-- Start : layer-popup content --> 
<%
if(live_v != null && live_v.size() > 0) {
%>
		<div id="layer" class="layer-wrap" style="display: block; width: 455px; height: 503px; margin:auto auto;"> <!-- height = pop-container + padding 68px + btn height 35px //--> 
			<div class="pop-layer"> 
				<div class="pop-container" style="width: 455px; height: auto;"> <!-- ���μ��� padding �� 68px //--> 
					<div class="pop-conts"> <!--content //--> 
						<h3><%=live_title %></h3>
						<%if (live_img != null && live_img.length() > 0) { %>
						<img src="/upload/reserve/<%=live_img %>" alt="�����"/>						
						<%} else { %>
						<div style="width:387px; height: 286px;background-size: 100% auto;"></div>
						<%} %>
						<%=live_rcontents %>
						<p class="btn_go"><a href="/2017/live/live_player.jsp?ccode=006001000000">����� ��������</a></p>
					</div> 
				</div> 
				<div class="btn"> <!--height 35px-->
<!-- 					<input type="checkbox" id="todayclose"/>  -->
<!-- 					<label for="todayclose">�����Ϸ� ���� ����</label> -->
					<a href="#" class="btn-layerClose">CLOSE</a> 
				</div> <!--// content--> 
			</div> 
		</div> <!-- End : layer-popup content --> 
 
<%} %>	
<%@ include file = "../include/html_foot.jsp"%>    
		
		