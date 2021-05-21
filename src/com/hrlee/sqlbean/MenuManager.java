/*
 * Created on 2005. 1. 10
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
/**
 * @author Choi Hee-Sung
 *
 * VOD카테고리 관리 클래스
 */
public class MenuManager {
	private static MenuManager instance;
	
	private MenuSqlBean sqlbean = null;
    
	private MenuManager() {
        sqlbean = new MenuSqlBean();
        //System.err.println("MenuManager 인스턴스 생성");
    }
    
	public static MenuManager getInstance() {
		if(instance == null) {
			synchronized(MenuManager.class) {
				if(instance == null) {
					instance = new MenuManager();
				}
			}
		}
		return instance;
	}


/*****************************************************
	메뉴코드(mtype)로 검색된 메뉴 전체리스트 리턴.<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 메뉴 리스트(order by mcode,minfo,mlevel,mtitle)<br>
	@param 
******************************************************/
	public Vector getMenuListALL() {
	    
	    String query = "";
	    query = "select * from menu where  order by morder,mcode,minfo,mlevel,mtitle";
	    return sqlbean.selectMenuListAll(query);
	    	  
	}



/*****************************************************
	검색된 메뉴 전체 리스트 출력<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 메뉴 리스트(order by mcode,minfo,mlevel,mtitle)<br>
	@param mtype(분류), minfo(레벨)
	@see /admin/menu/frm_menuUpdate.jsp
******************************************************/
	public Vector getMenuListALL( String info) {
	    
	    String query = "";
	    info = com.vodcaster.utils.TextUtil.getValue(info);
	    if (info != null && info.length() >0) {
	    
	        query = "select * from menu where minfo='" +info+ "' order by morder,mcode, minfo,mlevel,mtitle";
	    
	        return sqlbean.selectMenuListAll(query);
	    } else {
	    	return null;
	    }
	       
	    
	}	
	
	
	public Vector getMenuListALL2( String info) {
	    
	    String query = "";
	    info = com.vodcaster.utils.TextUtil.getValue(info);
	    if (info != null && info.length() >0) {
	        query = "select * from menu where  minfo='" +info+ "' order by morder,mlevel,mtitle,mcode";
	    
	        return sqlbean.selectMenuListAll(query);
	       
	    } else
	        return null;
	}	
	
	
	
	public Vector getMenuListALL2( String day, String info, String mu) {
	    String query = "";
	    //System.out.println("jjjjjjjjjjjjj11111===================================="+info);
	    info = com.vodcaster.utils.TextUtil.getValue(info);
	    day = com.vodcaster.utils.TextUtil.getValue(day);
	    
	    if( !info.equals("")) {
	        query = "select "+
					" coalesce(aa.sum_hit,0)as sum_hit2, "+
		        	" coalesce(bb.sum_hit,0)as sum_hit1, "+
		        	" coalesce(cc.sum_hit,0)as sum_hit3, cc.mtitle "+
		        	" from "+
		        	" (select substr(a.day,1,6), a.muid, b.mtitle , sum(coalesce(a.cnt,0))as sum_hit from menu b left outer join contact_stat_menu a on  b.muid = a.muid "+
		        	" where   substr(day,1,6) = substr("+day+",1,6) and a.flag='"+info+"' "+
		        	" group by a.muid, substr(a.day,1,6))aa  "+
		        	" left OUTER JOIN   "+
		        	" (select a.day, a.muid, b.mtitle , sum(coalesce(a.cnt,0))as sum_hit from menu b left outer join contact_stat_menu a on  b.muid = a.muid "+
		        	" where   day = "+day+" and a.flag='"+info+"' "+
		        	" group by a.muid, a.day)bb on bb.muid = aa.muid "+
		        	" right OUTER JOIN   "+
		        	" (select substr(a.day,1,4), a.muid, b.mtitle , sum(coalesce(a.cnt,0))as sum_hit from menu b left outer join contact_stat_menu a on  b.muid = a.muid "+
		        	" where   substr(day,1,4) = substr("+day+",1,4) and a.flag='"+info+"' "+
		        	" group by a.muid, substr(a.day,1,4))cc on cc.muid = aa.muid ";
	       // System.out.println(query);
	        return sqlbean.selectMenuListAll(query);
	    } 
	    
	    return null;
	}	
	
	
	
