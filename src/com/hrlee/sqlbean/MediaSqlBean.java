/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;


import javax.servlet.http.*;

import dbcp.SQLBeanExt;

import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;
import com.yundara.util.PageBean;
import com.vodcaster.sqlbean.DirectoryNameManager;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import java.io.*;
import java.util.*;



/**
 * @author Choi Hee-Sung
 *
 * �̵�� DB QUERY Ŭ����
 */
public class MediaSqlBean  extends SQLBeanExt {

    public MediaSqlBean() {
		super();
	}




    /*****************************************************
    	Ư�� �̵�� ��û�� �α����� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return<br>
    	@param vod_id ȸ�����̵�, ȸ���̸�, �̵���ڵ�, ȸ��������, �α����̺��
    ******************************************************/
    public void insertVodLog(String vod_id, String vod_name, String vod_buseo, String vod_gray, String vod_code, String vod_ip, String ctype) {
  
    	if (vod_code != null && vod_code.length() > 0) {
	        int no = 0;
			String table = "vod_log";
	        String table2 = "vod_media";
	        String hit_query = "";
			hit_query = "update "+table2+" set hitcount=hitcount+1 where ocode='" +vod_code+"'";
	        
			String query = "";
	         if(ctype.equals("R") || ctype.equals("L")) {
	        	table = "live_log";
	        	table2 = "live_media";
	        	hit_query = "update "+table2+" set rhit=rhit+1 where rcode=" +vod_code;
	         }
			
			querymanager.updateEntities(hit_query);
	
	            if(ctype.equals("R")|| ctype.equals("L")) {
	            	query = "insert into "+table+" (ip,vod_id,vod_name, vod_buseo,vod_gray,regDate,vod_code,oflag) values ('" +
		                vod_ip          + "','" +
		                vod_id          + "','" +
		                vod_name        + "','" +
		                vod_buseo        + "','" +
		                vod_gray        + "'," +
		                "now()," + 
		                vod_code        + ",'"+
						ctype        + "')";
	            } else {
	            	query = "insert into "+table+" (ip,vod_id,vod_name, vod_buseo,vod_gray,regDate,vod_code,oflag) values ('" +
	                    vod_ip          + "','" +
	                    vod_id          + "','" +
	                    vod_name        + "','" +
	                    vod_buseo        + "','" +
	                    vod_gray        + "'," +
	                    "now(),'" + 
	                    vod_code        + "','"+
						ctype        + "')";
	            }
	
	
	       querymanager.updateEntities(query);
   
    	}
    }
    
    



    /*****************************************************
    	�����˻��� ���� �̵����ü ����Ʈ ���.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �̵�� ���<br>
    	@param query �˻� QUERY
    ******************************************************/
	public Vector selectMediaListAll(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.err.println("selectMediaListAll ex : "+e.getMessage());
		}

