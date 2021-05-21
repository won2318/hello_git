package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

/**
 * Date: 2006. 2. 19
 * Time: ¿ÀÈÄ 12:39:34
 */
public class BestTopInfoBean extends InfoBeanExt {
    int bti_id;
    String bti_isview = "N";
    int bti_hit_num = 10;
    int bti_mng_num = 10;
    String bti_uip = "";
    String bti_uid = "";
    String bti_udate = "";
    String bti_rdate = "";
    
    String day = "";
    String muid = "";
    String mtitle = "";
    String sum_hit = "";
    
    
    
    public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getMuid() {
		return muid;
	}

	public void setMuid(String muid) {
		this.muid = muid;
	}

	public String getMtitle() {
		return mtitle;
	}

	public void setMtitle(String mtitle) {
		this.mtitle = mtitle;
	}

	public String getSum_hit() {
		return sum_hit;
	}

	public void setSum_hit(String sum_hit) {
		this.sum_hit = sum_hit;
	}

	public BestTopInfoBean() {
        super();
    }

    public int getBti_id() {
        return bti_id;
    }

    public void setBti_id(int bti_id) {
        this.bti_id = bti_id;
    }

    public String getBti_isview() {
        return bti_isview;
    }

    public void setBti_isview(String bti_isview) {
        this.bti_isview = bti_isview;
    }

    public int getBti_hit_num() {
        return bti_hit_num;
    }

    public void setBti_hit_num(int bti_hit_num) {
        this.bti_hit_num = bti_hit_num;
    }

    public int getBti_mng_num() {
        return bti_mng_num;
    }

    public void setBti_mng_num(int bti_mng_num) {
        this.bti_mng_num = bti_mng_num;
    }

    public String getBti_uip() {
        return bti_uip;
    }

    public void setBti_uip(String bti_uip) {
        this.bti_uip = bti_uip;
    }

    public String getBti_uid() {
        return bti_uid;
    }

    public void setBti_uid(String bti_uid) {
        this.bti_uid = bti_uid;
    }

    public String getBti_udate() {
        return bti_udate;
    }

    public void setBti_udate(String bti_udate) {
        this.bti_udate = bti_udate;
    }

    public String getBti_rdate() {
        return bti_rdate;
    }

    public void setBti_rdate(String bti_rdate) {
        this.bti_rdate = bti_rdate;
    }
}
