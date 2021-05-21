package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;
 
/**
 * @author Choi Hee-Sung
 * 예약형 미디어의 메모기능 관련 정보 클래스
 */
public class MemoInfoBean extends InfoBeanExt {

    private int muid        = 0;
    private String ocode    = "";
    private String id       = "";
    private String pwd      = "";
    private String wdate    = "";
    private String comment  = "";
    private String wname    = "";
    private String wnick_name = "";
    private String ip = "";
	private String flag = "";
	private String list_title = "";
	private String list_date = "";
	private int board_id = 0;
	private String list_name = "";
	private String ccode = "";


    public String getCcode() {
		return ccode;
	}

	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	public String getList_name() {
		return list_name;
	}

	public void setList_name(String list_name) {
		this.list_name = list_name;
	}

	public String getList_title() {
		return list_title;
	}

	public void setList_title(String list_title) {
		this.list_title = list_title;
	}

	public String getList_date() {
		return list_date;
	}

	public void setList_date(String list_date) {
		this.list_date = list_date;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public int getMuid() {
        return muid;
    }

    public void setMuid(int muid) {
        this.muid = muid;
    }

    public String getOcode() {
        return ocode;
    }

    public void setOcode(String ocode) {
        this.ocode = ocode;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getWdate() {
        return wdate;
    }

    public void setWdate(String wdate) {
        this.wdate = wdate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public String getWname() {
        return wname;
      }
    
    public void setWname(String wname) {
        this.wname = wname;
    }
    
    public String getWnick_name() {
        return wnick_name;
    }
    
    public void setWnick_name(String wnick_name) {
        this.wnick_name = wnick_name;
    }
    
    public String getIp() {
        return ip;
    }
    
    public void setIp(String ip) {
        this.ip = ip;
    }

	 public String getFlag() {
        return flag;
    }
	 public void setFlag(String flag) {
        this.flag = flag;
    }
}
