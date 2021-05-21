package com.vodcaster.sqlbean;
import com.yundara.beans.InfoBeanExt;
public class MenuAuthInfo extends InfoBeanExt{
	int r_list      = 0;//생방송 
    int r_content   = 0;
    int r_player    = 0;
    int r_write    	= 0;
    int r_del    	= 0;

    int v_list      = 0;
    int v_content   = 0;//VOD
    int v_player    = 0;
    int v_write    	= 0;
    int v_del    	= 0;

    int a_list      = 0;//오디오
    int a_content   = 0;
    int a_player    = 0;

    int c_list      = 0;//강좌
    int c_content   = 0;
    int c_player    = 0;

    int b_list      = 0;//게시판
    int b_content   = 0;
    int b_write     = 0;
    int b_del       = 0;    

    int m_write		= 0;//회원 
    int m_del		= 0;
    int m_list		= 0;
    
    int cate_write		= 0;//카테고리 
    int cate_del		= 0;
    int cate_list		= 0;

	int be_list		= 0; // 메인화면
	int be_write	= 0;
	int be_player	= 0;

	int p_list		= 0; // 포토
	int p_write		= 0;
	int p_del		= 0;
	int p_content	= 0;

	int s_list		= 0; //사이트
	int s_write		= 0;
	int s_del		= 0;
	int s_content	= 0;
	
	int menu_list = 0;	//메뉴 관리
	public int getMenu_list() {
		return menu_list;
	}
	public void setMenu_list(int menu_list) {
		this.menu_list = menu_list;
	}
	public int getMenu_write() {
		return menu_write;
	}
	public void setMenu_write(int menu_write) {
		this.menu_write = menu_write;
	}
	public int getMenu_del() {
		return menu_del;
	}
	public void setMenu_del(int menu_del) {
		this.menu_del = menu_del;
	}

	int menu_write = 0;
	int menu_del = 0;
	
	public int getBe_list() {
		return be_list;
	}
	public void setBe_list(int be_list) {
		this.be_list = be_list;
	}
	public int getBe_write() {
		return be_write;
	}
	public void setBe_write(int be_write) {
		this.be_write = be_write;
	}
	public int getBe_player() {
		return be_player;
	}
	public void setBe_player(int be_player) {
		this.be_player = be_player;
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

	// site
	public int getS_list() {
        return s_list;
    }

    public void setS_list(int s_list) {
        this.s_list = s_list;
    }

    public int getS_content() {
        return s_content;
    }

    public void setS_content(int s_content) {
        this.s_content = s_content;
    }

    public int getS_write() {
        return s_write;
    }

    public void setS_write(int s_write) {
        this.s_write = s_write;
    }

    public int getS_del() {
        return s_del;
    }

    public void setS_del(int s_del) {
        this.s_del = s_del;
    }

    /**
	 * @return Returns the m_del.
	 */
	public int getM_del() {
		return m_del;
	}

	/**
	 * @param m_del The m_del to set.
	 */
	public void setM_del(int m_del) {
		this.m_del = m_del;
	}

	/**
	 * @return Returns the m_list.
	 */
	public int getM_list() {
		return m_list;
	}

	/**
	 * @param m_list The m_list to set.
	 */
	public void setM_list(int m_list) {
		this.m_list = m_list;
	}

	/**
	 * @return Returns the m_write.
	 */
	public int getM_write() {
		return m_write;
	}

	/**
	 * @param m_write The m_write to set.
	 */
	public void setM_write(int m_write) {
		this.m_write = m_write;
	}
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

	/**
	 * @return Returns the cate_del.
	 */
	public int getCate_del() {
		return cate_del;
	}

	/**
	 * @param cate_del The cate_del to set.
	 */
	public void setCate_del(int cate_del) {
		this.cate_del = cate_del;
	}

	/**
	 * @return Returns the cate_list.
	 */
	public int getCate_list() {
		return cate_list;
	}

	/**
	 * @param cate_list The cate_list to set.
	 */
	public void setCate_list(int cate_list) {
		this.cate_list = cate_list;
	}

	/**
	 * @return Returns the cate_write.
	 */
	public int getCate_write() {
		return cate_write;
	}

	/**
	 * @param cate_write The cate_write to set.
	 */
	public void setCate_write(int cate_write) {
		this.cate_write = cate_write;
	}

	/**
	 * @return Returns the r_del.
	 */
	public int getR_del() {
		return r_del;
	}

	/**
	 * @param r_del The r_del to set.
	 */
	public void setR_del(int r_del) {
		this.r_del = r_del;
	}

	/**
	 * @return Returns the r_write.
	 */
	public int getR_write() {
		return r_write;
	}

	/**
	 * @param r_write The r_write to set.
	 */
	public void setR_write(int r_write) {
		this.r_write = r_write;
	}
}
