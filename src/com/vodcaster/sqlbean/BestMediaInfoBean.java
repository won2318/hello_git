package com.vodcaster.sqlbean;
import com.yundara.beans.InfoBeanExt;
/**
 * @author Choi Hee-Sung
 *
 * 메인페이지에 보여질 베스트컨텐츠 관련 Info 클래스
 * Date: 2005. 1. 26.
 * Time: 오후 2:48:19
 */

public class BestMediaInfoBean extends InfoBeanExt  {
    int uid;
    String isview = "";
    String mtype = "";
    String oflag = "";
    String title1 = "";
    String title2 = "";
    String title3 = "";
    String title4 = "";
    String ocode1 = "";
    String ocode2 = "";
    String ocode3 = "";
    String ocode4 = "";
    int border = 0;
	String v1="";
	String v2="";
	String v3="";
	String p1="";
	String p2="";
	String p3="";
	String img_file;
	String o_date="";
	int o_count = 0;
	String n_date="";
	int n_count = 0;


    public int getBorder() {
        return border;
    }

    public void setBorder(int border) {
        this.border = border;
    }

    public String getIsview() {
        return isview;
    }

    public void setIsview(String isview) {
        this.isview = isview;
    }

    public BestMediaInfoBean() {
        super();
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

    public String getMtype() {
        return mtype;
    }

    public void setMtype(String mtype) {
        this.mtype = mtype;
    }

    public String getTitle1() {
        return title1;
    }

    public void setTitle1(String title1) {
        this.title1 = title1;
    }

    public String getTitle2() {
        return title2;
    }

    public void setTitle2(String title2) {
        this.title2 = title2;
    }

    public String getTitle3() {
        return title3;
    }

    public void setTitle3(String title3) {
        this.title3 = title3;
    }

    public String getTitle4() {
        return title4;
    }

    public void setTitle4(String title4) {
        this.title4 = title4;
    }

    public String getOcode1() {
        return ocode1;
    }

    public void setOcode1(String ocode1) {
        this.ocode1 = ocode1;
    }

    public String getOcode2() {
        return ocode2;
    }

    public void setOcode2(String ocode2) {
        this.ocode2 = ocode2;
    }

    public String getOcode3() {
        return ocode3;
    }

    public void setOcode3(String ocode3) {
        this.ocode3 = ocode3;
    }

    public String getOcode4() {
        return ocode4;
    }

    public void setOcode4(String ocode4) {
        this.ocode4 = ocode4;
    }

	 public String getV1() {
        return v1;
    }
	 public void setV1(String v1) {
        this.v1 = v1;
    }


	public String getV2() {
        return v2;
    }

    public void setV2(String v2) {
        this.v2 = v2;
    }


	public String getV3() {
        return v3;
    }

    public void setV3(String v3) {
        this.v3 = v3;
    }

	public String getP1() {
        return p1;
    }
    public void setP1(String p1) {
        this.p1 = p1;
    }

	public String getP2() {
        return p2;
    }
    public void setP2(String p2) {
        this.p2 = p2;
    }

	public String getP3() {
        return p3;
    }
    public void setP3(String p3) {
        this.p3 = p3;
    }

	public String getO_date() {
        return o_date;
    }
    public void setO_date(String o_date) {
        this.o_date = o_date;
    }
	public int getO_count() {
        return o_count;
    }
    public void setO_count(int o_count) {
        this.o_count = o_count;
    }

	public String getN_date() {
        return n_date;
    }
    public void setN_date(String n_date) {
        this.n_date = n_date;
    }
	public int getN_count() {
        return n_count;
    }
    public void setN_count(int n_count) {
        this.n_count = n_count;
    }


}
