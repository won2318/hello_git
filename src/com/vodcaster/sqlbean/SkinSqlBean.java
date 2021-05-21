/*
 * Created on 2005. 1. 19
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

/**
 * @author 최희성
 *
 * 스킨시스템 DB관련정보
 */

import java.util.*;
import javax.servlet.http.*;
import dbcp.SQLBeanExt;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;

public class SkinSqlBean extends SQLBeanExt {

    public SkinSqlBean() {
		super();
	}


    public Vector selectQueryList(String query) {
        return querymanager.selectHashEntities(query);
    }



    public Vector selectQueryListExt(String query) {
        return querymanager.selectEntities(query);
    }


    public Vector selectQuery(String query) {
        return querymanager.selectEntity(query);
    }


    public int executeQuery(String query) {
        return querymanager.updateEntities(query);
    }

 
	
	public int updatePOP(String query) throws Exception {

		Vector row = null;
		int iRtn = -1;
        try {
        	iRtn = querymanager.executeQuery(query);

        } catch(Exception e) {
            System.err.println("updatePOP ex "+e.getMessage());
        }

        return iRtn;
	}
}
