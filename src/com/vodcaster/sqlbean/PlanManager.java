package com.vodcaster.sqlbean;

import java.util.Calendar;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * @author Choi Hee-Sung
 * ����� �޷°��� Ŭ����
 * Date: 2005. 1. 27.
 * Time: ���� 8:25:2
 */
public class PlanManager {
	private static PlanManager instance;

	private PlanSqlBean sqlbean = null;

	private PlanManager() {
        sqlbean = new PlanSqlBean();
        //System.err.println("PlanManager �ν��Ͻ� ����");
    }

	public static PlanManager getInstance() {
		if(instance == null) {
			synchronized(PlanManager.class) {
				if(instance == null) {
					instance = new PlanManager();
				}
			}
		}
		return instance;
	}



/*****************************************************
	�Է¹��� ��¥�� �������� ��¥���� Ȯ��.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:true  ����:false <br>
	@param ��, ��, ��
******************************************************/
    public boolean validDate(String year, String month, String date) {
    	year = com.vodcaster.utils.TextUtil.getValue(year);
    	month = com.vodcaster.utils.TextUtil.getValue(month);
    	date = com.vodcaster.utils.TextUtil.getValue(date);
    	
        int yearInt = Integer.parseInt(year);
        int monthInt = Integer.parseInt(month);
        int dateInt = Integer.parseInt(date);

        if(yearInt < 100)
            yearInt += 2000;

        monthInt--;

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, yearInt);
        cal.set(Calendar.MONTH, monthInt);
        cal.set(Calendar.DATE, dateInt);

        int fYear = cal.get(Calendar.YEAR);
        int fMonth = cal.get(Calendar.MONTH);
        int fDate = cal.get(Calendar.DATE);

        if((fYear != yearInt) || (fMonth != monthInt) || (fDate != dateInt))
            return false;

        return true;
    }



/*****************************************************
	���ڿ��� ���� ������ ���� ������ ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ���� ����<br>
	@param ��¥
******************************************************/
    public String getWeekDay(String instr) {
    	instr = com.vodcaster.utils.TextUtil.getValue(instr);
    	if (instr != null && instr.length() > 0) {
	        try {
	            DateFormat df = new SimpleDateFormat("yyyyMMdd");
	            DateFormat ddf = new SimpleDateFormat("EEE");
	            return String.valueOf(ddf.format(df.parse(instr)));
	        }catch(Exception e) {
	        	System.out.println(e);
	        	return "";
	        }
    	} else {
    		return "";	
    	}
 
    }



}
