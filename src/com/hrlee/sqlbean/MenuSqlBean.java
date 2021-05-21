/*
 * Created on 2005. 1. 10
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import dbcp.SQLBeanExt;

import java.util.*;

import javax.servlet.http.*;

import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.sqlbean.DirectoryNameManager;

/**
 * @author Choi Hee-Sung
 *
 * 메뉴관련 DB컨트롤 클래스
 */
public class MenuSqlBean  extends SQLBeanExt {
    
    public MenuSqlBean() {
		super();
	}

    
    private Calendar cal;
	private int YEAR, MONTH, DAY, DAYOFWEEK, HOUROFDAY;
	private String IP_ADDRESS, CUSTOMER_ID;


	/*****************************************************
	쇼핑몰 인덱스 화면 접속시에 접속자에 대한 접속 정보를 저장합니다.<p>

	<b>작성자</b>       : 김종진<br>
	<b>관련 JSP</b>     : ROOT/index.jsp						 
	******************************************************/
	public void setValueMenu(String ip, String customer_id, String flag,String menu_id)
	{
		this.cal=Calendar.getInstance();
		this.YEAR=cal.get(Calendar.YEAR);
		this.MONTH=cal.get(Calendar.MONTH)+1;
		this.DAY=cal.get(Calendar.DATE);
		this.DAYOFWEEK=cal.get(Calendar.DAY_OF_WEEK);
		this.HOUROFDAY=cal.get(Calendar.HOUR_OF_DAY);
		this.IP_ADDRESS=ip;
		this.CUSTOMER_ID=customer_id;
		//System.err.println("customer_id="+CUSTOMER_ID);
		setCount_menu(flag, menu_id);
	}
	
	
	public int menu_content(String ccode){
		
		// 현재 일시 정보를 갖는 Date 객체를 생성한다.
		  java.util.Date currentDate = new java.util.Date();  
		  
		//Date객체로부터 특정한 형식의 문자열로 일시를 만들어내기 위한 포매터를 생성한다.
		  java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
		  
		//포매터를 이용하여 Date객체로부터 문자열을 만들어낸다.
		  String dateString = format.format(currentDate);
		  
		
		String sub_query = "";
		if (ccode != null && ccode.length() > 11 )
		{
			String Code = ccode;
			if (ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if (ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if (ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}

			sub_query =" and a.ccode like '" +Code + "%'";
		}
		
		
//	String query = " select count(a.ocode) from vod_media a inner join category b on  a.ccode=b.ccode  " +
//				   " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
//				   "	   and a.openflag='Y' and b.openflag='Y' and b.ctype='V' and a.open_date ='"+dateString+"'  " + sub_query;
	
	String query = " select count(a.ocode) from vod_media a inner join category b on  a.ccode=b.ccode  " +
			   " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
				"  and a.openflag='Y' and b.openflag='Y' and b.ctype='V' "
			+   " and DATE(a.open_date) >= DATE(SUBDATE(NOW(), INTERVAL 3 DAY)) AND DATE(a.open_date) <= DATE(NOW())"
			+ sub_query;
	
	//System.out.println(query);			  
		    Vector v = querymanager.selectEntity(query);
		int rtn_cnt = 0;
		if (v != null && v.size() > 0) {
			rtn_cnt = Integer.parseInt(String.valueOf(v.elementAt(0)));
		}
		return rtn_cnt;
		
	}

	
public int menu_content_board(int board_id){
		
//		// 현재 일시 정보를 갖는 Date 객체를 생성한다.
//		  java.util.Date currentDate = new java.util.Date();  
//		//Date객체로부터 특정한 형식의 문자열로 일시를 만들어내기 위한 포매터를 생성한다.
//		  java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
//		//포매터를 이용하여 Date객체로부터 문자열을 만들어낸다.
//		  String dateString = format.format(currentDate);
		  
		  int rtn_cnt = 0;

		  if ( board_id < 0 )
		{
			
		} else {
		 
			String query = " SELECT COUNT(list_id) FROM board_list WHERE del_flag='N'  AND list_open='Y' AND board_id ="+board_id+

					   //" and DATE_FORMAT(list_date, '%Y-%m-%d')  = DATE('"+dateString+"')  ";
					   " and DATE(list_date) >= DATE(SUBDATE(NOW(), INTERVAL 3 DAY)) AND DATE(list_date) <= DATE(NOW())";
   
			    Vector v = querymanager.selectEntity(query);
			
			if (v != null && v.size() > 0) {
				rtn_cnt = Integer.parseInt(String.valueOf(v.elementAt(0)));
			}
			
		}
		
		return rtn_cnt;
	
		
	}

public int menu_content_board2(){
	
//	// 현재 일시 정보를 갖는 Date 객체를 생성한다.
//	  java.util.Date currentDate = new java.util.Date();  
//	//Date객체로부터 특정한 형식의 문자열로 일시를 만들어내기 위한 포매터를 생성한다.
//	  java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
//	//포매터를 이용하여 Date객체로부터 문자열을 만들어낸다.
//	  String dateString = format.format(currentDate);
	  
	  int rtn_cnt = 0; 
		String query = " SELECT COUNT(list_id) FROM board_list WHERE del_flag='N'  AND list_open='Y' "+ 
					" and board_id in (16,12,10,17,18,19,11,13,21,22,23) "+

				  // " and DATE_FORMAT(list_date, '%Y-%m-%d')  = DATE('"+dateString+"')  ";
				  " and DATE(list_date) >= DATE(SUBDATE(NOW(), INTERVAL 3 DAY)) AND DATE(list_date) <= DATE(NOW())"; 

	//System.out.println(query);			  
		    Vector v = querymanager.selectEntity(query);
		
		if (v != null && v.size() > 0) {
			rtn_cnt = Integer.parseInt(String.valueOf(v.elementAt(0)));
		}
	 
	return rtn_cnt;

	
}


/*****************************************************
	메뉴 삭제<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:삭제된 벡터, 실패:null<br>
	@param 메뉴코드
******************************************************/
	public Vector deleteMenu(String uid) {
	    
	    String mcode = "";
	    String minfo = "";
	    
	    String cond = "";
	    String query = "select minfo, mcode from menu where muid=" +uid;
	    Vector v = querymanager.selectEntity(query);

	    try {
	        
	        if(v != null && v.size() > 0) {
		        minfo = String.valueOf(v.elementAt(0));
		        mcode = String.valueOf(v.elementAt(1));
		       
		        
		    //    System.err.println("menu INFO minfo : " +minfo);
		    //    System.err.println("menu CODE mcode : " +mcode);
		        
		        
		        // 대분류시 서브메뉴가 있는지 검사.
		        if(minfo.equals("A")) {
		            
		            cond = " and mcode like '" +mcode.substring(0,3)+ "%'";
		            
		        }else if(minfo.equals("B")) {
		            
		            cond = " and mcode like '" +mcode.substring(0,6)+ "%'";
		        }else if(minfo.equals("C")) {
		            
		            cond = " and mcode like '" +mcode.substring(0,9)+"%'";
	        	}else if(minfo.equals("D")) {
		            
		            cond = " and mcode like '" +mcode+ "%'";
	        	}
		        
		        String query2 = "select * from menu where mcode!='" +mcode+ "' " + cond;
		        
		        Vector v2 = querymanager.selectEntities(query2);
		        
		        if(v2 != null && v2.size() > 0) {
		            //System.err.println("서브가 존재하는 경우 삭제 하려함 ");
		            
		            return null;
		        } else
		            query = "delete from menu where muid=" + uid;
		        
		    } else
		        return null;
		    
	    } catch(Exception e) {
	        
	        System.err.println("deleteMenu ex : " + e);
	    }
	    
		return querymanager.executeQuery(query, "");
	}



/*****************************************************
	메뉴 검색<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 메뉴정보를 백터로 반환<br>
	@param  code(메뉴코드)
******************************************************/
	public Vector chkDuplicate( String code){
	    String query = "select muid from menu where mcode='" +code+ "'";
	    return querymanager.selectEntity(query);
	}
	
	
	
/*****************************************************
	특정 검색에 의해 메뉴 전체 리스트 리턴.<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 메뉴 리스트<br>
	@param 검색 Query문
******************************************************/
	public Vector selectMenuListAll(String query){
		
		Vector rtn = null;
		
		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {}

		return rtn;
	}



/*****************************************************
	특정 메뉴 정보 리턴.<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 메뉴 정보<br>
	@param 검색 코드여ㅣQuery문
******************************************************/
	public Vector selectMenu(int uid){
		String query = "select * from menu where muid=" +uid;
		return 	querymanager.selectHashEntity(query);
	}		
	
	
	
/*****************************************************
	메뉴정보를 입력.<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param menuInfoBean 빈즈
******************************************************/
	public int insertMenu(MenuInfoBean bean) throws Exception {
	    
		
		
		
	    String part_info = bean.getMinfo();
	    String strtmp = "";
	    int intInfo = 0;
	    String query = "";
	    
	    if(part_info.equals("A")){
	        
	        try {
	            Vector vr = null;
                
	            query = "select substring(mcode,1,3) from menu where  minfo='A' order by mcode desc";
                Vector v = querymanager.selectEntity(query);
                if(v != null  && v.size() > 0) {
                    intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
                }
	            
	            do {
	                strtmp = "";	                
	                intInfo++;
	                strtmp += intInfo;
	                strtmp = TextUtil.zeroFill(1,3,strtmp);	//앞에서 3번째까지 설정
	                strtmp = TextUtil.zeroFill(0,12,strtmp); //뒤로 9번째까지 설정
	                
	                vr = this.chkDuplicate(strtmp);

	            }while (vr != null && vr.size() > 0);
	            
	        }catch(Exception e) {System.out.println(e);}
	    } else if(part_info.equals("B")) {
	        
	        try {
	            Vector vr = null;
	            String strFirst = (String.valueOf(bean.getMcode())).substring(0,3);
                
	            query = "select substring(mcode,4,3) from menu where " +
	            		"  minfo='B' and mcode like '" +strFirst+ "%' order by mcode desc";
                Vector v = querymanager.selectEntity(query);
                if(v != null && v.size() > 0) {
                    intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
                }
	            
	            do {
	                strtmp = "";
	                intInfo++;
	                strtmp += intInfo;
	                strtmp = TextUtil.zeroFill(1,3,strtmp);
	                strtmp = strFirst + strtmp;
	                strtmp = TextUtil.zeroFill(0,12,strtmp);
	                
	                vr = this.chkDuplicate(strtmp);
	                
	            }while (vr != null && vr.size() > 0);
	            
	        }catch(Exception e) {System.out.println(e);}
	        
	    } else if(part_info.equals("C")) {
	        
	        try {
	            Vector vr = null;
	            String strFirst = (String.valueOf(bean.getMcode())).substring(0,6);
                
	            query = "select substring(mcode,7,3) from menu where "+
	            		" minfo='C' and mcode like '" +strFirst+ "%' order by mcode desc";
                Vector v = querymanager.selectEntity(query);
                if(v != null && v.size() > 0) {
                    intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
                }
	            
	            do {
	                strtmp = "";
	                intInfo++;
	                strtmp += intInfo;
	                strtmp = TextUtil.zeroFill(1,3,strtmp);
	                strtmp = strFirst + strtmp;
	                strtmp = TextUtil.zeroFill(0,12,strtmp);
	                
	                vr = this.chkDuplicate( strtmp);

	            }while (vr != null && vr.size() > 0);
	            
	        }catch(Exception e) {System.out.println(e);}	        
	    }else if(part_info.equals("D")) {
	        
	        try {
	            Vector vr = null;
	            String strFirst = (String.valueOf(bean.getMcode())).substring(0,9);
                
	            query = "select substring(mcode,10,3) from menu where "+
	            		"  minfo='D' and mcode like '" +strFirst+ "%' order by mcode desc";
                Vector v = querymanager.selectEntity(query);
                if(v != null && v.size() > 0) {
                    intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
                }
	            
	            do {
	                strtmp = "";
	                intInfo++;
	                strtmp += intInfo;
	                strtmp = TextUtil.zeroFill(1,3,strtmp);
	                strtmp = strFirst + strtmp;
	                
	                vr = this.chkDuplicate( strtmp);

	            }while (vr != null && vr.size() > 0);
	            
	        }catch(Exception e) {System.out.println(e);}	        
	    }
	    
	    query = "insert into menu (mcode,mparent_code,mtitle,murl,mlevel,minfo,morder) values (" +
	    		"'" +
	    		strtmp						+ "','" +
	    		bean.getMparent_code()		+ "','" +
	    		bean.getMtitle().replace("'","''")		+ "','"	+
	    		bean.getMurl().replace("'","''")		+ "',"	+
	    		bean.getMlevel()			+ ",'"	+
	    		bean.getMinfo()				+ "',"+
	    		bean.getMorder()+
	    		")";
	    
 
		return querymanager.updateEntities(query);

	}


/*****************************************************
	메뉴정보 수정<p>
	<b>작성자</b> : 이희락<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param menuInfoBean 빈즈
	@see
******************************************************/
	public int updateMenu(MenuInfoBean bean) throws Exception{
	    
	    String query = "";
	    String sub_query = "";
	    int intInfo = 0;
	    String strtmp = "";
	    
	    if(String.valueOf(bean.getMinfo()).equals("A")) {
	        
	        query = "update menu set mtitle='" +bean.getMtitle()+ "'," +
	        		" murl='" +bean.getMurl()+"', "+
	        		" mlevel=" +bean.getMlevel()+ ",morder="+bean.getMorder()+" where muid=" + bean.getMuid();
	        
			//System.err.println("query == " + query);	        
	        
	    }else if(String.valueOf(bean.getMinfo()).equals("B")) {
	        
	        strtmp = "";
	        
	        try {
	            
	            if(!( bean.getMcode().equals( bean.getOrg_menu2() ) ) && !( bean.getMmenu1().equals( bean.getOrg_menu1() ) )) {
	                
	                Vector vr = new Vector();
	                
	                String strFirst = String.valueOf(bean.getMparent_code()).substring(0,3);
	                
	                sub_query = "select substring(mcode,4,3) from menu where" + 
	                			"  minfo='B' and mcode like '" +strFirst+ "%' order by mcode desc";
	                
	                Vector v = querymanager.selectEntity(query);
	                
	                if(v != null && v.size() > 0) {
	                    intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
	                }
	                
	                do {
	                    strtmp = "";
	                    intInfo++;
	                    strtmp += intInfo;
	                    strtmp = TextUtil.zeroFill(1,3,strtmp);
	                    strtmp = strFirst + strtmp;
	                    strtmp = TextUtil.zeroFill(0,12,strtmp);
	                    
	                    vr = this.chkDuplicate( strtmp);
	                
	                }while (vr !=  null && vr.size() > 0);
	             
	                
	     	       query = "update menu set mcode='" +strtmp+ "', " +
	     	       		"mparent_code='" +bean.getMparent_code()+
	       					"', mtitle='" +bean.getMtitle().replace("'","''")+ "', mlevel=" +bean.getMlevel()+
	       					" ,murl='" +bean.getMurl()+"' "+
	       					" ,morder=" +bean.getMorder() + " " +
	       					" where muid=" + bean.getMuid();
	     	       
	            } else {
	                
	                query = "update menu set mtitle='" +bean.getMtitle().replace("'","''")+ "', " +
	                		" mlevel=" +bean.getMlevel()+ 
	                		", murl='" +bean.getMurl()+"' "+
	                		" ,morder=" +bean.getMorder() + " " +
	                		" where muid=" + bean.getMuid();
	                
	            }
	       
	       }catch(Exception e) {}
	       
//			System.err.println("query2 == " + query);
			
	    }else if(String.valueOf(bean.getMinfo()).equals("C")) {
	        
	        strtmp = "";
	        
	        try {
	            
	            if(!( bean.getMcode().equals( bean.getOrg_menu3() ) ) && !( bean.getMmenu1().equals( bean.getOrg_menu1() ) ) && !( bean.getMmenu1().equals( bean.getOrg_menu1() ) )) {
	                
		            
		            Vector vr = new Vector();

		            String strFirst = String.valueOf(bean.getMparent_code()).substring(0,6);
		            
		            sub_query = "select substring(mcode,7,3) from menu where  minfo='C' and mcode like '" +strFirst+ "%' order by mcode desc";
		            
		            
		          //  System.err.println("sub_query ===> " + sub_query);
		                
		           Vector v = querymanager.selectEntity(query);
		           
		           if(v != null && v.size() > 0) {
		               intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
		           }
		           
		           do {
		               strtmp = "";
		               intInfo++;
		               strtmp += intInfo;
		               strtmp = TextUtil.zeroFill(1,3,strtmp);
		               strtmp = strFirst + strtmp;
		               strtmp = TextUtil.zeroFill(0,12,strtmp);
		               
		               vr = this.chkDuplicate( strtmp);
		           
		           }while (vr != null && vr.size() > 0);
	                
			       query = "update menu set mcode='" +strtmp+ "', mparent_code='" +bean.getMparent_code()+
	       			"', mtitle='" +bean.getMtitle().replace("'","''")+ 
	       			"', mlevel=" +bean.getMlevel()+ 
	       			" ,murl='" +bean.getMurl()+"' "+
	       			" ,morder=" +bean.getMorder() + " " +
	       			" where muid=" + bean.getMuid();
	                
	            } else {
	                
	                query = "update menu set mtitle='" +bean.getMtitle().replace("'","''")+ "'," +
	                		" mlevel=" +bean.getMlevel()+
	                		" ,murl ='" +bean.getMurl() + "'" +
	                		" ,morder=" +bean.getMorder() + " " +
	                		" where muid=" + bean.getMuid();
	            }
	            
	            
	       }catch(Exception e) {}
	       

	    }else if(String.valueOf(bean.getMinfo()).equals("D")) {
	        
	        strtmp = "";
	        
	        try {
	            
	            if(!( bean.getMcode().equals( bean.getOrg_menu4() ) ) && !( bean.getMmenu1().equals( bean.getOrg_menu1() ) ) && !( bean.getMmenu1().equals( bean.getOrg_menu1() ) )) {
	                
		            
		            Vector vr = new Vector();

		            String strFirst = String.valueOf(bean.getMparent_code()).substring(0,9);
		            
		            sub_query = "select substring(mcode,10,3) from menu where  minfo='D' and mcode like '" +strFirst+ "%' order by mcode desc";
		            
		            
		          //  System.err.println("sub_query ===> " + sub_query);
		                
		           Vector v = querymanager.selectEntity(query);
		           
		           if(v != null && v.size() > 0) {
		               intInfo = Integer.parseInt(String.valueOf(v.elementAt(0)));
		           }
		           
		           do {
		               strtmp = "";
		               intInfo++;
		               strtmp += intInfo;
		               strtmp = TextUtil.zeroFill(1,3,strtmp);
		               strtmp = strFirst + strtmp;
		               
		               vr = this.chkDuplicate( strtmp);
		           
		           }while (vr != null && vr.size() > 0);
	                
			       query = "update menu set mcode='" +strtmp+ "', mparent_code='" +bean.getMparent_code()+
	       			"', mtitle='" +bean.getMtitle().replace("'","''")+ 
	       			"', mlevel=" +bean.getMlevel()+ 
	       			" ,murl='" +bean.getMurl()+"' "+
	       			" ,morder=" +bean.getMorder() + " " +
	       			" where muid=" + bean.getMuid();
	                
	            } else {
	                
	                query = "update menu set mtitle='" +bean.getMtitle().replace("'","''")+ "'," +
	                		" mlevel=" +bean.getMlevel()+
	                		" ,murl ='" +bean.getMurl() + "'" +
	                		" ,morder=" +bean.getMorder() + " " +
	                		" where muid=" + bean.getMuid();
	            }
	            
	            
	       }catch(Exception e) {}
	       

	    }
		//System.out.println(query);

		return querymanager.updateEntities(query);
	}



/*****************************************************
	메뉴정보 리턴<p>
	<b>작성자</b> : 이희락<br>
	@return 메뉴 정보<br>
	@param 메뉴 코드
	@see
******************************************************/
	public Vector selectMenuAll(String muid){
		String query = "select * from menu where muid=" +muid;
		return 	querymanager.selectHashEntity(query);
	}
	
	

/*****************************************************
	메뉴제목 리턴<p>
	<b>작성자</b> : 이희락<br>
	@return 메뉴 제목<br>
	@param mcode(메뉴코드), 
	@see
******************************************************/
public Vector selectMenuTitle(String mcode) {
        String query = "select mtitle from menu where  mcode='" +mcode+ "'";
        return querymanager.selectEntity(query);
	}

/*****************************************************
메뉴URL 리턴<p>
<b>작성자</b> : 박종성<br>
@return 메뉴 URL<br>
@param ccode(카테고리코드), 
@see
******************************************************/
public Vector selectMenuCode(String ccode) {
    String query = "select mcode from menu where murl like '%ccode="+ccode+"%' and mparent_code <> '' and mparent_code <> 'null'";
    return querymanager.selectEntity(query);
}




/*****************************************************
	메뉴 분류정보 리턴<p>
	<b>작성자</b> : 이희락<br>
	@return 메뉴 분류정보<br>
	@param mcode(메뉴코드),
	@see
******************************************************/
	public Vector selectMenuInfo(String mcode) {
        String query = "select minfo from menu where  mcode='" +mcode+ "'";
        return querymanager.selectEntity(query);
	}

	 public Vector selectQuery(String query) {
	        return querymanager.selectEntity(query);
	    }
	 
	public Vector selectQueryList(String query) {
        return querymanager.selectHashEntities(query);
    }
	
	

	public void setCount_menu(String flag, String menu_id)
	{
        String sql = "";
        try {
            //insert
//            if(!isExistance_DAY(flag, menu_id)) {
// 
//                sql = "insert into contact_stat_menu (muid,day,dayofweek,cnt, flag) values('"+menu_id+"','"+getDateStr()+"',"+DAYOFWEEK+",1, '"+flag+"')";
//                querymanager.executeQuery(sql);
// 
//            } //update
//            else {
//                sql = "update contact_stat_menu set cnt=cnt+1 where day='"+getDateStr()+"' and flag='"+flag+"' and muid='"+menu_id+"'";
//                querymanager.executeQuery(sql);
// 
//            }
        	  sql = "INSERT INTO contact_stat_menu (muid, DAY,DAYOFWEEK,cnt, flag) VALUES('"+menu_id+"', '"+getDateStr()+"',"+DAYOFWEEK+",1,'"+flag+"') ON DUPLICATE KEY UPDATE cnt = cnt +1;";
        	  
            querymanager.executeQuery(sql);
        	

        }catch(Exception e) {
            System.err.println(e.getMessage());
        }
	}
	
	public boolean isExistance_DAY(String flag, String menu_id)
	{
		boolean day_exist = true;

		Vector v = getTodayContactCount(flag, menu_id);
		//System.err.println("vector size : "+v.size());
		if(v == null || v.size()<=0) {
            day_exist = false;
        }

		return day_exist;
	}
	
	public Vector getTodayContactCount(String flag, String menu_id)
	{
		String query = "select cnt from contact_stat_menu where day='"+getDateStr()+"' and flag='"+flag+"' and muid='"+menu_id+"' ";
		
		//System.err.println(query);
		return querymanager.selectEntity(query);
	}
	public String toStr(int num)
	{
		return Integer.toString(num);
	}

	public String getDateStr()
	{
		String date_str=toStr(YEAR);
		if(MONTH>9)
			date_str +=toStr(MONTH);
		else
			date_str +="0"+toStr(MONTH);
		if(DAY>9)
			date_str +=toStr(DAY);
		else
			date_str +="0"+toStr(DAY);
		return date_str;
	}
	
 

	
}
