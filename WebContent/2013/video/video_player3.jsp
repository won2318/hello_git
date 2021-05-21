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
		vo = mgr.getCode_1_cate(ccode, "desc", Integer.parseInt(vod_level)); // ī�װ��� �ֽ� ���� ���� ���� ����
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
		//�̵�� ���̵� ���� ��� 
		isView = false;
	}
	if (isView && omiBean.getOcode() != "" && StringUtils.isNotEmpty(ofilename)) {
		//ȸ������ �α�ȭ�Ͽ� ����
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

//  �޸� �б�

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
    	//������� ����.
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
	<title>���� iTV</title>
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
	    url: "/2013/comment/comment_list.jsp",  //<- �̵��� �ּ� 
	    global: false, //<- 
	    type: "POST",  //<-  ������ Ÿ�� 
	    data: $("#comment_form").serialize(),  //<-  ���� �Ķ��Ÿ 
	    dataType: "html",  //<-  ������Ÿ�� 
	    async:false,
	    success: function(data){  //<-  �����϶� 
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

	if (confirm("�޸� �����Ͻðڽ��ϱ�")) {
		if (muid != "") {
			f.muid.value=muid;
			f.submit();
		}
	}
}

</script>
<noscript>
�˼��մϴ�! ��ũ��Ʈ�� �������� �ʴ� ������ �Դϴ�! <br/> 
�Ϻ� ���α׷��� ��Ȱ�ϰ� �۵� ���� ������ �ֽ��ϴ�!<br/> 
</noscript>
<div id="pWrap">
	<!-- container::���������� -->
	<div id="pLogo">
		<h2><a href="/"><img src="../include/images/view_logo.gif" alt="���� iTV Ȩ������ �ٷΰ���"/></a></h2>
		<span class="close"><a href="/"><img src="../include/images/btn_view_close.gif" alt="�ݱ�"/><img src="../include/images/btn_close.gif" class="imgClose" alt="CLOSE"/> </a></span>
	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 class="pTitle"><%=otitle%></h3>
			<span class="pTime">����� : <%=mk_date%>&nbsp;&nbsp;|&nbsp;&nbsp;��۽ð� : <%=oPlay_time%></span>
			<div class="pPlayer">
				<div id="SilverlightControlHost" class="silverlightHost" >
					<iframe title="�ǹ�����Ʈ ������ ��� â" id="bestVod" name="bestVod" src="/silverPlayer.jsp?ocode=<%=ocode%>&width=579&height=362&auto_p=<%=auto_p%>" scrolling="no" width="579" height="362" marginwidth="0" frameborder="0" framespacing="0" ></iframe>
				</div> 
			</div>
			<div class="pSubject"><%=chb.getContent_2(odesc,"true")%></div>
			<span class="pRecomIcon"><a href="/"><img src="../include/images/btn_like.gif" alt="���ƿ� Like!"/></a></span>
			<!-- comment::��� -->
			<div class="comment" id="comment"></div> 
			<!-- //comment::��� -->
		</div>

		<div class="pAside">
			<div class="pInfo">
				<span class="pHit">�÷��̼�<span><%=oHit_count%></span></span>
				<span class="pRecom">��õ��<span><%=recomcount%></span></span>
			</div>
			<div class="pLink">
				<span>�����ϱ� <a href="/"><img src="../include/images/icon_view_link.gif" alt="��ũ"/></a>  <a href="/"><img src="../include/images/icon_view_twitter.gif" alt="Ʈ����"/></a> <a href="/"><img src="../include/images/icon_view_facebook.gif" alt="���̽���"/></a></span>
			</div>
			<div class="conContent">
				<h4>���� ������</h4>
				<ul class="pList">
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
				</ul>
			</div>
			<div class="conProgram">
				<h4>���� ���α׷�</h4>
				<ul class="pList">
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
				</ul>
			</div>
			<div class="topic">
				<h4>ȭ���� ����</h4>
				<ul class="pList">
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img2.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
					<li>
						<span class="img"><a href=""><span class="playPop"></span><img src="../include/images/img.gif" alt="�̹�����"/></a></span>
						<span class="total">
							<span class="cate"><a href="#">ī�װ�</a></span>
							<a href="#">���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� ���� �ͺ��� �ϳ���</a>
						</span>
					</li>
				</ul>
			</div>
			
		</div>
		
	</div>
	
	
</div>



</body>
</html>