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
 * MyList DB ���� Ŭ����
 * Date: 2005. 1. 24.
 * Time: ���� 10:52:39
 */
public class MyListSqlBean  extends SQLBeanExt {

    public MyListSqlBean() {
		super();
	}



/*****************************************************
	MyList���� ����<p>
	<b>�ۼ���</b> : ����<br>
	@return <br>
	@param MyList��ȣ
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
	MyList���� �Է�<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
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
	�����˻��� ���� MyList���� ���<p>
	<b>�ۼ���</b> : ����<br>
	@return MyList���� ���<br>
	@param �˻� Query
******************************************************/
	public Vector selectMyListQuery(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {}

		return rtn;
	}



/*****************************************************
	�����˻��� ���� MyList���� ���<p>
	<b>�ۼ���</b> : ����<br>
	@return MyList���� ���<br>
	@param ȸ�����̵�, �̵������, �̵��Ÿ��
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
	�����˻��� ���� MyList���� ���<p>
	<b>�ۼ���</b> : ����<br>
	@return MyList���� ���<br>
	@param ȸ�����̵�, �̵������, �̵��Ÿ��, ó����ȣ, ����ȣ
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
	MyList���� ����<p>
	<b>�ۼ���</b> : ����<br>
	@return <br>
	@param ȸ�����̵�, �̵������, �̵��Ÿ��
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
    ���� ��� ����¡ ó��<p>
	<b>�ۼ���</b> : ����<br>
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
					
			// �ش� �������� ����Ʈ�� ��´�.
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
