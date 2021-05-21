/*
 * Created on 2009. 7. 16
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

import com.yundara.util.*;

import java.util.*;

import javax.servlet.http.*;

import dbcp.SQLBeanExt;

import com.hrlee.sqlbean.CategoryManager;
import com.vodcaster.sqlbean.DirectoryNameManager;

/**
 * @author Jong-Sung Park
 * 
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 * �Խ��ǰ��� ������ ���/����/���� ���� Ŭ�����Դϴ�.
 */
public class BoardInfoSQLBean extends SQLBeanExt implements java.io.Serializable{
	private static BoardInfoSQLBean instance;
	/*****************************************************
	�Խ��� ������<p>
	<b>�ۼ���</b>       : ������<br>
	******************************************************/
	public BoardInfoSQLBean() {
		super();
	}

	public static BoardInfoSQLBean getInstance() {
		if(instance == null) {
			synchronized(BoardInfoSQLBean.class) {
				if(instance == null) {
					instance = new BoardInfoSQLBean();
				}
			}
		}
		return instance;
	} 
	/************************************************  SELECT  ************************************************/

	/*****************************************************
	��ϵǾ� �ִ� �Խ��� ����Ʈ�� �������� �Ѱ��ݴϴ�.<p>
	<b>�ۼ���</b>       : ������<br>
	@return �Խ��� ���̵�, ����, �켱����, ������¥, ��ȸ��
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getAllBoardInfoList(){
		String query = "select a.board_id, a.board_title, a.board_priority, a.board_date, b.count_list_id "+
						"from board_info a "+
						"left join( select board_id, count(list_id) as  count_list_id from board_list where del_flag='N' group by board_id ) b "+
						"on a.board_id = b.board_id "+
						"where a.del_flag = 'N' " + 
						"order by a.board_priority, a.board_title";
		return 	querymanager.selectEntities(query);
	}

	/*****************************************************
	������ �Խ����� ��������� �Ѱ��ݴϴ�.<p>
	<b>�ۼ���</b>       : ������<br>
	@return �Խ��� ����, ������ ���μ�, �̹��� �ɼ�, ���Ͽɼ�, �Ӹ���, �Ʒ���, ����� ����, �켱����, ��ۿ���
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getOnlyBoardList(int board_id){
 
		if (board_id >= 0) {
			String query = "Select board_title, board_page_line, board_image_flag, board_file_flag, board_link_flag, " +
	                " board_user_flag, board_top_comments, board_footer_comments, board_priority, board_auth_list, " +
	                " board_auth_read, board_auth_write, flag, view_comment, board_ccode , " +
	                " board_security_flag, board_hidden_flag  " +
	                " from board_info where " +
	                " del_flag='N' and board_id ="+board_id;
	//System.out.println(query);
			return 	querymanager.selectEntity(query);
		} else {
			return null;
		}
	}


	/*****************************************************
	Ư�� �Խ����� ����Ʈ����,�ۺ���,�۾��⿡ ���� ȸ������ ������ �Ѱ��ݴϴ�.<p>
	<b>�ۼ���</b>       : ������<br>
	@return Ư�� �Խ����� ����Ʈ����,�ۺ���,�۾��⿡ ���� ȸ������ �������� ����<br>
	@param board_id �Խ����ڵ�, field ȸ������ �ʵ�
	@see QueryManager#selectEntity
	******************************************************/

	public int getBoardAuthLevel(int board_id, String field) throws Exception
	{
 
        if (board_id >= 0  && field != null && field.length() > 0) {
        field = com.vodcaster.utils.TextUtil.getValue(field);
        
        Vector v = null;
		String query ="select " + field+ " from board_info where board_id=" + board_id;
        v = querymanager.selectEntity(query);

	        if(v != null && v.size() > 0) {
	            return Integer.parseInt(String.valueOf(v.elementAt(0)));
	        }else{
	            return -99;
	        }
        } else {
        	return -1;
        }
	}
	
	public int getBoardAuthFlag(int board_id, String field) throws Exception
	{
		 if (board_id >= 0  && field != null && field.length() > 0) {
		        field = com.vodcaster.utils.TextUtil.getValue(field);
		         
		        Vector v = null;
				String query ="select " + field+ " from board_info where board_id=" + board_id;
		        v = querymanager.selectEntity(query);
		
		        if(v != null && v.size() > 0) {
		        	if (String.valueOf(v.elementAt(0)).equals("t")) {
		        		return 99;
		        	} else {
		        		return -1;
		        	}
		        }else{
		            return -1;
		        }
		 } else{
			 return -1;
		 }
			 
	}


