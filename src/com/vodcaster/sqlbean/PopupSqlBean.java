/*
 * Created on 2005. 1. 19
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

/**
 * @author ����
 *
 * ��Ų�ý��� DB��������
 */

import java.util.*;

import javax.servlet.http.*;
import dbcp.*;
import com.yundara.util.CharacterSet;
import com.yundara.util.PageBean;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;

public class PopupSqlBean extends SQLBeanExt {

    public PopupSqlBean() {
		super();
	}
    
	
	/*----------------------------------------------
	 * discription : instance ����
	 * �ۼ���       : ����ȣ
	 * �ۼ���       : 2007/12/17
	 *----------------------------------------------*/
	private static PopupSqlBean instance;
	public static PopupSqlBean getInstance() {
		if(instance == null) {
			synchronized(PopupSqlBean.class) {
				if(instance == null) {
					instance = new PopupSqlBean();
				}
			}
		}
		return instance;
	}

    public Vector selectQueryList(String query) {
        return querymanager.selectHashEntities(query);
    }



    public Vector selectQueryListExt(String query) {
        return querymanager.selectEntities(query);
    }


    public Vector selectQuery(String query) {
        return querymanager.selectEntity(query);
    }


    public int executeQuery(String query) {
        return querymanager.updateEntities(query);
    }


	
	public int updatePOP(String query) throws Exception {

		int iResult = -1;
        try {
        	iResult = querymanager.executeQuery(query);

        } catch(Exception e) {
            System.err.println("updatePOP ex "+e.getMessage());
        }

        return iResult;
	}
	
	/*----------------------------------------------
	�˾�â�� ÷���̹��� �Է�.<p>
	<b>�ۼ���</b> : ����ȣ<br>
	date : 2007-12-17
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param bean RealMediaInfoBean
	*----------------------------------------------*/
	public int insertPopImage(PopupInfoBean bean) throws Exception{

		String query = "update popupman set img_name = '" + bean.getImg_name().replace("'", "''")+ "' where seq = " + bean.getSeq();
		return querymanager.updateEntities(query);

	}
	
	/*****************************************************
	�˾� ÷���̹��� ����.<p>
	<b>�ۼ���</b> : ����ȣ<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param rcode ������ �̵���ڵ�, �̵���ڵ�
	******************************************************/
	public int dropPopupImage(String seq, String gubun) throws Exception{
	
	    String query = "";
	    Vector v = null;
	    int rtn = -1;
	
	    if(seq != null 
	    		&& seq.length()> 0
	    		&&  com.yundara.util.TextUtil.isNumeric(seq)
	    		&& gubun != null 
	    		&& gubun.length()>0
	    		&& com.yundara.util.TextUtil.isNumeric(gubun)) { // ������ ����Ȯ��
	        try {
	            // �̵�� ȭ�� ����
				String dir = DirectoryNameManager.UPLOAD_POPUP ;

                // ����ȭ�� �������
				String fileName = PopupManager.getInstance().getUploadFile(seq, gubun);
                if(FileUtil.existsFile( dir, fileName ) ) {
                    if(FileUtil.delete(dir, fileName) ) {
                        //System.err.println("ȭ�� ���� ����");
                    } else {
                        System.err.println("ȭ�� ���� ���� : " + fileName);
                    }
                }
               
                if(gubun.equals("2")){
                	query = "update popupman set img_name_mobile='' where seq=" +seq;
                }else{
                	query = "update popupman set img_name='' where seq=" +seq;
                }
	           //  System.err.println("�̹��� ���� =================>" + query);
	            int iResult = querymanager.executeQuery(query);
	
	            return iResult;
	        } catch (Exception e) {
				System.err.println("dropRMediaImage : "+ e.getMessage());
	        }
	        
	        if(v == null)
	            return -1;
	        else
	            return v.size();
	
	    } else
	        return -1;
	
	}
	
	/*----------------------------------------------
	 * discription : �˾� ����Ʈ
	 * �ۼ���       : ����ȣ
	 * �ش� ����    : /admin/site/frm_popList.jsp
	 * �ۼ���       : 2007/12/14
	 *----------------------------------------------*/
	public Hashtable getAllPopup(int page, int limit) {

		Hashtable result_ht;

		String query = "";

		query = " select * from popupman order by seq desc";
		String count_query =  " select count(*) from popupman ";
		//System.out.println("list query ::: " + query);
		try {
			result_ht = this.getMediaList(page, query,count_query,  limit);

		} catch (Exception e) {
			result_ht = new Hashtable();
			//result_ht.put("LIST", new Hashtable());
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return result_ht;
	}
	
	
	/*----------------------------------------------
	 * discription : �˾� ����
	 * �ۼ���       : ����ȣ
	 * �ش� ����    : /admin/site/frm_popList.jsp
	 * �ۼ���       : 2007/12/14
	 *----------------------------------------------*/
	public int deletePopup(String seq) {
		String query = "delete from popupman where seq = " + seq;
		int result2 = querymanager.updateEntities(query);

		return result2;
	}
	
	////////////////
	// �ؽ� ���̺� 
	// ����¡ ó�� 
	/////////////
	public Hashtable getMediaList(int page, String query, String count_query, int limit) {

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
		//139,4,10,1
		PageBean pb = new PageBean(totalRecord, limit, 10, page);
		//totalrecord,lineperpage,pageperblock,page

		// �ش� �������� ����Ʈ�� ��´�.
		String rquery = "";
		//if(pb.getStartRecord()-1 > limit){
		//	rquery = query + " limit 0,"+limit;
		//	pb = null;
		//	pb = new PageBean(totalRecord, limit, 10,1);
		//}else{
		rquery = query + " limit " + (pb.getStartRecord() - 1) + "," + limit;
		//}
		//log.printlog("MovieBoardSQLBean getBoardList method query"+query);
		//System.err.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if (result_v != null && result_v.size() > 0) {
			ht.put("LIST", result_v);
			ht.put("PAGE", pb);
		} else {
			//ht.put("LIST", new Hashtable());
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}
}
