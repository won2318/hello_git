<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%> 
 
 <% 
 String hValue = request.getHeader("user-agent");
String protocal = "http://";
if(hValue.indexOf("Android") != -1)
	//protocal = "rtsp://";
	protocal = "Android";
else if(hValue.indexOf("iPhone") != -1)
	//protocal = "http://";
	protocal = "iPhone";
	
	
 LiveManager lMgr = LiveManager.getInstance();
 
 String live_popup = "";
 Vector v_onair = null;
 String live_url = "";
 String rcode ="";
  try {
  // rcode, rtitle, rcontents, rbcst_time, ralias, 
  // rstart_time, rend_time, rflag, rstatus, rwdate, 
  // rhit, rlevel,rfilename, rid, rimagefile,
  // property_id, openflag,group_id, del_flag, ocode, 
  // otitle, mobile_sream, inoutflag, org_rfilename 
       v_onair =  lMgr.getLive();
  
	    String mobile_stream = String.valueOf(v_onair.elementAt(21)); 
		String tmpIP = DirectoryNameManager.SV_LIVE_SERVER_IP ; 
		
		if(protocal.equals("Android")){
			live_url="rtsp://"+tmpIP+ ":1935"+mobile_stream;
		 }else if(protocal.equals("iPhone")){ 
			 live_url="http://"+tmpIP + ":1935/"+mobile_stream +"/playlist.m3u8";
		} 
		 
 	  }catch(Exception e) {}
  if(v_onair != null && v_onair.size() > 0) {  
 	 out.print("<a href='"+live_url+"'><img src='../include/images/icon_live.gif'  height='24' width='33' alt='LIVE_ON'/> 积规价 矫没窍扁</a>");
  } else {
	  out.print("<a href='LiveSchedule.jsp'><img src='../include/images/icon_live_off.gif'  height='24' width='33' alt='LIVE_OFF'/> 积规价 救郴</a>");
  }
 %>