	/************************************************  INSERT  ************************************************/

	/*****************************************************
	�Խ����� ��������� �����մϴ�.(insert�� ����)<p>
	<b>�ۼ���</b>       : ������<br>
	@return �������� ������ �����̸� row��, ������ ���� -1, Ŀ�ؼ� ������ ��� 99
	@see QueryManager#updateEntities
	******************************************************/
	public int insertBoardInfo(HttpServletRequest req) throws Exception 
	{
		// �⺻�������� �ʱ�ȭ �Ѵ�.
		String board_title    			=  "";
		String board_top_comments     	=  "";
		String board_footer_comments    =  "";
		String board_image_flag = "f";
		String board_file_flag  = "f";
		String board_link_flag  = "f";
		String board_user_flag  = "f";
		String view_comment  	= "f";
		String board_security_flag = "f";
		String board_hidden_flag = "f";
		String flag  = "N";
		int board_priority		=  0;
		int board_page_line		=  0;
        int board_auth_list     = 0;
        int board_auth_read     = 0;
        int board_auth_write    = 0;

		//�Ķ��Ÿ ���� �������� üũ�Ѵ�.
		if(req.getParameter("board_title") !=null)
			board_title	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_title").trim());
		if(req.getParameter("board_top_comments") !=null)
			board_top_comments	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_top_comments").trim());
		if(req.getParameter("board_footer_comments") !=null)
			board_footer_comments	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_footer_comments").trim());
		if(req.getParameter("board_priority") !=null)
			board_priority	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_priority").trim()));
		if(req.getParameter("board_page_line") !=null)
			board_page_line	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_page_line").trim()));

		if(req.getParameter("board_auth_list") !=null)
			board_auth_list	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_auth_list").trim()));
		if(req.getParameter("board_auth_read") !=null)
			board_auth_read	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_auth_read").trim()));
		if(req.getParameter("board_auth_write") !=null)
			board_auth_write	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_auth_write").trim()));
		if(req.getParameter("flag") !=null)
			flag	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("flag").trim());


