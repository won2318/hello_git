package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

/**
 * @author Choi Hee-Sung
 * 홈페이지 스킨정보 클래스
 * Date: 2005. 2. 21.
 * Time: 오후 4:31:9
 */
public class SkinInfoBean extends InfoBeanExt {
    private String skin_name    = "";
    private String servername   = "";
    private String posa         = "";
    private String posb         = "";
    private String posc         = "";
    private String posd         = "";
    private String pose         = "";
    private String posf         = "";
    private String posg         = "";

    public String getSkin_name() {
        return skin_name;
    }

    public void setSkin_name(String skin_name) {
        this.skin_name = skin_name;
    }

    public String getServername() {
        return servername;
    }

    public void setServername(String servername) {
        this.servername = servername;
    }

    public String getPosa() {
        return posa;
    }

    public void setPosa(String posa) {
        this.posa = posa;
    }

    public String getPosb() {
        return posb;
    }

    public void setPosb(String posb) {
        this.posb = posb;
    }

    public String getPosc() {
        return posc;
    }

    public void setPosc(String posc) {
        this.posc = posc;
    }

    public String getPosd() {
        return posd;
    }

    public void setPosd(String posd) {
        this.posd = posd;
    }

    public String getPose() {
        return pose;
    }

    public void setPose(String pose) {
        this.pose = pose;
    }

    public String getPosf() {
        return posf;
    }

    public void setPosf(String posf) {
        this.posf = posf;
    }

    public String getPosg() {
        return posg;
    }

    public void setPosg(String posg) {
        this.posg = posg;
    }


}
