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
	
	String auto_p = "";

	if(request.getParameter("auto_p") != null && request.getParameter("auto_p").length()>0 && !request.getParameter("auto_p").equals("null") && request.getParameter("auto_p").equals("True") ) {
		auto_p = "True";
	} else{
		auto_p = "False";
	}
	
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

	} else {
		vo = mgr.getCode_1_cate(ccode, "desc", Integer.parseInt(vod_level)); // 카테고리의 최신 영상 정보 가져 오기
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
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
 	<script type="text/javascript" src="../include/js/jquery.min.js"></script>
</head>
<body>

<script language="javascript">
$(document).ready( function(){
	 $.get('/2013/comment/comment_list.jsp', {'ocode' : '<%=ocode%>', 'page' : '1'}, function(data){
		 $("#comment").html(data);
     });
		return false;
	}
	);
	
 
function page_go(){
 	var bodyContent = $.ajax({
	    url: "/2013/comment/comment_list.jsp",  //<- 이동할 주소 
	    global: false, //<- 
	    type: "POST",  //<-  보낼때 타입 
	    data: $("#comment_form").serialize(),  //<-  보낼 파라메타 
	    dataType: "html",  //<-  받을때타입 
	    async:false,
	    success: function(data){  //<-  성공일때 
	    	alert(data);
	    	 if (data != "") {
                 $("div#comment").detach();
                 $("#comment").html(data);
                 
             } 
	    }
	 }
	);
}

function deleteChk(muid) {
	var f = document.comment_del

	if (confirm("메모를 삭제하시겠습니까")) {
		if (muid != "") {
			f.muid.value=muid;
			f.submit();
		}
	}
}

</script>
<noscript>
죄송합니다! 스크립트를 지원하지 않는 브라우져 입니다! <br/> 
일부 프로그램이 원활하게 작동 하지 않을수 있습니다!<br/> 
</noscript>
<div id="pWrap">
	<!-- container::메인컨텐츠 -->
	<div id="pLogo">
		<h2><a href="/"><img src="../include/images/view_logo.gif" alt="수원 iTV 홈페이지 바로가기"/></a></h2>
		<span class="close"><a href="/"><img src="../include/images/btn_view_close.gif" alt="닫기"/><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/> </a></span>
	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle"><%=otitle%></h3>
			<span class="pTime">등록일 : <%=mk_date%>&nbsp;&nbsp;|&nbsp;&nbsp;방송시간 : <%=oPlay_time%></span>
			<div class="pPlayer">
				<div id="SilverlightControlHost" class="silverlightHost" >
					<iframe title="실버라이트 동영상 재생 창" id="bestVod" name="bestVod" src="/silverPlayer.jsp?ocode=<%=ocode%>&width=579&height=362&auto_p=<%=auto_p%>" scrolling="no" width="579" height="362" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
				</div> 
			</div>
			<div class="pSubject"><%=chb.getContent_2(odesc,"true")%></div>
			<span class="pRecomIcon"><a href="/"><img src="../include/images/btn_like.gif" alt="좋아요 Like!"/></a></span>
			<!-- comment::댓글 -->
			<div class="comment" id="comment"></div> 
			<!-- //comment::댓글 -->
		</div>

		<div class="pAside">
			<div class="pInfo">
				<span class="pHit">플레이수<span><%=oHit_count%></span></span>
				<span class="pRecom">추천수<span><%=recomcount%></span></span>
			</div>
			<div class="pLink">
				<span>공유하기 <a href="/"><img src="../include/images/icon_view_link.gif" alt="링크"/></a>  <a href="/"><img src="../include/images/icon_view_twitter.gif" alt="트위터"/></a> <a href="/"><img src="../include/images/icon_view_facebook.gif" alt="페이스북"/></a></span>
			</div>
			<div class="conContent">
				<h4>관련 컨텐츠</h4>
				<ul class="pList">
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
				</ul>
			</div>
			<div class="conProgram">
				<h4>관련 프로그램</h4>
				<ul class="pList">
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
				</ul>
			</div>
			<div class="topic">
				<h4>화제의 영상</h4>
				<ul class="pList">
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="이미지명"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">카테고리</a></span>
							<a href="#">작은 것부터 작은 것부터 작은 것부터 작은 것부터 작은 것부터 하나씩</a>
						</span>
					</li>
				</ul>
			</div>
			
		</div>
		
	</div>
	
	
</div>



</body>
</html>