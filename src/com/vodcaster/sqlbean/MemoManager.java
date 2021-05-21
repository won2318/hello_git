package com.vodcaster.sqlbean;

import com.yundara.util.CharacterSet;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.StringEscapeUtils;

import com.security.SEEDUtil;
/**
 * @author Jong-Sung Park
 *
 * ������ �̵���� �޸��� ���� Ŭ����
 * Date: 2009. 07. 16.
 */
public class MemoManager {

	private static MemoManager instance;

	private MemoSqlBean sqlbean = null;

	private MemoManager() {
        sqlbean = new MemoSqlBean();
    }

	public static MemoManager getInstance() {
		if(instance == null) {
			synchronized(MemoManager.class) {
				if(instance == null) {
					instance = new MemoManager();
				}
			}
		}
		return instance;
	}

	/*****************************************************
	Ư�� �������� �޸𳻿� ����.<p>
	<b>�ۼ���</b> : ������<br>
	@return <br>
	@param ocode �������ڵ�, page ������, limit ������ ����Ʈ ����, flag ����������
	******************************************************/
	public Hashtable getMemoListLimit(String ocode, int page, int limit, String flag) {
        Hashtable result_ht;
        if(ocode == null || com.vodcaster.utils.TextUtil.getValue(ocode).equals("")
				|| !com.yundara.util.TextUtil.isNumeric(ocode)) 
        {
        	result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
            return result_ht;
        }
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		if(flag == null || com.vodcaster.utils.TextUtil.getValue(flag).equals("") 
				|| com.vodcaster.utils.TextUtil.getValue(flag).length()>1)
		{
			result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
            return result_ht;
		}
        flag = com.vodcaster.utils.TextUtil.getValue(flag);
        
         
        if (flag != null && flag.length() > 0) {
	       
	       // String query = " SELECT * FROM content_memo WHERE ocode='"+ocode+"' and flag='"+flag+"' ORDER BY muid DESC ";
	       // String count_query = " SELECT count(*) FROM content_memo WHERE ocode='"+ocode+"' and flag='"+flag+"' ";
	        String query ="";
	        String count_query="";
	        if(ocode != null && ocode.length()>0){

		        if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid DESC ";
		        	count_query = " SELECT count(*) FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.ocode='"+ocode+"'  and a.flag='"+flag+"' ";
		        } else if (flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid  FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid DESC ";
		        	count_query = " SELECT count(*) FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.ocode='"+ocode+"'  and a.flag='"+flag+"' ";
		        } else if (flag != null && flag.equals("L")) {
		        	query = " SELECT a.*, b.rtitle, b.rwdate FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid DESC ";
		        	count_query = " SELECT count(*) FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.ocode='"+ocode+"'  and a.flag='"+flag+"' ";
		       
		        }
	        }else{
	        	if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.flag='"+flag+"' ORDER BY a.muid DESC ";
		        	count_query = " SELECT count(*) FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and  a.flag='"+flag+"' ";
		        }else if (flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.flag='"+flag+"' ORDER BY a.muid DESC ";
		        	count_query = " SELECT count(*) FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and  a.flag='"+flag+"' ";
		        }else if (flag != null && flag.equals("L")){
		        	query = " SELECT a.*,  b.rtitle, b.rwdate FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.flag='"+flag+"' ORDER BY a.muid DESC ";
		        	count_query = " SELECT count(*) FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and  a.flag='"+flag+"' ";
		        } else {
		        	query = " SELECT * FROM content_memo WHERE  flag='"+flag+"' ORDER BY muid DESC ";
		            count_query = " SELECT count(*) FROM content_memo WHERE  flag='"+flag+"' ";
		            
		        }
	        }
	        
