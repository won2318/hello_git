package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;
/**
 * @author Choi Hee-Sung
 * MyList���� ���� Ŭ����
 * Date: 2005. 1. 24.
 * Time: ���� 10:43:58
 */

public class MyListInfoBean extends InfoBeanExt {

    private int uid             = 0;
    private String mid          = "";
    private String mtype        = "";       //1:�ֹ���   2:������
    private String ocode        = "";
    private String oflag        = "";       // V:����  A:�����  C:������



    public MyListInfoBean() {
        super();
    }


    public String getOcode() {
        return ocode;
    }

    public void setOcode(String ocode) {
        this.ocode = ocode;
    }

    public String getMtype() {
        return mtype;
    }

    public void setMtype(String mtype) {
        this.mtype = mtype;
    }

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getOflag() {
        return oflag;
    }

    public void setOflag(String oflag) {
        this.oflag = oflag;
    }
}
