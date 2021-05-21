/*
 * 생성일 : 2004. 12. 28.
 *
 * 사용방법 : 
 */

package com.yundara.util;

import java.util.GregorianCalendar;

/**
 * @author 오영석
 *
 * TODO 클래스에 대한 설명
 */
public class TimeTerm extends GregorianCalendar {
	long now_time = 0;
	long etc_time = 0;

	

	public TimeTerm(int year, int month, int date, int hour, int minute, int second)
	{
		//현재 세팅 시간
		//new GregorianCalendar();
		this.now_time = getMTime();

		//특정 시간 세팅
		setTime(year, month, date, hour, minute, second);
		this.etc_time = getMTime();
	}


	public TimeTerm(int year, int month, int date, int hour, int minute)
	{
		new TimeTerm(year, month, date, hour, minute, 0);
	}


	/**
		시간차이를 구할 이전 시간을 세팅합니다.

		@param year 년
		@param month 월
		@param date 일
		@param hour 시
		@param minute 분

		@author Kim JongJin
	*/
	public void setTime(int year, int month, int date, int hour, int minute, int second)
	{
		this.set(year, month-1, date, hour, minute, second);
	}



	/**
		세팅한 시간의 밀리타임 리턴.

		@author Kim JongJin
	*/
	public long getMTime()
	{
		return this.getTimeInMillis();
	}


	/**
		현재시간과 세팅한 시간의 시간 차이를 구합니다.
		@author Kim JongJin
	*/
	public long getTimeTerm()
	{
		//System.out.println("now_time = "+now_time);
		//System.out.println("etc_time = "+etc_time);
		return etc_time - now_time;
	}
	
	/**
		현재시간과 세팅한 시간의 시간 차이를 구합니다.
	*/
	public long getTimeTerm_()
	{
		//System.out.println("now_time = "+now_time);
		//System.out.println("etc_time = "+etc_time);
		return  now_time - etc_time;
	}
}
