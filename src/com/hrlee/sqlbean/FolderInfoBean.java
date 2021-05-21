package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;
/**
 * @author Choi Hee-Sung
 *
 * 동영상내용 업로드폴더관련 클래스
 * Date: 2005. 2. 21.
 * Time: 오후 12:4:5
 */
public class FolderInfoBean extends InfoBeanExt {

    private int fcode       = 0;
    private String folder   = "";
    private int mcode       = 0;
    private int ocode		= 0;


    public int getFcode() {
        return fcode;
    }

    public void setFcode(int fcode) {
        this.fcode = fcode;
    }

    public String getFolder() {
        return folder;
    }

    public void setFolder(String folder) {
        this.folder = folder;
    }

    public int getMcode() {
        return mcode;
    }

    public void setMcode(int mcode) {
        this.mcode = mcode;
    }

	/**
	 * @return Returns the ocode.
	 */
	public int getOcode() {
		return ocode;
	}

	/**
	 * @param ocode The ocode to set.
	 */
	public void setOcode(int ocode) {
		this.ocode = ocode;
	}

}
