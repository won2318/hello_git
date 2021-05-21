/*
 * ������ : 2004. 12. 28.
 *
 * ����� : 
 */

package com.yundara.util;

import java.util.GregorianCalendar;

/**
 * @author ������
 *
 * TODO Ŭ������ ���� ����
 */
public class TimeTerm extends GregorianCalendar {
	long now_time = 0;
	long etc_time = 0;

	

	public TimeTerm(int year, int month, int date, int hour, int minute, int second)
	{
		//���� ���� �ð�
		//new GregorianCalendar();
		this.now_time = getMTime();

		//Ư�� �ð� ����
		setTime(year, month, date, hour, minute, second);
		this.etc_time = getMTime();
	}


	public TimeTerm(int year, int month, int date, int hour, int minute)
	{
		new TimeTerm(year, month, date, hour, minute, 0);
	}


	/**
		�ð����̸� ���� ���� �ð��� �����մϴ�.

		@param year ��
		@param month ��
		@param date ��
		@param hour ��
		@param minute ��

		@author Kim JongJin
	*/
	public void setTime(int year, int month, int date, int hour, int minute, int second)
	{
		this.set(year, month-1, date, hour, minute, second);
	}



	/**
		������ �ð��� �и�Ÿ�� ����.

		@author Kim JongJin
	*/
	public long getMTime()
	{
		return this.getTimeInMillis();
	}


	/**
		����ð��� ������ �ð��� �ð� ���̸� ���մϴ�.
		@author Kim JongJin
	*/
	public long getTimeTerm()
	{
		//System.out.println("now_time = "+now_time);
		//System.out.println("etc_time = "+etc_time);
		return etc_time - now_time;
	}
	
	/**
		����ð��� ������ �ð��� �ð� ���̸� ���մϴ�.
	*/
	public long getTimeTerm_()
	{
		//System.out.println("now_time = "+now_time);
		//System.out.println("etc_time = "+etc_time);
		return  now_time - etc_time;
	}
}
