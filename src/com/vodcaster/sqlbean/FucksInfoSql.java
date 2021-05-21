package com.vodcaster.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import com.yundara.util.PageBean;

import dbcp.*;

public class FucksInfoSql  extends SQLBeanExt{
	public FucksInfoSql(){
		super();
	}
	/*****************************************************
		욕설 리스트 페이지 처리 후 출력.<p>
		<b>작성자</b> : 이희락<br>
		@return 검색된 욕설 리스트<br>
		@param 검색 Query
	 ******************************************************/
	public Hashtable selectFucksListAll(int page, String query, String count_query, int limit){

		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(count_query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}

        PageBean pb = new PageBean(totalRecord, limit, 10, page);

		// 해당 페이지의 리스트를 얻는다.
		String rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		Vector result_v = querymanager.selectHashEntities(rquery);
		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size()>0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST",new Vector());
			ht.put("PAGE",new PageBean());
		}

		return ht;
	}
	
	/*****************************************************
		욕설 전체 리스트 출력.<p>
		<b>작성자</b> : 이희락<br>
		@return 검색된 욕설 리스트<br>
		@param 검색 Query
	 ******************************************************/
	public Hashtable selectFucksListAll( String query, String count_query ){
	
		// page정보를 얻는다.
	    Vector v = querymanager.selectEntities(count_query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
	
	    PageBean pb = new PageBean(totalRecord, totalRecord, 10, 1);
	
		// 해당 페이지의 리스트를 얻는다.
		String rquery = query + " limit 0,"+totalRecord;
		Vector result_v = querymanager.selectHashEntities(rquery);
		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size()>0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST",new Vector());
			ht.put("PAGE",new PageBean());
		}
	
		return ht;
	}
	
	/*****************************************************
	 입력.<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param String
 ******************************************************/
	public int insertFucks(String fucksString) throws Exception {
		if (fucksString != null && fucksString.length() > 0) {
		String query = "insert into fuck_info(fucks) "+
						"values('" 	+ fucksString + "')";
		
		return querymanager.updateEntities(query);
		} else {
			return -1;
		}
	}


	
/*****************************************************
	시청 대상 정보 수정.<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param fuck_id(순차번호), fuck(욕설)
 ******************************************************/
	public int modifyFuckInfo(int fuck_id, String fuck) throws Exception{
		if (fuck_id >= 0 && fuck != null && fuck.length() > 0 ) {
		String query =	"update fuck_info set " +
						"fucks = '"	+ fuck			+ "' " +
						" where fuck_id = " + fuck_id ;
		return querymanager.updateEntities(query);
		} else {
			return -1;
		}
	}

	/*****************************************************
		욕설 정보 삭제.<p>
		<b>작성자</b> : 이희락<br>
		@return<br>
		@param 순차 아이디
	 ******************************************************/
	public int deleteFuckInfo(String fuck_id) {
		if (fuck_id != null && fuck_id.length() > 0) {
			String query = "delete from fuck_info where fuck_id= "+fuck_id; 
			return querymanager.executeQuery(query);
		} else {
			return -1;
		}
	}

	public Vector selectQuery(String query) {
	    return querymanager.selectEntity(query);

	}

    public Vector selectQueryList(String query) {
        return querymanager.selectEntities(query);
    }



    public int executeQuery(String query){
        return querymanager.executeQuery(query);
    }

    public Vector selectQueryHash(String query) {
	    return querymanager.selectHashEntity(query);
	}
    
    public Vector selectHashEntities(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.err.println("select hashquery buseoex " + e.getMessage());
		}

		return rtn;
	}
}
