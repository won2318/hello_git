<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/html; charset=UTF-8"%>
 
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<jsp:useBean id="logoInfo" class="com.vodcaster.sqlbean.LogoSqlBean" scope="page" />
<jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<% 

String ocode = "";

if(request.getParameter("ocode") == null || request.getParameter("ocode").length()<=0 || request.getParameter("ocode").equals("null")) {
	//out.println("<script lanauage='javascript'>alert('미디어코드가 없습니다. 다시 선택해주세요.'); self.close(); </script>");
} else
	ocode = request.getParameter("ocode");

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
String ofilename="";
com.hrlee.sqlbean.MediaManager mgr = com.hrlee.sqlbean.MediaManager.getInstance();
	Vector vt = mgr.getOMediaInfo_cate(ocode);			// 주문형미디어 서브정보
	com.hrlee.silver.OrderMediaInfoBean info = new com.hrlee.silver.OrderMediaInfoBean();
	if(vt != null && vt.size()>0){
		try {
			Enumeration e = vt.elements();
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
			imgTmpThumb = DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media/"+info.getSubfolder()+"/thumbnail/"+info.getModelimage();
			if (info.getThumbnail_file() != null && info.getThumbnail_file().indexOf(".") > 0) {
				imgTmpThumb = "http://tv.suwon.go.kr/upload/vod_file/"+info.getThumbnail_file();
			}
			ocode = info.getOcode();
			oHit_count = info.getHitcount();
			oPlay_time = info.getPlaytime();
			otitle = info.getTitle();
			odesc = info.getDescription();
			mk_date = info.getMk_date();
			
			mgr.setOrdermediaHit(ocode);  // 조횟수 증가
			ofilename = info.getSubfolder()+"/Encoded/"+info.getEncodedfilename();
			 
		} catch (Exception e) {
			//out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.');self.close(); </script>");
		}
	}else{
		//out.println("<script lanauage='javascript'>alert('동영상 정보 조회에 실패하였습니다. 이전 페이지로 이동합니다.'); self.close(); </script>");
	}
	
	
	Vector logo_vt = null;
	logo_vt = logoInfo.getLogo();
	
	String top_logo = "";
	String footer_logo = "";
	String media_logo = "";
	String play_logo = "";
	String play_pos = "";
	String high_quality = "";
	String opacity = "";
	if(logo_vt != null && logo_vt.size() > 0) {
	 
		top_logo = String.valueOf(logo_vt.elementAt(1));
		footer_logo = String.valueOf(logo_vt.elementAt(2));
		media_logo = String.valueOf(logo_vt.elementAt(4));
		play_logo = String.valueOf(logo_vt.elementAt(5));
		play_pos = String.valueOf(logo_vt.elementAt(6));
		high_quality = String.valueOf(logo_vt.elementAt(7));
		opacity = String.valueOf(logo_vt.elementAt(8)); 
	} else {
		//out.println("<script>alert('err : 영상 로고 정보를 불러 올수 없습니다!');</script>");
	}	
%>	
	<values>
 
				<![CDATA[
		AutoPlay=<%=auto_p%>
		,AutoReplay=False
		,WebServerUri=<%=DirectoryNameManager.SERVERNAME%>/
		,SilverligtServerUri=<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME%>
		,StartLogoUrl=<%=imgTmpThumb%>
		,PlayLogoUrl=<%=DirectoryNameManager.SERVERNAME%>/upload/logo/<%=play_logo%>
		,PlayLogoOpacity=0.71
		,PlayLogoPosition=2
		,playlist=&lt;playList>
          <playListItems>
              <playListItem title="<%=info.getTitle()%>" 
                  description="" 
				  
                  mediaSource="<%=DirectoryNameManager.WOWZA_SERVER_IP%><%=ofilename%>/Manifest"
				  publishURL="<%=DirectoryNameManager.SERVERNAME%>/index_link.jsp?ocode=<%=info.getOcode()%>&amp;ccode=<%=info.getCcode()%>"
				  
                  ocode="<%=info.getOcode() %>"
                  ccode="<%=info.getCcode() %>"
                  adaptiveStreaming="False" 
                  thumbSource="<%=imgTmpThumb%>" 
                  frameRate="29" >
                  <chapters>
<%
                        Vector img_vector = mgr.getMediaImages(ocode);
                if (img_vector != null && img_vector.size() > 0) {
                for (int i=0; i < img_vector.size(); i++) {
                    String img_time = String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(3));  // 시간 -초단위로 변경
                    int temp_time = 0;
                    if (img_time.length() > 6) {
                    	temp_time = 60*60 * Integer.parseInt(img_time.substring(0,2));
                    	temp_time += 60* Integer.parseInt(img_time.substring(3,5));
                    	temp_time += Integer.parseInt(img_time.substring(6,8));
                    }
                   
                    String img_url = String.valueOf(((Vector)img_vector.elementAt(i)).elementAt(1));  // 이미지파일
                    imgTmpThumb = DirectoryNameManager.SILVERLIGHT_SERVERNAME + "/ClientBin/Media/"+info.getSubfolder()+"/thumbnail/_small/"+img_url;
                    
            %>
 					<chapter  position="<%=temp_time%>" thumbnailSource="<%=imgTmpThumb%>" title="<%=img_time%>초 " />
            <%
                }
                }
            %>

                 </chapters>
                </playListItem>
            </playListItems>
        </playList>
 				]]>
 	
 </values>