	       // System.out.println(query);
	       // System.out.println(count_query);
	        try {
	            result_ht = sqlbean.getMemoListLimit(page, query,count_query, limit);
	
	        }catch (Exception e) {
	            result_ht = new Hashtable();
	            result_ht.put("LIST", new Vector());
	            result_ht.put("PAGE", new com.yundara.util.PageBean());
	            
	        }
			//System.err.println("Query ====> " + query);
			return result_ht;
        } else {
        	result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
            return result_ht;
        }
    }
	
	
	public Vector getMemoListAll(String ocode, String flag, String order) {
		Vector vt = null;
    
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
 
        flag = com.vodcaster.utils.TextUtil.getValue(flag);
        
         
        if (flag != null && flag.length() > 0) {
 	        String query ="";
 	        if(ocode != null && ocode.length()>0){

		        if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        } else if (flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid  FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid  " + order;
 		        } else if (flag != null && flag.equals("L")) {
		        	query = " SELECT a.*, b.rtitle, b.rwdate FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid  " + order;
 		        }
	        }else{
	        	if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        }else if (flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        }else if (flag != null && flag.equals("L")){
		        	query = " SELECT a.*,  b.rtitle, b.rwdate FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        } else {
		        	query = " SELECT * FROM content_memo WHERE  flag='"+flag+"' ORDER BY muid  " + order;
 	            
		        }
	        }
 //System.out.println(query);
	        try {
	        	vt = sqlbean.selectQuerylist( query);
	
	        }catch (Exception e) {
	      
	        }
 
        } 
        return vt;
    }


	public Vector getMemoListHashAll(String ocode, String flag, String order) {
		Vector vt = null;
    
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
 
        flag = com.vodcaster.utils.TextUtil.getValue(flag);
        
         
        if (flag != null && flag.length() > 0) {
 	        String query ="";
 	        if(ocode != null && ocode.length()>0){

		        if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        } else if (flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid  FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid  " + order;
 		        } else if (flag != null && flag.equals("L")) {
		        	query = " SELECT a.*, b.rtitle, b.rwdate FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid  " + order;
 		        }
	        }else{
	        	if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        }else if (flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        }else if (flag != null && flag.equals("L")){
		        	query = " SELECT a.*,  b.rtitle, b.rwdate FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.flag='"+flag+"' ORDER BY a.muid " + order;
 		        } else {
		        	query = " SELECT * FROM content_memo WHERE  flag='"+flag+"' ORDER BY muid  " + order;
 	            
		        }
	        }
 //System.out.println(query);
	        try {
	        	vt = sqlbean.selectHashListAll( query);
	
	        }catch (Exception e) {
	      
	        }
 
        } 
        return vt;
    }


	

	/*****************************************************
	Ư�� �������� �޸𳻿� ����.<p>
	<b>�ۼ���</b> : ������<br>
	@return <br>
	@param ocode �������ڵ�, page ������, limit ������ ����Ʈ ����, flag ����������
	******************************************************/
	public Hashtable getMemoListLimitMan(String ocode, int page, int limit, String flag) {




        Hashtable result_ht;
        /*
        if(ocode == null || com.vodcaster.utils.TextUtil.getValue(ocode).equals("")
				|| !com.yundara.util.TextUtil.isNumeric(ocode)) 
        {
        	result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
            return result_ht;
        }
        */
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);


		if(flag == null || com.vodcaster.utils.TextUtil.getValue(flag).equals("") 
				|| com.vodcaster.utils.TextUtil.getValue(flag).length()>1)
		{
			result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
            return result_ht;
		}
        flag = com.vodcaster.utils.TextUtil.getValue(flag);
        
         
        if (flag != null && flag.length() > 0) {
	       
	       // String query = " SELECT * FROM content_memo WHERE ocode='"+ocode+"' and flag='"+flag+"' ORDER BY muid DESC ";
	       // String count_query = " SELECT count(*) FROM content_memo WHERE ocode='"+ocode+"' and flag='"+flag+"' ";
	        String query ="";
	        String count_query="";
	        if(ocode != null && ocode.length()>0){

		        if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid DESC ";
 		        	count_query = " SELECT count(*) FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.ocode='"+ocode+"'  and a.flag='"+flag+"' ";
		        } else if(flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid  FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid DESC ";
 		        	count_query = " SELECT count(*) FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.ocode='"+ocode+"'  and a.flag='"+flag+"' ";
 
		        } else if(flag != null && flag.equals("L")){
		        	query = " SELECT a.*, b.rtitle, b.rwdate  FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.ocode='"+ocode+"' and a.flag='"+flag+"' ORDER BY a.muid DESC ";
 		        	count_query = " SELECT count(*) FROM content_memo a, live_media b WHERE a.ocode = b.rcode  and a.ocode='"+ocode+"'  and a.flag='"+flag+"' ";
 		        	
		        }
	        }else{
	        	if(flag != null && flag.equals("B")){
		        	query = " SELECT a.*, b.list_title,b.list_date,b.board_id, b.list_name FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and a.flag='"+flag+"' ORDER BY a.muid DESC ";
		        	count_query = " SELECT count(*) FROM content_memo a, board_list b WHERE a.ocode = b.list_id  and  a.flag='"+flag+"' ";
		        }else if (flag != null && flag.equals("M")){
		        	query = " SELECT a.*, b.title, b.mk_date, b.ccode, b.ownerid FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and a.flag='"+flag+"' ORDER BY a.muid DESC ";
 		        	count_query = " SELECT count(*) FROM content_memo a, vod_media b WHERE a.ocode = b.ocode  and  a.flag='"+flag+"' ";
		        } else if(flag != null && flag.equals("L")){
		        	query = " SELECT a.*, b.rtitle, b.rwdate  FROM content_memo a, live_media b WHERE a.ocode = b.rcode and a.flag='"+flag+"' ORDER BY a.muid DESC ";
 		        	count_query = " SELECT count(*) FROM content_memo a, live_media b WHERE a.ocode = b.rcode   and a.flag='"+flag+"' ";
 
		        } else {
		        	query = " SELECT * FROM content_memo WHERE  flag='"+flag+"' ORDER BY muid DESC ";
 		            count_query = " SELECT count(*) FROM content_memo WHERE  flag='"+flag+"' ";
		            
		        }
	        }
	        
	       // System.out.println(query);
	       // System.out.println(count_query);
	        try {
	            result_ht = sqlbean.getMemoListLimit(page, query,count_query, limit);
	
	        }catch (Exception e) {


	            result_ht = new Hashtable();
	            result_ht.put("LIST", new Vector());
	            result_ht.put("PAGE", new com.yundara.util.PageBean());
	            System.err.println("Query ====> " + query);
	            System.err.println("memo select exception ====> " + e);
	        }




	//		
			return result_ht;
        } else {
        	result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
            return result_ht;
        }
    }

	/*****************************************************
	Ư�� �������� �޸� ���� ����.<p>
	<b>�ۼ���</b> : ������<br>
	@return <br>
	@param ocode �������ڵ�, flag ����������
	******************************************************/
	public int getMemoCount ( String ocode, String flag){
		String query="";
		if(ocode == null || com.vodcaster.utils.TextUtil.getValue(ocode).equals("")
				|| !com.yundara.util.TextUtil.isNumeric(ocode)) return -1;
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		if(flag == null || com.vodcaster.utils.TextUtil.getValue(flag).equals("") 
				|| com.vodcaster.utils.TextUtil.getValue(flag).length()>1) return -1;
        flag = com.vodcaster.utils.TextUtil.getValue(flag);
        
		
		if (ocode != null && ocode.length() > 0 && flag != null && flag.length() > 0) {
			query = " select count(*) from content_memo where ocode='" +ocode+ "' and flag='"+flag+"' order by muid ";
			return sqlbean.selectMemoCount(query);
		} else {
			return 0;
		}
	}
	

	/*****************************************************
	Ư�� �������� �޸� �佺���� ����.<p>
	<b>�ۼ���</b> : ������<br>
	@return <br>
	@param id �޸��� ID
	******************************************************/
	public String getPwd(String id) {
        String pwd = "";
        if(id == null || com.vodcaster.utils.TextUtil.getValue(id).equals("")) return "";
		id = com.vodcaster.utils.TextUtil.getValue(id);
		
		
        Vector v = sqlbean.selectQuery("select pwd from content_memo where muid=" +id);
        if(v != null && v.size() > 0) {

            pwd = String.valueOf(v.elementAt(0));
        }
        return pwd;
    }


	/*****************************************************
	Ư�� �������� �޸� ����, ����.<p>
	<b>�ۼ���</b> : ������<br>
	@return �������� ������ �����̸� row��, ������ ���� -1, Ŀ�ؼ� ������ ��� 99 <br>
	@param memoBean MemoInfoBeanŬ����
	******************************************************/
	public int saveMemo(MemoInfoBean memoBean, String jaction) throws Exception {
        String query = "";
        if (StringUtils.equals(jaction, "save")) {
        	if(memoBean.getFlag() != null && memoBean.getFlag().length() > 0 ){
        	
            query = " INSERT INTO content_memo (ocode,id,pwd,wdate,comment,wname,wnick_name, ip, flag) VALUES ('"
                + memoBean.getOcode() + "', "
                + "'" + memoBean.getId() + "', "
                + "'" + memoBean.getPwd() + "', "
                + " NOW(), "
                + "'" + StringEscapeUtils.escapeSql(memoBean.getComment()) + "', "
              
                  + "'" + SEEDUtil.getEncrypt(StringEscapeUtils.escapeSql(memoBean.getWname())) + "', "
                
                + "'" + StringEscapeUtils.escapeSql(memoBean.getWnick_name()) + "', "
				+ "'" + memoBean.getIp() + "', "
                + "'" + memoBean.getFlag() + "' )";
        	} else {
        		return -1;
        	}
        } else {
            query = " DELETE FROM content_memo WHERE muid="+memoBean.getMuid();
        }
        
    //System.out.println("saveMemo:"+query);
        return sqlbean.saveMemo(query);        
    }



	/*****************************************************
	Ư�� �������� �޸𳻿� ����.<p>
	<b>�ۼ���</b> : ������<br>
	@return <br>
	@param ���̵�,��ȣ, �̵���ڵ�
	******************************************************/
	public int deleteMemo( String ocode, String flag) throws Exception {
		if(ocode == null || com.vodcaster.utils.TextUtil.getValue(ocode).equals("")
				|| !com.yundara.util.TextUtil.isNumeric(ocode)) return -1;
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		if(flag == null || com.vodcaster.utils.TextUtil.getValue(flag).equals("") 
				|| com.vodcaster.utils.TextUtil.getValue(flag).length()>1) return -1;
        flag = com.vodcaster.utils.TextUtil.getValue(flag);
        
		return sqlbean.deleteMemo(ocode, flag);
	}

}
