package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

/**
 * User:
 * Date: 2006. 2. 19
 * Time: ¿ÀÈÄ 2:01:47
 */
public class BestTopSubBean extends InfoBeanExt {
    private int bts_id;
    private int bti_id;
    private int bts_order;
    private String bts_title = "";
    private String bts_ocode="";
    private String bts_uip = "";
    private String bts_uid = "";
    private String bts_udate = "";
    private String bts_rdate = "";
    private String bts_type = "";

    public String getBts_type() {
		return bts_type;
	}

	public void setBts_type(String bts_type) {
		this.bts_type = bts_type;
	}

	public BestTopSubBean() {
        super();
    }

    public int getBts_id() {
        return bts_id;
    }

    public void setBts_id(int bts_id) {
        this.bts_id = bts_id;
    }

    public int getBti_id() {
        return bti_id;
    }

    public void setBti_id(int bti_id) {
        this.bti_id = bti_id;
    }

    public int getBts_order() {
        return bts_order;
    }

    public void setBts_order(int bts_order) {
        this.bts_order = bts_order;
    }

    public String getBts_title() {
        return bts_title;
    }

    public void setBts_title(String bts_title) {
        this.bts_title = bts_title;
    }

    public String getBts_ocode() {
        return bts_ocode;
    }

    public void setBts_ocode(String bts_ocode) {
        this.bts_ocode = bts_ocode;
    }

    public String getBts_uip() {
        return bts_uip;
    }

    public void setBts_uip(String bts_uip) {
        this.bts_uip = bts_uip;
    }

    public String getBts_uid() {
        return bts_uid;
    }

    public void setBts_uid(String bts_uid) {
        this.bts_uid = bts_uid;
    }

    public String getBts_udate() {
        return bts_udate;
    }

    public void setBts_udate(String bts_udate) {
        this.bts_udate = bts_udate;
    }

    public String getBts_rdate() {
        return bts_rdate;
    }

    public void setBts_rdate(String bts_rdate) {
        this.bts_rdate = bts_rdate;
    }
}
