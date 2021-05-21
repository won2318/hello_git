package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;
/**
 * @author Choi Hee-Sung
 * 예약형 미디어관련 정보 클래스
 * Date: 2005. 1. 28.
 * Time: 오전 11:4:52
 */
public class LiveInfoBean extends InfoBeanExt  {

    int rcode           = 0;
    String ocode		= "";
	String rtitle		= "";		
    String rcontents	= "";		
    String openflag		= "";		
	String group_id		= "";	
	String otitle 	= "";

    
	String rbcast_time  = "";
    String ralias       = "";
    String rstart_time  = "";
    String rend_time    = "";
    String rflag        = "";
    String rstatus      = "";
    String rwdate       = "";
    int rhit        = 0;
    int rlevel           = 0;
    String rfilename    = "";
    String rid          = "";
    String rimagefile   = "";
    int property_id		=0;

    String rstime1      = "";
    String rstime2      = "";
    String rstime3      = "";
    String rstime4      = "";
    String rstime5      = "";
    String retime1      = "";
    String retime2      = "";
    String retime3      = "";
    String retime4      = "";
    String retime5      = "";
    String mobile_stream = "";
    String inoutflag 		= "";
    
    String org_rfilename    = "";
    
    String ocode2		= "";
    String ocode3		= "";
    String otitle2 	= "";
    String otitle3 	= "";
   
    
	public String getOtitle2() {
		return otitle2;
	}
	public void setOtitle2(String otitle2) {
		this.otitle2 = otitle2;
	}
	public String getOtitle3() {
		return otitle3;
	}
	public void setOtitle3(String otitle3) {
		this.otitle3 = otitle3;
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
	public String getOrg_rfilename() {
		return org_rfilename;
	}
	public void setOrg_rfilename(String org_rfilename) {
		this.org_rfilename = org_rfilename;
	}
	public String getInoutflag() {
		return inoutflag;
	}
	public void setInoutflag(String inoutflag) {
		this.inoutflag = inoutflag;
	}
	public String getMobile_stream() {
		return mobile_stream;
	}
	public void setMobile_stream(String mobile_stream) {
		this.mobile_stream = mobile_stream;
	}
	/**
	 * @return Returns the group_id.
	 */
	public String getGroup_id() {
		return group_id;
	}
	/**
	 * @param group_id The group_id to set.
	 */
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	/**
	 * @return Returns the openflag.
	 */
	public String getOpenflag() {
		return openflag;
	}
	/**
	 * @param openflag The openflag to set.
	 */
	public void setOpenflag(String openflag) {
		this.openflag = openflag;
	}
	/**
	 * @return Returns the property_id.
	 */
	public int getProperty_id() {
		return property_id;
	}
	/**
	 * @param property_id The property_id to set.
	 */
	public void setProperty_id(int property_id) {
		this.property_id = property_id;
	}
	/**
	 * @return Returns the ralias.
	 */
	public String getRalias() {
		return ralias;
	}
	/**
	 * @param ralias The ralias to set.
	 */
	public void setRalias(String ralias) {
		this.ralias = ralias;
	}
	/**
	 * @return Returns the rbcast_time.
	 */
	public String getRbcast_time() {
		return rbcast_time;
	}
	/**
	 * @param rbcast_time The rbcast_time to set.
	 */
	public void setRbcast_time(String rbcast_time) {
		this.rbcast_time = rbcast_time;
	}
	/**
	 * @return Returns the rcode.
	 */
	public int getRcode() {
		return rcode;
	}
	/**
	 * @param rcode The rcode to set.
	 */
	public void setRcode(int rcode) {
		this.rcode = rcode;
	}
	/**
	 * @return Returns the rcontents.
	 */
	public String getRcontents() {
		return rcontents;
	}
	/**
	 * @param rcontents The rcontents to set.
	 */
	public void setRcontents(String rcontents) {
		this.rcontents = rcontents;
	}
	/**
	 * @return Returns the rend_time.
	 */
	public String getRend_time() {
		return rend_time;
	}
	/**
	 * @param rend_time The rend_time to set.
	 */
	public void setRend_time(String rend_time) {
		this.rend_time = rend_time;
	}
	/**
	 * @return Returns the retime1.
	 */
	public String getRetime1() {
		return retime1;
	}
	/**
	 * @param retime1 The retime1 to set.
	 */
	public void setRetime1(String retime1) {
		this.retime1 = retime1;
	}
	/**
	 * @return Returns the retime2.
	 */
	public String getRetime2() {
		return retime2;
	}
	/**
	 * @param retime2 The retime2 to set.
	 */
	public void setRetime2(String retime2) {
		this.retime2 = retime2;
	}
	/**
	 * @return Returns the retime3.
	 */
	public String getRetime3() {
		return retime3;
	}
	/**
	 * @param retime3 The retime3 to set.
	 */
	public void setRetime3(String retime3) {
		this.retime3 = retime3;
	}
	/**
	 * @return Returns the retime4.
	 */
	public String getRetime4() {
		return retime4;
	}
	/**
	 * @param retime4 The retime4 to set.
	 */
	public void setRetime4(String retime4) {
		this.retime4 = retime4;
	}
	/**
	 * @return Returns the retime5.
	 */
	public String getRetime5() {
		return retime5;
	}
	/**
	 * @param retime5 The retime5 to set.
	 */
	public void setRetime5(String retime5) {
		this.retime5 = retime5;
	}
	/**
	 * @return Returns the rfilename.
	 */
	public String getRfilename() {
		return rfilename;
	}
	/**
	 * @param rfilename The rfilename to set.
	 */
	public void setRfilename(String rfilename) {
		this.rfilename = rfilename;
	}
	/**
	 * @return Returns the rflag.
	 */
	public String getRflag() {
		return rflag;
	}
	/**
	 * @param rflag The rflag to set.
	 */
	public void setRflag(String rflag) {
		this.rflag = rflag;
	}
	/**
	 * @return Returns the rhit.
	 */
	public int getRhit() {
		return rhit;
	}
	/**
	 * @param rhit The rhit to set.
	 */
	public void setRhit(int rhit) {
		this.rhit = rhit;
	}
	/**
	 * @return Returns the rid.
	 */
	public String getRid() {
		return rid;
	}
	/**
	 * @param rid The rid to set.
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}
	/**
	 * @return Returns the rimagefile.
	 */
	public String getRimagefile() {
		return rimagefile;
	}
	/**
	 * @param rimagefile The rimagefile to set.
	 */
	public void setRimagefile(String rimagefile) {
		this.rimagefile = rimagefile;
	}
	/**
	 * @return Returns the rlevel.
	 */
	public int getRlevel() {
		return rlevel;
	}
	/**
	 * @param rlevel The rlevel to set.
	 */
	public void setRlevel(int rlevel) {
		this.rlevel = rlevel;
	}
	/**
	 * @return Returns the rstart_time.
	 */
	public String getRstart_time() {
		return rstart_time;
	}
	/**
	 * @param rstart_time The rstart_time to set.
	 */
	public void setRstart_time(String rstart_time) {
		this.rstart_time = rstart_time;
	}
	/**
	 * @return Returns the rstatus.
	 */
	public String getRstatus() {
		return rstatus;
	}
	/**
	 * @param rstatus The rstatus to set.
	 */
	public void setRstatus(String rstatus) {
		this.rstatus = rstatus;
	}
	/**
	 * @return Returns the rstime1.
	 */
	public String getRstime1() {
		return rstime1;
	}
	/**
	 * @param rstime1 The rstime1 to set.
	 */
	public void setRstime1(String rstime1) {
		this.rstime1 = rstime1;
	}
	/**
	 * @return Returns the rstime2.
	 */
	public String getRstime2() {
		return rstime2;
	}
	/**
	 * @param rstime2 The rstime2 to set.
	 */
	public void setRstime2(String rstime2) {
		this.rstime2 = rstime2;
	}
	/**
	 * @return Returns the rstime3.
	 */
	public String getRstime3() {
		return rstime3;
	}
	/**
	 * @param rstime3 The rstime3 to set.
	 */
	public void setRstime3(String rstime3) {
		this.rstime3 = rstime3;
	}
	/**
	 * @return Returns the rstime4.
	 */
	public String getRstime4() {
		return rstime4;
	}
	/**
	 * @param rstime4 The rstime4 to set.
	 */
	public void setRstime4(String rstime4) {
		this.rstime4 = rstime4;
	}
	/**
	 * @return Returns the rstime5.
	 */
	public String getRstime5() {
		return rstime5;
	}
	/**
	 * @param rstime5 The rstime5 to set.
	 */
	public void setRstime5(String rstime5) {
		this.rstime5 = rstime5;
	}
	/**
	 * @return Returns the rtitle.
	 */
	public String getRtitle() {
		return rtitle;
	}
	/**
	 * @param rtitle The rtitle to set.
	 */
	public void setRtitle(String rtitle) {
		this.rtitle = rtitle;
	}
	/**
	 * @return Returns the rwdate.
	 */
	public String getRwdate() {
		return rwdate;
	}
	/**
	 * @param rwdate The rwdate to set.
	 */
	public void setRwdate(String rwdate) {
		this.rwdate = rwdate;
	}
	public String getOcode() {
		return ocode;
	}
	public void setOcode(String ocode) {
		this.ocode = ocode;
	}
	public String getOtitle() {
		return otitle;
	}
	public void setOtitle(String otitle) {
		this.otitle = otitle;
	}
	
    
}
