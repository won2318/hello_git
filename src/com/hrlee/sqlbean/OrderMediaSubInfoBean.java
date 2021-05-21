/*
 * @(#)OrderMediaSubInfoBean $Date$
 * 
 */
package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class OrderMediaSubInfoBean extends InfoBeanExt {
    private int oms_seq         = 0;
    private int oms_ocode       = 0;
    private int oms_mcode       = 0;
    private String oms_contents = "";
    private String oms_seconds  = "";

    public int getOms_seq() {
        return oms_seq;
    }

    public void setOms_seq(int oms_seq) {
        this.oms_seq = oms_seq;
    }

    public int getOms_ocode() {
        return oms_ocode;
    }

    public void setOms_ocode(int oms_ocode) {
        this.oms_ocode = oms_ocode;
    }

    public int getOms_mcode() {
        return oms_mcode;
    }

    public void setOms_mcode(int oms_mcode) {
        this.oms_mcode = oms_mcode;
    }

    public String getOms_contents() {
        return oms_contents;
    }

    public void setOms_contents(String oms_contents) {
        this.oms_contents = oms_contents;
    }

    public String getOms_seconds() {
        return oms_seconds;
    }

    public void setOms_seconds(String oms_seconds) {
        this.oms_seconds = oms_seconds;
    }
}
