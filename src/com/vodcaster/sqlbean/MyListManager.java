package com.vodcaster.sqlbean;

import com.vodcaster.utils.WebutilsExt;
import java.util.*;

import dbcp.SQLBeanExt;
import javax.servlet.http.HttpServletRequest;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.TimeUtil;


/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2005. 1. 24.
 * Time: 오전 11:10:31
 * To change this template use File | Settings | File Templates.
 */
public class MyListManager {


	private static MyListManager instance;

	private MyListSqlBean sqlbean = null;

	private MyListManager() {
        sqlbean = new MyListSqlBean();
        //System.err.println("MyListManager 인스턴스 생성");
    }

	public static MyListManager getInstance() {
		if(instance == null) {
			synchronized(MyListManager.class) {
				if(instance == null) {
					instance = new MyListManager();
				}
			}
		}
		return instance;
	}




	/*****************************************************
	<code>mid,mtype,ocode</code>로 받은 정보를 마이리스트 InfoBean에 등록<p>
	<b>작성자</b>       : 최희성<br>
	<b>해당 파일</b>    : <br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 99를 리턴한다.
	@see
	******************************************************/
	public int insertMyList(String mid, String mtype, String ocode, String oflag) throws Exception {

		mid = com.vodcaster.utils.TextUtil.getValue(mid);
		mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		oflag = com.vodcaster.utils.TextUtil.getValue(oflag);
		
	    MyListInfoBean bean = new MyListInfoBean();
        bean.setMid(mid);
        bean.setMtype(mtype);
        bean.setOcode(ocode);
        bean.setOflag(oflag);

        return sqlbean.insertMyList(bean);
	}




	/*****************************************************
	<code>mid,mtype,ocode</code>로 받은 정보를 마이리스트 InfoBean에 등록<p>
	<b>작성자</b>       : 최희성<br>
	<b>해당 파일</b>    : <br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 99를 리턴한다.
	@see
	******************************************************/
	public int insertMcodeMyList(String mid, String mtype, int mcode, String oflag) throws Exception {

		mid = com.vodcaster.utils.TextUtil.getValue(mid);
		mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
		oflag = com.vodcaster.utils.TextUtil.getValue(oflag);
		
		if (mcode >= 0 ) {
	        String query = "select ocode from vod_media where mcode=" +mcode+ " order by ocode";
	        Vector v = sqlbean.selectQuery(query);
	
	        if(v.size() > 0) {
	            MyListInfoBean bean = new MyListInfoBean();
	
	            try {
	                bean.setMid(mid);
	                bean.setMtype(mtype);
	                bean.setOcode(String.valueOf(v.elementAt(0)));
	                bean.setOflag(oflag);
	            } catch(Exception e) {
	                System.out.println(e.getMessage());
	            }
	
	            return sqlbean.insertMyList(bean);
	        }else
	            return -1;
		} else {
			return -1;
		}

	}


	public int insertMcodeMyListExt(String mid,  String ocode) throws Exception {

        MyListInfoBean bean = new MyListInfoBean();
        mid = com.vodcaster.utils.TextUtil.getValue(mid);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		
        try {
            bean.setMid(mid);
            bean.setOcode(ocode);
        } catch(Exception e) {
            System.out.println(e.getMessage());
        }

        return sqlbean.insertMyList(bean);
	}



	/*****************************************************
	<code>mid,mtype,ocode</code>로 받은 정보로 마이리스트 삭제<p>
	<b>작성자</b>       : 최희성<br>
	<b>해당 파일</b>    : <br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 99를 리턴한다.
	@see
	******************************************************/
	public void deleteMyList(String mid, String ocode) throws Exception {
		mid = com.vodcaster.utils.TextUtil.getValue(mid);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
        sqlbean.deleteMyList(mid,ocode);

	}


    public Vector selectMyListList(String mid, String mtype, String oflag) {
    	mid = com.vodcaster.utils.TextUtil.getValue(mid);
		mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
		oflag = com.vodcaster.utils.TextUtil.getValue(oflag);
    	return sqlbean.selectMyListAll(mid, mtype, oflag);
    }



    public Vector selectMyListList(String mid, String mtype, String oflag, int limit1, int limit2) {
    	mid = com.vodcaster.utils.TextUtil.getValue(mid);
		mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
		oflag = com.vodcaster.utils.TextUtil.getValue(oflag);
        return sqlbean.selectMyListAll(mid, mtype, oflag, limit1, limit2);
    }



    public Vector selectMyListCount(String mid) {
    	mid = com.vodcaster.utils.TextUtil.getValue(mid);
		
    	if (mid != null && mid.length() > 0) {
        String query = "select * from my_list where mid='" +mid+ "'";
        //System.out.println(query);
        return sqlbean.selectQuery2(query);
    	} else {
    		return null;
    	}
    }