		//�������� ó�����¸� üũ�Ѵ�.
		try {
			if(req.getParameter("board_image_flag") != null && req.getParameter("board_image_flag").equals("t")) board_image_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_file_flag") != null && req.getParameter("board_file_flag").equals("t")) board_file_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_link_flag") != null && req.getParameter("board_link_flag").equals("t")) board_link_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_user_flag") != null && req.getParameter("board_user_flag").equals("t")) board_user_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_security_flag") != null && req.getParameter("board_security_flag").equals("t")) board_security_flag = "t";
		}catch(Exception e){}
		try {
		try {
			if(req.getParameter("board_hidden_flag") != null && req.getParameter("board_hidden_flag").equals("t")) board_hidden_flag = "t";
		}catch(Exception e){}
			if(req.getParameter("view_comment") != null && req.getParameter("view_comment").equals("t")) view_comment = "t";
		}catch(Exception e){}

		//board_id ����, �Խ��� ������ �հ迡 1�� ���Ѵ�.
		int board_id = 1;

		Vector v = null;
		try{
			v = querymanager.selectEntity("select max(board_id) from board_info");
		}catch(ArrayIndexOutOfBoundsException e){
			System.err.println("insertBoardInfo ex : " + e);
		}

		if(v != null && v.size() > 0){
			try{
				if(Integer.parseInt(String.valueOf(v.elementAt(0))) != 0)
					board_id = Integer.parseInt(String.valueOf(v.elementAt(0))) + 1;
				else board_id = 1;
			}catch(Exception e){
				System.err.println("insertBoardInfo ex : " + e);
			}
		}else{
			board_id = 0;
		}
		String query ="insert into board_info (board_id, board_title, board_page_line, board_image_flag,"+
		              " board_file_flag, board_link_flag, board_top_comments, board_footer_comments, board_user_flag, board_priority, " +
		              "board_date,board_auth_list,board_auth_read,board_auth_write, flag, view_comment, board_security_flag , board_hidden_flag)  values("
					+board_id+", '"+board_title+"', "+board_page_line+",'"+board_image_flag+"', '"+board_file_flag+"', '"+
					board_link_flag+"','"+board_top_comments+"', '"+board_footer_comments+"', '"+board_user_flag+"', "+board_priority+", now()," +
                    board_auth_list+ "," +board_auth_read+ "," +board_auth_write+ ",'"+flag+"','"+view_comment+"','"+board_security_flag+"','"+board_hidden_flag+"')";

		return querymanager.updateEntities(query);
	}


	/************************************************  UPDATE  ************************************************/

	/*****************************************************
	�Խ����� ��������� �����մϴ�.(update�� ����)<p>
	<b>�ۼ���</b>       : ������<br>
	@return �������� ������ �����̸� row��, ������ ���� -1
	@see QueryManager#updateEntities
	******************************************************/
	public int updateBoardInfo(HttpServletRequest req) throws Exception 
	{

		// �⺻�������� �ʱ�ȭ �Ѵ�.
		String board_title    			=  "";
		String board_top_comments     	=  "";
		String board_footer_comments    =  "";
		String board_image_flag = "f";
		String board_file_flag  = "f";
		String board_link_flag  = "f";
		String board_user_flag  = "f";
		String board_security_flag = "f";
		String view_comment		= "f";
		String flag  = "N";
		String board_hidden_flag="N";
		int board_priority		=  0;
		int board_page_line		=  0;
		int board_id		    =  0;
        int board_auth_list     = 0;
        int board_auth_read     = 0;
        int board_auth_write    = 0;
		
		//�Ķ��Ÿ ���� �������� üũ�Ѵ�.
        try{
			if(req.getParameter("board_title") !=null && req.getParameter("board_title").length() > 0) 
				board_title	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_title"));
        }catch(Exception ex){}
		
        try{
        	if(req.getParameter("board_top_comments") !=null && req.getParameter("board_top_comments").length() > 0) 
        		board_top_comments	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_top_comments"));
        }catch(Exception ex){        }
        try{
        	if(req.getParameter("board_footer_comments") !=null && req.getParameter("board_footer_comments").length() > 0) 
			board_footer_comments	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_footer_comments"));
        }catch(Exception ex){        }
        try{
        	if(req.getParameter("board_priority") !=null && req.getParameter("board_priority").length() > 0) 
        		board_priority	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(String.valueOf(req.getParameter("board_priority"))));
        }catch(Exception ex){        }
        try{
	        if(req.getParameter("board_page_line") !=null && req.getParameter("board_page_line").length() > 0) 
				board_page_line	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(String.valueOf(req.getParameter("board_page_line"))));
        }catch(Exception ex){        }
        try{
	        if(req.getParameter("board_id") !=null && req.getParameter("board_id").length() > 0) 
				board_id	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(String.valueOf(req.getParameter("board_id"))));
        }catch(Exception ex){        }
        try{
			if(req.getParameter("board_auth_list") !=null && req.getParameter("board_auth_list").length() > 0)
				board_auth_list	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_auth_list")).trim());
		}catch(Exception ex){	    }
		try{
			if(req.getParameter("board_auth_read") !=null && req.getParameter("board_auth_read").length() > 0)
				board_auth_read	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_auth_read")).trim());
		}catch(Exception ex){	    }
		try{
			if(req.getParameter("board_auth_write") !=null && req.getParameter("board_auth_write").length() > 0)
				board_auth_write	=  Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_auth_write")).trim());
		}catch(Exception ex){	    }
		try{
			if(req.getParameter("flag") !=null && req.getParameter("flag").length() > 0)
				flag	=  com.vodcaster.utils.TextUtil.getValue(req.getParameter("flag")).trim();
		}catch(Exception ex){	    }

		//�������� ó�����¸� üũ�Ѵ�.
		try {
			if(req.getParameter("board_image_flag") != null && String.valueOf(req.getParameter("board_image_flag")).equals("t")) board_image_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_file_flag") != null && String.valueOf(req.getParameter("board_file_flag")).equals("t")) board_file_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_link_flag") != null && String.valueOf(req.getParameter("board_link_flag")).equals("t")) board_link_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_user_flag") != null && String.valueOf(req.getParameter("board_user_flag")).equals("t")) board_user_flag = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_hidden_flag") != null && String.valueOf(req.getParameter("board_hidden_flag")).equals("t")) board_hidden_flag = "t";
		}catch(Exception e){}
		
		try {
			if(req.getParameter("view_comment") != null && String.valueOf(req.getParameter("view_comment")).equals("t")) view_comment = "t";
		}catch(Exception e){}
		try {
			if(req.getParameter("board_security_flag") != null && String.valueOf(req.getParameter("board_security_flag")).equals("t")) board_security_flag = "t";
		}catch(Exception e){}

    	String query ="update board_info set "+
					"board_title 			= '" + board_title + "', "+
					"board_page_line 		=  " + board_page_line + ", "+
					"board_image_flag 		= '" + board_image_flag +"', "+
					"board_file_flag 		= '" + board_file_flag +"', "+
					"board_link_flag 		= '" + board_link_flag +"', "+
					"view_comment 			= '" + view_comment +"', "+
					"board_security_flag 	= '" + board_security_flag +"', "+
					"board_top_comments 	= '" + board_top_comments +"', "+
					"board_footer_comments 	= '" + board_footer_comments +"', "+
					"board_user_flag 		= '" + board_user_flag +"', "+
					"board_priority 		=  " + board_priority + ", " +
                    "board_auth_list        =  " + board_auth_list + ", " +
                    "board_auth_read        =  " + board_auth_read + ", " +
                    "board_hidden_flag        =  '" + board_hidden_flag + "', " +
					"flag 		= '" + flag +"', "+
                    "board_auth_write       =  " + board_auth_write +" where board_id 		=  " + board_id;

