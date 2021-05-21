/*
 * ������ : 2004. 12. 28.
 *
 * ����� : 
 */

package com.yundara.util;

/**
 * @author ������
 *
 * TODO Ŭ������ ���� ����
 */

public class TimeUtil {
	/** ���� ��¥�� yyyyMMdd���·� ���� */
	public static String getCurDate()
	{
		java.text.SimpleDateFormat dfDate = new java.text.SimpleDateFormat( "yyyyMMdd" );
		java.util.Date currTime = new java.util.Date( System.currentTimeMillis() );
		return dfDate.format(currTime);
	}


	/** ���� ��¥�� ���ϴ� �������·� ���� */
	public static String getCurDate( String format )
	{
		java.text.SimpleDateFormat dfDate = new java.text.SimpleDateFormat( format );
		java.util.Date currTime = new java.util.Date( System.currentTimeMillis() );
		return dfDate.format(currTime);
	}

	public static String getTimeFormat(long time, String fmt) {
		java.text.SimpleDateFormat dfDate = new java.text.SimpleDateFormat( fmt );
		java.util.Date currTime = new java.util.Date( time );
		return dfDate.format(currTime);
	}

	// ���� �ð��� HHmmss���·� ����
	public static String getCurTime()
	{
	    java.text.SimpleDateFormat dfTime = new java.text.SimpleDateFormat( "HHmmss" );
	    java.util.Date currTime = new java.util.Date( System.currentTimeMillis() );
		return dfTime.format(currTime);
	}
	
	// ���� �ð��� 2002-11-01 15:37:12.891 ���·� ����
	public static String getTimestamp()
	{
		java.sql.Timestamp s=new java.sql.Timestamp(System.currentTimeMillis());
		return s.toString();
	}

	/**
	 *	'yyyy-MM-dd HH:mm:ss.SSS' �������� ���� �ð��� ����.
	 *  <br><font size=2>2003/08/11. Kim JongJin</font>
	 *  <p>
     *
	 *	@return yyyy-MM-dd HH:mm:ss.SSS
	 */
	public static String getDetailTime(){
		java.text.SimpleDateFormat dfDate = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss.SSS" );
		java.util.Date currTime = new java.util.Date( System.currentTimeMillis() );
		return dfDate.format(currTime);
	}	
}
