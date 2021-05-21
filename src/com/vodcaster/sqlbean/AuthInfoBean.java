package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

/**
 * @author Choi Hee-Sung
 *
 * 특정 컨텐츠에 대한 회원레벨볼 접근제한 설정.
*/

public class AuthInfoBean extends InfoBeanExt {
    int r_list      = 0;//생방송 
    int r_content   = 0;
    int r_player    = 0;

    int v_list      = 0;//VOD
    int v_content   = 0;
    int v_player    = 0;
    int v_write    	= 0;
    int v_del    	= 0;

    int a_list      = 0;//AUDIO
    int a_content   = 0;
    int a_player    = 0;

    int c_list      = 0;//강좌 
    int c_content   = 0;
    int c_player    = 0;

    int b_list      = 0;//게시판 
    int b_content   = 0;
    int b_write     = 0;
    int b_del       = 0;   

	int p_list		= 0; // 포토
	int p_write		= 0;
	int p_del		= 0;
	int p_content	= 0;
    
   

	public int getR_list() {
        return r_list;
    }

    public void setR_list(int r_list) {
        this.r_list = r_list;
    }

    public int getR_content() {
        return r_content;
    }

    public void setR_content(int r_content) {
        this.r_content = r_content;
    }

    public int getR_player() {
        return r_player;
    }

    public void setR_player(int r_player) {
        this.r_player = r_player;
    }

    public int getV_list() {
        return v_list;
    }

    public void setV_list(int v_list) {
        this.v_list = v_list;
    }

    public int getV_content() {
        return v_content;
    }

    public void setV_content(int v_content) {
        this.v_content = v_content;
    }

    public int getV_player() {
        return v_player;
    }

    public void setV_player(int v_player) {
        this.v_player = v_player;
    }

    public int getA_list() {
        return a_list;
    }

    public void setA_list(int a_list) {
        this.a_list = a_list;
    }

    public int getA_content() {
        return a_content;
    }

    public void setA_content(int a_content) {
        this.a_content = a_content;
    }

    public int getA_player() {
        return a_player;
    }

    public void setA_player(int a_player) {
        this.a_player = a_player;
    }

    public int getC_list() {
        return c_list;
    }

    public void setC_list(int c_list) {
        this.c_list = c_list;
    }

    public int getC_content() {
        return c_content;
    }

    public void setC_content(int c_content) {
        this.c_content = c_content;
    }

    public int getC_player() {
        return c_player;
    }

    public void setC_player(int c_player) {
        this.c_player = c_player;
    }

    public int getB_list() {
        return b_list;
    }

    public void setB_list(int b_list) {
        this.b_list = b_list;
    }

    public int getB_content() {
        return b_content;
    }

    public void setB_content(int b_content) {
        this.b_content = b_content;
    }

    public int getB_write() {
        return b_write;
    }

    public void setB_write(int b_write) {
        this.b_write = b_write;
    }

    public int getB_del() {
        return b_del;
    }

    public void setB_del(int b_del) {
        this.b_del = b_del;
    }

	/**
	 * @return Returns the v_del.
	 */
	public int getV_del() {
		return v_del;
	}

	/**
	 * @param v_del The v_del to set.
	 */
	public void setV_del(int v_del) {
		this.v_del = v_del;
	}

	/**
	 * @return Returns the v_write.
	 */
	public int getV_write() {
		return v_write;
	}

	/**
	 * @param v_write The v_write to set.
	 */
	public void setV_write(int v_write) {
		this.v_write = v_write;
	}
	
	// photo
	public int getP_list() {
        return p_list;
    }

    public void setP_list(int p_list) {
        this.p_list = p_list;
    }

    public int getP_content() {
        return p_content;
    }

    public void setP_content(int p_content) {
        this.p_content = p_content;
    }

    public int getP_write() {
        return p_write;
    }

    public void setP_write(int p_write) {
        this.p_write = p_write;
    }

    public int getP_del() {
        return p_del;
    }

    public void setP_del(int p_del) {
        this.p_del = p_del;
    }
}
