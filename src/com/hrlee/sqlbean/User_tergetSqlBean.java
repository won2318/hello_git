package com.hrlee.sqlbean;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import dbcp.SQLBeanExt;
import com.yundara.util.CharacterSet;

public class	User_tergetSqlBean extends SQLBeanExt{
	 public User_tergetSqlBean() {
			super();
		}
	 public Vector getSelectGroup(String tcode){
		 if (tcode != null && tcode.length() > 0){
		 String query = "select * from user_target where tcode=" +tcode;
		 Vector v = null;
		 try{
			 v= querymanager.selectEntities(query);
		 }catch(Exception ex){
			 System.err.println(ex.getMessage());
		 }
		 return v;
		 } else {
			 return null;
		 }
	 }


	 
		public int write(HttpServletRequest req) throws Exception 
		{
 
			int iReturn = -1;
		
			try{
				
			////////////////
			//  목차 정보 //
			////////////////

			String[] select_group = req.getParameterValues("user_target");
			
			String tcode  = "";
 
			String etc  = "";

			String query = "";
 
			//파라메타 값이 들어오는지 체크한다.


			
			if(req.getParameter("tcode") !=null && req.getParameter("tcode").length()>0) {
				tcode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("tcode")));
			}

			if(req.getParameter("etc") !=null && req.getParameter("etc").length()>0) {
				etc = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("etc")) );
 			}
 
			
	        if (select_group != null && select_group.length != 0 ) {
	            for (int i=0; i < select_group.length; i++) {
	            	User_tergetInfoBean omsib = new User_tergetInfoBean();

		            String query1 = " INSERT INTO user_target( tcode, select_group, etc ) VALUES ";
		            
	                if (StringUtils.isNotBlank(select_group[i]) ) {
	                    omsib.setSelect_group(select_group[i]);
	                    query = query1 +
                        " ('"+tcode+
                        "' , '" + com.vodcaster.utils.TextUtil.getValue(omsib.getSelect_group()) + 
                        "' , '" + etc + "' " +
                        " )";
	                    
	                    //System.out.println(query);
                iReturn =  querymanager.updateEntities(query);
	                }
	            }
	        }

			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			return iReturn;
		}
		
		
		public int delete(HttpServletRequest req) throws Exception 
		{
 
			int iReturn = -1;
		
			try{
				
			////////////////
			//  목차 정보 //
			////////////////

			String[] select_group = req.getParameterValues("user_target");
			
			//파라메타 값이 들어오는지 체크한다.
			
	        if (select_group != null && select_group.length != 0 ) {
	            for (int i=0; i < select_group.length; i++) {
	            	User_tergetInfoBean omsib = new User_tergetInfoBean();
 
	            	  if (StringUtils.isNotBlank(select_group[i]) ) {
		                    omsib.setIdx(Integer.parseInt(select_group[i]));
		                    
		                    System.out.println(Integer.parseInt(select_group[i]));
		                    
		                    String query = "delete from user_target where idx = " + omsib.getIdx();
		                    
//		                    System.out.println("query1="+query);
		                    iReturn =  querymanager.updateEntities(query);
		                }

	                }
	            }

			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			return iReturn;
		}
		
		
		
		
	public int delete(String seq) throws Exception 
		{
			int iResult = -1;
			if (seq != null && seq.length() > 0 ) {
			String query = "delete from user_target where idx = " + seq;
			try{
				iResult = querymanager.updateEntities(query);
				
			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			}
			return iResult;
		}
	
	public int delete_group(String tcode) throws Exception 
	{
		int iResult = -1;
		
		if (tcode != null && tcode.length() > 0 ) {
		String query = "delete from user_target where tcode = " + tcode;
		try{
			iResult = querymanager.updateEntities(query);
			
		}catch(Exception ex){
			System.err.println(ex.getMessage());
		}
		}
		return iResult;
	}
	
	
	public Vector getSelectBuseo(){
		 String query = "select * from buseo";
		 Vector v = null;
		 try{
			 v= querymanager.selectEntities(query);
		 }catch(Exception ex){
			 System.err.println(ex.getMessage());
		 }
		 return v;
	}
	
	public Vector getSelectGray(){
		 String query = "select * from gray";
		 Vector v_gray = null;
		 try{
			 v_gray = querymanager.selectEntities(query);
		 }catch(Exception ex){
			 System.err.println(ex.getMessage());
		 }
		 return v_gray;
	} 

}
