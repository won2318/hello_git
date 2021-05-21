<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,com.vodcaster.sqlbean.*, com.yundara.util.*"%>
 
<%
	
	String ctype = request.getParameter("ctype");
	String info = request.getParameter("info");
	String category = request.getParameter("vcategory");
	
	CategoryManager cmgr = CategoryManager.getInstance();
	Vector vList = null;
	if(info.equals("A") || category != null && category.length()>0){
		if (category == null || category.equals("")||category.equals("null")) {
			vList = cmgr.getCategoryListALL3(ctype, info);
		} else {
			vList = cmgr.getCategoryListALL3(ctype, info, category);
		}
	}

	com.hrlee.sqlbean.CategoryInfoBean infoBean = new com.hrlee.sqlbean.CategoryInfoBean();
	StringBuffer results = new StringBuffer("<?xml version='1.0' encoding='EUC-KR'?><vcategories>");
	if(vList != null && vList.size()>0){
		for(Enumeration e = vList.elements(); e.hasMoreElements();) {
			com.yundara.beans.BeanUtils.fill(infoBean, (Hashtable)e.nextElement());

			results.append("<vcategory>");
			results.append("<ccode>");
			results.append(infoBean.getCcode());
			results.append("</ccode>");
			results.append("<ctitle>");
			results.append(infoBean.getCtitle());
			results.append("</ctitle>");
			results.append("</vcategory>");

		}
	}
	results.append("</vcategories>");
	response.setContentType("text/xml");
	response.getWriter().write(results.toString());

%>