<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	
	String info = request.getParameter("info");
	String menu = request.getParameter("menu");
	
	MenuManager cmgr = MenuManager.getInstance();
	Vector vList = null;
	
	if(info.equals("A") || menu != null && menu.length()>0){
		if (menu == null || menu.equals("")||menu.equals("null")) {
			vList = cmgr.getMenuListALL( info);
		} else {
			vList = cmgr.getMenuListALL( info, menu);
		}
	}
	
 
	MenuInfoBean infoBean = new MenuInfoBean();
	StringBuffer results = new StringBuffer("<?xml version='1.0' encoding='EUC-KR'?><menus>");
	if(vList != null && vList.size()>0){
		for(Enumeration e = vList.elements(); e.hasMoreElements();) {
			com.yundara.beans.BeanUtils.fill(infoBean, (Hashtable)e.nextElement());

			results.append("<menu>");
			results.append("<mcode>");
			results.append(infoBean.getMcode());
			results.append("</mcode>");
			results.append("<mtitle>");
			results.append(infoBean.getMtitle());
			results.append("</mtitle>");
			results.append("</menu>");

		}
	}
	results.append("</menus>");
	response.setContentType("text/xml");
	response.getWriter().write(results.toString());

%>