//	System.out.println(query);	
		return querymanager.updateEntities(query);
	}


	/************************************************  DELETE  ************************************************/

	/*****************************************************
	Ư�� �Խ����� �����մϴ�.(delete�� ����)<p>
	<b>�ۼ���</b>       : ������<br>
	@return �������� ������ �����̸� row��, ������ ���� -1
	@see QueryManager#updateEntities
	******************************************************/
	public int deleteBoardInfo(int board_id) throws Exception 
	{
 
		if (board_id >= 0) {
			BoardListSQLBean boardList = new BoardListSQLBean();
			try {
					Vector v = querymanager.selectEntities("select list_id from board_list where board_id = "+board_id);
					int list_id = 0;
					int list_delete = 0;
					if(v != null && v.size() > 0){
						for(int i =0; i<v.size(); i++){
							list_id = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(i))).elementAt(0)));
							list_delete = boardList.delete_man(list_id);
						//	printLog(i +" ��° ����� : " + file_delete);
							if(list_delete == -1) break;
						}
					}
					if(list_delete > -1) {
						String query ="update board_info set del_flag='Y' where board_id = " + board_id;
						return querymanager.updateEntities(query);
					}
					return -1;
			}catch (Exception e) {
				System.out.println(e);
				return -1;
			}
		} else {
			return -1;
		}
	}


	 public Vector getBoardInfoList() {
	        String query = " SELECT * FROM board_info where del_flag='N' ORDER BY board_priority, board_title ";
	        return querymanager.selectHashEntities(query);
	    }
	 
	 public Vector getBoardInfoList_flag(String flag) {
 
		if (flag != null && flag.length() > 0) {
			flag = com.vodcaster.utils.TextUtil.getValue(flag);
	        String query = " SELECT * FROM board_info where del_flag='N' ";
	        if (flag != null && flag.length() > 0) {
	        	query = query + " and flag = '"+ flag + "' " ;
	        }
	        query = query +  " ORDER BY board_priority, board_title " ;
	        return querymanager.selectHashEntities(query);
		} else {
			return null;
		}
	}
	 
	 public String getBoardInfo_Memo(int board_id){
	    String strtmp = "";
	   
	    try {
	    	 
	    	String query = "select board_top_comments from board_info where del_flag='N' and board_id='" +board_id+ "'";
			
	    	Vector v = querymanager.selectEntity(query);
            if(v != null && v.size()>0){
            	strtmp = String.valueOf(v.elementAt(0));
            } 

	    }catch(Exception e) {
	    	System.err.println("getCategoryOneName ex : " + e);
	    }
	   return strtmp;
	}


}
