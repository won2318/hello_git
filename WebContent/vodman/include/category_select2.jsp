<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	
	String ctype = request.getParameter("ctype");
	String info = request.getParameter("info");
	String category = request.getParameter("category");
	
	CategoryManager cmgr = CategoryManager.getInstance();
	Vector vList = null;
	if(info.equals("A") || category != null && category.length()>0){
		if (category == null || category.equals("")||category.equals("null")) {
			vList = cmgr.getCategoryListALL3(ctype, info);
		} else {
			vList = cmgr.getCategoryListALL3(ctype, info, category);
		}
	}

	CategoryInfoBean infoBean = new CategoryInfoBean();
	StringBuffer results = new StringBuffer("<?xml version='1.0' encoding='EUC-KR'?><categories>");
	if(vList != null && vList.size()>0){
		for(Enumeration e = vList.elements(); e.hasMoreElements();) {
			com.yundara.beans.BeanUtils.fill(infoBean, (Hashtable)e.nextElement());

			results.append("<category>");
			results.append("<ccode>");
			results.append(infoBean.getCcode());
			results.append("</ccode>");
			results.append("<ctitle>");
			results.append(infoBean.getCtitle());
			results.append("</ctitle>");
			results.append("</category>");

		}
	}
	results.append("</categories>");
	response.setContentType("text/xml");
	response.getWriter().write(results.toString());

%>