<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.hrlee.sqlbean.MediaManager"%>
<%@ page import="com.security.*" %>

<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
 <%@ include file = "/include/chkLogin.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

	MediaManager mgr = MediaManager.getInstance();
	Hashtable result_ht = null;
	String strMenuName = "";

	String ccode ="";	
	if (request.getParameter("ccode") != null && request.getParameter("ccode").length() > 0  && !request.getParameter("ccode").equals("null")) {
		ccode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ccode"));
	}	

	String ocode ="";
	if (request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0  && !request.getParameter("ocode").equals("null")) {
		ocode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ocode"));
	}
	
	String auto_p = "True";

// 	if(request.getParameter("auto_p") != null && request.getParameter("auto_p").length()>0 && !request.getParameter("auto_p").equals("null") && request.getParameter("auto_p").equals("True") ) {
// 		auto_p = "True";
// 	} else{
// 		auto_p = "False";
// 	}
	
	boolean isView = true;
	boolean bOmibean = false;
	String imgTmpThumb = "";
	int oHit_count = 0;
	String oPlay_time = "";
	String otitle = "";
	String odesc = "";
	String mk_date = "";
	int recomcount =0;
	int replycount =0;
	Vector vo = null;
	if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
		vo = mgr.getOMediaInfo_cate(ocode);

	} 
	int auth_v = 1;
	if (vo != null && vo.size() > 0) {
		try {
			Enumeration e2 = vo.elements();
			com.yundara.beans.BeanUtils.fill(omiBean, (Hashtable) e2.nextElement());
			bOmibean = true;
			imgTmpThumb = SilverLightPath + "/"+omiBean.getSubfolder()+"/thumbnail/"+omiBean.getModelimage();
			ocode = omiBean.getOcode();
			oHit_count = omiBean.getHitcount();
				oPlay_time = omiBean.getPlaytime();
				otitle = omiBean.getTitle();
				odesc = omiBean.getDescription();
				mk_date = omiBean.getMk_date();
			replycount = omiBean.getReplycount();
			recomcount = omiBean.getRecomcount();
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
			isView = false;
		}
	}else{
	
	}

	auth_v = omiBean.getOlevel();
	int user_level = 0;
	if (vod_level != null) {
		try{
			user_level = Integer.parseInt(vod_level);
		}catch(Exception e){
			user_level = 0;
		}
	}

	String ofilename = "";
	if (StringUtils.isNotEmpty(omiBean.getFilename())) {
		ofilename = omiBean.getFilename();
		isView = true;
	} else {
		//미디어 아이디가 없는 경우 
		isView = false;
	}
	if (isView && omiBean.getOcode() != "" && StringUtils.isNotEmpty(ofilename)) {
		//회원정보 로그화일에 저장
		if(deptcd == null) deptcd = "";
		if(gradecode == null) gradecode = "";
		com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, omiBean.getOcode(), request.getRemoteAddr(),"V" );
	}				

	/*
	String GB = "WV";
	int year=0, month=0, date=0;
	Calendar cal = Calendar.getInstance();
	year  = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH)+1;
    date = cal.get(Calendar.DATE);
	
	MenuManager2 mgr2 = MenuManager2.getInstance();
	mgr2.insertHit(ccode,year,month,date,GB);	
	*/
	
	
	String flag = request.getParameter("flag");
	if (flag == null) {
		flag = "M";
	}

//  메모 읽기

    int mpg = NumberUtils.toInt(request.getParameter("mpage"), 1);
    Hashtable memo_ht = new Hashtable();
    MemoManager memoMgr = MemoManager.getInstance();
	if (ocode != null && ocode.length() > 0) {
	 memo_ht = memoMgr.getMemoListLimit(ocode, mpg, 3, flag);
	 
	}

    Vector memoVt = (Vector)memo_ht.get("LIST");
	com.yundara.util.PageBean mPageBean = null;

	if(memoVt != null && memoVt.size()>0){
    mPageBean = (com.yundara.util.PageBean)memo_ht.get("PAGE");
	}
   if(memoVt == null || (memoVt != null && memoVt.size() <= 0)){
    	//결과값이 없다.
    	//System.out.println("Vector ibt = (Vector)result_ht.get(LIST)  ibt.size = 0");
    }
    else{
    	if(mPageBean != null){
    		mPageBean.setPagePerBlock(4);
	    	mPageBean.setPage(mpg);
    	}
    }

	int memo_size = 0;
	if (ocode != null && ocode.length() > 0) {
		memo_size = memoMgr.getMemoCount( ocode ,flag);
	}
	
	//관련 컨텐츠, 관련 프로그램, 화재의 영상
	Vector new_list12 = mgr.getMediaList_Xcode(omiBean.getXcode(), ocode, "ocode", 2); //  프로그램 (ycode)
	Vector new_list11 = mgr.getMediaList_Ycode( omiBean.getYcode(), ocode, "ocode", 2); // 분야 (xcode)

	//글 쓰는 페이지를 지나가는지 체크하는 세션 변수 저장
	session.putValue("write_check", "1");

	//랜덤 값을 세션에 저장하고 사용자가 입력한 확인 문자열이 세션에 저장된 문자열과 같은지 체크한다.
	int iRandomNum = 0;
	java.util.Random r = new java.util.Random(); //난수 객체 선언 및 생성
	iRandomNum = r.nextInt(999)+10000;
	session.putValue("random_num", String.valueOf(iRandomNum));
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.validate.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
 
 
 	<script type="text/javascript" src="/Silverlight.js"></script>
 
	<script type="text/javascript" src="/2013/include/js/jquery.masonry.min.js"></script>
	<script type="text/javascript" src="/2013/include/js/script.js"></script>
	
