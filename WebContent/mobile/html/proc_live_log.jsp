<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%> 
 <%@ include file = "/include/chkLogin.jsp"%> 
 <% 
//////////////////////////////////////////////////////////////
//회원정보 로그화일에 저장
if(request.getParameter("rcode") != null && request.getParameter("rcode").length() > 0) {
 String rcode = request.getParameter("rcode") ;
if(deptcd == null) deptcd = "";
if(gradecode == null) gradecode = "";
com.hrlee.sqlbean.MediaManager.getInstance().insertVodLog( vod_id, vod_name, deptcd, gradecode, rcode, request.getRemoteAddr(),"R" );

String GB = "ML";
int year=0, month=0, date=0;
Calendar cal = Calendar.getInstance();
year  = cal.get(Calendar.YEAR);
month = cal.get(Calendar.MONTH)+1;
date = cal.get(Calendar.DATE);

MenuManager2 mgr2 = MenuManager2.getInstance();
mgr2.insertHit("000000000002",year,month,date,GB);	// 시청 통계 로그
 
}
//////////////////////////////////////////////////////////////
 %>