package com.vodcaster.sqlbean;

import dbcp.*;

import java.util.*;

import javax.servlet.http.*;
import com.yundara.util.CharacterSet;
import com.yundara.util.PageBean;
public class FixedUserSql extends SQLBeanExt{
	public FixedUserSql(){
		super();
	}
	
	/*****************************************************
	사용자 정보 전체 리스트를 seq 순으로 출력.<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 사용자 아이디  정보 리스트<br>
	@param
******************************************************/
	public Vector selectUserAll(int ocode, String gubun){
		if (ocode > 0 && gubun != null && gubun.length() > 0) {
		return querymanager.selectHashEntities("select * from fixed_user where ocode= "+ocode+ 
				" and gubun= '"+gubun+"'order by seq");
		} else {
			return null;
		}
	}


	/*****************************************************
	시청 대상자의 정보 출력.<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 시청대상자의 정보 <br>
	@param 아이디 ,ocode
 ******************************************************/
	public Vector selectFixedUserEntity(String vod_id, int ocode , String gubun){
		if (vod_id != null && vod_id.length()	> 0 && ocode > 0 ) {
		String query = "select * from fixed_user where ocode=" +ocode+" and vod_id='"+vod_id+"'";
		return 	querymanager.selectEntity(query);
		} else {
			return null;
		}
	}
	
	/*****************************************************
		사용자 정보 삭제.<p>
		<b>작성자</b> : 이희락<br>
		@return<br>
		@param 시청 사용자 아이디
	 ******************************************************/
		public int deleteFixedUser(String vod_id,int ocode, String gubun) {
			if (vod_id != null && vod_id.length()	> 0 && ocode > 0 && gubun!= null && gubun.length() > 0 ) {
				String query = "delete from fixed_user where vod_id ='" + vod_id + "' adn ocode="+ocode + " and gubun='"+gubun+"'";
				return querymanager.executeQuery(query);
			} else {
				return -1;
			}
		}
		
		/*****************************************************
		사용자 정보 삭제.<p>
		<b>작성자</b> : 이희락<br>
		@return<br>
		@param 시청 사용자 아이디
	 ******************************************************/
		public int deleteFixedUser(int ocode, String gubun) {
			if ( ocode > 0 && gubun!= null && gubun.length() > 0 ) {
			String query = "delete from fixed_user where ocode= "+ocode+ 
				" and gubun= '"+gubun+"'";
			return querymanager.executeQuery(query);
			} else {
				return -1;
			}
		}

		/*****************************************************
		시청 사용자 전체 리스트 출력.<p>
		<b>작성자</b> : 이희락<br>
		@return 검색된 시청 사용자 리스트<br>
		@param 검색 Query
	 ******************************************************/
		public Hashtable selectUserListAll(int page, String query){

			// page정보를 얻는다.
	        Vector v = querymanager.selectEntities(query);
			int totalRecord = 0;
			if(v != null && v.size()>0){
				totalRecord = v.size();
			}else{
				//sqlbean.printLog
				Hashtable ht = new Hashtable();
				ht.put("LIST",new Vector());
				ht.put("PAGE",new PageBean());

				return ht;
			}

	        PageBean pb = new PageBean(totalRecord, 10, 10, page);

			// 해당 페이지의 리스트를 얻는다.
			String rquery = query + " limit "+ (pb.getStartRecord()-1) + ",10";
	        //log.printlog("MovieBoardSQLBean getBoardList method query"+query);
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
		시청 사용자 전체 리스트 출력.<p>
		<b>작성자</b> : 이희락<br>
		@return 검색된 시청 사용자 리스트<br>
		@param 검색 Query
	 ******************************************************/
		public Hashtable selectUserListAll(int ocode,int page, String gubun){

			// page정보를 얻는다.
			try {
				if (ocode >= 0  && gubun != null && gubun.length() > 0) {
					int totalRecord = 0;
					String query = "select cnt(vod_id) from fixed_user where ocode="+ocode+" and gubun='"+gubun+"'";
			        Vector v = querymanager.selectEntities(query);
					if(v != null && v.size()>0){
						totalRecord = Integer.parseInt(String.valueOf(v.elementAt(0)));
						//totalRecord = v.size();
					}else{
						//sqlbean.printLog
						Hashtable ht = new Hashtable();
						ht.put("LIST",new Vector());
						ht.put("PAGE",new PageBean());
						return ht;
					}
 
			        PageBean pb = new PageBean(totalRecord, 10, 10, page);
					// 해당 페이지의 리스트를 얻는다.
					String rquery = query + " limit "+ (pb.getStartRecord()-1) + ",10";
			        //log.printlog("MovieBoardSQLBean getBoardList method query"+query);
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
				} else {
					Hashtable ht = new Hashtable();
					ht.put("LIST",new Vector());
					ht.put("PAGE",new PageBean());
	
					return ht;
				}
			}catch (Exception e){
				System.out.println(e);
				Hashtable ht = new Hashtable();
				ht.put("LIST",new Vector());
				ht.put("PAGE",new PageBean());

				return ht;
				
			}
		}
		
		/*****************************************************
			Alpha정보 입력.<p>
			<b>작성자</b> : 이희락<br>
			@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
			@param AlphaInfoBean
		 ******************************************************/
			public int insertFixedUser(FixedUserInfo memBean) throws Exception {
				
				int list_id = 1;
				
				Vector v = null;
				try{
					v = querymanager.selectEntity("select max(seq) from fixed_user");
				}catch(ArrayIndexOutOfBoundsException e){
					System.err.println("fixed_user ex : "+e);
				}
				try{
					if(Integer.parseInt(String.valueOf(v.elementAt(0))) != 0)
						list_id = Integer.parseInt(String.valueOf(v.elementAt(0))) + 1;
					else list_id = 1;
				}catch(Exception e){
					System.err.println("insert fixed_user ex : "+e);
				}
				
				
				memBean.setSeq(list_id);
				String query = "insert into fixed_user"+
								" (seq,ocode,vod_id,yn,view_date,gubun)" +
								"values(" 		+
								memBean.getSeq()				+ "," +
								memBean.getOcode()			+ ",'" +
								memBean.getVod_id()		+ "','" +
								memBean.getYn()				+ "'," +
								"now(),'" +
								memBean.getGubun()			+ "'" +
								")";
				
				return querymanager.updateEntities(query);
			}


			
		/*****************************************************
			시청 대상 정보 수정.<p>
			<b>작성자</b> : 이희락<br>
			@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
			@param AlphaInfoBean
		 ******************************************************/
			public int modifyFixedUser(FixedUserInfo bean) throws Exception{

				String query =	"update fixed_user set " +
								"ocode = "			+ bean.getOcode()			+ ", " +
								"vod_id = '"	+ bean.getVod_id()			+ "', " +
								"yn = '"			+ bean.getYn()				+ "', " +
								"view_date = now(), " +
								"gubun = '"			+ bean.getGubun()		+ "' " +
								
								" where seq = " + bean.getSeq() ;
				

				return querymanager.updateEntities(query);
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

}
