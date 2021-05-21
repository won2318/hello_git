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
 * @author Jong-Sung Park
 *
 * ������ ���� ������
 */
public class TimeMediaManager {

	private static TimeMediaManager instance;
	
	private TimeMediaSqlBean sqlbean = null;
    
	private TimeMediaManager() {
        sqlbean = new TimeMediaSqlBean();
    }
    
	public static TimeMediaManager getInstance() {
		if(instance == null) {
			synchronized(TimeMediaManager.class) {
				if(instance == null) {
					instance = new TimeMediaManager();
				}
			}
		}
		return instance;
	}
	
/*********************************************** select *********************************************************/
	
/*****************************************************
	�ð� ���� ��ȯ.<p>
	<b>�ۼ���</b> : ������<br>
	@return ��ȯ�� �ð� ��) 00:03:00<br>
	@param String time, ��ȯ�� �ð� ��) 180(��)
******************************************************/
    public String reformTime(String time) throws Exception{
    	
    	String rhour = StringUtils.leftPad(
                String.valueOf(
                    NumberUtils.toInt(
                        String.valueOf(NumberUtils.toInt(time) / 3600))),2, "0");
		String rmin = StringUtils.leftPad(
	                String.valueOf(
	                    NumberUtils.toInt(
	                        String.valueOf(
                                    (NumberUtils.toInt(time) % 3600) / 60))), 2, "0");
		String rsec = StringUtils.leftPad(
                String.valueOf(NumberUtils.toInt(time) % 60), 2, "0");
		
		time = rhour + ":" + rmin + ":" + rsec;
		
    	return time;
    }
    
    public static int formTime(String time) throws Exception{
    	
    	StringTokenizer tok = new StringTokenizer(time, ":");
    	
    	int return_time = 0;

    	if (tok != null) {
   		
    		String[] result = new String[ tok.countTokens() ];
     
    		for( int i = 0; i < result.length; i++ ){
    	 
    			result[ i ] = tok.nextToken();
    	 
    		}
    		
    		if (result.length == 3) {
    			return_time = (Integer.parseInt(result[0]) * 3600) +(Integer.parseInt(result[1]) * 60) + (Integer.parseInt(result[2]));
    		} else {
    			return_time= 0;
    		}
     	} 
		
    	return return_time;
    }
/*****************************************************
	������ ������ ��������<p>
	<b>�ۼ���</b> : ������<br>
	@return ������ ������ ����<br>
	@param String id, String day
******************************************************/   
    public Vector getSchedule(int id, String day) throws Exception{
    	String query = "select * from time_media where id="+id+" and day='"+day+"'";
    	return sqlbean.selectQuery(query);
    }
    
/*****************************************************
	���۽ð��� ������ ���۽ð����� ���� ����Ʈ ��������<p>
	<b>�ۼ���</b> : ������<br>
	@return ������ ����Ʈ<br>
	@param String day, String time
******************************************************/
    public Vector getScheduleTop(String day, int time, String info) throws Exception{
    	String wherecond = "";
    	if(info != null && !info.equals("")) {
	    	if(info.equals("top") || info.equals("up") ) {
	    		wherecond = " and time < " + time + " ";
	    	}else if (info.equals("middle")) {
	    		wherecond="";
	    	}else {
	    		wherecond = " and time >= " + time + " ";
	    	}
    	}
    	String query = "select * from time_media where day='"+day+"' "+wherecond+" order by CONVERT( time, UNSIGNED) asc";
  	
    	return sqlbean.selectQueries(query);
    }
    
    
/*****************************************************
	������ ��� ��ü<p>
	<b>�ۼ���</b> : ������<br>
	@return ������ ����Ʈ<br>
	@param String day, String time
******************************************************/
    
	public Vector getTime_ListAll(String day) {
	    
	    String query = "";
	    
        query = "select b.*, a.title from time_media b, vod_media a where b.day='"+day+"' and b.ocode=a.ocode  order by CONVERT(b.time, UNSIGNED) asc ";
    
        return sqlbean.selectListAll(query);
	       
	}

}

