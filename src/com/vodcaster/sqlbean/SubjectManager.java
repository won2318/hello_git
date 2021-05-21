/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;


import com.vodcaster.utils.WebutilsExt;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.sqlbean.DirectoryNameManager;
import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.TimeUtil;
import javazoom.upload.*;
import java.io.*;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.math.NumberUtils;


/**
 * @author Choi Hee-Sung
 *
 * photo ���� Ŭ����
 */
public class SubjectManager {

	private static SubjectManager instance;
	
	private SubjectSqlBean sqlbean = null;
    
	private SubjectManager() {
        sqlbean = new SubjectSqlBean();
        //sqlbean.printLog("SubjectManager �ν��Ͻ� ����");
    }
    
	public static SubjectManager getInstance() {
		if(instance == null) {
			synchronized(SubjectManager.class) {
				if(instance == null) {
					instance = new SubjectManager();
				}
			}
		}
		return instance;
	}
    


	/*****************************************************
	  Subject ���� ��� ����Ʈ
	  ������ 
	******************************************************/
	public Hashtable getSubjectList( int page, int limit ,String flag) {

        Hashtable result_ht;
        flag = com.vodcaster.utils.TextUtil.getValue(flag);
        String query = "";

        query = "select * from subject where sub_idx is not null and sub_flag='"+flag+"' order by sub_idx desc ";
        String count_query = "select count(sub_idx) from subject where sub_idx is not null and sub_flag='"+flag+"'  ";

        try {
            result_ht = sqlbean.getSubjectList(page, query,count_query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;

    }
	
	public Hashtable getSubjectList( int page, int limit ) {

        Hashtable result_ht;

        String query = "";

        query = "select * from subject where sub_idx is not null order by sub_idx desc ";
        String count_query = "select count(sub_idx) from subject where sub_idx is not null  ";
        try {
            result_ht = sqlbean.getSubjectList(page, query, count_query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;

    }
	
	public Vector getSubjectListDate (String flag){
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
//      String query =  " select * from subject  where sub_start <= sysdate and sysdate <= sub_end order by sub_idx asc ";
		//String query = " select * from subject where sub_flag='"+flag+"' and to_date(to_char(sub_start,'YYYY-MM-DD'),'yyyy-mm-dd') <= to_date(to_char(sysdate,'YYYY-MM-DD'),'yyyy-mm-dd') and to_date(to_char(sysdate,'YYYY-MM-DD'),'yyyy-mm-dd') <= to_date(to_char(sub_end,'YYYY-MM-DD'),'yyyy-mm-dd')";
		String query = " select a.*, (SELECT count(e.user_idx) from  subject_user e , subject_info d where d.user_idx=e.user_idx and d.sub_idx=a.sub_idx ) from subject a where a.sub_flag='"+flag+"' and a.sub_start <=  date_format(now(),'%Y-%m-%d') and  date_format(now(),'%Y-%m-%d') <= a.sub_end ";
//System.out.println(query);
		return sqlbean.selectQuery(query);

    }
	


	/*****************************************************
	  Subject ���� ���� ��� ����Ʈ
	  ������ 
	******************************************************/
	public Vector getSubject(String idx) {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
	      String query = "select * from subject where sub_idx="+idx ;
		  return sqlbean.selectQuery(query);
	}

	/*****************************************************
	  Subject ���� ���� ��� ����Ʈ
	  ������ 
	******************************************************/
	public Vector getSubject_lecture_idx(String idx) {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
	      String query = " select  *  from subject_user where lecture_idx="+idx ;
		  return sqlbean.selectQuery(query);
	}


	/*****************************************************
    Subject ���� ����.<p>
	<b>�ۼ���</b> : ������ <br>
	@return Subject<br>
	@param seq �Ϸù�ȣ
	******************************************************/

	public int delete_subject(String idx) throws Exception {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		return sqlbean.delete_subject(idx);
	}

	public int delete_question(String idx) throws Exception {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		return sqlbean.delete_question(idx);
	}

	public int delete_info(String idx) throws Exception {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		return sqlbean.delete_info(idx);
	}

	public int delete_ans(String idx) throws Exception {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		return sqlbean.delete_ans(idx);
	}

	public int delete_ans_idx(String idx) throws Exception {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		return sqlbean.delete_ans_idx(idx);
	}


	//////////////
	// ������ȣ ������Ʈ
	/////////////
	public int getQuestion_inxUp(String num, String idx) {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		num = com.vodcaster.utils.TextUtil.getValue(num);
		  return sqlbean.getQuestion_inxUp(num, idx);
	}


	public int getAns_inxUp(String num, String idx) {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		num = com.vodcaster.utils.TextUtil.getValue(num);
		
		  return sqlbean.getAns_inxUp(num, idx);
	}

	/*****************************************************
	  Subject_question ���� ��� ����Ʈ
	  ������ 
	******************************************************/
	public Hashtable getSubject_QuestionList(String idx, int page, int limit) {

        Hashtable result_ht;

        String query = "";
        idx = com.vodcaster.utils.TextUtil.getValue(idx);
        query = "select * from subject_question where sub_idx="+idx+" order by CAST(question_num  AS DECIMAL) ASC, question_idx asc ";
        String count_query = "select count(question_idx) from subject_question where sub_idx="+idx+"  ";

        try {
            result_ht = sqlbean.getSubjectList(page, query,count_query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }

	/*
	public Vector getSubject_QuestionListAll(String idx) {
		return getSubject_QuestionListAll(idx);
    }
	*/

	/*****************************************************
	  Subject ���� ���� ��� ����Ʈ
	  ������ 
	******************************************************/
	public Vector getSubject_Question(String idx) {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
	      String query = "select * from subject_question where question_idx="+idx ;
	
	
		  return sqlbean.selectQuery(query);
	}




	/*****************************************************
	  Subject_ans ���� ��� ����Ʈ
	  ������ 
	******************************************************/
	public Hashtable getSubject_AnsList(String idx, int page, int limit) {

		idx = com.vodcaster.utils.TextUtil.getValue(idx);
        Hashtable result_ht;

        String query = "";

        query = "select * from subject_ans where question_idx="+idx+" order by ans_num asc , ans_idx desc ";
        String count_query = "select count(ans_num) from subject_ans where question_idx="+idx;

        try {
            result_ht = sqlbean.getSubjectList(page, query, count_query,  limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }

	public Vector getSubject_AnsList(String question_idx) {
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		return sqlbean.getSubject_AnsList(question_idx);
	}

	public Vector getSubject_QuiestionList(String question_idx) {
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		return sqlbean.getSubject_QuiestionList(question_idx);
	}


	public String getSubject_AnsInx(String question_idx) {
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		return sqlbean.getSubject_AnsInx(question_idx);
	}

	public String getAns_num(String question_idx) {
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		return sqlbean.getAns_num(question_idx);
	}
	
	public String getAns_order(String question_idx) {
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		return sqlbean.getAns_order(question_idx);
	}

	/*****************************************************
	  Subject_ans ���� ���� ��� ����Ʈ
	  ������ 
	******************************************************/
	public Vector getSubject_Ans(String idx) {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
	
	      String query = "select * from subject_question where question_idx="+idx ;
		  return sqlbean.selectQuery(query);
	}
	
	public int insert_subject (HttpServletRequest req) throws Exception {
		return sqlbean.insert_subject(req);
	}
	
	public int update_subject (HttpServletRequest req) throws Exception {
		return sqlbean.update_subject(req);
	}
	
	
	
	/*���� �ο��� */
	
	public int user_count(String sub_idx) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		return sqlbean.user_count( sub_idx);
	}

	public int user_count(String sub_idx, String MF) {
		MF = com.vodcaster.utils.TextUtil.getValue(MF);
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		return sqlbean.user_count( sub_idx, MF);
	}
	
	/* ���� ���� ��� */
	public int user_count_question(String sub_idx, String question_idx) {
	
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		return sqlbean.user_count_question(sub_idx, question_idx);
	}
	public int user_count_question(String sub_idx, String question_idx,String MF, String question_flag) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		MF = com.vodcaster.utils.TextUtil.getValue(MF);
		question_flag = com.vodcaster.utils.TextUtil.getValue(question_flag);
		return sqlbean.user_count_question(sub_idx, question_idx, MF,question_flag);
	}
	public int user_count_question(String sub_idx, String question_idx,String MF, String question_flag, String teacher_code, String delivery_idx) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		question_flag = com.vodcaster.utils.TextUtil.getValue(question_flag);
		teacher_code = com.vodcaster.utils.TextUtil.getValue(teacher_code);
		delivery_idx = com.vodcaster.utils.TextUtil.getValue(delivery_idx);
		MF = com.vodcaster.utils.TextUtil.getValue(MF);
		return sqlbean.user_count_question(sub_idx, question_idx, MF,question_flag, teacher_code, delivery_idx);
	}
	
	
	/* ���� ���� �亯 ���� */
	
	public int user_count_ans(String sub_idx, String question_idx, String ans_idx) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		ans_idx = com.vodcaster.utils.TextUtil.getValue(ans_idx);
		
		return sqlbean.user_count_ans( sub_idx,  question_idx,  ans_idx);
	}

	public int user_count_ans(String sub_idx, String question_idx, String ans_idx,String MF) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		ans_idx = com.vodcaster.utils.TextUtil.getValue(ans_idx);
		MF = com.vodcaster.utils.TextUtil.getValue(MF);
		return sqlbean.user_count_ans( sub_idx,  question_idx,  ans_idx, MF);
	}
	
	public int user_count_ans(String sub_idx, String question_idx, String ans_idx,String MF, String teacher_code, String delivery_idx) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		ans_idx = com.vodcaster.utils.TextUtil.getValue(ans_idx);
		teacher_code = com.vodcaster.utils.TextUtil.getValue(teacher_code);
		MF = com.vodcaster.utils.TextUtil.getValue(MF);
		delivery_idx = com.vodcaster.utils.TextUtil.getValue(delivery_idx);
		return sqlbean.user_count_ans( sub_idx,  question_idx,  ans_idx, MF, teacher_code, delivery_idx);
	}
	
	/* ���� �亯 �ݺ� (������ư) */
	public int user_count_ans2(String sub_idx, String question_idx, String ans_idx, String ans_num) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		ans_idx = com.vodcaster.utils.TextUtil.getValue(ans_idx);
		ans_num = com.vodcaster.utils.TextUtil.getValue(ans_num);
		
		return sqlbean.user_count_ans2( sub_idx,  question_idx,  ans_idx, ans_num);
	}

	public int user_count_ans2(String sub_idx, String question_idx, String ans_idx, String ans_num,String MF) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		ans_idx = com.vodcaster.utils.TextUtil.getValue(ans_idx);
		ans_num = com.vodcaster.utils.TextUtil.getValue(ans_num);
		MF = com.vodcaster.utils.TextUtil.getValue(MF);
		return sqlbean.user_count_ans2( sub_idx,  question_idx,  ans_idx, ans_num, MF);
	}
	