    public Vector getTodayReserveMeaia(String vod_id){

    	vod_id = com.vodcaster.utils.TextUtil.getValue(vod_id);
		
        String query = "";
        if (vod_id != null && vod_id.length() > 0) {
        String cur_date = TimeUtil.getDetailTime();
        cur_date = cur_date.substring(0,10);

        query = "select b.* from my_list as a, real_media as b where (a.mid='" +vod_id+ "' and a.mtype='2' and a.oflag='V'" +
                " and a.ocode=b.rcode) and (b.rstart_time between '" +cur_date+ " 00:00' and '" +cur_date+ " 23:59')" +
                " and (b.rend_time between '" +cur_date+ " 00:00' and '" +cur_date+ " 23:59')";

        //System.out.println(query);

        return sqlbean.selectMyListQuery(query);
        } else {
        	return null;
        }
    }


/*
    MyList정보 출력<p>
	<b>작성자</b> : 주현<br>
	mid= 사용자 id
	oflag : V = vod, A=aod, C = content
	page = 페지지 번호
	limit = 목록 수
*/

	public Hashtable selectMyListAll2(String mid, String field, String searchstring, int page, int limit){

		mid = com.vodcaster.utils.TextUtil.getValue(mid);
		field= com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		
        String query = "";
        String sub_query = "";
		Hashtable result_ht = null;
		String count_query = "";
		if (mid != null && mid.length() > 0 ) {
			if(field != null && field.length() >0 && searchstring != null && searchstring.length() > 0 ) {
		        if(field.equals("title"))
		            sub_query = " and (b.otitle like '%" +searchstring+ "%') ";
		        else if(field.equals("content"))
		        	sub_query = " and ( b.ocontents like '%" +searchstring+ "%') ";
		        else if(field.equals("user"))
		        	sub_query = " and ( b.user_id like '%" +searchstring+ "%') ";
		        else if(field.equals("all"))
		        	sub_query = " and ( " +
		            		"       b.otitle like  '%" +searchstring+ "%'"+
		            		" or  b.user_id like   '%" +searchstring+ "%'"+
		                    " or  b.ocontents like '%" +searchstring+ "%') ";
		    }
	
	            query = "select b.* , c.uid from  vod_media  b, my_list  c where b.ocode=c.ocode " +
	                    " and c.mid='" +mid+ "' " + sub_query + " order by uid desc";
	            count_query = "select count(b.ocode)  from  vod_media  b, my_list  c where b.ocode=c.ocode " +
                		" and c.mid='" +mid+ "' " + sub_query ;
			Vector rtn = null;
	
			try {
	            result_ht = sqlbean.getMediaList(page, query, count_query, limit);
	        }catch (Exception e) {
	            result_ht = new Hashtable();
	            result_ht.put("LIST", new Vector());
	            result_ht.put("PAGE", new com.yundara.util.PageBean());
	            
	        }
			
		} else {
			result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
			
		}
		return result_ht;

	}
	
	public Hashtable selectMyListAll2_cate(String mid, String field, String searchstring, int page, int limit){

        String query = "";
        String sub_query = "";
        String count_query = "";
		Hashtable result_ht = null;
		if(page <= 0) page = 1;
		if(limit <= 0){
			limit = 10;
		}
		
		mid = com.vodcaster.utils.TextUtil.getValue(mid);
		field= com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		
		if (mid != null && mid.length() > 0 ) {
			if(field != null && field.length() >0 && searchstring != null && searchstring.length() > 0 ) {
		        if(field.equals("title"))
		            sub_query = " and (b.otitle like '%" +searchstring+ "%') ";
		        else if(field.equals("content"))
		        	sub_query = " and ( b.ocontents like '%" +searchstring+ "%') ";
		        else if(field.equals("user"))
		        	sub_query = " and ( b.user_id like '%" +searchstring+ "%') ";
		        else if(field.equals("all"))
		        	sub_query = " and ( " +
		            		"       b.otitle like  '%" +searchstring+ "%'"+
		            		" or  b.user_id like   '%" +searchstring+ "%'"+
		                    " or  b.ocontents like '%" +searchstring+ "%') ";
		    }

	            query = " select b.* , c.uid from " +
	            		" (select a.* from vod_media a, category b where a.ccode=b.ccode and a.del_flag='N' " +
	            		"		and b.del_flag='N' and a.openflag='Y' and b.openflag='Y' and b.ctype='V')  b, my_list  c" +
	            		" where b.ocode=c.ocode " +
	                    " and c.mid='" +mid+ "' " + sub_query + " order by uid desc";
	            count_query = " select count(b.ccode)  from " +
		        		" (select a.* from vod_media a, category b where a.ccode=b.ccode and a.del_flag='N' " +
		        		"		and b.del_flag='N' and a.openflag='Y' and b.openflag='Y' and b.ctype='V')  b, my_list  c " +
		        		" where b.ocode=c.ocode " +
		                " and c.mid='" +mid+ "' " + sub_query ;
			Vector rtn = null;

			try {
	            result_ht = sqlbean.getMediaList(page, query, count_query, limit);
	        }catch (Exception e) {
	            result_ht = new Hashtable();
	            result_ht.put("LIST", new Vector());
	            result_ht.put("PAGE", new com.yundara.util.PageBean());
	            
	        }
		} else {
			result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return result_ht;

	}

 
}
