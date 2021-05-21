package com.hrlee.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class User_tergetManager {
	private static User_tergetManager instance;
	
	private User_tergetSqlBean sqlbean = null;
    
	private User_tergetManager() {
        sqlbean = new User_tergetSqlBean();
    }
    
	public static User_tergetManager getInstance() {
		if(instance == null) {
			synchronized(User_tergetManager.class) {
				if(instance == null) {
					instance = new User_tergetManager();
				}
			}
		}
		return instance;
	}
	
	public int deleteUser_target(String idx) throws Exception {
		if (idx != null && idx.length() > 0) {
		return sqlbean.delete(idx);
		} else {
			return -1;
		}
	}
	

	/*
	 * 소속을 이용한 부서 목록
	 */
	public Vector getSelectGroup(String tcode) {
		if (tcode != null && tcode.length() > 0) {
	        return sqlbean.getSelectGroup(tcode);
		} else {
			return null;
		}

	}

	public Vector getSelectBuseo() {
	
	    return sqlbean.getSelectBuseo();
	}
	
	public Vector getSelectGray() {
	
	    return sqlbean.getSelectGray();
	}

	

}
