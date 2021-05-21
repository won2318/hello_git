<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ page import="com.hrlee.sqlbean.MediaManager"%>
 <jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
 <%@ include file="/include/chkLogin.jsp" %>
 <jsp:useBean id="logoInfo" class="com.vodcaster.sqlbean.LogoSqlBean" scope="page" />
 <jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
 <jsp:useBean id="contactLog" class="com.vodcaster.sqlbean.WebLogManager" />
<%
if(!chk_auth(vod_id, vod_level, "v_player")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
contact.setPage_cnn_cnt("W"); // 페이지 접속 카운트 증가
contact.setValue(request.getRemoteAddr(),"guest", "W");  //  접속 카운트 
contactLog.setStatVisitInfo(request);
 
	Vector vo = null;
	boolean bOmibean = false;
	boolean isView = true;
	String Description = "";
	String ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
	
	String video_ccode = "";//
	String otitle = "";
	String ofilename = "";
	int video_level = 0;
	int user_level = 0;
	String imgurl ="/2011/images/sub/noimg_wi.gif";
	String logoImgTmp = "";
	//String Server = request.getParameter("Server");
	String width = request.getParameter("width").replaceAll("<","").replaceAll(">","");
	String height = request.getParameter("height").replaceAll("<","").replaceAll(">","");
	
	String auto_p = "";

	if(request.getParameter("auto_p") != null && request.getParameter("auto_p").length()>0 && !request.getParameter("auto_p").equals("null") && request.getParameter("auto_p").equals("True") ) {
		auto_p = "True";
	} else{
		auto_p = "False";
	}

	MediaManager mgr = MediaManager.getInstance();
	if(ocode == null || ocode.length() == 0 || ocode.equals("null")) {
		ocode = "";
	}else{
		vo = mgr.getOMediaInfo_cate(ocode);
	}
	
	int auth_v = 1;
	if (vo != null && vo.size() > 0) {
		try {
			Enumeration e2 = vo.elements();
			com.yundara.beans.BeanUtils.fill(omiBean, (Hashtable) e2.nextElement());
			//Description = omiBean.getDescription();
			otitle = omiBean.getTitle();
			video_ccode = omiBean.getCcode();
			
			otitle = otitle.replaceAll("&amp;"," ")
			.replaceAll("&#35;"," ")
			.replaceAll(","," ")
			.replaceAll("&#180;"," ")
			.replaceAll("&#43;"," ")
			.replaceAll("&34;"," ")
			.replaceAll("&#39;"," ")
			.replaceAll("\""," ")
			.replaceAll("&#126;"," ")
			.replaceAll("&#45;"," ")
			.replaceAll("&lt;"," ")
			.replaceAll("&gt;"," ")
			.replaceAll("&#40;"," ")
			.replaceAll("&#41;"," ")
			.replaceAll("&quot"," ");
			while(otitle.indexOf("&#36;")>=0){
				otitle = otitle.replace("&#36;"," ");
			}
			
			//Description = Description.replaceAll("&amp;","&").replaceAll("&#35;","#").replaceAll("&#180;","'").replaceAll("&#43;","+").replaceAll("&34;","\"").replaceAll("&#39;","'").replaceAll("&#126;","~").replaceAll("&#45;","-").replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("&#40;","\\(").replaceAll("&#41;","\\)");
			//while(Description.indexOf("&#36;")>=0){
			//	Description = Description.replace("&#36;","$");
			//}
			video_level = omiBean.getOlevel();
			bOmibean = true;
			isView = true;
			ofilename = omiBean.getSubfolder()+"/Encoded/"+omiBean.getEncodedfilename();
			auth_v = omiBean.getOlevel();
			if (isView && omiBean.getOcode() != "" && StringUtils.isNotEmpty(ofilename)) {
				logoImgTmp = SilverLightPath + "/"+omiBean.getSubfolder()+"/thumbnail/"+omiBean.getModelimage();
				if(omiBean.getModelimage()== null || omiBean.getModelimage().length() <=0 ||omiBean.getModelimage().equals("null")) {
					logoImgTmp = imgurl;
				}
				
				

				//회원정보 로그화일에 저장
				if(deptcd == null) deptcd = "";
				if(gradecode == null) gradecode = "";
				com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, omiBean.getOcode(), request.getRemoteAddr(),"V" );
				
				String GB = "WV";
				int year=0, month=0, date=0;
				Calendar cal = Calendar.getInstance();
				year  = cal.get(Calendar.YEAR);
			    month = cal.get(Calendar.MONTH)+1;
			    date = cal.get(Calendar.DATE);
				MenuManager2 mgr2 = MenuManager2.getInstance();
				mgr2.insertHit(omiBean.getCcode(),year,month,date,GB);	// 시청 통계 로그
				
				
			}
		} catch (Exception e2) {
			System.err.println(e2.getMessage());
			isView = false;
		}
	}

	
	
	if (vod_level != null) {
	
		try{
			user_level = Integer.parseInt(vod_level);
		}catch(Exception e){
			user_level = 0;
		}
		
	} 
	
	
	if(width == null || width.length() == 0 || width.equals("null")) {
		width = "521";
	}
	
	
	if(height == null || height.length() == 0 || height.equals("null")) {
		height = "339";
	}
	
	Vector vtLogo = logoInfo.getLogo();

	String top_logo = "";
	String footer_logo = "";
	String media_logo = "";
	String playLogo = "";
	String playLogoPos = "";
	String playLogoOpacity = "0.5";
	double logo_opactiy = 0.1;
	
	if(vtLogo != null && vtLogo.size() > 0) {
		top_logo = String.valueOf(vtLogo.elementAt(1));
		footer_logo = String.valueOf(vtLogo.elementAt(2));
		media_logo = String.valueOf(vtLogo.elementAt(4));
		playLogo= String.valueOf(vtLogo.elementAt(5));
		playLogoPos= String.valueOf(vtLogo.elementAt(6));
		playLogoOpacity= String.valueOf(vtLogo.elementAt(7));
		try{
			
			if (playLogoOpacity != null && playLogoOpacity.length() > 0  ) {
					logo_opactiy = Double.parseDouble(playLogoOpacity) * 0.01;
				}
		}catch(Exception ex){
		}
		//logoImgTmp = "http://"+request.getServerName()+"/upload/logo/"+media_logo;
		playLogo =  "http://"+request.getServerName()+"/upload/logo/"+playLogo;
	} else {
		//out.println("<script>alert('err : -999'); window.close();</script>");
	}
	Description = " ";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<style type="text/css">
		* {margin:0; padding:0;}
		</style>
	
		<title>vod player</title>
		<%
// 	if(user_level <video_level ) {
// 		out.println("<script type='text/javascript'>");
// 		out.println("alert('동영상 시청 권한이 없습니다.');");
// 		out.println("</script>");
// 	}
%>
<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/Silverlight.js"></script>
	
	<script type="text/javascript" src="/2013/include/js/jquery.min.js"></script>
	<script type="text/javascript" src="/2013/include/js/jquery.validate.js"></script>
	<script type="text/javascript" src="/2013/include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="/2013/include/js/jquery.masonry.min.js"></script>
	<script type="text/javascript" src="/2013/include/js/script.js"></script>
 
    </head>
<body>
	<div id='errorLocation' style="font-size: small;color: Gray;"></div>
    <div id="silverlightControlHost">
        <object id="silver_player" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="<%=width%>" height="<%=height%>" style="z-index:0;">
		  <param name="source" value="WowzaPlayer.xap"/> 
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
    
</body>
</html>
				    