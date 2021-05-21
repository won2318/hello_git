package com.vodcaster.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import com.yundara.util.PageBean;

import dbcp.SQLBeanExt;

public class AdminSqlBean extends SQLBeanExt{
	public AdminSqlBean(){
		super();
	}
	
public Hashtable selectAdminListAll(int page,String query){
	
    Vector v = querymanager.selectEntities(query);
		int totalRecord = v.size();

     PageBean pb = new PageBean(totalRecord, 20, 10, page);

		// 해당 페이지의 리스트를 얻는다.
		String rquery = query + " limit "+ (pb.getStartRecord()-1) + ",20";
     //log.printlog("MovieBoardSQLBean getBoardList method query"+query);
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		ht.put("LIST",result_v);
		ht.put("PAGE",pb);

		return ht;
}

}
