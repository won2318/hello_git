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
	����� ���� ��ü ����Ʈ�� seq ������ ���.<p>
	<b>�ۼ���</b> : �����<br>
	@return �˻��� ����� ���̵�  ���� ����Ʈ<br>
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
	��û ������� ���� ���.<p>
	<b>�ۼ���</b> : �����<br>
	@return �˻��� ��û������� ���� <br>
	@param ���̵� ,ocode
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
		����� ���� ����.<p>
		<b>�ۼ���</b> : �����<br>
		@return<br>
		@param ��û ����� ���̵�
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
		����� ���� ����.<p>
		<b>�ۼ���</b> : �����<br>
		@return<br>
		@param ��û ����� ���̵�
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
		��û ����� ��ü ����Ʈ ���.<p>
		<b>�ۼ���</b> : �����<br>
		@return �˻��� ��û ����� ����Ʈ<br>
		@param �˻� Query
	 ******************************************************/
		public Hashtable selectUserListAll(int page, String query){

			// page������ ��´�.
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

			// �ش� �������� ����Ʈ�� ��´�.
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
		��û ����� ��ü ����Ʈ ���.<p>
		<b>�ۼ���</b> : �����<br>
		@return �˻��� ��û ����� ����Ʈ<br>
		@param �˻� Query
	 ******************************************************/
		public Hashtable selectUserListAll(int ocode,int page, String gubun){

			// page������ ��´�.
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
					// �ش� �������� ����Ʈ�� ��´�.
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
			Alpha���� �Է�.<p>
			<b>�ۼ���</b> : �����<br>
			@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
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
			��û ��� ���� ����.<p>
			<b>�ۼ���</b> : �����<br>
			@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
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