</head>
<body>

<script language="javascript">


</script>

<div id="pWrap">
	<!-- container::메인컨텐츠 -->
	<div id="pLogo">
		<h2><a href="/"><img src="../include/images/view_logo.gif" alt="수원 iTV 홈페이지 바로가기"/></a></h2>
<!-- 		<span class="close"> <img src="../include/images/btn_view_close.gif" alt="닫기"/><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/></span> -->
	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle"><%=otitle%></h3>
			<span class="pTime">등록일 : <%=mk_date%>&nbsp;&nbsp;|&nbsp;&nbsp;방송시간 : <%=oPlay_time%></span>
			<div class="pPlayer">
				<div id="SilverlightControlHost" class="silverlightHost" >
<%-- 					<iframe title="실버라이트 동영상 재생 창" id="silver_player" name="silver_player" src="/silverPlayer.jsp?ocode=<%=ocode%>&width=579&height=370&auto_p=<%=auto_p%>" scrolling="no" width="579" height="370" marginwidth="0" frameborder="0" framespacing="0" ></iframe> --%>

<div id='errorLocation' style="font-size: small;color: Gray;"></div>
 
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="579" height="370" style="z-index:0;">
		  <param name="source" value="/WowzaPlayer.xap"/> 
          <param name="initparams" value="Server=<%=DirectoryNameManager.SERVERNAME %>,Post=<%=ocode%>,Auto_p=<%=auto_p%>"/>
          
		  <param name="onError" value="onSilverlightError" />
		  <param name="onLoad" value="onSilverlightLoad" />
		  <param name="background" value="white" />
		  <param name="minRuntimeVersion" value="4.0.50826.0" />
		  <param name="enablehtmlaccess" value="true"/>
		  <param name="autoUpgrade" value="true" />
		  <param name="windowless" value="true" />
		 
		  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=4.0.50826.0" style="text-decoration:none">
 			  <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight" style="border-style:none"/>
		  </a>
	    </object><iframe title="_sl_historyFrame" id="_sl_historyFrame" style="display:none;visibility:hidden;height:0px;width:0px;border:0px"></iframe>
 


				</div> 
			</div>
			<div class="pSubject"><%=chb.getContent_2(odesc,"true")%></div>
			<span class="pRecomIcon"><a href="javascript:point_go();"><img src="../include/images/btn_like.gif" alt="좋아요 Like!"/></a></span>
			<!-- comment::댓글 -->
			<div class="comment">
				<div id="commentFrame">
					<h4 class="cTitle">리뷰의견(<span><%if(memo_ht != null && !memo_ht.isEmpty() && memo_ht.size() >= 1 && (memoVt != null && memoVt.size()>0)){%><%=mPageBean.getTotalRecord()%><%}else{%>0<%}%></span>)건</h4>
					<div class="commentInput">
					<form id="comment_form" name="comment_form" method="post" action="javascript:comment_action()" >
						<input type="hidden" name="ocode" value="<%=ocode%>" />
				 		<input type="hidden" name="jaction" value="save" />
						<input type="hidden" name="muid" value="" />
						<input type="hidden" name="flag" value="<%=flag %>" />