	public Vector getMenuListALL3(String month, String flag) {
	    String query = "";
	    month = com.vodcaster.utils.TextUtil.getValue(month);
	    flag = com.vodcaster.utils.TextUtil.getValue(flag);
	    if( month != null && month.length() > 0 && flag != null && flag.length() > 0) {
	        query = "select b.mtitle, a.muid from contact_stat_menu a, menu b where substring(a.day,1,6) = '"+month+"' and a.muid = b.muid and a.flag = '"+flag+"' group by muid order by a.muid, a.day";		        	
	        return sqlbean.selectMenuListAll(query);
	    } 
	    return null;
	}
	
	public Vector getMenuListALL3_0(String month, String flag) {
	    String query = "";
	    if( month != null && month.length() > 0 && flag != null && flag.length() > 0) {
	        query = "select b.mtitle, a.muid from contact_stat_menu a, menu b where substring(a.day,1,4) = '"+month+"' and a.muid = b.muid and a.flag = '"+flag+"' group by muid order by a.muid, a.day";		        	
	        return sqlbean.selectMenuListAll(query);
	    } 
	    return null;
	}
	
	
	public Vector getMenuListALL3_1(String month, String flag) {
	    String query = "";
	    month = com.vodcaster.utils.TextUtil.getValue(month);
	    flag = com.vodcaster.utils.TextUtil.getValue(flag);
	    if(  month != null && month.length() > 0 && flag != null && flag.length() > 0) {
	        query = "select a.muid, substring(a.day,7,2)day, a.cnt from contact_stat_menu a, menu b where substring(a.day,1,6) = '"+month+"' and a.muid = b.muid and a.flag= '"+flag+"' order by a.muid, a.day";		        	
	        System.out.println(query);
	        return sqlbean.selectMenuListAll(query);
	    } 
	    return null;
	}
	
	public Vector getMenuListALL3_2(String month, String flag) {
	    String query = "";
	    month = com.vodcaster.utils.TextUtil.getValue(month);
	    flag = com.vodcaster.utils.TextUtil.getValue(flag);
	    if(  month != null && month.length() > 0 && flag != null && flag.length() > 0) {
	        query = "select a.muid, substring(a.day,5,2)day, sum(a.cnt)cnt from contact_stat_menu a, menu b where substring(a.day,1,4) = '"+month+"' and a.muid = b.muid and a.flag= '"+flag+"' group by a.muid, substring(a.day,1,6) order by a.muid, a.day";		        	
	        System.out.println(query);
	        return sqlbean.selectMenuListAll(query);
	    } 
	    return null;
	}
	
	
	
	public Vector getMenuLevel_12( ) {
	    
	    String query = "";
	    
	    query = "select * from menu where  minfo='A' or minfo='B' order by mcode,morder,mlevel,mtitle";
	    return sqlbean.selectMenuListAll(query);
	    
	}
		

/*****************************************************
	검색된 메뉴 전체 리스트 출력<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 메뉴 리스트(order by mcode,minfo,mlevel,mtitle)<br>
	@param  info(레벨), menu(메뉴코드)
******************************************************/
	public Vector getMenuListALL( String info, String menu) {
	    
	    String query = "";
	    info = com.vodcaster.utils.TextUtil.getValue(info);
	    menu = com.vodcaster.utils.TextUtil.getValue(menu);
	    if (menu != null && menu.length()>= 9) {
	    if(info.equals("B"))
	        menu = menu.substring(0,3);
	    else if(info.equals("C"))
	        menu = menu.substring(0,6);
	    else if(info.equals("D"))
	    	menu = menu.substring(0,9);
	    if(  info != null && info.length() > 0 && menu != null && menu.length() > 0 ) {
	        query = "select * from menu where  minfo='" +info+ "' and mcode like '" +
	        		menu + "%' order by morder,mcode,minfo,mlevel,mtitle";
	        
	        return sqlbean.selectMenuListAll(query);
	    } else
	        return null;
	    } else {
	    	return null;
	    }
	}

