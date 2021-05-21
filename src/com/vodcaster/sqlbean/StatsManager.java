package com.vodcaster.sqlbean;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;

public class StatsManager {
	private static StatsManager instance;

	private BestMediaSqlBean sqlbean = null;

	private StatsManager() {
        sqlbean = new BestMediaSqlBean();
       // sqlbean.printLog("BestMediaManager 인스턴스 생성");
    }

	public static StatsManager getInstance() {
		if(instance == null) {
			synchronized(StatsManager.class) {
				if(instance == null) {
					instance = new StatsManager();
				}
			}
		}
		return instance;
	}
	
	
	
	
	public Vector getBestList() {

        String query = "";
        String subquery = "";
        Vector rtn = null;

        try {

            query = "select  coalesce(sum_hit1,0)sum_hit1, coalesce(sum_hit2,0)sum_hit2, ccc.sum_hit3, ccc.mtitle from (" +
            		"select aa.muid muid1,aa.sum_hit as sum_hit1, bb.muid as muid2, bb.sum_hit as sum_hit2 from" +
            		"(select a.day, a.muid, b.mtitle , ifnull(sum(a.cnt),0) as sum_hit from menu b left outer join contact_stat_menu a on  b.muid = a.muid"+
					"where   day = '20121011' and a.flag='W'"+
					"group by a.muid, a.day)aa"+ 
					"right OUTER JOIN  "+
					"(select substr(a.day,1,6), a.muid, b.mtitle , ifnull(sum(a.cnt),0) as sum_hit from menu b left outer join contact_stat_menu a on  b.muid = a.muid"+
					"where   day like '201210%' and a.flag='W'"+
					"group by a.muid, substr(a.day,1,6))bb on bb.muid = aa.muid"+
					")dd"+
					"right OUTER JOIN  "+
					"(select substr(a.day,1,4), a.muid, b.mtitle , ifnull(sum(a.cnt),0)  as sum_hit3"+ 
					"from menu b left outer join contact_stat_menu a on  b.muid = a.muid"+
					"where   day like '2012%' and a.flag='W'"+
					"group by a.muid, substr(a.day,1,4))ccc on ccc.muid = dd.muid1";
            rtn = sqlbean.getBestList(query);
        }catch(Exception e) {
        	System.err.println("getBestList ex : " + e.getMessage());
        	rtn = null;
        }

        return rtn;

    }
}