		return rtn;
	}



    /*****************************************************
    	�����˻��� ���� �̵����ü ����Ʈ ���.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �̵�� ���<br>
    	@param query �˻� QUERY
    ******************************************************/
	public Vector selectMediaListAllExt(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectEntities(query);
		}catch(Exception e) {
			System.err.println("selectMediaListAllExt ex : "+e.getMessage());
		}

		return rtn;
	}
	/*****************************************************
	�����˻��� ���� �̵����ü ����Ʈ ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return �̵�� ���<br>
	@param query �˻� QUERY
******************************************************/
public Hashtable selectMediaListAllExtPage(String query, int page, int limit){

	Vector rtn = null;
	Hashtable ht = new Hashtable();
	int totalRecord = 0;
	if(limit < 0){
		limit = 20;
	}
	try {
		Vector v = querymanager.selectEntities(query);
		if(v != null && v.size()>0) totalRecord = v.size();
		if(totalRecord <= 0){
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
//		rtn = querymanager.selectEntities(query);
		PageBean pb = new PageBean(totalRecord, limit, 20, page);
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






    /*****************************************************
    	�ֹ����̵���� �����̵������ ���.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �ֹ��� �̵������<br>
    	@param ocode �ֹ��� �̵���ڵ�
    ******************************************************/
	public Vector selectOMediaInfo(String ocode){
		if (ocode != null && ocode.length() > 0) {
			String query = "select * from vod_media where del_flag='N' and ocode='" +ocode+"'";
			return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}
 
	public Vector selectOMediaInfo_cate(String ocode){
		if (ocode != null && ocode.length() > 0) {
			String query = " select a.*, b.ctitle   from vod_media a inner join category b on  a.ccode=b.ccode  "
						 + " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' "
						 + " 	   and a.openflag='Y' and b.openflag='Y' and b.ctype='V' "  
						 + " 	   and a.ocode='" +ocode+"'";
			return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}

	
	public Vector selectOMediaInfo_admin(String ocode){
		if (ocode != null && ocode.length() > 0) {
		String query = " select a.*   from vod_media a inner join category b on  a.ccode=b.ccode  "
					 + " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' "
					 + " and b.ctype='V' "
					 + " and a.ocode='" +ocode+"'";
		return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}

	
	/**
     * vod_images ����� �̹��� ���
     * @param ocode
     * @return Vector
     */
    public Vector selectMediaImages(String ocode) {
    	if (ocode != null && ocode.length() > 0) {
        String query = " SELECT DISTINCT * FROM thumbnail WHERE ocode = '" + ocode + "' ORDER BY time ";
        return querymanager.selectEntities(query);
    	} else {
			return null;
		}
    }

/*****************************************************
		�ֹ��� �̵���� ÷������ ����.<p>
		<b>�ۼ���</b> : ����<br>
		@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
		@param ocode
	******************************************************/
	public int dropOMediaAttach(String ocode) throws Exception{
	
	    String query = "";
	    Vector v = null;
	    int rtn = -1;
 
	
	    if (ocode != null && ocode.length() > 0) { // ������ ����Ȯ��
	
	        try {
	
	            // �̵�� ȭ�� ����
 
	            Vector vt = querymanager.selectEntity("select attach_file from vod_media where   ocode='"+ocode+"'");
	            String old_file = "";
	            if(vt != null && vt.size() > 0){
	            	old_file = String.valueOf(vt.elementAt(0));

					File deleteFile1 = new File(DirectoryNameManager.VODROOT+old_file);
				
					try{  
						deleteFile1.delete(); // ���� �̹��� ���� ����
					}
					catch(Exception e){ // 
						System.err.println(" ���� �̹��� ���� ���� Ex : " + e);	
					}
	            }

	            query = "update vod_media set attach_file ='' where     ocode='"+ocode+"'";
	
	            rtn = querymanager.executeQuery(query);
	
	            if(rtn != -1) {
	                return rtn;
	            }else
	                System.err.println("���̺��������� ����");
	
	        } catch (Exception e) {
	        	System.err.println(e.getMessage());
	        }
	
	        return rtn;
	
	    } else
	        return -1;
	
	}



    public int executeQuery(String query) {
        return querymanager.updateEntities(query);
    }





	public Hashtable getOMediaListAll(int page, String query){
		int linePerPage = 10;
//		 page������ ��´�.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}

        PageBean pb = new PageBean(totalRecord, linePerPage, 10, page);
//totalrecord,lineperpage,pageperblock,page
        
		// �ش� �������� ����Ʈ�� ��´�.
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+linePerPage;

		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}

    /*****************************************************
    	�̵�� ����Ʈ ��� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return <br>
    	@param page ��������ȣ, �˻�Query
    ******************************************************/
    public Hashtable getMediaList(int page,String query){
        return this.getMediaList(page, query, 10);
    }

    public Vector getMedia(String query){
//    	 page������ ��´�.
        
        Vector v = querymanager.selectHashEntity(query);
        return v;
    }
    
	public Hashtable getMediaList(int page,String query, int limit){
		// page������ ��´�.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}

        PageBean pb = new PageBean(totalRecord, limit, 10, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		//System.out.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return ht;
	}
	

	public Hashtable getMediaListCnt(int page,String query, int limit, String cnt){
		// page������ ��´�.
		
		if (cnt != null && cnt.length() > 0) {
			String cnt_query = "select count(cnt."+cnt+") from ( "+ query +" ) as cnt";
	        Vector v = querymanager.selectEntities(cnt_query);
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
			String rquery ="";
			rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
			//System.out.println(rquery);
			Vector result_v = querymanager.selectHashEntities(rquery);
			Hashtable ht = new Hashtable();
			if(result_v != null && result_v.size() > 0){
				ht.put("LIST",result_v);
				ht.put("PAGE",pb);
			}else{
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
			}
			return ht;
		} else {
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
		
	}
	
	public Hashtable getMediaListCnt(int page,String query,String count_query, int limit){
		// page������ ��´�.
		// page������ ��´�.
	    Vector v = querymanager.selectEntities(count_query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			try{
				totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
			}catch(Exception ex){
				Hashtable ht = new Hashtable();
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
				return ht;
			}
		}

        //PageBean pb = new PageBean(totalRecord, limit, 10, page);
		PageBean pb = new PageBean(totalRecord, limit, 5, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		//System.out.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);
		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return ht;
		
	}
	
	public Hashtable getMediaList(int page,String query, int limit, int pagePerBlock){
		// page������ ��´�.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
		if(pagePerBlock < 1) pagePerBlock=10;
        PageBean pb = new PageBean(totalRecord, limit, pagePerBlock, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		//System.out.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return ht;
}
	
	public Hashtable getMediaListCnt(int page,String query, String count_query, int limit, int pagePerBlock){
		// page������ ��´�.
		
		// page������ ��´�.
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
		if(pagePerBlock < 1) pagePerBlock=10;
        PageBean pb = new PageBean(totalRecord, limit, pagePerBlock, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		//System.out.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return ht;
		
		
}
	
	public Vector getAllOrderMedia(){
		Vector v= null;
		String query = "select ocode, title from vod_media";
		try {
			v = querymanager.selectEntities(query);
		}catch(Exception e) {
			System.err.println("getAllOrderMedia ex : " + e.getMessage());
		}

		return v;
	}
	


    /**
     * order_media ��ȸ�� ����
     * @param ocode
     */
    public void updateOrdermediaHit(String ocode) {
    	if (ocode != null && ocode.length() > 0) {
	        String query = " UPDATE vod_media SET HitCount = HitCount + 1 WHERE ocode='"+ocode+"' ";
	        querymanager.updateEntities(query);
    	}
    }

   


	 /*****************************************************
    	�ֹ����̵���� ī�װ��� �ֱ� �̵��.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �ֹ��� �̵������<br>
    	@param ocode �ֹ��� �̵���ڵ�
    ******************************************************/
	public Vector selectCode_1(String ccode,  String direction, int vod_level){
		String sub_query = "";
 
		if (ccode != null && ccode.length() > 11 )
		{
			String Code = ccode;
			if (ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if (ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if (ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}

			sub_query =" and ccode like '" +Code + "%'";
		}
		
		if (direction == null || direction.length() <= 0) {
			direction = "desc";
		}
		String query = "select * from vod_media where olevel<="+vod_level+" and del_flag='N' and openflag='Y' "+sub_query+" order by ocode " + direction  +" limit 0,1";

//System.out.println(query);
		return querymanager.selectHashEntity(query);
	}
	
	public Vector selectCode_1_cate(String ccode,  String direction, int vod_level){
		String sub_query = "";
 
		if (ccode != null && ccode.length() > 11 )
		{
			String Code = ccode;
			if (ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if (ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if (ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}

			sub_query =" and a.ccode like '" +Code + "%'";
		}
		if (direction == null || direction.length() <= 0) {
			direction = "desc";
		}
		String query = " select a.* from vod_media a inner join category b on  a.ccode=b.ccode  " +
					   " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
					   "	   and a.openflag='Y' and b.openflag='Y' and b.ctype='V' " +
					   " 	   and a.olevel<=" + vod_level + sub_query +
					   " order by a.mk_date " + direction + " limit 0,1 ";
					   //" order by a.ocode " + direction + " limit 0,1 ";

//System.out.println(query);
		return querymanager.selectHashEntity(query);
	}

	/*****************************************************
    	�ֹ����̵���� ��õ(point) ��ȯ<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �ֹ��� �̵������ (point) <br>
    	@param mtype, ocode �ֹ��� �̵���ڵ�
    ******************************************************/
	public Vector selectOMediaPoint(  String ocode) {
		if (ocode != null && ocode.length() > 0) {
			String query = "select recomcount from vod_media where  ocode='"+ocode+"' ";
			//System.out.println(query);
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}

///////////////
// ÷������ ���
//  ����
///////////////

	public int insertOMediaFile2(OrderMediaInfoBean bean, String ctype) throws Exception{

	    String query = "";
	    String sub_query1 = "";
        String sub_query2 = "";

	    if(!String.valueOf(bean.getOimage()).equals("") && bean.getOimage() != null) { // ������ �̹���ȭ���� ���ε� �� ���

	        sub_query1 = String.valueOf(bean.getOimage());

	    }
            sub_query2 = "update vod_media set attach_file='";


        query = sub_query2 + sub_query1+ "' where oflag='"+ctype+"' and ocode='" +bean.getOcode()+"' ";
        return querymanager.updateEntities(query);
	}



/////////////
//  ��õ �ϱ�
// insertBest_count(mtype,Integer.parseInt(ocode),Integer.parseInt(point));
/////////////
	public int insertBest_Point(  String ocode, int point) throws Exception {

	    int rtn = -1;

	    try {
	    	 if( ocode != null && ocode.length()>0 ) {

                String query = "update vod_media set recomcount = recomcount+" +point+" where ocode='"+ocode+"' ";
//System.out.println(query); 
                	rtn = querymanager.updateEntities(query);
 
            }

	    } catch(Exception e) {}

	    return rtn;
	}
	
	
	/*****************************************************
	��õ ���� ��ȸ<p>
	<b>�ۼ���</b> : ������<br>
	@return <br>
	@param ocode , vod_id
******************************************************/
	
	public Vector selectBest_Point_user(String ocode, String vod_id) {
		if (ocode != null && ocode.length()> 0 && vod_id != null && vod_id.length() > 0) {
			String query = "select * from recommend where ocode='"+ocode+"' and user_id='"+vod_id+"'";
			return querymanager.selectEntities(query);
		} else {
			return null;
		}
	}

    /*****************************************************
	�μ�, ������ �ش��ϴ� �ڵ带 ������<p>
	<b>�ۼ���</b> : ������<br>
	@return tcode(�̵���� group_id�� ����)<br>
	@param deptcode : �μ�, gradecode : ����
******************************************************/
	
	public Vector selectTargetInfoSql(String deptcode, String gradecode){
		if (deptcode != null && deptcode.length()> 0 && gradecode != null && gradecode.length() > 0) {
	        String query = "select distinct tcode from user_target where select_group = '"+deptcode+":ALL' or select_group = '"+deptcode+":"+gradecode+"'";
	        return querymanager.selectEntities(query);
		} else {
			return null;
		}
	}

 
		public Vector selectQuery(String query) {
		    return querymanager.selectEntity(query);
		
		}
		

		  public Vector month_cnt_vod(int year, String month1, String month2) {
 
			  int year2 = year;
			  if (month1 == "01") {
				  year2 = year - 1;
			  }  
			  if (year > 0 && month1 != null && month1.length()> 0 && month2 != null && month2.length() > 0) {
//			     String query = "  select ifnull(B.ohit - ifnull((select ohit from VOD_HITLOG A where YY='"+year2+"' and MM='"+month2+"' and B.ocode =A.ocode),0),0) AS hit, " +
//			     " B.YY, B.MM,C.ocode, C.title, C.del_flag,(select ctitle from category D where D.ccode = C.ccode and D.del_flag='N' and ctype='V' ) ctitle  " +
//			     " from (select * from VOD_HITLOG where YY='"+year+"' and MM='"+month1+"') B, vod_media C " +
//			      
//			     " where B.ocode =C.ocode "+
//			     " order by ccode, B.ocode ";
				  
				  String query =" SELECT IFNULL( "+
				" (SELECT b.ohit FROM vod_hitlog B WHERE B.ocode = AA.ocode AND B.yy='"+year+"' AND B.mm='"+month1+"' ) - " +
				" (SELECT b.ohit FROM vod_hitlog B WHERE B.ocode = AA.ocode AND B.yy='"+year2+"' AND B.mm='"+month2+"' ),0 ) AS hit, "+
				" C.yy, C.mm, AA.ocode, AA.title, AA.del_flag "+
				" FROM vod_hitlog C LEFT JOIN vod_media AA ON C.ocode = AA.ocode WHERE C.yy='"+year+"' AND C.mm='"+month1+"'";
				  
			 		return querymanager.selectEntities(query);
			  } else {
				  return null;
			  }
		 }
		  
		
		 public int month_hit_log(String year , String month) {

		       String query = "";
		       int rtn = 0;
		      
		       if (  year != null && year.length()> 0 && month != null && month.length() > 0) {
		    	try {
		 
		    	     query = "INSERT INTO vod_hitlog (yy, mm,ohit,ocode)SELECT '"+year+"', '"+month+"',vod_media.hitcount,vod_media.ocode FROM vod_media  ";
		    	 
		    	     rtn = querymanager.executeQuery(query);
	    	     
		    	} catch(Exception e) {
		    		System.out.println(e);
		    	}
		    	try {
		    	     query = "INSERT INTO vod_hitlog (yy, mm,ohit,ocode)SELECT '"+year+"', '"+month+"',photo.mhit,photo.ocode FROM photo where pflag='M' ";
			    	 
		    	     rtn = querymanager.executeQuery(query);

		    	} catch(Exception e) {
		    		System.out.println(e);
		    	}
		       }
 
		    	return rtn;
		    }
		  

		    
		  public Vector month_hit_cnt(String year , String month) {
			  if (  year != null && year.length()> 0 && month != null && month.length() > 0) {
			    	 
		        String query = "select idx from vod_hitlog where yy='"+year+"' and mm='"+month+"' ";
		   		return querymanager.selectEntity(query);
			  } else {
				  return null;
			  }
		   }  	
		
		
}
