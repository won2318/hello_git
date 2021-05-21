package com.vodcaster.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.yundara.util.CharacterSet;

public class FucksInfoManager {
	private static FucksInfoManager instance;
	private FucksInfoSql sqlbean = null;
    
	private FucksInfoManager() {
        sqlbean = new FucksInfoSql();
    }
    
	public static FucksInfoManager getInstance() {
		if(instance == null) {
			synchronized(FucksInfoManager.class) {
				if(instance == null) {
					instance = new FucksInfoManager();
				}
			}
		}
		return instance;
	}
	
	/*****************************************************
		���̵� �Է¹޾� ��û ����� ���� ����.<p>
		<b>�ۼ���</b> : �����<br>
		@return <br> ����� faile=-1, success= >0
		@param ���̵� 
	******************************************************/
	public int deleteFuck( String fuck_id) {
		fuck_id = com.vodcaster.utils.TextUtil.getValue(fuck_id);
		return sqlbean.deleteFuckInfo(fuck_id);
	}
	
	/*****************************************************
	�弳������ �����մϴ�.(insert�� ����)<p>
	<b>�ۼ���</b>       : �����<br>
	@return �������� ������ �����̸� row��, ������ ���� -1, Ŀ�ؼ� ������ ��� 99
	@see QueryManager#updateEntities
	******************************************************/
	public int insertFuckInfo(HttpServletRequest req) throws Exception 
	{
		// �⺻�������� �ʱ�ȭ �Ѵ�.
		String fucks    			=  "";
				//�Ķ��Ÿ ���� �������� üũ�Ѵ�.
		if(req.getParameter("fucks") !=null && req.getParameter("fucks").length()>0 && !req.getParameter("fucks").equals("null")){
			fucks = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks")));
			//fucks = com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks"));
		}else{
			return -1;
		}
		return sqlbean.insertFucks(fucks);
	}
	
	/*****************************************************
	�弳������ ���� �����մϴ�.(update�� ����)<p>
	<b>�ۼ���</b>       : �����<br>
	@return �������� ������ �����̸� row��, ������ ���� -1, Ŀ�ؼ� ������ ��� 99
	@see QueryManager#updateEntities
	******************************************************/
	public int updateFuckInfo(HttpServletRequest req) throws Exception 
	{
		// �⺻�������� �ʱ�ȭ �Ѵ�.
		String fucks    			=  "";
		int fuck_id = 0;
		
		//�Ķ��Ÿ ���� �������� üũ�Ѵ�.
		if(req.getParameter("fuck_id") !=null && req.getParameter("fuck_id").length()>0 && !req.getParameter("fuck_id").equals("null") 
				&& com.yundara.util.TextUtil.isNumeric(com.vodcaster.utils.TextUtil.getValue(req.getParameter("fuck_id"))))  {
			fuck_id = Integer.parseInt(req.getParameter("fuck_id"));
		}else{
			return -1;
		}
		
		//�Ķ��Ÿ ���� �������� üũ�Ѵ�.
		if(req.getParameter("fucks") !=null && req.getParameter("fucks").length()>0 && !req.getParameter("fucks").equals("null")){
			fucks = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks")));
			//fucks =  com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks"));
		}else{
			return -1;
		}
		return sqlbean.modifyFuckInfo(fuck_id, fucks);
	}
	
	/*****************************************************
		�˻��� �弳 �Խ��Ǳ��� ����Ʈ�� �Ѱ��ݴϴ�.(������)<p>
		<b>�ۼ���</b>       : �����<br>
		@return �˻��� ���� Ư�� �弳 �Խ����� �Խù� ���� ����<br>
		@param  searchstring Ű���� ����
		@see QueryManager#selectEntities
	******************************************************/
	public Hashtable getAllFucks_admin(  String searchstring,  int page, int limit, String orderby, String order){
		
		String sub_query = "";
		orderby = com.vodcaster.utils.TextUtil.getValue(orderby);
		order = com.vodcaster.utils.TextUtil.getValue(order);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		Hashtable result_ht;
		String query = "";
		String count_query = "";
		if(order == null || order.length()<=0){
			order = " fuck_id ";
		}
		if(searchstring != null && searchstring.length()>0) { // �� �������� �˻��� ���
			query = "select * from  fuck_info where fucks like '%"+searchstring+"%'  order by  "+order+" desc";
			count_query = " select count(*) from  fuck_info where fucks like '%"+searchstring+"%'  ";
		}else{
			query = "select * from  fuck_info   order by  "+order+" desc";
			count_query = " select count(*) from  fuck_info    ";
		}
		try { 
	        result_ht = sqlbean.selectFucksListAll(page, query, count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	/*****************************************************
		�˻��� �弳 �Խ��Ǳ��� ����Ʈ�� �Ѱ��ݴϴ�.(������)<p>
		<b>�ۼ���</b>       : �����<br>
		@return �˻��� ���� Ư�� �弳 �Խ����� �Խù� ���� ����<br>
		@param  searchstring Ű���� ����
		@see QueryManager#selectEntities
	******************************************************/
	public Hashtable getAllFucks_admin(  String searchstring ){
		
		String sub_query = "";
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		Hashtable result_ht;
		String query = "";
		String count_query = "";
		
		if(searchstring != null && searchstring.length()>0){
			query = "select * from  fuck_info  where fucks like '%"+searchstring+"%' order by  fucks desc";
			count_query = "select count(fucks) from  fuck_info where fucks like '%"+searchstring+"%'  ";
		}else{
			query = "select * from  fuck_info   order by  fucks desc";
			count_query = "select count(fucks) from  fuck_info   ";
		}
	
		
		try { 
	        result_ht = sqlbean.selectFucksListAll(  query, count_query );
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	public Vector getFuck(String seq) {

		seq = com.vodcaster.utils.TextUtil.getValue(seq);
		if (seq != null && seq.length() > 0) {
	      String query = "select * from fuck_info where fuck_id="+seq ;

			return sqlbean.selectHashEntities(query);
		} else {
			return null;
		}

	    }

}
