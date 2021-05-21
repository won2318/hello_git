<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*"%>
<%@page import="com.yundara.util.TextUtil"%>
<%@page import="com.hrlee.sqlbean.MenuManager2"%>
<%
		String GB = "ML";
		int year=0, month=0, date=0;
		Calendar cal = Calendar.getInstance();
		year  = cal.get(Calendar.YEAR);
		month = cal.get(Calendar.MONTH)+1;
		date = cal.get(Calendar.DATE);
			
		MenuManager2 mgr2 = MenuManager2.getInstance();
		mgr2.insertHit("000000000002",year,month,date,GB);
%>