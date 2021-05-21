package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

/**
 * @author Choi Hee-Sung
 *
 * 금주의 영상 정보 클래스
 * Date: 2005. 1. 31.
 * Time: 오후 9:27:15
 */
public class BestWeekInfoBean  extends InfoBeanExt {
    String title = "";
    String ocode = "";
    String isview = "";
    String auto = "Y";
    String flag = "";
    public String getAuto() {
		return auto;
	}

	public void setAuto(String auto) {
		this.auto = auto;
	}

	public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOcode() {
        return ocode;
    }

    public void setOcode(String ocode) {
        this.ocode = ocode;
    }

    public String getIsview() {
        return isview;
    }

    public void setIsview(String isview) {
        this.isview = isview;
    }
    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

}