	public int user_count_ans2(String sub_idx, String question_idx, String ans_idx, String ans_num,String MF, String teacher_code, String delivery_idx) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		
		ans_idx = com.vodcaster.utils.TextUtil.getValue(ans_idx);
		ans_num = com.vodcaster.utils.TextUtil.getValue(ans_num);
		MF = com.vodcaster.utils.TextUtil.getValue(MF);
		teacher_code = com.vodcaster.utils.TextUtil.getValue(teacher_code);
		delivery_idx = com.vodcaster.utils.TextUtil.getValue(delivery_idx);
		return sqlbean.user_count_ans2( sub_idx,  question_idx,  ans_idx, ans_num, MF,  teacher_code, delivery_idx);
	}



	public String getAns_user_num(String user_idx,String question_idx) {
		user_idx = com.vodcaster.utils.TextUtil.getValue(user_idx);
		question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
	  return sqlbean.getAns_user_num(user_idx,question_idx);
	 }
	 public String getAns_user_order(String user_idx,String question_idx) {
		 user_idx = com.vodcaster.utils.TextUtil.getValue(user_idx);
		 question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
	  return sqlbean.getAns_user_order(user_idx,question_idx);
	 }
	 public String getAns_user_order2(String user_idx, String question_idx) {
		 user_idx = com.vodcaster.utils.TextUtil.getValue(user_idx);
		 question_idx = com.vodcaster.utils.TextUtil.getValue(question_idx);
		 return sqlbean.getAns_user_order2(user_idx,question_idx);
	 }
	

	/*****************************************************
	Subject_info ���� ��� ����Ʈ
	����ȣ 
	 ******************************************************/
	public Hashtable getSubject_ContentList(String idx,String ans ,int page, int limit) {
		
		Hashtable result_ht;
		
		String query = "";
		String count_query = "";
		if(ans != null && ans.length()>0){
			query = "select * from subject_info where question_idx="+idx+" and ans="+ans+" order by user_idx asc ";
			count_query = "select count(info_idx) from subject_info where question_idx="+idx+" and ans="+ans+"  ";
		}else{
			query = "select * from subject_info where question_idx="+idx+" and ans_order is not null order by user_idx asc ";
			count_query = "select count(info_idx) from subject_info where question_idx="+idx+" and ans_order is not null  ";
		}
		
		try {
			result_ht = sqlbean.getSubjectList(page, query,count_query, limit);
			
		}catch (Exception e) {
			result_ht = new Hashtable();
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return result_ht;
		
	}

	public Hashtable getSubject_ContentList(String idx,String ans ,int page, int limit, String user_mf) {
		
		Hashtable result_ht;
		
		String query = " select d.* from  subject_info d, subject_user e  where d.user_idx=e.user_idx and d.question_idx="+idx+" ";
		String count_query = " select count(info_idx) from  subject_info d, subject_user e  where d.user_idx=e.user_idx and d.question_idx="+idx+" ";
		if(ans != null && ans.length()>0){
			query =  query + "and d.ans="+ans+" ";
			count_query = count_query + "and d.ans="+ans+" ";
		}else{
			query = query +" and d.ans_order is not null ";
			count_query = count_query +" and d.ans_order is not null ";
		}

		if (user_mf != null && user_mf.length() > 0)
		{
			query = query+ " and e.user_mf = '" + user_mf + "'" ;
			count_query = count_query+ " and e.user_mf = '" + user_mf + "'" ;
		}
		
		query = query + "  order by d.user_idx desc ";
		
		try {
			result_ht = sqlbean.getSubjectList(page, query, count_query, limit);
			
		}catch (Exception e) {
			result_ht = new Hashtable();
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return result_ht;
		
	}
	
	public Vector getAns_user_num_V(String user_idx,String question_idx) {
		  return sqlbean.getAns_user_num_V(user_idx,question_idx);
	}
	
//////////////////
//  ����� ����
////////////////
	public Vector getSubject_user(String user_idx) {
       String query = "select * from subject_user where user_idx="+user_idx ;
	  return sqlbean.selectQuery(query);
	}

	
	/*****************************************************
	Subject_user ����� ����Ʈ
	����ȣ 
	 ******************************************************/
	public Hashtable getSubject_UserList(String sub_idx, int page, int limit) {
		
		Hashtable result_ht;
		
		String query = "";
		String count_query = "";
		query = " select distinct (e.user_idx) e, e.* "
				+ " from subject a, subject_question b ,  subject_info d, subject_user e"
				+ " where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx"
				+ " and a.sub_idx= "+sub_idx
				+ " order by e.user_date desc";
		count_query = " select count(distinct (e.user_idx) ) "
			+ " from subject a, subject_question b ,  subject_info d, subject_user e"
			+ " where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx"
			+ " and a.sub_idx= "+sub_idx;
		
		try {
			result_ht = sqlbean.getSubjectList(page, query, count_query, limit);
		}catch (Exception e) {
			result_ht = new Hashtable();
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return result_ht;
		
	}
	

	public Hashtable getSubject_UserList(String sub_idx, int page, int limit, String point) {

		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		String qry = " select count(distinct (b.question_idx)) from subject a, subject_question b "
		+ " where b.sub_idx = a.sub_idx  and a.sub_idx= "+sub_idx ;


		Vector vt = sqlbean.selectQuery(qry);
		int Pcount = 0;

		if(vt != null && vt.size() > 0)
             Pcount = Integer.parseInt(String.valueOf(vt.elementAt(0)));
		
		Hashtable result_ht;
		
		String query = "";
		
		query = " select distinct (e.user_idx) e, e.* "
				+ " from subject a, subject_question b ,  subject_info d, subject_user e "
				+ " where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx "
				+ " and a.sub_idx= "+sub_idx ; 
				if (point != null && point.length() > 0 && point.equals("T")) { // ������
					query = query +  " and e.event_point >= " + Pcount;
				} else if(point != null && point.length() > 0 && point.equals("F")) {  // ������
					query = query +  " and e.event_point < " + Pcount;
				}
		String count_query = " select count(distinct (e.user_idx)) "
			+ " from subject a, subject_question b ,  subject_info d, subject_user e "
			+ " where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx "
			+ " and a.sub_idx= "+sub_idx ; 
			if (point != null && point.length() > 0 && point.equals("T")) { // ������
				count_query = count_query +  " and e.event_point >= " + Pcount;
			} else if(point != null && point.length() > 0 && point.equals("F")) {  // ������
				count_query = count_query +  " and e.event_point < " + Pcount;
			}
			
		query = query +  " order by e.user_date desc";

		
		try {
			result_ht = sqlbean.getSubjectList(page, query, count_query, limit);
		}catch (Exception e) {
			result_ht = new Hashtable();
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return result_ht;
		
	}
	
/*���� �ο��� */
	
	public int user_count_T(String sub_idx) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		return sqlbean.user_count_T(sub_idx);
	}


//////////////////////////
// �̺�Ʈ ��÷ �ο� ���
//////////////////////////


	public int getEvent_userList(String sub_idx, int people) {
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		return sqlbean.getEvent_userList(sub_idx, people);

    }

	public Vector getEvent_user(String sub_idx){
		sub_idx = com.vodcaster.utils.TextUtil.getValue(sub_idx);
		return sqlbean.getEvent_user(sub_idx);
    }
	
	public String getSubjectUser_check(String idx, String dupInfo) {
		idx = com.vodcaster.utils.TextUtil.getValue(idx);
		dupInfo = com.vodcaster.utils.TextUtil.getValue(dupInfo);
		return sqlbean.getSubjectUser_check(idx, dupInfo);
	}

}
