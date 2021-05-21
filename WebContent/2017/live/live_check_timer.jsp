<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%> 
 
 <% 
 LiveManager lMgr = LiveManager.getInstance();
 String play_btn = "";
 String live_popup = "";
 Vector v_onair = null;
 String rcode ="";
  try {
  // rcode, rtitle, rcontents, rbcst_time, ralias, 
  // rstart_time, rend_time, rflag, rstatus, rwdate, 
  // rhit, rlevel,rfilename, rid, rimagefile,
  // property_id, openflag,group_id, del_flag, ocode, 
  // otitle, mobile_sream, inoutflag, org_rfilename 
   	      v_onair =  lMgr.getLive();
 
 	  }catch(Exception e) {}
  if(v_onair != null && v_onair.size() > 0) {  
 	 out.print("<a href='javascript:live_open();'><img src='../include/images/icon_live.gif' alt='LIVE'/></a>");
  } else {
	  out.print("<img src='../include/images/icon_live_off.gif' alt='life_off'/>");
  }
 %>