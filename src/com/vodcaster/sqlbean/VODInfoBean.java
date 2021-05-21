package com.vodcaster.sqlbean;

import javax.servlet.http.HttpServletRequest;

import dbcp.SQLBeanExt;

public class VODInfoBean extends SQLBeanExt implements java.io.Serializable{
	public  VODInfoBean(){
		super();
	}
	
	public int move_cate_admin(HttpServletRequest req  ) throws Exception 
	{
		try{
 
			String[] vod_ocode = req.getParameterValues("v_chk"); 
			String taget = req.getParameter("ccode");
			String flag = req.getParameter("flag");
		 	int rtn = 0;
		 	
		 	String sub_query = "";
		 	if (flag != null && flag.equals("V")) {
		 		sub_query=" ccode ";
		 	} else if (flag != null && flag.equals("Y")) {
		 		sub_query=" ycode";
		 	}
			
		 	if (vod_ocode != null && vod_ocode.length > 0) {
		 		String query = "update vod_media set "+sub_query+" = ? where ocode = ? ";
				rtn = querymanager.batchUpdateEntities(query,vod_ocode,taget);
		 	} else {
		 		rtn = -1;
		 	}

		 	return rtn;
		} catch(Exception e) {
			return -99;
		}
 
	}
 
}