<%-- 						<input type="hidden" name="wname" value="<%=comment_name %>" /> --%>
<%-- 						<input type="hidden" name="pwd" value="<%=comment_pwd %>" /> --%>
						<span class="warning">의견작성<span>&nbsp;&nbsp;|&nbsp;&nbsp;비방, 욕설, 광고 등은 사전협의 없이 삭제됩니다.</span></span>
						<ul>
							<li><label for="wnick_name">닉네임</label></li>
							<li><input type="text" name="wnick_name" value="" id="wnick_name" title="닉네임"/></li>
							<li class="pl20"><label for="pwd">비밀번호</label></li>
							<li><input type="password" name="pwd" value=""  id="pwd" title="비밀번호"/></li>
						</ul>
						<ul class="checkText">
							<li><label for="chk_word">확인문자열</label></li>
							<li><input type="text" name="chk_word" value="" id="chk_word" size="10" title="확인 문자열" onkeyup="javascript:chk_word_func();"/>
							<span class="checkText1"><%=iRandomNum %></span> <span class="checkText2">* 좌측 숫자를 입력 하십시오.</span></li>
						</ul>
						<div class="input_wrap">
							<textarea id="comment" name="comment" wrap="hard"  required="required" ></textarea>
							<input type="image" src="../include/images/btn_reply_ok.gif" alt="확인" class="img"/>
						</div>
						</form>
					</div>
					<div class="commentList" id="commentList"> 
					<!-- 댓글 목록 불러 오기 -->
					</div>
					<form name="comment_del" method="post" action="../comment/pwd_check.jsp" >
					<input type="hidden" name="ocode" value="<%=ocode%>" />
					<input type="hidden" name="jaction" value="del" />
					<input type="hidden" name="muid" value="" />
					<input type="hidden" name="pwd" value="<%=user_key %>" />
					<input type="hidden" name="flag" value="<%=flag %>" />
					</form>
						 
				</div>
			</div>
			<!-- //comment::댓글 -->
		</div>

		<div class="pAside">
			<div class="pInfo">
				<span class="pHit">플레이수<span><%=oHit_count%></span> <a href="javascript:document.getElementById('silver_player').contentWindow.StopSilverlight();">[test]</a></span>
				<span class="pRecom">추천수<span id="recomcount"><%=recomcount%></span></span>
			</div>
			<div class="pLink">
				<span>공유하기 <a href="/"><img src="../include/images/icon_view_link.gif" alt="링크"/></a>  <a href="/"><img src="../include/images/icon_view_twitter.gif" alt="트위터"/></a> <a href="/"><img src="../include/images/icon_view_facebook.gif" alt="페이스북"/></a></span>
			</div>
			<div class="conContent">
				<h4>관련 콘텐츠</h4>
				<ul class="pList">
				<% 
					if (new_list12 != null && new_list12.size() > 0) {
 							try {
								int i = 1;
						for (Enumeration e = new_list12.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(omiBean,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/" + omiBean.getSubfolder() +  "/thumbnail/" + omiBean.getModelimage();

									if (omiBean.getModelimage() == null || omiBean.getModelimage().length() <= 0 || omiBean.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									
									%>
							<li>
								<span class="img"><a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><span class="playPop"></span><img src="<%=imgTmp %>" alt="<%=omiBean.getTitle()%>"/></a></span>
								<span class="total">
									<span class="cate"><a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><%=omiBean.getCtitle()%></a></span>
									<a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><%=omiBean.getTitle()%></a>
								</span>
							</li>
									<% 
				 
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%>
				</ul>
			</div>
			<div class="conProgram">
				<h4>관련 프로그램</h4>
				<ul class="pList">
				
				
				<% 
					if (new_list11 != null && new_list11.size() > 0) {
 							try {
								int i = 1;
						for (Enumeration e = new_list11.elements(); e.hasMoreElements(); i++) {
									com.yundara.beans.BeanUtils.fill(omiBean,(Hashtable) e.nextElement());
									String imgurl = "/2013/include/images/default_img.jpg";
									String imgTmp = SilverLightPath + "/"+omiBean.getSubfolder()+"/thumbnail/" + omiBean.getModelimage();

									if (omiBean.getModelimage() == null || omiBean.getModelimage().length() <= 0 || omiBean.getModelimage().equals("null")) {
										imgTmp = imgurl;
									}
									
									%>
							<li>
								<span class="img"><a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><span class="playPop"></span><img src="<%=imgTmp %>" alt="<%=omiBean.getTitle()%>"/></a></span>
								<span class="total">
									<span class="cate"><a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><%=omiBean.getCtitle()%></a></span>
									<a href="video_player.jsp?ocode=<%=omiBean.getOcode()%>"><%=omiBean.getTitle()%></a>
								</span>
							</li>
									<% 
				 
						}
							} catch (Exception e) {
								out.println("error message :" + e);
							}
						}
					%> 
					
					 
				</ul>
			</div>
			<%@ include file = "../include/sub_topic.jsp"%>
			
		</div>
	</div>
</div>
</body>
</html>