	public Vector getMenuListALL2(String info, String menu) {
	    
	    String query = "";
	    info = com.vodcaster.utils.TextUtil.getValue(info);
	    menu = com.vodcaster.utils.TextUtil.getValue(menu);
	    if (menu != null && menu.length()> 0) {
	    if(info != null && info.length() > 0 && info.equals("B") && menu != null && menu.length() >= 3)
	        menu = menu.substring(0,3);
	    else if(info != null && info.length() > 0 && info.equals("C") && menu != null && menu.length() >= 6)
	        menu = menu.substring(0,6);
	    else if(info != null && info.length() > 0 && info.equals("D") && menu != null && menu.length() >= 9)
	        menu = menu.substring(0,9);
	    
	    if( info != null && info.length() > 0 && menu != null && menu.length() > 0) {
	        query = "select * from menu where  minfo='" +info+ "' and mcode like '" +
	        		menu + "%' order by morder,mcode,minfo,mlevel,mtitle";
	        
	        return sqlbean.selectMenuListAll(query);
	    } else
	        return null;
	    } else {
	    	return null;
	    }
	}
	
	public Vector getMenuList_sub(String info, String menu) {
	    
	    String query = "";
	    String infoQuery = "";
	    info = com.vodcaster.utils.TextUtil.getValue(info);
	    menu = com.vodcaster.utils.TextUtil.getValue(menu);
	    if (menu != null && menu.length()> 0) {
		    if(info != null && info.length() > 0 && info.equals("B") && menu != null && menu.length() >= 3){
		        menu = menu.substring(0,3);
		    	infoQuery = "( a.minfo='B' or a.minfo='C' or a.minfo='D' ) and ";
		    }
		    else if(info != null && info.length() > 0 && info.equals("C") && menu != null && menu.length() >= 6){
		        menu = menu.substring(0,6);
		        infoQuery = "  ( a.minfo='C' or a.minfo='D' ) and ";
		    }
		    else if(info != null && info.length() > 0 && info.equals("D") && menu != null && menu.length() >= 9){
		        menu = menu.substring(0,9);
		        infoQuery = " ( a.minfo='D' ) and ";
		    }
		    
		    if( info != null && info.length() > 0 && menu != null && menu.length() > 0 ) {
		    	query = "select a.*,(select count(*) from menu where a.mcode= mparent_code) as sub_count from menu a "+ 
	    		" where "+infoQuery+"  a.mcode like '"+menu+"%'" +
	    		" order by a.minfo,a.morder,a.mtitle,a.mcode,a.mlevel";
		        return sqlbean.selectMenuListAll(query);
		    } else
		        return null;
	    } else {
	    	return null;
	    }
	}
	
