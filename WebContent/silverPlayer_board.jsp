<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.text.DecimalFormat"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ page import="com.hrlee.sqlbean.MediaManager"%>
 <jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
 <%@ include file="/include/chkLogin.jsp" %>
 <jsp:useBean id="logoInfo" class="com.vodcaster.sqlbean.LogoSqlBean" scope="page" />
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
	String imgTmp = "";
	String Server = request.getParameter("Server").replaceAll("<","").replaceAll(">","");
	String width = request.getParameter("width").replaceAll("<","").replaceAll(">","");
	String height = request.getParameter("height").replaceAll("<","").replaceAll(">","");
	
	
	MediaManager mgr = MediaManager.getInstance();
	if(ocode == null || ocode.length() == 0 || ocode.equals("null")) {
		ocode = "";
	}else{
		vo = mgr.getOMediaInfo_admin(ocode);
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
			.replaceAll("&#126;"," ")
			.replaceAll("&#45;"," ")
			.replaceAll("&lt;"," ")
			.replaceAll("&gt;"," ")
			.replaceAll("&#40;"," ")
			.replaceAll("\""," ")
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
		 
			ofilename = omiBean.getSubfolder()+"/Mobile/"+omiBean.getMobilefilename();
		 
			auth_v = omiBean.getOlevel();
			if (isView && omiBean.getOcode() != "" && StringUtils.isNotEmpty(ofilename)) {
				imgTmp = SilverLightPath + "/"+omiBean.getSubfolder()+"/"+"/thumbnail/"+omiBean.getModelimage();
				if(omiBean.getModelimage()== null || omiBean.getModelimage().length() <=0 ||omiBean.getModelimage().equals("null")) {
					imgTmp = imgurl;
				}
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
 
	if(Server == null || Server.length() == 0 || Server.equals("null")) {
		Server = "";
	}
	
	
	if(width == null || width.length() == 0 || width.equals("null")) {
		width = "642";
	}
	
	
	if(height == null || height.length() == 0 || height.equals("null")) {
		height = "362";
	}
	
	Vector vtLogo = logoInfo.getLogo();

	String top_logo = "";
	String footer_logo = "";
	String media_logo = "";
	String playLogo = "";
	String playLogoPos = "";
	String playLogoOpacity = "0.5";
	double logo_opactiy = 0.1;
	String logoImgTmp = "";
	
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
		logoImgTmp = "http://"+request.getServerName()+"/upload/logo/"+media_logo;
		playLogo =  "http://"+request.getServerName()+"/upload/logo/"+playLogo;
	} else {
		//out.println("<script>alert('err : -999'); window.close();</script>");
	}
	Description = " ";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		
	
		<title>vod player</title>
		<%
	if(user_level <video_level ) {
		out.println("<script type='text/javascript'>");
		out.println("alert('동영상 시청 권한이 없습니다.');");
		out.println("</script>");
	}
%>

	  <script type="text/javascript" src="/Silverlight.js"></script>
    	<script type="text/javascript">

	function returnPath(State1 )
	{
		
		var State1Array  = State1.split("=");
		if(State1Array != null && State1Array.length > 1){
			if(State1Array[1] == 'Opening'){
				//alert('Opening');
			}else if(State1Array[1]  == 'Playing'){
				//alert('Playing');
			}else if(State1Array[1]  == 'Buffering'){
				//alert('Buffering');
			}else if(State1Array[1]  == 'AcquiringLicense'){
				//alert('AcquiringLicense');
			}else if(State1Array[1]  == 'Paused'){
				//alert('Paused');
			}else if(State1Array[1]  == 'Stopped'){
				//alert('Stopped');
			}else if(State1Array[1]  == 'Closed'){
				//alert('Closed');
			}
		}
	}

        function onSilverlightError(sender, args) {
        
            var appSource = "";
            if (sender != null && sender != 0) {
                appSource = sender.getHost().Source;
            } 
            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;
            
            var errMsg = "Unhandled Error in Silverlight Application " +  appSource + "\n" ;

            errMsg += "Code: "+ iErrorCode + "    \n";
            errMsg += "Category: " + errorType + "       \n";
            errMsg += "Message: " + args.ErrorMessage + "     \n";

            if (errorType == "ParserError")
            {
                errMsg += "File: " + args.xamlFile + "     \n";
                errMsg += "Line: " + args.lineNumber + "     \n";
                errMsg += "Position: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError")
            {           
                if (args.lineNumber != 0)
                {
                    errMsg += "Line: " + args.lineNumber + "     \n";
                    errMsg += "Position: " +  args.charPosition + "     \n";
                }
                errMsg += "MethodName: " + args.methodName + "     \n";
            }

            throw new Error(errMsg);
        }
    </script>
  
    </head>
<body>
<%=SilverLightServer%>/ClientBin/Media/<%=ofilename%>
	<div id='errorLocation' style="font-size: small;color: Gray;"></div>
    <div id="silverlightControlHost">
    	<object id="SilverPlayer" data="data:application/x-silverlight-2" type="application/x-silverlight-2" width="185px" height="210px">
			<param name="source" value="/BoardPlayer.xap"/>
			<param name="background" value="black" />
			<param name="initParams" value="mediaSource=<%=SilverLightServer%>/ClientBin/Media/<%=ofilename%>" />
			<param name="enablehtmlaccess" value="true"/>
			<param name="minRuntimeVersion" value="3.0.40624.0" />
			<param name="autoUpgrade" value="true" />

			<a href="http://go.microsoft.com/fwlink/?LinkID=149156" style="text-decoration: none;">
			<img src="http://go2.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none"/> </a>
		</object>
		<iframe title="_sl_historyFrame" id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe>
	 </div>
    
</body>
</html>
				    