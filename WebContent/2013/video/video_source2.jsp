<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ page import="com.vodcaster.sqlbean.DirectoryNameManager,com.vodcaster.utils.TextUtil"%>
<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
 
<% request.setCharacterEncoding("UTF-8"); 

MediaManager mgr = MediaManager.getInstance();
String ocode ="";
if (request.getParameter("ocode") != null && request.getParameter("ocode").length() > 0  && !request.getParameter("ocode").equals("null") && com.yundara.util.TextUtil.isNumeric(request.getParameter("ocode"))) {
	ocode = com.vodcaster.utils.TextUtil.getValue(request.getParameter("ocode"));
}

Vector vo = null;
if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
	vo = mgr.getOMediaInfo_cate(ocode); 
} 
String media_src1 = "";
String media_src2 = "";
String media_src3 = "";

if (vo != null && vo.size() > 0) {
	try {
		Enumeration e2 = vo.elements();
		com.yundara.beans.BeanUtils.fill(omiBean, (Hashtable) e2.nextElement()); 
 		media_src1 = "mp4:"+omiBean.getSubfolder()+"/Mobile/"+omiBean.getEncodedfilename();
 		media_src2 = "mp4:"+omiBean.getSubfolder()+"/Medium/"+omiBean.getEncodedfilename();
 		media_src3 = "mp4:"+omiBean.getSubfolder()+"/Encoded/"+omiBean.getEncodedfilename();
	} catch (Exception e2) {
		System.err.println(e2.getMessage());
	 
	}
}else{

}

%>    
[  {
	"streamer"  : "rtmp://27.101.101.113:1935/newsuwon",
    "media_src1"  : "<%=media_src1 %>",
    "media_src2"  : "<%=media_src2 %>",
    "media_src3"  : "<%=media_src3 %>"
} ]