	public Vector getSitemapMenuList( String info, String mparent_code) {
		info = com.vodcaster.utils.TextUtil.getValue(info);
		mparent_code = com.vodcaster.utils.TextUtil.getValue(mparent_code);
	    
		 if( info != null && info.length() > 0 && mparent_code != null && mparent_code.length() > 0 ) {
	    String query = "";
		    query = "select * from menu where minfo='"+info+"' and mparent_code='"+mparent_code+"'";
	        return sqlbean.selectMenuListAll(query);
		 } else {
			 return null;
		 }

	}

	
/*****************************************************
	메뉴 생성<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param HttpServletRequest
	@see /admin/menu/proc_menuAdd.jsp
******************************************************/
	public int createMenu(HttpServletRequest req) throws Exception {
	    
	    MenuInfoBean bean = new MenuInfoBean();
	    com.yundara.util.WebUtils.fill(bean, req);
	    
	    if(bean.getMmenu1() != null && bean.getMmenu1().equals("")) {
	        bean.setMinfo("A");
	    }else if(bean.getMmenu1() != null && bean.getMmenu2() != null 
	    		&& !bean.getMmenu1().equals("") && bean.getMmenu2().equals("")){
	        bean.setMinfo("B");
	    }else if(bean.getMmenu1() != null && bean.getMmenu2() != null && bean.getMmenu3() != null
	    		&& !bean.getMmenu1().equals("") && !bean.getMmenu2().equals("") && bean.getMmenu3().equals("")){
	        bean.setMinfo("C");
	    }else if(bean.getMmenu1() != null && bean.getMmenu2() != null && bean.getMmenu3() != null  && bean.getMmenu4() != null
	    		&& !bean.getMmenu1().equals("") && !bean.getMmenu2().equals("") && !bean.getMmenu3().equals("") && bean.getMmenu4().equals("")){
	        bean.setMinfo("D");
	    }
	    //System.out.println(bean.getMinfo());
	    //System.out.println(bean.getMmenu1());
	    //System.out.println(bean.getMmenu2());
	    //System.out.println(bean.getMmenu3());
	    //System.out.println(bean.getMtitle());
	    bean.setMtitle(bean.getMtitle());
	    
	    //parent_code 추출
	    // mcode값 추출 
	    
	    String strtmp = "";	    
	    if(bean.getMinfo() != null && bean.getMinfo().equals("D")){
	        bean.setMparent_code(bean.getMmenu3());
	        strtmp = String.valueOf(bean.getMmenu3());
	        
	    }else if(bean.getMinfo() != null && bean.getMinfo().equals("C")){
	        bean.setMparent_code(bean.getMmenu2());
	        strtmp = String.valueOf(bean.getMmenu2());
	        
	    }else if(bean.getMinfo() != null && bean.getMinfo().equals("B")){
	        bean.setMparent_code(bean.getMmenu1());
	        strtmp = String.valueOf(bean.getMmenu1());
	    }
	    
	    bean.setMcode(strtmp);
	    	    
	    return sqlbean.insertMenu(bean);
	}



/*****************************************************
	메뉴 수정<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param HttpServletRequest
	@see /admin/menu/proc_catregoryUpdate.jsp
******************************************************/
	public int updateMenu(HttpServletRequest req) throws Exception {
	    
	    MenuInfoBean bean = new MenuInfoBean();
	    com.yundara.util.WebUtils.fill(bean, req);
	    if(bean.getMmenu1()!= null && bean.getMmenu2()!= null && bean.getMmenu3()!= null && bean.getMmenu4()!= null 
	    		&& !bean.getMmenu1().equals("") && !bean.getMmenu2().equals("") && !bean.getMmenu3().equals("") && bean.getMmenu4().equals("")){
	        bean.setMinfo("D");
	    }else if(bean.getMmenu1()!= null && bean.getMmenu2()!= null && bean.getMmenu3()!= null && 
	    		!bean.getMmenu1().equals("") && bean.getMmenu2().equals("") && bean.getMmenu3().equals("")) {
	        bean.setMinfo("B");
	    }else if(bean.getMmenu1()!= null && bean.getMmenu2()!= null && bean.getMmenu3()!= null && 
	    		!bean.getMmenu1().equals("") && !bean.getMmenu2().equals("") && bean.getMmenu3().equals("")){
	        bean.setMinfo("C");
	    }else 
	        bean.setMinfo("A");
	    
	    bean.setMtitle(bean.getMtitle());
	    
	    //parent_code 추출
	    // mcode값 추출 
	    if(bean.getMinfo() != null && bean.getMinfo().equals("D")){
	        bean.setMparent_code(bean.getMmenu3());
	        
	    }else if(bean.getMinfo() != null && bean.getMinfo().equals("C")){
	        bean.setMparent_code(bean.getMmenu2());
	        
	    }else if(bean.getMinfo() != null && bean.getMinfo().equals("B")){
	        bean.setMparent_code(bean.getMmenu1());
	    }else {
	        bean.setMparent_code("");
	    }
	    
	    return sqlbean.updateMenu(bean);
	}
	
	
/*****************************************************
	메뉴 삭제<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:vector, 실패:null<br>
	@param 메뉴 코드번호
******************************************************/
	public Vector deleteMenu(String cuid) {
		cuid = com.vodcaster.utils.TextUtil.getValue(cuid);
	    String query = "select mcode from menu where muid=" +cuid;
		return sqlbean.deleteMenu(cuid);
	}



/*****************************************************
	메뉴정보 리턴<p>
	<b>작성자</b> : 이희락<br>
	@return 메뉴 백터<br>
	@param 메뉴코드
	@see
******************************************************/
	public Vector getMenuInfo(String cuid) {
		cuid = com.vodcaster.utils.TextUtil.getValue(cuid);
		return sqlbean.selectMenuAll(cuid);
	}



/*****************************************************
	메뉴코드를 특정형식으로 분리<p>
	<b>작성자</b> : 이희락<br>
	@return분리된 대,중,소 메뉴 코드 3개를 벡터로 반환<br>
	@param 메뉴코드, 메뉴분류
	@see
******************************************************/
	public Vector separateCode(String mcode, String info) {
		mcode = com.vodcaster.utils.TextUtil.getValue(mcode);
		info = com.vodcaster.utils.TextUtil.getValue(info);
	    Vector v = new Vector();
	    String strtmp1 = "";
	    String strtmp2 = "";
	    String strtmp3 = "";
	    String strtmp4 = "";
	    
	    if (info != null  && mcode != null && mcode.length() >= 12) {
		    try {
		        
			    if(info != null && info.equals("A")) {
			        strtmp1 = mcode;
			        strtmp2 = "";
			        strtmp3 = "";
			        strtmp4 = "";
			    }else if(info != null && info.equals("B") && mcode != null && mcode.length() >= 3) {
			        strtmp1 = mcode.substring(0,3);
	                strtmp1 = TextUtil.zeroFill(0,12,strtmp1); //뒤로 9번째까지 설정		        
			        strtmp2 = mcode;
			        strtmp3 = "";  
			        strtmp4 = "";
			    }else if(info != null && info.equals("C")&& mcode != null && mcode.length() >= 6) {
			        strtmp1 = mcode.substring(0,3);
	                strtmp1 = TextUtil.zeroFill(0,12,strtmp1); //뒤로12번째까지 설정		        
			        strtmp2 = mcode.substring(0,6);
	                strtmp2 = TextUtil.zeroFill(0,12,strtmp2); //뒤로 12번째까지 설정			        
			        strtmp3 = mcode; 
			        strtmp4 = "";
			    }else if(info != null && info.equals("D")&& mcode != null && mcode.length() >= 9) {
			        strtmp1 = mcode.substring(0,3);
	                strtmp1 = TextUtil.zeroFill(0,12,strtmp1); //뒤로 12번째까지 설정		
	                strtmp2 = mcode.substring(0,6);
	                strtmp2 = TextUtil.zeroFill(0,12,strtmp2); //뒤로 12번째까지 설정			        
	                strtmp3 = mcode.substring(0,9);
	                strtmp3 = TextUtil.zeroFill(0,12,strtmp2); //뒤로 12번째까지 설정			        
	                strtmp4 = mcode;
			    }
		    
		    }catch(Exception e) {}
		    
		    v.add(strtmp1);
		    v.add(strtmp2);
		    v.add(strtmp3);
		    v.add(strtmp4);
	    }
	    
	    
	    return v;
	    
	}
	
	
	
/*****************************************************
	 메뉴코드 제목 리턴<p>
	<b>작성자</b> : 이희락<br>
	@return 메뉴타이틀을 문자열로 반환 (예: 영화 > 액션 > 무협)<br>
	@param code(메뉴코드)
	@see
******************************************************/
	public String getMenuName(String mcode) {
	    
	    String strtmp = "";
	    Vector rt1, rt2, rt3, rt4 = null;
	    String menu1, menu2, menu3 = "";
	    Vector rtnV = null;
	    
	    mcode = com.vodcaster.utils.TextUtil.getValue(mcode);
	    try {

	        if(mcode != null && !mcode.equals("") && mcode.length() == 12 ) {

                Vector v = sqlbean.selectMenuInfo(mcode);
                String minfo = String.valueOf(v.elementAt(0));
                
             // 대분류 메뉴명 추출
                if(minfo.equals("A") || minfo.equals("B") || minfo.equals("C") || minfo.equals("D")) {
                    menu1 = mcode.substring(0,3);
                    menu1 = TextUtil.zeroFill(0,12,menu1); //뒤로 12번째까지 설정
                    rt1 = sqlbean.selectMenuTitle(menu1);
                    strtmp = String.valueOf(rt1.elementAt(0));
                }

		        // 중분류 메뉴명 추출
                if(minfo.equals("B") || minfo.equals("C") || minfo.equals("D")) {
                    menu2 = mcode.substring(0,6);
                    menu2 = TextUtil.zeroFill(0,12,menu2); //뒤로12번째까지 설정
                    rt2 = sqlbean.selectMenuTitle(menu2);
                    strtmp = strtmp + " > " + String.valueOf(rt2.elementAt(0));
                }

		        // 소분류 메뉴명 추출
                if(minfo.equals("C") || minfo.equals("D")) {
                    menu3 = mcode.substring(0,9);
                    menu3 = TextUtil.zeroFill(0,12,menu3); //뒤로12번째까지 설정
                    rt3 = sqlbean.selectMenuTitle(menu3);
                    strtmp = strtmp + " > " + String.valueOf(rt3.elementAt(0));
                }


		        // 최하위  메뉴명 추출
                if(minfo.equals("D")) {
                    rt4 = sqlbean.selectMenuTitle(mcode);
                    strtmp = strtmp + " > " + String.valueOf(rt4.elementAt(0));
                }
	        }
	        
	    }catch(Exception e) {}
            
	    
	    return strtmp;
	        
	}



/*****************************************************
	 메뉴코드 제목 리턴<p>
	<b>작성자</b> : 이희락<br>
	@return 메뉴타이틀을 문자열로 반환 (예: 무협)<br>
	@param code(메뉴코드)
	@see
******************************************************/
	public String getMenuOneName(String mcode) {

	    String strtmp = "";
	    mcode = com.vodcaster.utils.TextUtil.getValue(mcode);
	    try {

	        if(mcode != null && !mcode.equals("") && mcode.length() == 12) {

                Vector v = sqlbean.selectMenuTitle(mcode);
                if(v != null && v.size()>0){
                	strtmp = String.valueOf(v.elementAt(0));
                }
            }

	    }catch(Exception e) {
	    	System.err.println("getMenuOneName ex : " + e);
	    }
        return strtmp;
    }
	
/*****************************************************
	 메뉴코드 제목 리턴<p>
	<b>작성자</b> : 이희락<br>
	@return 메뉴타이틀을 문자열로 반환 (예: 무협)<br>
	@param code(메뉴코드)
	@see
******************************************************/
	public String getMenuOneCode(String ccode) {

	    String strtmp = "";
	    ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	    try {

	        if(ccode != null && !ccode.equals("") && ccode.length() == 12) {

               Vector v = sqlbean.selectMenuCode(ccode);
               if(v != null && v.size()>0){
               	strtmp = String.valueOf(v.elementAt(0));
               }
           }

	    }catch(Exception e) {
	    	System.err.println("getMenuOneName ex : " + e);
	    }
       return strtmp;
   }
	
		
	
	
}
