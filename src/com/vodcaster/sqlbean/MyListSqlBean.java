package com.vodcaster.sqlbean;

import java.util.*;

import javax.servlet.http.*;
import dbcp.SQLBeanExt;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;
import com.yundara.util.PageBean;

/**
 * @author Choi Hee-Sung
 * MyList DB 관리 클래스
 * Date: 2005. 1. 24.
 * Time: 오전 10:52:39
 */
public class MyListSqlBean  extends SQLBeanExt {

    public MyListSqlBean() {
		super();
	}



/*****************************************************
	MyList정보 삭제<p>
	<b>작성자</b> : 최희성<br>
	@return <br>
	@param MyList번호
******************************************************/

	public Vector deleteMyList(String mid, String ocode) {
		if (mid != null && mid.length() >0 && ocode != null && ocode.length() > 0) {
		String query = "delete from my_list where mid='" + mid +"' and ocode=" + ocode;

		return querymanager.executeQuery(query, "");
		} else {
			return null;
		}
	}



/*****************************************************
	MyList정보 입력<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param MyListInfoBean
******************************************************/
	public int insertMyList(MyListInfoBean bean) throws Exception {

	    int rtn = -1;

	    try {
            Vector v = querymanager.selectEntity("select * from my_list where mid='" +bean.getMid()+
                        "' and ocode=" + bean.getOcode());

            if(v != null && v.size() > 0) {


            } else {

                String query = "insert into my_list (mid,ocode) values('" +
                                bean.getMid()           + "','" +
                                bean.getOcode()         + "')";

                //System.out.println("MyList query == " + query);
                rtn = querymanager.updateEntities(query);
            }

	    } catch(Exception e) {}

	    return rtn;
	}



/*****************************************************
	지정검색에 의해 MyList정보 출력<p>
	<b>작성자</b> : 최희성<br>
	@return MyList정보 출력<br>
	@param 검색 Query
******************************************************/
	public Vector selectMyListQuery(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {}

		return rtn;
	}



/*****************************************************
	지정검색에 의해 MyList정보 출력<p>
	<b>작성자</b> : 최희성<br>
	@return MyList정보 출력<br>
	@param 회원아이디, 미디어종류, 미디어타입
******************************************************/
	public Vector selectMyListAll(String mid, String mtype, String oflag){

        String query = "";
        if (mtype != null && mtype.length() > 0 && mid != null && mid.length() > 0 && oflag != null && oflag.length() > 0) {
	        if(mtype.equals("1")) {
	            query = "select a.*, b.* from media as a, vod_media as b, my_list as c where b.ocode=c.ocode " +
	                    "and a.mcode=b.mcode and c.mtype='" +mtype+ "' and c.mid='" +mid+ "' and c.oflag='" +oflag+ "' order by uid desc";
	        } else if(mtype.equals("2")) {
	            query = "select a.*, b.* from media as a, live_media as b, my_list as c where b.rcode=c.ocode " +
	                    "and a.mcode=b.mcode and c.mtype='" +mtype+ "' and c.mid='" +mid+ "' and c.oflag='" +oflag+ "' order by uid desc";
	        }
			Vector rtn = null;
	
			try {
				rtn = querymanager.selectHashEntities(query);
			}catch(Exception e) {}
	
			return rtn;
        } else {
        	return null;
        }
	}



/*****************************************************
	지정검색에 의해 MyList정보 출력<p>
	<b>작성자</b> : 최희성<br>
	@return MyList정보 출력<br>
	@param 회원아이디, 미디어종류, 미디어타입, 처음번호, 끝번호
******************************************************/
	public Vector selectMyListAll(String mid, String mtype, String oflag, int limit1, int limit2){
		 if (mtype != null && mtype.length() > 0 && mid != null && mid.length() > 0 && oflag != null && oflag.length() > 0) {
	        String query = "select a.*, b.* from media as a, vod_media as b, my_list as c where b.ocode=c.ocode " +
	                    "and a.mcode=b.mcode and c.mtype='" +mtype+ "' and c.mid='" +mid+ "' and c.oflag='" +oflag+ "' order by uid desc limit " +limit1+ "," +limit2;
			Vector rtn = null;
	
			try {
				rtn = querymanager.selectHashEntities(query);
			}catch(Exception e) {}
	
			return rtn;
		 } else {
			 return null;
		 }
	}



/*****************************************************
	MyList정보 삭제<p>
	<b>작성자</b> : 최희성<br>
	@return <br>
	@param 회원아이디, 미디어종류, 미디어타입
******************************************************/
	public Vector deleteMyList(String mid, String mtype, String ocode, String oflag) {
		 if (mtype != null && mtype.length() > 0 && mid != null && mid.length() > 0 && oflag != null && oflag.length() > 0) {
		    String query = "delete from my_list where mid='" +mid+ "' and mtype='" +mtype+ "' and ocode='" +ocode+ "' and oflag='" +oflag+ "'";
	
	        return querymanager.executeQuery(query, "");
		 } else {
			 return null;
		 }

	}



    public Vector selectQuery(String query) {
        return querymanager.selectEntity(query);

    }
    
    public Vector selectQuery2(String query) {
        return querymanager.selectEntities(query);

    }





/*
    정보 출력 페이징 처리<p>
	<b>작성자</b> : 주현<br>
*/

        public Hashtable getMediaList(int page,String query, String count_query, int limit){

		Vector rtn = null;
		Hashtable ht = new Hashtable();
		int totalRecord = 0;
		if(limit <= 0){
			limit = 10;
		}
		try {
			Vector v = querymanager.selectEntities(count_query);
			if(v != null && v.size() > 0){
				totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
			}
			if(totalRecord <= 0){
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
				return ht;
			}
			
			PageBean pb = new PageBean(totalRecord, limit, 10, page);
	//		totalrecord,lineperpage,pageperblock,page
					
			// 해당 페이지의 리스트를 얻는다.
			String rquery ="";
			rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
			Vector result_v = querymanager.selectHashEntities(rquery);

			
			if(result_v != null && result_v.size() > 0){
				ht.put("LIST",result_v);
				ht.put("PAGE",pb);
			}else{
				//ht.put("LIST", new Hashtable());
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
			}
					
					
		}catch(Exception e) {
			System.err.println("selectMediaListAllExtPage ex : "+e.getMessage());
		}

		return ht;

		}


}
